Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225A342C7F0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 19:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238183AbhJMRtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 13:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238353AbhJMRsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 13:48:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9EBC061765
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:46:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f8-20020a2585480000b02905937897e3daso4005841ybn.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=20NkMtl5/oTCCyaEx9qoGNfehKf4AvL562g0n/D7+k4=;
        b=mhGs12CoZ8jFI7TJ7cV8n0CfCBqrVA7ZOGgqphbnhbxrTiEw2o826utYaMmT6rSM/u
         KaZdpqar6aA9FNiwq09s/XnliDmIGLXzG8D8Ug3BXn9f1Cd7pWmg2OVM1xcQ1ax4Betq
         BZwzAoTFWSZXJ44K9ToUGRsh3BMwFFHqqjvu2QwcdtdBC6k375OzyU4PXM6FicooCnuX
         y6g5WcjB0vrdSs3d61F5KpCr+9vBBJuVm+073J2Vjf+tkNyiAi8u8Qon9ywisY2RKt02
         bj++03JP36PC335PVISJXyPSuk8QbbCsrgJjwccVxMObUL9FeE/YdTrtQPMhPJhK1Lm/
         S+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=20NkMtl5/oTCCyaEx9qoGNfehKf4AvL562g0n/D7+k4=;
        b=KYJ8FtoafgiEbwwDTSz9RhVkUYdbefCaWBOzWJZkW39wT9hOsi47E1JlutGHHSZziX
         /CZbOhPG/+q0WFoNpGct9NOGU+/GX6nYywIZDGXDYjYPWHFjxG8pjbBTfBxu5ZlEG1Uy
         7+OHJDTI0oXHvgVHeQPmtwDDpYxCgtui9YLV9hruHjrfrx6hu2++lISuThI4u6Fc7Znl
         DCBZunLbmYI7OuCAups3jBGsx74jAv0tn/zY2G8ppPy6RuGkh/Jz9iqBygaMgydw9lKF
         os5cGibp8nDvKbS5Aoxcgd0646q204w/TeHrA/vsI0HYG3S9K7/aThMSp09qg4sHP1dT
         Uz1g==
X-Gm-Message-State: AOAM530c/LCzYtMmeDDY9tdEHzfvzek5tIEfQJDPxiuJTLtrpiYXZz1l
        8jS03LYT+BBtXuRdOU5rGKqwM+4zIJYB
X-Google-Smtp-Source: ABdhPJztf/6hO54+f74TzKTddFaGhF2G+BcE+CO3NEBZ/78xnZ3vndQYPrBKWOpvu4aLFx7IKPt2g6m/r7ub
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:aeaf:8e9e:3df2:aad9])
 (user=irogers job=sendgmr) by 2002:a25:b4d:: with SMTP id 74mr715977ybl.443.1634147208097;
 Wed, 13 Oct 2021 10:46:48 -0700 (PDT)
Date:   Wed, 13 Oct 2021 10:45:53 -0700
In-Reply-To: <20211013174604.747276-1-irogers@google.com>
Message-Id: <20211013174604.747276-12-irogers@google.com>
Mime-Version: 1.0
References: <20211013174604.747276-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 11/22] perf test: Convert watch point tests to test cases.
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
 tools/perf/tests/wp.c | 128 ++++++++++--------------------------------
 1 file changed, 30 insertions(+), 98 deletions(-)

diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
index 904bdf2dcf81..2c0513257b15 100644
--- a/tools/perf/tests/wp.c
+++ b/tools/perf/tests/wp.c
@@ -62,8 +62,12 @@ static int __event(int wp_type, void *wp_addr, unsigned long wp_len)
 	return fd;
 }
 
-static int wp_ro_test(void)
+static int test__wp_ro(struct test_suite *test __maybe_unused,
+		       int subtest __maybe_unused)
 {
+#if defined(__s390x__) || defined(__x86_64__) || defined(__i386__)
+	return TEST_SKIP;
+#else
 	int fd;
 	unsigned long tmp, tmp1 = rand();
 
@@ -79,10 +83,15 @@ static int wp_ro_test(void)
 
 	close(fd);
 	return 0;
+#endif
 }
 
-static int wp_wo_test(void)
+static int test__wp_wo(struct test_suite *test __maybe_unused,
+		       int subtest __maybe_unused)
 {
+#if defined(__s390x__)
+	return TEST_SKIP;
+#else
 	int fd;
 	unsigned long tmp, tmp1 = rand();
 
@@ -98,10 +107,15 @@ static int wp_wo_test(void)
 
 	close(fd);
 	return 0;
+#endif
 }
 
