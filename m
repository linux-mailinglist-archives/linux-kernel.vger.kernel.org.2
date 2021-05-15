Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8943E3819E0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 18:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbhEOQdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 12:33:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233615AbhEOQco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 12:32:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34786613C5;
        Sat, 15 May 2021 16:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621096291;
        bh=4gHjH22hjrE+c2KImEPYjZEasVP7AlG3q3zTrVqVgGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=js28ESWONIJ8IpOnXOHkWb3msBoP8MHFQhC1aXCUmV4qCbdhfe/0GjJitStmb5Qh8
         EJX3tFkh9Ez4Po6LyUMYQIZY3KYaQ7JNMm6ZxnfDuZ5NSgSfcWgO77drkPp8Qbm/7K
         bhdpXqmn4oYiwr1t2iBCpzAUvzr1RE77B/aIgs2CWVzhEtFBSNOF6s+roheG24vgQb
         LTNzTY+okzQGj4O+Kwkvcn3vZAxSbqo5eDyfa4lOagTH4r1elvQrlCt+Ox+OmVe00z
         C4y7g9sGf1crs7vAIZgKCVEDeb17pSPkYY5n/d3XcnPhBw15Gmc6LEaYrEEgFW/7YE
         avseyycuzBN5g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 5/5] habanalabs/gaudi: do not move HBM bar if iATU done by FW
Date:   Sat, 15 May 2021 19:31:16 +0300
Message-Id: <20210515163116.14181-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210515163116.14181-1-ogabbay@kernel.org>
References: <20210515163116.14181-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

As iATU configuration is done by FW, driver should not try and
move HBM bar.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 375f7893b84a..6654f95caecd 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -580,6 +580,9 @@ static u64 gaudi_set_hbm_bar_base(struct hl_device *hdev, u64 addr)
 	if ((gaudi) && (gaudi->hbm_bar_cur_addr == addr))
 		return old_addr;
 
+	if (hdev->asic_prop.iatu_done_by_fw)
+		return U64_MAX;
+
 	/* Inbound Region 2 - Bar 4 - Point to HBM */
 	pci_region.mode = PCI_BAR_MATCH_MODE;
 	pci_region.bar = HBM_BAR_ID;
@@ -3974,10 +3977,27 @@ static void gaudi_pre_hw_init(struct hl_device *hdev)
 
 static int gaudi_hw_init(struct hl_device *hdev)
 {
+	struct gaudi_device *gaudi = hdev->asic_specific;
 	int rc;
 
 	gaudi_pre_hw_init(hdev);
 
+	/* If iATU is done by FW, the HBM bar ALWAYS points to DRAM_PHYS_BASE.
+	 * So we set it here and if anyone tries to move it later to
+	 * a different address, there will be an error
+	 */
+	if (hdev->asic_prop.iatu_done_by_fw)
+		gaudi->hbm_bar_cur_addr = DRAM_PHYS_BASE;
+
+	/*
+	 * Before pushing u-boot/linux to device, need to set the hbm bar to
+	 * base address of dram
+	 */
+	if (gaudi_set_hbm_bar_base(hdev, DRAM_PHYS_BASE) == U64_MAX) {
+		dev_err(hdev->dev,
+			"failed to map HBM bar to DRAM base address\n");
+		return -EIO;
+	}
 
 	rc = gaudi_init_cpu(hdev);
 	if (rc) {
-- 
2.25.1

