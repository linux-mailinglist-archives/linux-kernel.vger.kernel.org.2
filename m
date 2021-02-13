Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB0131AB11
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 12:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhBMLg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 06:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhBMLdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 06:33:52 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22007C06178A
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 03:32:46 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id o21so1338391pgn.12
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 03:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e6PPt6Q0w52SGlwi3jxuH8NHG7/r6cFxIksj0jvT04Q=;
        b=EK00jZd7fBhtvrpq7rFToPozxX5PBjsyyvinkOIjI1day/gxjnZkqCmytiP4amIwqe
         gnfIqYMxZn4AOsME89943ha25ss38ujXrb5spdOoYsh25ZIXFltRUddFisUW2HrHg7v/
         DSauF4g7TnwfVb29tt/EKxuL4ukugNq4jnwfbyzeCrQxx68DLbYxlVE5TTl6YlYsHGYw
         dXU+UkwoQQghzTi8iImr5rUYL5QfWbz1NSGVksfbDfsgLE7sFn6KMY820GYv2h5Cx2Od
         QoHLfbtlZvXO2DVZXrxsRD/iHPh4FAVnO57cXl4vBJY91PaT21Jcrm8KlKZMiiOZi0ba
         fxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e6PPt6Q0w52SGlwi3jxuH8NHG7/r6cFxIksj0jvT04Q=;
        b=sBtED/Yb8yCrbR0Dt9ZLjM+zDAHa+2ddYMf+TKgEo3V4w+mWGi0Zep50/bxK6AOZ6V
         F98QMNMGsmNDZM2BAF0dfndogESsxplt6fw7JUFaTzHbnRhaWVhCDvYtFXqL4M0bzeca
         UBwMWjgnVYHeKBZ2NKoJXhzIb/t5dhfLrDr6hzFCfqQRgeERtSR+H7T5dxcUyE/uIapt
         /RLFHGpvlNp/7K2ySNfvGvaj6QgDX0s8AcNy/OaY67Lqg8iTvF0hzN+ky+I30aoMkQYq
         bNPF+IZ/Vs9Z82mM0zPTwUAW/4R7qPMPld18UAUnrRG4/uXSqU31ddsria20/bK8updp
         a79w==
X-Gm-Message-State: AOAM530F5BZ95oiJUR/6bTH3zPPxCTTcrnZrn+v7yZgh9jXhJkc/MgSh
        UF9lA0OxY6KolEIBYdOvpavmuQ==
X-Google-Smtp-Source: ABdhPJwo1LlrC26KOPPXr+TQvOf0ij8fmS73jkfYqITgdzmieo3kXeHK4EIaOYc9g1iYgnYeYkFSqg==
X-Received: by 2002:a63:9811:: with SMTP id q17mr7275763pgd.238.1613215965600;
        Sat, 13 Feb 2021 03:32:45 -0800 (PST)
Received: from localhost ([45.137.216.202])
        by smtp.gmail.com with ESMTPSA id f28sm13056434pfk.182.2021.02.13.03.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 03:32:45 -0800 (PST)
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
Cc:     Al Grant <al.grant@arm.com>, Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 5/5] perf cs-etm: Detect pid in VMID for kernel running at EL2
Date:   Sat, 13 Feb 2021 19:32:20 +0800
Message-Id: <20210213113220.292229-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210213113220.292229-1-leo.yan@linaro.org>
References: <20210213113220.292229-1-leo.yan@linaro.org>
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

