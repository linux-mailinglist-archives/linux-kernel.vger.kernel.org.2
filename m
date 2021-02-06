Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6668B311E53
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 16:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhBFPLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 10:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbhBFPKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 10:10:07 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE238C061356
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 07:09:03 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id s15so5069152plr.9
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 07:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pyq04aDyfklktjTYGZj1z7yEnQjahkQt1L+FxuD6rbc=;
        b=qouNmuiuA8NJ1l/H8300ZVUwur3oOXWDpVnlUcMcbSlVSiTRe22Z6KDCuf8kYKyk0U
         z+6ThKM6a8A/ne/di/CYjp1U55ffvgsiaUzHa/y38LW+iIJsNo2jJNn23X0dn4B4R2No
         8Wh82ynNFEzR3vG1/1H3hJW9+XzWOVWBh/3IwkbD7KaYLSyNtT9ktnn78f/VerycS3N7
         PrHCCtQ3bZZLFeJE3o+ZnWn/6nQnG4WrJjUr+BvKChM99ZhbZmw+cDXQh25eDV9NnK/h
         RX0OqfGrS0MM48on+Mow4AR93900EiV7lD46cqduxcg2Cca9zsCqCO/R+TNdgm3oV0VD
         LA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pyq04aDyfklktjTYGZj1z7yEnQjahkQt1L+FxuD6rbc=;
        b=kO5WjNZDNgEXIVnG+pUOXK3Ps5NAKh3LxddnMFoaSlT2Y43b02bl2retkIOhmYpWFc
         SFUaZo8l++FHzommwj6qpW7WVBpMlgbQfLgH2mK1fR4afwqKZfR7mVvwfm95lznEsuCg
         AMacDdXCyz7i/PliLmnM7HzVsJS/AvO0G/q7JrZk179K+hixGtpJsXt5LnXF2CyARFTT
         8rwJCquc169qASzOisbyPJMb7BQkDbOq3sKWxWUwp4B3/pgJBIaYcBfZFS1cNy98yXZM
         IT5tl2LCcCCLrnznwthhjsmltc+JlwWtx1LpiFbVuOPCNah7SbNgaZx46BS8HHXZ1Z3g
         S4yA==
X-Gm-Message-State: AOAM532S7b93LiPQwLubHzwegOXbVDmKyIe7RRKGsI4z6BYjVM+psW7k
        00ThFdXMx8aMTVbgzCNmndrdWg==
X-Google-Smtp-Source: ABdhPJwj+OVRVnKmsjDw1DYmbunE3T7l8kU39KGFhJEnF6qVIppWsp0LC23v9mPduTbJKz6UchQxqA==
X-Received: by 2002:a17:90a:a890:: with SMTP id h16mr723147pjq.125.1612624143395;
        Sat, 06 Feb 2021 07:09:03 -0800 (PST)
Received: from localhost ([45.137.216.202])
        by smtp.gmail.com with ESMTPSA id f15sm11364222pja.24.2021.02.06.07.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 07:09:02 -0800 (PST)
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
Subject: [PATCH v3 7/8] perf cs-etm: Detect pid in VMID for kernel running at EL2
Date:   Sat,  6 Feb 2021 23:08:32 +0800
Message-Id: <20210206150833.42120-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210206150833.42120-1-leo.yan@linaro.org>
References: <20210206150833.42120-1-leo.yan@linaro.org>
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

