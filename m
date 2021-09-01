Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5913FE05B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 18:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344186AbhIAQvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 12:51:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233909AbhIAQvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 12:51:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE8AF61053;
        Wed,  1 Sep 2021 16:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630515021;
        bh=uWdVEmRV3XydORkWWe2hpw7aa0AMyu3M9oS7lhuwlDk=;
        h=From:To:Cc:Subject:Date:From;
        b=gqthBBnKfLfvPo+COVGicaokIfxmxxI63c4jKI7k+uCFEKq83vNQoJeonI7U8oNvk
         RKfmF/8iU8AYRa1dALeXKtDQgijS1TCr8tNhu1kew49cuTXn6Ws15jvZxLzZo6Ue3w
         P4UxjGLBCXkfhAaFpjVjp3RPryl5XFq+C3f4lSPWP92vE4X4860UsHEfn3yUot4rLu
         BLZutOFYKOC+KqGrOIeI+RdDqsFkqsdX5xUd0/RQa/3Eq1nORADzAV7b2b75iv6PhF
         TXyI+aFyKE/9eQ4oRtvY5WfsZyMtJW4wFze/ab0Xphzem/bGeIFv3MUs/Ld17swFkh
         iPPLsY0K1J+gg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH] habanalabs/gaudi: use direct MSI in single mode
Date:   Wed,  1 Sep 2021 19:50:16 +0300
Message-Id: <20210901165016.33343-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

Due to FLR scenario when running inside a VM, we must not use indirect
MSI because it might cause some issues on VM destroy.
In a VM we use single MSI mode in contrary to multi MSI mode which is
used in bare-metal.
Hence direct MSI should be used in single MSI mode only.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c                    | 9 ++++++---
 .../misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h  | 2 ++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 383865be3c2c..5249f8fd4d59 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -5802,6 +5802,7 @@ static void gaudi_add_end_of_cb_packets(struct hl_device *hdev,
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
 	struct packet_msg_prot *cq_pkt;
+	u64 msi_addr;
 	u32 tmp;
 
 	cq_pkt = kernel_address + len - (sizeof(struct packet_msg_prot) * 2);
@@ -5823,10 +5824,12 @@ static void gaudi_add_end_of_cb_packets(struct hl_device *hdev,
 	cq_pkt->ctl = cpu_to_le32(tmp);
 	cq_pkt->value = cpu_to_le32(1);
 
-	if (!gaudi->multi_msi_mode)
-		msi_vec = 0;
+	if (gaudi->multi_msi_mode)
+		msi_addr = mmPCIE_MSI_INTR_0 + msi_vec * 4;
+	else
+		msi_addr = mmPCIE_CORE_MSI_REQ;
 
-	cq_pkt->addr = cpu_to_le64(CFG_BASE + mmPCIE_MSI_INTR_0 + msi_vec * 4);
+	cq_pkt->addr = cpu_to_le64(CFG_BASE + msi_addr);
 }
 
 static void gaudi_update_eq_ci(struct hl_device *hdev, u32 val)
diff --git a/drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h b/drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h
index ffdfbd9b3220..1a6576666794 100644
--- a/drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h
+++ b/drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h
@@ -308,6 +308,8 @@
 #define mmPCIE_AUX_FLR_CTRL                                          0xC07394
 #define mmPCIE_AUX_DBI                                               0xC07490
 
+#define mmPCIE_CORE_MSI_REQ                                          0xC04100
+
 #define mmPSOC_PCI_PLL_NR                                            0xC72100
 #define mmSRAM_W_PLL_NR                                              0x4C8100
 #define mmPSOC_HBM_PLL_NR                                            0xC74100
-- 
2.17.1

