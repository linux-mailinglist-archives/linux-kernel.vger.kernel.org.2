Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D4B42C7EF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 19:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238595AbhJMRtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 13:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238339AbhJMRsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 13:48:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E645C061749
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:46:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i83-20020a256d56000000b005b706d1417bso3981291ybc.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bHAJtKkcVsMu8DZqKFD4eZSofJUECoUVGeIvM/aoNWk=;
        b=EK1ofqXwNClA/J3yP1+yhMQUEifyj1f39xYcX0IfcjcpT1BsDsR4BMNixyJLPPgt2p
         s3vLS5KaXMSceBsHEVXkwmkvyvsvO1rNRp2bzKHd/1MnlrOSIS4wxvsmsFrpC91tt8BW
         CchdtlNf2L3fPkUSDOdF20wsCbNwr0c/UbK6EhgURFU+Ir3GUMo6B9t9fQsX85dy4Jtt
         bnUqlsAFJLGuaVXH9/OIMB/P+sO71LfCjXdrzyqINF8MM6ibMmTHRQrRZ8A6ee97daaA
         BHj9G/Wp/YDz00dPg5I+WqAfwXQx2Apthd0225uzxlLO0AiXTGEEml5vqFI+K6LYfGVN
         Ws3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bHAJtKkcVsMu8DZqKFD4eZSofJUECoUVGeIvM/aoNWk=;
        b=QCxVp0nUB4Y7ZFdedAD19W2UGEJyC4RVXm5z6GKUPG0zBIhoIuYg2OhDtnK8M2hBJz
         OTOAK6qggSFU8uUMp+yJ9So22s5hry02RxaE1sb37crdyubO8zVEGT7qPsKTg28Slzhm
         8xzQ25dx2Xk0tIeJDAUSHe8XL7hcp7Vxr3QUVd+GsbtgsLwCWBV8YjtNMp5TadEtE8AN
         NI1TS4QPGSdq+lh5Cg2Ly61o6ZmoRCoDTd5Z0pPy6UNRc8sL6179C2OO3ZJawjyfYNI+
         J6WkrG9mO5IjwWr+w6t+iG1V0AIGf0cWXdp7x4iRBYtn1A3kPs29BFRmNa22IKiQjsAE
         Q7cw==
X-Gm-Message-State: AOAM533C9lSBvqmRlWojCN5bu5MVk1XTNUw0jSW3aaoKrW49IzmAlMkl
        xvcccR/bVKrIW/2pxYvvLQW/Bb+5LNPH
X-Google-Smtp-Source: ABdhPJwz36aiH5OHL7zO3E+8aw8LSzWyfiBot4l2WZ+bPb22Wt3yLch4dt4czfzFMkpD4ffqj/joO6VJr/iK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:aeaf:8e9e:3df2:aad9])
 (user=irogers job=sendgmr) by 2002:a25:2681:: with SMTP id
 m123mr864421ybm.7.1634147205665; Wed, 13 Oct 2021 10:46:45 -0700 (PDT)
Date:   Wed, 13 Oct 2021 10:45:52 -0700
In-Reply-To: <20211013174604.747276-1-irogers@google.com>
Message-Id: <20211013174604.747276-11-irogers@google.com>
Mime-Version: 1.0
References: <20211013174604.747276-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 10/22] perf test: Convert pmu event tests to test cases.
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
 tools/perf/tests/pmu-events.c | 78 +++++++----------------------------
 1 file changed, 16 insertions(+), 62 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index fed399f76eaa..d568d9ff1b45 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -418,7 +418,8 @@ static int compare_alias_to_test_event(struct perf_pmu_alias *alias,
 }
 
 /* Verify generated events from pmu-events.c are as expected */
