Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CD8324289
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbhBXQvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 11:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235705AbhBXQtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:49:51 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C80EC0617AA
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:48:42 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id p21so1799351pgl.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WJ9CWLx2SrWUq/hh48DgFiOY7h1Fej0UywIRMqUv0R8=;
        b=RlQiOXdErQv5lTFk7nmrEQGazixBihx8nByWY+9Q4pwU8DhP8w6Ob4zjUfdGyJ9kX8
         oTJ/lXU5SKUJaqYW6DJTpzMFZ1YlHSRIdMY+nWYsjy0iVopvCf0MEPY8WWvAebr5AiTi
         XW7rC6KtWH0xPWgdFalJB9DPzgm30BGrx7k/mpiMj5/J9AscL8RsVztjrfX0qykIpcr1
         dS0v+jVf3bqMwB0nphK95FLvGDSEAyQVYpHWk7T5TdsFfW+JEKhZ1YWT4QNR/jsFS48y
         XJEW1LERZ0MUPHPUkv40mJJpF4JWw/Ve5zwYRrIlBe21MBpswYwm51oF8PFQ53WxZ3Ua
         Qz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WJ9CWLx2SrWUq/hh48DgFiOY7h1Fej0UywIRMqUv0R8=;
        b=XlxAyiAfVfzEtzaBjqoirzIPvhmDcDNI/DSrR60Jw+ST5sgZPONccYYYP2d1oVjPaV
         3bGcVeFms/0kF0xE9ZGVBGXQY4huYSr5FDyyVjIpkHk4OPpoNTLQ7DTGMgHWCt+guWJ5
         F5x419KRlIXTFBm8w6d4s2TQ1RjM0g/Yz9PPYBHzuYB0IGMjnMJ7vbgq2OIFsFCiPs8Q
         usMOB9mRhh4k6WLp9pRAxIjHqFWBtou/KfP2W/Qn6wNH2U2fZJHbe32wde5GL6ppXdiE
         hHiEi4qr5uJQJhcVR9MThMF3X337T/BCgZ8pz5PhsuTbal1fEFc1E/IFaTry+26qP41J
         21bw==
X-Gm-Message-State: AOAM532LDCB7k4O3TBy2Opjcu4E4Xa0+Jc7kk7i/fhlk/NER/GQQVu0r
        xPuvvrSq/rwHHIlxmjBEcMIkXR5vaocy0Q==
X-Google-Smtp-Source: ABdhPJw8cdNkUmFPla2oHioCIi+LNQO3Cl87pdaWwxyK93BDbrF2idxOKXsWKiSEfYTOtCq8oi9MEg==
X-Received: by 2002:a63:5f17:: with SMTP id t23mr5741874pgb.145.1614185321898;
        Wed, 24 Feb 2021 08:48:41 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id m6sm3284793pfc.56.2021.02.24.08.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 08:48:41 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     mike.leach@linaro.org, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] perf cs-etm: Add helper cs_etm__get_pid_fmt()
Date:   Wed, 24 Feb 2021 09:48:34 -0700
Message-Id: <20210224164835.3497311-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210224164835.3497311-1-mathieu.poirier@linaro.org>
References: <20210224164835.3497311-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

This patch adds helper function cs_etm__get_pid_fmt(), by passing
parameter "traceID", it returns the PID format.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20210213113220.292229-5-leo.yan@linaro.org
---
 tools/perf/util/cs-etm.c | 42 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/cs-etm.h |  1 +
 2 files changed, 43 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index ee32d023e9bd..9ac80fc23c58 100644
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
index e153d02df0de..85ed11e9d2a7 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -193,6 +193,7 @@ struct cs_etm_packet_queue {
 int cs_etm__process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session);
 int cs_etm__get_cpu(u8 trace_chan_id, int *cpu);
+int cs_etm__get_pid_fmt(u8 trace_chan_id, u64 *pid_fmt);
 int cs_etm__etmq_set_tid(struct cs_etm_queue *etmq,
 			 pid_t tid, u8 trace_chan_id);
 bool cs_etm__etmq_is_timeless(struct cs_etm_queue *etmq);
-- 
2.25.1

