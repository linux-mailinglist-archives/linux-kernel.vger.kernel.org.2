Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A1742E9DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 09:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbhJOHSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 03:18:13 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:54508 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236010AbhJOHSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:18:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Us6A078_1634282107;
Received: from localhost.localdomain(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0Us6A078_1634282107)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 Oct 2021 15:15:16 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     wuzongyong@linux.alibaba.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com
Cc:     wei.yang1@linux.alibaba.com
Subject: [PATCH v5 2/8] vdpa: fix typo
Date:   Fri, 15 Oct 2021 15:14:55 +0800
Message-Id: <18e7a676b9228efed7a95aae5eb8a6f5436ef9dd.1634281805.git.wuzongyong@linux.alibaba.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634281805.git.wuzongyong@linux.alibaba.com>
References: <cover.1632882380.git.wuzongyong@linux.alibaba.com> <cover.1634281805.git.wuzongyong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/vdpa.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 3972ab765de1..a896ee021e5f 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -257,7 +257,7 @@ struct vdpa_config_ops {
 	struct vdpa_notification_area
 	(*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
 	/* vq irq is not expected to be changed once DRIVER_OK is set */
-	int (*get_vq_irq)(struct vdpa_device *vdv, u16 idx);
+	int (*get_vq_irq)(struct vdpa_device *vdev, u16 idx);
 
 	/* Device ops */
 	u32 (*get_vq_align)(struct vdpa_device *vdev);
-- 
2.31.1

