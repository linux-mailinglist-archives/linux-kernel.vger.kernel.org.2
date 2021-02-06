Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79050311D2F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 13:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhBFMtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 07:49:13 -0500
Received: from m15111.mail.126.com ([220.181.15.111]:33249 "EHLO
        m15111.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBFMtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 07:49:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=P1PEd9ZD0HDbcn064j
        SAmMR0aZzIZSVLlNdZ+DNvkhM=; b=MH8UQB6rn3wGZdw5Rjq2pVKJI7itr6HRqU
        bqEE3b4WjZRDPc1PHPVZ99Z7SsDd/pSIm9L4dq8I8/X+ZPp20jSLQWZEHN+rBP3Q
        FUMRF29O9Nk7DrIRp9TOlOngY/15EMAFW9b9Fh3FP2SvTFXCLglOhsJ2TLOX/oRN
        Z/IpvG3l0=
Received: from 192.168.137.133 (unknown [112.10.84.219])
        by smtp1 (Coremail) with SMTP id C8mowABntVrbjx5g+saSOQ--.1970S3;
        Sat, 06 Feb 2021 20:47:25 +0800 (CST)
From:   Xianting Tian <xianting_tian@126.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@list.linux-foundation.org,
        linux-kernel@vger.kernel.org, xianting.tian@linux.alibaba.com
Subject: [PATCH] virtio_mmio: fix one typo
Date:   Sat,  6 Feb 2021 07:46:59 -0500
Message-Id: <1612615619-8128-1-git-send-email-xianting_tian@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: C8mowABntVrbjx5g+saSOQ--.1970S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKry8ArWUCw48WF1Utw18Krg_yoWfJFXEkr
        47Zr92qw1UXF42y39rCr4rZryS9asFgF4kWr4Yga95J3yUZFyUXrnrur45W3W3Ww1UGFsr
        Xrs8Grn2yw1S9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0Gjg7UUUUU==
X-Originating-IP: [112.10.84.219]
X-CM-SenderInfo: h0ld03plqjs3xldqqiyswou0bp/1tbiwBsxpFx5Bmk98gAAsL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the typo 'there is are' to 'there are'.

Signed-off-by: Xianting Tian <xianting_tian@126.com>
---
 drivers/virtio/virtio_mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 238383f..a286d22 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -126,7 +126,7 @@ static int vm_finalize_features(struct virtio_device *vdev)
 	/* Give virtio_ring a chance to accept features. */
 	vring_transport_features(vdev);
 
-	/* Make sure there is are no mixed devices */
+	/* Make sure there are no mixed devices */
 	if (vm_dev->version == 2 &&
 			!__virtio_test_bit(vdev, VIRTIO_F_VERSION_1)) {
 		dev_err(&vdev->dev, "New virtio-mmio devices (version 2) must provide VIRTIO_F_VERSION_1 feature!\n");
-- 
1.8.3.1

