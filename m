Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4553F27F3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 09:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238776AbhHTHxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 03:53:05 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:35943 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236378AbhHTHxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 03:53:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UkHjRXA_1629445940;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0UkHjRXA_1629445940)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 20 Aug 2021 15:52:21 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     amit@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [RESEND][PATCH] virtio_console: protect max_nr_ports to avoid invalid value
Date:   Fri, 20 Aug 2021 15:52:19 +0800
Message-Id: <20210820075219.202404-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In theory untrusted remote host can pass a big or overflow value
of max_nr_ports to guest, it may cause guest system consumes
a lot of memory when create vqs and other impacts.

Add the protection to guarantee max_nr_ports to get a safe value.

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 drivers/char/virtio_console.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 7eaf303a7..bba985c81 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -29,6 +29,8 @@
 
 #define is_rproc_enabled IS_ENABLED(CONFIG_REMOTEPROC)
 
+#define MAX_NR_PORTS	MAX_NR_HVC_CONSOLES
+
 /*
  * This is a global struct for storing common data for all the devices
  * this driver handles.
@@ -2039,6 +2041,9 @@ static int virtcons_probe(struct virtio_device *vdev)
 		multiport = true;
 	}
 
+	/* limit max_nr_ports to avoid invalid value from untrusted remote host */
+	portdev->max_nr_ports = min_t(u32, portdev->max_nr_ports, MAX_NR_PORTS);
+
 	err = init_vqs(portdev);
 	if (err < 0) {
 		dev_err(&vdev->dev, "Error %d initializing vqs\n", err);
-- 
2.17.1

