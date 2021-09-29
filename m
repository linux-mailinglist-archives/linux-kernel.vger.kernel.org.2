Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D5D41BA6B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 00:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243191AbhI1Wb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 18:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242929AbhI1WbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 18:31:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694F4C061755
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 15:29:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t7-20020a258387000000b005b6d7220c79so110560ybk.16
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tQxbK2aMfQ58b7hYEDvx1oQNslA/rl+NJOm+PdxI91M=;
        b=rkWLwcsI/zJYcVCxbC0PLbkHXr5VAOtHE0typWLzC2ts1SKsUPYivTE5muwmBg87qc
         DDRii8qzuawWFRLvrUV9FAJCsh3zXttLD4yguOpDO4/zGtbDUDi3zwoEr37eZdEly5Td
         M0mGaGUZzpQhIBtoS38XMnO+EaBA/EFYiJunJ6IOVtkO8E/Hfgoi8qDcS7fzPZFUS5ma
         KnjQpjwvsbdwvjoDwW9FMUuePW80xfWrc5kjr6gJ8eVZ3FiMjdB2ZgDfuUeeYTSjolbS
         xDIzKTDfBxKlATUVzhJs8cWha9ehknrQvq3AihB8QsmKMA9JTYUNsTbqxq2BJgNxdiP+
         yDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tQxbK2aMfQ58b7hYEDvx1oQNslA/rl+NJOm+PdxI91M=;
        b=UEsiWV2OIjlw1WPE/v2srwe4jiWubHfnQ1w1sn12m5BaMIsgAnd6wZdbiZv/YA/51e
         TFBSsmeSFmpZjcWJjmrZCSVa5yizknq6S19xykcmR5yWTWAGMN61zDX94eU3asARCrqB
         MhCRcjYiwwC3scE2ypahvZwyIwQltwqRuPC9cJyjCw9oizeLUQsLZFFYNZ/wzals6xUW
         IzYI4IlyCGNPMF0itmfrxLvkljWyL2bXBSNNFH7WB0GkufqeDX+latpMRWGUvS1lMqdX
         zJ4SxVCPS8DRP5iJ9c+5/alkkfPv+U60JBwtuSHvvT+xXfddiUvfW4W5Q+k6dsns9jVv
         yINg==
X-Gm-Message-State: AOAM532XT+6gDGuteWpmXasZGxKb8EgVSStJ4sAZq9C87YIZw9ZrV6Fh
        cDa8+W7qJXkUbCNWPGKVII3iUn351lUemQ==
X-Google-Smtp-Source: ABdhPJzCgAoZ+Vzx99NASv5ECob0Fdt51EI5DRKXyQxg1UrCErLR9HZM861stIuL3uSEwP+gganNlJnBqDl1Ag==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:981c:22f3:3855:9bb7])
 (user=dlatypov job=sendgmr) by 2002:a25:838d:: with SMTP id
 t13mr6638740ybk.140.1632868179683; Tue, 28 Sep 2021 15:29:39 -0700 (PDT)
Date:   Tue, 28 Sep 2021 15:29:26 -0700
In-Reply-To: <20210928222926.1180749-1-dlatypov@google.com>
Message-Id: <20210928222926.1180749-4-dlatypov@google.com>
Mime-Version: 1.0
References: <20210928222926.1180749-1-dlatypov@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v2 3/3] kunit: tool: support running each suite/test separately
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new --run_isolated flag makes the tool boot the kernel once per
suite or test, preventing leftover state from one suite to impact the
other. This can be useful as a starting point to debugging test
hermeticity issues.

Note: it takes a lot longer, so people should not use it normally.

Consider the following very simplified example:

  bool disable_something_for_test = false;
  void function_being_tested() {
    ...
    if (disable_something_for_test) return;
    ...
  }

  static void test_before(struct kunit *test)
  {
    disable_something_for_test = true;
    function_being_tested();
    /* oops, we forgot to reset it back to false */
  }

  static void test_after(struct kunit *test)
  {
    /* oops, now "fixing" test_before can cause test_after to fail! */
    function_being_tested();
  }

Presented like this, the issues are obvious, but it gets a lot more
complicated to track down as the amount of test setup and helper
functions increases.

Another use case is memory corruption. It might not be surface as an
failure/crash in the test case or suite that caused it. I've noticed in
kunit's own unit tests, the 3rd suite after might be the one to finally
crash after an out-of-bounds write, for example.

Example usage:

Per suite:
$ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=suite
...
Starting KUnit Kernel (1/7)...
============================================================
======== [PASSED] kunit_executor_test ========
....
Testing complete. 5 tests run. 0 failed. 0 crashed. 0 skipped.
Starting KUnit Kernel (2/7)...
============================================================
======== [PASSED] kunit-try-catch-test ========
...

