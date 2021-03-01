Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F493281D6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbhCAPJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236846AbhCAPIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:08:04 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E1EC06178C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 07:07:24 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lGk8l-00AJOK-HL; Mon, 01 Mar 2021 16:07:19 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-um@lists.infradead.org
Cc:     Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 8/8] um: virtio/pci: enable suspend/resume
Date:   Mon,  1 Mar 2021 16:07:08 +0100
Message-Id: <20210301160501.19e6e5378a97.I2e9caf8b2083e2a8d0c76799179db35d08032aa1@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210301150708.244970-1-johannes@sipsolutions.net>
References: <20210301150708.244970-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The UM virtual PCI devices currently cannot be suspended properly
since the virtio driver already disables VQs well before the PCI
bus's suspend_noirq wants to complete the transition by writing to
PCI config space.

After trying around for a long time with moving the devices on the
DPM list, trying to create dependencies between them, etc. I gave
up and instead added UML specific cross-driver API that lets the
virt-pci code enable not suspending/resuming VQs for its devices.

This then allows the PCI bus suspend_noirq to still talk to the
device, and suspend/resume works properly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/virt-pci.c         | 10 ++++++++
 arch/um/drivers/virtio_uml.c       | 40 ++++++++++++++++++++++--------
 arch/um/include/linux/virtio-uml.h | 13 ++++++++++
 3 files changed, 53 insertions(+), 10 deletions(-)
 create mode 100644 arch/um/include/linux/virtio-uml.h

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index dd85f36197aa..0b802834f40a 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -10,6 +10,7 @@
 #include <linux/logic_iomem.h>
 #include <linux/irqdomain.h>
 #include <linux/virtio_pcidev.h>
+#include <linux/virtio-uml.h>
 #include <linux/delay.h>
 #include <linux/msi.h>
 #include <asm/unaligned.h>
@@ -134,6 +135,9 @@ static int um_pci_send_cmd(struct um_pci_device *dev,
 		if (completed == HANDLE_NO_FREE(cmd))
 			break;
 
+		if (completed && !HANDLE_IS_NO_FREE(completed))
+			kfree(completed);
+
 		if (WARN_ONCE(virtqueue_is_broken(dev->cmd_vq) ||
 			      ++delay_count > UM_VIRT_PCI_MAXDELAY,
 			      "um virt-pci delay: %d", delay_count)) {
@@ -550,6 +554,12 @@ static int um_pci_virtio_probe(struct virtio_device *vdev)
 
 	device_set_wakeup_enable(&vdev->dev, true);
 
+	/*
+	 * In order to do suspend-resume properly, don't allow VQs
+	 * to be suspended.
+	 */
+	virtio_uml_set_no_vq_suspend(vdev, true);
+
 	um_pci_rescan();
 	return 0;
 error:
diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 91ddf74ca888..4412d6febade 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -56,6 +56,7 @@ struct virtio_uml_device {
 	u8 status;
 	u8 registered:1;
 	u8 suspended:1;
+	u8 no_vq_suspend:1;
 
 	u8 config_changed_irq:1;
 	uint64_t vq_irq_vq_map;
@@ -1098,6 +1099,19 @@ static void virtio_uml_release_dev(struct device *d)
 	kfree(vu_dev);
 }
 
+void virtio_uml_set_no_vq_suspend(struct virtio_device *vdev,
+				  bool no_vq_suspend)
+{
+	struct virtio_uml_device *vu_dev = to_virtio_uml_device(vdev);
+
+	if (WARN_ON(vdev->config != &virtio_uml_config_ops))
+		return;
+
+	vu_dev->no_vq_suspend = no_vq_suspend;
+	dev_info(&vdev->dev, "%sabled VQ suspend\n",
+		 no_vq_suspend ? "dis" : "en");
+}
+
 /* Platform device */
 
 static int virtio_uml_probe(struct platform_device *pdev)
@@ -1302,13 +1316,16 @@ MODULE_DEVICE_TABLE(of, virtio_uml_match);
 static int virtio_uml_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct virtio_uml_device *vu_dev = platform_get_drvdata(pdev);
-	struct virtqueue *vq;
 
-	virtio_device_for_each_vq((&vu_dev->vdev), vq) {
-		struct virtio_uml_vq_info *info = vq->priv;
+	if (!vu_dev->no_vq_suspend) {
+		struct virtqueue *vq;
 
-		info->suspended = true;
-		vhost_user_set_vring_enable(vu_dev, vq->index, false);
+		virtio_device_for_each_vq((&vu_dev->vdev), vq) {
+			struct virtio_uml_vq_info *info = vq->priv;
+
+			info->suspended = true;
+			vhost_user_set_vring_enable(vu_dev, vq->index, false);
+		}
 	}
 
 	if (!device_may_wakeup(&vu_dev->vdev.dev)) {
@@ -1322,13 +1339,16 @@ static int virtio_uml_suspend(struct platform_device *pdev, pm_message_t state)
 static int virtio_uml_resume(struct platform_device *pdev)
 {
 	struct virtio_uml_device *vu_dev = platform_get_drvdata(pdev);
-	struct virtqueue *vq;
 
-	virtio_device_for_each_vq((&vu_dev->vdev), vq) {
-		struct virtio_uml_vq_info *info = vq->priv;
+	if (!vu_dev->no_vq_suspend) {
+		struct virtqueue *vq;
+
+		virtio_device_for_each_vq((&vu_dev->vdev), vq) {
+			struct virtio_uml_vq_info *info = vq->priv;
 
-		info->suspended = false;
-		vhost_user_set_vring_enable(vu_dev, vq->index, true);
+			info->suspended = false;
+			vhost_user_set_vring_enable(vu_dev, vq->index, true);
+		}
 	}
 
 	vu_dev->suspended = false;
diff --git a/arch/um/include/linux/virtio-uml.h b/arch/um/include/linux/virtio-uml.h
new file mode 100644
index 000000000000..2f652fa90f04
--- /dev/null
+++ b/arch/um/include/linux/virtio-uml.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2021 Intel Corporation
+ * Author: Johannes Berg <johannes@sipsolutions.net>
+ */
+
+#ifndef __VIRTIO_UML_H__
+#define __VIRTIO_UML_H__
+
+void virtio_uml_set_no_vq_suspend(struct virtio_device *vdev,
+				  bool no_vq_suspend);
+
+#endif /* __VIRTIO_UML_H__ */
-- 
2.26.2

