Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641AF311AF6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhBFEhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbhBFCbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:31:19 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B41BC08EE1B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 16:09:08 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e62so8981872yba.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 16:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=hrmYfsz4IvvgTuDdChS4oTMm8sIONWMJAPQ5RCHlDBU=;
        b=oXQJ9vo72AOZRHUu3zlqMS9gRvI6TmGZWTdPipOdvqjDGbaC4qLYUAoe1I8I0lFQ0t
         PCsR/JRU2D2e2fJ6WXTq2Z4YUrH2KuVhsCDpY6Tr2i/rfrFLLeMDeKEqxCBS6Ecgv+OA
         ABPqo+4OZOcWmmAak+ZKd2HZx0QqcyrzWlrMahsHJKN5qwjOild7ztnmh9w2p5gaTHrH
         6YTzh7b4IFg94BG2e1gGEySiVtvpYkJJczWklcAGIBSEz9bah7uFdZGIv6FGbdnv10S5
         BveqG/r336wftq2vDMYJXubCdon9OWE7LSvMRybxHomH3Nxll3WNimiSXZ8BzzJrAcP9
         y9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hrmYfsz4IvvgTuDdChS4oTMm8sIONWMJAPQ5RCHlDBU=;
        b=h9zb3r9b9cQZNm44aKqUiph8lLSfjX51TV0XdMJx8ifiz3oBIApoLnMWFKSuE20exG
         rj9q+QHtq1vAKguNHK2rsRSF95zi1Ri4c37gut5f91H2cgFcTxikrU9eQOkXUvm8UFTO
         QFHHmbFn3NYV511tx5XVO6B9+KVktRJXIA6YFNg6r1UIYh8mnLObTdhuqctH+dw87Rsk
         WIM+6+YAnMTSieLm/ukHEPqgo9GQhHBphWsKpOBU5TyWb4lVUGNaWBJdUYeogfWaqB0B
         9biv5HURYGa49GsrssC+tw2VvHeohegbLaJ7knmU+M2cCKyx6pyS5wDDU49Wd9P3vcI0
         wQ8w==
X-Gm-Message-State: AOAM531JYxDDYnW6MLtxUoga9v9R+m5esHACGri+M5RfpIXL6H5tbwue
        BKcDsJGP5iK/3lZLrLUwidknp9CPRwvGdg==
X-Google-Smtp-Source: ABdhPJyCRRTRIyypZyx33dYUQlChl0qB8Ty9SbMIMnfMzjk1CwTo2Nz9sRnpaOzHq0jCUtXSKzCNHDKDEJQ6Cw==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a8b1:128a:69fa:86fb])
 (user=dlatypov job=sendgmr) by 2002:a25:9ac4:: with SMTP id
 t4mr9764076ybo.296.1612570147839; Fri, 05 Feb 2021 16:09:07 -0800 (PST)
Date:   Fri,  5 Feb 2021 16:08:53 -0800
In-Reply-To: <20210206000854.2037923-1-dlatypov@google.com>
Message-Id: <20210206000854.2037923-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20210206000854.2037923-1-dlatypov@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v4 2/3] kunit: tool: add support for filtering suites by glob
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows running different subsets of tests, e.g.

$ ./tools/testing/kunit/kunit.py build
$ ./tools/testing/kunit/kunit.py exec 'list*'
$ ./tools/testing/kunit/kunit.py exec 'kunit*'

This passes the "kunit_filter.glob" commandline option to the UML
kernel, which currently only supports filtering by suite name.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit.py           | 21 ++++++++++++++++-----
 tools/testing/kunit/kunit_kernel.py    |  4 +++-
 tools/testing/kunit/kunit_tool_test.py | 15 +++++++++------
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 02871a363f76..d5144fcb03ac 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -28,12 +28,12 @@ KunitBuildRequest = namedtuple('KunitBuildRequest',
 			       ['jobs', 'build_dir', 'alltests',
 				'make_options'])
 KunitExecRequest = namedtuple('KunitExecRequest',
-			      ['timeout', 'build_dir', 'alltests'])
+			      ['timeout', 'build_dir', 'alltests', 'filter_glob'])
 KunitParseRequest = namedtuple('KunitParseRequest',
 			       ['raw_output', 'input_data', 'build_dir', 'json'])
 KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs',
-					   'build_dir', 'alltests', 'json',
-					   'make_options'])
+					   'build_dir', 'alltests', 'filter_glob',
+					   'json', 'make_options'])
 
 KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
 
