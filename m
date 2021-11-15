Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D910344FD68
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 04:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236433AbhKODU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 22:20:27 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:33251 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236412AbhKODT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 22:19:58 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UwW95BM_1636946213;
Received: from localhost.localdomain(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0UwW95BM_1636946213)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 15 Nov 2021 11:17:01 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        wuzongyong@linux.alibaba.com
Cc:     wei.yang1@linux.alibaba.com
Subject: [PATCH] vhost-vdpa: clean irqs before reseting vdpa device
Date:   Mon, 15 Nov 2021 11:16:42 +0800
Message-Id: <a2cb60cf73be9da5c4e6399242117d8818f975ae.1636946171.git.wuzongyong@linux.alibaba.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vdpa devices should be reset after unseting irqs of virtqueues, or we
will get errors when killing qemu process:

>> pi_update_irte: failed to update PI IRTE
>> irq bypass consumer (token 0000000065102a43) unregistration fails: -22

Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
---
 drivers/vhost/vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 01c59ce7e250..29cced1cd277 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1014,12 +1014,12 @@ static int vhost_vdpa_release(struct inode *inode, struct file *filep)
 
 	mutex_lock(&d->mutex);
 	filep->private_data = NULL;
+	vhost_vdpa_clean_irq(v);
 	vhost_vdpa_reset(v);
 	vhost_dev_stop(&v->vdev);
 	vhost_vdpa_iotlb_free(v);
 	vhost_vdpa_free_domain(v);
 	vhost_vdpa_config_put(v);
-	vhost_vdpa_clean_irq(v);
 	vhost_dev_cleanup(&v->vdev);
 	kfree(v->vdev.vqs);
 	mutex_unlock(&d->mutex);
-- 
2.31.1

