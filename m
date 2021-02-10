Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445BC316B80
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 17:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhBJQl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 11:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbhBJQg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:36:56 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDE4C061786
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 08:36:16 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id z6so1619065pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 08:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GRN9yzymtSZ9Y0ZZfaRQVwKduE5L+sTAznMrnIO9T8g=;
        b=VtR37D/wvtRgOgUb38l7drJAQihrMInQXn77Nna5ua0Y+6948KXeYyhBBpjlCmBqU3
         NJB9cWDfzJyVrdb5qe0GZno3EyI9JI8L7i6SgEaT7bUucmkXQEivs+LUSCs/F4OjKS6h
         DeD82AmhX2Yz527pGC7Wh+1kUzkzk+Ul5A3mSPTizoJ2iBTV3lVnGbYmZ46J1GkEnsvU
         l8SSvwV/Ec5GPNiqHnkN6M6zjBXXvCOwSZToKb75GmGM9N8qTs32977IIhgq3q90kDD8
         ZV1/citRgM7cId3pu1JonNxh79J/Ny/+hVGvx91MHrMdHelTIxbjgr7ZpdLP75/bgKv6
         Oxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GRN9yzymtSZ9Y0ZZfaRQVwKduE5L+sTAznMrnIO9T8g=;
        b=PVpxWKqnDedcBvzf6kpSnurva19K6r/Cl0SSg+CLpzBTkDcVWt4dqksXmfDSZb5Y0O
         ssS7lbv6TII5ENrzdfJXCdjzyz8p2zdUAlg2Jp5k5WhKMfBaUBv3s4dWkoGfEBKF3bz+
         qU09kSZLsyHsoGKpO2JaUWNj1+aANWnjjt8IsQkq6kfVMR4Td6Hx9ajGjy9m3ZMZ3LIT
         lTa5Tf+KSl4J53Q5gkwEpTrWLTsfykSxnIBMYB4i0ffXNHviT0fMNOst5J5mIPnqy0Qq
         nMkTX4mQRtXOGrAJJ/Q4xSc+PpYxAqVla+DXgR+NQ7tWbMbOmldiNXlbxs/5PB2TI+xX
         7fcA==
X-Gm-Message-State: AOAM530p4MlllLOec4B2YplTfMDEoK8Grl/Q3t7g0OIYtmRtji0qS0XQ
        KlFHlI9cAPxYHLFx5GLGK1Xsww==
X-Google-Smtp-Source: ABdhPJx+yJ+E62tQ8dIh/dZm3sf357EN4qS7RTo9inetOLEJgnwebraZbE4tv72e5lPK50dHamO+tQ==
X-Received: by 2002:a63:5952:: with SMTP id j18mr3857058pgm.29.1612974976219;
        Wed, 10 Feb 2021 08:36:16 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id bv21sm2914637pjb.15.2021.02.10.08.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 08:36:15 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] coresight: etm-perf: Support PID tracing for kernel at EL2
Date:   Wed, 10 Feb 2021 09:36:09 -0700
Message-Id: <20210210163610.2338491-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210210163610.2338491-1-mathieu.poirier@linaro.org>
References: <20210210163610.2338491-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

When the kernel is running at EL2, the PID is stored in CONTEXTIDR_EL2.
So, tracing CONTEXTIDR_EL1 doesn't give us the pid of the process.
Thus we should trace the VMID with VMIDOPT set to trace CONTEXTIDR_EL2
instead of CONTEXTIDR_EL1.  Given that we have an existing config
option "contextid" and this will be useful for tracing virtual machines
(when we get to support virtualization).

So instead, this patch extends option CTXTID with an extra bit
ETM_OPT_CTXTID2 (bit 15), thus on an EL2 kernel, we will have another
bit available for the perf tool: ETM_OPT_CTXTID is for kernel running in
EL1, ETM_OPT_CTXTID2 is used when kernel runs in EL2 with VHE enabled.

The tool must be backward compatible for users, i.e, "contextid" today
traces PID and that should remain the same; for this purpose, the perf
tool is updated to automatically set corresponding bit for the
"contextid" config, therefore, the user doesn't have to bother which EL
the kernel is running.

  i.e, perf record -e cs_etm/contextid/u --

will always do the "pid" tracing, independent of the kernel EL.

The driver parses the format "contextid", which traces CONTEXTIDR_EL1
for ETM_OPT_CTXTID (on EL1 kernel) and traces CONTEXTIDR_EL2 for
ETM_OPT_CTXTID2 (on EL2 kernel).

