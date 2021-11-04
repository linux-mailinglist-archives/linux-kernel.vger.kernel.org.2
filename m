Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A009E444F1B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 07:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbhKDGsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 02:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbhKDGr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 02:47:26 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CDAC061227
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 23:43:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r67-20020a252b46000000b005bea12c4befso7325482ybr.19
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 23:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bDa29u/ndiNsX8EwvAxzBRsCHsm6XVJUwsCYIKbSYNU=;
        b=IeiSouheZYR16SzpZCnr7kTmgjl/G3L1ef4UnCnaz2hsyEQJh1ffEQrLq2e291JS86
         sCLewRsA4/bjaTppf6Jhl7uuwm1Ou5F6fClQwkXUys+7NIP64vyORjrBHOq2RfzgsXiK
         sVvX1ZPBT5txYECtczP2zjNVOMHurK/NFMWXoBJzS7tBGPU4mEMfcchIWDuz0PB1axmd
         G7Clb6qHRm5wZRCmtXOvp0RypZVLYU/dAJwict8M9NLdCoJgCbC0RxgkRk5ZIddHN1GM
         pubcayEHKH4+C501/7fKBhY5fBM0B9Facf0WebWhhpr/HgpHFEMOQWzhzClk+Z65atQw
         L0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bDa29u/ndiNsX8EwvAxzBRsCHsm6XVJUwsCYIKbSYNU=;
        b=u1fVQv7jt51+7CQjdbUbsyyzMuiAz/hd0vpJPKmp5fG0Nf3Wd2o7gGGeUP4/mgHDr9
         bHPTFH03ZCjGv4tOg8qTsEEF4sWKe0vD2hz1l1kve/IZlNbkqwQ4kSQoQ6A4uBinqb6n
         0iO5oRGhGLuIqlVBzm54OQFLlo0xZQEIK0ieuFic3MQBDRPBqISS1m6yYZ1xSBJGE3Jy
         e+PqOMCATlbyKvEt05lm/q5WWfgiiQH5uumCQPlpbsKBBxiMNNN9MG8WWVBHsioqc9KS
         5Tr449E7SjAZwuEBMbGV49lepE4igVu5AyVz85eL0uq7XKMYGJ0EkfRkWHPqTEEGBg8n
         d44w==
X-Gm-Message-State: AOAM532Y+DgG60WgVEP5GckFhSIsJccyI7B56Ds9KvbfnvlmIz2vgYvq
        ZhNHv2udPwf1WO3bQo/isYG/vnkK4VSo
X-Google-Smtp-Source: ABdhPJzndUDGPLfkemYeioDan06akCfGJJPe/2rXbIlDxIfa4XKvX4RtvrWTGD1s98JS3x6DpkbT/I2oLYKg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8ce:af84:2510:3f29])
 (user=irogers job=sendgmr) by 2002:a25:2bc1:: with SMTP id
 r184mr52349373ybr.44.1636008186470; Wed, 03 Nov 2021 23:43:06 -0700 (PDT)
Date:   Wed,  3 Nov 2021 23:42:07 -0700
In-Reply-To: <20211104064208.3156807-1-irogers@google.com>
Message-Id: <20211104064208.3156807-22-irogers@google.com>
Mime-Version: 1.0
References: <20211104064208.3156807-1-irogers@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3 21/22] perf test: Remove is_supported function
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

All tests now return TEST_SKIP if not supported. Removing this function
brings perf's test_suite struct more inline with kunit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 14 +-------------
 tools/perf/tests/tests.h        |  1 -
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 1d9c0e03b8db..19b1228dbd5d 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -150,11 +150,6 @@ static const char *test_description(const struct test_suite *t, int subtest)
 	return t->desc;
 }
 
-static bool is_supported(const struct test_suite *t)
-{
-	return !t->is_supported || t->is_supported();
-}
-
 static test_fnptr test_function(const struct test_suite *t, int subtest)
 {
 	if (subtest <= 0)
@@ -480,12 +475,6 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 				continue;
 		}
 
-		if (!is_supported(t)) {
-			pr_debug("%2d: %-*s: Disabled\n", i, width,
-				 test_description(t, -1));
-			continue;
-		}
-
 		pr_info("%2d: %-*s:", i, width, test_description(t, -1));
 
 		if (intlist__find(skiplist, i)) {
@@ -583,8 +572,7 @@ static int perf_test__list(int argc, const char **argv)
 	for_each_test(j, k, t) {
 		int curr = i++;
 
-		if (!perf_test__matches(test_description(t, -1), curr, argc, argv) ||
-		    !is_supported(t))
+		if (!perf_test__matches(test_description(t, -1), curr, argc, argv))
 			continue;
 
 		pr_info("%2d: %s\n", i, test_description(t, -1));
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 958f94dcc94c..15051801c790 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -44,7 +44,6 @@ struct test_suite {
 		bool skip_if_fail;
 	} subtest;
 	struct test_case *test_cases;
-	bool (*is_supported)(void);
 	void *priv;
 };
 
-- 
2.33.1.1089.g2158813163f-goog

