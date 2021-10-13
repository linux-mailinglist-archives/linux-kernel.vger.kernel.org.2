Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85CF42C7FF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 19:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238882AbhJMRvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 13:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238532AbhJMRu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 13:50:26 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F28C06178A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:47:12 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id gg11-20020a056214252b00b00382e4692e72so3249294qvb.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xteZMpZdkPkQ7I7Ombo00Pf+flGo+AinDwwB1uosPNQ=;
        b=VDCU+mVLaUNE2BviVcFOaL/SUFeBqp/jgWZ+hRr8hWon19Vg93Np4//HtbEp0Y6Pca
         vGEk56qLeG3QCjOr8q3jgqihrbv6WMSwaY8AZWbTReplVbcVv+aQpBKhJ6KG+86Stow5
         66OtIBgWlguJr8qTFA+OTpWyo4PCKFbzrnrYkH1alEhrYhVSKl7Q8tCBVDsBA4SpHgnl
         kh1funwC7Q56ki6wyf45jZ/GJTv1qyawv5VUzpD1mgY08LafGN8f+7MFhmjpV2FoIj4v
         iI9MeMB0s19XT4jwmj9dhse8pRjY3Wrd+osVEYYaPzW2LshI1+igx3bs4w4uv823VUEe
         W7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xteZMpZdkPkQ7I7Ombo00Pf+flGo+AinDwwB1uosPNQ=;
        b=QZUlKAx2xB9qlyRHiJCJr7YRaM79bPA2XYeZiRspFX19gftU9Df217S8E8AWQWBMk3
         T1Ns89L5grA6wx5EPsgFiK3Kfq7X8kMxpsuE9KF8SeDh58jMjiEg8Hy0b9k4wgplLR40
         d4A/VEWIxcGVUYavBf7KV6ckPg6I2HT47kh70Ac/VtrJcBckkKRCTODW0aQICfugXg1a
         xvZ2CH3wQZsCq2JFPuNYCqF6le7aPZpvc5Jw6XVlOadmcTyUHS+vZ7tCx9a3SAgo8pje
         rt8vUY0JZeGYVbObr12XxS9Y5OQ1IuYEKVCQ2AylbREvIDRm8wUcRsmaSqGYSq7uzHgl
         DySQ==
X-Gm-Message-State: AOAM5324nJL2cViXwx195VJSorp679DrvkT2x7SDRNd385pRinZT60GR
        b55iUG8BAwB5oqe/w1mfN6OP7Mf9Y8A2
X-Google-Smtp-Source: ABdhPJygyjSno8v6AOSiQqo4BGL++Bxd06BmFoAtjd6Bo9wO5UbMr+M8YZUh1sMam+G9PXkZHgng2WpinWhe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:aeaf:8e9e:3df2:aad9])
 (user=irogers job=sendgmr) by 2002:ac8:5f54:: with SMTP id
 y20mr836208qta.324.1634147232095; Wed, 13 Oct 2021 10:47:12 -0700 (PDT)
Date:   Wed, 13 Oct 2021 10:46:03 -0700
In-Reply-To: <20211013174604.747276-1-irogers@google.com>
Message-Id: <20211013174604.747276-22-irogers@google.com>
Mime-Version: 1.0
References: <20211013174604.747276-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 21/22] perf test: Remove is_supported function
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

All tests now return TEST_SKIP if not supported. Removing this function
brings perf's test_suite struct more inline with kunit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 14 +-------------
 tools/perf/tests/tests.h        |  1 -
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 966948cacba3..086641f60015 100644
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
2.33.0.882.g93a45727a2-goog

