Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A374039AB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 14:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351722AbhIHMW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 08:22:56 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:34492 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235143AbhIHMWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:22:55 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UnhbUrf_1631103655;
Received: from localhost.localdomain(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0UnhbUrf_1631103655)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 Sep 2021 20:21:06 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     wuzongyong@linux.alibaba.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com
Cc:     wei.yang1@linux.alibaba.com
Subject: [PATCH 4/6] vp_vdpa: split out reusable and device specific codes to separate file
Date:   Wed,  8 Sep 2021 20:20:35 +0800
Message-Id: <ba9c3b9c44ebfd658a8efc80768307ca5ece7e9c.1631101392.git.wuzongyong@linux.alibaba.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split out codes that can be reused later for legacy virtio-pci devices
to vp_vdpa_common.{h,c} files. And move modern device specific codes to
vp_vdpa_modern.c file.

Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
---
 drivers/vdpa/virtio_pci/Makefile         |   2 +
 drivers/vdpa/virtio_pci/vp_vdpa_common.c | 215 +++++++++++++++
 drivers/vdpa/virtio_pci/vp_vdpa_common.h |  56 ++++
 drivers/vdpa/virtio_pci/vp_vdpa_modern.c | 327 +++++++++++++++++++++++
 4 files changed, 600 insertions(+)
 create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa_common.c
 create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa_common.h
 create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa_modern.c

diff --git a/drivers/vdpa/virtio_pci/Makefile b/drivers/vdpa/virtio_pci/Makefile
index 231088d3af7d..a772d86952b1 100644
--- a/drivers/vdpa/virtio_pci/Makefile
+++ b/drivers/vdpa/virtio_pci/Makefile
@@ -1,2 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
+
+vp_vdpa-y += vp_vdpa_common.o vp_vdpa_modern.o
 obj-$(CONFIG_VP_VDPA) += vp_vdpa.o
