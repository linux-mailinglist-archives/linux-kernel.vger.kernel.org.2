Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26713C73E1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhGMQMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:12:46 -0400
Received: from m15114.mail.126.com ([220.181.15.114]:39292 "EHLO
        m15114.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhGMQMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:12:46 -0400
X-Greylist: delayed 1814 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Jul 2021 12:12:36 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=hWrXsZqz2S9WPoBszQ
        NOR1ZBbtfHZp1AgMaPc3k8gsI=; b=QcyF4cFMae2jfAxYumTa9v6LuCvK8ocG0z
        osbelUvnbyVZKlxeX//Rb59rD9EGeMwKT3hGki3PbXHdvEgZ7P2s4gfkWgrbOCIX
        YTQKy3RPQrdnPEEb+AUryHTs2kz+uhcMk+WmCDWAQr2vEXlcP0RT5A6CzqDk3Qzs
        m9evvUTPg=
Received: from 192.168.137.133 (unknown [112.10.74.16])
        by smtp7 (Coremail) with SMTP id DsmowAA3sDuFs+1gDe1hSQ--.4116S3;
        Tue, 13 Jul 2021 23:38:47 +0800 (CST)
From:   Xianting Tian <xianting_tian@126.com>
To:     mst@redhat.com, jasowang@redhat.com, david@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH] virtio-balloon: Use virtio_find_vqs() helper
Date:   Tue, 13 Jul 2021 11:38:44 -0400
Message-Id: <1626190724-7942-1-git-send-email-xianting_tian@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DsmowAA3sDuFs+1gDe1hSQ--.4116S3
X-Coremail-Antispam: 1Uf129KBjvdXoWruF18Xw4xWF1kuw4Uuw43trb_yoWfJFbEyr
        4Ivryxtr98GF4jkrWDur4Fvryaka48uF9rZ39Yy3WfJFW7Z3WjvasFgr1UJ3W7WFWUAa9x
        GF45urs7uw4IkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8nSdDUUUUU==
X-Originating-IP: [112.10.74.16]
X-CM-SenderInfo: h0ld03plqjs3xldqqiyswou0bp/1tbizgfOpF8RNJL9zQAAs7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xianting Tian <xianting.tian@linux.alibaba.com>

Use the helper virtio_find_vqs().

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 drivers/virtio/virtio_balloon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 510e931..18e0bf3 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -531,8 +531,8 @@ static int init_vqs(struct virtio_balloon *vb)
 		callbacks[VIRTIO_BALLOON_VQ_REPORTING] = balloon_ack;
 	}
 
-	err = vb->vdev->config->find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX,
-					 vqs, callbacks, names, NULL, NULL);
+	err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
+				callbacks, names, NULL);
 	if (err)
 		return err;
 
-- 
1.8.3.1

