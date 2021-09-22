Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43472414992
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 14:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbhIVMtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 08:49:22 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:53032 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236194AbhIVMtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 08:49:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UpEJoj9_1632314798;
Received: from localhost.localdomain(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0UpEJoj9_1632314798)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Sep 2021 20:46:46 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     wuzongyong@linux.alibaba.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com
Cc:     wei.yang1@linux.alibaba.com
Subject: [PATCH v3 2/7] vdpa: fix typo
Date:   Wed, 22 Sep 2021 20:46:25 +0800
Message-Id: <49dc74038cdfaa7af7dab1565ba5da5d6cc4ec7d.1632313398.git.wuzongyong@linux.alibaba.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632313398.git.wuzongyong@linux.alibaba.com>
References: <cover.1631621507.git.wuzongyong@linux.alibaba.com> <cover.1632313398.git.wuzongyong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
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

