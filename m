Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68EA30677B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbhA0XEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:04:24 -0500
Received: from mga12.intel.com ([192.55.52.136]:17428 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232638AbhA0W5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 17:57:25 -0500
IronPort-SDR: shQcyZk2ss09urZ6c6Krf28IJovUnDLpGXKRFwC6AyAkx/JQYsj50YpLsQyZuoB9HU6Mxv/0Xw
 0dsetBallQtw==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="159319080"
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="159319080"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 14:56:42 -0800
IronPort-SDR: Ri1ez2iYyvldB6S8R1AZ9UaAMf+RuDTScoZvDMOT2daXMI+4iM3pinJMhODw0hL8xm5vhtDM4B
 EqAZfdwH8u4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="388494231"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by orsmga008.jf.intel.com with ESMTP; 27 Jan 2021 14:56:42 -0800
From:   Mike Ximing Chen <mike.ximing.chen@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, pierre-louis.bossart@linux.intel.com,
        Gage Eads <gage.eads@intel.com>
Subject: [PATCH v10 02/20] dlb: initialize device
Date:   Wed, 27 Jan 2021 16:56:23 -0600
Message-Id: <20210127225641.1342-3-mike.ximing.chen@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20210127225641.1342-1-mike.ximing.chen@intel.com>
References: <20210127225641.1342-1-mike.ximing.chen@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign the physical function device 'ops' callbacks, map the PCI BAR space,
create a char device, set the DMA API mask for 64-bit addressing. Add the
corresponding undo operations to the remove callback.

The ops callbacks are implement behavior that differs depending on device
type -- physical function (PF, as implemented here) or virtual
function/device (support to be added later).

Signed-off-by: Gage Eads <gage.eads@intel.com>
Signed-off-by: Mike Ximing Chen <mike.ximing.chen@intel.com>
Reviewed-by: Magnus Karlsson <magnus.karlsson@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/misc/dlb/Makefile       |  1 +
 drivers/misc/dlb/dlb_hw_types.h | 23 +++++++++++++
 drivers/misc/dlb/dlb_main.c     | 59 +++++++++++++++++++++++++++++++++
 drivers/misc/dlb/dlb_main.h     | 14 ++++++++
 drivers/misc/dlb/dlb_pf_ops.c   | 50 ++++++++++++++++++++++++++++
 5 files changed, 147 insertions(+)
 create mode 100644 drivers/misc/dlb/dlb_pf_ops.c

diff --git a/drivers/misc/dlb/Makefile b/drivers/misc/dlb/Makefile
index 8911375effd2..a33bf774e6a8 100644
--- a/drivers/misc/dlb/Makefile
+++ b/drivers/misc/dlb/Makefile
@@ -7,3 +7,4 @@
 obj-$(CONFIG_INTEL_DLB) := dlb.o
 
 dlb-objs := dlb_main.o
+dlb-objs += dlb_pf_ops.o
diff --git a/drivers/misc/dlb/dlb_hw_types.h b/drivers/misc/dlb/dlb_hw_types.h
index 778ec8665ea0..a4ce28c157de 100644
--- a/drivers/misc/dlb/dlb_hw_types.h
+++ b/drivers/misc/dlb/dlb_hw_types.h
@@ -4,6 +4,20 @@
 #ifndef __DLB_HW_TYPES_H
 #define __DLB_HW_TYPES_H
 
+#include <linux/io.h>
+
+/* Read/write register 'reg' in the CSR BAR space */
+#define DLB_CSR_REG_ADDR(a, reg)   ((a)->csr_kva + (reg))
+#define DLB_CSR_RD(hw, reg)	    ioread32(DLB_CSR_REG_ADDR((hw), (reg)))
+#define DLB_CSR_WR(hw, reg, value) iowrite32((value), \
+					      DLB_CSR_REG_ADDR((hw), (reg)))
+
+/* Read/write register 'reg' in the func BAR space */
+#define DLB_FUNC_REG_ADDR(a, reg)   ((a)->func_kva + (reg))
+#define DLB_FUNC_RD(hw, reg)	     ioread32(DLB_FUNC_REG_ADDR((hw), (reg)))
+#define DLB_FUNC_WR(hw, reg, value) iowrite32((value), \
+					       DLB_FUNC_REG_ADDR((hw), (reg)))
+
 #define DLB_MAX_NUM_VDEVS			16
 #define DLB_MAX_NUM_DOMAINS			32
 #define DLB_MAX_NUM_LDB_QUEUES			32 /* LDB == load-balanced */
