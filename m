Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45890311E52
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 16:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhBFPLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 10:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhBFPKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 10:10:06 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F857C0617AA
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 07:09:00 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id t25so6698933pga.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 07:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ky9/mb+HYy0WWl4mxlZ9J0RrhFZHwnjADbosyVIjsYk=;
        b=HlpA5GEVcrMJGPrmuM6bPK1RvfP8Fk+fycR62dEsBdXF53pY6j+1Sb5/XS92AH5O5J
         JS31C7oNrg1+xshAkDnrCGXJVOL6dSue/ewTIRfCfrblnpreLzYx+804qZRIXHvvSmH4
         RPCaFIT9MIqlND2oO9WkqTnC1v7N+qfHQLJlTC5lqg6r9XDlpi6ytLo5mQtmCtUWRmLf
         pJYj0lks3nNgc3rGpLArT1S5IA2koPGBxqL2Gm1n25i1LxDNZNlckpZ9rrVw11WTSLbh
         ZLXwCx8ixCFAHdWz4GgAYkIrAejnUTJxIqDUd2PWa4KetiujY3DB3hVuN+0d7XGqM2DM
         +g3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ky9/mb+HYy0WWl4mxlZ9J0RrhFZHwnjADbosyVIjsYk=;
        b=ly5dsWbU6OHklQ7jJk7RR6FBgUGsrqW3b65fn92kKBJXuTuLwdzEUfO/Y5DIA3hSqD
         L+l+xTI4SKY3Jpk7jrnjpIwgqCMEpOqD47YfetuJStnzDBQYBVknUwTCGo/Sguq8GGAB
         WMumxE1S0NFKb+1VcdWFNEupiFi1D1sszw+mzMXkl+Ln2Hev8CO9uDOpS+SySw/lMheg
         WhUpls6xLk7osdyqEIO3FzS8DGakzu4T0drAARn+wwRTwlIC0PJODcO5EGBh9iHG2CH4
         MtyDBVpc4uXyKFblTcwtGQPKrnhnCHf31/TYBu6V8kuhL0uXs3DbV4r7A8YGIDo+CmOa
         T9/Q==
X-Gm-Message-State: AOAM530EYTmM3wYHJC/5lclwiPfBddQed1DiHGPtD7AFmXM2oMWlBW9o
        1xbKACggfEKn8M895NF7aSyfrg==
X-Google-Smtp-Source: ABdhPJwbIxytbPlNskRr/JQoUDuGlqZ2DeCf+fQ8vnx5N4pgtsmSEDNr9ySkEA475x0amn6l6LzwUw==
X-Received: by 2002:aa7:91cf:0:b029:1cb:1c6f:b77d with SMTP id z15-20020aa791cf0000b02901cb1c6fb77dmr9817288pfa.74.1612624139977;
        Sat, 06 Feb 2021 07:08:59 -0800 (PST)
Received: from localhost ([45.137.216.202])
        by smtp.gmail.com with ESMTPSA id t1sm3560253pfl.194.2021.02.06.07.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 07:08:59 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        Al Grant <al.grant@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 6/8] perf cs-etm: Add helper cs_etm__get_pid_fmt()
Date:   Sat,  6 Feb 2021 23:08:31 +0800
Message-Id: <20210206150833.42120-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210206150833.42120-1-leo.yan@linaro.org>
References: <20210206150833.42120-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds helper function cs_etm__get_pid_fmt(), by passing
parameter "traceID", it returns the PID format.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 42 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/cs-etm.h |  1 +
 2 files changed, 43 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index a2a369e2fbb6..b9c1d329a7f1 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/coresight-pmu.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/log2.h>
@@ -156,6 +157,47 @@ int cs_etm__get_cpu(u8 trace_chan_id, int *cpu)
 	return 0;
 }
 
+/*
+ * The returned PID format is presented by two bits:
+ *
+ *   Bit ETM_OPT_CTXTID: CONTEXTIDR or CONTEXTIDR_EL1 is traced;
+ *   Bit ETM_OPT_CTXTID2: CONTEXTIDR_EL2 is traced.
+ *
+ * It's possible that the two bits ETM_OPT_CTXTID and ETM_OPT_CTXTID2
+ * are enabled at the same time when the session runs on an EL2 kernel.
+ * This means the CONTEXTIDR_EL1 and CONTEXTIDR_EL2 both will be
+ * recorded in the trace data, the tool will selectively use
+ * CONTEXTIDR_EL2 as PID.
+ */
+int cs_etm__get_pid_fmt(u8 trace_chan_id, u64 *pid_fmt)
+{
+	struct int_node *inode;
+	u64 *metadata, val;
+
+	inode = intlist__find(traceid_list, trace_chan_id);
+	if (!inode)
+		return -EINVAL;
+
+	metadata = inode->priv;
+
+	if (metadata[CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
+		val = metadata[CS_ETM_ETMCR];
+		/* CONTEXTIDR is traced */
+		if (val & BIT(ETM_OPT_CTXTID))
+			*pid_fmt = BIT(ETM_OPT_CTXTID);
+	} else {
+		val = metadata[CS_ETMV4_TRCCONFIGR];
+		/* CONTEXTIDR_EL2 is traced */
+		if (val & (BIT(ETM4_CFG_BIT_VMID) | BIT(ETM4_CFG_BIT_VMID_OPT)))
+			*pid_fmt = BIT(ETM_OPT_CTXTID2);
+		/* CONTEXTIDR_EL1 is traced */
+		else if (val & BIT(ETM4_CFG_BIT_CTXTID))
+			*pid_fmt = BIT(ETM_OPT_CTXTID);
+	}
+
+	return 0;
+}
+
 void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
 					      u8 trace_chan_id)
 {
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 4ad925d6d799..7cc3bba0017d 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -173,6 +173,7 @@ struct cs_etm_packet_queue {
 int cs_etm__process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session);
 int cs_etm__get_cpu(u8 trace_chan_id, int *cpu);
+int cs_etm__get_pid_fmt(u8 trace_chan_id, u64 *pid_fmt);
 int cs_etm__etmq_set_tid(struct cs_etm_queue *etmq,
 			 pid_t tid, u8 trace_chan_id);
 bool cs_etm__etmq_is_timeless(struct cs_etm_queue *etmq);
-- 
2.25.1

