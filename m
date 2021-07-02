Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C4F3BA313
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 18:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhGBQLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 12:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhGBQLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 12:11:53 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E83C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 09:09:20 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id u7so10058281ion.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 09:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=+WyLr9zVijzZk1HQCauILm100Gnq0rco9cotVBzogB8=;
        b=JIGhvsvadV4f+LIiF/+XMSZpfN5uRFiEMxtczyQ5zoTZEb6qj0JutMczactiFlQy3h
         MxL2dzEC5d0+c7nnmQC6K36k/MmieLZWzpvktweWFUYyrm+2Xl8MJO+2SqeoofUqzdqH
         6oqKm0zEpu0Mivk/l3kLd/G9sBZ4bq5HlsPPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=+WyLr9zVijzZk1HQCauILm100Gnq0rco9cotVBzogB8=;
        b=lytVT5q2xADHyhWp3cNPCJSvBxeGIx9rK79KAB7Hse509eKnVs+5UMin6rmWE4C9qL
         hS2Mu65ox7fa8TCrMAYnZrINPzZg3Vy+HuaObvIrXK0LsbvPU67jCnQ07QDyzY5Gl/Fd
         dDAZTp3Kagi8+G8qoSSLS9jBju9JgW3zk0Q/x75qfG2ZXA74Jryx7R06NJC1YPR74P6N
         bbQQkIdwuogVvCK12GMXww8WbfZjhIjBhHpcjFSTe26i9PwSSI8spJ2RSG4yrEGKGWvX
         xBekiQ1dk6iP7Oo78zBQAIgw5pKz0Y0xA1rmES2tsTm3FRoiyQbt0OboFJg7c+kUWF8c
         tKcA==
X-Gm-Message-State: AOAM5303/wWAJ+90f3ufSlyvveYpVRwG61XLBsQe87CyIvP6MvjGbwE5
        RuJusePzVbcrvJQRY68FfTnFsg==
X-Google-Smtp-Source: ABdhPJxqnIqSccfXuwkTLyOz9T34bEFkytpwZA3vJEzmM9nbxFl5Hy2c6/6D6HolQMAEqCflegSx4A==
X-Received: by 2002:a5e:dc48:: with SMTP id s8mr556584iop.71.1625242159878;
        Fri, 02 Jul 2021 09:09:19 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 15sm2048052ilt.66.2021.07.02.09.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 09:09:19 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit update for Linux 5.14-rc1
Message-ID: <1ce88df5-31ca-7aba-d96d-92757b035d9a@linuxfoundation.org>
Date:   Fri, 2 Jul 2021 10:09:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------98BF7D50A0864B825756CAC7"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------98BF7D50A0864B825756CAC7
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,



Please pull the following KUnit update for Linux 5.14-rc1.

This KUnit update for Linux 5.14-rc1 consists of fixes and features:



-- add support for skipped tests

-- introduce kunit_kmalloc_array/kunit_kcalloc() helpers

-- add gnu_printf specifiers

-- add kunit_shutdown

-- add unit test for filtering suites by names

-- convert lib/test_list_sort.c to use KUnit

-- code organization moving default config to tools/testing/kunit

-- refactor of internal parser input handling

-- cleanups and updates to documentation

-- code cleanup related to casts


diff is attached.

Please note that the cast cleanups are in drivers area and you
will see updates to drivers/ files and kernel/sysctl-test.c
file.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:



   Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)



are available in the Git repository at:



   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-kunit-fixes-5.14-rc1



for you to fetch changes up to 1d71307a6f94df3750f8f884545a769e227172fe:



   kunit: add unit test for filtering suites by names (2021-06-25 
11:44:37 -0600)



----------------------------------------------------------------

linux-kselftest-kunit-fixes-5.14-rc1



This KUnit update for Linux 5.14-rc1 consists of fixes and features:



-- add support for skipped tests

-- introduce kunit_kmalloc_array/kunit_kcalloc() helpers

-- add gnu_printf specifiers

-- add kunit_shutdown

-- add unit test for filtering suites by names

-- convert lib/test_list_sort.c to use KUnit

-- code organization moving default config to tools/testing/kunit

-- refactor of internal parser input handling

-- cleanups and updates to documentation

-- code cleanup related to casts



----------------------------------------------------------------

Brendan Higgins (2):

       Documentation: kunit: document support for QEMU in kunit_tool

       kunit: tool: add support for QEMU



Daniel Latypov (5):

       Documentation: kunit: add tips for running KUnit

       kunit: introduce kunit_kmalloc_array/kunit_kcalloc() helpers

       lib/test: convert lib/test_list_sort.c to use KUnit

       kunit: tool: internal refactor of parser input handling

       kunit: add unit test for filtering suites by names



David Gow (20):

       Documentation: kunit: Update kunit_tool page

       kunit: Fix result propagation for parameterised tests

       kunit: Add 'kunit_shutdown' option

       kunit: Do not typecheck binary assertions

       kunit: Assign strings to 'const char*' in STREQ assertions

       Documentation: kunit: Clean up some string casts in examples

       device property: Remove some casts in property-entry-test

       iio: Remove a cast in iio-test-format which is no longer required

       mmc: sdhci-of-aspeed: Remove some unnecessary casts from KUnit tests

       thunderbolt: test: Remove some casts which are no longer required

       kernel/sysctl-test: Remove some casts which are no-longer required

       lib/cmdline_kunit: Remove a cast which are no-longer required

       kunit: Add gnu_printf specifiers

       kunit: arch/um/configs: Enable KUNIT_ALL_TESTS by default

       kunit: Move default config from arch/um -> tools/testing/kunit

       kunit: Remove the unused all_tests.config

       thunderbolt: test: Reinstate a few casts of bitfields

       kunit: Support skipped tests

       kunit: tool: Support skipped tests in kunit_tool

       kunit: test: Add example tests which are always skipped



Marco Elver (1):

       kasan: test: make use of kunit_skip()



Mauro Carvalho Chehab (1):

       docs: dev-tools: kunit: don't use a table for docs name


  Documentation/dev-tools/kunit/api/index.rst        |   8 +-

  Documentation/dev-tools/kunit/index.rst            |   1 +

  Documentation/dev-tools/kunit/kunit-tool.rst       | 188 ++++++++++++++-

  Documentation/dev-tools/kunit/running_tips.rst     | 259 
+++++++++++++++++++++

  Documentation/dev-tools/kunit/start.rst            |   4 +-

  Documentation/dev-tools/kunit/usage.rst            |  57 +++--

  drivers/base/test/property-entry-test.c            |  56 ++---

  drivers/iio/test/iio-test-format.c                 |   2 +-

  drivers/mmc/host/sdhci-of-aspeed-test.c            |  34 +--

  drivers/thunderbolt/test.c                         |  86 +++----

  include/kunit/test.h                               | 116 +++++++--

  kernel/sysctl-test.c                               |  24 +-

  lib/Kconfig.debug                                  |   5 +-

  lib/cmdline_kunit.c                                |   2 +-

  lib/kunit/debugfs.c                                |   2 +-

  lib/kunit/executor.c                               |  53 +++--

  lib/kunit/executor_test.c                          | 133 +++++++++++

  lib/kunit/kunit-example-test.c                     |  31 +++

  lib/kunit/kunit-test.c                             |  42 +++-

  lib/kunit/string-stream.h                          |   6 +-

  lib/kunit/test.c                                   |  77 +++---

  lib/test_kasan.c                                   |  12 +-

  lib/test_list_sort.c                               | 129 ++++------

  tools/testing/kunit/configs/all_tests.config       |   3 -

  .../testing/kunit/configs/default.config           |   2 +-

  tools/testing/kunit/kunit.py                       |  57 ++++-

  tools/testing/kunit/kunit_config.py                |   7 +-

  tools/testing/kunit/kunit_kernel.py                | 179 +++++++++++---

  tools/testing/kunit/kunit_parser.py                | 217 +++++++++++------

  tools/testing/kunit/kunit_tool_test.py             |  58 +++--

  tools/testing/kunit/qemu_config.py                 |  16 ++

  tools/testing/kunit/qemu_configs/alpha.py          |  10 +

  tools/testing/kunit/qemu_configs/arm.py            |  13 ++

  tools/testing/kunit/qemu_configs/arm64.py          |  12 +

  tools/testing/kunit/qemu_configs/i386.py           |  10 +

  tools/testing/kunit/qemu_configs/powerpc.py        |  12 +

  tools/testing/kunit/qemu_configs/riscv.py          |  31 +++

  tools/testing/kunit/qemu_configs/s390.py           |  14 ++

  tools/testing/kunit/qemu_configs/sparc.py          |  10 +

  tools/testing/kunit/qemu_configs/x86_64.py         |  10 +

  .../kunit/test_data/test_skip_all_tests.log        |  15 ++

  tools/testing/kunit/test_data/test_skip_tests.log  |  15 ++

  42 files changed, 1609 insertions(+), 409 deletions(-)

  create mode 100644 Documentation/dev-tools/kunit/running_tips.rst

  create mode 100644 lib/kunit/executor_test.c

  delete mode 100644 tools/testing/kunit/configs/all_tests.config

  rename arch/um/configs/kunit_defconfig => 
tools/testing/kunit/configs/default.config (63%)

  create mode 100644 tools/testing/kunit/qemu_config.py

  create mode 100644 tools/testing/kunit/qemu_configs/alpha.py

  create mode 100644 tools/testing/kunit/qemu_configs/arm.py

  create mode 100644 tools/testing/kunit/qemu_configs/arm64.py

  create mode 100644 tools/testing/kunit/qemu_configs/i386.py

  create mode 100644 tools/testing/kunit/qemu_configs/powerpc.py

  create mode 100644 tools/testing/kunit/qemu_configs/riscv.py

  create mode 100644 tools/testing/kunit/qemu_configs/s390.py

  create mode 100644 tools/testing/kunit/qemu_configs/sparc.py

  create mode 100644 tools/testing/kunit/qemu_configs/x86_64.py

  create mode 100644 tools/testing/kunit/test_dat/test_skip_all_tests.log
  create mode 100644 tools/testing/kunit/test_data/test_skip_tests.log
----------------------------------------------------------------

--------------98BF7D50A0864B825756CAC7
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-fixes-5.14-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-fixes-5.14-rc1.diff"

diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/dev-tools/kunit/api/index.rst
index 9b9bffe5d41a..b33ad72bcf0b 100644
--- a/Documentation/dev-tools/kunit/api/index.rst
+++ b/Documentation/dev-tools/kunit/api/index.rst
@@ -10,7 +10,7 @@ API Reference
 This section documents the KUnit kernel testing API. It is divided into the
 following sections:
 
-================================= ==============================================
-:doc:`test`                       documents all of the standard testing API
-                                  excluding mocking or mocking related features.
-================================= ==============================================
+Documentation/dev-tools/kunit/api/test.rst
+
+ - documents all of the standard testing API excluding mocking
+   or mocking related features.
diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
index 848478838347..7f7cf8d2ab20 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -14,6 +14,7 @@ KUnit - Unit Testing for the Linux Kernel
 	style
 	faq
 	tips
+	running_tips
 
 What is KUnit?
 ==============
diff --git a/Documentation/dev-tools/kunit/kunit-tool.rst b/Documentation/dev-tools/kunit/kunit-tool.rst
index 29ae2fee8123..c7ff9afe407a 100644
--- a/Documentation/dev-tools/kunit/kunit-tool.rst
+++ b/Documentation/dev-tools/kunit/kunit-tool.rst
@@ -22,14 +22,19 @@ not require any virtualization support: it is just a regular program.
 What is a .kunitconfig?
 =======================
 
-It's just a defconfig that kunit_tool looks for in the base directory.
-kunit_tool uses it to generate a .config as you might expect. In addition, it
-verifies that the generated .config contains the CONFIG options in the
-.kunitconfig; the reason it does this is so that it is easy to be sure that a
-CONFIG that enables a test actually ends up in the .config.
+It's just a defconfig that kunit_tool looks for in the build directory
+(``.kunit`` by default).  kunit_tool uses it to generate a .config as you might
+expect. In addition, it verifies that the generated .config contains the CONFIG
+options in the .kunitconfig; the reason it does this is so that it is easy to
+be sure that a CONFIG that enables a test actually ends up in the .config.
 
-How do I use kunit_tool?
-========================
+It's also possible to pass a separate .kunitconfig fragment to kunit_tool,
+which is useful if you have several different groups of tests you wish
+to run independently, or if you want to use pre-defined test configs for
+certain subsystems.
+
+Getting Started with kunit_tool
+===============================
 
 If a kunitconfig is present at the root directory, all you have to do is:
 
@@ -48,10 +53,177 @@ However, you most likely want to use it with the following options:
 
 .. note::
 	This command will work even without a .kunitconfig file: if no
-        .kunitconfig is present, a default one will be used instead.
+	.kunitconfig is present, a default one will be used instead.
+
+If you wish to use a different .kunitconfig file (such as one provided for
+testing a particular subsystem), you can pass it as an option.
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py run --kunitconfig=fs/ext4/.kunitconfig
 
 For a list of all the flags supported by kunit_tool, you can run:
 
 .. code-block:: bash
 
 	./tools/testing/kunit/kunit.py run --help
