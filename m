Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93CA35AAF6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 07:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbhDJFCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 01:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbhDJFCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 01:02:15 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B1DC061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 22:02:01 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id b17so5384696pgh.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 22:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rr39OeUgAUE/zL2Re4duZZEa5vKLOQM6kQLTh7tScK8=;
        b=mINjDvAHHVh1O4zkRj+iHdyYCFtS7jbrIGpsBxx4uKroKny8iXqjlsuIlwKLdNxMN3
         xIUGM7XUqggVL7HP6NTs+ZuWvOAAq76BEEB9CaOIeOuDFuHPt4UIFapLDiCsDE698Sjc
         VIeNYQNozfvSTEcAELPTLrbcrCyB89B98PLE9G85o97nIbJqjttFiIwqzUkSRxasYE1z
         e5xRl2RRSJugMcOU86gC6o8UhU8qYI9jbVATSqERk8qe0AfWWPxw/mgv3aeUoeQrr/8F
         FAB1g5i1BofWJ5O5F1go3GH42uozR/YaZkN1noaa6zGZyYXgSNUpj+ECaSXygJcAGbzp
         p4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rr39OeUgAUE/zL2Re4duZZEa5vKLOQM6kQLTh7tScK8=;
        b=qapSWxpnP0ygWeXsDsZlns00O9W1t1lEisX5PSN+OSdB5cbW7mm3KSUg3Bpq3iOaMH
         MtSYZxN96bAGmCkk8sp6PzWZQz+uyvfdqM1BUxL/a7f/ugBnmTaK9yFVjp9YfC8yHrHp
         nLz31qb0fmOcZCMAWoN8O+SUWWJyJrzYzFLER0oIAc+H3HuGNTM7MkMO60Vzs1ko5nGY
         UY4nRxDJd+j7wIPdD3L0UfEI9A6dHQ4tIoG4SNQD+IBdtT+k38cvndswqef/PPKenc75
         x2JMha5uqhSSeH8OokGpFCn+CmD3TVkFj61TuvmRh/OFiDgDg92JMi/1sOM0NQhiFD05
         Yahw==
X-Gm-Message-State: AOAM5337QxJF0YarzelNXp6fuCT+MPmW8pgjLp5+y4u4ixPEF71SxUYM
        Z1XabhoMiKAHPXaLRANU1FTmcw==
X-Google-Smtp-Source: ABdhPJyprIBWHqiL9ovXm2yBqVIPHjJrqOrnCm0lrQTGI+6wf/QZKVn7x+eQtNILgShxMjAqc4KRyQ==
X-Received: by 2002:aa7:8e0d:0:b029:214:a511:d88b with SMTP id c13-20020aa78e0d0000b0290214a511d88bmr15490846pfr.2.1618030920823;
        Fri, 09 Apr 2021 22:02:00 -0700 (PDT)
Received: from localhost ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id i9sm4214984pjh.9.2021.04.09.22.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 22:02:00 -0700 (PDT)
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Clark <James.Clark@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 2/6] perf arm-spe: Save clock parameters from TIME_CONV event
Date:   Sat, 10 Apr 2021 13:00:42 +0800
Message-Id: <20210410050046.5394-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210410050046.5394-1-leo.yan@linaro.org>
References: <20210410050046.5394-1-leo.yan@linaro.org>
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
 tools/perf/util/arm-spe.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 2539d4baec44..b48816d5c0b4 100644
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
 
@@ -1027,6 +1030,22 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
 
 	spe->timeless_decoding = arm_spe__is_timeless_decoding(spe);
+
+	/*
+	 * The synthesized event PERF_RECORD_TIME_CONV has been handled
+	 * ahead and the parameters for hardware clock are stored in
+	 * the session context.  Passes these parameters to the structure
+	 * perf_tsc_conversion in "spe->tc", which is used for later
+	 * conversion between clock counter and timestamp.
+	 */
+	spe->tc.time_shift = session->time_conv.time_shift;
+	spe->tc.time_mult = session->time_conv.time_mult;
+	spe->tc.time_zero = session->time_conv.time_zero;
+	spe->tc.time_cycles = session->time_conv.time_cycles;
+	spe->tc.time_mask = session->time_conv.time_mask;
+	spe->tc.cap_user_time_zero = session->time_conv.cap_user_time_zero;
+	spe->tc.cap_user_time_short = session->time_conv.cap_user_time_short;
+
 	spe->auxtrace.process_event = arm_spe_process_event;
 	spe->auxtrace.process_auxtrace_event = arm_spe_process_auxtrace_event;
 	spe->auxtrace.flush_events = arm_spe_flush;
-- 
2.25.1

