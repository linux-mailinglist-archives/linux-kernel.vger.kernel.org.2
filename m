Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24FF32428B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbhBXQv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 11:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbhBXQtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:49:51 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E22C0617A9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:48:41 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id t25so1829119pga.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YVpDo8mtMCCvytOk6IEb5HcRno2BHaL+YB4QiCfvD98=;
        b=p52RrZEKdmPfHmCNjhBMEW5ZfsxsEPChAAjLuFlu5EhNmGhVZNxuoSA3t6mA+PoOPu
         JvhOEJp8p6Ut6+6cmc7TG3HHzXLjKdXkBy0TBqNoToTDWp4JNRT8Tteul4uWmPgft55x
         +8K8XpfjxlVt7Z09CieDd2F1r66MF2QZ5CWu2EC2H1NsLDquFcWnjDIpCWy/DGVKWCKT
         VHqqKVAIutFtnZ6CwcFytvKGDbvMAinRstfHS7zNiRWW/g/QNogTU0QSeZvwYkV9n+rk
         FxZ5D1V8zJU0LgQQqBZFe6RJPIrsQpJKSMAnL7oRZbZcVFF7L7Xi0QC+76UAKWOYTY+c
         ieXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YVpDo8mtMCCvytOk6IEb5HcRno2BHaL+YB4QiCfvD98=;
        b=lxoBGudHmhPKwt+C/l7P5XSqTEE8o38GO4oIHG+I6tjj1B08CvtXQLi+SNVdIj2crU
         aJEC/xzthnSb07MG3PxP7i9K4nsuHMjHeVUK+aAc1NB3M3ejoz6NdKhQY/zOnNAwAjQe
         YoH2yntx/n2itKP0q4iiV2XBDlhsEu4oxPJCR+jFOmTq3I7z0E84TMqhsVog6OEs4KB3
         ci9xulfeF8kDjDmp0g34CSJNG1rkSWVX6DjWuTN5HqQWWtQSh/Zk1ytmBL0fBK95rBW6
         82VS6PqmXFBvEqcSqe++uvuwyvVWRPNLAfOq2jGpPYq7MW8DgN4G1Nas60z5yRvtEDZq
         fhPQ==
X-Gm-Message-State: AOAM533SAibqoDKMaDbilAMnKN0Ddima3G0DI+Ztn9VyK7WMsRsjdj+T
        K4qO7F4xeIOJNdbVUwijEzg7461Oo7oF4w==
X-Google-Smtp-Source: ABdhPJy28aZaFi/a3ALLFJkFyXKHo/3+0vxSh3PPb5/3vIM6fEgK3k4EzTXqWZbVK7PxMOd5PyBgkg==
X-Received: by 2002:a65:568b:: with SMTP id v11mr29457516pgs.49.1614185320937;
        Wed, 24 Feb 2021 08:48:40 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id m6sm3284793pfc.56.2021.02.24.08.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 08:48:40 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     mike.leach@linaro.org, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] perf cs-etm: Support PID tracing in config
Date:   Wed, 24 Feb 2021 09:48:33 -0700
Message-Id: <20210224164835.3497311-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210224164835.3497311-1-mathieu.poirier@linaro.org>
References: <20210224164835.3497311-1-mathieu.poirier@linaro.org>
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
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Co-developed-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Link: https://lore.kernel.org/r/20210213113220.292229-4-leo.yan@linaro.org
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
index 5b2bb7fc5ee1..911c7f2b3581 100644
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
 
@@ -485,7 +520,9 @@ static u64 cs_etmv4_get_config(struct auxtrace_record *itr)
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