+
+Configuring, Building, and Running Tests
+========================================
+
+It's also possible to run just parts of the KUnit build process independently,
+which is useful if you want to make manual changes to part of the process.
+
+A .config can be generated from a .kunitconfig by using the ``config`` argument
+when running kunit_tool:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py config
+
+Similarly, if you just want to build a KUnit kernel from the current .config,
+you can use the ``build`` argument:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py build
+
+And, if you already have a built UML kernel with built-in KUnit tests, you can
+run the kernel and display the test results with the ``exec`` argument:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py exec
+
+The ``run`` command which is discussed above is equivalent to running all three
+of these in sequence.
+
+All of these commands accept a number of optional command-line arguments. The
+``--help`` flag will give a complete list of these, or keep reading this page
+for a guide to some of the more useful ones.
+
+Parsing Test Results
+====================
+
+KUnit tests output their results in TAP (Test Anything Protocol) format.
+kunit_tool will, when running tests, parse this output and print a summary
+which is much more pleasant to read. If you wish to look at the raw test
+results in TAP format, you can pass the ``--raw_output`` argument.
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py run --raw_output
+
+.. note::
+	The raw output from test runs may contain other, non-KUnit kernel log
+	lines.
+
+If you have KUnit results in their raw TAP format, you can parse them and print
+the human-readable summary with the ``parse`` command for kunit_tool. This
+accepts a filename for an argument, or will read from standard input.
+
+.. code-block:: bash
+
+	# Reading from a file
+	./tools/testing/kunit/kunit.py parse /var/log/dmesg
+	# Reading from stdin
+	dmesg | ./tools/testing/kunit/kunit.py parse
+
+This is very useful if you wish to run tests in a configuration not supported
+by kunit_tool (such as on real hardware, or an unsupported architecture).
+
+Filtering Tests
+===============
+
+It's possible to run only a subset of the tests built into a kernel by passing
+a filter to the ``exec`` or ``run`` commands. For example, if you only wanted
+to run KUnit resource tests, you could use:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py run 'kunit-resource*'
+
+This uses the standard glob format for wildcards.
+
+Running Tests on QEMU
+=====================
+
+kunit_tool supports running tests on QEMU as well as via UML (as mentioned
+elsewhere). The default way of running tests on QEMU requires two flags:
+
+``--arch``
+	Selects a collection of configs (Kconfig as well as QEMU configs
+	options, etc) that allow KUnit tests to be run on the specified
+	architecture in a minimal way; this is usually not much slower than
+	using UML. The architecture argument is the same as the name of the
+	option passed to the ``ARCH`` variable used by Kbuild. Not all
+	architectures are currently supported by this flag, but can be handled
+	by the ``--qemu_config`` discussed later. If ``um`` is passed (or this
+	this flag is ignored) the tests will run via UML. Non-UML architectures,
+	e.g. i386, x86_64, arm, um, etc. Non-UML run on QEMU.
+
+``--cross_compile``
+	Specifies the use of a toolchain by Kbuild. The argument passed here is
+	the same passed to the ``CROSS_COMPILE`` variable used by Kbuild. As a
+	reminder this will be the prefix for the toolchain binaries such as gcc
+	for example ``sparc64-linux-gnu-`` if you have the sparc toolchain
+	installed on your system, or
+	``$HOME/toolchains/microblaze/gcc-9.2.0-nolibc/microblaze-linux/bin/microblaze-linux-``
+	if you have downloaded the microblaze toolchain from the 0-day website
+	to a directory in your home directory called ``toolchains``.
+
+In many cases it is likely that you may want to run an architecture which is
+not supported by the ``--arch`` flag, or you may want to just run KUnit tests
+on QEMU using a non-default configuration. For this use case, you can write
+your own QemuConfig. These QemuConfigs are written in Python. They must have an
+import line ``from ..qemu_config import QemuArchParams`` at the top of the file
+and the file must contain a variable called ``QEMU_ARCH`` that has an instance
+of ``QemuArchParams`` assigned to it. An example can be seen in
+``tools/testing/kunit/qemu_configs/x86_64.py``.
+
+Once you have a QemuConfig you can pass it into kunit_tool using the
+``--qemu_config`` flag; when used this flag replaces the ``--arch`` flag. If we
+were to do this with the ``x86_64.py`` example from above, the invocation would
+look something like this:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py run \
+		--timeout=60 \
+		--jobs=12 \
+		--qemu_config=./tools/testing/kunit/qemu_configs/x86_64.py
+
+Other Useful Options
+====================
+
+kunit_tool has a number of other command-line arguments which can be useful
+when adapting it to fit your environment or needs.
+
+Some of the more useful ones are:
+
+``--help``
+	Lists all of the available options. Note that different commands
+	(``config``, ``build``, ``run``, etc) will have different supported
+	options. Place ``--help`` before the command to list common options,
+	and after the command for options specific to that command.
+
+``--build_dir``
+	Specifies the build directory that kunit_tool will use. This is where
+	the .kunitconfig file is located, as well as where the .config and
+	compiled kernel will be placed. Defaults to ``.kunit``.
+
+``--make_options``
+	Specifies additional options to pass to ``make`` when compiling a
+	kernel (with the ``build`` or ``run`` commands). For example, to enable
+	compiler warnings, you can pass ``--make_options W=1``.
+
+``--alltests``
+        Builds a UML kernel with all config options enabled using ``make
+        allyesconfig``. This allows you to run as many tests as is possible,
+        but is very slow and prone to breakage as new options are added or
+        modified. In most cases, enabling all tests which have satisfied
+        dependencies by adding ``CONFIG_KUNIT_ALL_TESTS=1`` to your
+        .kunitconfig is preferable.
+
+There are several other options (and new ones are often added), so do check
+``--help`` if you're looking for something not mentioned here.
diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
new file mode 100644
index 000000000000..7d99386cf94a
--- /dev/null
+++ b/Documentation/dev-tools/kunit/running_tips.rst
@@ -0,0 +1,259 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================
+Tips For Running KUnit Tests
+============================
+
+Using ``kunit.py run`` ("kunit tool")
+=====================================
+
+Running from any directory
+--------------------------
+
+It can be handy to create a bash function like:
+
+.. code-block:: bash
+
+	function run_kunit() {
+	  ( cd "$(git rev-parse --show-toplevel)" && ./tools/testing/kunit/kunit.py run $@ )
+	}
+
+.. note::
+	Early versions of ``kunit.py`` (before 5.6) didn't work unless run from
+	the kernel root, hence the use of a subshell and ``cd``.
+
+Running a subset of tests
+-------------------------
+
+``kunit.py run`` accepts an optional glob argument to filter tests. Currently
+this only matches against suite names, but this may change in the future.
+
+Say that we wanted to run the sysctl tests, we could do so via:
+
+.. code-block:: bash
+
+	$ echo -e 'CONFIG_KUNIT=y\nCONFIG_KUNIT_ALL_TESTS=y' > .kunit/.kunitconfig
+	$ ./tools/testing/kunit/kunit.py run 'sysctl*'
+
+We're paying the cost of building more tests than we need this way, but it's
+easier than fiddling with ``.kunitconfig`` files or commenting out
+``kunit_suite``'s.
+
+However, if we wanted to define a set of tests in a less ad hoc way, the next
+tip is useful.
+
+Defining a set of tests
+-----------------------
+
+``kunit.py run`` (along with ``build``, and ``config``) supports a
+``--kunitconfig`` flag. So if you have a set of tests that you want to run on a
+regular basis (especially if they have other dependencies), you can create a
+specific ``.kunitconfig`` for them.
+
+E.g. kunit has one for its tests:
+
+.. code-block:: bash
+
+	$ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit/.kunitconfig
+
+Alternatively, if you're following the convention of naming your
+file ``.kunitconfig``, you can just pass in the dir, e.g.
+
+.. code-block:: bash
+
+	$ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit
+
+.. note::
+	This is a relatively new feature (5.12+) so we don't have any
+	conventions yet about on what files should be checked in versus just
+	kept around locally. It's up to you and your maintainer to decide if a
+	config is useful enough to submit (and therefore have to maintain).
+
+.. note::
+	Having ``.kunitconfig`` fragments in a parent and child directory is
+	iffy. There's discussion about adding an "import" statement in these
+	files to make it possible to have a top-level config run tests from all
+	child directories. But that would mean ``.kunitconfig`` files are no
+	longer just simple .config fragments.
+
+	One alternative would be to have kunit tool recursively combine configs
+	automagically, but tests could theoretically depend on incompatible
+	options, so handling that would be tricky.
+
+Generating code coverage reports under UML
+------------------------------------------
+
+.. note::
+	TODO(brendanhiggins@google.com): There are various issues with UML and
+	versions of gcc 7 and up. You're likely to run into missing ``.gcda``
+	files or compile errors. We know one `faulty GCC commit
+	<https://github.com/gcc-mirror/gcc/commit/8c9434c2f9358b8b8bad2c1990edf10a21645f9d>`_
+	but not how we'd go about getting this fixed. The compile errors still
+	need some investigation.
+
+.. note::
+	TODO(brendanhiggins@google.com): for recent versions of Linux
+	(5.10-5.12, maybe earlier), there's a bug with gcov counters not being
+	flushed in UML. This translates to very low (<1%) reported coverage. This is
+	related to the above issue and can be worked around by replacing the
+	one call to ``uml_abort()`` (it's in ``os_dump_core()``) with a plain
+	``exit()``.
+
+
+This is different from the "normal" way of getting coverage information that is
+documented in Documentation/dev-tools/gcov.rst.
+
+Instead of enabling ``CONFIG_GCOV_KERNEL=y``, we can set these options:
+
+.. code-block:: none
+
+	CONFIG_DEBUG_KERNEL=y
+	CONFIG_DEBUG_INFO=y
+	CONFIG_GCOV=y
+
+
+Putting it together into a copy-pastable sequence of commands:
+
+.. code-block:: bash
+
+	# Append coverage options to the current config
+	$ echo -e "CONFIG_DEBUG_KERNEL=y\nCONFIG_DEBUG_INFO=y\nCONFIG_GCOV=y" >> .kunit/.kunitconfig
+	$ ./tools/testing/kunit/kunit.py run
+	# Extract the coverage information from the build dir (.kunit/)
+	$ lcov -t "my_kunit_tests" -o coverage.info -c -d .kunit/
+
+	# From here on, it's the same process as with CONFIG_GCOV_KERNEL=y
+	# E.g. can generate an HTML report in a tmp dir like so:
+	$ genhtml -o /tmp/coverage_html coverage.info
+
+
+If your installed version of gcc doesn't work, you can tweak the steps:
+
+.. code-block:: bash
+
+	$ ./tools/testing/kunit/kunit.py run --make_options=CC=/usr/bin/gcc-6
+	$ lcov -t "my_kunit_tests" -o coverage.info -c -d .kunit/ --gcov-tool=/usr/bin/gcov-6
+
+
+Running tests manually
+======================
+
+Running tests without using ``kunit.py run`` is also an important use case.
+Currently it's your only option if you want to test on architectures other than
+UML.
+
+As running the tests under UML is fairly straightforward (configure and compile
+the kernel, run the ``./linux`` binary), this section will focus on testing
+non-UML architectures.
+
+
+Running built-in tests
+----------------------
+
+When setting tests to ``=y``, the tests will run as part of boot and print
+results to dmesg in TAP format. So you just need to add your tests to your
+``.config``, build and boot your kernel as normal.
+
+So if we compiled our kernel with:
+
+.. code-block:: none
+
+	CONFIG_KUNIT=y
+	CONFIG_KUNIT_EXAMPLE_TEST=y
+
+Then we'd see output like this in dmesg signaling the test ran and passed:
+
+.. code-block:: none
+
+	TAP version 14
+	1..1
+	    # Subtest: example
+	    1..1
+	    # example_simple_test: initializing
+	    ok 1 - example_simple_test
+	ok 1 - example
+
+Running tests as modules
+------------------------
+
+Depending on the tests, you can build them as loadable modules.
+
+For example, we'd change the config options from before to
+
+.. code-block:: none
+
+	CONFIG_KUNIT=y
+	CONFIG_KUNIT_EXAMPLE_TEST=m
+
+Then after booting into our kernel, we can run the test via
+
+.. code-block:: none
+
+	$ modprobe kunit-example-test
+
+This will then cause it to print TAP output to stdout.
+
+.. note::
+	The ``modprobe`` will *not* have a non-zero exit code if any test
+	failed (as of 5.13). But ``kunit.py parse`` would, see below.
+
+.. note::
+	You can set ``CONFIG_KUNIT=m`` as well, however, some features will not
+	work and thus some tests might break. Ideally tests would specify they
+	depend on ``KUNIT=y`` in their ``Kconfig``'s, but this is an edge case
+	most test authors won't think about.
+	As of 5.13, the only difference is that ``current->kunit_test`` will
+	not exist.
+
+Pretty-printing results
+-----------------------
+
+You can use ``kunit.py parse`` to parse dmesg for test output and print out
+results in the same familiar format that ``kunit.py run`` does.
+
+.. code-block:: bash
+
+	$ ./tools/testing/kunit/kunit.py parse /var/log/dmesg
+
+
+Retrieving per suite results
+----------------------------
+
+Regardless of how you're running your tests, you can enable
+``CONFIG_KUNIT_DEBUGFS`` to expose per-suite TAP-formatted results:
+
+.. code-block:: none
+
+	CONFIG_KUNIT=y
+	CONFIG_KUNIT_EXAMPLE_TEST=m
+	CONFIG_KUNIT_DEBUGFS=y
+
+The results for each suite will be exposed under
+``/sys/kernel/debug/kunit/<suite>/results``.
+So using our example config:
+
+.. code-block:: bash
+
+	$ modprobe kunit-example-test > /dev/null
+	$ cat /sys/kernel/debug/kunit/example/results
+	... <TAP output> ...
+
+	# After removing the module, the corresponding files will go away
+	$ modprobe -r kunit-example-test
+	$ cat /sys/kernel/debug/kunit/example/results
+	/sys/kernel/debug/kunit/example/results: No such file or directory
+
+Generating code coverage reports
+--------------------------------
+
+See Documentation/dev-tools/gcov.rst for details on how to do this.
+
+The only vaguely KUnit-specific advice here is that you probably want to build
+your tests as modules. That way you can isolate the coverage from tests from
+other code executed during boot, e.g.
+
+.. code-block:: bash
+
+	# Reset coverage counters before running the test.
+	$ echo 0 > /sys/kernel/debug/gcov/reset
+	$ modprobe kunit-example-test
diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 0e65cabe08eb..62d8462db4df 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -36,7 +36,7 @@ A good starting point for a ``.kunitconfig`` is the KUnit defconfig:
 .. code-block:: bash
 
 	cd $PATH_TO_LINUX_REPO
-	cp arch/um/configs/kunit_defconfig .kunitconfig
+	cp tools/testing/kunit/configs/default.config .kunitconfig
 
 You can then add any other Kconfig options you wish, e.g.:
 
@@ -236,5 +236,7 @@ Next Steps
 ==========
 *   Check out the :doc:`tips` page for tips on
     writing idiomatic KUnit tests.
+*   Check out the :doc:`running_tips` page for tips on
+    how to make running KUnit tests easier.
 *   Optional: see the :doc:`usage` page for a more
     in-depth explanation of KUnit.
diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 650f99590df5..97c9a31919a6 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -465,10 +465,9 @@ fictitious example for ``sha1sum(1)``
 
 .. code-block:: c
 
-	/* Note: the cast is to satisfy overly strict type-checking. */
 	#define TEST_SHA1(in, want) \
 		sha1sum(in, out); \
-		KUNIT_EXPECT_STREQ_MSG(test, (char *)out, want, "sha1sum(%s)", in);
+		KUNIT_EXPECT_STREQ_MSG(test, out, want, "sha1sum(%s)", in);
 
 	char out[40];
 	TEST_SHA1("hello world",  "2aae6c35c94fcfb415dbe95f408b9ce91ee846ed");
@@ -507,7 +506,7 @@ In some cases, it can be helpful to write a *table-driven test* instead, e.g.
 	};
 	for (i = 0; i < ARRAY_SIZE(cases); ++i) {
 		sha1sum(cases[i].str, out);
-		KUNIT_EXPECT_STREQ_MSG(test, (char *)out, cases[i].sha1,
+		KUNIT_EXPECT_STREQ_MSG(test, out, cases[i].sha1,
 		                      "sha1sum(%s)", cases[i].str);
 	}
 
@@ -568,7 +567,7 @@ Reusing the same ``cases`` array from above, we can write the test as a
 		struct sha1_test_case *test_param = (struct sha1_test_case *)(test->param_value);
 
 		sha1sum(test_param->str, out);
-		KUNIT_EXPECT_STREQ_MSG(test, (char *)out, test_param->sha1,
+		KUNIT_EXPECT_STREQ_MSG(test, out, test_param->sha1,
 				      "sha1sum(%s)", test_param->str);
 	}
 
@@ -609,17 +608,45 @@ non-UML architectures:
 None of these are reasons not to run your KUnit tests on real hardware; they are
 only things to be aware of when doing so.
 
-The biggest impediment will likely be that certain KUnit features and
-infrastructure may not support your target environment. For example, at this
-time the KUnit Wrapper (``tools/testing/kunit/kunit.py``) does not work outside
-of UML. Unfortunately, there is no way around this. Using UML (or even just a
-particular architecture) allows us to make a lot of assumptions that make it
-possible to do things which might otherwise be impossible.
-
-Nevertheless, all core KUnit framework features are fully supported on all
-architectures, and using them is straightforward: all you need to do is to take
-your kunitconfig, your Kconfig options for the tests you would like to run, and
-merge them into whatever config your are using for your platform. That's it!
+Currently, the KUnit Wrapper (``tools/testing/kunit/kunit.py``) (aka
+kunit_tool) only fully supports running tests inside of UML and QEMU; however,
+this is only due to our own time limitations as humans working on KUnit. It is
+entirely possible to support other emulators and even actual hardware, but for
+now QEMU and UML is what is fully supported within the KUnit Wrapper. Again, to
+be clear, this is just the Wrapper. The actualy KUnit tests and the KUnit
+library they are written in is fully architecture agnostic and can be used in
+virtually any setup, you just won't have the benefit of typing a single command
+out of the box and having everything magically work perfectly.
+
+Again, all core KUnit framework features are fully supported on all
+architectures, and using them is straightforward: Most popular architectures
+are supported directly in the KUnit Wrapper via QEMU. Currently, supported
+architectures on QEMU include:
+
+*   i386
+*   x86_64
+*   arm
+*   arm64
+*   alpha
+*   powerpc
+*   riscv
+*   s390
+*   sparc
+
+In order to run KUnit tests on one of these architectures via QEMU with the
+KUnit wrapper, all you need to do is specify the flags ``--arch`` and
+``--cross_compile`` when invoking the KUnit Wrapper. For example, we could run
+the default KUnit tests on ARM in the following manner (assuming we have an ARM
+toolchain installed):
+
+.. code-block:: bash
+
+	tools/testing/kunit/kunit.py run --timeout=60 --jobs=12 --arch=arm --cross_compile=arm-linux-gnueabihf-
+
+Alternatively, if you want to run your tests on real hardware or in some other
+emulation environment, all you need to do is to take your kunitconfig, your
+Kconfig options for the tests you would like to run, and merge them into
+whatever config your are using for your platform. That's it!
 
 For example, let's say you have the following kunitconfig:
 
diff --git a/drivers/base/test/property-entry-test.c b/drivers/base/test/property-entry-test.c
index 1106fedcceed..6071d5bc128c 100644
--- a/drivers/base/test/property-entry-test.c
+++ b/drivers/base/test/property-entry-test.c
@@ -32,11 +32,11 @@ static void pe_test_uints(struct kunit *test)
 
 	error = fwnode_property_read_u8(node, "prop-u8", &val_u8);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)val_u8, 8);
+	KUNIT_EXPECT_EQ(test, val_u8, 8);
 
 	error = fwnode_property_read_u8_array(node, "prop-u8", array_u8, 1);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)array_u8[0], 8);
+	KUNIT_EXPECT_EQ(test, array_u8[0], 8);
 
 	error = fwnode_property_read_u8_array(node, "prop-u8", array_u8, 2);
 	KUNIT_EXPECT_NE(test, error, 0);
@@ -49,14 +49,14 @@ static void pe_test_uints(struct kunit *test)
 
 	error = fwnode_property_read_u16(node, "prop-u16", &val_u16);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)val_u16, 16);
+	KUNIT_EXPECT_EQ(test, val_u16, 16);
 
 	error = fwnode_property_count_u16(node, "prop-u16");
 	KUNIT_EXPECT_EQ(test, error, 1);
 
 	error = fwnode_property_read_u16_array(node, "prop-u16", array_u16, 1);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)array_u16[0], 16);
+	KUNIT_EXPECT_EQ(test, array_u16[0], 16);
 
 	error = fwnode_property_read_u16_array(node, "prop-u16", array_u16, 2);
 	KUNIT_EXPECT_NE(test, error, 0);
@@ -69,14 +69,14 @@ static void pe_test_uints(struct kunit *test)
 
 	error = fwnode_property_read_u32(node, "prop-u32", &val_u32);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)val_u32, 32);
+	KUNIT_EXPECT_EQ(test, val_u32, 32);
 
 	error = fwnode_property_count_u32(node, "prop-u32");
 	KUNIT_EXPECT_EQ(test, error, 1);
 
 	error = fwnode_property_read_u32_array(node, "prop-u32", array_u32, 1);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)array_u32[0], 32);
+	KUNIT_EXPECT_EQ(test, array_u32[0], 32);
 
 	error = fwnode_property_read_u32_array(node, "prop-u32", array_u32, 2);
 	KUNIT_EXPECT_NE(test, error, 0);
@@ -89,14 +89,14 @@ static void pe_test_uints(struct kunit *test)
 
 	error = fwnode_property_read_u64(node, "prop-u64", &val_u64);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)val_u64, 64);
+	KUNIT_EXPECT_EQ(test, val_u64, 64);
 
 	error = fwnode_property_count_u64(node, "prop-u64");
 	KUNIT_EXPECT_EQ(test, error, 1);
 
 	error = fwnode_property_read_u64_array(node, "prop-u64", array_u64, 1);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)array_u64[0], 64);
+	KUNIT_EXPECT_EQ(test, array_u64[0], 64);
 
 	error = fwnode_property_read_u64_array(node, "prop-u64", array_u64, 2);
 	KUNIT_EXPECT_NE(test, error, 0);
@@ -140,19 +140,19 @@ static void pe_test_uint_arrays(struct kunit *test)
 
 	error = fwnode_property_read_u8(node, "prop-u8", &val_u8);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)val_u8, 8);
+	KUNIT_EXPECT_EQ(test, val_u8, 8);
 
 	error = fwnode_property_count_u8(node, "prop-u8");
 	KUNIT_EXPECT_EQ(test, error, 10);
 
 	error = fwnode_property_read_u8_array(node, "prop-u8", array_u8, 1);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)array_u8[0], 8);
+	KUNIT_EXPECT_EQ(test, array_u8[0], 8);
 
 	error = fwnode_property_read_u8_array(node, "prop-u8", array_u8, 2);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)array_u8[0], 8);
-	KUNIT_EXPECT_EQ(test, (int)array_u8[1], 9);
+	KUNIT_EXPECT_EQ(test, array_u8[0], 8);
+	KUNIT_EXPECT_EQ(test, array_u8[1], 9);
 
 	error = fwnode_property_read_u8_array(node, "prop-u8", array_u8, 17);
 	KUNIT_EXPECT_NE(test, error, 0);
@@ -165,19 +165,19 @@ static void pe_test_uint_arrays(struct kunit *test)
 
 	error = fwnode_property_read_u16(node, "prop-u16", &val_u16);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)val_u16, 16);
+	KUNIT_EXPECT_EQ(test, val_u16, 16);
 
 	error = fwnode_property_count_u16(node, "prop-u16");
 	KUNIT_EXPECT_EQ(test, error, 10);
 
 	error = fwnode_property_read_u16_array(node, "prop-u16", array_u16, 1);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)array_u16[0], 16);
+	KUNIT_EXPECT_EQ(test, array_u16[0], 16);
 
 	error = fwnode_property_read_u16_array(node, "prop-u16", array_u16, 2);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)array_u16[0], 16);
-	KUNIT_EXPECT_EQ(test, (int)array_u16[1], 17);
+	KUNIT_EXPECT_EQ(test, array_u16[0], 16);
+	KUNIT_EXPECT_EQ(test, array_u16[1], 17);
 
 	error = fwnode_property_read_u16_array(node, "prop-u16", array_u16, 17);
 	KUNIT_EXPECT_NE(test, error, 0);
@@ -190,19 +190,19 @@ static void pe_test_uint_arrays(struct kunit *test)
 
 	error = fwnode_property_read_u32(node, "prop-u32", &val_u32);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)val_u32, 32);
+	KUNIT_EXPECT_EQ(test, val_u32, 32);
 
 	error = fwnode_property_count_u32(node, "prop-u32");
 	KUNIT_EXPECT_EQ(test, error, 10);
 
 	error = fwnode_property_read_u32_array(node, "prop-u32", array_u32, 1);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)array_u32[0], 32);
