Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A965313C76
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbhBHSG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:06:58 -0500
Received: from mga14.intel.com ([192.55.52.115]:62811 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234107AbhBHPiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:38:20 -0500
IronPort-SDR: XtRHSNDQUb8OChs63ojL+ZSDQtj2fxU25n9OlRD/AoPR2CHkpsSo3JEJci/Tn6KoBaAdW/a0ZX
 8aGelsV37eQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="180951947"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="180951947"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:12 -0800
IronPort-SDR: A0/4re6jGpGJyL+WiunDGLin+AzbZQeOpjZ9TKjpRDriAQm//TTYdWM0RXN73i7gGCCHhL+QPT
 jtKbv0GitAcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820642"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:12 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 13/49] perf/x86: Expose check_hw_exists
Date:   Mon,  8 Feb 2021 07:25:10 -0800
Message-Id: <1612797946-18784-14-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Hybrid PMUs have a different number of counters. Each Hybrid PMU has to
check its own HW existence before registration.

Expose check_hw_exists, and add number of counters as parameters.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       | 10 +++++-----
 arch/x86/events/perf_event.h |  2 ++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 6857934..29dee3f 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -239,7 +239,7 @@ static void release_pmc_hardware(void) {}
 
 #endif
 
-static bool check_hw_exists(void)
+bool check_hw_exists(int num_counters, int num_counters_fixed)
 {
 	u64 val, val_fail = -1, val_new= ~0;
 	int i, reg, reg_fail = -1, ret = 0;
@@ -250,7 +250,7 @@ static bool check_hw_exists(void)
 	 * Check to see if the BIOS enabled any of the counters, if so
 	 * complain and bail.
 	 */
-	for (i = 0; i < x86_pmu.num_counters; i++) {
+	for (i = 0; i < num_counters; i++) {
 		reg = x86_pmu_config_addr(i);
 		ret = rdmsrl_safe(reg, &val);
 		if (ret)
@@ -264,12 +264,12 @@ static bool check_hw_exists(void)
 		}
 	}
 
-	if (x86_pmu.num_counters_fixed) {
+	if (num_counters_fixed) {
 		reg = MSR_ARCH_PERFMON_FIXED_CTR_CTRL;
 		ret = rdmsrl_safe(reg, &val);
 		if (ret)
 			goto msr_fail;
-		for (i = 0; i < x86_pmu.num_counters_fixed; i++) {
+		for (i = 0; i < num_counters_fixed; i++) {
 			if (fixed_counter_disabled(i, NULL))
 				continue;
 			if (val & (0x03 << i*4)) {
@@ -2012,7 +2012,7 @@ static int __init init_hw_perf_events(void)
 	pmu_check_apic();
 
 	/* sanity check that the hardware exists or is emulated */
-	if (!check_hw_exists())
+	if (!check_hw_exists(x86_pmu.num_counters, x86_pmu.num_counters_fixed))
 		return 0;
 
 	pr_cont("%s PMU driver.\n", x86_pmu.name);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 109139c..560410c 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1024,6 +1024,8 @@ static inline int x86_pmu_rdpmc_index(int index)
 	return x86_pmu.rdpmc_index ? x86_pmu.rdpmc_index(index) : index;
 }
 
+bool check_hw_exists(int num_counters, int num_counters_fixed);
+
 int x86_add_exclusive(unsigned int what);
 
 void x86_del_exclusive(unsigned int what);
-- 
2.7.4

