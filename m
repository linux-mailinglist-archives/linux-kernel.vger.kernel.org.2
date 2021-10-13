Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82ABB42C7F3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 19:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhJMRuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 13:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238372AbhJMRsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 13:48:54 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA76C06176A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:46:51 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s6-20020a254506000000b005b6b6434cd6so3934453yba.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uFzFn60xagd3rvPkgk0DIlO5waExh8qiW5dFaj69kK8=;
        b=ZwCha6xmbTlPL9PnQIHpPFQOLyT7BUafbHmRJfKxnoI1M2eaYS/+UDTwzW/isBDrAQ
         uVVilh3AbhHX6ZJ+ML8OXu1UxqSbWgxfdr1YK/oRkW5cpmdw2Bsr8Qe1lhChLyziA+Bs
         DGfEpvBxjNaDXOnuVlCyXYld5pY0iG4rm18xIEr7sfdZtR28nnFbB+cwZySSSzoHqnX2
         gfYpgRNn9AgsTzRe4NmPj4qlvyFwlejYNshQwT5hzWBkxHu8PIFwMuPL5CvoACsAz/Ih
         /EmQbUTLvKzI4LeIoacvjiz/7G0fNT1eZrjMdxYZy5r6W0JoDXP6r2cMGONg3Jmp/ps8
         DbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uFzFn60xagd3rvPkgk0DIlO5waExh8qiW5dFaj69kK8=;
        b=ohcMPB3oVTqH96sTWH0lqpX1daWu9hjl+R0+1ytWHFNfKl4QxXGeBWKGi8esocQ44a
         aCuxPhBAzbvpNNTJBllGRaUtftqXxKnNO7uBplFXEFz4ZsaWaBCAtMn91ycBi6rhiExS
         zWTU53UgAf45b5//Z5Te2MTKDYEPCdMj7NCss53/HHI+PAnA6Y682ZKVzXRZCwtkmXyH
         JDQ6K55tPhxG/wsEsT+Bo8w0dqysqqjzhgScEqxBYF73RfvWLY0NVx0o+Pi6rX7tmBKu
         luQJK4lon7jangvo932fWT9Tf9drN94L/FlACtzW/IZcu4qOLaVQ0bMWTMeqw23iQ4dI
         EUGw==
X-Gm-Message-State: AOAM530ldAW9kxbAqvbn+GZDkc+U+Ouo2X0tfq+sg+kgXOGCvFpKW1qn
        sMNtYocfeyj0+7nODeC4bNrQjtgQA/Jp
X-Google-Smtp-Source: ABdhPJznb7DRl9KO3PvtGpoj3CvMRVy8+Q9sHKJ+BNu2xNHZ6amVDeA0FPsX6+hDL25dh/Nz6bgs1Bh3WFKX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:aeaf:8e9e:3df2:aad9])
 (user=irogers job=sendgmr) by 2002:a25:bb08:: with SMTP id
 z8mr845563ybg.167.1634147210444; Wed, 13 Oct 2021 10:46:50 -0700 (PDT)
Date:   Wed, 13 Oct 2021 10:45:54 -0700
In-Reply-To: <20211013174604.747276-1-irogers@google.com>
Message-Id: <20211013174604.747276-13-irogers@google.com>
Mime-Version: 1.0
References: <20211013174604.747276-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 12/22] perf test: Convert clang tests to test cases.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use null terminated array of test cases rather than the previous sub
test functions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/clang.c           | 57 +++++++++---------------------
 tools/perf/util/c++/clang-c.h      |  8 ++---
 tools/perf/util/c++/clang-test.cpp |  6 ++--
 3 files changed, 24 insertions(+), 47 deletions(-)

diff --git a/tools/perf/tests/clang.c b/tools/perf/tests/clang.c
index a499fcf37bf9..ba06a2257574 100644
--- a/tools/perf/tests/clang.c
+++ b/tools/perf/tests/clang.c
@@ -3,54 +3,31 @@
 #include "c++/clang-c.h"
 #include <linux/kernel.h>
 