+	KUNIT_EXPECT_EQ(test, array_u32[0], 32);
 
 	error = fwnode_property_read_u32_array(node, "prop-u32", array_u32, 2);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)array_u32[0], 32);
-	KUNIT_EXPECT_EQ(test, (int)array_u32[1], 33);
+	KUNIT_EXPECT_EQ(test, array_u32[0], 32);
+	KUNIT_EXPECT_EQ(test, array_u32[1], 33);
 
 	error = fwnode_property_read_u32_array(node, "prop-u32", array_u32, 17);
 	KUNIT_EXPECT_NE(test, error, 0);
@@ -215,19 +215,19 @@ static void pe_test_uint_arrays(struct kunit *test)
 
 	error = fwnode_property_read_u64(node, "prop-u64", &val_u64);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)val_u64, 64);
+	KUNIT_EXPECT_EQ(test, val_u64, 64);
 
 	error = fwnode_property_count_u64(node, "prop-u64");
 	KUNIT_EXPECT_EQ(test, error, 10);
 
 	error = fwnode_property_read_u64_array(node, "prop-u64", array_u64, 1);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)array_u64[0], 64);
+	KUNIT_EXPECT_EQ(test, array_u64[0], 64);
 
 	error = fwnode_property_read_u64_array(node, "prop-u64", array_u64, 2);
 	KUNIT_EXPECT_EQ(test, error, 0);
-	KUNIT_EXPECT_EQ(test, (int)array_u64[0], 64);
-	KUNIT_EXPECT_EQ(test, (int)array_u64[1], 65);
+	KUNIT_EXPECT_EQ(test, array_u64[0], 64);
+	KUNIT_EXPECT_EQ(test, array_u64[1], 65);
 
 	error = fwnode_property_read_u64_array(node, "prop-u64", array_u64, 17);
 	KUNIT_EXPECT_NE(test, error, 0);
@@ -358,13 +358,13 @@ static void pe_test_move_inline_u8(struct kunit *test)
 
 	KUNIT_EXPECT_TRUE(test, copy[0].is_inline);
 	data_ptr = (u8 *)&copy[0].value;
-	KUNIT_EXPECT_EQ(test, (int)data_ptr[0], 1);
-	KUNIT_EXPECT_EQ(test, (int)data_ptr[1], 2);
+	KUNIT_EXPECT_EQ(test, data_ptr[0], 1);
+	KUNIT_EXPECT_EQ(test, data_ptr[1], 2);
 
 	KUNIT_EXPECT_FALSE(test, copy[1].is_inline);
 	data_ptr = copy[1].pointer;
-	KUNIT_EXPECT_EQ(test, (int)data_ptr[0], 5);
-	KUNIT_EXPECT_EQ(test, (int)data_ptr[1], 6);
+	KUNIT_EXPECT_EQ(test, data_ptr[0], 5);
+	KUNIT_EXPECT_EQ(test, data_ptr[1], 6);
 
 	property_entries_free(copy);
 }
diff --git a/drivers/iio/test/iio-test-format.c b/drivers/iio/test/iio-test-format.c
index 55a0cfe9181d..f1e951eddb43 100644
--- a/drivers/iio/test/iio-test-format.c
+++ b/drivers/iio/test/iio-test-format.c
@@ -8,7 +8,7 @@
 #include <linux/iio/iio.h>
 
 #define IIO_TEST_FORMAT_EXPECT_EQ(_test, _buf, _ret, _val) do { \
-		KUNIT_EXPECT_EQ(_test, (int)strlen(_buf), _ret); \
+		KUNIT_EXPECT_EQ(_test, strlen(_buf), _ret); \
 		KUNIT_EXPECT_STREQ(_test, (_buf), (_val)); \
 	} while (0)
 
diff --git a/drivers/mmc/host/sdhci-of-aspeed-test.c b/drivers/mmc/host/sdhci-of-aspeed-test.c
index bb67d159b7d8..1ed4f86291f2 100644
--- a/drivers/mmc/host/sdhci-of-aspeed-test.c
+++ b/drivers/mmc/host/sdhci-of-aspeed-test.c
@@ -26,23 +26,23 @@ static void aspeed_sdhci_phase_ddr52(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 15,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 25));
 
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 0,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 0,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 180));
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 0,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 0,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 181));
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 182));
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 183));
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 2,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 2,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 184));
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 3,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 3,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 185));
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 14,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 14,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 203));
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 204));
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 205));
 }
 
@@ -67,21 +67,21 @@ static void aspeed_sdhci_phase_hs200(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 15,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 96));
 
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 180));
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 185));
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 186));
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 187));
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 14,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 14,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 269));
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 270));
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 271));
-	KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
+	KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
 			aspeed_sdhci_phase_to_tap(NULL, rate, 276));
 }
 
diff --git a/drivers/thunderbolt/test.c b/drivers/thunderbolt/test.c
index 5ff5a03bc9ce..3cc36ef639f3 100644
--- a/drivers/thunderbolt/test.c
+++ b/drivers/thunderbolt/test.c
@@ -389,7 +389,7 @@ static void tb_test_path_single_hop_walk(struct kunit *test)
 		i++;
 	}
 
-	KUNIT_EXPECT_EQ(test, i, (int)ARRAY_SIZE(test_data));
+	KUNIT_EXPECT_EQ(test, i, ARRAY_SIZE(test_data));
 
 	i = ARRAY_SIZE(test_data) - 1;
 	tb_for_each_port_on_path(dst_port, src_port, p) {
@@ -448,7 +448,7 @@ static void tb_test_path_daisy_chain_walk(struct kunit *test)
 		i++;
 	}
 
-	KUNIT_EXPECT_EQ(test, i, (int)ARRAY_SIZE(test_data));
+	KUNIT_EXPECT_EQ(test, i, ARRAY_SIZE(test_data));
 
 	i = ARRAY_SIZE(test_data) - 1;
 	tb_for_each_port_on_path(dst_port, src_port, p) {
@@ -511,7 +511,7 @@ static void tb_test_path_simple_tree_walk(struct kunit *test)
 		i++;
 	}
 
-	KUNIT_EXPECT_EQ(test, i, (int)ARRAY_SIZE(test_data));
+	KUNIT_EXPECT_EQ(test, i, ARRAY_SIZE(test_data));
 
 	i = ARRAY_SIZE(test_data) - 1;
 	tb_for_each_port_on_path(dst_port, src_port, p) {
@@ -595,7 +595,7 @@ static void tb_test_path_complex_tree_walk(struct kunit *test)
 		i++;
 	}
 
-	KUNIT_EXPECT_EQ(test, i, (int)ARRAY_SIZE(test_data));
+	KUNIT_EXPECT_EQ(test, i, ARRAY_SIZE(test_data));
 
 	i = ARRAY_SIZE(test_data) - 1;
 	tb_for_each_port_on_path(dst_port, src_port, p) {
@@ -698,7 +698,7 @@ static void tb_test_path_max_length_walk(struct kunit *test)
 		i++;
 	}
 
-	KUNIT_EXPECT_EQ(test, i, (int)ARRAY_SIZE(test_data));
+	KUNIT_EXPECT_EQ(test, i, ARRAY_SIZE(test_data));
 
 	i = ARRAY_SIZE(test_data) - 1;
 	tb_for_each_port_on_path(dst_port, src_port, p) {
@@ -780,7 +780,7 @@ static void tb_test_path_not_bonded_lane0(struct kunit *test)
 
 	path = tb_path_alloc(NULL, down, 8, up, 8, 0, "PCIe Down");
 	KUNIT_ASSERT_TRUE(test, path != NULL);
-	KUNIT_ASSERT_EQ(test, path->path_length, (int)ARRAY_SIZE(test_data));
+	KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
 	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
 		const struct tb_port *in_port, *out_port;
 
@@ -842,7 +842,7 @@ static void tb_test_path_not_bonded_lane1(struct kunit *test)
 
 	path = tb_path_alloc(NULL, in, 9, out, 9, 1, "Video");
 	KUNIT_ASSERT_TRUE(test, path != NULL);
-	KUNIT_ASSERT_EQ(test, path->path_length, (int)ARRAY_SIZE(test_data));
+	KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
 	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
 		const struct tb_port *in_port, *out_port;
 
@@ -922,7 +922,7 @@ static void tb_test_path_not_bonded_lane1_chain(struct kunit *test)
 
 	path = tb_path_alloc(NULL, in, 9, out, 9, 1, "Video");
 	KUNIT_ASSERT_TRUE(test, path != NULL);
-	KUNIT_ASSERT_EQ(test, path->path_length, (int)ARRAY_SIZE(test_data));
+	KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
 	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
 		const struct tb_port *in_port, *out_port;
 
@@ -1002,7 +1002,7 @@ static void tb_test_path_not_bonded_lane1_chain_reverse(struct kunit *test)
 
 	path = tb_path_alloc(NULL, in, 9, out, 9, 1, "Video");
 	KUNIT_ASSERT_TRUE(test, path != NULL);
-	KUNIT_ASSERT_EQ(test, path->path_length, (int)ARRAY_SIZE(test_data));
+	KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
 	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
 		const struct tb_port *in_port, *out_port;
 
@@ -1094,7 +1094,7 @@ static void tb_test_path_mixed_chain(struct kunit *test)
 
 	path = tb_path_alloc(NULL, in, 9, out, 9, 1, "Video");
 	KUNIT_ASSERT_TRUE(test, path != NULL);
-	KUNIT_ASSERT_EQ(test, path->path_length, (int)ARRAY_SIZE(test_data));
+	KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
 	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
 		const struct tb_port *in_port, *out_port;
 
@@ -1186,7 +1186,7 @@ static void tb_test_path_mixed_chain_reverse(struct kunit *test)
 
 	path = tb_path_alloc(NULL, in, 9, out, 9, 1, "Video");
 	KUNIT_ASSERT_TRUE(test, path != NULL);
-	KUNIT_ASSERT_EQ(test, path->path_length, (int)ARRAY_SIZE(test_data));
+	KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
 	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
 		const struct tb_port *in_port, *out_port;
 
@@ -1230,10 +1230,10 @@ static void tb_test_tunnel_pcie(struct kunit *test)
 	up = &dev1->ports[9];
 	tunnel1 = tb_tunnel_alloc_pci(NULL, up, down);
 	KUNIT_ASSERT_TRUE(test, tunnel1 != NULL);
-	KUNIT_EXPECT_EQ(test, tunnel1->type, (enum tb_tunnel_type)TB_TUNNEL_PCI);
+	KUNIT_EXPECT_EQ(test, tunnel1->type, TB_TUNNEL_PCI);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel1->src_port, down);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel1->dst_port, up);
-	KUNIT_ASSERT_EQ(test, tunnel1->npaths, (size_t)2);
+	KUNIT_ASSERT_EQ(test, tunnel1->npaths, 2);
 	KUNIT_ASSERT_EQ(test, tunnel1->paths[0]->path_length, 2);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel1->paths[0]->hops[0].in_port, down);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel1->paths[0]->hops[1].out_port, up);
@@ -1245,10 +1245,10 @@ static void tb_test_tunnel_pcie(struct kunit *test)
 	up = &dev2->ports[9];
 	tunnel2 = tb_tunnel_alloc_pci(NULL, up, down);
 	KUNIT_ASSERT_TRUE(test, tunnel2 != NULL);
-	KUNIT_EXPECT_EQ(test, tunnel2->type, (enum tb_tunnel_type)TB_TUNNEL_PCI);
+	KUNIT_EXPECT_EQ(test, tunnel2->type, TB_TUNNEL_PCI);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel2->src_port, down);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel2->dst_port, up);
-	KUNIT_ASSERT_EQ(test, tunnel2->npaths, (size_t)2);
+	KUNIT_ASSERT_EQ(test, tunnel2->npaths, 2);
 	KUNIT_ASSERT_EQ(test, tunnel2->paths[0]->path_length, 2);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel2->paths[0]->hops[0].in_port, down);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel2->paths[0]->hops[1].out_port, up);
@@ -1282,10 +1282,10 @@ static void tb_test_tunnel_dp(struct kunit *test)
 
 	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
 	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
-	KUNIT_EXPECT_EQ(test, tunnel->type, (enum tb_tunnel_type)TB_TUNNEL_DP);
+	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, out);
-	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)3);
+	KUNIT_ASSERT_EQ(test, tunnel->npaths, 3);
 	KUNIT_ASSERT_EQ(test, tunnel->paths[0]->path_length, 2);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->paths[0]->hops[0].in_port, in);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->paths[0]->hops[1].out_port, out);
@@ -1328,10 +1328,10 @@ static void tb_test_tunnel_dp_chain(struct kunit *test)
 
 	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
 	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
-	KUNIT_EXPECT_EQ(test, tunnel->type, (enum tb_tunnel_type)TB_TUNNEL_DP);
+	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, out);
-	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)3);
+	KUNIT_ASSERT_EQ(test, tunnel->npaths, 3);
 	KUNIT_ASSERT_EQ(test, tunnel->paths[0]->path_length, 3);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->paths[0]->hops[0].in_port, in);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->paths[0]->hops[2].out_port, out);
@@ -1378,10 +1378,10 @@ static void tb_test_tunnel_dp_tree(struct kunit *test)
 
 	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
 	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
-	KUNIT_EXPECT_EQ(test, tunnel->type, (enum tb_tunnel_type)TB_TUNNEL_DP);
+	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, out);
-	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)3);
+	KUNIT_ASSERT_EQ(test, tunnel->npaths, 3);
 	KUNIT_ASSERT_EQ(test, tunnel->paths[0]->path_length, 4);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->paths[0]->hops[0].in_port, in);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->paths[0]->hops[3].out_port, out);
@@ -1443,10 +1443,10 @@ static void tb_test_tunnel_dp_max_length(struct kunit *test)
 
 	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
 	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
-	KUNIT_EXPECT_EQ(test, tunnel->type, (enum tb_tunnel_type)TB_TUNNEL_DP);
+	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, out);
-	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)3);
+	KUNIT_ASSERT_EQ(test, tunnel->npaths, 3);
 	KUNIT_ASSERT_EQ(test, tunnel->paths[0]->path_length, 13);
 	/* First hop */
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->paths[0]->hops[0].in_port, in);
@@ -1499,10 +1499,10 @@ static void tb_test_tunnel_usb3(struct kunit *test)
 	up = &dev1->ports[16];
 	tunnel1 = tb_tunnel_alloc_usb3(NULL, up, down, 0, 0);
 	KUNIT_ASSERT_TRUE(test, tunnel1 != NULL);
-	KUNIT_EXPECT_EQ(test, tunnel1->type, (enum tb_tunnel_type)TB_TUNNEL_USB3);
+	KUNIT_EXPECT_EQ(test, tunnel1->type, TB_TUNNEL_USB3);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel1->src_port, down);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel1->dst_port, up);
-	KUNIT_ASSERT_EQ(test, tunnel1->npaths, (size_t)2);
+	KUNIT_ASSERT_EQ(test, tunnel1->npaths, 2);
 	KUNIT_ASSERT_EQ(test, tunnel1->paths[0]->path_length, 2);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel1->paths[0]->hops[0].in_port, down);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel1->paths[0]->hops[1].out_port, up);
@@ -1514,10 +1514,10 @@ static void tb_test_tunnel_usb3(struct kunit *test)
 	up = &dev2->ports[16];
 	tunnel2 = tb_tunnel_alloc_usb3(NULL, up, down, 0, 0);
 	KUNIT_ASSERT_TRUE(test, tunnel2 != NULL);
-	KUNIT_EXPECT_EQ(test, tunnel2->type, (enum tb_tunnel_type)TB_TUNNEL_USB3);
+	KUNIT_EXPECT_EQ(test, tunnel2->type, TB_TUNNEL_USB3);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel2->src_port, down);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel2->dst_port, up);
-	KUNIT_ASSERT_EQ(test, tunnel2->npaths, (size_t)2);
+	KUNIT_ASSERT_EQ(test, tunnel2->npaths, 2);
 	KUNIT_ASSERT_EQ(test, tunnel2->paths[0]->path_length, 2);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel2->paths[0]->hops[0].in_port, down);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel2->paths[0]->hops[1].out_port, up);
@@ -1618,10 +1618,10 @@ static void tb_test_tunnel_dma(struct kunit *test)
 
 	tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, 8, 1, 8, 1);
 	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
-	KUNIT_EXPECT_EQ(test, tunnel->type, (enum tb_tunnel_type)TB_TUNNEL_DMA);
+	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DMA);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, nhi);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, port);
-	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)2);
+	KUNIT_ASSERT_EQ(test, tunnel->npaths, 2);
 	/* RX path */
 	KUNIT_ASSERT_EQ(test, tunnel->paths[0]->path_length, 1);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->paths[0]->hops[0].in_port, port);
@@ -1661,10 +1661,10 @@ static void tb_test_tunnel_dma_rx(struct kunit *test)
 
 	tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, -1, -1, 15, 2);
 	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
-	KUNIT_EXPECT_EQ(test, tunnel->type, (enum tb_tunnel_type)TB_TUNNEL_DMA);
+	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DMA);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, nhi);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, port);
-	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)1);
+	KUNIT_ASSERT_EQ(test, tunnel->npaths, 1);
 	/* RX path */
 	KUNIT_ASSERT_EQ(test, tunnel->paths[0]->path_length, 1);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->paths[0]->hops[0].in_port, port);
@@ -1698,10 +1698,10 @@ static void tb_test_tunnel_dma_tx(struct kunit *test)
 
 	tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, 15, 2, -1, -1);
 	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
-	KUNIT_EXPECT_EQ(test, tunnel->type, (enum tb_tunnel_type)TB_TUNNEL_DMA);
+	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DMA);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, nhi);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, port);
-	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)1);
+	KUNIT_ASSERT_EQ(test, tunnel->npaths, 1);
 	/* TX path */
 	KUNIT_ASSERT_EQ(test, tunnel->paths[0]->path_length, 1);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->paths[0]->hops[0].in_port, nhi);
@@ -1744,10 +1744,10 @@ static void tb_test_tunnel_dma_chain(struct kunit *test)
 	port = &dev2->ports[3];
 	tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, 8, 1, 8, 1);
 	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
-	KUNIT_EXPECT_EQ(test, tunnel->type, (enum tb_tunnel_type)TB_TUNNEL_DMA);
+	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DMA);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, nhi);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, port);
-	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)2);
+	KUNIT_ASSERT_EQ(test, tunnel->npaths, 2);
 	/* RX path */
 	KUNIT_ASSERT_EQ(test, tunnel->paths[0]->path_length, 3);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->paths[0]->hops[0].in_port, port);
@@ -1906,7 +1906,7 @@ static void tb_test_property_parse(struct kunit *test)
 
 	p = tb_property_find(dir, "vendorid", TB_PROPERTY_TYPE_VALUE);
 	KUNIT_ASSERT_TRUE(test, p != NULL);
