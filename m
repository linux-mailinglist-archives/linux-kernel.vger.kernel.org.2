Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF341373058
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhEDTIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:08:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:38664 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232063AbhEDTIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:08:23 -0400
IronPort-SDR: S+rpf8Q4CxV7mXINNiODMToWjggFzH1UcYph/CME8jQSAuL/d/SFXT/oP9A30D91JWL5HqEBbf
 NTHHe1qss3uQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="178269909"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="178269909"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 12:07:17 -0700
IronPort-SDR: SNqfHgdqMz1T1j3uUvhGSRB+7xOGSI2hhP2FhVFmTLAoSiG74bluW7Isf00l8YWmyAjBO8cYek
 ISt8XUAmgg8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="618591749"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga006.fm.intel.com with ESMTP; 04 May 2021 12:07:17 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Andi Kleen <andi.kleen@intel.com>
Subject: [RFC PATCH v5 11/16] x86/watchdog/hardlockup/hpet: Determine if HPET timer caused NMI
Date:   Tue,  4 May 2021 12:05:21 -0700
Message-Id: <20210504190526.22347-12-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210504190526.22347-1-ricardo.neri-calderon@linux.intel.com>
References: <20210504190526.22347-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only direct method to determine whether an HPET timer caused an
interrupt is to read the Interrupt Status register. Unfortunately,
reading HPET registers is slow and, therefore, it is not recommended to
read them while in NMI context. Furthermore, status is not available if
the interrupt is generated via the Front Side Bus.

An indirect manner to infer if a given non-maskable interrupt was caused
by the HPET timer is to use the time-stamp counter. Compute the value that
the time-stamp counter should have at the next interrupt of the HPET timer.
Since the hardlockup detector operates in seconds, high precision is not
needed. This implementation considers that the HPET caused the NMI if the
time-stamp counter reads the expected value -/+ 1.5%. This value is
selected as it is equivalent to 1/64 and the division can be performed
using a bit shift operation. Experimentally, the error in the estimation
is consistently less than 1%.

The computation of the expected value of the time-stamp counter must be
performed in relation to watchdog_thresh divided by the number of groups
of packages with monitored CPUs. This quantity is stored in
tsc_ticks_per_group and must be updated whenever the number of monitored
CPUs changes. Namely, when enabling or disabling the hardlockup detector
on a given CPU.

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Suggested-by: Andi Kleen <andi.kleen@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v4:
 * Compute the TSC expected value at the next HPET interrupt based on the
   number of monitored packages and not the number of monitored CPUs.

Changes since v3:
 * None

Changes since v2:
 * Reworked condition to check if the expected TSC value is within the
   error margin to avoid an unnecessary conditional. (Peter Zijlstra)
 * Removed TSC error margin from struct hld_data; use a global variable
   instead. (Peter Zijlstra)

Changes since v1:
 * Introduced this patch.
---
 arch/x86/include/asm/hpet.h         |  6 ++++++
 arch/x86/kernel/watchdog_hld_hpet.c | 27 ++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index 738fcf256b14..1ff7436c1ce6 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -104,6 +104,10 @@ extern void hpet_unregister_irq_handler(rtc_irq_handler handler);
  * @ticks_per_second:		Frequency of the HPET timer
  * @ticks_per_group:		HPET ticks per group that must elapse before
  *				the timer expires
+ * @tsc_next:			Estimated value of the TSC at the next
+ *				HPET timer interrupt
+ * @tsc_ticks_per_group:	TSC ticks that must elapse for each group of
+ *				monitored CPUs.
  * @irq:			IRQ number assigned to the HPET channel
  * @handling_cpu:		CPU handling the HPET interrupt
  * @pkgs_per_group:		Number of physical packages in a group of CPUs
@@ -126,6 +130,8 @@ struct hpet_hld_data {
 	u32		channel;
 	u64		ticks_per_second;
 	u64		ticks_per_group;
+	u64		tsc_next;
+	u64		tsc_ticks_per_group;
 	int		irq;
 	u32		handling_cpu;
 	u32		pkgs_per_group;
diff --git a/arch/x86/kernel/watchdog_hld_hpet.c b/arch/x86/kernel/watchdog_hld_hpet.c
index bf3ee354907f..cd5f59b7c01b 100644
--- a/arch/x86/kernel/watchdog_hld_hpet.c
+++ b/arch/x86/kernel/watchdog_hld_hpet.c
@@ -24,6 +24,7 @@
 
 static struct hpet_hld_data *hld_data;
 static bool hardlockup_use_hpet;
+static u64 tsc_next_error;
 
 /**
  * kick_timer() - Reprogram timer to expire in the future
@@ -33,10 +34,21 @@ static bool hardlockup_use_hpet;
  * Reprogram the timer to expire within watchdog_thresh seconds in the future.
  * If the timer supports periodic mode, it is not kicked unless @force is
  * true.
+ *
+ * Also, compute the expected value of the time-stamp counter at the time of
+ * expiration as well as a deviation from the expected value. The maximum
+ * deviation is of ~1.5%. This deviation can be easily computed by shifting
+ * by 6 positions the delta between the current and expected time-stamp values.
  */
 static void kick_timer(struct hpet_hld_data *hdata, bool force)
 {
-	u64 new_compare, count, period = 0;
+	u64 tsc_curr, tsc_delta, new_compare, count, period = 0;
+
+	tsc_curr = rdtsc();
+
+	tsc_delta = (unsigned long)watchdog_thresh * hdata->tsc_ticks_per_group;
+	hdata->tsc_next = tsc_curr + tsc_delta;
+	tsc_next_error = tsc_delta >> 6;
 
 	/* kick the timer only when needed */
 	if (!force && hdata->has_periodic)
@@ -113,6 +125,15 @@ static void enable_timer(struct hpet_hld_data *hdata)
  */
 static bool is_hpet_wdt_interrupt(struct hpet_hld_data *hdata)
 {
+	if (smp_processor_id() == hdata->handling_cpu) {
+		u64 tsc_curr;
+
+		tsc_curr = rdtsc();
+
+		return (tsc_curr - hdata->tsc_next) + tsc_next_error <
+		       2 * tsc_next_error;
+	}
+
 	return false;
 }
 
@@ -438,6 +459,10 @@ static void update_ticks_per_group(struct hpet_hld_data *hdata)
 
 	do_div(ticks, hdata->nr_groups);
 	hdata->ticks_per_group = ticks;
+
+	ticks = (unsigned long)tsc_khz * 1000L;
+	do_div(ticks, hdata->nr_groups);
+	hdata->tsc_ticks_per_group = ticks;
 }
 
 /**
-- 
2.17.1

