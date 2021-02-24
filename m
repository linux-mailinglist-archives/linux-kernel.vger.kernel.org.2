Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3874532428C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbhBXQv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 11:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235413AbhBXQtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:49:53 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381D1C0617AB
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:48:43 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id o10so1823264pgg.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=glJhZa+yFUzXCGkagQvUI+4doW8HmcIalftw83QfG70=;
        b=N0zhfZCvUAlulRmcD70wR+wCkyMBEcSGdTvUISKL6EsUxvIl5Q8YRpc7sqcilgdYLi
         BiSIBE8J3uNMQQ9Bb/uD+4qlo6zvnFcBFD7ZAQseeh9+UnjW3GNVZsd4KroKrDelhkEq
         7AfBVWPLkOG2powRDMrT9soRv/F1ZAbpJH3at647WbmBr+dst/p6Xg2hXgVznj8+bpYw
         gzGMAC7O7RhmOVKJ763aVYlzfPRekoSzBVc4lILNvIMb/L93E6bM8r3vmSb9yG26mcsf
         /GmGuBP5qDtZ3Y+8Mq2e+NYpNHdQw1gCv/yiSDaWwhBUGXVhW7SmevnjfL8zPsdrjGOP
         +q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=glJhZa+yFUzXCGkagQvUI+4doW8HmcIalftw83QfG70=;
        b=jcGFLIjLoZKuwgvhNzK3RSk73yagQHSszTpbUeJC6Qun6x8ijHzb1s+jBqSR+xEOTS
         ULB+indlyeIiK5FXCt9i94eZ/iNi2BzLvgcgoZbTE3SttZicnUBED9eBMapOWEENTICv
         kD88DYoJHeLDpOknaxjhB+h/CIcN3KCfQGW1ZR8SY1+XCWl2C3/zv0OWOwFJiP9Jsj6G
         wkmDufqZrGcH9nxQzUv3gaZ88L9dmWUy2JbjdUtFyH6xiFgVwe41IYNrsG4DVvNnblXD
         sC+BobYZJdWrOW2qhUK7+qFTNuNYfFxgOQASwuhOL+tPKN6Wde4tArFzY3UvK7jXdFiE
         plbg==
X-Gm-Message-State: AOAM530h3oraKcCZCZAh6WiOFZ1Ro/teaF0Hnz7k/O4enWFLWRbWjpa4
        u/+mG/znphK4ZupULGrrnIbImmZfpPy9zA==
X-Google-Smtp-Source: ABdhPJy9cNIUI88RDI+939SAf9kLyNgwQidkhaPbzExR9UiKuYP+tMMuUAzp9p9ej5EE3tuyfCE6Zw==
X-Received: by 2002:a65:5a0a:: with SMTP id y10mr1825659pgs.122.1614185322778;
        Wed, 24 Feb 2021 08:48:42 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id m6sm3284793pfc.56.2021.02.24.08.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 08:48:42 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     mike.leach@linaro.org, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] perf cs-etm: Detect pid in VMID for kernel running at EL2
Date:   Wed, 24 Feb 2021 09:48:35 -0700
Message-Id: <20210224164835.3497311-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210224164835.3497311-1-mathieu.poirier@linaro.org>
References: <20210224164835.3497311-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

The PID of the task could be traced as VMID when the kernel is running
at EL2.  Teach the decoder to look for VMID when the CONTEXTIDR (Arm32)
or CONTEXTIDR_EL1 (Arm64) is invalid but we have a valid VMID.

Cc: Mike Leach <mike.leach@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Al Grant <al.grant@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Co-developed-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Link: https://lore.kernel.org/r/20210213113220.292229-6-leo.yan@linaro.org
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 38 +++++++++++++++++--
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 3f4bc4050477..4052c9ce6e2f 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -6,6 +6,7 @@
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
 
+#include <linux/coresight-pmu.h>
 #include <linux/err.h>
 #include <linux/list.h>
 #include <linux/zalloc.h>
@@ -491,13 +492,42 @@ cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
 			const ocsd_generic_trace_elem *elem,
 			const uint8_t trace_chan_id)
 {
-	pid_t tid;
+	pid_t tid = -1;
+	static u64 pid_fmt;
+	int ret;
 
-	/* Ignore PE_CONTEXT packets that don't have a valid contextID */
-	if (!elem->context.ctxt_id_valid)
+	/*
+	 * As all the ETMs run at the same exception level, the system should
+	 * have the same PID format crossing CPUs.  So cache the PID format
+	 * and reuse it for sequential decoding.
+	 */
+	if (!pid_fmt) {
+		ret = cs_etm__get_pid_fmt(trace_chan_id, &pid_fmt);
+		if (ret)
+			return OCSD_RESP_FATAL_SYS_ERR;
+	}
+
+	/*
+	 * Process the PE_CONTEXT packets if we have a valid contextID or VMID.
+	 * If the kernel is running at EL2, the PID is traced in CONTEXTIDR_EL2
+	 * as VMID, Bit ETM_OPT_CTXTID2 is set in this case.
+	 */
+	switch (pid_fmt) {
+	case BIT(ETM_OPT_CTXTID):
+		if (elem->context.ctxt_id_valid)
+			tid = elem->context.context_id;
+		break;
+	case BIT(ETM_OPT_CTXTID2):
+		if (elem->context.vmid_valid)
+			tid = elem->context.vmid;
+		break;
+	default:
+		break;
+	}
+
+	if (tid == -1)
 		return OCSD_RESP_CONT;
 
-	tid =  elem->context.context_id;
 	if (cs_etm__etmq_set_tid(etmq, tid, trace_chan_id))
 		return OCSD_RESP_FATAL_SYS_ERR;
 
-- 
2.25.1