-	KUNIT_EXPECT_EQ(test, p->value.immediate, (u32)0xa27);
+	KUNIT_EXPECT_EQ(test, p->value.immediate, 0xa27);
 
 	p = tb_property_find(dir, "deviceid", TB_PROPERTY_TYPE_TEXT);
 	KUNIT_ASSERT_TRUE(test, p != NULL);
@@ -1914,7 +1914,7 @@ static void tb_test_property_parse(struct kunit *test)
 
 	p = tb_property_find(dir, "deviceid", TB_PROPERTY_TYPE_VALUE);
 	KUNIT_ASSERT_TRUE(test, p != NULL);
-	KUNIT_EXPECT_EQ(test, p->value.immediate, (u32)0xa);
+	KUNIT_EXPECT_EQ(test, p->value.immediate, 0xa);
 
 	p = tb_property_find(dir, "missing", TB_PROPERTY_TYPE_DIRECTORY);
 	KUNIT_ASSERT_TRUE(test, !p);
@@ -1927,19 +1927,19 @@ static void tb_test_property_parse(struct kunit *test)
 
 	p = tb_property_find(network_dir, "prtcid", TB_PROPERTY_TYPE_VALUE);
 	KUNIT_ASSERT_TRUE(test, p != NULL);
-	KUNIT_EXPECT_EQ(test, p->value.immediate, (u32)0x1);
+	KUNIT_EXPECT_EQ(test, p->value.immediate, 0x1);
 
 	p = tb_property_find(network_dir, "prtcvers", TB_PROPERTY_TYPE_VALUE);
 	KUNIT_ASSERT_TRUE(test, p != NULL);
-	KUNIT_EXPECT_EQ(test, p->value.immediate, (u32)0x1);
+	KUNIT_EXPECT_EQ(test, p->value.immediate, 0x1);
 
 	p = tb_property_find(network_dir, "prtcrevs", TB_PROPERTY_TYPE_VALUE);
 	KUNIT_ASSERT_TRUE(test, p != NULL);
-	KUNIT_EXPECT_EQ(test, p->value.immediate, (u32)0x1);
+	KUNIT_EXPECT_EQ(test, p->value.immediate, 0x1);
 
 	p = tb_property_find(network_dir, "prtcstns", TB_PROPERTY_TYPE_VALUE);
 	KUNIT_ASSERT_TRUE(test, p != NULL);
-	KUNIT_EXPECT_EQ(test, p->value.immediate, (u32)0x0);
+	KUNIT_EXPECT_EQ(test, p->value.immediate, 0x0);
 
 	p = tb_property_find(network_dir, "deviceid", TB_PROPERTY_TYPE_VALUE);
 	KUNIT_EXPECT_TRUE(test, !p);
@@ -1960,7 +1960,7 @@ static void tb_test_property_format(struct kunit *test)
 	KUNIT_ASSERT_TRUE(test, dir != NULL);
 
 	ret = tb_property_format_dir(dir, NULL, 0);
-	KUNIT_ASSERT_EQ(test, ret, (int)ARRAY_SIZE(root_directory));
+	KUNIT_ASSERT_EQ(test, ret, ARRAY_SIZE(root_directory));
 
 	block_len = ret;
 
@@ -2063,7 +2063,7 @@ static void tb_test_property_copy(struct kunit *test)
 
 	/* Compare the resulting property block */
 	ret = tb_property_format_dir(dst, NULL, 0);
-	KUNIT_ASSERT_EQ(test, ret, (int)ARRAY_SIZE(root_directory));
+	KUNIT_ASSERT_EQ(test, ret, ARRAY_SIZE(root_directory));
 
 	block = kunit_kzalloc(test, sizeof(root_directory), GFP_KERNEL);
 	KUNIT_ASSERT_TRUE(test, block != NULL);
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 49601c4b98b8..35b0aed9b739 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -97,6 +97,9 @@ struct kunit;
 /* Maximum size of parameter description string. */
 #define KUNIT_PARAM_DESC_SIZE 128
 
+/* Maximum size of a status comment. */
+#define KUNIT_STATUS_COMMENT_SIZE 256
+
 /*
  * TAP specifies subtest stream indentation of 4 spaces, 8 spaces for a
  * sub-subtest.  See the "Subtests" section in
@@ -105,6 +108,18 @@ struct kunit;
 #define KUNIT_SUBTEST_INDENT		"    "
 #define KUNIT_SUBSUBTEST_INDENT		"        "
 
+/**
+ * enum kunit_status - Type of result for a test or test suite
+ * @KUNIT_SUCCESS: Denotes the test suite has not failed nor been skipped
+ * @KUNIT_FAILURE: Denotes the test has failed.
+ * @KUNIT_SKIPPED: Denotes the test has been skipped.
+ */
+enum kunit_status {
+	KUNIT_SUCCESS,
+	KUNIT_FAILURE,
+	KUNIT_SKIPPED,
+};
+
 /**
  * struct kunit_case - represents an individual test case.
  *
@@ -148,13 +163,20 @@ struct kunit_case {
 	const void* (*generate_params)(const void *prev, char *desc);
 
 	/* private: internal use only. */
-	bool success;
+	enum kunit_status status;
 	char *log;
 };
 
-static inline char *kunit_status_to_string(bool status)
+static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
 {
-	return status ? "ok" : "not ok";
+	switch (status) {
+	case KUNIT_SKIPPED:
+	case KUNIT_SUCCESS:
+		return "ok";
+	case KUNIT_FAILURE:
+		return "not ok";
+	}
+	return "invalid";
 }
 
 /**
@@ -212,6 +234,7 @@ struct kunit_suite {
 	struct kunit_case *test_cases;
 
 	/* private: internal use only */
+	char status_comment[KUNIT_STATUS_COMMENT_SIZE];
 	struct dentry *debugfs;
 	char *log;
 };
@@ -245,19 +268,21 @@ struct kunit {
 	 * be read after the test case finishes once all threads associated
 	 * with the test case have terminated.
 	 */
-	bool success; /* Read only after test_case finishes! */
 	spinlock_t lock; /* Guards all mutable test state. */
+	enum kunit_status status; /* Read only after test_case finishes! */
 	/*
 	 * Because resources is a list that may be updated multiple times (with
 	 * new resources) from any thread associated with a test case, we must
 	 * protect it with some type of lock.
 	 */
 	struct list_head resources; /* Protected by lock. */
+
+	char status_comment[KUNIT_STATUS_COMMENT_SIZE];
 };
 
 static inline void kunit_set_failure(struct kunit *test)
 {
-	WRITE_ONCE(test->success, false);
+	WRITE_ONCE(test->status, KUNIT_FAILURE);
 }
 
 void kunit_init_test(struct kunit *test, const char *name, char *log);
@@ -348,7 +373,7 @@ static inline int kunit_run_all_tests(void)
 #define kunit_suite_for_each_test_case(suite, test_case)		\
 	for (test_case = suite->test_cases; test_case->run_case; test_case++)
 
-bool kunit_suite_has_succeeded(struct kunit_suite *suite);
+enum kunit_status kunit_suite_has_succeeded(struct kunit_suite *suite);
 
 /*
  * Like kunit_alloc_resource() below, but returns the struct kunit_resource
@@ -577,16 +602,30 @@ static inline int kunit_destroy_named_resource(struct kunit *test,
 void kunit_remove_resource(struct kunit *test, struct kunit_resource *res);
 
 /**
- * kunit_kmalloc() - Like kmalloc() except the allocation is *test managed*.
+ * kunit_kmalloc_array() - Like kmalloc_array() except the allocation is *test managed*.
  * @test: The test context object.
+ * @n: number of elements.
  * @size: The size in bytes of the desired memory.
  * @gfp: flags passed to underlying kmalloc().
  *
- * Just like `kmalloc(...)`, except the allocation is managed by the test case
+ * Just like `kmalloc_array(...)`, except the allocation is managed by the test case
  * and is automatically cleaned up after the test case concludes. See &struct
  * kunit_resource for more information.
  */
-void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp);
+void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t flags);
+
+/**
+ * kunit_kmalloc() - Like kmalloc() except the allocation is *test managed*.
+ * @test: The test context object.
+ * @size: The size in bytes of the desired memory.
+ * @gfp: flags passed to underlying kmalloc().
+ *
+ * See kmalloc() and kunit_kmalloc_array() for more information.
+ */
+static inline void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
+{
+	return kunit_kmalloc_array(test, 1, size, gfp);
+}
 
 /**
  * kunit_kfree() - Like kfree except for allocations managed by KUnit.
@@ -601,16 +640,66 @@ void kunit_kfree(struct kunit *test, const void *ptr);
  * @size: The size in bytes of the desired memory.
  * @gfp: flags passed to underlying kmalloc().
  *
- * See kzalloc() and kunit_kmalloc() for more information.
+ * See kzalloc() and kunit_kmalloc_array() for more information.
  */
 static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
 {
 	return kunit_kmalloc(test, size, gfp | __GFP_ZERO);
 }
 
+/**
+ * kunit_kcalloc() - Just like kunit_kmalloc_array(), but zeroes the allocation.
+ * @test: The test context object.
+ * @n: number of elements.
+ * @size: The size in bytes of the desired memory.
+ * @gfp: flags passed to underlying kmalloc().
+ *
+ * See kcalloc() and kunit_kmalloc_array() for more information.
+ */
+static inline void *kunit_kcalloc(struct kunit *test, size_t n, size_t size, gfp_t flags)
+{
+	return kunit_kmalloc_array(test, n, size, flags | __GFP_ZERO);
+}
+
 void kunit_cleanup(struct kunit *test);
 
-void kunit_log_append(char *log, const char *fmt, ...);
+void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
+
+/**
+ * kunit_mark_skipped() - Marks @test_or_suite as skipped
+ *
+ * @test_or_suite: The test context object.
+ * @fmt:  A printk() style format string.
+ *
+ * Marks the test as skipped. @fmt is given output as the test status
+ * comment, typically the reason the test was skipped.
+ *
+ * Test execution continues after kunit_mark_skipped() is called.
+ */
+#define kunit_mark_skipped(test_or_suite, fmt, ...)			\
+	do {								\
+		WRITE_ONCE((test_or_suite)->status, KUNIT_SKIPPED);	\
+		scnprintf((test_or_suite)->status_comment,		\
+			  KUNIT_STATUS_COMMENT_SIZE,			\
+			  fmt, ##__VA_ARGS__);				\
+	} while (0)
+
+/**
+ * kunit_skip() - Marks @test_or_suite as skipped
+ *
+ * @test_or_suite: The test context object.
+ * @fmt:  A printk() style format string.
+ *
+ * Skips the test. @fmt is given output as the test status
+ * comment, typically the reason the test was skipped.
+ *
+ * Test execution is halted after kunit_skip() is called.
+ */
+#define kunit_skip(test_or_suite, fmt, ...)				\
+	do {								\
+		kunit_mark_skipped((test_or_suite), fmt, ##__VA_ARGS__);\
+		kunit_try_catch_throw(&((test_or_suite)->try_catch));	\
+	} while (0)
 
 /*
  * printk and log to per-test or per-suite log buffer.  Logging only done
@@ -775,7 +864,6 @@ void kunit_do_assertion(struct kunit *test,
 do {									       \
 	typeof(left) __left = (left);					       \
 	typeof(right) __right = (right);				       \
-	((void)__typecheck(__left, __right));				       \
 									       \
 	KUNIT_ASSERTION(test,						       \
 			__left op __right,				       \
@@ -1129,8 +1217,8 @@ do {									       \
 				   fmt,					       \
 				   ...)					       \
 do {									       \
-	typeof(left) __left = (left);					       \
-	typeof(right) __right = (right);				       \
+	const char *__left = (left);					       \
+	const char *__right = (right);				       \
 									       \
 	KUNIT_ASSERTION(test,						       \
 			strcmp(__left, __right) op 0,			       \
diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
index ccb78509f1a8..664ded05dd7a 100644
--- a/kernel/sysctl-test.c
+++ b/kernel/sysctl-test.c
@@ -49,7 +49,7 @@ static void sysctl_test_api_dointvec_null_tbl_data(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&null_data_table,
 					       KUNIT_PROC_READ, buffer, &len,
 					       &pos));
-	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+	KUNIT_EXPECT_EQ(test, 0, len);
 
 	/*
 	 * See above.
@@ -58,7 +58,7 @@ static void sysctl_test_api_dointvec_null_tbl_data(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&null_data_table,
 					       KUNIT_PROC_WRITE, buffer, &len,
 					       &pos));
-	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+	KUNIT_EXPECT_EQ(test, 0, len);
 }
 
 /*
@@ -95,7 +95,7 @@ static void sysctl_test_api_dointvec_table_maxlen_unset(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&data_maxlen_unset_table,
 					       KUNIT_PROC_READ, buffer, &len,
 					       &pos));
-	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+	KUNIT_EXPECT_EQ(test, 0, len);
 
 	/*
 	 * See previous comment.
@@ -104,7 +104,7 @@ static void sysctl_test_api_dointvec_table_maxlen_unset(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&data_maxlen_unset_table,
 					       KUNIT_PROC_WRITE, buffer, &len,
 					       &pos));
-	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+	KUNIT_EXPECT_EQ(test, 0, len);
 }
 
 /*
@@ -135,11 +135,11 @@ static void sysctl_test_api_dointvec_table_len_is_zero(struct kunit *test)
 
 	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_READ, buffer,
 					       &len, &pos));
-	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+	KUNIT_EXPECT_EQ(test, 0, len);
 
 	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_WRITE, buffer,
 					       &len, &pos));
-	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+	KUNIT_EXPECT_EQ(test, 0, len);
 }
 
 /*
@@ -174,7 +174,7 @@ static void sysctl_test_api_dointvec_table_read_but_position_set(
 
 	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_READ, buffer,
 					       &len, &pos));
-	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+	KUNIT_EXPECT_EQ(test, 0, len);
 }
 
 /*
@@ -203,7 +203,7 @@ static void sysctl_test_dointvec_read_happy_single_positive(struct kunit *test)
 
 	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_READ,
 					       user_buffer, &len, &pos));
-	KUNIT_ASSERT_EQ(test, (size_t)3, len);
+	KUNIT_ASSERT_EQ(test, 3, len);
 	buffer[len] = '\0';
 	/* And we read 13 back out. */
 	KUNIT_EXPECT_STREQ(test, "13\n", buffer);
@@ -233,9 +233,9 @@ static void sysctl_test_dointvec_read_happy_single_negative(struct kunit *test)
 
 	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_READ,
 					       user_buffer, &len, &pos));
-	KUNIT_ASSERT_EQ(test, (size_t)4, len);
+	KUNIT_ASSERT_EQ(test, 4, len);
 	buffer[len] = '\0';
-	KUNIT_EXPECT_STREQ(test, "-16\n", (char *)buffer);
+	KUNIT_EXPECT_STREQ(test, "-16\n", buffer);
 }
 
 /*
@@ -265,7 +265,7 @@ static void sysctl_test_dointvec_write_happy_single_positive(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_WRITE,
 					       user_buffer, &len, &pos));
 	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
-	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, (size_t)pos);
+	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, pos);
 	KUNIT_EXPECT_EQ(test, 9, *((int *)table.data));
 }
 
@@ -295,7 +295,7 @@ static void sysctl_test_dointvec_write_happy_single_negative(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_WRITE,
 					       user_buffer, &len, &pos));
 	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
-	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, (size_t)pos);
+	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, pos);
 	KUNIT_EXPECT_EQ(test, -9, *((int *)table.data));
 }
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 678c13967580..5553508080db 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2047,8 +2047,9 @@ config LKDTM
 	Documentation/fault-injection/provoke-crashes.rst
 
 config TEST_LIST_SORT
-	tristate "Linked list sorting test"
-	depends on DEBUG_KERNEL || m
+	tristate "Linked list sorting test" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
 	help
 	  Enable this to turn on 'list_sort()' function test. This test is
 	  executed only once during system boot (so affects only boot time),
diff --git a/lib/cmdline_kunit.c b/lib/cmdline_kunit.c
index 018bfc8113c4..a72a2c16066e 100644
--- a/lib/cmdline_kunit.c
+++ b/lib/cmdline_kunit.c
@@ -124,7 +124,7 @@ static void cmdline_do_one_range_test(struct kunit *test, const char *in,
 			    n, e[0], r[0]);
 
 	p = memchr_inv(&r[1], 0, sizeof(r) - sizeof(r[0]));
-	KUNIT_EXPECT_PTR_EQ_MSG(test, p, (int *)0, "in test %u at %u out of bound", n, p - r);
+	KUNIT_EXPECT_PTR_EQ_MSG(test, p, NULL, "in test %u at %u out of bound", n, p - r);
 }
 
 static void cmdline_test_range(struct kunit *test)
diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index 9214c493d8b7..b71db0abc12b 100644
--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -64,7 +64,7 @@ static int debugfs_print_results(struct seq_file *seq, void *v)
 		debugfs_print_result(seq, suite, test_case);
 
 	seq_printf(seq, "%s %d - %s\n",
-		   kunit_status_to_string(success), 1, suite->name);
+		   kunit_status_to_ok_not_ok(success), 1, suite->name);
 	return 0;
 }
 
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 15832ed44668..acd1de436f59 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/reboot.h>
 #include <kunit/test.h>
 #include <linux/glob.h>
 #include <linux/moduleparam.h>
@@ -13,13 +14,17 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
 
 #if IS_BUILTIN(CONFIG_KUNIT)
 
-static char *filter_glob;
-module_param(filter_glob, charp, 0);
+static char *filter_glob_param;
+module_param_named(filter_glob, filter_glob_param, charp, 0);
 MODULE_PARM_DESC(filter_glob,
 		"Filter which KUnit test suites run at boot-time, e.g. list*");
 
+static char *kunit_shutdown;
+core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
+
 static struct kunit_suite * const *
-kunit_filter_subsuite(struct kunit_suite * const * const subsuite)
+kunit_filter_subsuite(struct kunit_suite * const * const subsuite,
+			const char *filter_glob)
 {
 	int i, n = 0;
 	struct kunit_suite **filtered;
@@ -52,19 +57,14 @@ struct suite_set {
 	struct kunit_suite * const * const *end;
 };
 
-static struct suite_set kunit_filter_suites(void)
+static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
+					    const char *filter_glob)
 {
 	int i;
 	struct kunit_suite * const **copy, * const *filtered_subsuite;
 	struct suite_set filtered;
 
-	const size_t max = __kunit_suites_end - __kunit_suites_start;
-
-	if (!filter_glob) {
-		filtered.start = __kunit_suites_start;
-		filtered.end = __kunit_suites_end;
-		return filtered;
-	}
+	const size_t max = suite_set->end - suite_set->start;
 
 	copy = kmalloc_array(max, sizeof(*filtered.start), GFP_KERNEL);
 	filtered.start = copy;
@@ -74,7 +74,7 @@ static struct suite_set kunit_filter_suites(void)
 	}
 
 	for (i = 0; i < max; ++i) {
-		filtered_subsuite = kunit_filter_subsuite(__kunit_suites_start[i]);
+		filtered_subsuite = kunit_filter_subsuite(suite_set->start[i], filter_glob);
 		if (filtered_subsuite)
 			*copy++ = filtered_subsuite;
 	}
@@ -82,6 +82,20 @@ static struct suite_set kunit_filter_suites(void)
 	return filtered;
 }
 
+static void kunit_handle_shutdown(void)
+{
+	if (!kunit_shutdown)
+		return;
+
+	if (!strcmp(kunit_shutdown, "poweroff"))
+		kernel_power_off();
+	else if (!strcmp(kunit_shutdown, "halt"))
+		kernel_halt();
+	else if (!strcmp(kunit_shutdown, "reboot"))
+		kernel_restart(NULL);
+
+}
+
 static void kunit_print_tap_header(struct suite_set *suite_set)
 {
 	struct kunit_suite * const * const *suites, * const *subsuite;
@@ -98,21 +112,32 @@ static void kunit_print_tap_header(struct suite_set *suite_set)
 int kunit_run_all_tests(void)
 {
 	struct kunit_suite * const * const *suites;
+	struct suite_set suite_set = {
+		.start = __kunit_suites_start,
+		.end = __kunit_suites_end,
+	};
 
-	struct suite_set suite_set = kunit_filter_suites();
+	if (filter_glob_param)
+		suite_set = kunit_filter_suites(&suite_set, filter_glob_param);
 
 	kunit_print_tap_header(&suite_set);
 
 	for (suites = suite_set.start; suites < suite_set.end; suites++)
 		__kunit_test_suites_init(*suites);
 
-	if (filter_glob) { /* a copy was made of each array */
+	if (filter_glob_param) { /* a copy was made of each array */
 		for (suites = suite_set.start; suites < suite_set.end; suites++)
 			kfree(*suites);
 		kfree(suite_set.start);
 	}
 
