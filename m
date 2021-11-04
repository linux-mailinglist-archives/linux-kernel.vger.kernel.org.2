Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54185444F18
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 07:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhKDGsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 02:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhKDGqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 02:46:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68A8C0797B7
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 23:42:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m78-20020a252651000000b005c1f44d3c7bso7393867ybm.22
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 23:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=N51ftPci49QHKXv2EdIL5CFt1D7hBmKrru2lMDQQtvY=;
        b=QVoOer+wqH/YvEnUkcOwR0PNk03Nk0XhxZCfr2uXHXbivu9rJjuuSm8YH/FU2dbL9x
         R1yqQTSm/jzPrw5XToNxUmTF4zuDwmFJUKbUBLwCNsN+JjuqgowGpES4GbW+PQgZPdpt
         l3DvpV8pulz1ADx9gXpqCr9CnXqmn1tMm8nL7pT1GTisXfOWE9LJ7G0dSghKC3ahZWPi
         iJ3J1Jx2jJSLe6RvV3saOwEBRrXoRlK582+tTMAMHZsttA7iXo2NVqKAgxiqnqYjAsKm
         sRUr9kG0ylE3zszWw3m+LrcNzZ83oNmWx9s6NqLVhqsuk4D7/b3Kb9146v2XhfrUnWNI
         MUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N51ftPci49QHKXv2EdIL5CFt1D7hBmKrru2lMDQQtvY=;
        b=oTnCY60XSpvZ9kwFkWOy7HsNMPTnvI/RnCwLPOfn/y9Oj8PqutAaE32u0qvFDwJMCQ
         U+3V+2ZJxWHeKd6+ZPsCfMKqmzXUFm3V1VFvj1twcQZyiVBKBSXKRhLeEJEkajOyAdTD
         XUI+pkwdJdvUZIy2+nMgWPRSAa/amx+4/kQT7doectc/qm++SlrQ1rZap7QY9+Z9WxOG
         CXyc+SKOsAOWjX6fBksg4aHEMMxCEsLeaToOU1i2On7PycvKUvhc8iBNqFTZ94gq91PG
         SQYwpY+xDdW9IaQHEt3OMuKtUu0DJ8kRQBwbWQsuJosd/05XY9A9pq87YBqKH/5DkALk
         8mEw==
X-Gm-Message-State: AOAM53146LtVh8Aa4lVmYaRiFJKOKal6DHxajQVxzl2qmMTNMK8nSLay
        +InzW28lklDXpUJ6fiBpNCF23oG5z2xD
X-Google-Smtp-Source: ABdhPJycCwf0B7S+81Xu18NbtkeCjAKRQFz1bUrjGVuh8YXsAB4KNq+s5MvEyKd5flMupFqPfcY2tFJQgGhl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8ce:af84:2510:3f29])
 (user=irogers job=sendgmr) by 2002:a25:ac0b:: with SMTP id
 w11mr46441245ybi.163.1636008179000; Wed, 03 Nov 2021 23:42:59 -0700 (PDT)
Date:   Wed,  3 Nov 2021 23:42:04 -0700
In-Reply-To: <20211104064208.3156807-1-irogers@google.com>
Message-Id: <20211104064208.3156807-19-irogers@google.com>
Mime-Version: 1.0
References: <20211104064208.3156807-1-irogers@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3 18/22] perf test: Remove non test case style support.
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

Convert shell tests to also run using test case style.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 25 ++++++++++++++++---------
 tools/perf/tests/tests.h        |  1 -
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 62e97faa90f0..1d9c0e03b8db 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -157,9 +157,6 @@ static bool is_supported(const struct test_suite *t)
 
 static test_fnptr test_function(const struct test_suite *t, int subtest)
 {
-	if (t->func)
-		return t->func;
-
 	if (subtest <= 0)
 		return t->test_cases[0].run_case;
 
@@ -413,24 +410,34 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width,
 	for_each_shell_test(entlist, n_dirs, st.dir, ent) {
 		int curr = i++;
 		char desc[256];
-		struct test_suite test = {
-			.desc = shell_test__description(desc, sizeof(desc), st.dir, ent->d_name),
-			.func = shell_test__run,
+		struct test_case test_cases[] = {
+			{
+				.desc = shell_test__description(desc,
+								sizeof(desc),
+								st.dir,
+								ent->d_name),
+				.run_case = shell_test__run,
+			},
+			{ .name = NULL, }
+		};
+		struct test_suite test_suite = {
+			.desc = test_cases[0].desc,
+			.test_cases = test_cases,
 			.priv = &st,
 		};
 
-		if (!perf_test__matches(test.desc, curr, argc, argv))
+		if (!perf_test__matches(test_suite.desc, curr, argc, argv))
 			continue;
 
 		st.file = ent->d_name;
-		pr_info("%2d: %-*s:", i, width, test.desc);
+		pr_info("%2d: %-*s:", i, width, test_suite.desc);
 
 		if (intlist__find(skiplist, i)) {
 			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
 			continue;
 		}
 
-		test_and_print(&test, false, -1);
+		test_and_print(&test_suite, false, 0);
 	}
 
 	for (e = 0; e < n_dirs; e++)
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 9bf448f7429a..cae33c375d55 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -40,7 +40,6 @@ struct test_case {
 
 struct test_suite {
 	const char *desc;
-	test_fnptr func;
 	struct {
 		bool skip_if_fail;
 	} subtest;
-- 
2.33.1.1089.g2158813163f-goog

