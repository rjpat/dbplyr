# select_query() print method output is as expected

    Code
      mf
    Output
      <SQL SELECT>
      From:
        <IDENT> df
      Select:   *

# queries generated by select() don't alias unnecessarily

    Code
      lf_render
    Output
      <SQL> SELECT `x`
      FROM `df`

