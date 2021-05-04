Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE6637304F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbhEDTIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:08:25 -0400
Received: from mga17.intel.com ([192.55.52.151]:38656 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231777AbhEDTIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:08:19 -0400
IronPort-SDR: rjDKWrYhBs8lCafYNmCBnK5VuUFx1QMimDDKNDEQPH3/KdxbhJS6gVhDd0JYVRKJCIh20LaBnE
 9gq+a2bNnVDA==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="178269887"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="178269887"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 12:07:16 -0700
IronPort-SDR: dTMdOqPOm7gBkTxw6KJFXQ2RJFqIa19i8/fuuNy5ToSZVDiGaDe3vKjrDxE1jkSSJ27EqIq/DA
 RzbVpWkEjnSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="618591720"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga006.fm.intel.com with ESMTP; 04 May 2021 12:07:16 -0700
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
Subject: [RFC PATCH v5 02/16] x86/hpet: Add helper function hpet_set_comparator_periodic()
Date:   Tue,  4 May 2021 12:05:12 -0700
Message-Id: <20210504190526.22347-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210504190526.22347-1-ricardo.neri-calderon@linux.intel.com>
References: <20210504190526.22347-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Programming an HPET channel as periodic requires setting the
HPET_TN_SETVAL bit in the channel configuration. Plus, the comparator
register must be written twice (once for the comparator value and once for
the periodic value). Since this programming might be needed in several
places (e.g., the HPET clocksource and the HPET-based hardlockup detector),
add a helper function for this purpose.

A helper function hpet_set_comparator_oneshot() could also be implemented.
However, such function would only program the comparator register and the
function would be quite small. Hence, it is better to not bloat the code
with such an obvious function.

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Originally-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
When programming the HPET channel in periodic mode, a udelay(1) between
the two successive writes to HPET_Tn_CMP was introduced in commit
e9e2cdb41241 ("[PATCH] clockevents: i386 drivers"). The commit message
does not give any reason for such delay. The hardware specification does
not seem to require it. The refactoring in this patch simply carries such
delay.
---
Changes since v4:
 * Implement function only for periodic mode. This removed extra logic to
   to use a non-zero period value as a proxy for periodic mode
   programming. (Thomas)
 * Added a comment on the history of the udelay() when programming the
   channel in periodic mode. (Ashok)

Changes since v3:
 * Added back a missing hpet_writel() for time configuration.

Changes since v2:
 *  Introduced this patch.

Changes since v1:
 * N/A
---
 arch/x86/include/asm/hpet.h |  2 ++
 arch/x86/kernel/hpet.c      | 49 ++++++++++++++++++++++++++++---------
 2 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index be9848f0883f..486e001413c7 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -74,6 +74,8 @@ extern void hpet_disable(void);
 extern unsigned int hpet_readl(unsigned int a);
 extern void hpet_writel(unsigned int d, unsigned int a);
 extern void force_hpet_resume(void);
+extern void hpet_set_comparator_periodic(int channel, unsigned int cmp,
+					 unsigned int period);
 
 #ifdef CONFIG_HPET_EMULATE_RTC
 
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 326af9a55129..8be1d3d9162e 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -293,6 +293,39 @@ static void hpet_enable_legacy_int(void)
 	hpet_legacy_int_enabled = true;
 }
 
+/**
+ * hpet_set_comparator_periodic() - Helper function to set periodic channel
+ * @channel:	The HPET channel
+ * @cmp:	The value to be written to the comparator/accumulator
+ * @period:	Number of ticks per period
+ *
+ * Helper function for updating comparator, accumulator and period values.
+ *
+ * In periodic mode, HPET needs HPET_TN_SETVAL to be set before writing
+ * to the Tn_CMP to update the accumulator. Then, HPET needs a second
+ * write (with HPET_TN_SETVAL cleared) to Tn_CMP to set the period.
+ * The HPET_TN_SETVAL bit is automatically cleared after the first write.
+ *
+ * This function takes a 1 microsecond delay. However, this function is supposed
+ * to be called only once (or when reprogramming the timer) as it deals with a
+ * periodic timer channel.
+ *
+ * See the following documents:
+ *   - Intel IA-PC HPET (High Precision Event Timers) Specification
+ *   - AMD-8111 HyperTransport I/O Hub Data Sheet, Publication # 24674
+ */
+void hpet_set_comparator_periodic(int channel, unsigned int cmp, unsigned int period)
+{
+	unsigned int v = hpet_readl(HPET_Tn_CFG(channel));
+
+	hpet_writel(v | HPET_TN_SETVAL, HPET_Tn_CFG(channel));
+
+	hpet_writel(cmp, HPET_Tn_CMP(channel));
+
+	udelay(1);
+	hpet_writel(period, HPET_Tn_CMP(channel));
+}
+
 static int hpet_clkevt_set_state_periodic(struct clock_event_device *evt)
 {
 	unsigned int channel = clockevent_to_channel(evt)->num;
@@ -305,19 +338,11 @@ static int hpet_clkevt_set_state_periodic(struct clock_event_device *evt)
 	now = hpet_readl(HPET_COUNTER);
 	cmp = now + (unsigned int)delta;
 	cfg = hpet_readl(HPET_Tn_CFG(channel));
-	cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_SETVAL |
-	       HPET_TN_32BIT;
+	cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_32BIT;
 	hpet_writel(cfg, HPET_Tn_CFG(channel));
-	hpet_writel(cmp, HPET_Tn_CMP(channel));
-	udelay(1);
-	/*
-	 * HPET on AMD 81xx needs a second write (with HPET_TN_SETVAL
-	 * cleared) to T0_CMP to set the period. The HPET_TN_SETVAL
-	 * bit is automatically cleared after the first write.
-	 * (See AMD-8111 HyperTransport I/O Hub Data Sheet,
-	 * Publication # 24674)
-	 */
-	hpet_writel((unsigned int)delta, HPET_Tn_CMP(channel));
+
+	hpet_set_comparator_periodic(channel, cmp, (unsigned int)delta);
+
 	hpet_start_counter();
 	hpet_print_config();
 
-- 
2.17.1

