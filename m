Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD2835C036
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 11:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241094AbhDLJLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:11:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15665 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238423AbhDLI4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 04:56:23 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FJjF26PsKznZBh;
        Mon, 12 Apr 2021 16:53:10 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Mon, 12 Apr 2021
 16:55:52 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <alex.williamson@redhar.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, <liulongfang@huawei.com>
Subject: [RFC PATCH 2/3] vfio/hisilicon: register the driver to vfio
Date:   Mon, 12 Apr 2021 16:53:15 +0800
Message-ID: <1618217596-13621-3-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1618217596-13621-1-git-send-email-liulongfang@huawei.com>
References: <1618217596-13621-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register the live migration driver of the accelerator module to vfio

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
Reviewed-by: Zengtao <prime.zeng@hisilicon.com>
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