diff --git a/drivers/vdpa/virtio_pci/vp_vdpa_common.c b/drivers/vdpa/virtio_pci/vp_vdpa_common.c
new file mode 100644
index 000000000000..3ff24c9ad6e4
--- /dev/null
+++ b/drivers/vdpa/virtio_pci/vp_vdpa_common.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * vDPA bridge driver for modern virtio-pci device
+ *
+ * Copyright (c) 2020, Red Hat Inc. All rights reserved.
+ * Author: Jason Wang <jasowang@redhat.com>
+ *
+ * Based on virtio_pci_modern.c.
+ */
+
+#include <linux/irqreturn.h>
+#include <linux/interrupt.h>
+#include "vp_vdpa_common.h"
+
+int vp_vdpa_get_vq_irq(struct vdpa_device *vdev, u16 idx)
+{
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdev);
+
+	return vp_vdpa->vring[idx].irq;
+}
+
+void vp_vdpa_free_irq(struct vp_vdpa *vp_vdpa)
+{
+	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
+	struct pci_dev *pdev = mdev->pci_dev;
+	int i;
+
+	for (i = 0; i < vp_vdpa->queues; i++) {
+		if (vp_vdpa->vring[i].irq != VIRTIO_MSI_NO_VECTOR) {
+			vp_modern_queue_vector(mdev, i, VIRTIO_MSI_NO_VECTOR);
+			devm_free_irq(&pdev->dev, vp_vdpa->vring[i].irq,
+				      &vp_vdpa->vring[i]);
+			vp_vdpa->vring[i].irq = VIRTIO_MSI_NO_VECTOR;
+		}
+	}
+
+	if (vp_vdpa->config_irq != VIRTIO_MSI_NO_VECTOR) {
+		vp_modern_config_vector(mdev, VIRTIO_MSI_NO_VECTOR);
+		devm_free_irq(&pdev->dev, vp_vdpa->config_irq, vp_vdpa);
+		vp_vdpa->config_irq = VIRTIO_MSI_NO_VECTOR;
+	}
+
+	if (vp_vdpa->vectors) {
+		pci_free_irq_vectors(pdev);
+		vp_vdpa->vectors = 0;
+	}
+}
+
+static irqreturn_t vp_vdpa_vq_handler(int irq, void *arg)
+{
+	struct vp_vring *vring = arg;
+
+	if (vring->cb.callback)
+		return vring->cb.callback(vring->cb.private);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t vp_vdpa_config_handler(int irq, void *arg)
+{
+	struct vp_vdpa *vp_vdpa = arg;
+
+	if (vp_vdpa->config_cb.callback)
+		return vp_vdpa->config_cb.callback(vp_vdpa->config_cb.private);
+
+	return IRQ_HANDLED;
+}
+
+int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
+{
+	struct pci_dev *pdev = vp_vdpa->pci_dev;
+	int i, ret, irq;
+	int queues = vp_vdpa->queues;
+	int vectors = queues + 1;
+
+	ret = pci_alloc_irq_vectors(pdev, vectors, vectors, PCI_IRQ_MSIX);
+	if (ret != vectors) {
+		dev_err(&pdev->dev,
+			"vp_vdpa: fail to allocate irq vectors want %d but %d\n",
+			vectors, ret);
+		return ret;
+	}
+
+	vp_vdpa->vectors = vectors;
+
+	for (i = 0; i < queues; i++) {
+		snprintf(vp_vdpa->vring[i].msix_name, VP_VDPA_NAME_SIZE,
+			"vp-vdpa[%s]-%d\n", pci_name(pdev), i);
+		irq = pci_irq_vector(pdev, i);
+		ret = devm_request_irq(&pdev->dev, irq,
+				       vp_vdpa_vq_handler,
+				       0, vp_vdpa->vring[i].msix_name,
+				       &vp_vdpa->vring[i]);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"vp_vdpa: fail to request irq for vq %d\n", i);
+			goto err;
+		}
+		vp_vdpa->queue_vector(vp_vdpa, i, i);
+		vp_vdpa->vring[i].irq = irq;
+	}
+
+	snprintf(vp_vdpa->msix_name, VP_VDPA_NAME_SIZE, "vp-vdpa[%s]-config\n",
+		 pci_name(pdev));
+	irq = pci_irq_vector(pdev, queues);
+	ret = devm_request_irq(&pdev->dev, irq,	vp_vdpa_config_handler, 0,
+			       vp_vdpa->msix_name, vp_vdpa);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"vp_vdpa: fail to request irq for vq %d\n", i);
+			goto err;
+	}
+	vp_vdpa->config_vector(vp_vdpa, queues);
+	vp_vdpa->config_irq = irq;
+
+	return 0;
+err:
+	vp_vdpa_free_irq(vp_vdpa);
+	return ret;
+}
+
+int vp_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 qid,
+			struct vdpa_vq_state *state)
+{
+	/* Note that this is not supported by virtio specification, so
+	 * we return -EOPNOTSUPP here. This means we can't support live
+	 * migration, vhost device start/stop.
+	 */
+	return -EOPNOTSUPP;
+}
+
+void vp_vdpa_set_vq_cb(struct vdpa_device *vdpa, u16 qid,
+			struct vdpa_callback *cb)
+{
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
+
+	vp_vdpa->vring[qid].cb = *cb;
+}
+
+void vp_vdpa_kick_vq(struct vdpa_device *vdpa, u16 qid)
+{
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
+
+	vp_iowrite16(qid, vp_vdpa->vring[qid].notify);
+}
+
+u32 vp_vdpa_get_vq_align(struct vdpa_device *vdpa)
+{
+	return PAGE_SIZE;
+}
+
+void vp_vdpa_set_config_cb(struct vdpa_device *vdpa,
+				  struct vdpa_callback *cb)
+{
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
+
+	vp_vdpa->config_cb = *cb;
+}
+
+void vp_vdpa_free_irq_vectors(void *data)
+{
+	pci_free_irq_vectors(data);
+}
+
+static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct vp_vdpa *vp_vdpa;
+	int ret;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	vp_vdpa = vp_vdpa_modern_probe(pdev);
+	if (IS_ERR(vp_vdpa))
+		return PTR_ERR(vp_vdpa);
+
+	vp_vdpa->pci_dev = pdev;
+
+	pci_set_master(pdev);
+
+	ret = vdpa_register_device(&vp_vdpa->vdpa, vp_vdpa->queues);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register to vdpa bus\n");
+		goto err;
+	}
+
+	return 0;
+
+err:
+	put_device(&vp_vdpa->vdpa.dev);
+	return ret;
+}
+
+static void vp_vdpa_remove(struct pci_dev *pdev)
+{
+	struct vp_vdpa *vp_vdpa = pci_get_drvdata(pdev);
+
+	vdpa_unregister_device(&vp_vdpa->vdpa);
+	vp_modern_remove(&vp_vdpa->mdev);
+}
+
+static struct pci_driver vp_vdpa_driver = {
+	.name		= "vp-vdpa",
+	.id_table	= NULL, /* only dynamic ids */
+	.probe		= vp_vdpa_probe,
+	.remove		= vp_vdpa_remove,
+};
+
+module_pci_driver(vp_vdpa_driver);
+
+MODULE_AUTHOR("Jason Wang <jasowang@redhat.com>");
+MODULE_DESCRIPTION("vp-vdpa");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("1");
diff --git a/drivers/vdpa/virtio_pci/vp_vdpa_common.h b/drivers/vdpa/virtio_pci/vp_vdpa_common.h
new file mode 100644
index 000000000000..57886b55a2e9
--- /dev/null
+++ b/drivers/vdpa/virtio_pci/vp_vdpa_common.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _DRIVERS_VDPA_VIRTIO_PCI_VP_VDPA_COMMON_H
+#define _DRIVERS_VDPA_VIRTIO_PCI_VP_VDPA_COMMON_H
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/vdpa.h>
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_ring.h>
+#include <linux/virtio_pci.h>
+#include <linux/virtio_pci_modern.h>
+
+#define VP_VDPA_DRIVER_NAME "vp_vdpa"
+#define VP_VDPA_NAME_SIZE 256
+
+struct vp_vring {
+	void __iomem *notify;
+	char msix_name[VP_VDPA_NAME_SIZE];
+	struct vdpa_callback cb;
+	resource_size_t notify_pa;
+	int irq;
+};
+
+struct vp_vdpa {
+	struct vdpa_device vdpa;
+	struct pci_dev *pci_dev;
+	struct virtio_pci_modern_device mdev;
+	struct vp_vring *vring;
+	struct vdpa_callback config_cb;
+	char msix_name[VP_VDPA_NAME_SIZE];
+	int config_irq;
+	int queues;
+	int vectors;
+	u16 (*queue_vector)(struct vp_vdpa *vp_vdpa, u16 idx, u16 vector);
+	u16 (*config_vector)(struct vp_vdpa *vp_vdpa, u16 vector);
+};
+
+static struct vp_vdpa *vdpa_to_vp(struct vdpa_device *vdpa)
+{
+	return container_of(vdpa, struct vp_vdpa, vdpa);
+}
+
+int vp_vdpa_get_vq_irq(struct vdpa_device *vdev, u16 idx);
+void vp_vdpa_free_irq(struct vp_vdpa *vp_vdpa);
+int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa);
+int vp_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 qid, struct vdpa_vq_state *state);
+void vp_vdpa_set_vq_cb(struct vdpa_device *vdpa, u16 qid, struct vdpa_callback *cb);
+void vp_vdpa_kick_vq(struct vdpa_device *vdpa, u16 qid);
+u32 vp_vdpa_get_vq_align(struct vdpa_device *vdpa);
+void vp_vdpa_set_config_cb(struct vdpa_device *vdpa, struct vdpa_callback *cb);
+void vp_vdpa_free_irq_vectors(void *data);
+
+struct vp_vdpa *vp_vdpa_modern_probe(struct pci_dev *pdev);
+
+#endif
diff --git a/drivers/vdpa/virtio_pci/vp_vdpa_modern.c b/drivers/vdpa/virtio_pci/vp_vdpa_modern.c
new file mode 100644
index 000000000000..13b66edbb27a
--- /dev/null
+++ b/drivers/vdpa/virtio_pci/vp_vdpa_modern.c
@@ -0,0 +1,327 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * vDPA bridge driver for modern virtio-pci device
+ *
+ * Copyright (c) 2020, Red Hat Inc. All rights reserved.
+ * Author: Jason Wang <jasowang@redhat.com>
+ *
+ * Based on virtio_pci_modern.c.
+ */
+
+#include "linux/pci.h"
+#include "linux/vdpa.h"
+#include "vp_vdpa_common.h"
+
+#define VP_VDPA_QUEUE_MAX 256
+
+static struct virtio_pci_modern_device *vdpa_to_mdev(struct vdpa_device *vdpa)
+{
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
+
+	return &vp_vdpa->mdev;
+}
+
+static u64 vp_vdpa_get_features(struct vdpa_device *vdpa)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	return vp_modern_get_features(mdev);
+}
+
+static int vp_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	vp_modern_set_features(mdev, features);
+
+	return 0;
+}
+
+static u8 vp_vdpa_get_status(struct vdpa_device *vdpa)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	return vp_modern_get_status(mdev);
+}
+
+static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
+{
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
+	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
+	u8 s = vp_vdpa_get_status(vdpa);
+
+	if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
+	    !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
+		vp_vdpa_request_irq(vp_vdpa);
+	}
+
+	vp_modern_set_status(mdev, status);
+
+	if (!(status & VIRTIO_CONFIG_S_DRIVER_OK) &&
+	    (s & VIRTIO_CONFIG_S_DRIVER_OK))
+		vp_vdpa_free_irq(vp_vdpa);
+}
+
+static u16 vp_vdpa_get_vq_num_max(struct vdpa_device *vdpa)
+{
+	return VP_VDPA_QUEUE_MAX;
+}
+
+static int vp_vdpa_set_vq_state_split(struct vdpa_device *vdpa,
+				      const struct vdpa_vq_state *state)
+{
+	const struct vdpa_vq_state_split *split = &state->split;
+
+	if (split->avail_index == 0)
+		return 0;
+
+	return -EOPNOTSUPP;
+}
+
+static int vp_vdpa_set_vq_state_packed(struct vdpa_device *vdpa,
+				       const struct vdpa_vq_state *state)
+{
+	const struct vdpa_vq_state_packed *packed = &state->packed;
+
+	if (packed->last_avail_counter == 1 &&
+	    packed->last_avail_idx == 0 &&
+	    packed->last_used_counter == 1 &&
+	    packed->last_used_idx == 0)
+		return 0;
+
+	return -EOPNOTSUPP;
+}
+
+static int vp_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 qid,
+				const struct vdpa_vq_state *state)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	/* Note that this is not supported by virtio specification.
+	 * But if the state is by chance equal to the device initial
+	 * state, we can let it go.
+	 */
+	if ((vp_modern_get_status(mdev) & VIRTIO_CONFIG_S_FEATURES_OK) &&
+	    !vp_modern_get_queue_enable(mdev, qid)) {
+		if (vp_modern_get_driver_features(mdev) &
+		    BIT_ULL(VIRTIO_F_RING_PACKED))
+			return vp_vdpa_set_vq_state_packed(vdpa, state);
+		else
+			return vp_vdpa_set_vq_state_split(vdpa,	state);
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static void vp_vdpa_set_vq_ready(struct vdpa_device *vdpa,
+				 u16 qid, bool ready)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	vp_modern_set_queue_enable(mdev, qid, ready);
+}
+
+static bool vp_vdpa_get_vq_ready(struct vdpa_device *vdpa, u16 qid)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	return vp_modern_get_queue_enable(mdev, qid);
+}
+
+static void vp_vdpa_set_vq_num(struct vdpa_device *vdpa, u16 qid,
+			       u32 num)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	vp_modern_set_queue_size(mdev, qid, num);
+}
+
+static int vp_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 qid,
+				  u64 desc_area, u64 driver_area,
+				  u64 device_area)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	vp_modern_queue_address(mdev, qid, desc_area,
+				driver_area, device_area);
+
+	return 0;
+}
+
+static u32 vp_vdpa_get_generation(struct vdpa_device *vdpa)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	return vp_modern_generation(mdev);
+}
+
+static u32 vp_vdpa_get_device_id(struct vdpa_device *vdpa)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	return mdev->id.device;
+}
+
+static u32 vp_vdpa_get_vendor_id(struct vdpa_device *vdpa)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	return mdev->id.vendor;
+}
+
+static size_t vp_vdpa_get_config_size(struct vdpa_device *vdpa)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	return mdev->device_len;
+}
+
+static void vp_vdpa_get_config(struct vdpa_device *vdpa,
+			       unsigned int offset,
+			       void *buf, unsigned int len)
+{
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
+	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
+	u8 old, new;
+	u8 *p;
+	int i;
+
+	do {
+		old = vp_ioread8(&mdev->common->config_generation);
+		p = buf;
+		for (i = 0; i < len; i++)
+			*p++ = vp_ioread8(mdev->device + offset + i);
+
+		new = vp_ioread8(&mdev->common->config_generation);
+	} while (old != new);
+}
+
+static void vp_vdpa_set_config(struct vdpa_device *vdpa,
+			       unsigned int offset, const void *buf,
+			       unsigned int len)
+{
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
+	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
+	const u8 *p = buf;
+	int i;
+
+	for (i = 0; i < len; i++)
+		vp_iowrite8(*p++, mdev->device + offset + i);
+}
+
+static struct vdpa_notification_area
+vp_vdpa_get_vq_notification(struct vdpa_device *vdpa, u16 qid)
+{
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
+	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
+	struct vdpa_notification_area notify;
+
+	notify.addr = vp_vdpa->vring[qid].notify_pa;
+	notify.size = mdev->notify_offset_multiplier;
+
+	return notify;
+}
+
+static const struct vdpa_config_ops vp_vdpa_ops = {
+	.get_features	= vp_vdpa_get_features,
+	.set_features	= vp_vdpa_set_features,
+	.get_status	= vp_vdpa_get_status,
+	.set_status	= vp_vdpa_set_status,
+	.get_vq_num_max	= vp_vdpa_get_vq_num_max,
+	.get_vq_state	= vp_vdpa_get_vq_state,
+	.get_vq_notification = vp_vdpa_get_vq_notification,
+	.set_vq_state	= vp_vdpa_set_vq_state,
+	.set_vq_cb	= vp_vdpa_set_vq_cb,
+	.set_vq_ready	= vp_vdpa_set_vq_ready,
+	.get_vq_ready	= vp_vdpa_get_vq_ready,
+	.set_vq_num	= vp_vdpa_set_vq_num,
+	.set_vq_address	= vp_vdpa_set_vq_address,
+	.kick_vq	= vp_vdpa_kick_vq,
+	.get_generation	= vp_vdpa_get_generation,
+	.get_device_id	= vp_vdpa_get_device_id,
+	.get_vendor_id	= vp_vdpa_get_vendor_id,
+	.get_vq_align	= vp_vdpa_get_vq_align,
+	.get_config_size = vp_vdpa_get_config_size,
+	.get_config	= vp_vdpa_get_config,
+	.set_config	= vp_vdpa_set_config,
+	.set_config_cb  = vp_vdpa_set_config_cb,
+	.get_vq_irq	= vp_vdpa_get_vq_irq,
+};
+
+static u16 vp_vdpa_queue_vector(struct vp_vdpa *vp_vdpa, u16 idx, u16 vector)
+{
+	return vp_modern_queue_vector(&vp_vdpa->mdev, idx, vector);
+}
+
+static u16 vp_vdpa_config_vector(struct vp_vdpa *vp_vdpa, u16 vector)
+{
+	return vp_modern_config_vector(&vp_vdpa->mdev, vector);
+}
+
+struct vp_vdpa *vp_vdpa_modern_probe(struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct vp_vdpa *vp_vdpa;
+	struct virtio_pci_modern_device *mdev;
+	int ret, i;
+
+	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
+				    dev, &vp_vdpa_ops, NULL);
+	if (IS_ERR(vp_vdpa)) {
+		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
+		return vp_vdpa;
+	}
+
+	mdev = &vp_vdpa->mdev;
+	mdev->pci_dev = pdev;
+
+	ret = vp_modern_probe(mdev);
+	if (ret) {
+		dev_err(dev, "Failed to probe modern PCI device\n");
+		goto err;
+	}
+
+	pci_set_master(pdev);
+	pci_set_drvdata(pdev, vp_vdpa);
+
+	vp_vdpa->vdpa.dma_dev = dev;
+	vp_vdpa->queues = vp_modern_get_num_queues(mdev);
+
+	ret = devm_add_action_or_reset(dev, vp_vdpa_free_irq_vectors, pdev);
+	if (ret) {
+		dev_err(dev,
+			"Failed for adding devres for freeing irq vectors\n");
+		goto err;
+	}
+
+	vp_vdpa->vring = devm_kcalloc(&pdev->dev, vp_vdpa->queues,
+				      sizeof(*vp_vdpa->vring),
+				      GFP_KERNEL);
+	if (!vp_vdpa->vring) {
+		ret = -ENOMEM;
+		dev_err(dev, "Fail to allocate virtqueues\n");
+		goto err;
+	}
+
+	for (i = 0; i < vp_vdpa->queues; i++) {
+		vp_vdpa->vring[i].irq = VIRTIO_MSI_NO_VECTOR;
+		vp_vdpa->vring[i].notify =
+			vp_modern_map_vq_notify(mdev, i,
+						&vp_vdpa->vring[i].notify_pa);
+		if (!vp_vdpa->vring[i].notify) {
+			ret = -EINVAL;
+			dev_warn(dev, "Fail to map vq notify %d\n", i);
+			goto err;
+		}
+	}
+	vp_vdpa->config_irq = VIRTIO_MSI_NO_VECTOR;
+
+	vp_vdpa->queue_vector = vp_vdpa_queue_vector;
+	vp_vdpa->config_vector = vp_vdpa_config_vector;
+
+	return vp_vdpa;
+
+err:
+	put_device(&vp_vdpa->vdpa.dev);
+	return ERR_PTR(ret);
+}
-- 
2.31.1