Per test:
$ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=test
Starting KUnit Kernel (1/23)...
============================================================
======== [PASSED] kunit_executor_test ========
[PASSED] parse_filter_test
============================================================
Testing complete. 1 tests run. 0 failed. 0 crashed. 0 skipped.
Starting KUnit Kernel (2/23)...
============================================================
======== [PASSED] kunit_executor_test ========
[PASSED] filter_subsuite_test
...

It works with filters as well:
$ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=suite example
...
Starting KUnit Kernel (1/1)...
============================================================
======== [PASSED] example ========
...

It also handles test filters, '*.*skip*' runs these 3 tests:
  kunit_status.kunit_status_mark_skipped_test
  example.example_skip_test
  example.example_mark_skipped_test

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit.py           | 91 ++++++++++++++++++++------
 tools/testing/kunit/kunit_tool_test.py | 40 +++++++++++
 2 files changed, 112 insertions(+), 19 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 31eec9f6ecc3..e7b92caba53d 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -16,7 +16,7 @@ assert sys.version_info >= (3, 7), "Python version is too old"
 
 from collections import namedtuple
 from enum import Enum, auto
-from typing import Iterable
+from typing import Iterable, List
 
 import kunit_config
 import kunit_json
@@ -31,13 +31,13 @@ KunitBuildRequest = namedtuple('KunitBuildRequest',
 			       ['jobs', 'build_dir', 'alltests',
 				'make_options'])
 KunitExecRequest = namedtuple('KunitExecRequest',
-                              ['timeout', 'build_dir', 'alltests',
-                               'filter_glob', 'kernel_args'])
+			      ['timeout', 'build_dir', 'alltests',
+			       'filter_glob', 'kernel_args', 'run_isolated'])
 KunitParseRequest = namedtuple('KunitParseRequest',
 			       ['raw_output', 'build_dir', 'json'])
 KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs',
 					   'build_dir', 'alltests', 'filter_glob',
-					   'kernel_args', 'json', 'make_options'])
+					   'kernel_args', 'run_isolated', 'json', 'make_options'])
 
 KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
 
@@ -91,21 +91,66 @@ def build_tests(linux: kunit_kernel.LinuxSourceTree,
 			   'built kernel successfully',
 			   build_end - build_start)
 
-def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest,
-	       parse_request: KunitParseRequest) -> KunitResult:
-	kunit_parser.print_with_timestamp('Starting KUnit Kernel ...')
-	test_start = time.time()
-	run_result = linux.run_kernel(
-		args=request.kernel_args,
-		timeout=None if request.alltests else request.timeout,
-		filter_glob=request.filter_glob,
-		build_dir=request.build_dir)
+def _list_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -> List[str]:
+	args = ['kunit.action=list']
+	if request.kernel_args:
+		args.extend(request.kernel_args)
+
+	output = linux.run_kernel(args=args,
+			   timeout=None if request.alltests else request.timeout,
+			   filter_glob=request.filter_glob,
+			   build_dir=request.build_dir)
+	output = kunit_parser.extract_tap_lines(output)
+	# Hack! Drop the TAP version header and top-level test plan.
+	output.pop()
+	output.pop()
+	return list(output)
+
+def _suites_from_test_list(tests: List[str]) -> List[str]:
+	"""Extracts all the suites from an ordered list of tests."""
+	suites = []  # type: List[str]
+	for t in tests:
+		parts = t.split('.', maxsplit=2)
+		if len(parts) != 2:
+			raise ValueError(f'internal KUnit error, test name should be of the form "<suite>.<test>", got "{t}"')
+		suite, case = parts
+		if not suites or suites[-1] != suite:
+			suites.append(suite)
+	return suites
+
 
-	test_end = time.time()
-	exec_time = test_end - test_start
 
-	# Named tuples are immutable, so we rebuild them here manually
-	result = parse_tests(parse_request, run_result)
+def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest,
+	       parse_request: KunitParseRequest) -> KunitResult:
+	filter_globs = [request.filter_glob]
+	if request.run_isolated:
+		tests = _list_tests(linux, request)
+		if request.run_isolated == 'test':
+			filter_globs = tests
+		if request.run_isolated == 'suite':
+			filter_globs = _suites_from_test_list(tests)
+			# Apply the test-part of the user's glob, if present.
+			if '.' in request.filter_glob:
+				test_glob = request.filter_glob.split('.', maxsplit=2)[1]
+				filter_globs = [g + '.'+ test_glob for g in filter_globs]
+
+	overall_status = kunit_parser.TestStatus.SUCCESS
+	exec_time = 0
+	for i, filter_glob in enumerate(filter_globs):
+		kunit_parser.print_with_timestamp('Starting KUnit Kernel ({}/{})...'.format(i+1, len(filter_globs)))
+
+		test_start = time.time()
+		run_result = linux.run_kernel(
+			args=request.kernel_args,
+			timeout=None if request.alltests else request.timeout,
+			filter_glob=filter_glob,
+			build_dir=request.build_dir)
+
+		test_end = time.time()
+		exec_time += test_end - test_start
+
+		result = parse_tests(parse_request, run_result)
+		overall_status = kunit_parser.max_status(overall_status, result.status)
 
 	return KunitResult(status=result.status, result=result.result, elapsed_time=exec_time)
 
