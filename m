Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64719310065
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 23:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhBDW4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 17:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhBDW4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 17:56:16 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99644C061793
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 14:54:59 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id n123so3457195pfn.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 14:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=M0j63Y+dGrapku6v2TeatocmD7eQzHpeOBCsoHcCmr8=;
        b=ZTYXSsgggGJz5jGj8p6Ols2kXiqqWJ7Hf1B/onFHGGkZxzizQdPOQQv7QnZXz7i57R
         f59xM0Pb19jW1IkNItgm1FtQ1HzlPWrizu/VriIAAWZ+R4UW/MqRMKGmAGByCJKdCcMW
         YWY9i+HbzqrS1Mw3QwvE6eRFZHJqrMpiZJmNKtVbQDdbaI2ceY7dE6bSe5R9nO0Y/W90
         L6D2d/KnrPj/2Qj1NOmWZzUulbybc4a06iqPmnsvmpC7SMW21WE4UAePOGjjcdGknwsB
         T664uNXsY8Qje7+o/NfqkwBfK7cHq8heh2tep/KhoKV2aAjryzhG/GZZsRjeipovKgnq
         lYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=M0j63Y+dGrapku6v2TeatocmD7eQzHpeOBCsoHcCmr8=;
        b=r2w0QeVbML87XytyOtHkVTBcMBCGzYJSo6TfsA6mq0eHUv2UFNFM69Y58EGNTUQfuP
         BJTifou4WUDjnbRZOAO0EOyS/tXeEeXPPjpec1Yo/+eBJOM9Ev71u4gP1PwGvKSbfYwl
         8ZD8W4uAKLaL2RfE5uMIU/gVWUjE8OXXBXOFoT0HZFI+656IojRfMRuhXCYoQOC/tqcz
         cKbzrJjGZTkitrCqnujEkZvY7z/kFMN2YkfXBL6J/2qOztaiuUH8cILlE4xfNefdCoO1
         BIIrFK7AJCV1YsgYWJeoAG80nPWzArIGC8x4RqtA0z2e8OPvo15u2HHILJqde7eSut+z
         ihbg==
X-Gm-Message-State: AOAM530DtU556+65x/tPFpS0Q2OUPPmrHlRUwwaECjprfT3PrD/7p/+x
        uugFsYHkNk5hKMZO21WHd0TvUqGRuUymeA==
X-Google-Smtp-Source: ABdhPJzGDJJb99I4uPs0OtacvEjb+GqAyjJeAQCifyLhXhsh82fYNZkotlFKA2eeDEt/b2U2ya+6tJl85WcLUA==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:bd7a:7717:5b5b:de27])
 (user=dlatypov job=sendgmr) by 2002:a17:90a:aa8a:: with SMTP id
 l10mr1274505pjq.86.1612479298500; Thu, 04 Feb 2021 14:54:58 -0800 (PST)
Date:   Thu,  4 Feb 2021 14:54:47 -0800
In-Reply-To: <20210204225448.1393741-1-dlatypov@google.com>
Message-Id: <20210204225448.1393741-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20210204225448.1393741-1-dlatypov@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v3 2/3] kunit: tool: add support for filtering suites by glob
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
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
 tools/testing/kunit/kunit.py        | 21 ++++++++++++++++-----
 tools/testing/kunit/kunit_kernel.py |  4 +++-
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index e808a47c839b..a15ee33bb1f5 100755
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
@@ -197,6 +198,14 @@ def add_exec_opts(parser) -> None:
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
@@ -263,6 +272,7 @@ def main(argv, linux=None):
 				       cli_args.jobs,
 				       cli_args.build_dir,
 				       cli_args.alltests,
+				       cli_args.filter_glob,
 				       cli_args.json,
 				       cli_args.make_options)
 		result = run_tests(linux, request)
@@ -304,7 +314,8 @@ def main(argv, linux=None):
 
 		exec_request = KunitExecRequest(cli_args.timeout,
 						cli_args.build_dir,
-						cli_args.alltests)
+						cli_args.alltests,
+						cli_args.filter_glob)
 		exec_result = exec_tests(linux, exec_request)
 		parse_request = KunitParseRequest(cli_args.raw_output,
 						  exec_result.result,
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 2076a5a2d060..71b1942f5ccd 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -199,8 +199,10 @@ class LinuxSourceTree(object):
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
-- 
2.30.0.478.g8a0d178c01-goog

