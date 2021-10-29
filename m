Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E048343F99C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 11:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbhJ2JTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 05:19:13 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:45172 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231589AbhJ2JSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 05:18:11 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Uu7wNNx_1635498896;
Received: from localhost.localdomain(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0Uu7wNNx_1635498896)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 29 Oct 2021 17:15:03 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        wuzongyong@linux.alibaba.com
Cc:     wei.yang1@linux.alibaba.com
Subject: [PATCH v7 3/9] vp_vdpa: add vq irq offloading support
Date:   Fri, 29 Oct 2021 17:14:44 +0800
Message-Id: <bb091e5505db704dd620f8854a7aebc921d2a752.1635493219.git.wuzongyong@linux.alibaba.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1635493219.git.wuzongyong@linux.alibaba.com>
References: <cover.1634870456.git.wuzongyong@linux.alibaba.com> <cover.1635493219.git.wuzongyong@linux.alibaba.com>
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