+	kunit_handle_shutdown();
+
 	return 0;
 }
 
+#if IS_BUILTIN(CONFIG_KUNIT_TEST)
+#include "executor_test.c"
+#endif
+
 #endif /* IS_BUILTIN(CONFIG_KUNIT) */
diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
new file mode 100644
index 000000000000..cdbe54b16501
--- /dev/null
+++ b/lib/kunit/executor_test.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for the KUnit executor.
+ *
+ * Copyright (C) 2021, Google LLC.
+ * Author: Daniel Latypov <dlatypov@google.com>
+ */
+
+#include <kunit/test.h>
+
+static void kfree_at_end(struct kunit *test, const void *to_free);
+static struct kunit_suite *alloc_fake_suite(struct kunit *test,
+					    const char *suite_name);
+
+static void filter_subsuite_test(struct kunit *test)
+{
+	struct kunit_suite *subsuite[3] = {NULL, NULL, NULL};
+	struct kunit_suite * const *filtered;
+
+	subsuite[0] = alloc_fake_suite(test, "suite1");
+	subsuite[1] = alloc_fake_suite(test, "suite2");
+
+	/* Want: suite1, suite2, NULL -> suite2, NULL */
+	filtered = kunit_filter_subsuite(subsuite, "suite2*");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered);
+	kfree_at_end(test, filtered);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered[0]);
+	KUNIT_EXPECT_STREQ(test, (const char *)filtered[0]->name, "suite2");
+
+	KUNIT_EXPECT_FALSE(test, filtered[1]);
+}
+
+static void filter_subsuite_to_empty_test(struct kunit *test)
+{
+	struct kunit_suite *subsuite[3] = {NULL, NULL, NULL};
+	struct kunit_suite * const *filtered;
+
+	subsuite[0] = alloc_fake_suite(test, "suite1");
+	subsuite[1] = alloc_fake_suite(test, "suite2");
+
+	filtered = kunit_filter_subsuite(subsuite, "not_found");
+	kfree_at_end(test, filtered); /* just in case */
+
+	KUNIT_EXPECT_FALSE_MSG(test, filtered,
+			       "should be NULL to indicate no match");
+}
+
+static void kfree_subsuites_at_end(struct kunit *test, struct suite_set *suite_set)
+{
+	struct kunit_suite * const * const *suites;
+
+	kfree_at_end(test, suite_set->start);
+	for (suites = suite_set->start; suites < suite_set->end; suites++)
+		kfree_at_end(test, *suites);
+}
+
+static void filter_suites_test(struct kunit *test)
+{
+	/* Suites per-file are stored as a NULL terminated array */
+	struct kunit_suite *subsuites[2][2] = {
+		{NULL, NULL},
+		{NULL, NULL},
+	};
+	/* Match the memory layout of suite_set */
+	struct kunit_suite * const * const suites[2] = {
+		subsuites[0], subsuites[1],
+	};
+
+	const struct suite_set suite_set = {
+		.start = suites,
+		.end = suites + 2,
+	};
+	struct suite_set filtered = {.start = NULL, .end = NULL};
+
+	/* Emulate two files, each having one suite */
+	subsuites[0][0] = alloc_fake_suite(test, "suite0");
+	subsuites[1][0] = alloc_fake_suite(test, "suite1");
+
+	/* Filter out suite1 */
+	filtered = kunit_filter_suites(&suite_set, "suite0");
+	kfree_subsuites_at_end(test, &filtered); /* let us use ASSERTs without leaking */
+	KUNIT_ASSERT_EQ(test, filtered.end - filtered.start, (ptrdiff_t)1);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start[0]);
+	KUNIT_EXPECT_STREQ(test, (const char *)filtered.start[0][0]->name, "suite0");
+}
+
+static struct kunit_case executor_test_cases[] = {
+	KUNIT_CASE(filter_subsuite_test),
+	KUNIT_CASE(filter_subsuite_to_empty_test),
+	KUNIT_CASE(filter_suites_test),
+	{}
+};
+
+static struct kunit_suite executor_test_suite = {
+	.name = "kunit_executor_test",
+	.test_cases = executor_test_cases,
+};
+
+kunit_test_suites(&executor_test_suite);
+
+/* Test helpers */
+
+static void kfree_res_free(struct kunit_resource *res)
+{
+	kfree(res->data);
+}
+
+/* Use the resource API to register a call to kfree(to_free).
+ * Since we never actually use the resource, it's safe to use on const data.
+ */
+static void kfree_at_end(struct kunit *test, const void *to_free)
+{
+	/* kfree() handles NULL already, but avoid allocating a no-op cleanup. */
+	if (IS_ERR_OR_NULL(to_free))
+		return;
+	kunit_alloc_and_get_resource(test, NULL, kfree_res_free, GFP_KERNEL,
+				     (void *)to_free);
+}
+
+static struct kunit_suite *alloc_fake_suite(struct kunit *test,
+					    const char *suite_name)
+{
+	struct kunit_suite *suite;
+
+	/* We normally never expect to allocate suites, hence the non-const cast. */
+	suite = kunit_kzalloc(test, sizeof(*suite), GFP_KERNEL);
+	strncpy((char *)suite->name, suite_name, sizeof(suite->name) - 1);
+
+	return suite;
+}
diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index be1164ecc476..51099b0ca29c 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -40,6 +40,35 @@ static int example_test_init(struct kunit *test)
 	return 0;
 }
 
+/*
+ * This test should always be skipped.
+ */
+static void example_skip_test(struct kunit *test)
+{
+	/* This line should run */
+	kunit_info(test, "You should not see a line below.");
+
+	/* Skip (and abort) the test */
+	kunit_skip(test, "this test should be skipped");
+
+	/* This line should not execute */
+	KUNIT_FAIL(test, "You should not see this line.");
+}
+
+/*
+ * This test should always be marked skipped.
+ */
+static void example_mark_skipped_test(struct kunit *test)
+{
+	/* This line should run */
+	kunit_info(test, "You should see a line below.");
+
+	/* Skip (but do not abort) the test */
+	kunit_mark_skipped(test, "this test should be skipped");
+
+	/* This line should run */
+	kunit_info(test, "You should see this line.");
+}
 /*
  * Here we make a list of all the test cases we want to add to the test suite
  * below.
@@ -52,6 +81,8 @@ static struct kunit_case example_test_cases[] = {
 	 * test suite.
 	 */
 	KUNIT_CASE(example_simple_test),
+	KUNIT_CASE(example_skip_test),
+	KUNIT_CASE(example_mark_skipped_test),
 	{}
 };
 
diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 69f902440a0e..d69efcbed624 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -437,7 +437,47 @@ static void kunit_log_test(struct kunit *test)
 #endif
 }
 
+static void kunit_status_set_failure_test(struct kunit *test)
+{
+	struct kunit fake;
+
+	kunit_init_test(&fake, "fake test", NULL);
+
+	KUNIT_EXPECT_EQ(test, fake.status, (enum kunit_status)KUNIT_SUCCESS);
+	kunit_set_failure(&fake);
+	KUNIT_EXPECT_EQ(test, fake.status, (enum kunit_status)KUNIT_FAILURE);
+}
+
+static void kunit_status_mark_skipped_test(struct kunit *test)
+{
+	struct kunit fake;
+
+	kunit_init_test(&fake, "fake test", NULL);
+
+	/* Before: Should be SUCCESS with no comment. */
+	KUNIT_EXPECT_EQ(test, fake.status, KUNIT_SUCCESS);
+	KUNIT_EXPECT_STREQ(test, fake.status_comment, "");
+
+	/* Mark the test as skipped. */
+	kunit_mark_skipped(&fake, "Accepts format string: %s", "YES");
+
+	/* After: Should be SKIPPED with our comment. */
+	KUNIT_EXPECT_EQ(test, fake.status, (enum kunit_status)KUNIT_SKIPPED);
+	KUNIT_EXPECT_STREQ(test, fake.status_comment, "Accepts format string: YES");
+}
+
+static struct kunit_case kunit_status_test_cases[] = {
+	KUNIT_CASE(kunit_status_set_failure_test),
+	KUNIT_CASE(kunit_status_mark_skipped_test),
+	{}
+};
+
+static struct kunit_suite kunit_status_test_suite = {
+	.name = "kunit_status",
+	.test_cases = kunit_status_test_cases,
+};
+
 kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite,
-		  &kunit_log_test_suite);
+		  &kunit_log_test_suite, &kunit_status_test_suite);
 
 MODULE_LICENSE("GPL v2");
diff --git a/lib/kunit/string-stream.h b/lib/kunit/string-stream.h
index fe98a00b75a9..5e94b623454f 100644
--- a/lib/kunit/string-stream.h
+++ b/lib/kunit/string-stream.h
@@ -35,9 +35,9 @@ struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp);
 int __printf(2, 3) string_stream_add(struct string_stream *stream,
 				     const char *fmt, ...);
 
-int string_stream_vadd(struct string_stream *stream,
-		       const char *fmt,
-		       va_list args);
+int __printf(2, 0) string_stream_vadd(struct string_stream *stream,
+				      const char *fmt,
+				      va_list args);
 
 char *string_stream_get_string(struct string_stream *stream);
 
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 2f6cc0123232..b3d0c8e4e339 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -98,12 +98,14 @@ static void kunit_print_subtest_start(struct kunit_suite *suite)
 
 static void kunit_print_ok_not_ok(void *test_or_suite,
 				  bool is_test,
-				  bool is_ok,
+				  enum kunit_status status,
 				  size_t test_number,
-				  const char *description)
+				  const char *description,
+				  const char *directive)
 {
 	struct kunit_suite *suite = is_test ? NULL : test_or_suite;
 	struct kunit *test = is_test ? test_or_suite : NULL;
+	const char *directive_header = (status == KUNIT_SKIPPED) ? " # SKIP " : "";
 
 	/*
 	 * We do not log the test suite results as doing so would
@@ -114,25 +116,31 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
 	 * representation.
 	 */
 	if (suite)
-		pr_info("%s %zd - %s\n",
-			kunit_status_to_string(is_ok),
-			test_number, description);
+		pr_info("%s %zd - %s%s%s\n",
+			kunit_status_to_ok_not_ok(status),
+			test_number, description, directive_header,
+			(status == KUNIT_SKIPPED) ? directive : "");
 	else
-		kunit_log(KERN_INFO, test, KUNIT_SUBTEST_INDENT "%s %zd - %s",
-			  kunit_status_to_string(is_ok),
-			  test_number, description);
+		kunit_log(KERN_INFO, test,
+			  KUNIT_SUBTEST_INDENT "%s %zd - %s%s%s",
+			  kunit_status_to_ok_not_ok(status),
+			  test_number, description, directive_header,
+			  (status == KUNIT_SKIPPED) ? directive : "");
 }
 
-bool kunit_suite_has_succeeded(struct kunit_suite *suite)
+enum kunit_status kunit_suite_has_succeeded(struct kunit_suite *suite)
 {
 	const struct kunit_case *test_case;
+	enum kunit_status status = KUNIT_SKIPPED;
 
 	kunit_suite_for_each_test_case(suite, test_case) {
-		if (!test_case->success)
-			return false;
+		if (test_case->status == KUNIT_FAILURE)
+			return KUNIT_FAILURE;
+		else if (test_case->status == KUNIT_SUCCESS)
+			status = KUNIT_SUCCESS;
 	}
 
-	return true;
+	return status;
 }
 EXPORT_SYMBOL_GPL(kunit_suite_has_succeeded);
 
@@ -143,7 +151,8 @@ static void kunit_print_subtest_end(struct kunit_suite *suite)
 	kunit_print_ok_not_ok((void *)suite, false,
 			      kunit_suite_has_succeeded(suite),
 			      kunit_suite_counter++,
-			      suite->name);
+			      suite->name,
+			      suite->status_comment);
 }
 
 unsigned int kunit_test_case_num(struct kunit_suite *suite,
@@ -252,7 +261,8 @@ void kunit_init_test(struct kunit *test, const char *name, char *log)
 	test->log = log;
 	if (test->log)
 		test->log[0] = '\0';
-	test->success = true;
+	test->status = KUNIT_SUCCESS;
+	test->status_comment[0] = '\0';
 }
 EXPORT_SYMBOL_GPL(kunit_init_test);
 
@@ -376,7 +386,11 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
 	context.test_case = test_case;
 	kunit_try_catch_run(try_catch, &context);
 
-	test_case->success = test->success;
+	/* Propagate the parameter result to the test case. */
+	if (test->status == KUNIT_FAILURE)
+		test_case->status = KUNIT_FAILURE;
+	else if (test_case->status != KUNIT_FAILURE && test->status == KUNIT_SUCCESS)
+		test_case->status = KUNIT_SUCCESS;
 }
 
 int kunit_run_tests(struct kunit_suite *suite)
