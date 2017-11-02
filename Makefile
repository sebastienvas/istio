## Copyright 2017 Istio Authors
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.

SHELL := /bin/bash

detected_OS := $(shell sh -c 'uname -s 2>/dev/null || echo not')

BAZEL_STARTUP_ARGS ?=
BAZEL_BUILD_ARGS ?=
BAZEL_TEST_ARGS ?=
ifeq ($(detected_OS),Darwin)  # Mac OS X
    BUILD_FLAGS = --cpu=darwin
endif

setup:
	@[[ -f pilot/platform/kube/config ]] || ln -s ~/.kube/config pilot/platform/kube/

build: setup
	@bazel $(BAZEL_STARTUP_ARGS) build $(BAZEL_BUILD_ARGS) //...

clean:
	@bazel clean

test: setup
	@bazel $(BAZEL_STARTUP_ARGS) test $(BAZEL_TEST_ARGS) //...

artifacts:
	echo 'To be added'


.PHONY: setup build clean test artifacts
