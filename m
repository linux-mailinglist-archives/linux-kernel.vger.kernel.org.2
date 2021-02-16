Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCB631CDA2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 17:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhBPQKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 11:10:38 -0500
Received: from mga18.intel.com ([134.134.136.126]:8286 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230131AbhBPQKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:10:16 -0500
IronPort-SDR: DbvhFxw88F5B67bSnGvCreXqGjwG7XydeP6baa9qu6jelMbeCPxev9S2wx9tPqYdX1M7MlLCGE
 NjOAmDZxnfMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="170591193"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="170591193"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 08:08:28 -0800
IronPort-SDR: L9eH/nvtmvBpcfvJIIDB8RBU2+zqBYitq1YungWzn2s1h07OuJBiZuF1VGa/6wJpLxGcwvExhx
 mwGmi2tudUuQ==
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="493336819"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 08:08:22 -0800
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: [PATCH v1 12/12] gna: add a char device
Date:   Tue, 16 Feb 2021 17:05:25 +0100
Message-Id: <20210216160525.5028-13-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com>
References: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Jankowski <tomasz1.jankowski@intel.com>

The new char device is the node for applications in user space to
interact with the driver.

Signed-off-by: Tomasz Jankowski <tomasz1.jankowski@intel.com>
Tested-by: Savo Novakovic <savox.novakovic@intel.com>
Co-developed-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Signed-off-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Co-developed-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Signed-off-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
---
 drivers/misc/gna/gna_device.c | 157 ++++++++++++++++++++++++++++++++++
 drivers/misc/gna/gna_driver.c |  23 ++++-
 2 files changed, 178 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/gna/gna_device.c b/drivers/misc/gna/gna_device.c
index 9faf0456fee2..7b2d3b4f863b 100644
--- a/drivers/misc/gna/gna_device.c
+++ b/drivers/misc/gna/gna_device.c
@@ -1,12 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // Copyright(c) 2017-2021 Intel Corporation
 
+#include <linux/cdev.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 
 #include "gna_device.h"
 #include "gna_driver.h"
 #include "gna_hw.h"
+#include "gna_ioctl.h"
 #include "gna_request.h"
 
 #define GNA_DEV_HWID_CNL	0x5A11
@@ -85,6 +87,150 @@ const struct pci_device_id gna_pci_ids[] = {
 
 MODULE_DEVICE_TABLE(pci, gna_pci_ids);
 
+static inline struct gna_private *inode_to_gna(struct inode *inode)
+{
+	return container_of(inode->i_cdev, struct gna_private, cdev);
+}
+
+static int gna_open(struct inode *inode, struct file *f)
+{
+	struct gna_file_private *file_priv;
+	struct gna_private *gna_priv;
+
+	gna_priv = inode_to_gna(inode);
+	if (!gna_priv)
+		return -ENODEV;
+
+	file_priv = kzalloc(sizeof(*file_priv), GFP_KERNEL);
+	if (!file_priv)
+		return -ENOMEM;
+
+	file_priv->fd = f;
+	file_priv->gna_priv = gna_priv;
+
+	mutex_init(&file_priv->memlist_lock);
+	INIT_LIST_HEAD(&file_priv->memory_list);
+
+	mutex_lock(&gna_priv->filelist_lock);
+	list_add_tail(&file_priv->flist, &gna_priv->file_list);
+	mutex_unlock(&gna_priv->filelist_lock);
+
+	f->private_data = file_priv;
+
+	return 0;
+}
+
+static int gna_release(struct inode *inode, struct file *f)
+{
+	struct gna_file_private *iter_file, *temp_file;
+	struct gna_memory_object *iter_mo, *temp_mo;
+	struct gna_file_private *file_priv;
+	struct gna_private *gna_priv;
+
+	gna_priv = inode_to_gna(inode);
+	if (!gna_priv)
+		return -ENODEV;
+
+	/* free all memory objects created by that file */
+	file_priv = (struct gna_file_private *)f->private_data;
+	mutex_lock(&file_priv->memlist_lock);
+	list_for_each_entry_safe(iter_mo, temp_mo, &file_priv->memory_list, file_mem_list) {
+		queue_work(gna_priv->request_wq, &iter_mo->work);
+		wait_event(iter_mo->waitq, true);
+		gna_memory_free(gna_priv, iter_mo);
+	}
+	mutex_unlock(&file_priv->memlist_lock);
+
+	gna_delete_file_requests(f, gna_priv);
+
+	/* delete itself from device's file list */
+	mutex_lock(&gna_priv->filelist_lock);
+	list_for_each_entry_safe(iter_file, temp_file, &gna_priv->file_list, flist) {
+		if (iter_file->fd == f) {
+			list_del(&iter_file->flist);
+			f->private_data = NULL;
+			kfree(iter_file);
+			break;
+		}
+	}
+	mutex_unlock(&gna_priv->filelist_lock);
+
+	return 0;
+}
+
+static const struct file_operations gna_file_ops = {
+	.owner		=	THIS_MODULE,
+	.open		=	gna_open,
+	.release	=	gna_release,
+	.unlocked_ioctl =	gna_ioctl,
+};
+
+/* Reverse gna_dev_create() */
+static void gna_dev_release(struct gna_private *gna_priv)
+{
+	cdev_device_del(&gna_priv->cdev, &gna_priv->dev);
+
+	mutex_lock(&gna_drv_priv.lock);
+	__clear_bit(MINOR(gna_priv->dev.devt), gna_drv_priv.dev_map);
+	mutex_unlock(&gna_drv_priv.lock);
+
+	dev_set_drvdata(&gna_priv->dev, NULL);
+}
+
+static int gna_dev_create(struct gna_private *gna_priv)
+{
+	struct pci_dev *pcidev;
+	struct device *dev;
+	dev_t gna_devt;
+	int dev_num;
+	int major;
+	int minor;
+	int ret;
+
+	pcidev = gna_priv->pdev;
+
+	mutex_lock(&gna_drv_priv.lock);
+
+	dev_num = find_first_zero_bit(gna_drv_priv.dev_map, GNA_MAX_DEVICES);
+	if (dev_num == GNA_MAX_DEVICES) {
+		mutex_unlock(&gna_drv_priv.lock);
+		dev_err(&pcidev->dev, "number of gna devices reached maximum\n");
+		return -ENODEV;
+	}
+
+	set_bit(dev_num, gna_drv_priv.dev_map);
+	major = MAJOR(gna_drv_priv.devt);
+	minor = gna_drv_priv.minor++;
+
+	mutex_unlock(&gna_drv_priv.lock);
+
+	gna_devt = MKDEV(major, minor);
+	dev = &gna_priv->dev;
+	device_initialize(dev);
+	dev->devt = gna_devt;
+	dev->class = gna_class;
+	dev->parent = gna_priv->parent;
+	dev->groups = NULL;
+	dev_set_drvdata(dev, gna_priv);
+	dev_set_name(dev, "gna%d", dev_num);
+
+	cdev_init(&gna_priv->cdev, &gna_file_ops);
+	gna_priv->cdev.owner = THIS_MODULE;
+
+	ret = cdev_device_add(&gna_priv->cdev, &gna_priv->dev);
+	if (ret) {
+		mutex_lock(&gna_drv_priv.lock);
+		__clear_bit(minor, gna_drv_priv.dev_map);
+		mutex_unlock(&gna_drv_priv.lock);
+		dev_err(&gna_priv->dev, "could not add gna%d char device\n", dev_num);
+	} else {
+		dev_info(&gna_priv->dev, "registered gna%d device: major %d, minor %d\n",
+			 dev_num, major, minor);
+	}
+
+	return ret;
+}
+
 static int gna_dev_init(struct gna_private *gna_priv, struct pci_dev *pcidev,
 			const struct pci_device_id *pci_id)
 {
@@ -133,8 +279,17 @@ static int gna_dev_init(struct gna_private *gna_priv, struct pci_dev *pcidev,
 	mutex_init(&gna_priv->reqlist_lock);
 	INIT_LIST_HEAD(&gna_priv->request_list);
 
+	ret = gna_dev_create(gna_priv);
+	if (ret) {
+		dev_err(&pcidev->dev, "could not create gna device\n");
+		goto err_del_wq;
+	}
+
 	return 0;
 
+err_del_wq:
+	destroy_workqueue(gna_priv->request_wq);
+
 err_pci_drvdata_unset:
 	pci_set_drvdata(pcidev, NULL);
 
@@ -244,6 +399,8 @@ void gna_remove(struct pci_dev *pcidev)
 
 	gna_priv = pci_get_drvdata(pcidev);
 
+	gna_dev_release(gna_priv);
+
 	free_irq(gna_priv->irq, gna_priv);
 
 	gna_dev_deinit(gna_priv);
diff --git a/drivers/misc/gna/gna_driver.c b/drivers/misc/gna/gna_driver.c
index cb638dfa81ac..5219a5408bc1 100644
--- a/drivers/misc/gna/gna_driver.c
+++ b/drivers/misc/gna/gna_driver.c
@@ -46,19 +46,38 @@ static int __init gna_drv_init(void)
 	}
 	gna_class->devnode = gna_devnode;
 
+	ret = alloc_chrdev_region(&gna_drv_priv.devt, 0, GNA_MAX_DEVICES, "gna");
+	if (ret) {
+		pr_err("could not get major number\n");
+		goto err_destroy_class;
+	}
+
+	pr_debug("major %d\n", MAJOR(gna_drv_priv.devt));
+	pr_debug("minor %d\n", MINOR(gna_drv_priv.devt));
+
+	gna_drv_priv.minor = MINOR(gna_drv_priv.devt);
+
 	ret = pci_register_driver(&gna_driver);
 	if (ret) {
 		pr_err("pci register driver failed\n");
-		class_destroy(gna_class);
-		return ret;
+		goto err_unreg_chdev;
 	}
 
 	return 0;
+
+err_unreg_chdev:
+	unregister_chrdev_region(gna_drv_priv.devt, GNA_MAX_DEVICES);
+
+err_destroy_class:
+	class_destroy(gna_class);
+
+	return ret;
 }
 
 static void __exit gna_drv_exit(void)
 {
 	pci_unregister_driver(&gna_driver);
+	unregister_chrdev_region(gna_drv_priv.devt, GNA_MAX_DEVICES);
 	class_destroy(gna_class);
 }
 
-- 
2.28.0