@@ -166,7 +211,7 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 
 	exec_request = KunitExecRequest(request.timeout, request.build_dir,
 				 request.alltests, request.filter_glob,
-				 request.kernel_args)
+				 request.kernel_args, request.run_isolated)
 	parse_request = KunitParseRequest(request.raw_output,
 					  request.build_dir,
 					  request.json)
@@ -250,6 +295,12 @@ def add_exec_opts(parser) -> None:
 	parser.add_argument('--kernel_args',
 			    help='Kernel command-line parameters. Maybe be repeated',
 			     action='append')
+	parser.add_argument('--run_isolated', help='If set, boot the kernel for each '
+			    'individual suite/test. This is can be useful for debugging '
+			    'a non-hermetic test, one that might pass/fail based on '
+			    'what ran before it.',
+			    type=str,
+			    choices=['suite', 'test']),
 
 def add_parse_opts(parser) -> None:
 	parser.add_argument('--raw_output', help='If set don\'t format output from kernel. '
@@ -323,6 +374,7 @@ def main(argv, linux=None):
 				       cli_args.alltests,
 				       cli_args.filter_glob,
 				       cli_args.kernel_args,
+				       cli_args.run_isolated,
 				       cli_args.json,
 				       cli_args.make_options)
 		result = run_tests(linux, request)
@@ -378,7 +430,8 @@ def main(argv, linux=None):
 						cli_args.build_dir,
 						cli_args.alltests,
 						cli_args.filter_glob,
-						cli_args.kernel_args)
+						cli_args.kernel_args,
+						cli_args.run_isolated)
 		parse_request = KunitParseRequest(cli_args.raw_output,
 						  cli_args.build_dir,
 						  cli_args.json)
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 619c4554cbff..bcfdc6664c9d 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -477,6 +477,46 @@ class KUnitMainTest(unittest.TestCase):
 		      args=['a=1','b=2'], build_dir='.kunit', filter_glob='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
+	def test_list_tests(self):
+		want = ['suite.test1', 'suite.test2', 'suite2.test1']
+		self.linux_source_mock.run_kernel.return_value = ['TAP version 14', '1..0'] + want
+
+		got = kunit._list_tests(self.linux_source_mock,
+				     kunit.KunitExecRequest(300, '.kunit', False, 'suite*', None, 'suite'))
+
+		self.assertEqual(got, want)
+		# Should respect the user's filter glob when listing tests.
+		self.linux_source_mock.run_kernel.assert_called_once_with(
+			args=['kunit.action=list'], build_dir='.kunit', filter_glob='suite*', timeout=300)
+
+
+	@mock.patch.object(kunit, '_list_tests')
+	def test_run_isolated_by_suite(self, mock_tests):
+		mock_tests.return_value = ['suite.test1', 'suite.test2', 'suite2.test1']
+		kunit.main(['exec', '--run_isolated=suite', 'suite*.test*'], self.linux_source_mock)
+
+		# Should respect the user's filter glob when listing tests.
+		mock_tests.assert_called_once_with(mock.ANY,
+				     kunit.KunitExecRequest(300, '.kunit', False, 'suite*.test*', None, 'suite'))
+		self.linux_source_mock.run_kernel.assert_has_calls([
+			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test*', timeout=300),
+			mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test*', timeout=300),
+		])
+
+	@mock.patch.object(kunit, '_list_tests')
+	def test_run_isolated_by_test(self, mock_tests):
+		mock_tests.return_value = ['suite.test1', 'suite.test2', 'suite2.test1']
+		kunit.main(['exec', '--run_isolated=test', 'suite*'], self.linux_source_mock)
+
+		# Should respect the user's filter glob when listing tests.
+		mock_tests.assert_called_once_with(mock.ANY,
+				     kunit.KunitExecRequest(300, '.kunit', False, 'suite*', None, 'test'))
+		self.linux_source_mock.run_kernel.assert_has_calls([
+			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test1', timeout=300),
+			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test2', timeout=300),
+			mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test1', timeout=300),
+		])
+
 
 if __name__ == '__main__':
 	unittest.main()
-- 
2.33.0.685.g46640cef36-goog

