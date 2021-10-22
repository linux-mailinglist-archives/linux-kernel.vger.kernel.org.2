Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC877437027
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 04:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhJVCrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 22:47:02 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:57428 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232440AbhJVCq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 22:46:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UtCtrLa_1634870672;
Received: from localhost.localdomain(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0UtCtrLa_1634870672)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Oct 2021 10:44:41 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     wuzongyong@linux.alibaba.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com
Cc:     wei.yang1@linux.alibaba.com
Subject: [PATCH v6 4/8] vdpa: add new callback get_vq_num_min in vdpa_config_ops
Date:   Fri, 22 Oct 2021 10:44:19 +0800
Message-Id: <7e4d859949fa37fce2289a4b287843cdeffcaf8a.1634870456.git.wuzongyong@linux.alibaba.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634870456.git.wuzongyong@linux.alibaba.com>
References: <cover.1634281805.git.wuzongyong@linux.alibaba.com> <cover.1634870456.git.wuzongyong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This callback is optional. For vdpa devices that not support to change
virtqueue size, get_vq_num_min and get_vq_num_max will return the same
value, so that users can choose a correct value for that device.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
---
 include/linux/vdpa.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index a896ee021e5f..30864848950b 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -171,6 +171,9 @@ struct vdpa_map_file {
  * @get_vq_num_max:		Get the max size of virtqueue
  *				@vdev: vdpa device
  *				Returns u16: max size of virtqueue
+ * @get_vq_num_min:		Get the min size of virtqueue (optional)
+ *				@vdev: vdpa device
+ *				Returns u16: min size of virtqueue
  * @get_device_id:		Get virtio device id
  *				@vdev: vdpa device
  *				Returns u32: virtio device id
@@ -266,6 +269,7 @@ struct vdpa_config_ops {
 	void (*set_config_cb)(struct vdpa_device *vdev,
 			      struct vdpa_callback *cb);
 	u16 (*get_vq_num_max)(struct vdpa_device *vdev);
+	u16 (*get_vq_num_min)(struct vdpa_device *vdev);
 	u32 (*get_device_id)(struct vdpa_device *vdev);
 	u32 (*get_vendor_id)(struct vdpa_device *vdev);
 	u8 (*get_status)(struct vdpa_device *vdev);
-- 
2.31.1