@@ -93,6 +93,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree,
 	test_start = time.time()
 	result = linux.run_kernel(
 		timeout=None if request.alltests else request.timeout,
+                filter_glob=request.filter_glob,
 		build_dir=request.build_dir)
 
 	test_end = time.time()
@@ -149,7 +150,7 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 		return build_result
 
 	exec_request = KunitExecRequest(request.timeout, request.build_dir,
-					request.alltests)
+					request.alltests, request.filter_glob)
 	exec_result = exec_tests(linux, exec_request)
 	if exec_result.status != KunitStatus.SUCCESS:
 		return exec_result
@@ -200,6 +201,14 @@ def add_exec_opts(parser) -> None:
 			    type=int,
 			    default=300,
 			    metavar='timeout')
+	parser.add_argument('filter_glob',
+			    help='maximum number of seconds to allow for all tests '
+			    'to run. This does not include time taken to build the '
+			    'tests.',
+			    type=str,
+			    nargs='?',
+			    default='',
+			    metavar='filter_glob')
 
 def add_parse_opts(parser) -> None:
 	parser.add_argument('--raw_output', help='don\'t format output from kernel',
@@ -266,6 +275,7 @@ def main(argv, linux=None):
 				       cli_args.jobs,
 				       cli_args.build_dir,
 				       cli_args.alltests,
+				       cli_args.filter_glob,
 				       cli_args.json,
 				       cli_args.make_options)
 		result = run_tests(linux, request)
@@ -307,7 +317,8 @@ def main(argv, linux=None):
 
 		exec_request = KunitExecRequest(cli_args.timeout,
 						cli_args.build_dir,
-						cli_args.alltests)
+						cli_args.alltests,
+						cli_args.filter_glob)
 		exec_result = exec_tests(linux, exec_request)
 		parse_request = KunitParseRequest(cli_args.raw_output,
 						  exec_result.result,
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 0b461663e7d9..71a5f5c1750b 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -203,8 +203,10 @@ class LinuxSourceTree(object):
 			return False
 		return self.validate_config(build_dir)
 
-	def run_kernel(self, args=[], build_dir='', timeout=None) -> Iterator[str]:
+	def run_kernel(self, args=[], build_dir='', filter_glob='', timeout=None) -> Iterator[str]:
 		args.extend(['mem=1G', 'console=tty'])
+		if filter_glob:
+			args.append('kunit.filter_glob='+filter_glob)
 		self._ops.linux_bin(args, timeout, build_dir)
 		outfile = get_outfile_path(build_dir)
 		subprocess.call(['stty', 'sane'])
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 251bb0b4bc2e..1ad3049e9069 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -315,7 +315,8 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['exec'], self.linux_source_mock)
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 0)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
-		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='.kunit', timeout=300)
+		self.linux_source_mock.run_kernel.assert_called_once_with(
+			build_dir='.kunit', filter_glob='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_passes_args_pass(self):
@@ -323,7 +324,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			build_dir='.kunit', timeout=300)
+			build_dir='.kunit', filter_glob='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_exec_passes_args_fail(self):
@@ -361,7 +362,8 @@ class KUnitMainTest(unittest.TestCase):
 	def test_exec_timeout(self):
 		timeout = 3453
 		kunit.main(['exec', '--timeout', str(timeout)], self.linux_source_mock)
-		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='.kunit', timeout=timeout)
+		self.linux_source_mock.run_kernel.assert_called_once_with(
+			build_dir='.kunit', filter_glob='', timeout=timeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_timeout(self):
@@ -369,7 +371,7 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['run', '--timeout', str(timeout)], self.linux_source_mock)
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			build_dir='.kunit', timeout=timeout)
+			build_dir='.kunit', filter_glob='', timeout=timeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_builddir(self):
@@ -377,7 +379,7 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['run', '--build_dir=.kunit'], self.linux_source_mock)
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			build_dir=build_dir, timeout=300)
+			build_dir=build_dir, filter_glob='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_config_builddir(self):
@@ -393,7 +395,8 @@ class KUnitMainTest(unittest.TestCase):
 	def test_exec_builddir(self):
 		build_dir = '.kunit'
 		kunit.main(['exec', '--build_dir', build_dir], self.linux_source_mock)
-		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir=build_dir, timeout=300)
+		self.linux_source_mock.run_kernel.assert_called_once_with(
+			build_dir=build_dir, filter_glob='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	@mock.patch.object(kunit_kernel, 'LinuxSourceTree')
-- 
2.30.0.478.g8a0d178c01-goog

