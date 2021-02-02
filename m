Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5CD30C63F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236772AbhBBQmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbhBBQkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:40:04 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473F2C061786
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 08:39:24 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id z21so15250661pgj.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 08:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V2lSRSt7N2kcQ0+pfELKM7JZFhVM2Dwdlyux9eP2c0c=;
        b=sayQXgMDWznfBbxktPHzwshYZhmop5peILAxFgiQn94AIcgnL/xRLNVph3GW6XuCT3
         GB0Z3A8HWWs7pWAD2gGXwIUQoLn3hB7yQxYRJP3K4vGvfAurjIWNHhTWn7a2BmuOwsGO
         EpPo9HRIhO2Aa61VVThHtGtr5AE3UFy6imSWxpeS3hMHXzrB9/QInfPdz7hKEkD24AwO
         2wGLsOy+5p0IsgZZogeWQfxti+mhErSZAf2IZpf2A72uZnytyrmKMyqeQ1E3TDQCqHET
         EaGe5l4rHnIb/d+YdIE9xi4ezl+Y3Np8mufbnhR5lSrJeyuXj07GW3iAwD7BFzt3jK0q
         JISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V2lSRSt7N2kcQ0+pfELKM7JZFhVM2Dwdlyux9eP2c0c=;
        b=l7ZwLC6sBar3/pWNbVihqfchX4V4IPfiumX/zXX4BXkFUxvp/dYhbhAp9WlHDTADIv
         dbPRSuz8ssZTrsHjWU9/H+DNNxG/OgOVPnwWaNu3eMNUvyKE86Wdq5DnwgG4pZbZ00pv
         qpxies+chvBK3rAYWcpFwswc0qUPLfNqdpFromKt8xO9CaJIel28J4/QDkeWskJLE/es
         3TiKpZHu+LbXlgtXoe4n10y/MTkygf7wk5aMDXf2V22iTLilcdI1CZf4faFDv3pIA3AC
         Ts0Krox2QuSza4nxxWa03v68jHlFAkgO54WHTB2o48OKH7vnZCqSi/D6azCTg9ThvRUv
         1QvA==
X-Gm-Message-State: AOAM532rJe5QFG/KJSf8sMBbUkbzUJgU8ZNI/ciKDt2C2RUHltenj1eE
        XvVX0TY7CS5RLOsa8o7NEeSX1A==
X-Google-Smtp-Source: ABdhPJyS6ootz5/MUIbpCq0nnbh/qg8NapSJATnyWajH1UfDBRNOOGycEMGhBKOnWlDY9XhgE5qz6w==
X-Received: by 2002:aa7:83c2:0:b029:1a5:daa9:f22f with SMTP id j2-20020aa783c20000b02901a5daa9f22fmr21612501pfn.48.1612283963844;
        Tue, 02 Feb 2021 08:39:23 -0800 (PST)
Received: from localhost ([45.137.216.202])
        by smtp.gmail.com with ESMTPSA id a37sm21936861pgm.79.2021.02.02.08.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:39:23 -0800 (PST)
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
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 5/7] perf cs-etm: Add helper cs_etm__get_pid_fmt()
Date:   Wed,  3 Feb 2021 00:38:40 +0800
Message-Id: <20210202163842.134734-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210202163842.134734-1-leo.yan@linaro.org>
References: <20210202163842.134734-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds helper function cs_etm__get_pid_fmt(), by passing
parameter "traceID", it returns the PID format.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 43 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/cs-etm.h |  1 +
 2 files changed, 44 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index a2a369e2fbb6..8194ddbd01e5 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/coresight-pmu.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/log2.h>
@@ -156,6 +157,48 @@ int cs_etm__get_cpu(u8 trace_chan_id, int *cpu)
 	return 0;
 }
 
+/*
+ * The returned PID format is presented by two bits:
+ *
+ *   Bit ETM_OPT_CTXTID: CONTEXTIDR or CONTEXTIDR_EL1 is traced;
+ *   Bit ETM_OPT_CTXTID2: CONTEXTIDR_EL2 is traced.
+ *
+ * It's possible that these two bits are set together, this means the tracing
+ * contains PIDs for both CONTEXTIDR_EL1 and CONTEXTIDR_EL2.
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
+
+		*pid_fmt = 0;
+
+		/* CONTEXTIDR_EL2 is traced */
+		if (val & (BIT(ETM4_CFG_BIT_VMID) | BIT(ETM4_CFG_BIT_VMID_OPT)))
+			*pid_fmt = BIT(ETM_OPT_CTXTID2);
+
+		/* CONTEXTIDR_EL1 is traced */
+		if (val & BIT(ETM4_CFG_BIT_CTXTID))
+			*pid_fmt |= BIT(ETM_OPT_CTXTID);
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

