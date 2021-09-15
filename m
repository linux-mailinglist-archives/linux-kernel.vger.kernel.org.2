Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED97240BFB5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 08:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbhIOGlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 02:41:19 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:13377 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229484AbhIOGlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 02:41:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UoSCDY4_1631687981;
Received: from localhost.localdomain(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0UoSCDY4_1631687981)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 15 Sep 2021 14:39:49 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     wuzongyong@linux.alibaba.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com, tiwei.bie@intel.com
Cc:     wei.yang1@linux.alibaba.com
Subject: [PATCH] vhost_vdpa: unset vq irq before freeing irq
Date:   Wed, 15 Sep 2021 14:39:32 +0800
Message-Id: <02637d38dcf4e4b836c5b3a65055fe92bf812b3b.1631687872.git.wuzongyong@linux.alibaba.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we unset vq irq after freeing irq and that will result in
error messages:

  pi_update_irte: failed to update PI IRTE
  irq bypass consumer (token 000000005a07a12b) unregistration fails: -22

This patch solves this.

Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
---
 drivers/vhost/vdpa.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index f41d081777f5..15bae2290bf9 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -173,6 +173,10 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
 	if (status != 0 && (ops->get_status(vdpa) & ~status) != 0)
 		return -EINVAL;
 
+	if ((status_old & VIRTIO_CONFIG_S_DRIVER_OK) && !(status & VIRTIO_CONFIG_S_DRIVER_OK))
+		for (i = 0; i < nvqs; i++)
+			vhost_vdpa_unsetup_vq_irq(v, i);
+
 	if (status == 0) {
 		ret = ops->reset(vdpa);
 		if (ret)
@@ -184,10 +188,6 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
 		for (i = 0; i < nvqs; i++)
 			vhost_vdpa_setup_vq_irq(v, i);
 
-	if ((status_old & VIRTIO_CONFIG_S_DRIVER_OK) && !(status & VIRTIO_CONFIG_S_DRIVER_OK))
-		for (i = 0; i < nvqs; i++)
-			vhost_vdpa_unsetup_vq_irq(v, i);
-
 	return 0;
 }
 
-- 
2.31.1

