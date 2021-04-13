Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33E335D4C0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 03:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243929AbhDMBXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 21:23:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17316 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238132AbhDMBX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 21:23:28 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FK78h1kP5z9yyN;
        Tue, 13 Apr 2021 09:20:52 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Tue, 13 Apr 2021
 09:22:58 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <alex.williamson@redhat.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, <liulongfang@huawei.com>
Subject: [RFC PATCH 2/3] vfio/hisilicon: register the driver to vfio
Date:   Tue, 13 Apr 2021 09:20:20 +0800
Message-ID: <1618276821-8320-3-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1618276821-8320-1-git-send-email-liulongfang@huawei.com>
References: <1618276821-8320-1-git-send-email-liulongfang@huawei.com>
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
 drivers/vfio/pci/vfio_pci_private.h | 10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index f041b1a..50d1138 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -293,6 +293,17 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
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
index f561ac1..74bb611 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -138,4 +138,14 @@ static inline int vfio_pci_igd_init(struct vfio_pci_device *vdev)
 	return -ENODEV;
 }
 #endif
+
+#ifdef CONFIG_VFIO_PCI_HISI_MIGRATION
+extern int vfio_pci_hisilicon_acc_init(struct vfio_pci_device *vdev);
+#else
+static inline int vfio_pci_hisilicon_acc_init(struct vfio_pci_device *vdev)
+{
+	return -ENODEV;
+}
+#endif
+
 #endif /* VFIO_PCI_PRIVATE_H */
-- 
2.8.1

