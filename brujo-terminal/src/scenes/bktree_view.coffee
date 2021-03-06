

nav_bar = rc require('./shared_comps/nav_bar.coffee').default
dctn_browser = rc require('./shared_comps/dctn_browser.coffee').default
text_entry_feedback = rc require('./shared_comps/text_entry_feedback.coffee').default

jobs_browser = rc require('./shared_comps/jobs_browser.coffee').default

comp = rr
    render: ->
        div null,
            nav_bar()
            div
                style:
                    display: 'flex'
                div
                    style:
                        display: 'flex'
                        flexDirection: 'column'
                    dctn_browser()
                    button
                        style:
                            margin: .01 * ww
                            width: .04 * ww
                        onClick: =>
                            @props.bktree_build_tree
                                dctn_selected: @props.dctn_selected
                        "build BK tree"
                    jobs_browser()

                text_entry_feedback()


map_state_to_props = (state) ->
    state.get('lookup').toJS()


map_dispatch_to_props = (dispatch) ->

    bktree_build_tree : ({ dctn_selected }) ->
        dispatch
            type: 'bktree_build_tree'
            payload: { dctn_name: dctn_selected }


    search_bktree_tree : ({ prefix }) ->
        dispatch
            type: 'primus_hotwire'
            payload:
                type: 'search_bktree'
                payload:
                    client_ref: 'placeholder'  # another client ref.
                    tree_id: 'placeholder'   # will identify exactly which tree to search
                    prefix: prefix


exports.default = connect(map_state_to_props, map_dispatch_to_props)(comp)
