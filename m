Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF34D446795
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbhKERM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbhKERMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:12:46 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CAEC061227
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:10:02 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id jx2-20020a17090b46c200b001a62e9db321so2750228pjb.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 10:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tp+YfoZbse0y0sKx8hj8OQ/6tqTMgmmCVlQaWClRapE=;
        b=V4792M5UGZZS7QJjiVHuH+dpHIXEIXKcCgLoxj1yCp/8q4ci4mVpI/7hJ14pPtaAD9
         SKIC+TktLFNZNOBWHIhapfdiZ1xvici3YJL2P/GtLgeUJxSv6XjR5e4wvpH4oDWMXMOJ
         VW5rp+AgbLfGbj03kpqbPXsev2K5dxwDPypGp8NAHVgm7ARLQmG7Yy3rvSrCg7GxNwZ+
         /c44nu0cOwfsWSET1LTQOHQGT74PYEKukMBFDCkPcPWtwd7Sx+TD9Pk22yAt+DdnyMcZ
         J3gqNFD9I4myZsE39r0QT6awKeMh9enNZ5bDsX4Qfv97fLzlzPrxHNrMU85O1OrdUzmV
         M69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tp+YfoZbse0y0sKx8hj8OQ/6tqTMgmmCVlQaWClRapE=;
        b=T55s0eEXDqKZwalf/rwbbmn2l7ogcn3sLlYW8IJTVgRE69zTHa/iMshWaUMU/IQY7v
         lrlMmgl9bE0Q4FbGpYVc/tBe2VT/gaQiLBYhAHmRib3BHpbTrfjwCUoOvQIH3g66VrtU
         xzO53x3cfKwFHYouK0Wm992C5srHFHwcrJv4X98kOUdd0NE0zaZlRrC16EMkA2+QulXH
         fjR+EbcjCxrib7fnPbkYUxyWEMjTX8zOKdmCCPTuMXnmfnXgny2/ZrPgrPR1yDc8RnKE
         LSWBiHjnu/InU4g+S4/xc/Y7W9VY4xZLYElbFaWCTezGB6hyhtE/AGcqzpP4SMI4dvaH
         d7bQ==
X-Gm-Message-State: AOAM530+2t8rAlO1MYwXQysSOwoOyA6g6+lBjXDrrBmvMl6aWoXDLj+F
        6dXv2+ZG32lPsA84OtUk0g2pKyvgB+dw
X-Google-Smtp-Source: ABdhPJw6FlvchtLRGTKvlWJvCTY1XkBsyp2Th0kQYUxgnlDyZX6k88O5Ha/f2Ji/Anibt6TC6hkkX+GvfMnz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4cee:beb8:1744:5207])
 (user=irogers job=sendgmr) by 2002:a17:90a:5285:: with SMTP id
 w5mr94080pjh.1.1636132201145; Fri, 05 Nov 2021 10:10:01 -0700 (PDT)
Date:   Fri,  5 Nov 2021 10:09:42 -0700
In-Reply-To: <20211105170943.3479315-1-irogers@google.com>
Message-Id: <20211105170943.3479315-7-irogers@google.com>
Mime-Version: 1.0
References: <20211105170943.3479315-1-irogers@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH 6/7] perf expr: Add metric literals for topology.
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Song Liu <song@kernel.org>, Wan Jiabing <wanjiabing@vivo.com>,
        Yury Norov <yury.norov@gmail.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the number of cpus, cores, dies and packages to be queried by a
metric expression.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c | 12 +++++++++++-
 tools/perf/util/expr.c  | 27 +++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 9ee2dc91c27b..0c09ccc76665 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -66,7 +66,7 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 {
 	struct expr_id_data *val_ptr;
 	const char *p;
-	double val;
+	double val, num_cpus, num_cores, num_dies, num_packages;
 	int ret;
 	struct expr_parse_ctx *ctx;
 
@@ -161,6 +161,16 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 			NULL, ctx) == 0);
 	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
 
+	/* Test toplogy constants appear well ordered. */
+	expr__ctx_clear(ctx);
+	TEST_ASSERT_VAL("#num_cpus", expr__parse(&num_cpus, ctx, "#num_cpus") == 0);
+	TEST_ASSERT_VAL("#num_cores", expr__parse(&num_cores, ctx, "#num_cores") == 0);
+	TEST_ASSERT_VAL("#num_cpus >= #num_cores", num_cpus >= num_cores);
+	TEST_ASSERT_VAL("#num_dies", expr__parse(&num_dies, ctx, "#num_dies") == 0);
+	TEST_ASSERT_VAL("#num_cores >= #num_dies", num_cores >= num_dies);
+	TEST_ASSERT_VAL("#num_packages", expr__parse(&num_packages, ctx, "#num_packages") == 0);
+	TEST_ASSERT_VAL("#num_dies >= #num_packages", num_dies >= num_packages);
+
 	expr__ctx_free(ctx);
 
 	return 0;
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 7464739c2890..15af8b8ef5e7 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -5,6 +5,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include "metricgroup.h"
+#include "cpumap.h"
+#include "cputopo.h"
 #include "debug.h"
 #include "expr.h"
 #include "expr-bison.h"
@@ -375,9 +377,34 @@ double expr_id_data__value(const struct expr_id_data *data)
 
 double expr__get_literal(const char *literal)
 {
+	static struct cpu_topology *topology;
+
 	if (!strcmp("#smt_on", literal))
 		return smt_on() > 0 ? 1.0 : 0.0;
 
+	if (!strcmp("#num_cpus", literal))
+		return cpu__max_present_cpu();
+
+	/*
+	 * Assume that topology strings are consistent, such as CPUs "0-1"
+	 * wouldn't be listed as "0,1", and so after deduplication the number of
+	 * these strings gives an indication of the number of packages, dies,
+	 * etc.
+	 */
+	if (!topology) {
+		topology = cpu_topology__new();
+		if (!topology) {
+			pr_err("Error creating CPU topology");
+			return NAN;
+		}
+	}
+	if (!strcmp("#num_packages", literal))
+		return topology->package_cpus_lists;
+	if (!strcmp("#num_dies", literal))
+		return topology->die_cpus_lists;
+	if (!strcmp("#num_cores", literal))
+		return topology->core_cpus_lists;
+
 	pr_err("Unrecognized literal '%s'", literal);
 	return NAN;
 }
-- 
2.34.0.rc0.344.g81b53c2807-goog

