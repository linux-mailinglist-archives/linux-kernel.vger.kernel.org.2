Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6805738D411
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 08:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhEVG4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 02:56:04 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:25724 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229914AbhEVG4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 02:56:00 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d71 with ME
        id 7iub2500221Fzsu03iubbV; Sat, 22 May 2021 08:54:35 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 22 May 2021 08:54:35 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     arnd@arndb.de, gregkh@linuxfoundation.org,
        mihai.carabas@oracle.com, andriy.shevchenko@linux.intel.com,
        pizhenwei@bytedance.com, pbonzini@redhat.com,
        bobo.shaobowang@huawei.com, linqiheng@huawei.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 1/5] misc/pvpanic-pci: Fix error handling in 'pvpanic_pci_probe()'
Date:   Sat, 22 May 2021 08:54:33 +0200
Message-Id: <ab071b1f4ed6e1174f9199095fb16a58bb406090.1621665058.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1621665058.git.christophe.jaillet@wanadoo.fr>
References: <cover.1621665058.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no error handling path in the probe function.
Switch to managed resource so that errors in the probe are handled easily
and simplify the remove function accordingly.

Fixes: db3a4f0abefd ("misc/pvpanic: add PCI driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: add -pci in the description of the commit
---
 drivers/misc/pvpanic/pvpanic-pci.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
index 9ecc4e8559d5..046ce4ecc195 100644
--- a/drivers/misc/pvpanic/pvpanic-pci.c
+++ b/drivers/misc/pvpanic/pvpanic-pci.c
@@ -78,15 +78,15 @@ static int pvpanic_pci_probe(struct pci_dev *pdev,
 	void __iomem *base;
 	int ret;
 
-	ret = pci_enable_device(pdev);
+	ret = pcim_enable_device(pdev);
 	if (ret < 0)
 		return ret;
 
-	base = pci_iomap(pdev, 0, 0);
+	base = pcim_iomap(pdev, 0, 0);
 	if (!base)
 		return -ENOMEM;
 
-	pi = kmalloc(sizeof(*pi), GFP_ATOMIC);
+	pi = devm_kmalloc(&pdev->dev, sizeof(*pi), GFP_ATOMIC);
 	if (!pi)
 		return -ENOMEM;
 
@@ -107,9 +107,6 @@ static void pvpanic_pci_remove(struct pci_dev *pdev)
 	struct pvpanic_instance *pi = dev_get_drvdata(&pdev->dev);
 
 	pvpanic_remove(pi);
-	iounmap(pi->base);
-	kfree(pi);
-	pci_disable_device(pdev);
 }
 
 static struct pci_driver pvpanic_pci_driver = {
-- 
2.30.2

