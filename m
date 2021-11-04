Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F53A444F0B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 07:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhKDGqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 02:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhKDGpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 02:45:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76164C06127A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 23:42:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z2-20020a254c02000000b005b68ef4fe24so7457322yba.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 23:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0g5O3hehOKwr7XSv2DOlaGGXEdP4vxrZBtdGl60mP00=;
        b=Z4f7o9prPhB5f5Vc20QA++cA5IC32LflgRBfprWhme4StF80NSJS2OMG8RerfW2Gc3
         XSvEPlIeGWV1KSfS31s8qUW0/UEV2KdwK7BNMBfKol+83EtJkhAPCKFQ4TZcLzRpSovE
         LI7+zRHTto3Qo4X5CIwpMZ5+MWt62fyKKwKaJuVwH0WZ6BArQT9NIiOVbQLSqRFcezYf
         avG9u82uCRyJwC8EAhVIsONMZBq4+R1BxV29znjwdt1Y1tdi1kYt8cb/BgoDXF4WCWW9
         L4JMbGa5GeihuZt984CMoMn25QZ74yePFUT8KGVYoqmWV1jQDcgFRzALfJ7j//v4Xv7t
         LlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0g5O3hehOKwr7XSv2DOlaGGXEdP4vxrZBtdGl60mP00=;
        b=u0zQTw4GmM450Nan3TU5C3P5Td9txzXHotf3wsIPPnZhy9/Zm8ZFeBIFhnRDFHwRjf
         +eoIasSrMFa0b1TLk8S250UFzSOzBdSjR2cDn7LlIPeHWkXPOJ+80RCy177FTHMt23JG
         04ALmFBOzJj3PyLLHJUzX4Y8jBQnu365yfCJGCVj8sFng75NmWDJT4bRWBFDa613x9WT
         bdn3lBIIiymFZ5SDtyn7ZhYcYHZ8PT6SEPVIa6IhLMfXCIv65agdx9fAenh5oHcWmHjT
         xdJIqealt07SwX0fStDl0dGYGZrP3HE673ikuaq27f2WcVj3CJX6OuMemQCxs4KLWaen
         dkeA==
X-Gm-Message-State: AOAM5304sC0Hn3n9aPHX9PhCiEyDMIAL5M/2FFfFetd9Wa/T/7/OGohm
        nu6fxmVM2Mfic6D7gjQwKR98SCc009Dp
X-Google-Smtp-Source: ABdhPJyxWzWUi+Nzlbm+IyoZKx/hBjJG/ep/2RI4nfoYOUTDxZw9lM3RkWktVZbhkA3BkmbMFpSmuw06J+y0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8ce:af84:2510:3f29])
 (user=irogers job=sendgmr) by 2002:a25:ec06:: with SMTP id
 j6mr36168538ybh.238.1636008156691; Wed, 03 Nov 2021 23:42:36 -0700 (PDT)
Date:   Wed,  3 Nov 2021 23:41:55 -0700
In-Reply-To: <20211104064208.3156807-1-irogers@google.com>
Message-Id: <20211104064208.3156807-10-irogers@google.com>
Mime-Version: 1.0
References: <20211104064208.3156807-1-irogers@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3 09/22] perf test: Convert pfm tests to use test cases.
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
 tools/perf/tests/pfm.c | 66 ++++++++++++------------------------------
 1 file changed, 19 insertions(+), 47 deletions(-)

diff --git a/tools/perf/tests/pfm.c b/tools/perf/tests/pfm.c
index f55e4ecdda71..651fee4ef819 100644
--- a/tools/perf/tests/pfm.c
+++ b/tools/perf/tests/pfm.c
@@ -11,27 +11,6 @@
 
 #include <linux/kernel.h>
 
-#ifdef HAVE_LIBPFM
-static int test__pfm_events(void);
-static int test__pfm_group(void);
-#endif
-
-static const struct {
-	int (*func)(void);
-	const char *desc;
-} pfm_testcase_table[] = {
-#ifdef HAVE_LIBPFM
-	{
-		.func = test__pfm_events,
-		.desc = "test of individual --pfm-events",
-	},
-	{
-		.func = test__pfm_group,
-		.desc = "test groups of --pfm-events",
-	},
-#endif
-};
-
 #ifdef HAVE_LIBPFM
 static int count_pfm_events(struct perf_evlist *evlist)
 {
@@ -44,7 +23,8 @@ static int count_pfm_events(struct perf_evlist *evlist)
 	return count;
 }
 
-static int test__pfm_events(void)
+static int test__pfm_events(struct test_suite *test __maybe_unused,
+			    int subtest __maybe_unused)
 {
 	struct evlist *evlist;
 	struct option opt;
@@ -104,7 +84,8 @@ static int test__pfm_events(void)
 	return 0;
 }
 
-static int test__pfm_group(void)
+static int test__pfm_group(struct test_suite *test __maybe_unused,
+			   int subtest __maybe_unused)
 {
 	struct evlist *evlist;
 	struct option opt;
@@ -187,37 +168,28 @@ static int test__pfm_group(void)
 	}
 	return 0;
 }
-#endif
-
-static const char *test__pfm_subtest_get_desc(int i)
-{
-	if (i < 0 || i >= (int)ARRAY_SIZE(pfm_testcase_table))
-		return NULL;
-	return pfm_testcase_table[i].desc;
-}
-
-static int test__pfm_subtest_get_nr(void)
+#else
+static int test__pfm_events(struct test_suite *test __maybe_unused,
+			    int subtest __maybe_unused)
 {
-	return (int)ARRAY_SIZE(pfm_testcase_table);
+	return TEST_SKIP;
 }
 
-static int test__pfm(struct test_suite *test __maybe_unused, int i __maybe_unused)
+static int test__pfm_group(struct test_suite *test __maybe_unused,
+			   int subtest __maybe_unused)
 {
-#ifdef HAVE_LIBPFM
-	if (i < 0 || i >= (int)ARRAY_SIZE(pfm_testcase_table))
-		return TEST_FAIL;
-	return pfm_testcase_table[i].func();
-#else
 	return TEST_SKIP;
-#endif
 }
+#endif
+
+static struct test_case pfm_tests[] = {
+	TEST_CASE_REASON("test of individual --pfm-events", pfm_events, "not compiled in"),
+	TEST_CASE_REASON("test groups of --pfm-events", pfm_group, "not compiled in"),
+	{ .name = NULL, }
+};
 
 struct test_suite suite__pfm = {
 	.desc = "Test libpfm4 support",
-	.func = test__pfm,
-	.subtest = {
-		.skip_if_fail	= true,
-		.get_nr		= test__pfm_subtest_get_nr,
-		.get_desc	= test__pfm_subtest_get_desc,
-	}
+	.test_cases = pfm_tests,
+	.subtest = { .skip_if_fail   = true }
 };
-- 
2.33.1.1089.g2158813163f-goog

