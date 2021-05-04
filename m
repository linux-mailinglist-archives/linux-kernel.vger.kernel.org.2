Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8AE373075
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhEDTMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:12:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:9835 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231849AbhEDTMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:12:36 -0400
IronPort-SDR: 5SLc0gNAvmQoupwjaAw7blTg4QL5XMAxZQnkQ6jF/9oPtPM2VcvGEJa5QKTuCRX0NP6K+SPGgj
 3Bu1IhQJMlhQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="198115952"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="198115952"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 12:11:40 -0700
IronPort-SDR: QRMhQ60IP6XEM0FH9wzLjak7I1PeorEfIptzOegX1syGKho/lGCLE079Kjyrq5+yQl75p6zrQl
 5WEtluDgxtTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="396245278"
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
        David Woodhouse <dwmw2@infradead.org>,
        "x86 @ kernel . orgReviewed-by : Ashok Raj" <ashok.raj@intel.com>
Subject: [RFC PATCH v5 1/7] x86/apic: Add irq_cfg::delivery_mode
Date:   Tue,  4 May 2021 12:10:43 -0700
Message-Id: <20210504191049.22661-2-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210504191049.22661-1-ricardo.neri-calderon@linux.intel.com>
References: <20210504191049.22661-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now, the delivery mode of APIC interrupts is set to the default
mode set in the APIC driver. However, there are no restrictions in hardware
to configure each interrupt with a different delivery mode. Specifying the
delivery mode per interrupt is useful when one is interested in changing
the delivery mode of a particular interrupt. For instance, this can be used
to deliver an interrupt as non-maskable.

Add a new member, delivery_mode, to struct irq_cfg. This new member can
be used to update the configuration of the delivery mode in each interrupt
domain.

Currently, all interrupt domains set the delivery mode of interrupts using
the APIC setting. Interrupt domains use an irq_cfg data structure to
configure their own data structures and hardware resources. Thus, in order
to keep the current behavior, set the delivery mode of the irq
configuration that as the APIC setting. In this manner, irq domains can
obtain the delivery mode from the irq configuration data instead of the
APIC setting, if needed.

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
Cc: x86@kernel.orgReviewed-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v4:
 * Rebased to use new enumeration apic_delivery_modes.

Changes since v3:
 * None

Changes since v2:
 * Reduced scope to only add the interrupt delivery mode in
   struct irq_alloc_info.

Changes since v1:
 * Introduced this patch.
---
 arch/x86/include/asm/hw_irq.h |  1 +
 arch/x86/kernel/apic/vector.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index d465ece58151..370f4db0372b 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -90,6 +90,7 @@ struct irq_alloc_info {
 struct irq_cfg {
 	unsigned int		dest_apicid;
 	unsigned int		vector;
+	enum apic_delivery_modes	delivery_mode;
 };
 
 extern struct irq_cfg *irq_cfg(unsigned int irq);
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 6dbdc7c22bb7..d47ed07a56a4 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -567,6 +567,16 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 		irqd->chip_data = apicd;
 		irqd->hwirq = virq + i;
 		irqd_set_single_target(irqd);
+
+		/*
+		 * Initialize the delivery mode of this irq to match the
+		 * default delivery mode of the APIC. This is useful for
+		 * children irq domains which want to take the delivery
+		 * mode from the individual irq configuration rather
+		 * than from the APIC.
+		 */
+		 apicd->hw_irq_cfg.delivery_mode = apic->delivery_mode;
+
 		/*
 		 * Prevent that any of these interrupts is invoked in
 		 * non interrupt context via e.g. generic_handle_irq()
-- 
2.17.1

