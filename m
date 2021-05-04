Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0917F373076
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbhEDTMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:12:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:9835 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232102AbhEDTMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:12:36 -0400
IronPort-SDR: 7PS1QenTxsZ1v/0mXxVbGTo92b6CKm4KihSgvQ7enDnfFSZbdtQY9usnsO3UYOhfwjwKge9aiz
 9igBHPiYvNgg==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="198115953"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="198115953"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 12:11:41 -0700
IronPort-SDR: 6p0FpG4JiRnHAfLETLhIKxYaKWvAVyMDeVKz4hGji4aYIx+Wuxg4wdIDMAHAR3BeEXff74BPna
 ld1YiEvKEaVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="396245282"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 04 May 2021 12:11:40 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     woodhouse@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [RFC PATCH v5 2/7] x86/hpet: Introduce function to identify HPET hardlockup detector irq
Date:   Tue,  4 May 2021 12:10:44 -0700
Message-Id: <20210504191049.22661-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210504191049.22661-1-ricardo.neri-calderon@linux.intel.com>
References: <20210504191049.22661-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HPET hardlockup detector needs to deliver its interrupt as NMI.
In x86 there is not an IRQF_NMI flag that can be used in the irq plumbing
code to tell interrupt remapping drivers to set the interrupt delivery
mode accordingly. Hence, they must fixup the delivery mode internally.

Implement a method to determine if the interrupt being allocated belongs
to the HPET hardlockup detector.

Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: David Woodhouse <dwmw2@infradead.org> (supporter:INTEL IOMMU (VT-d))
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jacob Pan <jacob.jun.pan@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com> (supporter:INTEL IOMMU (VT-d))
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: iommu@lists.linux-foundation.org (open list:INTEL IOMMU (VT-d))
Cc: x86@kernel.org
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v4:
 * Introduced this patch. Previous versions had special functions to
   allocate and set the affinity of a remapped NMI interrupt.

Changes since v3:
 * N/A

Changes since v2:
 * N/A

Changes since v1:
 * N/A
---
 arch/x86/include/asm/hpet.h |  3 +++
 arch/x86/kernel/hpet.c      | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index df11c7d4af44..5bf675970d4b 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -149,6 +149,7 @@ extern void hardlockup_detector_hpet_stop(void);
 extern void hardlockup_detector_hpet_enable(unsigned int cpu);
 extern void hardlockup_detector_hpet_disable(unsigned int cpu);
 extern void hardlockup_detector_switch_to_perf(void);
+extern bool is_hpet_irq_hardlockup_detector(struct irq_alloc_info *info);
 #else
 static inline int hardlockup_detector_hpet_init(void)
 { return -ENODEV; }
@@ -156,6 +157,8 @@ static inline void hardlockup_detector_hpet_stop(void) {}
 static inline void hardlockup_detector_hpet_enable(unsigned int cpu) {}
 static inline void hardlockup_detector_hpet_disable(unsigned int cpu) {}
 static inline void hardlockup_detector_switch_to_perf(void) {}
+static inline bool is_hpet_irq_hardlockup_detector(struct irq_alloc_info *info)
+{ return false; }
 #endif /* CONFIG_X86_HARDLOCKUP_DETECTOR_HPET */
 
 #else /* CONFIG_HPET_TIMER */
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 5012590dc1b8..3e43e0f348b8 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -1479,6 +1479,39 @@ struct hpet_hld_data *hpet_hld_get_timer(void)
 	hld_data = NULL;
 	return NULL;
 }
+
+/**
+ * is_hpet_irq_hardlockup_detector() - Identify the HPET hld interrupt info
+ * @info:	Interrupt allocation info, with private HPET channel data
+ *
+ * The HPET hardlockup detector is special as it needs its interrupts delivered
+ * as NMI. However, for interrupt remapping we use the existing irq subsystem
+ * to configure and route the HPET interrupt. Unfortunately, there is not a
+ * IRQF_NMI flag for x86. Instead, identify whether the interrupt being
+ * allocated for the HPET channel belongs to the hardlockup detector.
+ *
+ * Returns: True if @info indicates that it belongs to the HPET hardlockup
+ * detector. False otherwise.
+ */
+bool is_hpet_irq_hardlockup_detector(struct irq_alloc_info *info)
+{
+	struct hpet_channel *hc;
+
+	if (!info)
+		return false;
+
+	if (info->type != X86_IRQ_ALLOC_TYPE_HPET)
+		return false;
+
+	hc = info->data;
+	if (!hc)
+		return false;
+
+	if (hc->mode == HPET_MODE_NMI_WATCHDOG)
+		return true;
+
+	return false;
+}
 #endif /* CONFIG_X86_HARDLOCKUP_DETECTOR_HPET */
 
 #endif
-- 
2.17.1

