Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA5041BEFF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 08:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244346AbhI2GOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 02:14:00 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:45224 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244269AbhI2GN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 02:13:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Uq.GBNB_1632895927;
Received: from localhost.localdomain(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0Uq.GBNB_1632895927)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 29 Sep 2021 14:12:15 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     wuzongyong@linux.alibaba.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com
Cc:     wei.yang1@linux.alibaba.com
Subject: [PATCH v4 3/7] vp_vdpa: add vq irq offloading support
Date:   Wed, 29 Sep 2021 14:11:42 +0800
Message-Id: <118c8e66e943dc35bce5a572a4fb23ab8d81b722.1632882380.git.wuzongyong@linux.alibaba.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632882380.git.wuzongyong@linux.alibaba.com>
References: <cover.1632313398.git.wuzongyong@linux.alibaba.com> <cover.1632882380.git.wuzongyong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the get_vq_irq() callback for virtio pci devices
to allow irq offloading.

Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index 5bcd00246d2e..e3ff7875e123 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -76,6 +76,17 @@ static u8 vp_vdpa_get_status(struct vdpa_device *vdpa)
 	return vp_modern_get_status(mdev);
 }
 
+static int vp_vdpa_get_vq_irq(struct vdpa_device *vdpa, u16 idx)
+{
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
+	int irq = vp_vdpa->vring[idx].irq;
+
+	if (irq == VIRTIO_MSI_NO_VECTOR)
+		return -EINVAL;
+
+	return irq;
+}
+
 static void vp_vdpa_free_irq(struct vp_vdpa *vp_vdpa)
 {
 	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
@@ -427,6 +438,7 @@ static const struct vdpa_config_ops vp_vdpa_ops = {
 	.get_config	= vp_vdpa_get_config,
 	.set_config	= vp_vdpa_set_config,
 	.set_config_cb  = vp_vdpa_set_config_cb,
+	.get_vq_irq	= vp_vdpa_get_vq_irq,
 };
 
 static void vp_vdpa_free_irq_vectors(void *data)
-- 
2.31.1

