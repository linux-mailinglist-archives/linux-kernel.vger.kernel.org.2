Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAEC373081
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhEDTMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:12:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:9835 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232208AbhEDTMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:12:37 -0400
IronPort-SDR: +cxvddP6+QdssEN3Aa3nrEiVng0iUMhdniolVo8rjOMYRMzFjo4NfysdChBp2onHNCr3AJxQNr
 eIgkKZDNwEzA==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="198115957"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="198115957"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 12:11:41 -0700
IronPort-SDR: zQFJBhcgEZHf9/cLASl+w3pxDwLapeYUVWAYAzxAEdsolXppVm2zQle2n+OvvjriN/I1K1zzry
 WtNkOTjab2+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="396245297"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 04 May 2021 12:11:41 -0700
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
Subject: [RFC PATCH v5 5/7] iommu/vt-d: Fixup delivery mode of the HPET hardlockup interrupt
Date:   Tue,  4 May 2021 12:10:47 -0700
Message-Id: <20210504191049.22661-6-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210504191049.22661-1-ricardo.neri-calderon@linux.intel.com>
References: <20210504191049.22661-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HPET hardlockup detector requires that the HPET timer delivers the
interrupt as NMI. When interrupt remapping is disabled, this can be
done by programming the HPET MSI registers directly. With interrupt
remapping, it is necessary to populate an entry in the interrupt
remapping table.

In x86 there is not an IRQF_NMI flag that can be used to indicate the
delivery mode when requesting an interrupt (via request_irq()). Thus,
there is no way for the interrupt remapping driver to know and set
the delivery mode.

Hence, when allocating an interrupt, check if such interrupt belongs to
the HPET hardlockup detector and fixup the delivery mode accordingly.

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
 * Introduced this patch.

Changes since v3:
 * N/A

Changes since v2:
 * N/A

Changes since v1:
 * N/A
---
 drivers/iommu/intel/irq_remapping.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index daa5df53db59..b07c68ecac01 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -18,6 +18,7 @@
 #include <asm/apic.h>
 #include <asm/smp.h>
 #include <asm/cpu.h>
+#include <asm/hpet.h>
 #include <asm/irq_remapping.h>
 #include <asm/pci-direct.h>
 
@@ -1376,6 +1377,14 @@ static int intel_irq_remapping_alloc(struct irq_domain *domain,
 		irq_data->hwirq = (index << 16) + i;
 		irq_data->chip_data = ird;
 		irq_data->chip = &intel_ir_chip;
+
+		/*
+		 * If we find the HPET hardlockup detector irq, fixup the
+		 * delivery mode.
+		 */
+		if (is_hpet_irq_hardlockup_detector(info))
+			irq_cfg->delivery_mode = APIC_DELIVERY_MODE_NMI;
+
 		intel_irq_remapping_prepare_irte(ird, irq_cfg, info, index, i);
 		irq_set_status_flags(virq + i, IRQ_MOVE_PCNTXT);
 	}
-- 
2.17.1