-static int test_pmu_event_table(void)
+static int test__pmu_event_table(struct test_suite *test __maybe_unused,
+				 int subtest __maybe_unused)
 {
 	struct pmu_event *sys_event_tables = __test_pmu_get_sys_events_table();
 	struct pmu_events_map *map = __test_pmu_get_events_map();
@@ -705,7 +706,8 @@ static struct perf_pmu_test_pmu test_pmus[] = {
 };
 
 /* Test that aliases generated are as expected */
-static int test_aliases(void)
+static int test__aliases(struct test_suite *test __maybe_unused,
+			int subtest __maybe_unused)
 {
 	struct perf_pmu *pmu = NULL;
 	unsigned long i;
@@ -883,7 +885,8 @@ static int resolve_metric_simple(struct expr_parse_ctx *pctx,
 
 }
 
-static int test_parsing(void)
+static int test__parsing(struct test_suite *test __maybe_unused,
+			 int subtest __maybe_unused)
 {
 	struct pmu_events_map *cpus_map = pmu_events_map__find();
 	struct pmu_events_map *map;
@@ -1025,7 +1028,8 @@ static int metric_parse_fake(const char *str)
  * or all defined cpus via the 'fake_pmu'
  * in parse_events.
  */
-static int test_parsing_fake(void)
+static int test__parsing_fake(struct test_suite *test __maybe_unused,
+			      int subtest __maybe_unused)
 {
 	struct pmu_events_map *map;
 	struct pmu_event *pe;
@@ -1059,66 +1063,16 @@ static int test_parsing_fake(void)
 	return 0;
 }
 
-static const struct {
-	int (*func)(void);
-	const char *desc;
-} pmu_events_testcase_table[] = {
-	{
-		.func = test_pmu_event_table,
-		.desc = "PMU event table sanity",
-	},
-	{
-		.func = test_aliases,
-		.desc = "PMU event map aliases",
-	},
-	{
-		.func = test_parsing,
-		.desc = "Parsing of PMU event table metrics",
-	},
-	{
-		.func = test_parsing_fake,
-		.desc = "Parsing of PMU event table metrics with fake PMUs",
-	},
+static struct test_case pmu_events_tests[] = {
+	TEST_CASE("PMU event table sanity", pmu_event_table),
+	TEST_CASE("PMU event map aliases", aliases),
+	TEST_CASE_REASON("Parsing of PMU event table metrics", parsing,
+			 "some metrics failed"),
+	TEST_CASE("Parsing of PMU event table metrics with fake PMUs", parsing_fake),
+	{ .name = NULL, }
 };
 
-static const char *test__pmu_events_subtest_get_desc(int subtest)
-{
-	if (subtest < 0 ||
-	    subtest >= (int)ARRAY_SIZE(pmu_events_testcase_table))
-		return NULL;
-	return pmu_events_testcase_table[subtest].desc;
-}
-
-static const char *test__pmu_events_subtest_skip_reason(int subtest)
-{
-	if (subtest < 0 ||
-	    subtest >= (int)ARRAY_SIZE(pmu_events_testcase_table))
-		return NULL;
-	if (pmu_events_testcase_table[subtest].func != test_parsing)
-		return NULL;
-	return "some metrics failed";
-}
-
-static int test__pmu_events_subtest_get_nr(void)
-{
-	return (int)ARRAY_SIZE(pmu_events_testcase_table);
-}
-
-static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest)
-{
-	if (subtest < 0 ||
-	    subtest >= (int)ARRAY_SIZE(pmu_events_testcase_table))
-		return TEST_FAIL;
-	return pmu_events_testcase_table[subtest].func();
-}
-
 struct test_suite suite__pmu_events = {
 	.desc = "PMU events",
-	.func = test__pmu_events,
-	.subtest = {
-		.skip_if_fail	= false,
-		.get_nr		= test__pmu_events_subtest_get_nr,
-		.get_desc	= test__pmu_events_subtest_get_desc,
-		.skip_reason	= test__pmu_events_subtest_skip_reason,
-	},
+	.test_cases = pmu_events_tests,
 };
-- 
2.33.0.882.g93a45727a2-goog

