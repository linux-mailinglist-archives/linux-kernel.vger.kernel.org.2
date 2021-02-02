Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C641D30C641
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236749AbhBBQn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236759AbhBBQkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:40:08 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7398C0617AA
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 08:39:27 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id g15so2733014pjd.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 08:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AW8CUVNikpRcfCmlQlkKe+p5l74C17GQZxwOIyIje8c=;
        b=sMKh1VDH4XQ4uNnZpqULVrGrFKyOK1UHUpKnfFvXTOF3DOv9YSlI9v6+EmTG0URk+l
         rgGFfFLLVSaG+OEpsBqycNJbn8F9JqbeqMjqGb0rmumIlH8fyKWbRJyDIDELigIpcO4w
         5cREhHhVvKMluIKxx42crdk0aK9EZboWm0iPJf3UXxHwYXaE5xn56CweqY2pgCNXtl+X
         Vxx8cyYOBSMFpXmaV8El/CuAxnbm1URG1gZqjYplOQ9ZfJM2h7WZNc09u6Cx/l8NRGuj
         wyZ9KmWRn1CkaL1OHazf6SXbaf305m92NECrvoj8fiJtk9pC3vSAv2oD+XOUCbRCXvYV
         oRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AW8CUVNikpRcfCmlQlkKe+p5l74C17GQZxwOIyIje8c=;
        b=sefm/l0z8WksNHd81I47Tab5LGT1dkCLrFOo97oT4gsz8nW6Nw8CC5bNAOn7mt6w8g
         t1D6gUwxkIJxJ5Pg3gLrtnKe0DEZVBXgK7JFnaEe6iiVdmAvZIw2zFsn66QgZvipQW5K
         I4jaqM/eHj/7XAemkZFLahQgytMExkEntOnF1sH6OeLm5IwdSpdDB4Xgs07e9fmsR9nL
         loKRwnZRwM9Am5vcvs2qWGzZEf4pKm81FJILn4Jgp7to9b5F4Qipmb21BpUDcbrKWj2a
         ZZsN227+ShEEqyerif5QU9g+u5TGI8is9LHv1TO9EkZDNuGEhk38XcDPXofDzdm/chgu
         Bigw==
X-Gm-Message-State: AOAM530mBUeKsFvL91rgHORWPhvXkr0oF7h1GoE70f+aMlL8DoPaX6TE
        zQ1pn3bJ12vz3G9nv9akk2dDNQ==
X-Google-Smtp-Source: ABdhPJxiAKNBNJDKgM6MXUFZjUxFiAN8UPHm4njx5CDHH1RDm+7QarExdpmAQyLvyYB9j3cl7Xcduw==
X-Received: by 2002:a17:90b:1a8b:: with SMTP id ng11mr5468385pjb.160.1612283967292;
        Tue, 02 Feb 2021 08:39:27 -0800 (PST)
Received: from localhost ([45.137.216.202])
        by smtp.gmail.com with ESMTPSA id x3sm23344320pfp.98.2021.02.02.08.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:39:26 -0800 (PST)
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
Subject: [PATCH v2 6/7] perf cs-etm: Detect pid in VMID for kernel running at EL2
Date:   Wed,  3 Feb 2021 00:38:41 +0800
Message-Id: <20210202163842.134734-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210202163842.134734-1-leo.yan@linaro.org>
References: <20210202163842.134734-1-leo.yan@linaro.org>
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
Co-developed-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 32 ++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 3f4bc4050477..fb2a163ff74e 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -6,6 +6,7 @@
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
 
+#include <linux/coresight-pmu.h>
 #include <linux/err.h>
 #include <linux/list.h>
 #include <linux/zalloc.h>
@@ -491,13 +492,36 @@ cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
 			const ocsd_generic_trace_elem *elem,
 			const uint8_t trace_chan_id)
 {
-	pid_t tid;
+	pid_t tid = -1;
+	u64 pid_fmt;
+	int ret;
 
-	/* Ignore PE_CONTEXT packets that don't have a valid contextID */
-	if (!elem->context.ctxt_id_valid)
+	ret = cs_etm__get_pid_fmt(trace_chan_id, &pid_fmt);
+	if (ret)
+		return OCSD_RESP_FATAL_SYS_ERR;
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
+	case BIT(ETM_OPT_CTXTID2) | BIT(ETM_OPT_CTXTID):
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

