Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFA6377146
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 12:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhEHKq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 06:46:59 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:46436 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230234AbhEHKq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 06:46:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UY8pf9V_1620470746;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UY8pf9V_1620470746)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 08 May 2021 18:45:56 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     mst@redhat.com
Cc:     jasowang@redhat.com, irtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] vp_vdpa: Fix inconsistent indenting
Date:   Sat,  8 May 2021 18:45:45 +0800
Message-Id: <1620470745-35571-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch warnings:
drivers/vdpa/virtio_pci/vp_vdpa.c:169 vp_vdpa_request_irq() warn:
inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index c76ebb5..f567788 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -164,9 +164,8 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
 	ret = devm_request_irq(&pdev->dev, irq,	vp_vdpa_config_handler, 0,
 			       vp_vdpa->msix_name, vp_vdpa);
 	if (ret) {
-		dev_err(&pdev->dev,
-			"vp_vdpa: fail to request irq for vq %d\n", i);
-			goto err;
+		dev_err(&pdev->dev, "vp_vdpa: fail to request irq for vq %d\n", i);
+		goto err;
 	}
 	vp_modern_config_vector(mdev, queues);
 	vp_vdpa->config_irq = irq;
-- 
1.8.3.1

