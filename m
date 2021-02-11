Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E717E3191A3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhBKRyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbhBKRVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:21:23 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE0AC06178A
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:20:43 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id cv23so3765209pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SaDNVFpV/oFZvL50IMJ+aksLQj8pFjVfZykazLuHDNY=;
        b=FhSYnclEl45NUQwZyMCL9KrsTnrrQdPC8N/u6KPWUi7Mhb80cnnl0Sb75wPs3ngQEa
         8tZ9X6Vz9jK1+Wr4lVRaHokdr4GIhQK2jQd0hyWBiuMthDHgf2PDcfvLm+bs3+XqTsSj
         71VAi/YFpe7xcpFXIJEgaXix5rSVTEHkuGSToFdsU9lc+RRMwx6r9p5pMMYQqs+fHdTq
         RJUvCjvBZNIqHXQiObfsm9Z9A/wg5z8GM3XwlGJVxg84nfhrzUlyQGyf9nouxWVZj9ff
         FHPdninbRM/p6qQ0zWixnGQ8J2O3RvOzznKJcnQW4r7MxhC41DJmHgSbUapgHpGPzNEO
         igsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SaDNVFpV/oFZvL50IMJ+aksLQj8pFjVfZykazLuHDNY=;
        b=mnwSW7l58uCf79n/842Ee7gkoefZBM4Qf3CJK+W4GxT8+rdgfoIZOSh7ZE7Zw4RcTQ
         YepEQJpNmd9yEp0sb6o7hY3ji9Bj5qkHPc/WL9PuuyMWs/U4cIxrakVSdqAd7ISUS7kU
         Yu6g4qQyfzQtc3GMurgkV+2XtirxiIEdcYFLWjKmScCEvaXg1+r2H4lmcDjbXc/LIVMz
         ZmeUvusu0vTcR8tIcs/FiLZXblcsEe4bhkJQjbxjMn6YunxQbkQFDLsDng0oJ/NLXmNg
         PIs33IJa+Br8gkLKqHpU1Mx7quP1Ts0Qm4FDsnHcPurBsDK9YU8tuUgAv813RDCw2gWZ
         kvCw==
X-Gm-Message-State: AOAM531vswy1crpddA6xuI1BM04yiIxv63DL/l01qR9oSnvezQ/rsqdv
        w4/t4JeiNEcAdZ9h/p1xaPf6UbhdDTM18w==
X-Google-Smtp-Source: ABdhPJx9AyXjl0xrq1EZG664/xo5G+Uack/Ewln/jfeLWEPzUBZLYtHIKPjUN8vEdennJGsaUVBNvg==
X-Received: by 2002:a17:903:1d0:b029:df:d098:f1cb with SMTP id e16-20020a17090301d0b02900dfd098f1cbmr8480698plh.49.1613064042909;
        Thu, 11 Feb 2021 09:20:42 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e15sm7415384pgr.81.2021.02.11.09.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 09:20:41 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] coresight: etm-perf: Clarify comment on perf options
Date:   Thu, 11 Feb 2021 10:20:36 -0700
Message-Id: <20210211172038.2483517-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211172038.2483517-1-mathieu.poirier@linaro.org>
References: <20210211172038.2483517-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

In theory, the options should be arbitrary values and are neutral for
any ETM version; so far perf tool uses ETMv3.5/PTM ETMCR config bits
except for register's bit definitions, also uses as options.

This can introduce confusion, especially if we want to add a new option
but the new option is not supported by ETMv3.5/PTM ETMCR.  But on the
other hand, we cannot change options since these options are generic
CoreSight PMU ABI.

For easier maintenance and avoid confusion, this patch refines the
comment to clarify perf options, and gives out the background info for
these bits are coming from ETMv3.5/PTM.  Afterwards, we should take
these options as general knobs, and if there have any confliction with
ETMv3.5/PTM, should consider to define saperate macros for ETMv3.5/PTM
ETMCR config bits.

Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-Id: <20210206150833.42120-2-leo.yan@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../hwtracing/coresight/coresight-etm-perf.c    |  5 ++++-
 include/linux/coresight-pmu.h                   | 17 ++++++++++++-----
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index bdc34ca449f7..465ef1aa8c82 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -27,7 +27,10 @@ static bool etm_perf_up;
 static DEFINE_PER_CPU(struct perf_output_handle, ctx_handle);
 static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
 
-/* ETMv3.5/PTM's ETMCR is 'config' */
+/*
+ * The PMU formats were orignally for ETMv3.5/PTM's ETMCR 'config';
+ * now take them as general formats and apply on all ETMs.
+ */
 PMU_FORMAT_ATTR(cycacc,		"config:" __stringify(ETM_OPT_CYCACC));
 PMU_FORMAT_ATTR(contextid,	"config:" __stringify(ETM_OPT_CTXTID));
 PMU_FORMAT_ATTR(timestamp,	"config:" __stringify(ETM_OPT_TS));
diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index b0e35eec6499..5dc47cfdcf07 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
@@ -10,11 +10,18 @@
 #define CORESIGHT_ETM_PMU_NAME "cs_etm"
 #define CORESIGHT_ETM_PMU_SEED  0x10
 
-/* ETMv3.5/PTM's ETMCR config bit */
-#define ETM_OPT_CYCACC  12
-#define ETM_OPT_CTXTID	14
-#define ETM_OPT_TS      28
-#define ETM_OPT_RETSTK	29
+/*
+ * Below are the definition of bit offsets for perf option, and works as
+ * arbitrary values for all ETM versions.
+ *
+ * Most of them are orignally from ETMv3.5/PTM's ETMCR config, therefore,
+ * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
+ * directly use below macros as config bits.
+ */
+#define ETM_OPT_CYCACC		12
+#define ETM_OPT_CTXTID		14
+#define ETM_OPT_TS		28
+#define ETM_OPT_RETSTK		29
 
 /* ETMv4 CONFIGR programming bits for the ETM OPTs */
 #define ETM4_CFG_BIT_CYCACC	4
-- 
2.25.1

