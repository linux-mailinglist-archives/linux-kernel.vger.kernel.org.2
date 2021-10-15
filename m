Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC0542E6CA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 04:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbhJOCtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 22:49:14 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:33805 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233054AbhJOCtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 22:49:11 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Us01OPT_1634266022;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0Us01OPT_1634266022)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 Oct 2021 10:47:03 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org, amit@kernel.org,
        arnd@arndb.de, osandov@fb.com
Cc:     shile.zhang@linux.alibaba.com, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH v11 3/3] virtio-console: remove unnecessary kmemdup()
Date:   Fri, 15 Oct 2021 10:46:58 +0800
Message-Id: <20211015024658.1353987-4-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211015024658.1353987-1-xianting.tian@linux.alibaba.com>
References: <20211015024658.1353987-1-xianting.tian@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This revert commit c4baad5029 ("virtio-console: avoid DMA from stack")

hvc framework will never pass stack memory to the put_chars() function,
So the calling of kmemdup() is unnecessary, we can remove it.

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
Reviewed-by: Shile Zhang <shile.zhang@linux.alibaba.com>
---
 drivers/char/virtio_console.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 7eaf303a7..4ed3ffb1d 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1117,8 +1117,6 @@ static int put_chars(u32 vtermno, const char *buf, int count)
 {
 	struct port *port;
 	struct scatterlist sg[1];
-	void *data;
-	int ret;
 
 	if (unlikely(early_put_chars))
 		return early_put_chars(vtermno, buf, count);
@@ -1127,14 +1125,8 @@ static int put_chars(u32 vtermno, const char *buf, int count)
 	if (!port)
 		return -EPIPE;
 
-	data = kmemdup(buf, count, GFP_ATOMIC);
-	if (!data)
-		return -ENOMEM;
-
-	sg_init_one(sg, data, count);
-	ret = __send_to_port(port, sg, 1, count, data, false);
-	kfree(data);
-	return ret;
+	sg_init_one(sg, buf, count);
+	return __send_to_port(port, sg, 1, count, (void *)buf, false);
 }
 
 /*
-- 
2.17.1

