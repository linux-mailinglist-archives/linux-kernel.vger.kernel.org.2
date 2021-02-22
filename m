Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69313321096
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 06:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhBVF5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 00:57:48 -0500
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:25439 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhBVF5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 00:57:47 -0500
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee8603347a3797-df5f1; Mon, 22 Feb 2021 13:56:52 +0800 (CST)
X-RM-TRANSID: 2ee8603347a3797-df5f1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6033479fe33-bae41;
        Mon, 22 Feb 2021 13:56:51 +0800 (CST)
X-RM-TRANSID: 2eea6033479fe33-bae41
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH v2] virtio-mmio: Use to_virtio_mmio_device() to simply code
Date:   Mon, 22 Feb 2021 13:57:24 +0800
Message-Id: <20210222055724.220-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file virtio_mmio.c has defined the function to_virtio_mmio_device,
so use it instead of container_of() to simply code.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
Changes from v1
 - Separate the patch with style changes.
---
 drivers/virtio/virtio_mmio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 627ac0487..e530591cd 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -517,8 +517,7 @@ static void virtio_mmio_release_dev(struct device *_d)
 {
 	struct virtio_device *vdev =
 			container_of(_d, struct virtio_device, dev);
-	struct virtio_mmio_device *vm_dev =
-			container_of(vdev, struct virtio_mmio_device, vdev);
+	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 	struct platform_device *pdev = vm_dev->pdev;
 
 	devm_kfree(&pdev->dev, vm_dev);
-- 
2.20.1.windows.1



