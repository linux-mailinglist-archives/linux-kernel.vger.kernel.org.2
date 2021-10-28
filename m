Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855D043E4A3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 17:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhJ1PMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 11:12:37 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:57361 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230265AbhJ1PM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 11:12:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Uu0vwYK_1635433797;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0Uu0vwYK_1635433797)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 28 Oct 2021 23:09:57 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org, amit@kernel.org,
        arnd@arndb.de, osandov@fb.com
Cc:     shile.zhang@linux.alibaba.com, sfr@canb.auug.org.au,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH v12 2/2] virtio-console: remove unnecessary kmemdup()
Date:   Thu, 28 Oct 2021 23:09:54 +0800
Message-Id: <20211028150954.1356334-3-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211028150954.1356334-1-xianting.tian@linux.alibaba.com>
References: <20211028150954.1356334-1-xianting.tian@linux.alibaba.com>
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

