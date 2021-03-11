Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B0333685F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 01:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhCKAJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 19:09:11 -0500
Received: from mail-il1-f170.google.com ([209.85.166.170]:45143 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhCKAIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 19:08:45 -0500
Received: by mail-il1-f170.google.com with SMTP id s1so17308438ilh.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 16:08:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FOMAKATdifDr6FlmQ9HjwBsrw11qeqE3kI6wm0SfYvU=;
        b=fCKszF9NlVinWpbfzIV/QS42PERYm0RX4r4DfKksYn5UpoHeYflR8AH3VjvvYXIt+P
         iDCLnaDtpr6nuCD1YytT3JN+HvyK9KgLBGHeSFbV9FfVwwcYCOUCalLDNZIj7HWUcxN8
         tPVbEFzvpJrmbn9UoteszqBPHC4t8aYD99Vjn/G8m1w67LPlznAmkgg/gsd5IFzjao3q
         eraMmQmAxPDU1mXcqxENCZ93pTz/RkKqdTxwmfIVDcyQ+JZqKeqUjGleAdItFw4W/tej
         iJTsuVhXD8U0G235OQHVFLQYso4aXP+OCqeXDX6xekuVbWbIL+BXiCCXvbDMXBAB+hiC
         4Ckw==
X-Gm-Message-State: AOAM530AeQKIluPJM/UgcS0+6hWnKl7T2Q9C2IH79viaNgTpgSrYZUBJ
        OpnWd4eJm2mYts1QrLy6Gg==
X-Google-Smtp-Source: ABdhPJz97I0fuv2LaCHNDEf4YfaxyAwcKHowOMAIRPq0PmZrHkz1RRX7u16P0fIvTQ/db5IMbTHQNw==
X-Received: by 2002:a05:6e02:1c83:: with SMTP id w3mr4942092ill.216.1615421325011;
        Wed, 10 Mar 2021 16:08:45 -0800 (PST)
Received: from xps15.herring.priv ([64.188.179.253])
        by smtp.googlemail.com with ESMTPSA id x17sm484351ilm.40.2021.03.10.16.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 16:08:44 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 01/10] arm64: pmu: Add function implementation to update event index in userpage
Date:   Wed, 10 Mar 2021 17:08:28 -0700
Message-Id: <20210311000837.3630499-2-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210311000837.3630499-1-robh@kernel.org>
References: <20210311000837.3630499-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

In order to be able to access the counter directly for userspace,
we need to provide the index of the counter using the userpage.
We thus need to override the event_idx function to retrieve and
convert the perf_event index to armv8 hardware index.

Since the arm_pmu driver can be used by any implementation, even
if not armv8, two components play a role into making sure the
behaviour is correct and consistent with the PMU capabilities:

* the ARMPMU_EL0_RD_CNTR flag which denotes the capability to access
counter from userspace.
* the event_idx call back, which is implemented and initialized by
the PMU implementation: if no callback is provided, the default
behaviour applies, returning 0 as index value.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/kernel/perf_event.c | 18 ++++++++++++++++++
 include/linux/perf/arm_pmu.h   |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 4658fcf88c2b..387838496955 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -871,6 +871,22 @@ static void armv8pmu_clear_event_idx(struct pmu_hw_events *cpuc,
 		clear_bit(idx - 1, cpuc->used_mask);
 }
 
+static int armv8pmu_access_event_idx(struct perf_event *event)
+{
+	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
+		return 0;
+
+	/*
+	 * We remap the cycle counter index to 32 to
+	 * match the offset applied to the rest of
+	 * the counter indices.
+	 */
+	if (event->hw.idx == ARMV8_IDX_CYCLE_COUNTER)
+		return 32;
+
+	return event->hw.idx;
+}
+
 /*
  * Add an event filter to a given event.
  */
@@ -1098,6 +1114,8 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
 	cpu_pmu->filter_match		= armv8pmu_filter_match;
 
+	cpu_pmu->pmu.event_idx		= armv8pmu_access_event_idx;
+
 	cpu_pmu->name			= name;
 	cpu_pmu->map_event		= map_event;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = events ?
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 505480217cf1..d29aa981d989 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -26,6 +26,8 @@
  */
 /* Event uses a 64bit counter */
 #define ARMPMU_EVT_64BIT		1
+/* Allow access to hardware counter from userspace */
+#define ARMPMU_EL0_RD_CNTR		2
 
 #define HW_OP_UNSUPPORTED		0xFFFF
 #define C(_x)				PERF_COUNT_HW_CACHE_##_x
-- 
2.27.0