-static int wp_rw_test(void)
+static int test__wp_rw(struct test_suite *test __maybe_unused,
+		       int subtest __maybe_unused)
 {
+#if defined(__s390x__)
+	return TEST_SKIP;
+#else
 	int fd;
 	unsigned long tmp, tmp1 = rand();
 
@@ -118,10 +132,15 @@ static int wp_rw_test(void)
 
 	close(fd);
 	return 0;
+#endif
 }
 
-static int wp_modify_test(void)
+static int test__wp_modify(struct test_suite *test __maybe_unused,
+			   int subtest __maybe_unused)
 {
+#if defined(__s390x__)
+	return TEST_SKIP;
+#else
 	int fd, ret;
 	unsigned long tmp = rand();
 	struct perf_event_attr new_attr;
@@ -163,105 +182,18 @@ static int wp_modify_test(void)
 
 	close(fd);
 	return 0;
-}
-
-static bool wp_ro_supported(void)
-{
-#if defined (__x86_64__) || defined (__i386__)
-	return false;
-#else
-	return true;
-#endif
-}
-
-static const char *wp_ro_skip_msg(void)
-{
-#if defined (__x86_64__) || defined (__i386__)
-	return "missing hardware support";
-#else
-	return NULL;
 #endif
 }
 
-static struct {
-	const char *desc;
-	int (*target_func)(void);
-	bool (*is_supported)(void);
-	const char *(*skip_msg)(void);
-} wp_testcase_table[] = {
-	{
-		.desc = "Read Only Watchpoint",
-		.target_func = &wp_ro_test,
-		.is_supported = &wp_ro_supported,
-		.skip_msg = &wp_ro_skip_msg,
-	},
-	{
-		.desc = "Write Only Watchpoint",
-		.target_func = &wp_wo_test,
-	},
-	{
-		.desc = "Read / Write Watchpoint",
-		.target_func = &wp_rw_test,
-	},
-	{
-		.desc = "Modify Watchpoint",
-		.target_func = &wp_modify_test,
-	},
+static struct test_case wp_tests[] = {
+	TEST_CASE_REASON("Read Only Watchpoint", wp_ro, "missing hardware support"),
+	TEST_CASE_REASON("Write Only Watchpoint", wp_wo, "missing hardware support"),
+	TEST_CASE_REASON("Read / Write Watchpoint", wp_rw, "missing hardware support"),
+	TEST_CASE_REASON("Modify Watchpoint", wp_modify, "missing hardware support"),
+	{ .name = NULL, }
 };
 
-static int test__wp_subtest_get_nr(void)
-{
-	return (int)ARRAY_SIZE(wp_testcase_table);
-}
-
-static const char *test__wp_subtest_get_desc(int i)
-{
-	if (i < 0 || i >= (int)ARRAY_SIZE(wp_testcase_table))
-		return NULL;
-	return wp_testcase_table[i].desc;
-}
-
-static const char *test__wp_subtest_skip_reason(int i)
-{
-	if (i < 0 || i >= (int)ARRAY_SIZE(wp_testcase_table))
-		return NULL;
-	if (!wp_testcase_table[i].skip_msg)
-		return NULL;
-	return wp_testcase_table[i].skip_msg();
-}
-
-static int test__wp(struct test_suite *test __maybe_unused, int i)
-{
-	if (i < 0 || i >= (int)ARRAY_SIZE(wp_testcase_table))
-		return TEST_FAIL;
-
-	if (wp_testcase_table[i].is_supported &&
-	    !wp_testcase_table[i].is_supported())
-		return TEST_SKIP;
-
-	return !wp_testcase_table[i].target_func() ? TEST_OK : TEST_FAIL;
-}
-
-/* The s390 so far does not have support for
- * instruction breakpoint using the perf_event_open() system call.
- */
-static bool test__wp_is_supported(void)
-{
-#if defined(__s390x__)
-	return false;
-#else
-	return true;
-#endif
-}
-
 struct test_suite suite__wp = {
 	.desc = "Watchpoint",
-	.func = test__wp,
-	.is_supported = test__wp_is_supported,
-	.subtest = {
-		.skip_if_fail	= false,
-		.get_nr		= test__wp_subtest_get_nr,
-		.get_desc	= test__wp_subtest_get_desc,
-		.skip_reason    = test__wp_subtest_skip_reason,
-	},
+	.test_cases = wp_tests,
 };
-- 
2.33.0.882.g93a45727a2-goog

