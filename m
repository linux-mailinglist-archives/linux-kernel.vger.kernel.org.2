Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDB335C8FB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 16:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242709AbhDLOja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 10:39:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:29207 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242486AbhDLOjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 10:39:01 -0400
IronPort-SDR: oHpHtdw0DF8JSeiHyCk2veq8G8U6zZkNcftfckTp8W1/CDUwBm/sQnOWUE9CA9W/cPOAvKBSBc
 2YPItAqPa9Bw==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="194318023"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="194318023"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 07:38:35 -0700
IronPort-SDR: RSIPxX5UYSfmHxcTz32TdGzerfY0HPa/2Dz5Un/7YHWjLFI+wCe3nQ/9luK2qAeifyq2Zudh5a
 MUj8zNdoYZdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="398392865"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga002.jf.intel.com with ESMTP; 12 Apr 2021 07:38:35 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, ricardo.neri-calderon@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH V6 21/25] perf: Extend PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
Date:   Mon, 12 Apr 2021 07:31:01 -0700
Message-Id: <1618237865-33448-22-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1618237865-33448-1-git-send-email-kan.liang@linux.intel.com>
References: <1618237865-33448-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Current Hardware events and Hardware cache events have special perf
types, PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE. The two types don't
pass the PMU type in the user interface. For a hybrid system, the perf
subsystem doesn't know which PMU the events belong to. The first capable
PMU will always be assigned to the events. The events never get a chance
to run on the other capable PMUs.

Extend the two types to become PMU aware types. The PMU type ID is
stored at attr.config[63:32].

Add a new PMU capability, PERF_PMU_CAP_EXTENDED_HW_TYPE, to indicate a
PMU which supports the extended PERF_TYPE_HARDWARE and
PERF_TYPE_HW_CACHE.

The PMU type is only required when searching a specific PMU. The PMU
specific codes will only be interested in the 'real' config value, which
is stored in the low 32 bit of the event->attr.config. Update the
event->attr.config in the generic code, so the PMU specific codes don't
need to calculate it separately.

If a user specifies a PMU type, but the PMU doesn't support the extended
type, error out.

If an event cannot be initialized in a PMU specified by a user, error
out immediately. Perf should not try to open it on other PMUs.

The new PMU capability is only set for the X86 hybrid PMUs for now.
Other architectures, e.g., ARM, may need it as well. The support on ARM
may be implemented later separately.

Cc: Mark Rutland <mark.rutland@arm.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c          |  1 +
 include/linux/perf_event.h      | 19 ++++++++++---------
 include/uapi/linux/perf_event.h | 15 +++++++++++++++
 kernel/events/core.c            | 19 ++++++++++++++++---
 4 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8fc45b8..88f2dbf 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2174,6 +2174,7 @@ static int __init init_hw_perf_events(void)
 			hybrid_pmu->pmu.type = -1;
 			hybrid_pmu->pmu.attr_update = x86_pmu.attr_update;
 			hybrid_pmu->pmu.capabilities |= PERF_PMU_CAP_HETEROGENEOUS_CPUS;
+			hybrid_pmu->pmu.capabilities |= PERF_PMU_CAP_EXTENDED_HW_TYPE;
 
 			err = perf_pmu_register(&hybrid_pmu->pmu, hybrid_pmu->name,
 						(hybrid_pmu->cpu_type == hybrid_big) ? PERF_TYPE_RAW : -1);
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index b832e09..2f12dca 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -260,15 +260,16 @@ struct perf_event;
 /**
  * pmu::capabilities flags
  */
-#define PERF_PMU_CAP_NO_INTERRUPT		0x01
-#define PERF_PMU_CAP_NO_NMI			0x02
-#define PERF_PMU_CAP_AUX_NO_SG			0x04
-#define PERF_PMU_CAP_EXTENDED_REGS		0x08
-#define PERF_PMU_CAP_EXCLUSIVE			0x10
-#define PERF_PMU_CAP_ITRACE			0x20
-#define PERF_PMU_CAP_HETEROGENEOUS_CPUS		0x40
-#define PERF_PMU_CAP_NO_EXCLUDE			0x80
-#define PERF_PMU_CAP_AUX_OUTPUT			0x100
+#define PERF_PMU_CAP_NO_INTERRUPT		0x0001
+#define PERF_PMU_CAP_NO_NMI			0x0002
+#define PERF_PMU_CAP_AUX_NO_SG			0x0004
+#define PERF_PMU_CAP_EXTENDED_REGS		0x0008
+#define PERF_PMU_CAP_EXCLUSIVE			0x0010
+#define PERF_PMU_CAP_ITRACE			0x0020
+#define PERF_PMU_CAP_HETEROGENEOUS_CPUS		0x0040
+#define PERF_PMU_CAP_NO_EXCLUDE			0x0080
+#define PERF_PMU_CAP_AUX_OUTPUT			0x0100
+#define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0200
 
 struct perf_output_handle;
 
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index ad15e40..14332f4 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -38,6 +38,21 @@ enum perf_type_id {
 };
 
 /*
+ * attr.config layout for type PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
+ * PERF_TYPE_HARDWARE:			0xEEEEEEEE000000AA
+ *					AA: hardware event ID
+ *					EEEEEEEE: PMU type ID
+ * PERF_TYPE_HW_CACHE:			0xEEEEEEEE00DDCCBB
+ *					BB: hardware cache ID
+ *					CC: hardware cache op ID
+ *					DD: hardware cache op result ID
+ *					EEEEEEEE: PMU type ID
+ * If the PMU type ID is 0, the PERF_TYPE_RAW will be applied.
+ */
+#define PERF_PMU_TYPE_SHIFT		32
+#define PERF_HW_EVENT_MASK		0xffffffff
+
+/*
  * Generalized performance event event_id types, used by the
  * attr.event_id parameter of the sys_perf_event_open()
  * syscall:
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f079431..c87c51e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11095,6 +11095,7 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 
 static struct pmu *perf_init_event(struct perf_event *event)
 {
+	bool extended_type = false;
 	int idx, type, ret;
 	struct pmu *pmu;
 
@@ -11113,16 +11114,27 @@ static struct pmu *perf_init_event(struct perf_event *event)
 	 * are often aliases for PERF_TYPE_RAW.
 	 */
 	type = event->attr.type;
-	if (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE)
-		type = PERF_TYPE_RAW;
+	if (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE) {
+		type = event->attr.config >> PERF_PMU_TYPE_SHIFT;
+		if (!type) {
+			type = PERF_TYPE_RAW;
+		} else {
+			extended_type = true;
+			event->attr.config &= PERF_HW_EVENT_MASK;
+		}
+	}
 
 again:
 	rcu_read_lock();
 	pmu = idr_find(&pmu_idr, type);
 	rcu_read_unlock();
 	if (pmu) {
+		if (event->attr.type != type && type != PERF_TYPE_RAW &&
+		    !(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE))
+			goto fail;
+
 		ret = perf_try_init_event(pmu, event);
-		if (ret == -ENOENT && event->attr.type != type) {
+		if (ret == -ENOENT && event->attr.type != type && !extended_type) {
 			type = event->attr.type;
 			goto again;
 		}
@@ -11143,6 +11155,7 @@ static struct pmu *perf_init_event(struct perf_event *event)
 			goto unlock;
 		}
 	}
+fail:
 	pmu = ERR_PTR(-ENOENT);
 unlock:
 	srcu_read_unlock(&pmus_srcu, idx);
-- 
2.7.4

