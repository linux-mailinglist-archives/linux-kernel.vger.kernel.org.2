Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B148542C7FC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 19:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238191AbhJMRuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 13:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238424AbhJMRuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 13:50:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D115C0613E9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:47:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i83-20020a256d56000000b005b706d1417bso3982188ybc.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=REGzgN8X9fN5ply/7E9LzsjfVW7yuXTByGhaPBFWXJ8=;
        b=ZqQS2v6Gvj7W6vqT+l6CnXf0/429EV/FmKYWJoQk3z/OJjNs8yYDXelfCmR8gyGBHf
         5eARzKnRe3ifVPaKze8MgTqnfewQMF+VOTysTM84BOOsVJpLq5OCaqgmZoQUZW85zLEB
         G2y60+XlSwTBEbG2Vk9abyiZwrminvwZfdEFjFX/V6fYat3Xiu7qiq1nKt9VPBmQcN8F
         RuPeAUANgyM3EgpjRduUdf1F12oLNDSS7xjptGXT4o6L5cfYej06J7EL0Kl4vSFpeVaQ
         mKviXpYGsdTd1VYI/qPxKXctWSwf7r138Ve5REaledWO4M/Nzl3Rr9CIVnyUhTnxHVBh
         TP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=REGzgN8X9fN5ply/7E9LzsjfVW7yuXTByGhaPBFWXJ8=;
        b=R1U3LnVqLgKcOqfKBS9yzG1QAvg1KE9H9mJtoe4eRtsmhqGXU33eo/rRH7jSqqBqiF
         gvrrLgX+C4mhkZ0v1T4kz807T2/pVqPcPr6lMMFkcf9JCj+HuT4W8iYOEvwLoy9N6SHZ
         0eXoOp0pe42VyTfNxC0nwBh24P7y1X8878Yvyc8gcB62gMB8+HC57x+H09IU3DaLu2oG
         U7A6XvWRG+qIzLp+aE8O0ST6S6qS8J0z0f7Nr6KLd7Jcj+sY/hmufYXGE9riqVpVIAWK
         AJqhniWqeJhX18jmD/gkrvn142Wy1LqkPVSLPtRT+YQ1/jybEbGdgtgkEB8D7f546CBk
         FaVw==
X-Gm-Message-State: AOAM5329o108RlXgfzXmd9h1y6cwTbN/4SSQI8GbdnXTi04gTmPx8bBz
        z6YqbW7/oiQLplZ28fmpWb/2FpMuQ/6S
X-Google-Smtp-Source: ABdhPJxNrLzJkPIGwA+4X/MvjvvKSL77JIKLUZKEBVpGLqExQRgP3F6yQoa/WWJseRM1ayX1zW92qcEBQgAK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:aeaf:8e9e:3df2:aad9])
 (user=irogers job=sendgmr) by 2002:a25:ab61:: with SMTP id
 u88mr738884ybi.241.1634147224865; Wed, 13 Oct 2021 10:47:04 -0700 (PDT)
Date:   Wed, 13 Oct 2021 10:46:00 -0700
In-Reply-To: <20211013174604.747276-1-irogers@google.com>
Message-Id: <20211013174604.747276-19-irogers@google.com>
Mime-Version: 1.0
References: <20211013174604.747276-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 18/22] perf test: Remove non test case style support.
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

Convert shell tests to also run using test case style.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 25 ++++++++++++++++---------
 tools/perf/tests/tests.h        |  1 -
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index c98c7134b552..966948cacba3 100644
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
2.33.0.882.g93a45727a2-goog

