Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB66844CE40
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 01:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbhKKAY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 19:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbhKKAYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 19:24:16 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0D7C061205
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 16:21:28 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id g36-20020a25ae64000000b005c1f46f7ee6so6609069ybe.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 16:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HaT//OZ9My5i7hsIiDgx5w3ZNiHfZxS82NKzQLSX4Bk=;
        b=c657myAOTty26MKAOn4n7gEUVhvUcePkyPWHcM4cnvb3oSrBL5YP76A0sj/Cz+oa8e
         dOwH9/C4vT5VgjH+fjSSvXSldIB3xNg1oxJR6cUtPEsxkODRCrkubOY1Waf//8PwC01s
         xFRi4QbxakAGROxuWAXAykb9RkflVPRuJuZLAkC9+hjsR2hSXU5eD0SRtyBdvm7IEiWN
         PxvEb2BeyHpL4rudB3bWhxyrptUkKo2al2P4b0DzTpk793hUgxjWDDgavnm2lU3ThBnt
         PUDhWS2DLBXuknoaj4YhWG3Z39RLU624h5e21SBDW1IZO0eVYRCj8lm8mDLAZKiJvT6A
         eaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HaT//OZ9My5i7hsIiDgx5w3ZNiHfZxS82NKzQLSX4Bk=;
        b=XgMI53lpymjEI6ANCgT5kkA/LeOBNjFZnPo6p5KIfl9G03wLvX2H6YSTZnc5D3mpUu
         MuKRtGpr+OH2wbd8Jx9pOVdptxELdDj+MloNnVt1xOODH6nEhtmXmbvjLTug+2OSIn5q
         gAToST9bXS69U6hl5t1wXOW3h3z3ayHoelo3Lrhzd5BZuxw7mJUAoD2eoh5aVB+SIQXG
         NufZBjT/F9ZncbAFlM/pwdJ99lCp+wMr6trCTgrwIvIvj2uwI8uX4fLfYgV7ylQ1gcw8
         Dv9zzrwOiOSgniSkjoZhWcl/oXXGwr2Vdt7jJgitAbhJ9N3ZuYhGG1ibEmmgSQ81TC1T
         J2IQ==
X-Gm-Message-State: AOAM532uQ2M8gzhyRwL6qkmx+rtEwKnvsqlFrVP+3q0YyVEuncZkog7G
        BQIH8A1KwXaGZYzWaxJVpXqF4hLWMjlN
X-Google-Smtp-Source: ABdhPJy1Oj7jSQhEvdZJPLKARLLqNk754ry+AQIXX3JOOFXb2YtJPzKShfqFnbImaFBl9LYajlbCN8bpZX+y
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9510:b6b5:241:e409])
 (user=irogers job=sendgmr) by 2002:a05:6902:4e7:: with SMTP id
 w7mr3437508ybs.77.1636590087476; Wed, 10 Nov 2021 16:21:27 -0800 (PST)
Date:   Wed, 10 Nov 2021 16:21:07 -0800
In-Reply-To: <20211111002109.194172-1-irogers@google.com>
Message-Id: <20211111002109.194172-7-irogers@google.com>
Mime-Version: 1.0
References: <20211111002109.194172-1-irogers@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v2 6/8] perf expr: Add metric literals for topology.
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
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
2.34.0.rc1.387.gb447b232ab-goog

