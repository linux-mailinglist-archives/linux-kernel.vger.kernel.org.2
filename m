Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EF930C63B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbhBBQmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236743AbhBBQkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:40:01 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFDEC061797
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 08:39:21 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id v19so15229082pgj.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 08:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7AX8o2m7TaGernMBKLQ1ccQQ5curN1Db2eFCwO1KjJ4=;
        b=WX+FutqhMS7HGLn3Gezpkj78TZZMIBbKSh+Wo/9dckqU+hMb/VJoBUNCI/6pimjGEJ
         blensVatFns1nJGAlm4Pvu7uR21mjCDC2RtdcYQ4eWOtLDJwRPy77VCDEbnZBF6Uk9n9
         cxyjsVR1wQlsLueZw+BTBp1hMDw+6/w2D1bcS31MOrBFgoJ+EJ5S1y5R1/4sjXm3Ulj3
         /Cc4GmxgkQUi4lYWRl+hY7JwgFgPdYXvWvCRynmJ9d1tMzoNEzflxASNme5NRLr6BZ8P
         dKyoFivSY5GYk0aHs9H59GmngJJa9WZu340/e396ht22NXJKdr8N9/ijlwu9OUIj9Pqk
         M9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7AX8o2m7TaGernMBKLQ1ccQQ5curN1Db2eFCwO1KjJ4=;
        b=ge1SEYZTYuxCx3o3XOrtqMYDK4sp3Vt/IQxQIRkAuamdNejVMaNFgChsUI84xp7fXI
         yL2IMsyYLuYovORBYV4bIWH0HqO8pR2H45AGd0rLsoVc3fWELZ5S1X/no4MQznnnngec
         TC8sc81QJo4wtd15Ih4gJdZtKRx9mpH7DZOfj2mjMWJTyPLJl42Jy3WQxZ4PiG06RYjQ
         zLqymm9wTRbdOAIlcQLLW5MDwSOfPnDqamP4Oxaz1cuJ2JZQZFSPvQgxyViDqT1HWgL2
         YaihPAhM1HQKzjZKnbet3QgcSfUfkYdUoXxeZgIax0DBjwBMCbMgsbwZ2rZTs6dc+Y9H
         /5Qw==
X-Gm-Message-State: AOAM533SScMO34mKd9MHF+4Ue0EAW+DLz4hPDJ2sKcdmok0k2mrB4s/F
        9VOeCYxold1PLoqHiptm9MmfTg==
X-Google-Smtp-Source: ABdhPJxL/JZsXqjBx3k8YXfoQ4uW7lwdezlnxiczR3v27+QWWGlGQK927KHnkd2TbWPvZJiM+wFYFA==
X-Received: by 2002:a63:db0d:: with SMTP id e13mr22753885pgg.343.1612283960549;
        Tue, 02 Feb 2021 08:39:20 -0800 (PST)
Received: from localhost ([45.137.216.202])
        by smtp.gmail.com with ESMTPSA id 192sm22297699pfv.209.2021.02.02.08.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:39:20 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Al Grant <al.grant@arm.com>, Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 4/7] perf cs-etm: Support PID tracing in config
Date:   Wed,  3 Feb 2021 00:38:39 +0800
Message-Id: <20210202163842.134734-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210202163842.134734-1-leo.yan@linaro.org>
References: <20210202163842.134734-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

If the kernel is running at EL2, the pid of a task is exposed via VMID
instead of the CONTEXTID.  Add support for this in the perf tool.

This patch respects user setting if user has specified any configs
from "contextid", "contextid1" or "contextid2"; otherwise, it
dynamically sets config based on PMU format "contextid".

Cc: Mike Leach <mike.leach@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Al Grant <al.grant@arm.com>
Co-developed-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/include/linux/coresight-pmu.h |  3 ++
 tools/perf/arch/arm/util/cs-etm.c   | 61 +++++++++++++++++++++++------
 2 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
index 5dc47cfdcf07..4ac5c081af93 100644
--- a/tools/include/linux/coresight-pmu.h
+++ b/tools/include/linux/coresight-pmu.h
@@ -20,14 +20,17 @@
  */
 #define ETM_OPT_CYCACC		12
 #define ETM_OPT_CTXTID		14
+#define ETM_OPT_CTXTID2		15
 #define ETM_OPT_TS		28
 #define ETM_OPT_RETSTK		29
 
 /* ETMv4 CONFIGR programming bits for the ETM OPTs */
 #define ETM4_CFG_BIT_CYCACC	4
 #define ETM4_CFG_BIT_CTXTID	6
