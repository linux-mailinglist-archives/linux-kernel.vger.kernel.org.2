Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6F242E6C9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 04:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbhJOCtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 22:49:12 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:55701 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232833AbhJOCtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 22:49:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Us1llkI_1634266021;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0Us1llkI_1634266021)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 Oct 2021 10:47:01 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org, amit@kernel.org,
        arnd@arndb.de, osandov@fb.com
Cc:     shile.zhang@linux.alibaba.com, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH v11 1/3] tty: hvc: use correct dma alignment size
Date:   Fri, 15 Oct 2021 10:46:56 +0800
Message-Id: <20211015024658.1353987-2-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211015024658.1353987-1-xianting.tian@linux.alibaba.com>
References: <20211015024658.1353987-1-xianting.tian@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use L1_CACHE_BYTES as the dma alignment size, use 'sizeof(long)' as
dma alignment is wrong.

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
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

