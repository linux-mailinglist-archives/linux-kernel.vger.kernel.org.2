Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CB9373051
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhEDTIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:08:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:38664 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231894AbhEDTIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:08:22 -0400
IronPort-SDR: Dt3DmTnN5e7jQiptXr49xeCe0M0GGcnLp3fu4GHNb1ynVBGoajr9QkJcWdyzE8kJM1kkIkt33L
 LVAaqGwbEjnw==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="178269890"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="178269890"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 12:07:16 -0700
IronPort-SDR: 4VfN2IPUd2AAFiW3Dckauu3/vVMyPplaOCbiJ2MaDb/4K3XszZAkDS+K/arqrB6fDEo0Ibwurr
 cdKH8gbSGRrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="618591723"
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
Subject: [RFC PATCH v5 03/16] x86/hpet: Reserve an HPET channel for the hardlockup detector
Date:   Tue,  4 May 2021 12:05:13 -0700
Message-Id: <20210504190526.22347-4-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210504190526.22347-1-ricardo.neri-calderon@linux.intel.com>
References: <20210504190526.22347-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HPET hardlockup detector needs a dedicated HPET channel. Hence, create
a new HPET_MODE_NMI_WATCHDOG mode category to indicate that it cannot be
used for other purposes. Using MSI interrupts greatly simplifies the
implementation of the detector. Specifically, it helps to avoid the
complexities of routing the interrupt via the IO-APIC (e.g., potential
race conditions that arise from re-programming the IO-APIC while also
servicing an NMI). Therefore, only reserve the timer if it supports Front
Side Bus interrupt delivery.

HPET channels are reserved at various stages. First, from
x86_late_time_init(), hpet_time_init() checks if the HPET timer supports
Legacy Replacement Routing. If this is the case, channels 0 and 1 are
reserved as HPET_MODE_LEGACY.

At a later stage, from lockup_detector_init(), reserve the HPET channel
for the hardlockup detector. Then, the HPET clocksource reserves the
channels it needs and then the remaining channels are given to the HPET
char driver via hpet_alloc().

Hence, the channel assigned to the HPET hardlockup detector depends on
whether the first two channels are reserved for legacy mode.

Lastly, only reserve the channel for the hardlockup detector if enabled
in the kernel command line.

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v4:
 * Reworked timer reservation to use Thomas' rework on HPET channel
   management.
 * Removed hard-coded channel number for the hardlockup detector.
 * Provided more details on the sequence of HPET channel reservations.
   (Thomas Gleixner)
 * Only reserve a channel for the hardlockup detector if enabled via
   kernel command line. The function reserving the channel is called from
   hardlockup detector. (Thomas Gleixner)
 * Shorten the name of hpet_hardlockup_detector_get_timer() to
   hpet_hld_get_timer(). (Andi)
 * Simplify error handling when a channel is not found. (Tony)

Changes since v3:
 * None

Changes since v2:
 * None

Changes since v1:
 * None
---
 arch/x86/include/asm/hpet.h | 18 +++++++++
 arch/x86/kernel/hpet.c      | 73 +++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index 486e001413c7..f1e41c11c29f 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -95,6 +95,24 @@ extern void hpet_unregister_irq_handler(rtc_irq_handler handler);
 
 #endif /* CONFIG_HPET_EMULATE_RTC */
 
+#ifdef CONFIG_X86_HARDLOCKUP_DETECTOR_HPET
+/**
+ * struct hpet_hld_data - Data needed to operate the detector
+ * @has_periodic:		The HPET channel supports periodic mode
+ * @channel:			HPET channel assigned to the detector
+ * @ticks_per_second:		Frequency of the HPET timer
+ * @irq:			IRQ number assigned to the HPET channel
+ */
+struct hpet_hld_data {
+	bool		has_periodic;
+	u32		channel;
+	u64		ticks_per_second;
+	int		irq;
+};
+
+extern struct hpet_hld_data *hpet_hld_get_timer(void);
+#endif /* CONFIG_X86_HARDLOCKUP_DETECTOR_HPET */
+
 #else /* CONFIG_HPET_TIMER */
 
 static inline int hpet_enable(void) { return 0; }
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 8be1d3d9162e..5012590dc1b8 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -19,6 +19,7 @@ enum hpet_mode {
 	HPET_MODE_LEGACY,
 	HPET_MODE_CLOCKEVT,
 	HPET_MODE_DEVICE,
+	HPET_MODE_NMI_WATCHDOG,
 };
 
 struct hpet_channel {
@@ -215,6 +216,7 @@ static void __init hpet_reserve_platform_timers(void)
 			break;
 		case HPET_MODE_CLOCKEVT:
 		case HPET_MODE_LEGACY:
+		case HPET_MODE_NMI_WATCHDOG:
 			hpet_reserve_timer(&hd, hc->num);
 			break;
 		}
@@ -1408,4 +1410,75 @@ irqreturn_t hpet_rtc_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 EXPORT_SYMBOL_GPL(hpet_rtc_interrupt);
+
+#ifdef CONFIG_X86_HARDLOCKUP_DETECTOR_HPET
+static struct hpet_hld_data *hld_data;
+
+/**
+ * hpet_hld_get_timer - Get an HPET channel for the hardlockup detector
+ *
+ * Reseve an HPET channel and return the timer information to caller only if a
+ * channel is available and supports FSB mode. This function is called by the
+ * hardlockup detector only if enabled in the kernel command line.
+ *
+ * Returns: none
+ */
+struct hpet_hld_data *hpet_hld_get_timer(void)
+{
+	struct hpet_channel *hc = hpet_base.channels;
+	int i, irq;
+
+	for (i = 0; i < hpet_base.nr_channels; i++) {
+		hc = hpet_base.channels + i;
+
+		/*
+		 * Associate the first unused channel to the hardlockup
+		 * detector. Bailout if we cannot find one. This may happen if
+		 * the HPET clocksource has taken all the timers. The HPET driver
+		 * (/dev/hpet) should not take timers at this point as channels
+		 * for such driver can only be reserved from user space.
+		 */
+		if (hc->mode == HPET_MODE_UNUSED)
+			break;
+	}
+
+	if (i == hpet_base.nr_channels)
+		return NULL;
+
+	if (!(hc->boot_cfg & HPET_TN_FSB_CAP))
+		return NULL;
+
+	hld_data = kzalloc(sizeof(*hld_data), GFP_KERNEL);
+	if (!hld_data)
+		return NULL;
+
+	if (hc->boot_cfg & HPET_TN_PERIODIC_CAP)
+		hld_data->has_periodic = true;
+
+	hld_data->channel = i;
+	hld_data->ticks_per_second = hpet_freq;
+
+	if (!hpet_domain)
+		hpet_domain = hpet_create_irq_domain(hpet_blockid);
+
+	if (!hpet_domain)
+		goto err;
+
+	hc->mode = HPET_MODE_NMI_WATCHDOG;
+	irq = hpet_assign_irq(hpet_domain, hc, hc->num);
+	if (irq <= 0)
+		goto err;
+
+	hc->irq = irq;
+	hld_data->irq = irq;
+	return hld_data;
+
+err:
+	hc->mode = HPET_MODE_UNUSED;
+	kfree(hld_data);
+	hld_data = NULL;
+	return NULL;
+}
+#endif /* CONFIG_X86_HARDLOCKUP_DETECTOR_HPET */
+
 #endif
-- 
2.17.1

