@test "K8S_VERSION environment variable is set" {
  [ -n "$K8S_VERSION" ]
  run echo -n "$K8S_VERSION"
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" != "" ]]
}

@test "kubectl executable version matches expected" {
  run kubectl version --client
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" =~ "${K8S_VERSION}" ]]
}

