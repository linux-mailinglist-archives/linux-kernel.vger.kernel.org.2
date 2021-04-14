Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF6D35EAC0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 04:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239653AbhDNCWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 22:22:18 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:40327 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231475AbhDNCWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 22:22:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UVUx26c_1618366909;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UVUx26c_1618366909)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 14 Apr 2021 10:21:54 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     maximlevitsky@gmail.com
Cc:     oakad@yahoo.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] memstick: r592: remove unused variable
Date:   Wed, 14 Apr 2021 10:21:43 +0800
Message-Id: <1618366903-94346-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following clang warning:

drivers/memstick/host/r592.c:363:6: warning: variable ‘len’ set but not
used [-Wunused-but-set-variable].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/memstick/host/r592.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
index d2ef463..026fada 100644
--- a/drivers/memstick/host/r592.c
+++ b/drivers/memstick/host/r592.c
@@ -360,12 +360,11 @@ static void r592_write_fifo_pio(struct r592_device *dev,
 static void r592_flush_fifo_write(struct r592_device *dev)
 {
 	u8 buffer[4] = { 0 };
-	int len;
 
 	if (kfifo_is_empty(&dev->pio_fifo))
 		return;
 
-	len = kfifo_out(&dev->pio_fifo, buffer, 4);
+	kfifo_out(&dev->pio_fifo, buffer, 4);
 	r592_write_reg_raw_be(dev, R592_FIFO_PIO, *(u32 *)buffer);
 }
 
-- 
1.8.3.1

