Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACEC308578
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 07:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhA2GFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 01:05:41 -0500
Received: from lpdvacalvio01.broadcom.com ([192.19.229.182]:50546 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231865AbhA2GFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 01:05:38 -0500
Received: from lbrmn-lnxub113.broadcom.net (lbrmn-lnxub113.ric.broadcom.net [10.136.13.65])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 586137DC2;
        Thu, 28 Jan 2021 22:04:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 586137DC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1611900286;
        bh=VdexXpEXeDnA6Pz6Z0Dj4BVYxUURgYzUdgGHUPcuhfo=;
        h=From:To:Cc:Subject:Date:From;
        b=YNAk2uEBCXgtpLRkKyNcv+fngqR+MudnGSz1AWEeYBAhH95xIpA6GTFWbCP1Q/+ka
         aZTKb6auyxVVubyyX4PozAKFw1b6ZZs/LGfkdU5Ml5mYpDFCf/QB/wVerAEdapj/Ns
         V0X47Gc7O7jZZE77XDj/Ojzg5eVBH4DtQ5RLVz5A=
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>,
        Desmond Yan <desmond.yan@broadcom.com>
Subject: [PATCH] misc: bcm-vk: only support ttyVK if CONFIG_TTY is set
Date:   Thu, 28 Jan 2021 22:04:43 -0800
Message-Id: <20210129060443.14864-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct compile issue if CONFIG_TTY is not set by
only adding ttyVK devices if CONFIG_TTY is set.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/misc/bcm-vk/Makefile     |  4 ++--
 drivers/misc/bcm-vk/bcm_vk_dev.c | 13 +++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/bcm-vk/Makefile b/drivers/misc/bcm-vk/Makefile
index e4a1486f7209..8d81a734fcad 100644
--- a/drivers/misc/bcm-vk/Makefile
+++ b/drivers/misc/bcm-vk/Makefile
@@ -7,6 +7,6 @@ obj-$(CONFIG_BCM_VK) += bcm_vk.o
 bcm_vk-objs := \
 	bcm_vk_dev.o \
 	bcm_vk_msg.o \
-	bcm_vk_sg.o \
-	bcm_vk_tty.o
+	bcm_vk_sg.o
 
+bcm_vk-$(CONFIG_TTY) += bcm_vk_tty.o
diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index c3d2bba68ef1..ae63fbdf14bc 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -525,7 +525,10 @@ void bcm_vk_blk_drv_access(struct bcm_vk *vk)
 			}
 		}
 	}
+
+#ifdef CONFIG_TTY
 	bcm_vk_tty_terminate_tty_user(vk);
+#endif
 	spin_unlock(&vk->ctx_lock);
 }
 
@@ -1385,6 +1388,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	vk->num_irqs++;
 
+#ifdef CONFIG_TTY
 	for (i = 0;
 	     (i < VK_MSIX_TTY_MAX) && (vk->num_irqs < irq);
 	     i++, vk->num_irqs++) {
@@ -1398,6 +1402,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 		vk->tty[i].irq_enabled = true;
 	}
+#endif
 
 	id = ida_simple_get(&bcm_vk_ida, 0, 0, GFP_KERNEL);
 	if (id < 0) {
@@ -1451,10 +1456,12 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_destroy_workqueue;
 	}
 
+#ifdef CONFIG_TTY
 	snprintf(name, sizeof(name), KBUILD_MODNAME ".%d_ttyVK", id);
 	err = bcm_vk_tty_init(vk, name);
 	if (err)
 		goto err_unregister_panic_notifier;
+#endif
 
 	/*
 	 * lets trigger an auto download.  We don't want to do it serially here
@@ -1480,9 +1487,11 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return 0;
 
 err_bcm_vk_tty_exit:
+#ifdef CONFIG_TTY
 	bcm_vk_tty_exit(vk);
 
 err_unregister_panic_notifier:
+#endif
 	atomic_notifier_chain_unregister(&panic_notifier_list,
 					 &vk->panic_nb);
 
@@ -1560,7 +1569,9 @@ static void bcm_vk_remove(struct pci_dev *pdev)
 					 &vk->panic_nb);
 
 	bcm_vk_msg_remove(vk);
+#ifdef CONFIG_TTY
 	bcm_vk_tty_exit(vk);
+#endif
 
 	if (vk->tdma_vaddr)
 		dma_free_coherent(&pdev->dev, nr_scratch_pages * PAGE_SIZE,
@@ -1580,8 +1591,10 @@ static void bcm_vk_remove(struct pci_dev *pdev)
 
 	cancel_work_sync(&vk->wq_work);
 	destroy_workqueue(vk->wq_thread);
+#ifdef CONFIG_TTY
 	cancel_work_sync(&vk->tty_wq_work);
 	destroy_workqueue(vk->tty_wq_thread);
+#endif
 
 	for (i = 0; i < MAX_BAR; i++) {
 		if (vk->bar[i])
-- 
2.17.1

