Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3500D3532F4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 09:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbhDCHYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 03:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236385AbhDCHYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 03:24:06 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF21C0613E6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 00:24:04 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id t5so1464469plg.9
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 00:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yDQkVFQx1wvSF4PwfMYbvtAIynpYf0Emi2vuQmMgMls=;
        b=bObzaMlWPQofgYLHAngb5As25NaWGFH1YLsEzWOmlIGOhn1sarRoAnavxwnzzOnLc0
         qTFF2buCxOfwV2Xx1c0QXVJQ8rQKXROVWCQzhfHOIcBH57MOnCsyH5IhYaoxz7cDwHQ+
         eJIuJ5s1T/irkVnfv+vmc2XbFEZjNdVnPDlA6jr513xj/XkX56oU7Gi3qY+1JcCSabxu
         ODLcMMDIftc84OaQAVSUty1wSsSAw+oBnd/xjhsl7vnHv9qKB0/mdwkRwZqo7OH+aRNu
         Kng23a49Rp/e12TXO+tuvEeHV1W4RrELiuGkdbrpHJCP5jEvrpU8e3UKvz3ld7xiiZGe
         s3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yDQkVFQx1wvSF4PwfMYbvtAIynpYf0Emi2vuQmMgMls=;
        b=NJgs/KwtU1LhhhaTX1ocjM3WSmpD9ttc5Qhy9bQQpQNeCwIvcUqw8BGzOZJN970Wnq
         h/EQ6JY73nBXaWgEXXLL4RsTK3VYqgZxSaocCSt5wMi8AhLvFgcD7UQ4qE2xUqx5I21m
         YV8e52Gmm0fheyd65FNHWm/21YaRwvxVkEf3aQITYbQ3FjvcrMgXW/MDhCkTftdbqHXE
         vSJhuEhC5YdYC/Z/Gj5hAu9DAvX3SRyhgJbQ8NKeJhVwnsJTG7HljNjnc+Mdprq7NI+P
         EpowC7DvIyPC88TXFpc5dGclUEp7g3PwUjmMxipt1Oq/pvIJqm9XVzCxDcfmSSKkjzRp
         WbNg==
X-Gm-Message-State: AOAM531kKnilz41wHqfVh+ikyeRuXf/eeOOHjOxd7foeLVS2zUqpwc+9
        Qz+dRxmoSi3abOgWbwIGXgISEw==
X-Google-Smtp-Source: ABdhPJw2qoQRH515wl70IAvEgCCXP4EPVDw6T5rYSjkc8DwasCihwMl+CXPZiNA+JSBm6YHfbYlRnQ==
X-Received: by 2002:a17:90a:fb54:: with SMTP id iq20mr16539966pjb.153.1617434644077;
        Sat, 03 Apr 2021 00:24:04 -0700 (PDT)
Received: from localhost ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id w84sm10170082pfc.142.2021.04.03.00.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 00:24:03 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 3/7] perf arm-spe: Dump TSC parameters
Date:   Sat,  3 Apr 2021 15:23:42 +0800
Message-Id: <20210403072346.30430-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210403072346.30430-1-leo.yan@linaro.org>
References: <20210403072346.30430-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TSC parameters are stored in auxtrace info, this patch dumps these
parameters for reporting the raw data.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.c | 42 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 2539d4baec44..69ce3483d1af 100644
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
 
@@ -803,14 +806,23 @@ static bool arm_spe_evsel_is_auxtrace(struct perf_session *session,
 
 static const char * const arm_spe_info_fmts[] = {
 	[ARM_SPE_PMU_TYPE]		= "  PMU Type           %"PRId64"\n",
+	[ARM_SPE_TIME_SHIFT]		= "  Time Shift         %"PRIu64"\n",
+	[ARM_SPE_TIME_MULT]		= "  Time Muliplier     %"PRIu64"\n",
+	[ARM_SPE_TIME_ZERO]		= "  Time Zero          %"PRIu64"\n",
+	[ARM_SPE_TIME_CYCLES]		= "  Time Cycles        %"PRIu64"\n",
+	[ARM_SPE_TIME_MASK]		= "  Time Mask          %#"PRIx64"\n",
+	[ARM_SPE_CAP_USER_TIME_SHORT]	= "  Cap Time Short     %"PRId64"\n",
 };
 
-static void arm_spe_print_info(__u64 *arr)
+static void arm_spe_print_info(__u64 *arr, int start, int finish)
 {
+	int i;
+
 	if (!dump_trace)
 		return;
 
-	fprintf(stdout, arm_spe_info_fmts[ARM_SPE_PMU_TYPE], arr[ARM_SPE_PMU_TYPE]);
+	for (i = start; i <= finish; i++)
+		fprintf(stdout, arm_spe_info_fmts[i], arr[i]);
 }
 
 struct arm_spe_synth {
@@ -1001,11 +1013,19 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 	return 0;
 }
 
+static bool arm_spe_has(struct perf_record_auxtrace_info *auxtrace_info,
+			int pos)
+{
+	return auxtrace_info->header.size >=
+		(sizeof(struct perf_record_auxtrace_info) +
+		 (sizeof(u64) * (pos + 1)));
+}
+
 int arm_spe_process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session)
 {
 	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
-	size_t min_sz = sizeof(u64) * ARM_SPE_AUXTRACE_PRIV_MAX;
+	size_t min_sz = sizeof(u64) * ARM_SPE_TIME_SHIFT;
 	struct arm_spe *spe;
 	int err;
 
@@ -1025,6 +1045,20 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	spe->machine = &session->machines.host; /* No kvm support */
 	spe->auxtrace_type = auxtrace_info->type;
 	spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
+	arm_spe_print_info(&auxtrace_info->priv[0], ARM_SPE_PMU_TYPE,
+			   ARM_SPE_PMU_TYPE);
+
+	if (arm_spe_has(auxtrace_info, ARM_SPE_CAP_USER_TIME_SHORT)) {
+		spe->tc.time_shift = auxtrace_info->priv[ARM_SPE_TIME_SHIFT];
+		spe->tc.time_mult = auxtrace_info->priv[ARM_SPE_TIME_MULT];
+		spe->tc.time_zero = auxtrace_info->priv[ARM_SPE_TIME_ZERO];
+		spe->tc.time_cycles = auxtrace_info->priv[ARM_SPE_TIME_CYCLES];
+		spe->tc.time_mask = auxtrace_info->priv[ARM_SPE_TIME_MASK];
+		spe->tc.cap_user_time_short =
+			auxtrace_info->priv[ARM_SPE_CAP_USER_TIME_SHORT];
+		arm_spe_print_info(&auxtrace_info->priv[0], ARM_SPE_TIME_SHIFT,
+				   ARM_SPE_CAP_USER_TIME_SHORT);
+	}
 
 	spe->timeless_decoding = arm_spe__is_timeless_decoding(spe);
 	spe->auxtrace.process_event = arm_spe_process_event;
@@ -1035,8 +1069,6 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	spe->auxtrace.evsel_is_auxtrace = arm_spe_evsel_is_auxtrace;
 	session->auxtrace = &spe->auxtrace;
 
-	arm_spe_print_info(&auxtrace_info->priv[0]);
-
 	if (dump_trace)
 		return 0;
 
-- 
2.25.1

