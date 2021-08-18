Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC633EFF08
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 10:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238800AbhHRIWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 04:22:08 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:37391 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238050AbhHRIWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 04:22:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UjfSYRK_1629274885;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0UjfSYRK_1629274885)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 Aug 2021 16:21:25 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org, amit@kernel.org,
        arnd@arndb.de, osandov@fb.com
Cc:     shile.zhang@linux.alibaba.com, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH v8 1/3] tty: hvc: use correct dma alignment size
Date:   Wed, 18 Aug 2021 16:21:20 +0800
Message-Id: <20210818082122.166881-2-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210818082122.166881-1-xianting.tian@linux.alibaba.com>
References: <20210818082122.166881-1-xianting.tian@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use L1_CACHE_BYTES as the dma alignment size, use 'sizeof(long)'
is wrong.

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
Reviewed-by: Shile Zhang <shile.zhang@linux.alibaba.com>
---
 drivers/tty/hvc/hvc_console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 5bb8c4e44..5957ab728 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -49,7 +49,7 @@
 #define N_OUTBUF	16
 #define N_INBUF		16
 
-#define __ALIGNED__ __attribute__((__aligned__(sizeof(long))))
+#define __ALIGNED__ __attribute__((__aligned__(L1_CACHE_BYTES)))
 
 static struct tty_driver *hvc_driver;
 static struct task_struct *hvc_task;
-- 
2.17.1

