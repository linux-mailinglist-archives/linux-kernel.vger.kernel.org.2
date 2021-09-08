Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1214039AC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 14:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351738AbhIHMXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 08:23:02 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:50800 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349230AbhIHMWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:22:55 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UnhbUrf_1631103655;
Received: from localhost.localdomain(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0UnhbUrf_1631103655)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 Sep 2021 20:21:06 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     wuzongyong@linux.alibaba.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com
Cc:     wei.yang1@linux.alibaba.com
Subject: [PATCH 3/6] vp_vdpa: add vq irq offloading support
Date:   Wed,  8 Sep 2021 20:20:34 +0800
Message-Id: <88701e88ab061f5d1b94bd046afcb9d3588414c3.1631101392.git.wuzongyong@linux.alibaba.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the get_vq_irq() callback for virtio pci devices
to allow irq offloading.

Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index fe0527329857..4c512ae1fe01 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -76,6 +76,13 @@ static u8 vp_vdpa_get_status(struct vdpa_device *vdpa)
 	return vp_modern_get_status(mdev);
 }
 
+static int vp_vdpa_get_vq_irq(struct vdpa_device *vdev, u16 idx)
+{
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdev);
+
+	return vp_vdpa->vring[idx].irq;
+}
+
 static void vp_vdpa_free_irq(struct vp_vdpa *vp_vdpa)
 {
 	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
@@ -416,6 +423,7 @@ static const struct vdpa_config_ops vp_vdpa_ops = {
 	.get_config	= vp_vdpa_get_config,
 	.set_config	= vp_vdpa_set_config,
 	.set_config_cb  = vp_vdpa_set_config_cb,
+	.get_vq_irq	= vp_vdpa_get_vq_irq,
 };
 
 static void vp_vdpa_free_irq_vectors(void *data)
-- 
2.31.1

