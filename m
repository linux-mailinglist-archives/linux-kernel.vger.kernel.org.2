Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A8735C253
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 11:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243759AbhDLJnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240730AbhDLJKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:10:54 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F23C061342
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:10:27 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id p12so8873922pgj.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b2AJdiv36eBYj95RGDnrJVH8a4LrKTTY6S8FUinX/Ek=;
        b=Td9+tp0wklJ8cJy3VNdoI8FvHbgafWiNNYrFEuuLLkAIg8DmNuruHKMheCyYiP7NtQ
         4IodPCkBl4C4hW+2nDcJNoTyKY1Rpek5iMB3nosruXirr7BSlE8an9jHytAU9gt42kIK
         vP969yuqrr1mybkcxBHVcETAw7dI2BU7BVtBjIeIY7xvGSYYEgv6ya0enzSCaDPsWR+u
         Xl0By+qUPeIRymThbK0s57f32ykZx3NI0gulVX3FeCmf2CUcxLRJr4mFtRjXcqqUXM8n
         y+W7VBGWQTaHr3DnZcRzM3PrUlfec9foWhTr6gTryRaKFA7JYk3wzOJKYaWrkTIyt0Ts
         TooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b2AJdiv36eBYj95RGDnrJVH8a4LrKTTY6S8FUinX/Ek=;
        b=LW5xXYlaSK2BGPR7A/nUn3AdpI8ROfoDWhTKo3pj26wVGpp3VJudi9c5Suezvosh4f
         vE3u7LPfcU4KzRjW8ECmPjZbNquQ6Tl+n7lflvxhtG5PzgcyRcCK3e2m+cTV+Rrwazpa
         kFjvjGaByWKgpgxshiitSYKO9mfTTnpfc+HBbiGPzmmLohZwTrb6sxVnqv9+xoF280O6
         lAXfavHK+IamP3mJj5sVSecpG270TmVMp112rnk6jWsKLkBZnbjJCzB+GT5cXHnD5LsV
         4Hf/s2Trll7zrvuPQntWHnbWtotP9sgZFQcAy+0MaZKCtkNmjVMkgto9U3A/Zfpo8Ufm
         S8Pg==
X-Gm-Message-State: AOAM5309oANpYXFHSEJST1j4QqtFLVcc4mFfmGxp9tOZSvwEvpPOO5Mv
        ML04Zl+2KMO6KSrchXX08w/r3w==
X-Google-Smtp-Source: ABdhPJziG0wwEPvJ8tGBnqDJmL17LQRkS6qICH0szLW3oAIHOgvlzefrtdZ00/ZP9HzlFDN6F2KYbQ==
X-Received: by 2002:a63:d61:: with SMTP id 33mr26266191pgn.201.1618218627554;
        Mon, 12 Apr 2021 02:10:27 -0700 (PDT)
Received: from localhost ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id t1sm1164493pjo.33.2021.04.12.02.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 02:10:27 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Al Grant <Al.Grant@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        James Clark <James.Clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 2/6] perf arm-spe: Save clock parameters from TIME_CONV event
Date:   Mon, 12 Apr 2021 17:10:02 +0800
Message-Id: <20210412091006.468557-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210412091006.468557-1-leo.yan@linaro.org>
References: <20210412091006.468557-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the recording phase, "perf record" tool synthesizes event
PERF_RECORD_TIME_CONV for the hardware clock parameters and saves the
event into the data file.

Afterwards, when processing the data file, the event TIME_CONV will be
processed at the very early time and is stored into session context.

This patch extracts these parameters from the session context and saves
into the structure "spe->tc" with the type perf_tsc_conversion, so that
the parameters are ready for conversion between clock counter and time
stamp.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 2539d4baec44..7620dcc45940 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -26,6 +26,7 @@
 #include "symbol.h"
 #include "thread.h"
 #include "thread-stack.h"
+#include "tsc.h"
 #include "tool.h"
 #include "util/synthetic-events.h"
 
@@ -45,6 +46,8 @@ struct arm_spe {
 	struct machine			*machine;
 	u32				pmu_type;
 
+	struct perf_tsc_conversion	tc;
+
 	u8				timeless_decoding;
 	u8				data_queued;
 
@@ -1006,6 +1009,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 {
 	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
 	size_t min_sz = sizeof(u64) * ARM_SPE_AUXTRACE_PRIV_MAX;
+	struct perf_record_time_conv *tc = &session->time_conv;
 	struct arm_spe *spe;
 	int err;
 
@@ -1027,6 +1031,29 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
 
 	spe->timeless_decoding = arm_spe__is_timeless_decoding(spe);
+
+	/*
+	 * The synthesized event PERF_RECORD_TIME_CONV has been handled ahead
+	 * and the parameters for hardware clock are stored in the session
+	 * context.  Passes these parameters to the struct perf_tsc_conversion
+	 * in "spe->tc", which is used for later conversion between clock
+	 * counter and timestamp.
+	 *
+	 * For backward compatibility, checks the event size and save extended
+	 * fields staring from "time_cycles" if these fields are contained in
+	 * the event.
+	 */
+	spe->tc.time_shift = tc->time_shift;
+	spe->tc.time_mult = tc->time_mult;
+	spe->tc.time_zero = tc->time_zero;
+
+	if (tc->header.size > ((void *)&tc->time_cycles - (void *)tc)) {
+		spe->tc.time_cycles = tc->time_cycles;
+		spe->tc.time_mask = tc->time_mask;
+		spe->tc.cap_user_time_zero = tc->cap_user_time_zero;
+		spe->tc.cap_user_time_short = tc->cap_user_time_short;
+	}
+
 	spe->auxtrace.process_event = arm_spe_process_event;
 	spe->auxtrace.process_auxtrace_event = arm_spe_process_auxtrace_event;
 	spe->auxtrace.flush_events = arm_spe_flush;
-- 
2.25.1

