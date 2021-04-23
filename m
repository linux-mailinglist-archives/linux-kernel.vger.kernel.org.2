Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C983696C9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 18:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhDWQTl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Apr 2021 12:19:41 -0400
Received: from mail.savoirfairelinux.com ([208.88.110.44]:54818 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhDWQTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 12:19:39 -0400
X-Greylist: delayed 511 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Apr 2021 12:19:39 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id A3B019C225E;
        Fri, 23 Apr 2021 12:10:30 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
        by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id XG_rFHhL8pfK; Fri, 23 Apr 2021 12:10:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id 243769C23BA;
        Fri, 23 Apr 2021 12:10:30 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
        by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Y8oj36qeAhEC; Fri, 23 Apr 2021 12:10:30 -0400 (EDT)
Received: from barbarian (unknown [192.168.51.254])
        by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 040489C225E;
        Fri, 23 Apr 2021 12:10:30 -0400 (EDT)
Message-ID: <b9598838a77c156a88b2847f43c3a276c340de04.camel@savoirfairelinux.com>
Subject: uio: uio_pci_generic: add missing memory mappings
From:   firas ashkar <firas.ashkar@savoirfairelinux.com>
To:     mst@redhat.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Date:   Fri, 23 Apr 2021 12:10:29 -0400
Organization: SavoirFaireLinux
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
pls find attached a trivial but necessary patch, this change is based on [drivers/uio/uio_pdrv_genirq.c], 
the patch was tested on following hardware: MiniPCIE AltaData ARNIC-429 module on imx8qm-apalis-ixora-v1.2

-- 
Firas Ashkar
Developpeur Système Embarqué

savoirfairelinux.com  | Montréal, Québec

Tél.: +1 514 276 5468 ext. 118
--------------------------------------

From 0c83bbc8bbf6c45efc52f6d30b8302a5d9075198 Mon Sep 17 00:00:00 2001
From: Firas Ashkar <firas.ashkar@savoirfairelinux.com>
Date: Fri, 23 Apr 2021 10:38:28 -0400
Subject: [PATCH 1/1] uio: uio_pci_generic: add memory mappings

import memory resources from underlaying pci device, thus allowing
userspace applications to memory map those resources.
---
 drivers/uio/uio_pci_generic.c | 52 +++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/drivers/uio/uio_pci_generic.c
b/drivers/uio/uio_pci_generic.c
index c7d681fef198..809eca95b5bb 100644
--- a/drivers/uio/uio_pci_generic.c
+++ b/drivers/uio/uio_pci_generic.c
@@ -24,9 +24,9 @@
 #include <linux/slab.h>
 #include <linux/uio_driver.h>
 
-#define DRIVER_VERSION	"0.01.0"
-#define DRIVER_AUTHOR	"Michael S. Tsirkin <mst@redhat.com>"
-#define DRIVER_DESC	"Generic UIO driver for PCI 2.3 devices"
+#define DRIVER_VERSION "0.01.0"
+#define DRIVER_AUTHOR "Michael S. Tsirkin <mst@redhat.com>"
+#define DRIVER_DESC "Generic UIO driver for PCI 2.3 devices"
 
 struct uio_pci_generic_dev {
 	struct uio_info info;
@@ -56,7 +56,8 @@ static int release(struct uio_info *info, struct
inode *inode)
 }
 
 /* Interrupt handler. Read/modify/write the command register to
disable
- * the interrupt. */
+ * the interrupt.
+ */
 static irqreturn_t irqhandler(int irq, struct uio_info *info)
 {
 	struct uio_pci_generic_dev *gdev =
to_uio_pci_generic_dev(info);
@@ -68,11 +69,12 @@ static irqreturn_t irqhandler(int irq, struct
uio_info *info)
 	return IRQ_HANDLED;
 }
 
-static int probe(struct pci_dev *pdev,
-			   const struct pci_device_id *id)
+static int probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct uio_pci_generic_dev *gdev;
+	struct uio_mem *uiomem;
 	int err;
+	int i;
 
 	err = pcim_enable_device(pdev);
 	if (err) {
@@ -84,7 +86,8 @@ static int probe(struct pci_dev *pdev,
 	if (pdev->irq && !pci_intx_mask_supported(pdev))
 		return -ENOMEM;
 
-	gdev = devm_kzalloc(&pdev->dev, sizeof(struct
uio_pci_generic_dev), GFP_KERNEL);
+	gdev = devm_kzalloc(&pdev->dev, sizeof(struct
uio_pci_generic_dev),
+			    GFP_KERNEL);
 	if (!gdev)
 		return -ENOMEM;
 
@@ -97,8 +100,39 @@ static int probe(struct pci_dev *pdev,
 		gdev->info.irq_flags = IRQF_SHARED;
 		gdev->info.handler = irqhandler;
 	} else {
-		dev_warn(&pdev->dev, "No IRQ assigned to device: "
-			 "no support for interrupts?\n");
+		dev_warn(
+			&pdev->dev,
+			"No IRQ assigned to device: no support for
interrupts?\n");
+	}
+
+	uiomem = &gdev->info.mem[0];
+	for (i = 0; i < MAX_UIO_MAPS; ++i) {
+		struct resource *r = &pdev->resource[i];
+
+		if (r->flags != (IORESOURCE_SIZEALIGN |
IORESOURCE_MEM))
+			continue;
+
+		if (uiomem >= &gdev->info.mem[MAX_UIO_MAPS]) {
+			dev_warn(
+				&pdev->dev,
+				"device has more than " __stringify(
+					MAX_UIO_MAPS) " I/O memory
resources.\n");
+			break;
+		}
+
+		uiomem->memtype = UIO_MEM_PHYS;
+		uiomem->addr = r->start & PAGE_MASK;
+		uiomem->offs = r->start & ~PAGE_MASK;
+		uiomem->size =
+			(uiomem->offs + resource_size(r) + PAGE_SIZE -
1) &
+			PAGE_MASK;
+		uiomem->name = r->name;
+		++uiomem;
+	}
+
+	while (uiomem < &gdev->info.mem[MAX_UIO_MAPS]) {
+		uiomem->size = 0;
+		++uiomem;
 	}
 
 	return devm_uio_register_device(&pdev->dev, &gdev->info);
-- 
2.25.1



          

