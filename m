Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042D143F99D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 11:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhJ2JTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 05:19:15 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:58232 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231561AbhJ2JSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 05:18:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Uu7wNNx_1635498896;
Received: from localhost.localdomain(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0Uu7wNNx_1635498896)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 29 Oct 2021 17:15:04 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        wuzongyong@linux.alibaba.com
Cc:     wei.yang1@linux.alibaba.com
Subject: [PATCH v7 7/9] vdpa: add new attribute VDPA_ATTR_DEV_MIN_VQ_SIZE
Date:   Fri, 29 Oct 2021 17:14:48 +0800
Message-Id: <2bbc417355c4d22298050b1ba887cecfbde3e85d.1635493219.git.wuzongyong@linux.alibaba.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1635493219.git.wuzongyong@linux.alibaba.com>
References: <cover.1634870456.git.wuzongyong@linux.alibaba.com> <cover.1635493219.git.wuzongyong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This attribute advertises the min value of virtqueue size. The value is
1 by default.

Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
---
 drivers/vdpa/vdpa.c       | 5 +++++
 include/uapi/linux/vdpa.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index d783a943647d..fcf02a364878 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -500,6 +500,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
 	      int flags, struct netlink_ext_ack *extack)
 {
 	u16 max_vq_size;
+	u16 min_vq_size = 1;
 	u32 device_id;
 	u32 vendor_id;
 	void *hdr;
@@ -516,6 +517,8 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
 	device_id = vdev->config->get_device_id(vdev);
 	vendor_id = vdev->config->get_vendor_id(vdev);
 	max_vq_size = vdev->config->get_vq_num_max(vdev);
+	if (vdev->config->get_vq_num_min)
+		min_vq_size = vdev->config->get_vq_num_min(vdev);
 
 	err = -EMSGSIZE;
 	if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev)))
@@ -528,6 +531,8 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
 		goto msg_err;
 	if (nla_put_u16(msg, VDPA_ATTR_DEV_MAX_VQ_SIZE, max_vq_size))
 		goto msg_err;
+	if (nla_put_u16(msg, VDPA_ATTR_DEV_MIN_VQ_SIZE, min_vq_size))
+		goto msg_err;
 
 	genlmsg_end(msg, hdr);
 	return 0;
diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
index 66a41e4ec163..e3b87879514c 100644
--- a/include/uapi/linux/vdpa.h
+++ b/include/uapi/linux/vdpa.h
@@ -32,6 +32,7 @@ enum vdpa_attr {
 	VDPA_ATTR_DEV_VENDOR_ID,		/* u32 */
 	VDPA_ATTR_DEV_MAX_VQS,			/* u32 */
 	VDPA_ATTR_DEV_MAX_VQ_SIZE,		/* u16 */
+	VDPA_ATTR_DEV_MIN_VQ_SIZE,		/* u16 */
 
 	/* new attributes must be added above here */
 	VDPA_ATTR_MAX,
-- 
2.31.1

