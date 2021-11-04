Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8429D444F0A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 07:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhKDGpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 02:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhKDGpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 02:45:14 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38783C06122B
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 23:42:35 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d27-20020a25addb000000b005c2355d9052so7444290ybe.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 23:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CIgm9aOYABDFacjcOgWVtMt5SOTRrDoHBgwN9MizIcI=;
        b=OGVbBuC8tSuhNu2J9IidOZnlDgurGqAmeyH7b7kKE47xnRRjZ/LYscwDRs2XzDTfdO
         VFhOmmGDHIb9Rll/MzC8QCR2B+ds405YW0T5ZeQSTb5fhbmoSgM7ZNTPMnWLElBCqQuH
         LphBTMQhndB128YhgE2dIqFoKjLqvk2515LsyGyqmafvyqj1SNSBoO68mcz1ayDH5Jas
         lGOp6jzsG1Lu5oETNNSZ6xVDMLX8IZvBbb99dHndbpHzWPyP9T7v6RXT1eCAwlk54IgO
         OIFJob4JxiEUy8bpKiK1Hcw0vTQmW0DCxF1duVxBGHKCxy7Nx9Mx1Ra9SgqWPNs1XGwV
         K0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CIgm9aOYABDFacjcOgWVtMt5SOTRrDoHBgwN9MizIcI=;
        b=0LwMnLwjsOBXe/qRmO6GbmSmNGcdpbeEr2UnZz5FKX/mklhXrmvLVvOY2gXj92ZfK6
         TCC471gxcQy5by2T8JOnoahH8TsF/0cqGBn8VgHlOIjhTmyZAF9LZW06zuBrx+lDclL2
         ZDpau2rXVRlZJeDbch3xlxOLCxnDPwpJ7tFhmOQD6LKdbZZhwVOLGzeGwGdgz/KJ0IYt
         M5/rdWYTaQCbunaWYE21kMYYg4iGKKjKeKYXhsv9HMhYOG+XJE2BUeLft5tXblm9PWT1
         3aXSzBh0jGwzRBekCaYPm6yivXA9DbBQr/at730yCmB/LvNEn6qxjjs/aT8rwuGqkZc+
         LHEg==
X-Gm-Message-State: AOAM5314bgSyfd1PKq99aPY/rJUr5F6mx/o2Dar/l6WOqRFIFu1WKS8S
        GvKTXFpcgnyzatzy1FGe/t2/o3f/GS47
X-Google-Smtp-Source: ABdhPJzNwGwarPkdI0jOxicrlMxhkS+xo6wrtcMqGFM0WNni9KjP08LBQRmq4oOnRp/Mj4eGPvdmLxlwFAbU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8ce:af84:2510:3f29])
 (user=irogers job=sendgmr) by 2002:a25:2444:: with SMTP id
 k65mr29175919ybk.94.1636008154413; Wed, 03 Nov 2021 23:42:34 -0700 (PDT)
Date:   Wed,  3 Nov 2021 23:41:54 -0700
In-Reply-To: <20211104064208.3156807-1-irogers@google.com>
Message-Id: <20211104064208.3156807-9-irogers@google.com>
Mime-Version: 1.0
References: <20211104064208.3156807-1-irogers@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3 08/22] perf test: Add skip reason to test case.
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

This doesn't exist in kunit, but will ease the transition from perf
tests.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c |  3 +++
 tools/perf/tests/tests.h        | 11 ++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index a6d84feba483..db76d7d10749 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -142,6 +142,9 @@ static const char *skip_reason(const struct test_suite *t, int subtest)
 	if (t->subtest.skip_reason)
 		return t->subtest.skip_reason(subtest);
 
+	if (t->test_cases && subtest >= 0)
+		return t->test_cases[subtest].skip_reason;
+
 	return NULL;
 }
 
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 71b8d2c88e5c..f87129b63d92 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -34,6 +34,7 @@ typedef int (*test_fnptr)(struct test_suite *, int);
 struct test_case {
 	const char *name;
 	const char *desc;
+	const char *skip_reason;
 	test_fnptr run_case;
 };
 
@@ -61,7 +62,15 @@ struct test_suite {
 		.run_case = test__##_name,		\
 	}
 
-#define DEFINE_SUITE(description, _name)			\
+#define TEST_CASE_REASON(description, _name, _reason)	\
+	{						\
+		.name = #_name,				\
+		.desc = description,			\
+		.run_case = test__##_name,		\
+		.skip_reason = _reason,			\
+	}
+
+#define DEFINE_SUITE(description, _name)		\
 	struct test_case tests__##_name[] = {           \
 		TEST_CASE(description, _name),		\
 		{	.name = NULL, }			\
-- 
2.33.1.1089.g2158813163f-goog

