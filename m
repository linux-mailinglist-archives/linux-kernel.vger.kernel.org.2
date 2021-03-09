Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04C3332E47
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 19:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhCIS2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 13:28:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:37362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230425AbhCIS2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 13:28:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1E1364F57
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 18:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615314527;
        bh=AZNhylBq8yJ8qXi4iAQ1TDsXOMhTObzC9WCn/FBHvP0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TpWhQK2kJXst8Ioa4f9lZ7T3r8d7lTWP9YMtd3uFK+2i0zgXnjKuIXkg7h4Tczy0c
         /IuRcjc20KhFhYueTOAlL1RFmjjD+zo7j3j1ztmiLlNnsJu7xGfRfwVCqpaxVaQVIy
         S+12yFeOnQ/1bTaOLK5NwcpF1PKBRyy63FN0sN7LfTkSJWiDOGv0qWgzOXjXeJJoOX
         tUydtYru4/Ltd+YNJOmzOjh6KqlatKHTOTESAPHiGCvk3AfRscXo970HhBtU8K+5Yx
         jU2Q+RjPR1cJeybbUlohAQUlPmnqleXQUgPsH08RLfQFTHirN4hsagqfSFfzI93OW/
         zwg2cL0Op46Ow==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] habanalabs/gaudi: always use single-msi mode
Date:   Tue,  9 Mar 2021 20:28:38 +0200
Message-Id: <20210309182838.4641-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210309182838.4641-1-ogabbay@kernel.org>
References: <20210309182838.4641-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device can get into deadlock in case it use indirect mode for MSI
interrupts (multi-msi) and have hard-reset during interrupt storm.

To prevent that, always use direct mode which means single-msi mode.

The F/W will prevent the host from writing to the indirect MSI
registers to prevent any malicious user from causing this scenario.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 099c51350be6..0bcee675e1db 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1766,8 +1766,7 @@ static int gaudi_enable_msi(struct hl_device *hdev)
 	if (gaudi->hw_cap_initialized & HW_CAP_MSI)
 		return 0;
 
-	rc = pci_alloc_irq_vectors(hdev->pdev, 1, GAUDI_MSI_ENTRIES,
-					PCI_IRQ_MSI);
+	rc = pci_alloc_irq_vectors(hdev->pdev, 1, 1, PCI_IRQ_MSI);
 	if (rc < 0) {
 		dev_err(hdev->dev, "MSI: Failed to enable support %d\n", rc);
 		return rc;
-- 
2.25.1