-static struct {
-	int (*func)(void);
-	const char *desc;
-} clang_testcase_table[] = {
-#ifdef HAVE_LIBCLANGLLVM_SUPPORT
-	{
-		.func = test__clang_to_IR,
-		.desc = "builtin clang compile C source to IR",
-	},
-	{
-		.func = test__clang_to_obj,
-		.desc = "builtin clang compile C source to ELF object",
-	},
-#endif
-};
-
-static int test__clang_subtest_get_nr(void)
-{
-	return (int)ARRAY_SIZE(clang_testcase_table);
-}
-
-static const char *test__clang_subtest_get_desc(int i)
-{
-	if (i < 0 || i >= (int)ARRAY_SIZE(clang_testcase_table))
-		return NULL;
-	return clang_testcase_table[i].desc;
-}
-
 #ifndef HAVE_LIBCLANGLLVM_SUPPORT
-static int test__clang(struct test_suite *test __maybe_unused, int i __maybe_unused)
+static int test__clang_to_IR(struct test_suite *test __maybe_unused,
+			     int subtest __maybe_unused)
 {
 	return TEST_SKIP;
 }
-#else
-static int test__clang(struct test_suite *test __maybe_unused, int i)
+
+static int test__clang_to_obj(struct test_suite *test __maybe_unused,
+			      int subtest __maybe_unused)
 {
-	if (i < 0 || i >= (int)ARRAY_SIZE(clang_testcase_table))
-		return TEST_FAIL;
-	return clang_testcase_table[i].func();
+	return TEST_SKIP;
 }
 #endif
 
+static struct test_case clang_tests[] = {
+	TEST_CASE_REASON("builtin clang compile C source to IR", clang_to_IR,
+			 "not compiled in"),
+	TEST_CASE_REASON("builtin clang compile C source to ELF object",
+			 clang_to_obj,
+			 "not compiled in"),
+	{ .name = NULL, }
+};
+
 struct test_suite suite__clang = {
 	.desc = "builtin clang support",
-	.func = test__clang,
-	.subtest = {
-		.skip_if_fail	= true,
-		.get_nr		= test__clang_subtest_get_nr,
-		.get_desc	= test__clang_subtest_get_desc,
-	}
+	.test_cases = clang_tests,
+	.subtest = { .skip_if_fail = true, },
 };
diff --git a/tools/perf/util/c++/clang-c.h b/tools/perf/util/c++/clang-c.h
index 2df8a45bd088..d3731a876b6c 100644
--- a/tools/perf/util/c++/clang-c.h
+++ b/tools/perf/util/c++/clang-c.h
@@ -12,8 +12,9 @@ extern "C" {
 extern void perf_clang__init(void);
 extern void perf_clang__cleanup(void);
 
-extern int test__clang_to_IR(void);
-extern int test__clang_to_obj(void);
+struct test_suite;
+extern int test__clang_to_IR(struct test_suite *test, int subtest);
+extern int test__clang_to_obj(struct test_suite *test, int subtest);
 
 extern int perf_clang__compile_bpf(const char *filename,
 				   void **p_obj_buf,
@@ -26,9 +27,6 @@ extern int perf_clang__compile_bpf(const char *filename,
 static inline void perf_clang__init(void) { }
 static inline void perf_clang__cleanup(void) { }
 
-static inline int test__clang_to_IR(void) { return -1; }
-static inline int test__clang_to_obj(void) { return -1;}
-
 static inline int
 perf_clang__compile_bpf(const char *filename __maybe_unused,
 			void **p_obj_buf __maybe_unused,
diff --git a/tools/perf/util/c++/clang-test.cpp b/tools/perf/util/c++/clang-test.cpp
index 21b23605f78b..a4683ca53697 100644
--- a/tools/perf/util/c++/clang-test.cpp
+++ b/tools/perf/util/c++/clang-test.cpp
@@ -35,7 +35,8 @@ __test__clang_to_IR(void)
 }
 
 extern "C" {
-int test__clang_to_IR(void)
+int test__clang_to_IR(struct test_suite *test __maybe_unused,
+                      int subtest __maybe_unused)
 {
 	perf_clang_scope _scope;
 
@@ -48,7 +49,8 @@ int test__clang_to_IR(void)
 	return -1;
 }
 
-int test__clang_to_obj(void)
+int test__clang_to_obj(struct test_suite *test __maybe_unused,
+                       int subtest __maybe_unused)
 {
 	perf_clang_scope _scope;
 
-- 
2.33.0.882.g93a45727a2-goog