+#define ETM4_CFG_BIT_VMID	7
 #define ETM4_CFG_BIT_TS		11
 #define ETM4_CFG_BIT_RETSTK	12
+#define ETM4_CFG_BIT_VMID_OPT	15
 
 static inline int coresight_get_trace_id(int cpu)
 {
diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index c25c878fd06c..fa6f91a7c8a1 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -67,6 +67,7 @@ static int cs_etm_set_context_id(struct auxtrace_record *itr,
 	char path[PATH_MAX];
 	int err = -EINVAL;
 	u32 val;
+	u64 contextid;
 
 	ptr = container_of(itr, struct cs_etm_recording, itr);
 	cs_etm_pmu = ptr->cs_etm_pmu;
@@ -86,25 +87,59 @@ static int cs_etm_set_context_id(struct auxtrace_record *itr,
 		goto out;
 	}
 
+	/* User has configured for PID tracing, respects it. */
+	contextid = evsel->core.attr.config &
+			(BIT(ETM_OPT_CTXTID) | BIT(ETM_OPT_CTXTID2));
+
 	/*
-	 * TRCIDR2.CIDSIZE, bit [9-5], indicates whether contextID tracing
-	 * is supported:
-	 *  0b00000 Context ID tracing is not supported.
-	 *  0b00100 Maximum of 32-bit Context ID size.
-	 *  All other values are reserved.
+	 * If user doesn't configure the contextid format, parse PMU format and
+	 * enable PID tracing according to the "contextid" format bits:
+	 *
+	 *   If bit ETM_OPT_CTXTID is set, trace CONTEXTIDR_EL1;
+	 *   If bit ETM_OPT_CTXTID2 is set, trace CONTEXTIDR_EL2.
 	 */
-	val = BMVAL(val, 5, 9);
-	if (!val || val != 0x4) {
-		err = -EINVAL;
-		goto out;
+	if (!contextid)
+		contextid = perf_pmu__format_bits(&cs_etm_pmu->format,
+						  "contextid");
+
+	if (contextid & BIT(ETM_OPT_CTXTID)) {
+		/*
+		 * TRCIDR2.CIDSIZE, bit [9-5], indicates whether contextID
+		 * tracing is supported:
+		 *  0b00000 Context ID tracing is not supported.
+		 *  0b00100 Maximum of 32-bit Context ID size.
+		 *  All other values are reserved.
+		 */
+		val = BMVAL(val, 5, 9);
+		if (!val || val != 0x4) {
+			pr_err("%s: CONTEXTIDR_EL1 isn't supported\n",
+			       CORESIGHT_ETM_PMU_NAME);
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
+	if (contextid & BIT(ETM_OPT_CTXTID2)) {
+		/*
+		 * TRCIDR2.VMIDOPT[30:29] != 0 and
+		 * TRCIDR2.VMIDSIZE[14:10] == 0b00100 (32bit virtual contextid)
+		 * We can't support CONTEXTIDR in VMID if the size of the
+		 * virtual context id is < 32bit.
+		 * Any value of VMIDSIZE >= 4 (i.e, > 32bit) is fine for us.
+		 */
+		if (!BMVAL(val, 29, 30) || BMVAL(val, 10, 14) < 4) {
+			pr_err("%s: CONTEXTIDR_EL2 isn't supported\n",
+			       CORESIGHT_ETM_PMU_NAME);
+			err = -EINVAL;
+			goto out;
+		}
 	}
 
 	/* All good, let the kernel know */
-	evsel->core.attr.config |= (1 << ETM_OPT_CTXTID);
+	evsel->core.attr.config |= contextid;
 	err = 0;
 
 out:
-
 	return err;
 }
 
@@ -489,7 +524,9 @@ static u64 cs_etmv4_get_config(struct auxtrace_record *itr)
 		config |= BIT(ETM4_CFG_BIT_TS);
 	if (config_opts & BIT(ETM_OPT_RETSTK))
 		config |= BIT(ETM4_CFG_BIT_RETSTK);
-
+	if (config_opts & BIT(ETM_OPT_CTXTID2))
+		config |= BIT(ETM4_CFG_BIT_VMID) |
+			  BIT(ETM4_CFG_BIT_VMID_OPT);
 	return config;
 }
 
-- 
2.25.1

