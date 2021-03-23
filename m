Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C87346AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbhCWVLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbhCWVLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:11:18 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016F2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 14:11:17 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id m7so13018893pgj.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 14:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CLIOhCRms8tpJ/sHpF45FW6i8w9LAGKp/drQPJzwM74=;
        b=b379C8IjnEtT9XjLYWVbqa3a7tYRZ+8EjPiTrqLlwwVBHTQK7I3P+XvFOi/XKneRgx
         4AVVDxN9IDV/ZOyPVU9kKsucpqBZcDJjXYv1W4lN7yyeM9o7gMQAJFQQ2THh073XKjva
         7bqbhWRCKXQuXB6BMOz3RwgUi8X0xcnhUCqafI+1/Y2ChkuX4Ski2lSrBGuTPjwCqwXe
         PMqjOVzr5F7Yqpb3r5ouO8zUUF8mq80IKBUXgAEM+M63kJyPizBpxtYYV8zQd8fHuHMK
         +rVvK5fjwIZd0EtYLJwzSW91vFvfRdxTX0INMYmKwUoVGCMdeduMlpkkZoEaeqor9kTZ
         evLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CLIOhCRms8tpJ/sHpF45FW6i8w9LAGKp/drQPJzwM74=;
        b=eTIZucgmaWJmFP+eA8vteB7XFk5wv2OUbybcTxS4hc3oBKrtcgmMVX3UTlVSppTuQv
         dmG6/meuAgXiQTDpqxmiq17BeH62NNIQFQt/S87K+dYWQwSei/xKLrcrH6vHDorWA0ie
         aaADiKasnIKMtpcJ4AYDJNwTgXFEReYFHewItH4hJcjRPkg0hsDkVKhttciHR6Pf+vbf
         7pfUHfel3yT2Le43VVWpeAZ8OLroK6iwOcabVcCtqTnnzDymJTqPosKfdoeVPTsb9cvT
         l8FMotzq05acfZb9jmk9iXBn4gv0MrpZEDLFQ2/Pp3bFasQDwkwr3/IKwBC0GGBCAuFr
         2uDA==
X-Gm-Message-State: AOAM533X5U0YCUlwrboaMHjLEFiQ9MaDbZajI4EfU11Z716wNj364ovG
        gJSCcvrKPDxFbWfCo1FIOqw=
X-Google-Smtp-Source: ABdhPJzqdN84423qKzDEVMMzkVrrCjeBTYKM0+hQe8eyob6r/r5rqxq3ktgngDVVuUnXYBXcwHh4Ng==
X-Received: by 2002:a17:902:ac94:b029:e6:de3d:3cb7 with SMTP id h20-20020a170902ac94b02900e6de3d3cb7mr279748plr.23.1616533877209;
        Tue, 23 Mar 2021 14:11:17 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id 190sm106058pgh.61.2021.03.23.14.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 14:11:16 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Nadav Amit <namit@vmware.com>, Jiajun Cao <caojiajun@vmware.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/amd: page-specific invalidations for more than one page
Date:   Tue, 23 Mar 2021 14:06:19 -0700
Message-Id: <20210323210619.513069-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Currently, IOMMU invalidations and device-IOTLB invalidations using
AMD IOMMU fall back to full address-space invalidation if more than a
single page need to be flushed.

Full flushes are especially inefficient when the IOMMU is virtualized by
a hypervisor, since it requires the hypervisor to synchronize the entire
address-space.

AMD IOMMUs allow to provide a mask to perform page-specific
invalidations for multiple pages that match the address. The mask is
encoded as part of the address, and the first zero bit in the address
(in bits [51:12]) indicates the mask size.

Use this hardware feature to perform selective IOMMU and IOTLB flushes.
Combine the logic between both for better code reuse.

The IOMMU invalidations passed a smoke-test. The device IOTLB
invalidations are untested.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/iommu/amd/iommu.c | 76 +++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 34 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 9256f84f5ebf..5f2dc3d7f2dc 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -927,33 +927,58 @@ static void build_inv_dte(struct iommu_cmd *cmd, u16 devid)
 	CMD_SET_TYPE(cmd, CMD_INV_DEV_ENTRY);
 }
 
