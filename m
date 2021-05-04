Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B807837307F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhEDTMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:12:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:9838 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231926AbhEDTMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:12:37 -0400
IronPort-SDR: kwOVSmkIIogEIhADG8xZNoKTSF7+VBTzk5JmVEFYMbwCJnBNpOimF+SUhWGlDUOxazZfrccGvk
 +nVQkG0DLMdw==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="198115956"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="198115956"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 12:11:41 -0700
IronPort-SDR: fhkrUiuFVLDq9e4Qc69OzHKPlDkUNy8UnX6A/43uKWqfc4UO1ncrzGpZMAz8AnTgJiek3Tf9Ca
 JzXWUNiJIHgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="396245291"
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
Subject: [RFC PATCH v5 4/7] iommu/amd: Set the IRTE delivery mode from irq_cfg
Date:   Tue,  4 May 2021 12:10:46 -0700
Message-Id: <20210504191049.22661-5-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210504191049.22661-1-ricardo.neri-calderon@linux.intel.com>
References: <20210504191049.22661-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is not hardware requirement to have a different delivery mode for
each interrupt. Instead of using the delivery mode of the APIC driver, use
the delivery mode of each specific interrupt configuration.

This allows to accommodate interrupts which require a specific delivery
mode, such as the HPET hardlockup detector.

Outside of such case, there are not functional changes since the delivery
mode of an interrupt is initialized with the delivery mode of the APIC
driver.

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
 drivers/iommu/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a69a8b573e40..e8d9fae0c766 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3122,7 +3122,7 @@ static void irq_remapping_prepare_irte(struct amd_ir_data *data,
 
 	data->irq_2_irte.devid = devid;
 	data->irq_2_irte.index = index + sub_handle;
-	iommu->irte_ops->prepare(data->entry, apic->delivery_mode,
+	iommu->irte_ops->prepare(data->entry, irq_cfg->delivery_mode,
 				 apic->dest_mode_logical, irq_cfg->vector,
 				 irq_cfg->dest_apicid, devid);
 
-- 
2.17.1

