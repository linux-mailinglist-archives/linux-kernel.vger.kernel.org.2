Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A1F3E2200
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 05:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241073AbhHFDCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 23:02:11 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:9656 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229919AbhHFDCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 23:02:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Ui5GmbN_1628218901;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0Ui5GmbN_1628218901)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 Aug 2021 11:01:41 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org, amit@kernel.org,
        arnd@arndb.de, osandov@fb.com
Cc:     linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, guoren@kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH v4 1/2] tty: hvc: pass DMA capable memory to put_chars()
Date:   Fri,  6 Aug 2021 11:01:37 +0800
Message-Id: <20210806030138.123479-2-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210806030138.123479-1-xianting.tian@linux.alibaba.com>
References: <20210806030138.123479-1-xianting.tian@linux.alibaba.com>
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

We make 'char c[N_OUTBUF]' part of 'struct hvc_struct', so hp->c is no
longer the stack memory. we can use it in above two cases.

Other cleanup is to make 'hp->outbuf' aligned and use struct_size() to
calculate the size of hvc_struct.

With the patch, we can remove the fix c4baad5029.

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
Tested-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 drivers/tty/hvc/hvc_console.c | 33 ++++++++++++++++++---------------
 drivers/tty/hvc/hvc_console.h | 16 ++++++++++++++--
 2 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 5bb8c4e44..3afdb169c 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -41,16 +41,6 @@
  */
 #define HVC_CLOSE_WAIT (HZ/100) /* 1/10 of a second */
 
-/*
- * These sizes are most efficient for vio, because they are the
- * native transfer size. We could make them selectable in the
- * future to better deal with backends that want other buffer sizes.
- */
-#define N_OUTBUF	16
-#define N_INBUF		16
-
-#define __ALIGNED__ __attribute__((__aligned__(sizeof(long))))
-
 static struct tty_driver *hvc_driver;
 static struct task_struct *hvc_task;
 
@@ -151,9 +141,11 @@ static uint32_t vtermnos[MAX_NR_HVC_CONSOLES] =
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
@@ -163,6 +155,13 @@ static void hvc_console_print(struct console *co, const char *b,
 	if (vtermnos[index] == -1)
 		return;
 
+	list_for_each_entry(hp, &hvc_structs, next)
+		if (hp->vtermno == vtermnos[index])
+			break;
+
+	c = hp->c;
+
+	spin_lock_irqsave(&hp->c_lock, flags);
 	while (count > 0 || i > 0) {
 		if (count > 0 && i < sizeof(c)) {
 			if (b[n] == '\n' && !donecr) {
@@ -191,6 +190,7 @@ static void hvc_console_print(struct console *co, const char *b,
 			}
 		}
 	}
+	spin_unlock_irqrestore(&hp->c_lock, flags);
 	hvc_console_flush(cons_ops[index], vtermnos[index]);
 }
 
@@ -878,9 +878,13 @@ static void hvc_poll_put_char(struct tty_driver *driver, int line, char ch)
 	struct tty_struct *tty = driver->ttys[0];
 	struct hvc_struct *hp = tty->driver_data;
 	int n;
+	unsigned long flags;
 
 	do {
-		n = hp->ops->put_chars(hp->vtermno, &ch, 1);
+		spin_lock_irqsave(&hp->c_lock, flags);
+		hp->c[0] = ch;
+		n = hp->ops->put_chars(hp->vtermno, hp->c, 1);
+		spin_unlock_irqrestore(&hp->c_lock, flags);
 	} while (n <= 0);
 }
 #endif
@@ -922,8 +926,7 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
 			return ERR_PTR(err);
 	}
 
-	hp = kzalloc(ALIGN(sizeof(*hp), sizeof(long)) + outbuf_size,
-			GFP_KERNEL);
+	hp = kzalloc(struct_size(hp, outbuf, outbuf_size), GFP_KERNEL);
 	if (!hp)
 		return ERR_PTR(-ENOMEM);
 
@@ -931,13 +934,13 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
 	hp->data = data;
 	hp->ops = ops;
 	hp->outbuf_size = outbuf_size;
-	hp->outbuf = &((char *)hp)[ALIGN(sizeof(*hp), sizeof(long))];
 
 	tty_port_init(&hp->port);
 	hp->port.ops = &hvc_port_ops;
 
 	INIT_WORK(&hp->tty_resize, hvc_set_winsz);
 	spin_lock_init(&hp->lock);
+	spin_lock_init(&hp->c_lock);
 	mutex_lock(&hvc_structs_mutex);
 
 	/*
diff --git a/drivers/tty/hvc/hvc_console.h b/drivers/tty/hvc/hvc_console.h
index 18d005814..52374e2da 100644
--- a/drivers/tty/hvc/hvc_console.h
+++ b/drivers/tty/hvc/hvc_console.h
@@ -32,13 +32,21 @@
  */
 #define HVC_ALLOC_TTY_ADAPTERS	8
 
+/*
+ * These sizes are most efficient for vio, because they are the
+ * native transfer size. We could make them selectable in the
+ * future to better deal with backends that want other buffer sizes.
+ */
+#define N_OUTBUF	16
+#define N_INBUF		16
+
+#define __ALIGNED__ __attribute__((__aligned__(sizeof(long))))
+
 struct hvc_struct {
 	struct tty_port port;
 	spinlock_t lock;
 	int index;
 	int do_wakeup;
-	char *outbuf;
-	int outbuf_size;
 	int n_outbuf;
 	uint32_t vtermno;
 	const struct hv_ops *ops;
@@ -48,6 +56,10 @@ struct hvc_struct {
 	struct work_struct tty_resize;
 	struct list_head next;
 	unsigned long flags;
+	spinlock_t c_lock;
+	char c[N_OUTBUF] __ALIGNED__;
+	int outbuf_size;
+	char outbuf[0] __ALIGNED__;
 };
 
 /* implemented by a low level driver */
-- 
2.17.1