@@ -388,7 +402,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 
 	kunit_suite_for_each_test_case(suite, test_case) {
 		struct kunit test = { .param_value = NULL, .param_index = 0 };
-		bool test_success = true;
+		test_case->status = KUNIT_SKIPPED;
 
 		if (test_case->generate_params) {
 			/* Get initial param. */
@@ -398,7 +412,6 @@ int kunit_run_tests(struct kunit_suite *suite)
 
 		do {
 			kunit_run_case_catch_errors(suite, test_case, &test);
-			test_success &= test_case->success;
 
 			if (test_case->generate_params) {
 				if (param_desc[0] == '\0') {
@@ -410,7 +423,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 					  KUNIT_SUBTEST_INDENT
 					  "# %s: %s %d - %s",
 					  test_case->name,
-					  kunit_status_to_string(test.success),
+					  kunit_status_to_ok_not_ok(test.status),
 					  test.param_index + 1, param_desc);
 
 				/* Get next param. */
@@ -420,9 +433,10 @@ int kunit_run_tests(struct kunit_suite *suite)
 			}
 		} while (test.param_value);
 
-		kunit_print_ok_not_ok(&test, true, test_success,
+		kunit_print_ok_not_ok(&test, true, test_case->status,
 				      kunit_test_case_num(suite, test_case),
-				      test_case->name);
+				      test_case->name,
+				      test.status_comment);
 	}
 
 	kunit_print_subtest_end(suite);
@@ -434,6 +448,7 @@ EXPORT_SYMBOL_GPL(kunit_run_tests);
 static void kunit_init_suite(struct kunit_suite *suite)
 {
 	kunit_debugfs_create_suite(suite);
+	suite->status_comment[0] = '\0';
 }
 
 int __kunit_test_suites_init(struct kunit_suite * const * const suites)
@@ -573,41 +588,43 @@ int kunit_destroy_resource(struct kunit *test, kunit_resource_match_t match,
 }
 EXPORT_SYMBOL_GPL(kunit_destroy_resource);
 
-struct kunit_kmalloc_params {
+struct kunit_kmalloc_array_params {
+	size_t n;
 	size_t size;
 	gfp_t gfp;
 };
 
-static int kunit_kmalloc_init(struct kunit_resource *res, void *context)
+static int kunit_kmalloc_array_init(struct kunit_resource *res, void *context)
 {
-	struct kunit_kmalloc_params *params = context;
+	struct kunit_kmalloc_array_params *params = context;
 
-	res->data = kmalloc(params->size, params->gfp);
+	res->data = kmalloc_array(params->n, params->size, params->gfp);
 	if (!res->data)
 		return -ENOMEM;
 
 	return 0;
 }
 
-static void kunit_kmalloc_free(struct kunit_resource *res)
+static void kunit_kmalloc_array_free(struct kunit_resource *res)
 {
 	kfree(res->data);
 }
 
-void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
+void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t gfp)
 {
-	struct kunit_kmalloc_params params = {
+	struct kunit_kmalloc_array_params params = {
 		.size = size,
+		.n = n,
 		.gfp = gfp
 	};
 
 	return kunit_alloc_resource(test,
-				    kunit_kmalloc_init,
-				    kunit_kmalloc_free,
+				    kunit_kmalloc_array_init,
+				    kunit_kmalloc_array_free,
 				    gfp,
 				    &params);
 }
-EXPORT_SYMBOL_GPL(kunit_kmalloc);
+EXPORT_SYMBOL_GPL(kunit_kmalloc_array);
 
 void kunit_kfree(struct kunit *test, const void *ptr)
 {
diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index cacbbbdef768..0a2029d14c91 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -111,17 +111,13 @@ static void kasan_test_exit(struct kunit *test)
 } while (0)
 
 #define KASAN_TEST_NEEDS_CONFIG_ON(test, config) do {			\
-	if (!IS_ENABLED(config)) {					\
-		kunit_info((test), "skipping, " #config " required");	\
-		return;							\
-	}								\
+	if (!IS_ENABLED(config))					\
+		kunit_skip((test), "Test requires " #config "=y");	\
 } while (0)
 
 #define KASAN_TEST_NEEDS_CONFIG_OFF(test, config) do {			\
-	if (IS_ENABLED(config)) {					\
-		kunit_info((test), "skipping, " #config " enabled");	\
-		return;							\
-	}								\
+	if (IS_ENABLED(config))						\
+		kunit_skip((test), "Test requires " #config "=n");	\
 } while (0)
 
 static void kmalloc_oob_right(struct kunit *test)
diff --git a/lib/test_list_sort.c b/lib/test_list_sort.c
index 00daaf23316f..ade7a1ea0c8e 100644
--- a/lib/test_list_sort.c
+++ b/lib/test_list_sort.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#define pr_fmt(fmt) "list_sort_test: " fmt
+#include <kunit/test.h>
 
 #include <linux/kernel.h>
 #include <linux/list_sort.h>
@@ -23,68 +23,52 @@ struct debug_el {
 	struct list_head list;
 	unsigned int poison2;
 	int value;
-	unsigned serial;
+	unsigned int serial;
 };
 
-/* Array, containing pointers to all elements in the test list */
-static struct debug_el **elts __initdata;
-
-static int __init check(struct debug_el *ela, struct debug_el *elb)
+static void check(struct kunit *test, struct debug_el *ela, struct debug_el *elb)
 {
-	if (ela->serial >= TEST_LIST_LEN) {
-		pr_err("error: incorrect serial %d\n", ela->serial);
-		return -EINVAL;
-	}
-	if (elb->serial >= TEST_LIST_LEN) {
-		pr_err("error: incorrect serial %d\n", elb->serial);
-		return -EINVAL;
-	}
-	if (elts[ela->serial] != ela || elts[elb->serial] != elb) {
-		pr_err("error: phantom element\n");
-		return -EINVAL;
-	}
-	if (ela->poison1 != TEST_POISON1 || ela->poison2 != TEST_POISON2) {
-		pr_err("error: bad poison: %#x/%#x\n",
-			ela->poison1, ela->poison2);
-		return -EINVAL;
-	}
-	if (elb->poison1 != TEST_POISON1 || elb->poison2 != TEST_POISON2) {
-		pr_err("error: bad poison: %#x/%#x\n",
-			elb->poison1, elb->poison2);
-		return -EINVAL;
-	}
-	return 0;
+	struct debug_el **elts = test->priv;
+
+	KUNIT_EXPECT_LT_MSG(test, ela->serial, (unsigned int)TEST_LIST_LEN, "incorrect serial");
+	KUNIT_EXPECT_LT_MSG(test, elb->serial, (unsigned int)TEST_LIST_LEN, "incorrect serial");
+
+	KUNIT_EXPECT_PTR_EQ_MSG(test, elts[ela->serial], ela, "phantom element");
+	KUNIT_EXPECT_PTR_EQ_MSG(test, elts[elb->serial], elb, "phantom element");
+
+	KUNIT_EXPECT_EQ_MSG(test, ela->poison1, TEST_POISON1, "bad poison");
+	KUNIT_EXPECT_EQ_MSG(test, ela->poison2, TEST_POISON2, "bad poison");
+
+	KUNIT_EXPECT_EQ_MSG(test, elb->poison1, TEST_POISON1, "bad poison");
+	KUNIT_EXPECT_EQ_MSG(test, elb->poison2, TEST_POISON2, "bad poison");
 }
 
-static int __init cmp(void *priv, const struct list_head *a,
-		      const struct list_head *b)
+/* `priv` is the test pointer so check() can fail the test if the list is invalid. */
+static int cmp(void *priv, const struct list_head *a, const struct list_head *b)
 {
 	struct debug_el *ela, *elb;
 
 	ela = container_of(a, struct debug_el, list);
 	elb = container_of(b, struct debug_el, list);
 
-	check(ela, elb);
+	check(priv, ela, elb);
 	return ela->value - elb->value;
 }
 
-static int __init list_sort_test(void)
+static void list_sort_test(struct kunit *test)
 {
-	int i, count = 1, err = -ENOMEM;
-	struct debug_el *el;
+	int i, count = 1;
+	struct debug_el *el, **elts;
 	struct list_head *cur;
 	LIST_HEAD(head);
 
-	pr_debug("start testing list_sort()\n");
-
-	elts = kcalloc(TEST_LIST_LEN, sizeof(*elts), GFP_KERNEL);
-	if (!elts)
-		return err;
+	elts = kunit_kcalloc(test, TEST_LIST_LEN, sizeof(*elts), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, elts);
+	test->priv = elts;
 
 	for (i = 0; i < TEST_LIST_LEN; i++) {
-		el = kmalloc(sizeof(*el), GFP_KERNEL);
-		if (!el)
-			goto exit;
+		el = kunit_kmalloc(test, sizeof(*el), GFP_KERNEL);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, el);
 
 		 /* force some equivalencies */
 		el->value = prandom_u32() % (TEST_LIST_LEN / 3);
@@ -95,55 +79,44 @@ static int __init list_sort_test(void)
 		list_add_tail(&el->list, &head);
 	}
 
-	list_sort(NULL, &head, cmp);
+	list_sort(test, &head, cmp);
 
-	err = -EINVAL;
 	for (cur = head.next; cur->next != &head; cur = cur->next) {
 		struct debug_el *el1;
 		int cmp_result;
 
-		if (cur->next->prev != cur) {
-			pr_err("error: list is corrupted\n");
-			goto exit;
-		}
+		KUNIT_ASSERT_PTR_EQ_MSG(test, cur->next->prev, cur,
+					"list is corrupted");
 
-		cmp_result = cmp(NULL, cur, cur->next);
-		if (cmp_result > 0) {
-			pr_err("error: list is not sorted\n");
-			goto exit;
-		}
+		cmp_result = cmp(test, cur, cur->next);
+		KUNIT_ASSERT_LE_MSG(test, cmp_result, 0, "list is not sorted");
 
 		el = container_of(cur, struct debug_el, list);
 		el1 = container_of(cur->next, struct debug_el, list);
-		if (cmp_result == 0 && el->serial >= el1->serial) {
-			pr_err("error: order of equivalent elements not "
-				"preserved\n");
-			goto exit;
+		if (cmp_result == 0) {
+			KUNIT_ASSERT_LE_MSG(test, el->serial, el1->serial,
+					    "order of equivalent elements not preserved");
 		}
 
-		if (check(el, el1)) {
-			pr_err("error: element check failed\n");
-			goto exit;
-		}
+		check(test, el, el1);
 		count++;
 	}
-	if (head.prev != cur) {
-		pr_err("error: list is corrupted\n");
-		goto exit;
-	}
+	KUNIT_EXPECT_PTR_EQ_MSG(test, head.prev, cur, "list is corrupted");
 
+	KUNIT_EXPECT_EQ_MSG(test, count, TEST_LIST_LEN,
+			    "list length changed after sorting!");
+}
 
-	if (count != TEST_LIST_LEN) {
-		pr_err("error: bad list length %d", count);
-		goto exit;
-	}
+static struct kunit_case list_sort_cases[] = {
+	KUNIT_CASE(list_sort_test),
+	{}
+};
+
+static struct kunit_suite list_sort_suite = {
+	.name = "list_sort",
+	.test_cases = list_sort_cases,
+};
+
+kunit_test_suites(&list_sort_suite);
 
-	err = 0;
-exit:
-	for (i = 0; i < TEST_LIST_LEN; i++)
-		kfree(elts[i]);
-	kfree(elts);
-	return err;
-}
-module_init(list_sort_test);
 MODULE_LICENSE("GPL");
diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
deleted file mode 100644
index 9235b7d42d38..000000000000
--- a/tools/testing/kunit/configs/all_tests.config
+++ /dev/null
@@ -1,3 +0,0 @@
-CONFIG_KUNIT=y
-CONFIG_KUNIT_TEST=y
-CONFIG_KUNIT_EXAMPLE_TEST=y
diff --git a/arch/um/configs/kunit_defconfig b/tools/testing/kunit/configs/default.config
similarity index 63%
rename from arch/um/configs/kunit_defconfig
rename to tools/testing/kunit/configs/default.config
index 9235b7d42d38..e67af7b9f1bb 100644
--- a/arch/um/configs/kunit_defconfig
+++ b/tools/testing/kunit/configs/default.config
@@ -1,3 +1,3 @@
 CONFIG_KUNIT=y
-CONFIG_KUNIT_TEST=y
 CONFIG_KUNIT_EXAMPLE_TEST=y
+CONFIG_KUNIT_ALL_TESTS=y
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 5da8fb3762f9..be8d8d4a4e08 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -70,10 +70,10 @@ def build_tests(linux: kunit_kernel.LinuxSourceTree,
 	kunit_parser.print_with_timestamp('Building KUnit Kernel ...')
 
 	build_start = time.time()
-	success = linux.build_um_kernel(request.alltests,
-					request.jobs,
-					request.build_dir,
-					request.make_options)
+	success = linux.build_kernel(request.alltests,
+				     request.jobs,
+				     request.build_dir,
+				     request.make_options)
 	build_end = time.time()
 	if not success:
 		return KunitResult(KunitStatus.BUILD_FAILURE,
@@ -189,6 +189,31 @@ def add_common_opts(parser) -> None:
 			     'will get  automatically appended.',
 			     metavar='kunitconfig')
 
+	parser.add_argument('--arch',
+			    help=('Specifies the architecture to run tests under. '
+				  'The architecture specified here must match the '
+				  'string passed to the ARCH make param, '
+				  'e.g. i386, x86_64, arm, um, etc. Non-UML '
+				  'architectures run on QEMU.'),
+			    type=str, default='um', metavar='arch')
+
+	parser.add_argument('--cross_compile',
+			    help=('Sets make\'s CROSS_COMPILE variable; it should '
+				  'be set to a toolchain path prefix (the prefix '
+				  'of gcc and other tools in your toolchain, for '
+				  'example `sparc64-linux-gnu-` if you have the '
+				  'sparc toolchain installed on your system, or '
+				  '`$HOME/toolchains/microblaze/gcc-9.2.0-nolibc/microblaze-linux/bin/microblaze-linux-` '
+				  'if you have downloaded the microblaze toolchain '
+				  'from the 0-day website to a directory in your '
+				  'home directory called `toolchains`).'),
+			    metavar='cross_compile')
+
+	parser.add_argument('--qemu_config',
+			    help=('Takes a path to a path to a file containing '
+				  'a QemuArchParams object.'),
+			    type=str, metavar='qemu_config')
+
 def add_build_opts(parser) -> None:
 	parser.add_argument('--jobs',
 			    help='As in the make command, "Specifies  the number of '
@@ -270,7 +295,11 @@ def main(argv, linux=None):
 			os.mkdir(cli_args.build_dir)
 
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir, kunitconfig_path=cli_args.kunitconfig)
+			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
+					kunitconfig_path=cli_args.kunitconfig,
+					arch=cli_args.arch,
+					cross_compile=cli_args.cross_compile,
+					qemu_config_path=cli_args.qemu_config)
 
 		request = KunitRequest(cli_args.raw_output,
 				       cli_args.timeout,
@@ -289,7 +318,11 @@ def main(argv, linux=None):
 			os.mkdir(cli_args.build_dir)
 
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir, kunitconfig_path=cli_args.kunitconfig)
+			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
+					kunitconfig_path=cli_args.kunitconfig,
+					arch=cli_args.arch,
+					cross_compile=cli_args.cross_compile,
+					qemu_config_path=cli_args.qemu_config)
 
 		request = KunitConfigRequest(cli_args.build_dir,
 					     cli_args.make_options)
@@ -301,7 +334,11 @@ def main(argv, linux=None):
 			sys.exit(1)
 	elif cli_args.subcommand == 'build':
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir, kunitconfig_path=cli_args.kunitconfig)
+			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
+					kunitconfig_path=cli_args.kunitconfig,
+					arch=cli_args.arch,
+					cross_compile=cli_args.cross_compile,
+					qemu_config_path=cli_args.qemu_config)
 
 		request = KunitBuildRequest(cli_args.jobs,
 					    cli_args.build_dir,
@@ -315,7 +352,11 @@ def main(argv, linux=None):
 			sys.exit(1)
 	elif cli_args.subcommand == 'exec':
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
+			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
+					kunitconfig_path=cli_args.kunitconfig,
+					arch=cli_args.arch,
+					cross_compile=cli_args.cross_compile,
+					qemu_config_path=cli_args.qemu_config)
 
 		exec_request = KunitExecRequest(cli_args.timeout,
 						cli_args.build_dir,
diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
index 1e2683dcc0e7..c77c7d2ef622 100644
--- a/tools/testing/kunit/kunit_config.py
+++ b/tools/testing/kunit/kunit_config.py
@@ -52,8 +52,13 @@ class Kconfig(object):
 				return False
 		return True
 
+	def merge_in_entries(self, other: 'Kconfig') -> None:
+		if other.is_subset_of(self):
+			return
+		self._entries = list(self.entries().union(other.entries()))
+
 	def write_to_file(self, path: str) -> None:
-		with open(path, 'w') as f:
+		with open(path, 'a+') as f:
 			for entry in self.entries():
 				f.write(str(entry) + '\n')
 
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 89a7d4024e87..90bc007f1f93 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -6,23 +6,31 @@
 # Author: Felix Guo <felixguoxiuping@gmail.com>
 # Author: Brendan Higgins <brendanhiggins@google.com>
 
+from __future__ import annotations
+import importlib.util
 import logging
 import subprocess
 import os
 import shutil
 import signal
 from typing import Iterator
+from typing import Optional
 
 from contextlib import ExitStack
 
+from collections import namedtuple
+
 import kunit_config
 import kunit_parser
+import qemu_config
 
 KCONFIG_PATH = '.config'
 KUNITCONFIG_PATH = '.kunitconfig'
-DEFAULT_KUNITCONFIG_PATH = 'arch/um/configs/kunit_defconfig'
+DEFAULT_KUNITCONFIG_PATH = 'tools/testing/kunit/configs/default.config'
 BROKEN_ALLCONFIG_PATH = 'tools/testing/kunit/configs/broken_on_uml.config'
 OUTFILE_PATH = 'test.log'
+ABS_TOOL_PATH = os.path.abspath(os.path.dirname(__file__))
+QEMU_CONFIGS_DIR = os.path.join(ABS_TOOL_PATH, 'qemu_configs')
 
 def get_file_path(build_dir, default):
 	if build_dir:
@@ -40,6 +48,10 @@ class BuildError(Exception):
 class LinuxSourceTreeOperations(object):
 	"""An abstraction over command line operations performed on a source tree."""
 
+	def __init__(self, linux_arch: str, cross_compile: Optional[str]):
+		self._linux_arch = linux_arch
+		self._cross_compile = cross_compile
+
 	def make_mrproper(self) -> None:
 		try:
 			subprocess.check_output(['make', 'mrproper'], stderr=subprocess.STDOUT)
@@ -48,12 +60,21 @@ class LinuxSourceTreeOperations(object):
 		except subprocess.CalledProcessError as e:
 			raise ConfigError(e.output.decode())
 
+	def make_arch_qemuconfig(self, kconfig: kunit_config.Kconfig) -> None:
+		pass
+
+	def make_allyesconfig(self, build_dir, make_options) -> None:
+		raise ConfigError('Only the "um" arch is supported for alltests')
+
 	def make_olddefconfig(self, build_dir, make_options) -> None:
-		command = ['make', 'ARCH=um', 'olddefconfig']
+		command = ['make', 'ARCH=' + self._linux_arch, 'olddefconfig']
+		if self._cross_compile:
+			command += ['CROSS_COMPILE=' + self._cross_compile]
 		if make_options:
 			command.extend(make_options)
 		if build_dir:
 			command += ['O=' + build_dir]
+		print('Populating config with:\n$', ' '.join(command))
 		try:
 			subprocess.check_output(command, stderr=subprocess.STDOUT)
 		except OSError as e:
@@ -61,6 +82,79 @@ class LinuxSourceTreeOperations(object):
 		except subprocess.CalledProcessError as e:
 			raise ConfigError(e.output.decode())
 
+	def make(self, jobs, build_dir, make_options) -> None:
+		command = ['make', 'ARCH=' + self._linux_arch, '--jobs=' + str(jobs)]
+		if make_options:
+			command.extend(make_options)
+		if self._cross_compile:
+			command += ['CROSS_COMPILE=' + self._cross_compile]
+		if build_dir:
+			command += ['O=' + build_dir]
+		print('Building with:\n$', ' '.join(command))
+		try:
+			proc = subprocess.Popen(command,
+						stderr=subprocess.PIPE,
+						stdout=subprocess.DEVNULL)
+		except OSError as e:
+			raise BuildError('Could not call execute make: ' + str(e))
+		except subprocess.CalledProcessError as e:
+			raise BuildError(e.output)
+		_, stderr = proc.communicate()
+		if proc.returncode != 0:
+			raise BuildError(stderr.decode())
+		if stderr:  # likely only due to build warnings
+			print(stderr.decode())
+
+	def run(self, params, timeout, build_dir, outfile) -> None:
+		pass
+
+
+class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
+
+	def __init__(self, qemu_arch_params: qemu_config.QemuArchParams, cross_compile: Optional[str]):
+		super().__init__(linux_arch=qemu_arch_params.linux_arch,
+				 cross_compile=cross_compile)
+		self._kconfig = qemu_arch_params.kconfig
+		self._qemu_arch = qemu_arch_params.qemu_arch
+		self._kernel_path = qemu_arch_params.kernel_path
+		self._kernel_command_line = qemu_arch_params.kernel_command_line + ' kunit_shutdown=reboot'
+		self._extra_qemu_params = qemu_arch_params.extra_qemu_params
+
+	def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) -> None:
+		kconfig = kunit_config.Kconfig()
+		kconfig.parse_from_string(self._kconfig)
+		base_kunitconfig.merge_in_entries(kconfig)
+
+	def run(self, params, timeout, build_dir, outfile):
+		kernel_path = os.path.join(build_dir, self._kernel_path)
+		qemu_command = ['qemu-system-' + self._qemu_arch,
+				'-nodefaults',
+				'-m', '1024',
+				'-kernel', kernel_path,
+				'-append', '\'' + ' '.join(params + [self._kernel_command_line]) + '\'',
+				'-no-reboot',
+				'-nographic',
+				'-serial stdio'] + self._extra_qemu_params
+		print('Running tests with:\n$', ' '.join(qemu_command))
+		with open(outfile, 'w') as output:
+			process = subprocess.Popen(' '.join(qemu_command),
+						   stdin=subprocess.PIPE,
+						   stdout=output,
+						   stderr=subprocess.STDOUT,
+						   text=True, shell=True)
+		try:
+			process.wait(timeout=timeout)
+		except Exception as e:
+			print(e)
+			process.terminate()
+		return process
+
+class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
+	"""An abstraction over command line operations performed on a source tree."""
+
+	def __init__(self, cross_compile=None):
+		super().__init__(linux_arch='um', cross_compile=cross_compile)
+
 	def make_allyesconfig(self, build_dir, make_options) -> None:
 		kunit_parser.print_with_timestamp(
 			'Enabling all CONFIGs for UML...')
@@ -83,32 +177,16 @@ class LinuxSourceTreeOperations(object):
 		kunit_parser.print_with_timestamp(
 			'Starting Kernel with all configs takes a few minutes...')
 
-	def make(self, jobs, build_dir, make_options) -> None:
-		command = ['make', 'ARCH=um', '--jobs=' + str(jobs)]
-		if make_options:
-			command.extend(make_options)
-		if build_dir:
-			command += ['O=' + build_dir]
-		try:
-			proc = subprocess.Popen(command,
-						stderr=subprocess.PIPE,
-						stdout=subprocess.DEVNULL)
-		except OSError as e:
-			raise BuildError('Could not call make command: ' + str(e))
-		_, stderr = proc.communicate()
-		if proc.returncode != 0:
-			raise BuildError(stderr.decode())
-		if stderr:  # likely only due to build warnings
-			print(stderr.decode())
-
-	def linux_bin(self, params, timeout, build_dir) -> None:
+	def run(self, params, timeout, build_dir, outfile):
 		"""Runs the Linux UML binary. Must be named 'linux'."""
 		linux_bin = get_file_path(build_dir, 'linux')
 		outfile = get_outfile_path(build_dir)
 		with open(outfile, 'w') as output:
 			process = subprocess.Popen([linux_bin] + params,
+						   stdin=subprocess.PIPE,
 						   stdout=output,
-						   stderr=subprocess.STDOUT)
+						   stderr=subprocess.STDOUT,
+						   text=True)
 			process.wait(timeout)
 
 def get_kconfig_path(build_dir) -> str:
