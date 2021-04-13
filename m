Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E1A35D60F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 05:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344425AbhDMDji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 23:39:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17320 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241739AbhDMDjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 23:39:32 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FKB9f5QcwzB024;
        Tue, 13 Apr 2021 11:36:54 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Tue, 13 Apr 2021
 11:39:02 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <alex.williamson@redhat.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, <liulongfang@huawei.com>
Subject: [RFC PATCH 2/3] vfio/hisilicon: register the driver to vfio
Date:   Tue, 13 Apr 2021 11:36:22 +0800
Message-ID: <1618284983-55581-3-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1618284983-55581-1-git-send-email-liulongfang@huawei.com>
References: <1618284983-55581-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register the live migration driver of the accelerator module to vfio

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/vfio/pci/vfio_pci.c         | 11 +++++++++++
 drivers/vfio/pci/vfio_pci_private.h |  9 +++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 65e7e6b..e1b0e37 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -407,6 +407,17 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
 		}
 	}
 
+	if (pdev->vendor == PCI_VENDOR_ID_HUAWEI &&
+	    IS_ENABLED(CONFIG_VFIO_PCI_HISI_MIGRATION)) {
+		ret = vfio_pci_hisilicon_acc_init(vdev);
+		if (ret && ret != -ENODEV) {
+			dev_warn(&vdev->pdev->dev,
+				 "Failed to setup Hisilicon ACC region\n");
+			vfio_pci_disable(vdev);
+			return ret;
+		}
+	}
+
 	vfio_pci_probe_mmaps(vdev);
 
 	return 0;
diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
index 9cd1882..83c51be 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -214,6 +214,15 @@ static inline int vfio_pci_ibm_npu2_init(struct vfio_pci_device *vdev)
 }
 #endif
 
+#ifdef CONFIG_VFIO_PCI_HISI_MIGRATION
+extern int vfio_pci_hisilicon_acc_init(struct vfio_pci_device *vdev);
+#else
+static inline int vfio_pci_hisilicon_acc_init(struct vfio_pci_device *vdev)
+{
+	return -ENODEV;
+}
+#endif
+
 #ifdef CONFIG_S390
 extern int vfio_pci_info_zdev_add_caps(struct vfio_pci_device *vdev,
 				       struct vfio_info_cap *caps);
-- 
2.8.1

