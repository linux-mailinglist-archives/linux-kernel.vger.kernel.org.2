Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA403A4CFC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 07:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhFLFl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 01:41:56 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:53387 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhFLFlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 01:41:55 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d17 with ME
        id G5ft2500E21Fzsu035fth4; Sat, 12 Jun 2021 07:39:55 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 12 Jun 2021 07:39:55 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     ogabbay@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        obitton@habana.ai, oshpigelman@habana.ai, fkassabri@habana.ai
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] habanalabs: Fix an error handling path in 'hl_pci_probe()'
Date:   Sat, 12 Jun 2021 07:39:51 +0200
Message-Id: <e0d146b034576c755cb98018159fa30f8dba2101.1623476278.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs after a 'pci_enable_pcie_error_reporting()' call, it
must be undone by a corresponding 'pci_disable_pcie_error_reporting()'
call, as already done in the remove function.

Fixes: 2e5eda4681f9 ("habanalabs: PCIe Advanced Error Reporting support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/misc/habanalabs/common/habanalabs_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 64d1530db985..d15b912a347b 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -464,6 +464,7 @@ static int hl_pci_probe(struct pci_dev *pdev,
 	return 0;
 
 disable_device:
+	pci_disable_pcie_error_reporting(pdev);
 	pci_set_drvdata(pdev, NULL);
 	destroy_hdev(hdev);
 
-- 
2.30.2