@@ -29,4 +43,13 @@
 
 #define PCI_DEVICE_ID_INTEL_DLB_PF		0x2710
 
+struct dlb_hw {
+	/* BAR 0 address */
+	void __iomem *csr_kva;
+	unsigned long csr_phys_addr;
+	/* BAR 2 address */
+	void __iomem *func_kva;
+	unsigned long func_phys_addr;
+};
+
 #endif /* __DLB_HW_TYPES_H */
diff --git a/drivers/misc/dlb/dlb_main.c b/drivers/misc/dlb/dlb_main.c
index fbd77203b398..7fb6e9c360c8 100644
--- a/drivers/misc/dlb/dlb_main.c
+++ b/drivers/misc/dlb/dlb_main.c
@@ -16,10 +16,38 @@ MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Intel(R) Dynamic Load Balancer (DLB) Driver");
 
 static struct class *dlb_class;
+static struct cdev dlb_cdev;
 static dev_t dlb_devt;
 static DEFINE_IDR(dlb_ids);
 static DEFINE_SPINLOCK(dlb_ids_lock);
 
+static int dlb_device_create(struct dlb *dlb, struct pci_dev *pdev)
+{
+	/*
+	 * Create a new device in order to create a /dev/dlb node. This device
+	 * is a child of the DLB PCI device.
+	 */
+	dlb->dev_number = MKDEV(MAJOR(dlb_devt), dlb->id);
+	dlb->dev = device_create(dlb_class, &pdev->dev, dlb->dev_number, dlb,
+				 "dlb%d", dlb->id);
+	if (IS_ERR(dlb->dev)) {
+		dev_err(dlb->dev, "device_create() returned %ld\n",
+			PTR_ERR(dlb->dev));
+
+		return PTR_ERR(dlb->dev);
+	}
+
+	return 0;
+}
+
+/********************************/
+/****** Char dev callbacks ******/
+/********************************/
+
+static const struct file_operations dlb_fops = {
+	.owner   = THIS_MODULE,
+};
+
 /**********************************/
 /****** PCI driver callbacks ******/
 /**********************************/
@@ -33,6 +61,8 @@ static int dlb_probe(struct pci_dev *pdev, const struct pci_device_id *pdev_id)
 	if (!dlb)
 		return -ENOMEM;
 
+	dlb->ops = &dlb_pf_ops;
+
 	pci_set_drvdata(pdev, dlb);
 
 	dlb->pdev = pdev;
@@ -71,8 +101,24 @@ static int dlb_probe(struct pci_dev *pdev, const struct pci_device_id *pdev_id)
 	if (ret != 0)
 		dev_info(&pdev->dev, "Failed to enable AER %d\n", ret);
 
+	ret = dlb->ops->map_pci_bar_space(dlb, pdev);
+	if (ret)
+		goto map_pci_bar_fail;
+
+	ret = dlb_device_create(dlb, pdev);
+	if (ret)
+		goto map_pci_bar_fail;
+
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (ret)
+		goto dma_set_mask_fail;
+
 	return 0;
 
+dma_set_mask_fail:
+	device_destroy(dlb_class, dlb->dev_number);
+map_pci_bar_fail:
+	pci_disable_pcie_error_reporting(pdev);
 pci_enable_device_fail:
 	spin_lock(&dlb_ids_lock);
 	idr_remove(&dlb_ids, dlb->id);
