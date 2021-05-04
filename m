Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635F8373074
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbhEDTMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:12:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:9835 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231694AbhEDTMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:12:36 -0400
IronPort-SDR: ScqSuGxiOOP4EVZ1HORoxheTn9sR079OHmFv769XISXvjFaw/W1txIjY5VOtcPjqcJ4egqEj7c
 p/otVggmI8SQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="198115951"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="198115951"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 12:11:40 -0700
IronPort-SDR: pqfyhjcoUwP+RhjIgOOdDX0iTRL7b0YM4al68SNO5jQQDwvzBL3zQ/QbxYutFTINWforPd5KBO
 T/vWTRF7dwUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="396245275"
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
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [RFC PATCH v5 0/7] x86: watchdog/hardlockup/hpet: Add support for interrupt remapping
Date:   Tue,  4 May 2021 12:10:42 -0700
Message-Id: <20210504191049.22661-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi IOMMU experts,

I proposed a hardlockup detector driven by the HPET timer [1]. Such
detector is driven by a single timer. The hardlockup detector brings the
extra complexity of having to update the affinity of the interrupt
periodically and initiated from NMI context. The proposed design only
requires updating the affinity every watchdog_thresh (the interval is
between [1, 60] seconds). Also, the affinity update is offloaded to
an irq_work. Handling the HPET interrupt affinity is trivial with
!intremap since the detector composes the MSI message and writes it
directly to the HPET registers.

However, for intremap we must use the existing IOMMU drivers as well as
the kernel's irq plumbing. Thomas Gleixner has imposed two restrictions:
  1) Do not implement an IRQF_NMI flag for x86 as it is not possible to
     determine the source of an NMI [2].
  2) Use the irq subsystem to update the affinity of the HPET
     interrupt [3].

1) implies that the interrupt remapping drivers need to implement a quirk
to identify the HPET interrupt and update its delivery mode to NMI. 2)
means that the hardlockup detector must use request_irq() to allocate the
HPET interrupt.

This patch series attempts to meet the requirements above by
  a) Decoupling the delivery mode of an APIC interrupt from the delivery
     mode of the APIC driver (patch 1)
  b) Implement quirks in the Intel and AMD IOMMU drivers to identify the
     HPET timer and update the delivery mode accordingly (patches 2-5).
  c) Add support for interrupt remapping in the HPET hardlockup detector
     in [1]. This includes the unavoidable eyesore of using request_irq()
     and having a useless regular interrupt handler (patch 6).

I would like to get your feedback on whether the HPET NMI quirk looks
sane to you and whether offloading the affinity setup to an irq_work
could pose issues.

Thanks and BR,
Ricardo

[1]. https://lore.kernel.org/lkml/20210504190526.22347-1-ricardo.neri-calderon@linux.intel.com/T/#mf77988cc98f9ca6988831e17f68394577388959d
[2]. https://lore.kernel.org/lkml/alpine.DEB.2.21.1808021137400.2037@nanos.tec.linutronix.de/
[3]. https://lore.kernel.org/lkml/alpine.DEB.2.21.1906161042080.1760@nanos.tec.linutronix.de/

Changes since v4:
 * With !CONFIG_IRQ_REMAP [1] now disables the HPET channel before changing
   the MSI Destination ID field. This should avoid races between a pending
   interrupt and updating the detector's interrupt affinity. (Ashok)
 * Rebased to use new enumeration apic_delivery_modes.
 * Removed custom functions to allocate an interrupt for the detector
   and instead added support to identify the detector's interrupt and
   change the delivery mode.
 * With interrupt remapping enabled, use request_irq().
 * Added support for AMD IOMMU.

Changes since v3:
 * None

Changes since v2:
 * None

Changes since v1:
 * Introduced support for interrupt remapping

Ricardo Neri (7):
  x86/apic: Add irq_cfg::delivery_mode
  x86/hpet: Introduce function to identify HPET hardlockup detector irq
  iommu/vt-d: Rework prepare_irte() to support per-irq delivery mode
  iommu/amd: Set the IRTE delivery mode from irq_cfg
  iommu/vt-d: Fixup delivery mode of the HPET hardlockup interrupt
  iommu/amd: Fixup delivery mode of the HPET hardlockup interrupt
  x86/watchdog/hardlockup/hpet: Support interrupt remapping

 arch/x86/include/asm/hpet.h         |  5 +++
 arch/x86/include/asm/hw_irq.h       |  1 +
 arch/x86/kernel/apic/vector.c       | 10 ++++++
 arch/x86/kernel/hpet.c              | 36 ++++++++++++++++++++++
 arch/x86/kernel/watchdog_hld_hpet.c | 48 +++++++++++++++++++++++++----
 drivers/iommu/amd/iommu.c           | 11 ++++++-
 drivers/iommu/intel/irq_remapping.c | 20 ++++++++----
 7 files changed, 118 insertions(+), 13 deletions(-)

-- 
2.17.1

