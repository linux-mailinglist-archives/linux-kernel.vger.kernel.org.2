Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDEF444F1A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 07:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhKDGsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 02:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhKDGqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 02:46:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CEFC0797BB
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 23:43:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m78-20020a252651000000b005c1f44d3c7bso7394106ybm.22
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 23:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KzZeBe+O8SKYymb2H1BN3nOBX8ztzQBCRsWikxLb7wk=;
        b=FZQUUxZNWSDvNS/BTKjZQZBIBSViNnqULGO4e40pX+85w5Sgftch/C5Q+XlgjaN+yE
         tVk4mDPczi+6CD6z/mioI5JA+cY4GjomN4DsPvUbl4rwqzty+DXJLZVw0BMQIYMAX7q2
         CMYIpzj9dynUgfe4RV7W7Qia+3T01gS6D3HzN2JKM2IM0aQQw7654rSCmyOt/3RpRObx
         1HFQpxD40lPYJJtfa+yGovEnTdWSpYlVIUPBT+1Knq/BFlM9UeHJPAZXD7rTUSY2HyQf
         xvpejjJqX5Des1veW1pBVjPjvZJzMmz+Dgp52sqPbcUOykAyiCB1/8ZUksMBJd/UWj9y
         +zHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KzZeBe+O8SKYymb2H1BN3nOBX8ztzQBCRsWikxLb7wk=;
        b=jZp4d362U9+Es2WzSnI7J0jAVJTCb8kyq67sdiXLiMVRIT3/RjcHpTQom06ydQW9H7
         WzMk/w46H2yNKncGYHKln2LScmlDl8IKeJqKgsKA04mA4FRgTuCvsbS+ptGCU1+jgb1v
         f+InvsCk/j3CZyu7ffD3GyN78ckHbBiw82n48Oex4XbnJPPjgz7ZuebrmSeN4C1M/Ch2
         rpkY5aYfSl0lqrf+TNLUDSRwGSeD1hxLsXUJPCceBv7WiVS3r2ryTbJYeg5S8GvT6uNW
         C/7QqVkLeXRVbBn2VodPLtRPE9L9hJIctVzVgQYQEFq5IJTPYywGhpdPeuUsH5B2G9c1
         3XDQ==
X-Gm-Message-State: AOAM5325Pql6CB6KqOdK/Puv1yDqygyt2LAQCfLT4jd5O/aLT9mQ+jO3
        ofCykN4oycRCyNz3xbd7EL7FoL9xy0q4
X-Google-Smtp-Source: ABdhPJzvzyAhGmbbAYoN8rpH+tUKmRC0oOVd9ipehXN0lpWYMc9oAjXdjOmQkYD3C3LWW2fVeNQDXfRVkmDk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8ce:af84:2510:3f29])
 (user=irogers job=sendgmr) by 2002:a25:9c02:: with SMTP id
 c2mr32564801ybo.137.1636008183976; Wed, 03 Nov 2021 23:43:03 -0700 (PDT)
Date:   Wed,  3 Nov 2021 23:42:06 -0700
In-Reply-To: <20211104064208.3156807-1-irogers@google.com>
Message-Id: <20211104064208.3156807-21-irogers@google.com>
Mime-Version: 1.0
References: <20211104064208.3156807-1-irogers@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3 20/22] perf test: TSC test, remove is_supported use
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

Migrate the is_supported functionality to returning TEST_SKIP.
Motivation is kunit has no is_supported function.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/perf-time-to-tsc.c | 39 ++++++++++++-----------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index 594013e94ed0..d12d0ad81801 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -23,6 +23,16 @@
 #include "pmu.h"
 #include "pmu-hybrid.h"
 
+/*
+ * Except x86_64/i386 and Arm64, other archs don't support TSC in perf.  Just
+ * enable the test for x86_64/i386 and Arm64 archs.
+ */
+#if defined(__x86_64__) || defined(__i386__) || defined(__aarch64__)
+#define TSC_IS_SUPPORTED 1
+#else
+#define TSC_IS_SUPPORTED 0
+#endif
+
 #define CHECK__(x) {				\
 	while ((x) < 0) {			\
 		pr_debug(#x " failed!\n");	\
@@ -69,6 +79,11 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
 	u64 test_time, comm1_time = 0, comm2_time = 0;
 	struct mmap *md;
 
+	if (!TSC_IS_SUPPORTED) {
+		pr_debug("Test not supported on this architecture");
+		return TEST_SKIP;
+	}
+
 	threads = thread_map__new(-1, getpid(), UINT_MAX);
 	CHECK_NOT_NULL__(threads);
 
@@ -185,26 +200,4 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
 	return err;
 }
 
-static bool test__tsc_is_supported(void)
-{
-	/*
-	 * Except x86_64/i386 and Arm64, other archs don't support TSC in perf.
-	 * Just enable the test for x86_64/i386 and Arm64 archs.
-	 */
-#if defined(__x86_64__) || defined(__i386__) || defined(__aarch64__)
-	return true;
-#else
-	return false;
-#endif
-}
-
-static struct test_case perf_time_to_tsc_tests[] = {
-	TEST_CASE("Convert perf time to TSC", perf_time_to_tsc),
-	{ .name = NULL, }
-};
-
-struct test_suite suite__perf_time_to_tsc = {
-	.desc = "Convert perf time to TSC",
-	.test_cases = perf_time_to_tsc_tests,
-	.is_supported = test__tsc_is_supported,
-};
+DEFINE_SUITE("Convert perf time to TSC", perf_time_to_tsc);
-- 
2.33.1.1089.g2158813163f-goog