-static void build_inv_iommu_pages(struct iommu_cmd *cmd, u64 address,
-				  size_t size, u16 domid, int pde)
+/*
+ * Builds an invalidation address which is suitable for one page or multiple
+ * pages. Sets the size bit (S) as needed is more than one page is flushed.
+ */
+static inline u64 build_inv_address(u64 address, size_t size)
 {
-	u64 pages;
-	bool s;
+	u64 pages, end, msb_diff;
 
 	pages = iommu_num_pages(address, size, PAGE_SIZE);
-	s     = false;
 
-	if (pages > 1) {
+	if (pages == 1)
+		return address & PAGE_MASK;
+
+	end = address + size - 1;
+
+	/*
+	 * msb_diff would hold the index of the most significant bit that
+	 * flipped between the start and end.
+	 */
+	msb_diff = fls64(end ^ address) - 1;
+
+	/*
+	 * Bits 63:52 are sign extended. If for some reason bit 51 is different
+	 * between the start and the end, invalidate everything.
+	 */
+	if (unlikely(msb_diff > 51)) {
+		address = CMD_INV_IOMMU_ALL_PAGES_ADDRESS;
+	} else {
 		/*
-		 * If we have to flush more than one page, flush all
-		 * TLB entries for this domain
+		 * The msb-bit must be clear on the address. Just set all the
+		 * lower bits.
 		 */
-		address = CMD_INV_IOMMU_ALL_PAGES_ADDRESS;
-		s = true;
+		address |= 1ull << (msb_diff - 1);
 	}
 
+	/* Clear bits 11:0 */
 	address &= PAGE_MASK;
 
+	/* Set the size bit - we flush more than one 4kb page */
+	return address | CMD_INV_IOMMU_PAGES_SIZE_MASK;
+}
+
+static void build_inv_iommu_pages(struct iommu_cmd *cmd, u64 address,
+				  size_t size, u16 domid, int pde)
+{
+	u64 inv_address = build_inv_address(address, size);
+
 	memset(cmd, 0, sizeof(*cmd));
 	cmd->data[1] |= domid;
-	cmd->data[2]  = lower_32_bits(address);
-	cmd->data[3]  = upper_32_bits(address);
+	cmd->data[2]  = lower_32_bits(inv_address);
+	cmd->data[3]  = upper_32_bits(inv_address);
 	CMD_SET_TYPE(cmd, CMD_INV_IOMMU_PAGES);
-	if (s) /* size bit - we flush more than one 4kb page */
-		cmd->data[2] |= CMD_INV_IOMMU_PAGES_SIZE_MASK;
 	if (pde) /* PDE bit - we want to flush everything, not only the PTEs */
 		cmd->data[2] |= CMD_INV_IOMMU_PAGES_PDE_MASK;
 }
@@ -961,32 +986,15 @@ static void build_inv_iommu_pages(struct iommu_cmd *cmd, u64 address,
 static void build_inv_iotlb_pages(struct iommu_cmd *cmd, u16 devid, int qdep,
 				  u64 address, size_t size)
 {
-	u64 pages;
-	bool s;
-
-	pages = iommu_num_pages(address, size, PAGE_SIZE);
-	s     = false;
-
-	if (pages > 1) {
-		/*
-		 * If we have to flush more than one page, flush all
-		 * TLB entries for this domain
-		 */
-		address = CMD_INV_IOMMU_ALL_PAGES_ADDRESS;
-		s = true;
-	}
-
-	address &= PAGE_MASK;
+	u64 inv_address = build_inv_address(address, size);
 
 	memset(cmd, 0, sizeof(*cmd));
 	cmd->data[0]  = devid;
 	cmd->data[0] |= (qdep & 0xff) << 24;
 	cmd->data[1]  = devid;
-	cmd->data[2]  = lower_32_bits(address);
-	cmd->data[3]  = upper_32_bits(address);
+	cmd->data[2]  = lower_32_bits(inv_address);
+	cmd->data[3]  = upper_32_bits(inv_address);
 	CMD_SET_TYPE(cmd, CMD_INV_IOTLB_PAGES);
-	if (s)
-		cmd->data[2] |= CMD_INV_IOMMU_PAGES_SIZE_MASK;
 }
 
 static void build_inv_iommu_pasid(struct iommu_cmd *cmd, u16 domid, u32 pasid,
-- 
2.25.1

