Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6E040AD84
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 14:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbhINM0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 08:26:48 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:38463 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232552AbhINM0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 08:26:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UoNt7PD_1631622314;
Received: from localhost.localdomain(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0UoNt7PD_1631622314)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 Sep 2021 20:25:25 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     wuzongyong@linux.alibaba.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com
Cc:     wei.yang1@linux.alibaba.com
Subject: [PATCH v2 3/5] vp_vdpa: add vq irq offloading support
Date:   Tue, 14 Sep 2021 20:24:50 +0800
Message-Id: <11a491e2200e17319989ff9043b8d58867610197.1631621507.git.wuzongyong@linux.alibaba.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631621507.git.wuzongyong@linux.alibaba.com>
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com> <cover.1631621507.git.wuzongyong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the get_vq_irq() callback for virtio pci devices
to allow irq offloading.

Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
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