@@ -85,6 +131,8 @@ static void dlb_remove(struct pci_dev *pdev)
 {
 	struct dlb *dlb = pci_get_drvdata(pdev);
 
+	device_destroy(dlb_class, dlb->dev_number);
+
 	pci_disable_pcie_error_reporting(pdev);
 
 	spin_lock(&dlb_ids_lock);
@@ -107,6 +155,7 @@ static struct pci_driver dlb_pci_driver = {
 
 static int __init dlb_init_module(void)
 {
+	int dlb_major;
 	int err;
 
 	dlb_class = class_create(THIS_MODULE, "dlb");
@@ -126,6 +175,12 @@ static int __init dlb_init_module(void)
 		goto alloc_chrdev_fail;
 	}
 
+	dlb_major = MAJOR(dlb_devt);
+	cdev_init(&dlb_cdev, &dlb_fops);
+	err = cdev_add(&dlb_cdev, MKDEV(dlb_major, 0), DLB_MAX_NUM_DEVICES);
+	if (err)
+		goto cdev_add_fail;
+
 	err = pci_register_driver(&dlb_pci_driver);
 	if (err < 0) {
 		pr_err("dlb: pci_register_driver() returned %d\n", err);
@@ -136,6 +191,8 @@ static int __init dlb_init_module(void)
 	return 0;
 
 pci_register_fail:
+	cdev_del(&dlb_cdev);
+cdev_add_fail:
 	unregister_chrdev_region(dlb_devt, DLB_MAX_NUM_DEVICES);
 alloc_chrdev_fail:
 	class_destroy(dlb_class);
@@ -147,6 +204,8 @@ static void __exit dlb_exit_module(void)
 {
 	pci_unregister_driver(&dlb_pci_driver);
 
+	cdev_del(&dlb_cdev);
+
 	unregister_chrdev_region(dlb_devt, DLB_MAX_NUM_DEVICES);
 
 	class_destroy(dlb_class);
diff --git a/drivers/misc/dlb/dlb_main.h b/drivers/misc/dlb/dlb_main.h
index ab2a2014bafd..21570b206419 100644
--- a/drivers/misc/dlb/dlb_main.h
+++ b/drivers/misc/dlb/dlb_main.h
@@ -29,9 +29,23 @@ enum dlb_device_type {
 	DLB_PF,
 };
 
+struct dlb;
+
+struct dlb_device_ops {
+	int (*map_pci_bar_space)(struct dlb *dlb, struct pci_dev *pdev);
+	void (*unmap_pci_bar_space)(struct dlb *dlb, struct pci_dev *pdev);
+};
+
+extern struct dlb_device_ops dlb_pf_ops;
+
 struct dlb {
 	struct pci_dev *pdev;
+	struct dlb_hw hw;
+	struct dlb_device_ops *ops;
+	struct device *dev;
+	enum dlb_device_type type;
 	int id;
+	dev_t dev_number;
 };
 
 #endif /* __DLB_MAIN_H */
diff --git a/drivers/misc/dlb/dlb_pf_ops.c b/drivers/misc/dlb/dlb_pf_ops.c
new file mode 100644
index 000000000000..0951c99f6183
--- /dev/null
+++ b/drivers/misc/dlb/dlb_pf_ops.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(C) 2016-2020 Intel Corporation. All rights reserved. */
+
+#include "dlb_main.h"
+
+/********************************/
+/****** PCI BAR management ******/
+/********************************/
+
+static void
+dlb_pf_unmap_pci_bar_space(struct dlb *dlb, struct pci_dev *pdev)
+{
+	pcim_iounmap(pdev, dlb->hw.csr_kva);
+	pcim_iounmap(pdev, dlb->hw.func_kva);
+}
+
+static int
+dlb_pf_map_pci_bar_space(struct dlb *dlb, struct pci_dev *pdev)
+{
+	dlb->hw.func_kva = pcim_iomap_table(pdev)[DLB_FUNC_BAR];
+	dlb->hw.func_phys_addr = pci_resource_start(pdev, DLB_FUNC_BAR);
+
+	if (!dlb->hw.func_kva) {
+		dev_err(&pdev->dev, "Cannot iomap BAR 0 (size %llu)\n",
+			pci_resource_len(pdev, 0));
+
+		return -EIO;
+	}
+
+	dlb->hw.csr_kva = pcim_iomap_table(pdev)[DLB_CSR_BAR];
+	dlb->hw.csr_phys_addr = pci_resource_start(pdev, DLB_CSR_BAR);
+
+	if (!dlb->hw.csr_kva) {
+		dev_err(&pdev->dev, "Cannot iomap BAR 2 (size %llu)\n",
+			pci_resource_len(pdev, 2));
+
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/********************************/
+/****** DLB PF Device Ops ******/
+/********************************/
+
+struct dlb_device_ops dlb_pf_ops = {
+	.map_pci_bar_space = dlb_pf_map_pci_bar_space,
+	.unmap_pci_bar_space = dlb_pf_unmap_pci_bar_space,
+};
-- 
2.17.1

