Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A343D75A1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 15:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbhG0NMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 09:12:34 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:34864 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232123AbhG0NMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:12:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Uh9kV2H_1627391539;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0Uh9kV2H_1627391539)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 27 Jul 2021 21:12:31 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     amit@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        osandov@fb.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH] virtio-console: avoid DMA from vmalloc area
Date:   Tue, 27 Jul 2021 21:12:17 +0800
Message-Id: <20210727131217.15092-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to optimize the commit c4baad5029:
	virtio-console: avoid DMA from stack

Commit c4baad5029(virtio-console: avoid DMA from stack) directly uses
kmemdup() to alloc new buffer from kmalloc area and do memcpy no matter
the buf is in kmalloc area or not.

This patch is to optimize the commit c4baad5029, use is_vmalloc_addr()
to judge the buf to avoid unnecessary memory alloc and copy.

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 drivers/char/virtio_console.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 7eaf303a7..106247903 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1119,6 +1119,7 @@ static int put_chars(u32 vtermno, const char *buf, int count)
 	struct scatterlist sg[1];
 	void *data;
 	int ret;
+	bool vmalloc_addr = false;
 
 	if (unlikely(early_put_chars))
 		return early_put_chars(vtermno, buf, count);
@@ -1127,13 +1128,18 @@ static int put_chars(u32 vtermno, const char *buf, int count)
 	if (!port)
 		return -EPIPE;
 
-	data = kmemdup(buf, count, GFP_ATOMIC);
-	if (!data)
-		return -ENOMEM;
+	if (is_vmalloc_addr(buf)) {
+		data = kmemdup(buf, count, GFP_ATOMIC);
+		if (!data)
+			return -ENOMEM;
+		vmalloc_addr = true;
+	} else
+		data = (void *)buf;
 
 	sg_init_one(sg, data, count);
 	ret = __send_to_port(port, sg, 1, count, data, false);
-	kfree(data);
+	if (vmalloc_addr)
+		kfree(data);
 	return ret;
 }
 
-- 
2.17.1