Besides the enhancement for format "contexid", extra two formats are
introduced: "contextid1" and "contextid2".  This considers to support
tracing both CONTEXTIDR_EL1 and CONTEXTIDR_EL2 when the kernel is
running at EL2.  Finally, the PMU formats are defined as follow:

  "contextid1": Available on both EL1 kernel and EL2 kernel.  When the
                kernel is running at EL1, "contextid1" enables the PID
		tracing; when the kernel is running at EL2, this enables
		tracing the PID of guest applications.

  "contextid2": Only usable when the kernel is running at EL2.  When
                selected, enables PID tracing on EL2 kernel.

  "contextid":  Will be an alias for the option that enables PID
                tracing.  I.e,
                contextid == contextid1, on EL1 kernel.
                contextid == contextid2, on EL2 kernel.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Al Grant <al.grant@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
[ Added two config formats: contextid1, contextid2 ]
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Message-Id: <20210206150833.42120-4-leo.yan@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../hwtracing/coresight/coresight-etm-perf.c  | 27 ++++++++++++++++++-
 .../coresight/coresight-etm4x-core.c          | 13 +++++++++
 include/linux/coresight-pmu.h                 |  3 +++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 465ef1aa8c82..0f603b4094f2 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -32,15 +32,40 @@ static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
  * now take them as general formats and apply on all ETMs.
  */
 PMU_FORMAT_ATTR(cycacc,		"config:" __stringify(ETM_OPT_CYCACC));
-PMU_FORMAT_ATTR(contextid,	"config:" __stringify(ETM_OPT_CTXTID));
+/* contextid1 enables tracing CONTEXTIDR_EL1 for ETMv4 */
+PMU_FORMAT_ATTR(contextid1,	"config:" __stringify(ETM_OPT_CTXTID));
+/* contextid2 enables tracing CONTEXTIDR_EL2 for ETMv4 */
+PMU_FORMAT_ATTR(contextid2,	"config:" __stringify(ETM_OPT_CTXTID2));
 PMU_FORMAT_ATTR(timestamp,	"config:" __stringify(ETM_OPT_TS));
 PMU_FORMAT_ATTR(retstack,	"config:" __stringify(ETM_OPT_RETSTK));
 /* Sink ID - same for all ETMs */
 PMU_FORMAT_ATTR(sinkid,		"config2:0-31");
 
+/*
+ * contextid always traces the "PID".  The PID is in CONTEXTIDR_EL1
+ * when the kernel is running at EL1; when the kernel is at EL2,
+ * the PID is in CONTEXTIDR_EL2.
+ */
+static ssize_t format_attr_contextid_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *page)
+{
+	int pid_fmt = ETM_OPT_CTXTID;
+
+#if defined(CONFIG_CORESIGHT_SOURCE_ETM4X)
+	pid_fmt = is_kernel_in_hyp_mode() ? ETM_OPT_CTXTID2 : ETM_OPT_CTXTID;
+#endif
+	return sprintf(page, "config:%d\n", pid_fmt);
+}
+
+struct device_attribute format_attr_contextid =
+	__ATTR(contextid, 0444, format_attr_contextid_show, NULL);
+
 static struct attribute *etm_config_formats_attr[] = {
 	&format_attr_cycacc.attr,
 	&format_attr_contextid.attr,
+	&format_attr_contextid1.attr,
+	&format_attr_contextid2.attr,
 	&format_attr_timestamp.attr,
 	&format_attr_retstack.attr,
 	&format_attr_sinkid.attr,
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 5017d33ba4f5..bb1ec5f28ff6 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -550,6 +550,19 @@ static int etm4_parse_event_config(struct etmv4_drvdata *drvdata,
 		/* bit[6], Context ID tracing bit */
 		config->cfg |= BIT(ETM4_CFG_BIT_CTXTID);
 
+	/*
+	 * If set bit ETM_OPT_CTXTID2 in perf config, this asks to trace VMID
+	 * for recording CONTEXTIDR_EL2.  Do not enable VMID tracing if the
+	 * kernel is not running in EL2.
+	 */
+	if (attr->config & BIT(ETM_OPT_CTXTID2)) {
+		if (!is_kernel_in_hyp_mode()) {
+			ret = -EINVAL;
+			goto out;
+		}
+		config->cfg |= BIT(ETM4_CFG_BIT_VMID) | BIT(ETM4_CFG_BIT_VMID_OPT);
+	}
+
 	/* return stack - enable if selected and supported */
 	if ((attr->config & BIT(ETM_OPT_RETSTK)) && drvdata->retstack)
 		/* bit[12], Return stack enable bit */
diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index 5dc47cfdcf07..4ac5c081af93 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
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
-- 
2.25.1

