Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046AD44EBD4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 18:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbhKLRMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 12:12:49 -0500
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:53467 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235434AbhKLRMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 12:12:47 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id la3nmTxux1UGBla3nmGMMW; Fri, 12 Nov 2021 18:09:55 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 12 Nov 2021 18:09:55 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     andraprs@amazon.com, lexnv@amazon.com, alcioa@amazon.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] nitro_enclaves: Remove redundant 'flush_workqueue()' calls
Date:   Fri, 12 Nov 2021 18:09:54 +0100
Message-Id: <d57f5c7e362837a8dfcde0d726a76b56f114e619.1636736947.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'destroy_workqueue()' already drains the queue before destroying it, so
there is no need to flush it explicitly.

Remove the redundant 'flush_workqueue()' calls.

This was generated with coccinelle:

@@
expression E;
@@
- 	flush_workqueue(E);
	destroy_workqueue(E);

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/virt/nitro_enclaves/ne_pci_dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/virt/nitro_enclaves/ne_pci_dev.c b/drivers/virt/nitro_enclaves/ne_pci_dev.c
index 40b49ec8e30b..6b81e8f3a5dc 100644
--- a/drivers/virt/nitro_enclaves/ne_pci_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_pci_dev.c
@@ -376,7 +376,6 @@ static void ne_teardown_msix(struct pci_dev *pdev)
 	free_irq(pci_irq_vector(pdev, NE_VEC_EVENT), ne_pci_dev);
 
 	flush_work(&ne_pci_dev->notify_work);
-	flush_workqueue(ne_pci_dev->event_wq);
 	destroy_workqueue(ne_pci_dev->event_wq);
 
 	free_irq(pci_irq_vector(pdev, NE_VEC_REPLY), ne_pci_dev);
-- 
2.30.2

