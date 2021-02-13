Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECB831AB10
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 12:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhBMLfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 06:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhBMLdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 06:33:23 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F489C061788
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 03:32:43 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id fa16so1069139pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 03:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DDx+J7LYJk+PUgNgvQjSySDpyLHvv32UH/PV1/PNx2s=;
        b=S89AdnwalueeUAqpGFtAuEuDdIEbajrxuel592+vWwr4DXiAWm3hYQLUE4B5ffyVWH
         P9c8iZnlxWnQn5Drqv0nH4HfLRTQ9Jv5QVoJ/fRce/RcleI89y9iqSZ8iHBnSl49DHVv
         QZrghPabZxdAqVkL1eKcDZaEWwEhM2moP18T0rhR1fGBMenPF1z1xHHK1XRTLxwcZKW8
         kM/56eKcNqbgmD1OCQU4WIjMMcrYGLdGH7UtP5K/eFEhSMXIGEeWz28Gu8P4FLshdOP8
         vzIp27ERA/evcea3jFfNUHbqnsEh5qe1qP312TXmwUbe5lYEjz5/rUGqOs8XhpeEWkli
         W1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DDx+J7LYJk+PUgNgvQjSySDpyLHvv32UH/PV1/PNx2s=;
        b=fDw0bTfLAkclh812qYDQlRYNVDNfiv+C8Er0/bQDxIeE/KB7ONpWJ6S5XHUvTlL9oa
         UuWHFxONHYDxTQhm4IN5yDh6W6FTWxMK6/UGytAsrH4SyTKcT5WRck/1tSZeaD2LJkG3
         20M4DsqkzRLS2+yJxSz+Oc6aHmA5sTe6O2tSjY5LUd8QwYeMLQmfQ6FUW8b6H9ySul+a
         QR2f0lbfjh+P4354ZQYHO8MjYP8Hz3RD2s+7zXqz4fAF4iHlYIZGr/DQJKp1pSyPKPgA
         K3yR3E+en1TmUFNj0mA0+12Nc1bK4bHifxIuDiKroON91j7nejIX46MCFv4PiUMpvJrJ
         vCrw==
X-Gm-Message-State: AOAM532MxGp/3aEgK/Fv9zuitQXlqiL3XYTV2nNndX8BdRQf9ZDy/7X8
        oEuud9CJjbCXHY1fdUFL3r39xQ==
X-Google-Smtp-Source: ABdhPJyKT+pueEHN0aEbRDROU9nrStIWq+JLQSDpH4a6CYifZ+e6E6AL7mHbZWsCsuGzWcTm9xyiaA==
X-Received: by 2002:a17:90a:1542:: with SMTP id y2mr7008570pja.123.1613215962577;
        Sat, 13 Feb 2021 03:32:42 -0800 (PST)
Received: from localhost ([45.137.216.202])
        by smtp.gmail.com with ESMTPSA id z22sm12444917pfa.41.2021.02.13.03.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 03:32:42 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 4/5] perf cs-etm: Add helper cs_etm__get_pid_fmt()
Date:   Sat, 13 Feb 2021 19:32:19 +0800
Message-Id: <20210213113220.292229-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210213113220.292229-1-leo.yan@linaro.org>
References: <20210213113220.292229-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds helper function cs_etm__get_pid_fmt(), by passing
parameter "traceID", it returns the PID format.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
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

