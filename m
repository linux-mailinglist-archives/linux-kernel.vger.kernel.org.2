Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014B8444F10
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 07:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbhKDGrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 02:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbhKDGpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 02:45:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAE3C061234
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 23:42:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x16-20020a25b910000000b005b6b7f2f91cso7614644ybj.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 23:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GKJf8Yw6nAvyH7L7LWtVnPqoYfvwfYxKaTQQ4i15vnw=;
        b=G38y6tdBeOqfNqLclHL6MJStzEFiBNg203t3YGe7yEATwZ/h8UQndsBxusWTDTDzT/
         rVpdbXa5xnOF3exP0inMxehyxgoAnWJAGFTbmQC8Hc30Jg9SGCk2gbEqc0hADgQc9Jby
         1D5Pqr94JLEk22lvIg0b8TInDXiOdTU3sLwz2GAPFtuq6y4N4nmkcykY1ehRwu+I19Bl
         IYWZvBt4pc39f+ghkPfbbtIFBA52GN2lopwfXSajKFd67a7uf48DZxzqUd2biroqOE+Q
         2RDPNZcbp0SDTVuNdcZAkY6LrcRxG2w9mvn6MM4FTTK9F9/Cjh7JtKYmvdzoL+b4lZcE
         ga6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GKJf8Yw6nAvyH7L7LWtVnPqoYfvwfYxKaTQQ4i15vnw=;
        b=QoJiLiTY/PdN4Qpos48Y3wDD94eU8Yj8ovcQGZVFaYgUW2QReUODRlk/QLF0atSIJf
         mV6uF1zHVFY9QnHXt+EC2rTcrS/ZzfqElMIHQFHGjAo1qdlqnCS/n5LIpzg0C5guAI4A
         XJ6R9Uym6vYKCyqFVwlON6l2iy0+9RBnqlysgfasIx9j1qfy6fuAOAiGJLvdRoM70OSv
         v/evtQ34HMJIbrsATucTSxpiAj4S+arprQ0Ssg/Piz6+P1xBMJqE0LuXiVGYdEMF764q
         YLb6PuFTwpBYC89rIbicRQpIP4knFDK91vLXska12uhPU4tSS2vAqmq4AfFIXpIuw/oK
         RE1g==
X-Gm-Message-State: AOAM533PHEiyFny+o/PK6zE2JSyTaU19e+1NHvFmu8yGnhN2KcgeE58Q
        cWXUebn868HvKCKKoQmlAcC+5yLpOeoo
X-Google-Smtp-Source: ABdhPJwvxhGUs8qT6o1qXj0hFaxADubdJNS3RcNfw6stMxv0lpgPwWe9znpjjDYLclDuTHnjp/NX48k5FfFX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8ce:af84:2510:3f29])
 (user=irogers job=sendgmr) by 2002:a5b:145:: with SMTP id c5mr51349264ybp.60.1636008164141;
 Wed, 03 Nov 2021 23:42:44 -0700 (PDT)
Date:   Wed,  3 Nov 2021 23:41:58 -0700
In-Reply-To: <20211104064208.3156807-1-irogers@google.com>
Message-Id: <20211104064208.3156807-13-irogers@google.com>
Mime-Version: 1.0
References: <20211104064208.3156807-1-irogers@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3 12/22] perf test: Convert clang tests to test cases.
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
        David Gow <davidgow@google.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>
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
2.33.1.1089.g2158813163f-goog

