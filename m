Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21C44005E8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 21:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348220AbhICTiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 15:38:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231599AbhICTiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 15:38:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 830BA60F42;
        Fri,  3 Sep 2021 19:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630697835;
        bh=8pJXwbq8sr7AEftGFAhYt+EmsU9VO48MHi8Lzyl5ku4=;
        h=From:To:Cc:Subject:Date:From;
        b=iWniM8iiwgFevFvWVJMFl5vXAThH0ZAJxbrfWDF2oz8avYvzN2xml4BwZFCVJMw1r
         jg3HtCwlQ9EK6SWNi88GGxdHHZngL83WVYYmWZ5Zo1l/OkUbxptG6WmUVXuR1uSpxL
         nsvlfSP1rPL4d91i1q9vwhif63uj6yqjia+L2gYTdZmSyUkz+ht04iFu2MQpKiW+Wq
         n0oVZmtSGyL52XxfTFrICm6LRgUxJ5ZHm1B/e3OTrSWryOz4G14Sv4IVqDeXClLXOJ
         YyIoVYb8P5l6C9Ky6tgZP8ZZNmivIoNlbK/y36kZUR3VnAboZEZwUQ2HzwEeCOyCY1
         x3L9VLHELRHyw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] iommu/vt-d: Drop "0x" prefix from PCI bus & device addresses
Date:   Fri,  3 Sep 2021 14:37:11 -0500
Message-Id: <20210903193711.483999-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

719a19335692 ("iommu/vt-d: Tweak the description of a DMA fault") changed
the DMA fault reason from hex to decimal.  It also added "0x" prefixes to
the PCI bus/device, e.g.,

  - DMAR: [INTR-REMAP] Request device [00:00.5]
  + DMAR: [INTR-REMAP] Request device [0x00:0x00.5]

These no longer match dev_printk() and other similar messages in
dmar_match_pci_path() and dmar_acpi_insert_dev_scope().

Drop the "0x" prefixes from the bus and device addresses.

Fixes: 719a19335692 ("iommu/vt-d: Tweak the description of a DMA fault")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/iommu/intel/dmar.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index d66f79acd14d..8647a355dad0 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1944,18 +1944,18 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 	reason = dmar_get_fault_reason(fault_reason, &fault_type);
 
 	if (fault_type == INTR_REMAP)
-		pr_err("[INTR-REMAP] Request device [0x%02x:0x%02x.%d] fault index 0x%llx [fault reason 0x%02x] %s\n",
+		pr_err("[INTR-REMAP] Request device [%02x:%02x.%d] fault index 0x%llx [fault reason 0x%02x] %s\n",
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
 		       PCI_FUNC(source_id & 0xFF), addr >> 48,
 		       fault_reason, reason);
 	else if (pasid == INVALID_IOASID)
-		pr_err("[%s NO_PASID] Request device [0x%02x:0x%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
+		pr_err("[%s NO_PASID] Request device [%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
 		       type ? "DMA Read" : "DMA Write",
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
 		       PCI_FUNC(source_id & 0xFF), addr,
 		       fault_reason, reason);
 	else
-		pr_err("[%s PASID 0x%x] Request device [0x%02x:0x%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
+		pr_err("[%s PASID 0x%x] Request device [%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
 		       type ? "DMA Read" : "DMA Write", pasid,
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
 		       PCI_FUNC(source_id & 0xFF), addr,
-- 
2.25.1