@@ -120,13 +198,54 @@ def get_kunitconfig_path(build_dir) -> str:
 def get_outfile_path(build_dir) -> str:
 	return get_file_path(build_dir, OUTFILE_PATH)
 
+def get_source_tree_ops(arch: str, cross_compile: Optional[str]) -> LinuxSourceTreeOperations:
+	config_path = os.path.join(QEMU_CONFIGS_DIR, arch + '.py')
+	if arch == 'um':
+		return LinuxSourceTreeOperationsUml(cross_compile=cross_compile)
+	elif os.path.isfile(config_path):
+		return get_source_tree_ops_from_qemu_config(config_path, cross_compile)[1]
+	else:
+		raise ConfigError(arch + ' is not a valid arch')
+
+def get_source_tree_ops_from_qemu_config(config_path: str,
+					 cross_compile: Optional[str]) -> tuple[
+							 str, LinuxSourceTreeOperations]:
+	# The module name/path has very little to do with where the actual file
+	# exists (I learned this through experimentation and could not find it
+	# anywhere in the Python documentation).
+	#
+	# Bascially, we completely ignore the actual file location of the config
+	# we are loading and just tell Python that the module lives in the
+	# QEMU_CONFIGS_DIR for import purposes regardless of where it actually
+	# exists as a file.
+	module_path = '.' + os.path.join(os.path.basename(QEMU_CONFIGS_DIR), os.path.basename(config_path))
+	spec = importlib.util.spec_from_file_location(module_path, config_path)
+	config = importlib.util.module_from_spec(spec)
+	# TODO(brendanhiggins@google.com): I looked this up and apparently other
+	# Python projects have noted that pytype complains that "No attribute
+	# 'exec_module' on _importlib_modulespec._Loader". Disabling for now.
+	spec.loader.exec_module(config) # pytype: disable=attribute-error
+	return config.QEMU_ARCH.linux_arch, LinuxSourceTreeOperationsQemu(
+			config.QEMU_ARCH, cross_compile=cross_compile)
+
 class LinuxSourceTree(object):
 	"""Represents a Linux kernel source tree with KUnit tests."""
 
-	def __init__(self, build_dir: str, load_config=True, kunitconfig_path='') -> None:
+	def __init__(
+	      self,
+	      build_dir: str,
+	      load_config=True,
+	      kunitconfig_path='',
+	      arch=None,
+	      cross_compile=None,
+	      qemu_config_path=None) -> None:
 		signal.signal(signal.SIGINT, self.signal_handler)
-
-		self._ops = LinuxSourceTreeOperations()
+		if qemu_config_path:
+			self._arch, self._ops = get_source_tree_ops_from_qemu_config(
+					qemu_config_path, cross_compile)
+		else:
+			self._arch = 'um' if arch is None else arch
+			self._ops = get_source_tree_ops(self._arch, cross_compile)
 
 		if not load_config:
 			return
@@ -170,8 +289,9 @@ class LinuxSourceTree(object):
 		kconfig_path = get_kconfig_path(build_dir)
 		if build_dir and not os.path.exists(build_dir):
 			os.mkdir(build_dir)
-		self._kconfig.write_to_file(kconfig_path)
 		try:
+			self._ops.make_arch_qemuconfig(self._kconfig)
+			self._kconfig.write_to_file(kconfig_path)
 			self._ops.make_olddefconfig(build_dir, make_options)
 		except ConfigError as e:
 			logging.error(e)
@@ -184,6 +304,7 @@ class LinuxSourceTree(object):
 		if os.path.exists(kconfig_path):
 			existing_kconfig = kunit_config.Kconfig()
 			existing_kconfig.read_from_file(kconfig_path)
+			self._ops.make_arch_qemuconfig(self._kconfig)
 			if not self._kconfig.is_subset_of(existing_kconfig):
 				print('Regenerating .config ...')
 				os.remove(kconfig_path)
@@ -194,7 +315,7 @@ class LinuxSourceTree(object):
 			print('Generating .config ...')
 			return self.build_config(build_dir, make_options)
 
-	def build_um_kernel(self, alltests, jobs, build_dir, make_options) -> bool:
+	def build_kernel(self, alltests, jobs, build_dir, make_options) -> bool:
 		try:
 			if alltests:
 				self._ops.make_allyesconfig(build_dir, make_options)
@@ -208,11 +329,11 @@ class LinuxSourceTree(object):
 	def run_kernel(self, args=None, build_dir='', filter_glob='', timeout=None) -> Iterator[str]:
 		if not args:
 			args = []
-		args.extend(['mem=1G', 'console=tty'])
+		args.extend(['mem=1G', 'console=tty', 'kunit_shutdown=halt'])
 		if filter_glob:
 			args.append('kunit.filter_glob='+filter_glob)
-		self._ops.linux_bin(args, timeout, build_dir)
 		outfile = get_outfile_path(build_dir)
+		self._ops.run(args, timeout, build_dir, outfile)
 		subprocess.call(['stty', 'sane'])
 		with open(outfile, 'r') as file:
 			for line in file:
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index e8bcc139702e..c3c524b79db8 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -43,26 +43,68 @@ class TestCase(object):
 class TestStatus(Enum):
 	SUCCESS = auto()
 	FAILURE = auto()
+	SKIPPED = auto()
 	TEST_CRASHED = auto()
 	NO_TESTS = auto()
 	FAILURE_TO_PARSE_TESTS = auto()
 
+class LineStream:
+	"""Provides a peek()/pop() interface over an iterator of (line#, text)."""
+	_lines: Iterator[Tuple[int, str]]
+	_next: Tuple[int, str]
+	_done: bool
+
+	def __init__(self, lines: Iterator[Tuple[int, str]]):
+		self._lines = lines
+		self._done = False
+		self._next = (0, '')
+		self._get_next()
+
+	def _get_next(self) -> None:
+		try:
+			self._next = next(self._lines)
+		except StopIteration:
+			self._done = True
+
+	def peek(self) -> str:
+		return self._next[1]
+
+	def pop(self) -> str:
+		n = self._next
+		self._get_next()
+		return n[1]
+
+	def __bool__(self) -> bool:
+		return not self._done
+
+	# Only used by kunit_tool_test.py.
+	def __iter__(self) -> Iterator[str]:
+		while bool(self):
+			yield self.pop()
+
+	def line_number(self) -> int:
+		return self._next[0]
+
 kunit_start_re = re.compile(r'TAP version [0-9]+$')
 kunit_end_re = re.compile('(List of all partitions:|'
-			  'Kernel panic - not syncing: VFS:)')
-
-def isolate_kunit_output(kernel_output) -> Iterator[str]:
-	started = False
-	for line in kernel_output:
-		line = line.rstrip()  # line always has a trailing \n
-		if kunit_start_re.search(line):
-			prefix_len = len(line.split('TAP version')[0])
-			started = True
-			yield line[prefix_len:] if prefix_len > 0 else line
-		elif kunit_end_re.search(line):
-			break
-		elif started:
-			yield line[prefix_len:] if prefix_len > 0 else line
+			  'Kernel panic - not syncing: VFS:|reboot: System halted)')
+
+def extract_tap_lines(kernel_output: Iterable[str]) -> LineStream:
+	def isolate_kunit_output(kernel_output: Iterable[str]) -> Iterator[Tuple[int, str]]:
+		line_num = 0
+		started = False
+		for line in kernel_output:
+			line_num += 1
+			line = line.rstrip()  # line always has a trailing \n
+			if kunit_start_re.search(line):
+				prefix_len = len(line.split('TAP version')[0])
+				started = True
+				yield line_num, line[prefix_len:]
+			elif kunit_end_re.search(line):
+				break
+			elif started:
+				yield line_num, line[prefix_len:]
+	return LineStream(lines=isolate_kunit_output(kernel_output))
 
 def raw_output(kernel_output) -> None:
 	for line in kernel_output:
@@ -97,34 +139,40 @@ def print_log(log) -> None:
 
 TAP_ENTRIES = re.compile(r'^(TAP|[\s]*ok|[\s]*not ok|[\s]*[0-9]+\.\.[0-9]+|[\s]*#).*$')
 
-def consume_non_diagnostic(lines: List[str]) -> None:
-	while lines and not TAP_ENTRIES.match(lines[0]):
-		lines.pop(0)
+def consume_non_diagnostic(lines: LineStream) -> None:
+	while lines and not TAP_ENTRIES.match(lines.peek()):
+		lines.pop()
 
-def save_non_diagnostic(lines: List[str], test_case: TestCase) -> None:
-	while lines and not TAP_ENTRIES.match(lines[0]):
-		test_case.log.append(lines[0])
-		lines.pop(0)
+def save_non_diagnostic(lines: LineStream, test_case: TestCase) -> None:
+	while lines and not TAP_ENTRIES.match(lines.peek()):
+		test_case.log.append(lines.peek())
+		lines.pop()
 
 OkNotOkResult = namedtuple('OkNotOkResult', ['is_ok','description', 'text'])
 
+OK_NOT_OK_SKIP = re.compile(r'^[\s]*(ok|not ok) [0-9]+ - (.*) # SKIP(.*)$')
+
 OK_NOT_OK_SUBTEST = re.compile(r'^[\s]+(ok|not ok) [0-9]+ - (.*)$')
 
 OK_NOT_OK_MODULE = re.compile(r'^(ok|not ok) ([0-9]+) - (.*)$')
 
-def parse_ok_not_ok_test_case(lines: List[str], test_case: TestCase) -> bool:
+def parse_ok_not_ok_test_case(lines: LineStream, test_case: TestCase) -> bool:
 	save_non_diagnostic(lines, test_case)
 	if not lines:
 		test_case.status = TestStatus.TEST_CRASHED
 		return True
-	line = lines[0]
+	line = lines.peek()
 	match = OK_NOT_OK_SUBTEST.match(line)
 	while not match and lines:
-		line = lines.pop(0)
+		line = lines.pop()
 		match = OK_NOT_OK_SUBTEST.match(line)
 	if match:
-		test_case.log.append(lines.pop(0))
+		test_case.log.append(lines.pop())
 		test_case.name = match.group(2)
+		skip_match = OK_NOT_OK_SKIP.match(line)
+		if skip_match:
+			test_case.status = TestStatus.SKIPPED
+			return True
 		if test_case.status == TestStatus.TEST_CRASHED:
 			return True
 		if match.group(1) == 'ok':
@@ -138,14 +186,14 @@ def parse_ok_not_ok_test_case(lines: List[str], test_case: TestCase) -> bool:
 SUBTEST_DIAGNOSTIC = re.compile(r'^[\s]+# (.*)$')
 DIAGNOSTIC_CRASH_MESSAGE = re.compile(r'^[\s]+# .*?: kunit test case crashed!$')
 
-def parse_diagnostic(lines: List[str], test_case: TestCase) -> bool:
+def parse_diagnostic(lines: LineStream, test_case: TestCase) -> bool:
 	save_non_diagnostic(lines, test_case)
 	if not lines:
 		return False
-	line = lines[0]
+	line = lines.peek()
 	match = SUBTEST_DIAGNOSTIC.match(line)
 	if match:
-		test_case.log.append(lines.pop(0))
+		test_case.log.append(lines.pop())
 		crash_match = DIAGNOSTIC_CRASH_MESSAGE.match(line)
 		if crash_match:
 			test_case.status = TestStatus.TEST_CRASHED
@@ -153,7 +201,7 @@ def parse_diagnostic(lines: List[str], test_case: TestCase) -> bool:
 	else:
 		return False
 
-def parse_test_case(lines: List[str]) -> Optional[TestCase]:
+def parse_test_case(lines: LineStream) -> Optional[TestCase]:
 	test_case = TestCase()
 	save_non_diagnostic(lines, test_case)
 	while parse_diagnostic(lines, test_case):
@@ -165,55 +213,58 @@ def parse_test_case(lines: List[str]) -> Optional[TestCase]:
 
 SUBTEST_HEADER = re.compile(r'^[\s]+# Subtest: (.*)$')
 
-def parse_subtest_header(lines: List[str]) -> Optional[str]:
+def parse_subtest_header(lines: LineStream) -> Optional[str]:
 	consume_non_diagnostic(lines)
 	if not lines:
 		return None
-	match = SUBTEST_HEADER.match(lines[0])
+	match = SUBTEST_HEADER.match(lines.peek())
 	if match:
-		lines.pop(0)
+		lines.pop()
 		return match.group(1)
 	else:
 		return None
 
 SUBTEST_PLAN = re.compile(r'[\s]+[0-9]+\.\.([0-9]+)')
 
-def parse_subtest_plan(lines: List[str]) -> Optional[int]:
+def parse_subtest_plan(lines: LineStream) -> Optional[int]:
 	consume_non_diagnostic(lines)
-	match = SUBTEST_PLAN.match(lines[0])
+	match = SUBTEST_PLAN.match(lines.peek())
 	if match:
-		lines.pop(0)
+		lines.pop()
 		return int(match.group(1))
 	else:
 		return None
 
 def max_status(left: TestStatus, right: TestStatus) -> TestStatus:
-	if left == TestStatus.TEST_CRASHED or right == TestStatus.TEST_CRASHED:
+	if left == right:
+		return left
+	elif left == TestStatus.TEST_CRASHED or right == TestStatus.TEST_CRASHED:
 		return TestStatus.TEST_CRASHED
 	elif left == TestStatus.FAILURE or right == TestStatus.FAILURE:
 		return TestStatus.FAILURE
-	elif left != TestStatus.SUCCESS:
-		return left
-	elif right != TestStatus.SUCCESS:
+	elif left == TestStatus.SKIPPED:
 		return right
 	else:
-		return TestStatus.SUCCESS
+		return left
 
