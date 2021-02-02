Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1BD30C637
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbhBBQl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbhBBQjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:39:54 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515ABC06178C
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 08:39:14 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id r38so15218980pgk.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 08:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YKQ2Uuk22SDzqtH5p9HNVi65OgzC74U0uil1Sq8AVic=;
        b=PoUCVFQ2SrsgvCiA+YUyY9Wdl/S9yhZGEoknQNjHBdt/ziziTiUS3HivVYepE2qk1c
         HzQy3u8N1/ew0rBtOj0xXZx/ykR9RfZyjkfCLBict6YdUFZluA7tijWcH1pen+58Ka55
         hwN/WeH7lYSzTu/fxCrPUNLOhCuEqh6OlJGVMxQW4NyrZnXmz7nuOjcZ8oKDDh4PmC4d
         m00VoE/+hGR5cMNa3BWhL80a978cof+I+mPtnwH9l6KNoqokPze81S+sABrlHqcHOfLF
         YqLqJaD+OwmvI8+Y1pAunljyiK3lpWQnTDdtSaec6xlxNgvl2h6qAGF1Ii9ec62VVV1y
         h1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YKQ2Uuk22SDzqtH5p9HNVi65OgzC74U0uil1Sq8AVic=;
        b=KD0x6Gh2JGEVhbMQPUuC4nedIroavC6wOa8zqxkuPhZYScilLv0EZ1T/fGFtzm5101
         JdB/JgJ1ayfQkDnkoLDws6lSfxRIdxgkqsB1AU8jMyaALs1TepZLf+sir6ifwDFjoakt
         C9SJub5E+S0ceCUCawMJBLaGzrjM+1dcYfyHXOcwnKxabeixlKS5ju0FB3qoTPU4UzWg
         SQ2URT7FeH8DZudhgDqNUZ+IFf90DDfcuySpiFwe2IPNEIK59L8rONp+yWG1cEg5Pp+f
         P9gvB9O2bBAVqaGVx9m+gLqjovR7yc9TD+EODJBqcJzy/PhJyF9p5k6Tyu0UgA8aQxm0
         nwtg==
X-Gm-Message-State: AOAM532vrIAxtoQCcSwGGf91KCCYMeIO7WPRe+r4wTQGqZEZuhZxwIhw
        ra32UhbobJb0Nns0tDfedHMzrA==
X-Google-Smtp-Source: ABdhPJyvNcZw6DdnoPxJeWtsw6gbHQ+Rr7SvuO7orASJ8vHLJjoc45uYqmBu9JH36AESQ1YoNq84fg==
X-Received: by 2002:aa7:8edd:0:b029:1b7:9f41:c4d8 with SMTP id b29-20020aa78edd0000b02901b79f41c4d8mr22153133pfr.39.1612283953799;
        Tue, 02 Feb 2021 08:39:13 -0800 (PST)
Received: from localhost ([45.137.216.202])
        by smtp.gmail.com with ESMTPSA id v16sm21617844pfu.76.2021.02.02.08.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:39:13 -0800 (PST)
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
Subject: [PATCH v2 2/7] coresight: etm-perf: Support PID tracing for kernel at EL2
Date:   Wed,  3 Feb 2021 00:38:37 +0800
Message-Id: <20210202163842.134734-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210202163842.134734-1-leo.yan@linaro.org>
References: <20210202163842.134734-1-leo.yan@linaro.org>
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
Signed-off-by: Leo Yan <leo.yan@linaro.org>
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
index b20b6ff17cf6..8681c225b0ba 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -477,6 +477,19 @@ static int etm4_parse_event_config(struct etmv4_drvdata *drvdata,
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

