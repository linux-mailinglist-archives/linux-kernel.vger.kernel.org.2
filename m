Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF4645B095
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 01:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240593AbhKXAPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 19:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239081AbhKXAPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 19:15:43 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9A0C061714
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 16:12:34 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id q82-20020a627555000000b004a4f8cadb6fso419341pfc.20
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 16:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=r7AhAqgjV2rKTWwkAzKHbn6CM2swTuumTBUvYfOAdxA=;
        b=WIlybyw20/IqPGv4r5lxaiFgeeeVnl/2nshw/ZRrhi6qbzWb025FKIDoeTM9z+xmBj
         OqIWNYP4/Ky0W/gFsoG8t3ElgA7cUAuErI05uLtTgG8dpg3YJPSLb6Sskcq1U6lS8UVB
         rC8qJeiHRfmd3GMn0JR1Qcc5D8KB+zBlMgpSormqsL7ocOTCfhZyxCTI5mkkyJPC9gad
         U4l2Uic0XnKvzIr4sp8fd4y65tFmI5yGbEK3t05hg//GXNrVpAAQOsjmIH/3Ly+irtZd
         vNjX7TpUA3mGJrw3IJuuiPygPf1YrfjMOh6FEzJ3EGxOx5Qd0Mp2YH5H2jbIetKSAFzu
         KefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=r7AhAqgjV2rKTWwkAzKHbn6CM2swTuumTBUvYfOAdxA=;
        b=QRULn7tZZTMMmkzdo1GlMZ+dYqHFosSixhzsbN4Kmha2Sdfos2t+2TFbRQYmzIxvVb
         LxT5AW4oQy1U1T8cvMd4rB/nPI/UiFv8evUqRVX5V6lBBu2mbuK6pwoRIZ0Iow4CizV1
         oguHSrrtQz+xnzFm9PqOon+qr8/XXllmFPmagwBbudG4/RiC1OR80I2HyC7WeAo3HHKe
         L/Ro26LsdmbFbdeMyKU0jUDAIIPHhz/2TeEP3pOXeVUICKz41HC1p6m6HHe+TTpY3jO9
         GwhsaDMVurXs7SbIZRn4APMC1D9tLeqi5ONOVUn2/VpDEpXVjF9C7Gy5MorhVPioW9Dd
         laxg==
X-Gm-Message-State: AOAM531T7fmKNIHQVF693crnuJKUN7IN5LGxlSzetNLiAi5lPs76bLe4
        ldkHOiCi+upb2N4xkzf/j/5wKqMCI5IH
X-Google-Smtp-Source: ABdhPJx5MMGItrF9g98TXg/DgoPLAPJv4hr6kiVeAwZ/T4cQAUL9sJSiwvAyBbvRRVd36uCv0oj4p2osJN2O
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:dbab:a6fe:1e3a:91fa])
 (user=irogers job=sendgmr) by 2002:a17:90a:db89:: with SMTP id
 h9mr2121357pjv.71.1637712754074; Tue, 23 Nov 2021 16:12:34 -0800 (PST)
Date:   Tue, 23 Nov 2021 16:12:28 -0800
Message-Id: <20211124001231.3277836-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 1/4] perf expr: Add debug logging for literals
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Useful for diagnosing problems with metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 1d532b9fed29..cdbab4f959fe 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -395,12 +395,17 @@ double expr_id_data__source_count(const struct expr_id_data *data)
 double expr__get_literal(const char *literal)
 {
 	static struct cpu_topology *topology;
+	double result = NAN;
 
-	if (!strcmp("#smt_on", literal))
-		return smt_on() > 0 ? 1.0 : 0.0;
+	if (!strcmp("#smt_on", literal)) {
+		result =  smt_on() > 0 ? 1.0 : 0.0;
+		goto out;
+	}
 
-	if (!strcmp("#num_cpus", literal))
-		return cpu__max_present_cpu();
+	if (!strcmp("#num_cpus", literal)) {
+		result = cpu__max_present_cpu();
+		goto out;
+	}
 
 	/*
 	 * Assume that topology strings are consistent, such as CPUs "0-1"
@@ -415,13 +420,21 @@ double expr__get_literal(const char *literal)
 			return NAN;
 		}
 	}
-	if (!strcmp("#num_packages", literal))
-		return topology->package_cpus_lists;
-	if (!strcmp("#num_dies", literal))
-		return topology->die_cpus_lists;
-	if (!strcmp("#num_cores", literal))
-		return topology->core_cpus_lists;
+	if (!strcmp("#num_packages", literal)) {
+		result = topology->package_cpus_lists;
+		goto out;
+	}
+	if (!strcmp("#num_dies", literal)) {
+		result = topology->die_cpus_lists;
+		goto out;
+	}
+	if (!strcmp("#num_cores", literal)) {
+		result = topology->core_cpus_lists;
+		goto out;
+	}
 
 	pr_err("Unrecognized literal '%s'", literal);
-	return NAN;
+out:
+	pr_debug2("literal: %s = %f\n", literal, result);
+	return result;
 }
-- 
2.34.0.rc2.393.gf8c9666880-goog

