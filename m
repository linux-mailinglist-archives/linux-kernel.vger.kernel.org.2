Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42C53DF9CE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 04:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbhHDCzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 22:55:09 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:46621 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231396AbhHDCzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 22:55:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UhvKFUE_1628045695;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0UhvKFUE_1628045695)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Aug 2021 10:54:55 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org, amit@kernel.org,
        arnd@arndb.de, osandov@fb.com
Cc:     linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH v3 1/2] tty: hvc: pass DMA capable memory to put_chars()
Date:   Wed,  4 Aug 2021 10:54:53 +0800
Message-Id: <20210804025453.93543-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As well known, hvc backend can register its opertions to hvc backend.
the opertions contain put_chars(), get_chars() and so on.

Some hvc backend may do dma in its opertions. eg, put_chars() of
virtio-console. But in the code of hvc framework, it may pass DMA
incapable memory to put_chars() under a specific configuration, which
is explained in commit c4baad5029(virtio-console: avoid DMA from stack):
1, c[] is on stack,
   hvc_console_print():
	char c[N_OUTBUF] __ALIGNED__;
	cons_ops[index]->put_chars(vtermnos[index], c, i);
2, ch is on stack,
   static void hvc_poll_put_char(,,char ch)
   {
	struct tty_struct *tty = driver->ttys[0];
	struct hvc_struct *hp = tty->driver_data;
	int n;

	do {
		n = hp->ops->put_chars(hp->vtermno, &ch, 1);
	} while (n <= 0);
   }

Commit c4baad5029 is just the fix to avoid DMA from stack memory, which
is passed to virtio-console by hvc framework in above code. But I think
the fix is aggressive, it directly uses kmemdup() to alloc new buffer
from kmalloc area and do memcpy no matter the memory is in kmalloc area
or not. But most importantly, it should better be fixed in the hvc
framework, by changing it to never pass stack memory to the put_chars()
function in the first place. Otherwise, we still face the same issue if
a new hvc backend using dma added in the furture.

Considering lock competition of hp->outbuf, we created a new buffer
hp->hvc_con_outbuf, which is aligned at least to N_OUTBUF, and use it
in above two cases.

With the patch, we can remove the fix c4baad5029.

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
Tested-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 drivers/tty/hvc/hvc_console.c | 30 ++++++++++++++++++++++++++++--
 drivers/tty/hvc/hvc_console.h |  2 ++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 5bb8c4e44..e5862989c 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -151,9 +151,11 @@ static uint32_t vtermnos[MAX_NR_HVC_CONSOLES] =
 static void hvc_console_print(struct console *co, const char *b,
 			      unsigned count)
 {
-	char c[N_OUTBUF] __ALIGNED__;
+	char *c;
 	unsigned i = 0, n = 0;
 	int r, donecr = 0, index = co->index;
+	unsigned long flags;
+	struct hvc_struct *hp;
 
 	/* Console access attempt outside of acceptable console range. */
 	if (index >= MAX_NR_HVC_CONSOLES)
@@ -163,6 +165,13 @@ static void hvc_console_print(struct console *co, const char *b,
 	if (vtermnos[index] == -1)
 		return;
 
+	list_for_each_entry(hp, &hvc_structs, next)
+		if (hp->vtermno == vtermnos[index])
+			break;
+
+	c = hp->hvc_con_outbuf;
+
+	spin_lock_irqsave(&hp->hvc_con_lock, flags);
 	while (count > 0 || i > 0) {
 		if (count > 0 && i < sizeof(c)) {
 			if (b[n] == '\n' && !donecr) {
@@ -191,6 +200,7 @@ static void hvc_console_print(struct console *co, const char *b,
 			}
 		}
 	}
+	spin_unlock_irqrestore(&hp->hvc_con_lock, flags);
 	hvc_console_flush(cons_ops[index], vtermnos[index]);
 }
 
@@ -878,9 +888,15 @@ static void hvc_poll_put_char(struct tty_driver *driver, int line, char ch)
 	struct tty_struct *tty = driver->ttys[0];
 	struct hvc_struct *hp = tty->driver_data;
 	int n;
+	unsigned long flags;
+	char *c;
 
+	c = hp->hvc_con_outbuf;
 	do {
-		n = hp->ops->put_chars(hp->vtermno, &ch, 1);
+		spin_lock_irqsave(&hp->hvc_con_lock, flags);
+		c[0] = ch;
+		n = hp->ops->put_chars(hp->vtermno, c, 1);
+		spin_unlock_irqrestore(&hp->hvc_con_lock, flags);
 	} while (n <= 0);
 }
 #endif
@@ -933,6 +949,16 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
 	hp->outbuf_size = outbuf_size;
 	hp->outbuf = &((char *)hp)[ALIGN(sizeof(*hp), sizeof(long))];
 
+	/*
+	 * hvc_con_outbuf is guaranteed to be aligned at least to the
+	 * size(N_OUTBUF) by kmalloc().
+	 */
+	hp->hvc_con_outbuf = kzalloc(N_OUTBUF, GFP_KERNEL);
+	if (!hp->hvc_con_outbuf)
+		return ERR_PTR(-ENOMEM);
+
+	spin_lock_init(&hp->hvc_con_lock);
+
 	tty_port_init(&hp->port);
 	hp->port.ops = &hvc_port_ops;
 
diff --git a/drivers/tty/hvc/hvc_console.h b/drivers/tty/hvc/hvc_console.h
index 18d005814..8972c52de 100644
--- a/drivers/tty/hvc/hvc_console.h
+++ b/drivers/tty/hvc/hvc_console.h
@@ -48,6 +48,8 @@ struct hvc_struct {
 	struct work_struct tty_resize;
 	struct list_head next;
 	unsigned long flags;
+	char *hvc_con_outbuf;
+	spinlock_t hvc_con_lock;
 };
 
 /* implemented by a low level driver */
-- 
2.17.1

