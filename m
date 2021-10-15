Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED7342E9D9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 09:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbhJOHSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 03:18:05 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:45817 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235955AbhJOHSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:18:04 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Us6A078_1634282107;
Received: from localhost.localdomain(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0Us6A078_1634282107)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 Oct 2021 15:15:17 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     wuzongyong@linux.alibaba.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com
Cc:     wei.yang1@linux.alibaba.com
Subject: [PATCH v5 5/8] vdpa: min vq num of vdpa device cannot be greater than max vq num
Date:   Fri, 15 Oct 2021 15:14:58 +0800
Message-Id: <5b75093fc4a866a4502485ec208ca0e55440bdf7.1634281805.git.wuzongyong@linux.alibaba.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634281805.git.wuzongyong@linux.alibaba.com>
References: <cover.1632882380.git.wuzongyong@linux.alibaba.com> <cover.1634281805.git.wuzongyong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just failed to probe the vdpa device if the min virtqueue num returned
by get_vq_num_min is greater than the max virtqueue num returned by
get_vq_num_max.

Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
---
 drivers/vdpa/vdpa.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 1dc121a07a93..fd014ecec711 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -26,8 +26,16 @@ static int vdpa_dev_probe(struct device *d)
 {
 	struct vdpa_device *vdev = dev_to_vdpa(d);
 	struct vdpa_driver *drv = drv_to_vdpa(vdev->dev.driver);
+	const struct vdpa_config_ops *ops = vdev->config;
+	u32 max_num, min_num = 0;
 	int ret = 0;
 
+	max_num = ops->get_vq_num_max(vdev);
+	if (ops->get_vq_num_min)
+		min_num = ops->get_vq_num_min(vdev);
+	if (max_num < min_num)
+		return -EINVAL;
+
 	if (drv && drv->probe)
 		ret = drv->probe(vdev);
 
-- 
2.31.1

