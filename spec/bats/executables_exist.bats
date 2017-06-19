@test "which executable exists" {
  run which which
  [ "$status" -eq 0 ]
}

@test "bash executable exists" {
  run which bash
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" =~ "bin/bash" ]]
}

@test "git executable exists" {
  [ -x "$(which git)" ]
}

@test "wget executable exists" {
  [ -x "$(which wget)" ]
}

@test "envsubst executable exists" {
  [ -x "$(which envsubst)" ]
}

@test "make executable exists" {
  [ -x "$(which make)" ]
}

@test "libtool executable exists" {
  [ -x "$(which libtool)" ]
}

@test "pkg-config executable exists" {
  [ -x "$(which pkg-config)" ]
}

@test "autoconf executable exists" {
  [ -x "$(which autoconf)" ]
}

@test "automake executable exists" {
  [ -x "$(which automake)" ]
}

@test "file executable exists" {
  [ -x "$(which file)" ]
}

@test "kubectl executable exists" {
  [ -x "$(which kubectl)" ]
}

@test "docker executable exists" {
  [ -x "$(which docker)" ]
}
