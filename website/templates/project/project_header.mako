% if node['is_registration']:
    <div class="alert alert-info">This ${node['category']} is a registration of <a class="alert-link" href="${node['registered_from_url']}">this ${node["category"]}</a>; the content of the ${node["category"]} has been frozen and cannot be edited.
    </div>
    <style type="text/css">
    .watermarked {
        background-image:url('/static/img/read-only.png');
        background-repeat:repeat;
    }
    </style>
% endif

<div id="projectScope">
    <header class="subhead" id="overview">
        <div class="row">

            <div class="col-md-7 cite-container">
                %if parent_node['id']:
                    % if parent_node['is_public'] or parent_node['is_contributor']:
                        <h1 class="node-parent-title">
                            <a href="${parent_node['url']}">${parent_node['title']}</a> /
                        </h1>
                    % else:
                         <h1 class="node-parent-title unavailable">
                             <span>Private Project</span> /
                         </h1>
                    %endif
                %endif
                <h1 class="node-title">
                    <span id="nodeTitleEditable">${node['title']}</span>
                </h1>
            </div><!-- end col-md-->

            <div class="col-md-5">
                <div class="btn-toolbar node-control pull-right">
                    <div class="btn-group">
                    %if not node["is_public"]:
                        <button class='btn btn-default disabled'>Private</button>
                        % if 'admin' in user['permissions']:
                            <a class="btn btn-default" data-bind="click: makePublic">Make Public</a>
                        % endif
                    %else:
                        % if 'admin' in user['permissions']:
                            <a class="btn btn-default" data-bind="click: makePrivate">Make Private</a>
                        % endif
                        <button class="btn btn-default disabled">Public</button>
                    %endif
                    </div><!-- end btn-group -->

                    <div class="btn-group">
                        % if user_name and not node['is_registration']:
                            <a rel="tooltip" title="Watch" class="btn btn-default" href="#" data-bind="click: toggleWatch">
                        % else:
                            <a rel="tooltip" title="Watch" class="btn btn-default disabled" href="#">
                        % endif
                        <i class="icon-eye-open"></i>
                        <span id="watchCount" data-bind="text: watchButtonDisplay"></span>

                        </a>
                        <button
                            class='btn btn-default node-fork-btn'
                            data-bind="enable: !isRegistration && category === 'project' && user.id,
                                        click: forkNode"
                            rel="tooltip"
                            title="Number of times this ${node['category']} has been forked (copied)"
                        >
                            <i class="icon-code-fork"></i>&nbsp;${node['fork_count']}
                        </button>
##                        <a
##                                rel="tooltip"
##                                % if node['points']:
##                                    href="#showLinks"
##                                    data-toggle="modal"
##                                % endif
##                                class="btn btn-default ${'disabled' if node['points'] == 0 else ''}"
##                                title="Number times this ${node['category']} has been linked"
##                            >
##                            <i id="linkCount" class="icon-hand-right">&nbsp;${node['points']}</i>
##                        </a>

                    </div><!-- end btn-grp -->
                </div><!-- end btn-toolbar -->

            </div><!-- end col-md-->

        </div><!-- end row -->


        <p id="contributors">Contributors:
            <span id="contributorsview"><div mod-meta='{
                    "tpl": "util/render_contributors.mako",
                    "uri": "${node["api_url"]}get_contributors/",
                    "replace": true
                }'></div></span>
            % if node['is_fork']:
                <br />Forked from <a class="node-forked-from" href="/${node['forked_from_id']}/">${node['forked_from_display_absolute_url']}</a> on
                <span data-bind="text: dateForked.local, tooltip: {title: dateForked.utc}"></span>
            % endif
            % if node['is_registration'] and node['registered_meta']:
                <br />Registration Supplement:
                % for meta in node['registered_meta']:
                    <a href="${node['url']}register/${meta['name_no_ext']}">${meta['name_clean']}</a>
                % endfor
            % endif
            <br />Date Created:
                <span data-bind="text: dateCreated.local, tooltip: {title: dateCreated.utc}"
                     class="date node-date-created"></span>
            | Last Updated:
            <span data-bind="text: dateModified.local, tooltip: {title: dateModified.utc}"
                   class="date node-last-modified-date"></span>
            % if parent_node['id']:
                <br />Category: <span class="node-category">${node['category']}</span>
            % elif node['description'] or user['can_edit']:
                 <br />Description: <span id="nodeDescriptionEditable" class="node-description">${node['description']}</span>
            % endif
        </p>

        <nav id="projectSubnav" class="navbar navbar-default ">
            <ul class="nav navbar-nav">
                <li><a href="${node['url']}">Dashboard</a></li>

                <li><a href="${node['url']}files/">Files</a></li>
                <!-- Add-on tabs -->
                % for addon in addons_enabled:
                    % if addons[addon]['has_page']:
                        <li>
                            <a href="${node['url']}${addons[addon]['short_name']}">
                                % if addons[addon]['icon']:
                                    <img src="${addons[addon]['icon']}" class="addon-logo"/>
                                % endif
                                ${addons[addon]['full_name']}
                            </a>
                        </li>
                    % endif
                % endfor

                <li><a href="${node['url']}statistics/">Statistics</a></li>
                % if not node['is_registration']:
                    <li><a href="${node['url']}registrations/">Registrations</a></li>
                % endif
                <li><a href="${node['url']}forks/">Forks</a></li>
                % if user['is_contributor'] and not node['is_registration']:
                <li><a href="${node['url']}contributors/">Contributors</a></li>
                %endif
                % if user['is_contributor'] and not node['is_registration']:
                <li><a href="${node['url']}settings/">Settings</a></li>
                %endif
            </ul>
        </nav>
    </header>
</div><!-- end projectScope -->

