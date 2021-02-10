Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37B2315DB6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 04:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbhBJDFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 22:05:08 -0500
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:6504 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbhBJDFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 22:05:00 -0500
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee560234d0f09f-345f1; Wed, 10 Feb 2021 11:03:43 +0800 (CST)
X-RM-TRANSID: 2ee560234d0f09f-345f1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea60234d0bebc-67c97;
        Wed, 10 Feb 2021 11:03:43 +0800 (CST)
X-RM-TRANSID: 2eea60234d0bebc-67c97
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] virtio-mmio: Use to_virtio_mmio_device() to simply code
Date:   Wed, 10 Feb 2021 11:04:01 +0800
Message-Id: <20210210030401.5532-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file virtio_mmio.c has defined the function to_virtio_mmio_device,
so use it instead of container_of() to simply code. And remove
superfluous blank lines in this file.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/virtio/virtio_mmio.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 627ac0487..449d0f209 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -69,14 +69,10 @@
 #include <uapi/linux/virtio_mmio.h>
 #include <linux/virtio_ring.h>
 
-
-
 /* The alignment to use between consumer and producer parts of vring.
  * Currently hardcoded to the page size. */
 #define VIRTIO_MMIO_VRING_ALIGN		PAGE_SIZE
 
-
-
 #define to_virtio_mmio_device(_plat_dev) \
 	container_of(_plat_dev, struct virtio_mmio_device, vdev)
 
@@ -100,8 +96,6 @@ struct virtio_mmio_vq_info {
 	struct list_head node;
 };
 
-
-
 /* Configuration interface */
 
 static u64 vm_get_features(struct virtio_device *vdev)
@@ -264,8 +258,6 @@ static void vm_reset(struct virtio_device *vdev)
 	writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
 }
 
-
-
 /* Transport interface */
 
 /* the notify function used when creating a virt queue */
@@ -307,8 +299,6 @@ static irqreturn_t vm_interrupt(int irq, void *opaque)
 	return ret;
 }
 
-
-
 static void vm_del_vq(struct virtqueue *vq)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vq->vdev);
@@ -512,13 +502,11 @@ static const struct virtio_config_ops virtio_mmio_config_ops = {
 	.bus_name	= vm_bus_name,
 };
 
-
 static void virtio_mmio_release_dev(struct device *_d)
 {
 	struct virtio_device *vdev =
 			container_of(_d, struct virtio_device, dev);
-	struct virtio_mmio_device *vm_dev =
-			container_of(vdev, struct virtio_mmio_device, vdev);
+	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 	struct platform_device *pdev = vm_dev->pdev;
 
 	devm_kfree(&pdev->dev, vm_dev);
@@ -608,8 +596,6 @@ static int virtio_mmio_remove(struct platform_device *pdev)
 	return 0;
 }
 
-
-
 /* Devices list parameter */
 
 #if defined(CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES)
-- 
2.20.1.windows.1



