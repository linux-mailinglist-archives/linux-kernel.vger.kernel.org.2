Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFCC38D41A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 08:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhEVG4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 02:56:48 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:18913 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230095AbhEVG4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 02:56:47 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d71 with ME
        id 7ivM2500C21Fzsu03ivMfX; Sat, 22 May 2021 08:55:22 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 22 May 2021 08:55:22 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     arnd@arndb.de, gregkh@linuxfoundation.org,
        mihai.carabas@oracle.com, andriy.shevchenko@linux.intel.com,
        pizhenwei@bytedance.com, pbonzini@redhat.com,
        bobo.shaobowang@huawei.com, linqiheng@huawei.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 5/5] misc/pvpanic: Make 'pvpanic_probe()' resource managed
Date:   Sat, 22 May 2021 08:55:20 +0200
Message-Id: <9212cdc8c1e5c187a2f1129a6190085c2a10d28a.1621665058.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1621665058.git.christophe.jaillet@wanadoo.fr>
References: <cover.1621665058.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify code and turn 'pvpanic_probe()' into a managed resource version.
This simplify callers that don't need to do some clean-up on error in the
probe and on remove.

Update pvpanic-mmio.c and pvpanic-pci.c accordingly.

'pvpanic_remove()' don't need to be exported anymore.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Compile tested only
---
 drivers/misc/pvpanic/pvpanic-mmio.c | 14 +-------------
 drivers/misc/pvpanic/pvpanic-pci.c  | 13 +------------
 drivers/misc/pvpanic/pvpanic.c      | 30 ++++++++++++++---------------
 drivers/misc/pvpanic/pvpanic.h      |  3 +--
 4 files changed, 18 insertions(+), 42 deletions(-)

diff --git a/drivers/misc/pvpanic/pvpanic-mmio.c b/drivers/misc/pvpanic/pvpanic-mmio.c
index d4a407956c07..be4016084979 100644
--- a/drivers/misc/pvpanic/pvpanic-mmio.c
+++ b/drivers/misc/pvpanic/pvpanic-mmio.c
@@ -104,18 +104,7 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
 	pi->capability &= ioread8(base);
 	pi->events = pi->capability;
 
-	dev_set_drvdata(dev, pi);
-
-	return pvpanic_probe(pi);
-}
-
-static int pvpanic_mmio_remove(struct platform_device *pdev)
-{
-	struct pvpanic_instance *pi = dev_get_drvdata(&pdev->dev);
-
-	pvpanic_remove(pi);
-
-	return 0;
+	return devm_pvpanic_probe(dev, pi);
 }
 
 static const struct of_device_id pvpanic_mmio_match[] = {
@@ -138,6 +127,5 @@ static struct platform_driver pvpanic_mmio_driver = {
 		.dev_groups = pvpanic_mmio_dev_groups,
 	},
 	.probe = pvpanic_mmio_probe,
-	.remove = pvpanic_mmio_remove,
 };
 module_platform_driver(pvpanic_mmio_driver);
diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
index 3d7f9efb3dd4..a43c401017ae 100644
--- a/drivers/misc/pvpanic/pvpanic-pci.c
+++ b/drivers/misc/pvpanic/pvpanic-pci.c
@@ -73,7 +73,6 @@ ATTRIBUTE_GROUPS(pvpanic_pci_dev);
 static int pvpanic_pci_probe(struct pci_dev *pdev,
 			     const struct pci_device_id *ent)
 {
-	struct device *dev = &pdev->dev;
 	struct pvpanic_instance *pi;
 	void __iomem *base;
 	int ret;
@@ -97,23 +96,13 @@ static int pvpanic_pci_probe(struct pci_dev *pdev,
 	pi->capability &= ioread8(base);
 	pi->events = pi->capability;
 
-	dev_set_drvdata(dev, pi);
-
-	return pvpanic_probe(pi);
-}
-
-static void pvpanic_pci_remove(struct pci_dev *pdev)
-{
-	struct pvpanic_instance *pi = dev_get_drvdata(&pdev->dev);
-
-	pvpanic_remove(pi);
+	return devm_pvpanic_probe(&pdev->dev, pi);
 }
 
 static struct pci_driver pvpanic_pci_driver = {
 	.name =         "pvpanic-pci",
 	.id_table =     pvpanic_pci_id_tbl,
 	.probe =        pvpanic_pci_probe,
-	.remove =       pvpanic_pci_remove,
 	.driver = {
 		.dev_groups = pvpanic_pci_dev_groups,
 	},
diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
index 793ea0c01193..82770a088d62 100644
--- a/drivers/misc/pvpanic/pvpanic.c
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -61,22 +61,10 @@ static struct notifier_block pvpanic_panic_nb = {
 	.priority = 1, /* let this called before broken drm_fb_helper */
 };
 
-int pvpanic_probe(struct pvpanic_instance *pi)
-{
-	if (!pi || !pi->base)
-		return -EINVAL;
-
-	spin_lock(&pvpanic_lock);
-	list_add(&pi->list, &pvpanic_list);
-	spin_unlock(&pvpanic_lock);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pvpanic_probe);
-
-void pvpanic_remove(struct pvpanic_instance *pi)
+static void pvpanic_remove(void *param)
 {
 	struct pvpanic_instance *pi_cur, *pi_next;
+	struct pvpanic_instance *pi = param;
 
 	if (!pi)
 		return;
@@ -90,7 +78,19 @@ void pvpanic_remove(struct pvpanic_instance *pi)
 	}
 	spin_unlock(&pvpanic_lock);
 }
-EXPORT_SYMBOL_GPL(pvpanic_remove);
+
+int devm_pvpanic_probe(struct device *dev, struct pvpanic_instance *pi)
+{
+	if (!pi || !pi->base)
+		return -EINVAL;
+
+	spin_lock(&pvpanic_lock);
+	list_add(&pi->list, &pvpanic_list);
+	spin_unlock(&pvpanic_lock);
+
+	return devm_add_action_or_reset(dev, pvpanic_remove, pi);
+}
+EXPORT_SYMBOL_GPL(devm_pvpanic_probe);
 
 static int pvpanic_init(void)
 {
diff --git a/drivers/misc/pvpanic/pvpanic.h b/drivers/misc/pvpanic/pvpanic.h
index 1afccc2e9fec..493545951754 100644
--- a/drivers/misc/pvpanic/pvpanic.h
+++ b/drivers/misc/pvpanic/pvpanic.h
@@ -15,7 +15,6 @@ struct pvpanic_instance {
 	struct list_head list;
 };
 
-int pvpanic_probe(struct pvpanic_instance *pi);
-void pvpanic_remove(struct pvpanic_instance *pi);
+int devm_pvpanic_probe(struct device *dev, struct pvpanic_instance *pi);
 
 #endif /* PVPANIC_H_ */
-- 
2.30.2