-def parse_ok_not_ok_test_suite(lines: List[str],
+def parse_ok_not_ok_test_suite(lines: LineStream,
 			       test_suite: TestSuite,
 			       expected_suite_index: int) -> bool:
 	consume_non_diagnostic(lines)
 	if not lines:
 		test_suite.status = TestStatus.TEST_CRASHED
 		return False
-	line = lines[0]
+	line = lines.peek()
 	match = OK_NOT_OK_MODULE.match(line)
 	if match:
-		lines.pop(0)
+		lines.pop()
 		if match.group(1) == 'ok':
 			test_suite.status = TestStatus.SUCCESS
 		else:
 			test_suite.status = TestStatus.FAILURE
+		skip_match = OK_NOT_OK_SKIP.match(line)
+		if skip_match:
+			test_suite.status = TestStatus.SKIPPED
 		suite_index = int(match.group(2))
 		if suite_index != expected_suite_index:
 			print_with_timestamp(
@@ -224,14 +275,14 @@ def parse_ok_not_ok_test_suite(lines: List[str],
 	else:
 		return False
 
-def bubble_up_errors(statuses: Iterable[TestStatus]) -> TestStatus:
-	return reduce(max_status, statuses, TestStatus.SUCCESS)
+def bubble_up_errors(status_list: Iterable[TestStatus]) -> TestStatus:
+	return reduce(max_status, status_list, TestStatus.SKIPPED)
 
 def bubble_up_test_case_errors(test_suite: TestSuite) -> TestStatus:
 	max_test_case_status = bubble_up_errors(x.status for x in test_suite.cases)
 	return max_status(max_test_case_status, test_suite.status)
 
-def parse_test_suite(lines: List[str], expected_suite_index: int) -> Optional[TestSuite]:
+def parse_test_suite(lines: LineStream, expected_suite_index: int) -> Optional[TestSuite]:
 	if not lines:
 		return None
 	consume_non_diagnostic(lines)
@@ -257,26 +308,26 @@ def parse_test_suite(lines: List[str], expected_suite_index: int) -> Optional[Te
 		print_with_timestamp(red('[ERROR] ') + 'ran out of lines before end token')
 		return test_suite
 	else:
-		print('failed to parse end of suite' + lines[0])
+		print(f'failed to parse end of suite "{name}", at line {lines.line_number()}: {lines.peek()}')
 		return None
 
 TAP_HEADER = re.compile(r'^TAP version 14$')
 
-def parse_tap_header(lines: List[str]) -> bool:
+def parse_tap_header(lines: LineStream) -> bool:
 	consume_non_diagnostic(lines)
-	if TAP_HEADER.match(lines[0]):
-		lines.pop(0)
+	if TAP_HEADER.match(lines.peek()):
+		lines.pop()
 		return True
 	else:
 		return False
 
 TEST_PLAN = re.compile(r'[0-9]+\.\.([0-9]+)')
 
-def parse_test_plan(lines: List[str]) -> Optional[int]:
+def parse_test_plan(lines: LineStream) -> Optional[int]:
 	consume_non_diagnostic(lines)
-	match = TEST_PLAN.match(lines[0])
+	match = TEST_PLAN.match(lines.peek())
 	if match:
-		lines.pop(0)
+		lines.pop()
 		return int(match.group(1))
 	else:
 		return None
@@ -284,7 +335,7 @@ def parse_test_plan(lines: List[str]) -> Optional[int]:
 def bubble_up_suite_errors(test_suites: Iterable[TestSuite]) -> TestStatus:
 	return bubble_up_errors(x.status for x in test_suites)
 
-def parse_test_result(lines: List[str]) -> TestResult:
+def parse_test_result(lines: LineStream) -> TestResult:
 	consume_non_diagnostic(lines)
 	if not lines or not parse_tap_header(lines):
 		return TestResult(TestStatus.NO_TESTS, [], lines)
@@ -311,49 +362,69 @@ def parse_test_result(lines: List[str]) -> TestResult:
 	else:
 		return TestResult(TestStatus.NO_TESTS, [], lines)
 
-def print_and_count_results(test_result: TestResult) -> Tuple[int, int, int]:
-	total_tests = 0
-	failed_tests = 0
-	crashed_tests = 0
+class TestCounts:
+	passed: int
+	failed: int
+	crashed: int
+	skipped: int
+
+	def __init__(self):
+		self.passed = 0
+		self.failed = 0
+		self.crashed = 0
+		self.skipped = 0
+
+	def total(self) -> int:
+		return self.passed + self.failed + self.crashed + self.skipped
+
+def print_and_count_results(test_result: TestResult) -> TestCounts:
+	counts = TestCounts()
 	for test_suite in test_result.suites:
 		if test_suite.status == TestStatus.SUCCESS:
 			print_suite_divider(green('[PASSED] ') + test_suite.name)
+		elif test_suite.status == TestStatus.SKIPPED:
+			print_suite_divider(yellow('[SKIPPED] ') + test_suite.name)
 		elif test_suite.status == TestStatus.TEST_CRASHED:
 			print_suite_divider(red('[CRASHED] ' + test_suite.name))
 		else:
 			print_suite_divider(red('[FAILED] ') + test_suite.name)
 		for test_case in test_suite.cases:
-			total_tests += 1
 			if test_case.status == TestStatus.SUCCESS:
+				counts.passed += 1
 				print_with_timestamp(green('[PASSED] ') + test_case.name)
+			elif test_case.status == TestStatus.SKIPPED:
+				counts.skipped += 1
+				print_with_timestamp(yellow('[SKIPPED] ') + test_case.name)
 			elif test_case.status == TestStatus.TEST_CRASHED:
-				crashed_tests += 1
+				counts.crashed += 1
 				print_with_timestamp(red('[CRASHED] ' + test_case.name))
 				print_log(map(yellow, test_case.log))
 				print_with_timestamp('')
 			else:
-				failed_tests += 1
+				counts.failed += 1
 				print_with_timestamp(red('[FAILED] ') + test_case.name)
 				print_log(map(yellow, test_case.log))
 				print_with_timestamp('')
-	return total_tests, failed_tests, crashed_tests
+	return counts
 
-def parse_run_tests(kernel_output) -> TestResult:
-	total_tests = 0
-	failed_tests = 0
-	crashed_tests = 0
-	test_result = parse_test_result(list(isolate_kunit_output(kernel_output)))
+def parse_run_tests(kernel_output: Iterable[str]) -> TestResult:
+	counts = TestCounts()
+	lines = extract_tap_lines(kernel_output)
+	test_result = parse_test_result(lines)
 	if test_result.status == TestStatus.NO_TESTS:
 		print(red('[ERROR] ') + yellow('no tests run!'))
 	elif test_result.status == TestStatus.FAILURE_TO_PARSE_TESTS:
 		print(red('[ERROR] ') + yellow('could not parse test results!'))
 	else:
-		(total_tests,
-		 failed_tests,
-		 crashed_tests) = print_and_count_results(test_result)
+		counts = print_and_count_results(test_result)
 	print_with_timestamp(DIVIDER)
-	fmt = green if test_result.status == TestStatus.SUCCESS else red
+	if test_result.status == TestStatus.SUCCESS:
+		fmt = green
+	elif test_result.status == TestStatus.SKIPPED:
+		fmt = yellow
+	else:
+		fmt =red
 	print_with_timestamp(
-		fmt('Testing complete. %d tests run. %d failed. %d crashed.' %
-		    (total_tests, failed_tests, crashed_tests)))
+		fmt('Testing complete. %d tests run. %d failed. %d crashed. %d skipped.' %
+		    (counts.total(), counts.failed, counts.crashed, counts.skipped)))
 	return test_result
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 2e809dd956a7..bdae0e5f6197 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -11,6 +11,7 @@ from unittest import mock
 
 import tempfile, shutil # Handling test_tmpdir
 
+import itertools
 import json
 import signal
 import os
@@ -92,17 +93,18 @@ class KconfigTest(unittest.TestCase):
 
 class KUnitParserTest(unittest.TestCase):
 
-	def assertContains(self, needle, haystack):
-		for line in haystack:
+	def assertContains(self, needle: str, haystack: kunit_parser.LineStream):
+		# Clone the iterator so we can print the contents on failure.
+		copy, backup = itertools.tee(haystack)
+		for line in copy:
 			if needle in line:
 				return
-		raise AssertionError('"' +
-			str(needle) + '" not found in "' + str(haystack) + '"!')
+		raise AssertionError(f'"{needle}" not found in {list(backup)}!')
 
 	def test_output_isolated_correctly(self):
 		log_path = test_data_path('test_output_isolated_correctly.log')
 		with open(log_path) as file:
-			result = kunit_parser.isolate_kunit_output(file.readlines())
+			result = kunit_parser.extract_tap_lines(file.readlines())
 		self.assertContains('TAP version 14', result)
 		self.assertContains('	# Subtest: example', result)
 		self.assertContains('	1..2', result)
@@ -113,7 +115,7 @@ class KUnitParserTest(unittest.TestCase):
 	def test_output_with_prefix_isolated_correctly(self):
 		log_path = test_data_path('test_pound_sign.log')
 		with open(log_path) as file:
-			result = kunit_parser.isolate_kunit_output(file.readlines())
+			result = kunit_parser.extract_tap_lines(file.readlines())
 		self.assertContains('TAP version 14', result)
 		self.assertContains('	# Subtest: kunit-resource-test', result)
 		self.assertContains('	1..5', result)
@@ -159,7 +161,7 @@ class KUnitParserTest(unittest.TestCase):
 		empty_log = test_data_path('test_is_test_passed-no_tests_run.log')
 		with open(empty_log) as file:
 			result = kunit_parser.parse_run_tests(
-				kunit_parser.isolate_kunit_output(file.readlines()))
+				kunit_parser.extract_tap_lines(file.readlines()))
 		self.assertEqual(0, len(result.suites))
 		self.assertEqual(
 			kunit_parser.TestStatus.NO_TESTS,
@@ -170,7 +172,7 @@ class KUnitParserTest(unittest.TestCase):
 		print_mock = mock.patch('builtins.print').start()
 		with open(crash_log) as file:
 			result = kunit_parser.parse_run_tests(
-				kunit_parser.isolate_kunit_output(file.readlines()))
+				kunit_parser.extract_tap_lines(file.readlines()))
 		print_mock.assert_any_call(StrContains('no tests run!'))
 		print_mock.stop()
 		file.close()
@@ -183,6 +185,28 @@ class KUnitParserTest(unittest.TestCase):
 			kunit_parser.TestStatus.TEST_CRASHED,
 			result.status)
 
+	def test_skipped_test(self):
+		skipped_log = test_data_path('test_skip_tests.log')
+		file = open(skipped_log)
+		result = kunit_parser.parse_run_tests(file.readlines())
+
+		# A skipped test does not fail the whole suite.
+		self.assertEqual(
+			kunit_parser.TestStatus.SUCCESS,
+			result.status)
+		file.close()
+
+	def test_skipped_all_tests(self):
+		skipped_log = test_data_path('test_skip_all_tests.log')
+		file = open(skipped_log)
+		result = kunit_parser.parse_run_tests(file.readlines())
+
+		self.assertEqual(
+			kunit_parser.TestStatus.SKIPPED,
+			result.status)
+		file.close()
+
+
 	def test_ignores_prefix_printk_time(self):
 		prefix_log = test_data_path('test_config_printk_time.log')
 		with open(prefix_log) as file:
@@ -303,7 +327,7 @@ class KUnitMainTest(unittest.TestCase):
 
 		self.linux_source_mock = mock.Mock()
 		self.linux_source_mock.build_reconfig = mock.Mock(return_value=True)
-		self.linux_source_mock.build_um_kernel = mock.Mock(return_value=True)
+		self.linux_source_mock.build_kernel = mock.Mock(return_value=True)
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=all_passed_log)
 
 	def test_config_passes_args_pass(self):
@@ -314,7 +338,7 @@ class KUnitMainTest(unittest.TestCase):
 	def test_build_passes_args_pass(self):
 		kunit.main(['build'], self.linux_source_mock)
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 0)
-		self.linux_source_mock.build_um_kernel.assert_called_once_with(False, 8, '.kunit', None)
+		self.linux_source_mock.build_kernel.assert_called_once_with(False, 8, '.kunit', None)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 0)
 
 	def test_exec_passes_args_pass(self):
@@ -396,7 +420,7 @@ class KUnitMainTest(unittest.TestCase):
 	def test_build_builddir(self):
 		build_dir = '.kunit'
 		kunit.main(['build', '--build_dir', build_dir], self.linux_source_mock)
-		self.linux_source_mock.build_um_kernel.assert_called_once_with(False, 8, build_dir, None)
+		self.linux_source_mock.build_kernel.assert_called_once_with(False, 8, build_dir, None)
 
 	def test_exec_builddir(self):
 		build_dir = '.kunit'
@@ -410,14 +434,22 @@ class KUnitMainTest(unittest.TestCase):
 		mock_linux_init.return_value = self.linux_source_mock
 		kunit.main(['run', '--kunitconfig=mykunitconfig'])
 		# Just verify that we parsed and initialized it correctly here.
-		mock_linux_init.assert_called_once_with('.kunit', kunitconfig_path='mykunitconfig')
+		mock_linux_init.assert_called_once_with('.kunit',
+							kunitconfig_path='mykunitconfig',
+							arch='um',
+							cross_compile=None,
+							qemu_config_path=None)
 
 	@mock.patch.object(kunit_kernel, 'LinuxSourceTree')
 	def test_config_kunitconfig(self, mock_linux_init):
 		mock_linux_init.return_value = self.linux_source_mock
 		kunit.main(['config', '--kunitconfig=mykunitconfig'])
 		# Just verify that we parsed and initialized it correctly here.
-		mock_linux_init.assert_called_once_with('.kunit', kunitconfig_path='mykunitconfig')
+		mock_linux_init.assert_called_once_with('.kunit',
+							kunitconfig_path='mykunitconfig',
+							arch='um',
+							cross_compile=None,
+							qemu_config_path=None)
 
 if __name__ == '__main__':
 	unittest.main()
diff --git a/tools/testing/kunit/qemu_config.py b/tools/testing/kunit/qemu_config.py
new file mode 100644
index 000000000000..1672f6184e95
--- /dev/null
+++ b/tools/testing/kunit/qemu_config.py
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Collection of configs for building non-UML kernels and running them on QEMU.
+#
+# Copyright (C) 2021, Google LLC.
+# Author: Brendan Higgins <brendanhiggins@google.com>
+
+from collections import namedtuple
+
+
+QemuArchParams = namedtuple('QemuArchParams', ['linux_arch',
+					       'kconfig',
+					       'qemu_arch',
+					       'kernel_path',
+					       'kernel_command_line',
+					       'extra_qemu_params'])
diff --git a/tools/testing/kunit/qemu_configs/alpha.py b/tools/testing/kunit/qemu_configs/alpha.py
new file mode 100644
index 000000000000..5d0c0cff03bd
--- /dev/null
+++ b/tools/testing/kunit/qemu_configs/alpha.py
@@ -0,0 +1,10 @@
+from ..qemu_config import QemuArchParams
+
+QEMU_ARCH = QemuArchParams(linux_arch='alpha',
+			   kconfig='''
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y''',
+			   qemu_arch='alpha',
+			   kernel_path='arch/alpha/boot/vmlinux',
+			   kernel_command_line='console=ttyS0',
+			   extra_qemu_params=[''])
diff --git a/tools/testing/kunit/qemu_configs/arm.py b/tools/testing/kunit/qemu_configs/arm.py
new file mode 100644
index 000000000000..b9c2a35e0296
--- /dev/null
+++ b/tools/testing/kunit/qemu_configs/arm.py
@@ -0,0 +1,13 @@
+from ..qemu_config import QemuArchParams
+
+QEMU_ARCH = QemuArchParams(linux_arch='arm',
+			   kconfig='''
+CONFIG_ARCH_VIRT=y
+CONFIG_SERIAL_AMBA_PL010=y
+CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
+CONFIG_SERIAL_AMBA_PL011=y
+CONFIG_SERIAL_AMBA_PL011_CONSOLE=y''',
+			   qemu_arch='arm',
+			   kernel_path='arch/arm/boot/zImage',
+			   kernel_command_line='console=ttyAMA0',
+			   extra_qemu_params=['-machine virt'])
diff --git a/tools/testing/kunit/qemu_configs/arm64.py b/tools/testing/kunit/qemu_configs/arm64.py
new file mode 100644
index 000000000000..517c04459f47
--- /dev/null
+++ b/tools/testing/kunit/qemu_configs/arm64.py
@@ -0,0 +1,12 @@
+from ..qemu_config import QemuArchParams
+
+QEMU_ARCH = QemuArchParams(linux_arch='arm64',
+			   kconfig='''
+CONFIG_SERIAL_AMBA_PL010=y
+CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
+CONFIG_SERIAL_AMBA_PL011=y
+CONFIG_SERIAL_AMBA_PL011_CONSOLE=y''',
+			   qemu_arch='aarch64',
+			   kernel_path='arch/arm64/boot/Image.gz',
+			   kernel_command_line='console=ttyAMA0',
+			   extra_qemu_params=['-machine virt', '-cpu cortex-a57'])
diff --git a/tools/testing/kunit/qemu_configs/i386.py b/tools/testing/kunit/qemu_configs/i386.py
new file mode 100644
index 000000000000..aed3ffd3937d
--- /dev/null
+++ b/tools/testing/kunit/qemu_configs/i386.py
@@ -0,0 +1,10 @@
+from ..qemu_config import QemuArchParams
+
+QEMU_ARCH = QemuArchParams(linux_arch='i386',
+			   kconfig='''
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y''',
+			   qemu_arch='x86_64',
+			   kernel_path='arch/x86/boot/bzImage',
+			   kernel_command_line='console=ttyS0',
+			   extra_qemu_params=[''])
diff --git a/tools/testing/kunit/qemu_configs/powerpc.py b/tools/testing/kunit/qemu_configs/powerpc.py
new file mode 100644
index 000000000000..35e9de24f0db
--- /dev/null
+++ b/tools/testing/kunit/qemu_configs/powerpc.py
@@ -0,0 +1,12 @@
+from ..qemu_config import QemuArchParams
+
+QEMU_ARCH = QemuArchParams(linux_arch='powerpc',
+			   kconfig='''
+CONFIG_PPC64=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_HVC_CONSOLE=y''',
+			   qemu_arch='ppc64',
+			   kernel_path='vmlinux',
+			   kernel_command_line='console=ttyS0',
+			   extra_qemu_params=['-M pseries', '-cpu power8'])
diff --git a/tools/testing/kunit/qemu_configs/riscv.py b/tools/testing/kunit/qemu_configs/riscv.py
new file mode 100644
index 000000000000..9e528087cd7c
--- /dev/null
+++ b/tools/testing/kunit/qemu_configs/riscv.py
@@ -0,0 +1,31 @@
+from ..qemu_config import QemuArchParams
+import os
+import os.path
+import sys
+
+GITHUB_OPENSBI_URL = 'https://github.com/qemu/qemu/raw/master/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin'
+OPENSBI_FILE = os.path.basename(GITHUB_OPENSBI_URL)
+
+if not os.path.isfile(OPENSBI_FILE):
+	print('\n\nOpenSBI file is not in the current working directory.\n'
+	      'Would you like me to download it for you from:\n' + GITHUB_OPENSBI_URL + ' ?\n')
+	response = input('yes/[no]: ')
+	if response.strip() == 'yes':
+		os.system('wget ' + GITHUB_OPENSBI_URL)
+	else:
+		sys.exit()
+
+QEMU_ARCH = QemuArchParams(linux_arch='riscv',
+			   kconfig='''
+CONFIG_SOC_VIRT=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_SERIAL_EARLYCON_RISCV_SBI=y''',
+			   qemu_arch='riscv64',
+			   kernel_path='arch/riscv/boot/Image',
+			   kernel_command_line='console=ttyS0',
+			   extra_qemu_params=[
+					   '-machine virt',
+					   '-cpu rv64',
+					   '-bios opensbi-riscv64-generic-fw_dynamic.bin'])
diff --git a/tools/testing/kunit/qemu_configs/s390.py b/tools/testing/kunit/qemu_configs/s390.py
new file mode 100644
index 000000000000..e310bd521113
--- /dev/null
+++ b/tools/testing/kunit/qemu_configs/s390.py
@@ -0,0 +1,14 @@
+from ..qemu_config import QemuArchParams
+
+QEMU_ARCH = QemuArchParams(linux_arch='s390',
+			   kconfig='''
+CONFIG_EXPERT=y
+CONFIG_TUNE_ZEC12=y
+CONFIG_NUMA=y
+CONFIG_MODULES=y''',
+			   qemu_arch='s390x',
+			   kernel_path='arch/s390/boot/bzImage',
+			   kernel_command_line='console=ttyS0',
+			   extra_qemu_params=[
+					   '-machine s390-ccw-virtio',
+					   '-cpu qemu',])
diff --git a/tools/testing/kunit/qemu_configs/sparc.py b/tools/testing/kunit/qemu_configs/sparc.py
new file mode 100644
index 000000000000..27f474e7ad6e
--- /dev/null
+++ b/tools/testing/kunit/qemu_configs/sparc.py
@@ -0,0 +1,10 @@
+from ..qemu_config import QemuArchParams
+
+QEMU_ARCH = QemuArchParams(linux_arch='sparc',
+			   kconfig='''
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y''',
+			   qemu_arch='sparc',
+			   kernel_path='arch/sparc/boot/zImage',
+			   kernel_command_line='console=ttyS0 mem=256M',
+			   extra_qemu_params=['-m 256'])
diff --git a/tools/testing/kunit/qemu_configs/x86_64.py b/tools/testing/kunit/qemu_configs/x86_64.py
new file mode 100644
index 000000000000..77ab1aeee8a3
--- /dev/null
+++ b/tools/testing/kunit/qemu_configs/x86_64.py
@@ -0,0 +1,10 @@
+from ..qemu_config import QemuArchParams
+
+QEMU_ARCH = QemuArchParams(linux_arch='x86_64',
+			   kconfig='''
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y''',
+			   qemu_arch='x86_64',
+			   kernel_path='arch/x86/boot/bzImage',
+			   kernel_command_line='console=ttyS0',
+			   extra_qemu_params=[''])
diff --git a/tools/testing/kunit/test_data/test_skip_all_tests.log b/tools/testing/kunit/test_data/test_skip_all_tests.log
new file mode 100644
index 000000000000..2ea6e6d14fff
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_skip_all_tests.log
@@ -0,0 +1,15 @@
+TAP version 14
+1..2
+    # Subtest: string-stream-test
+    1..3
+    ok 1 - string_stream_test_empty_on_creation # SKIP all tests skipped
+    ok 2 - string_stream_test_not_empty_after_add # SKIP all tests skipped
+    ok 3 - string_stream_test_get_string # SKIP all tests skipped
+ok 1 - string-stream-test # SKIP
+    # Subtest: example
+    1..2
+    # example_simple_test: initializing
+    ok 1 - example_simple_test # SKIP all tests skipped
+    # example_skip_test: initializing
+    ok 2 - example_skip_test # SKIP this test should be skipped
+ok 2 - example # SKIP
diff --git a/tools/testing/kunit/test_data/test_skip_tests.log b/tools/testing/kunit/test_data/test_skip_tests.log
new file mode 100644
index 000000000000..79b326e31274
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_skip_tests.log
@@ -0,0 +1,15 @@
+TAP version 14
+1..2
+    # Subtest: string-stream-test
+    1..3
+    ok 1 - string_stream_test_empty_on_creation
+    ok 2 - string_stream_test_not_empty_after_add
+    ok 3 - string_stream_test_get_string
+ok 1 - string-stream-test
+    # Subtest: example
+    1..2
+    # example_simple_test: initializing
+    ok 1 - example_simple_test
+    # example_skip_test: initializing
+    ok 2 - example_skip_test # SKIP this test should be skipped
+ok 2 - example

--------------98BF7D50A0864B825756CAC7--
