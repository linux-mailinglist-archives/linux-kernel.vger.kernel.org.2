Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C3A42C7EE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 19:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238146AbhJMRta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 13:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238203AbhJMRsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 13:48:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1966EC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:46:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f8-20020a2585480000b02905937897e3daso4005406ybn.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C89KxJXK2AmfC41UKgGo8vF4MhXi7J9MAY9rM2xkdyE=;
        b=V0Z/L1CaFQ+Z9lO9MhkZJlid8IqMjTmndnLxS8iY9dm8uNOzzLjWFeaf8yGsQoKsuL
         g33GE97zKHXXi0Cz9W8C2q6+ZmSJH8vJnt7nvVaf6c6VVsof2/NPCXrCe6ITlU3egAju
         7gi1GNUi4R2CfX6Z5Hj2tgW7e0oo+MXz87WryrwxgEcsPH+79s74a8VbNzHZNBZQloFs
         a2zghpoJHYqhPxKC+d4lYsuuyXgwdfkmDxLx7pxiH8xqG9vvs9n/SAM1rHRIOtP4b6GT
         iavelPHfv/ocX3mW3N87ehsr8CDj3HZWKbmB3Yb3Zt35aIPrV+i1p5DGBaFI/UBa+2b9
         +orA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C89KxJXK2AmfC41UKgGo8vF4MhXi7J9MAY9rM2xkdyE=;
        b=JTa3Cc/eETDJ6wjlTSF+bcA2UfZHP745hllWRxEDIw7q7iTZMF017mAdLBTwsCOAwY
         pRGuRJVVWWXy0zluHaiWGYCbVM0mMYOnMDq5Bm72FfRvrcHbMM/TBuXTMFgex5UQOb5I
         3cJVDsBJ93Ki30hOcJ32zGnpUL6Kw+IAYpvGzISdUYThsM3CYNkPwzgy/aG7AmUJAbry
         DBPRM+dZBTGSFsh0GDl7RkQAFjhbHbmoVdCB2o3B3nXJSMF1LMgAm/qGDlGIYJndVbP/
         EKi+Fhpv6PHlYNtXWtLChTKxncZxBP4QnI0YhUb7tNMgHW0L/yB5Ld5bjjKBKqk60ObX
         NYKQ==
X-Gm-Message-State: AOAM530/9NJ4hL2sKL1tCkm1sQPH2/9p2Uv3uapUqKN80LCuC+2kOvNd
        LOsF/6yUZW3DXPs2kugpN7D9b/xgpZ06
X-Google-Smtp-Source: ABdhPJwOf9IMke9cKQ5Vp83R+oNhjfapQ+6q+MPZmx6pAvoK5alRGMdUUO9gx/UDC3WRwJeR4rSEMVkw2srd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:aeaf:8e9e:3df2:aad9])
 (user=irogers job=sendgmr) by 2002:a05:6902:709:: with SMTP id
 k9mr914170ybt.317.1634147198268; Wed, 13 Oct 2021 10:46:38 -0700 (PDT)
Date:   Wed, 13 Oct 2021 10:45:49 -0700
In-Reply-To: <20211013174604.747276-1-irogers@google.com>
Message-Id: <20211013174604.747276-8-irogers@google.com>
Mime-Version: 1.0
References: <20211013174604.747276-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 07/22] perf test: Add test case struct.
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

Add a test case struct mirroring the 'struct kunit_case'. Use the struct
with the DEFINE_SUITE macro, where the single test is turned into a test
case. Update the helpers in builtin-test to handle test cases.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 30 ++++++++++++++++++++++++------
 tools/perf/tests/tests.h        | 26 ++++++++++++++++++++++----
 2 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 96eb486ffbc9..a6d84feba483 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -117,10 +117,19 @@ static struct test_suite **tests[] = {
 
 static int num_subtests(const struct test_suite *t)
 {
+	int num;
+
 	if (t->subtest.get_nr)
 		return t->subtest.get_nr();
 
-	return 0;
+	if (!t->test_cases)
+		return 0;
+
+	num = 0;
+	while (t->test_cases[num].name)
+		num++;
+
+	return num;
 }
 
 static bool has_subtests(const struct test_suite *t)
@@ -138,10 +147,13 @@ static const char *skip_reason(const struct test_suite *t, int subtest)
 
 static const char *test_description(const struct test_suite *t, int subtest)
 {
-	if (subtest < 0 || !t->subtest.get_desc)
-		return t->desc;
+	if (t->test_cases && subtest >= 0)
+		return t->test_cases[subtest].desc;
 
-	return t->subtest.get_desc(subtest);
+	if (t->subtest.get_desc && subtest >= 0)
+		return t->subtest.get_desc(subtest);
+
+	return t->desc;
 }
 
 static bool is_supported(const struct test_suite *t)
@@ -149,9 +161,15 @@ static bool is_supported(const struct test_suite *t)
 	return !t->is_supported || t->is_supported();
 }
 
-static test_fnptr test_function(const struct test_suite *t, int subtest __maybe_unused)
+static test_fnptr test_function(const struct test_suite *t, int subtest)
 {
-	return t->func;
+	if (t->func)
+		return t->func;
+
+	if (subtest <= 0)
+		return t->test_cases[0].run_case;
+
+	return t->test_cases[subtest].run_case;
 }
 
 static bool perf_test__matches(const char *desc, int curr, int argc, const char *argv[])
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 5139e24973cc..71b8d2c88e5c 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -31,6 +31,12 @@ struct test_suite;
 
 typedef int (*test_fnptr)(struct test_suite *, int);
 
+struct test_case {
+	const char *name;
+	const char *desc;
+	test_fnptr run_case;
+};
+
 struct test_suite {
 	const char *desc;
 	test_fnptr func;
@@ -40,6 +46,7 @@ struct test_suite {
 		const char *(*get_desc)(int subtest);
 		const char *(*skip_reason)(int subtest);
 	} subtest;
+	struct test_case *test_cases;
 	bool (*is_supported)(void);
 	void *priv;
 };
@@ -47,10 +54,21 @@ struct test_suite {
 #define DECLARE_SUITE(name) \
 	extern struct test_suite suite__##name;
 
-#define DEFINE_SUITE(description, name)		\
-	struct test_suite suite__##name = {		\
-		.desc = description,		\
-		.func = test__##name,		\
+#define TEST_CASE(description, _name)			\
+	{						\
+		.name = #_name,				\
+		.desc = description,			\
+		.run_case = test__##_name,		\
+	}
+
+#define DEFINE_SUITE(description, _name)			\
+	struct test_case tests__##_name[] = {           \
+		TEST_CASE(description, _name),		\
+		{	.name = NULL, }			\
+	};						\
+	struct test_suite suite__##_name = {		\
+		.desc = description,			\
+		.test_cases = tests__##_name,		\
 	}
 
 /* Tests */
-- 
2.33.0.882.g93a45727a2-goog

