Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09026381D65
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 10:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbhEPI3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 04:29:04 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:28926 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhEPI3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 04:29:02 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d54 with ME
        id 5LTk2500821Fzsu03LTk3J; Sun, 16 May 2021 10:27:46 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 16 May 2021 10:27:46 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] intel_th: Fix a resource leak in an error handling path
Date:   Sun, 16 May 2021 10:27:43 +0200
Message-Id: <6e89bfd3c66de62bc3b9da720a2c864a7c167c49.1621153607.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs after calling 'pci_alloc_irq_vectors()',
'pci_free_irq_vectors()' must be called as already done in the remove
function.

Fixes: 7b7036d47c35 ("intel_th: pci: Use MSI interrupt signalling")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/hwtracing/intel_th/pci.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index 7da4f298ed01..fcd0aca75007 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -100,8 +100,10 @@ static int intel_th_pci_probe(struct pci_dev *pdev,
 		}
 
 	th = intel_th_alloc(&pdev->dev, drvdata, resource, r);
-	if (IS_ERR(th))
-		return PTR_ERR(th);
+	if (IS_ERR(th)) {
+		err = PTR_ERR(th);
+		goto err_free_irq;
+	}
 
 	th->activate   = intel_th_pci_activate;
 	th->deactivate = intel_th_pci_deactivate;
@@ -109,6 +111,10 @@ static int intel_th_pci_probe(struct pci_dev *pdev,
 	pci_set_master(pdev);
 
 	return 0;
+
+err_free_irq:
+	pci_free_irq_vectors(pdev);
+	return err;
 }
 
 static void intel_th_pci_remove(struct pci_dev *pdev)
-- 
2.30.2

