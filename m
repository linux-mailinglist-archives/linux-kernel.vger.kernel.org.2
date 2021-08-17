Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E933EED43
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 15:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239873AbhHQNXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 09:23:41 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:52625 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237479AbhHQNXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 09:23:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UjPoNEN_1629206583;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0UjPoNEN_1629206583)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 17 Aug 2021 21:23:03 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org, amit@kernel.org,
        arnd@arndb.de, osandov@fb.com
Cc:     linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH v7 1/2] tty: hvc: pass DMA capable memory to put_chars()
Date:   Tue, 17 Aug 2021 21:22:59 +0800
Message-Id: <20210817132300.165014-2-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210817132300.165014-1-xianting.tian@linux.alibaba.com>
References: <20210817132300.165014-1-xianting.tian@linux.alibaba.com>
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

Other fix is use L1_CACHE_BYTES as the alignment, use 'sizeof(long)' as
dma alignment is wrong. And use struct_size() to calculate size of
hvc_struct.

Introduce another array(cons_hvcs[]) for hvc_struct pointers next to
the cons_ops[] and vtermnos[] arrays. With the array, we can easily find
the hp, instead of traversing hp list.

With the patch, we can remove the fix c4baad5029.

We tested the patch, it worked normally.

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 drivers/tty/hvc/hvc_console.c | 39 +++++++++++++++++++++--------------
 drivers/tty/hvc/hvc_console.h | 16 ++++++++++++--
 2 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 5bb8c4e44..b882ceb5f 100644
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
 
@@ -142,6 +132,7 @@ static int hvc_flush(struct hvc_struct *hp)
 static const struct hv_ops *cons_ops[MAX_NR_HVC_CONSOLES];
 static uint32_t vtermnos[MAX_NR_HVC_CONSOLES] =
 	{[0 ... MAX_NR_HVC_CONSOLES - 1] = -1};
+static struct hvc_struct *cons_hvcs[MAX_NR_HVC_CONSOLES];
 
 /*
  * Console APIs, NOT TTY.  These APIs are available immediately when
@@ -151,9 +142,11 @@ static uint32_t vtermnos[MAX_NR_HVC_CONSOLES] =
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
@@ -163,6 +156,13 @@ static void hvc_console_print(struct console *co, const char *b,
 	if (vtermnos[index] == -1)
 		return;
 
+	hp = cons_hvcs[index];
+	if (!hp || !hp->c)
+		return;
+
+	c = hp->c;
+
+	spin_lock_irqsave(&hp->c_lock, flags);
 	while (count > 0 || i > 0) {
 		if (count > 0 && i < sizeof(c)) {
 			if (b[n] == '\n' && !donecr) {
@@ -191,6 +191,7 @@ static void hvc_console_print(struct console *co, const char *b,
 			}
 		}
 	}
+	spin_unlock_irqrestore(&hp->c_lock, flags);
 	hvc_console_flush(cons_ops[index], vtermnos[index]);
 }
 
@@ -878,9 +879,16 @@ static void hvc_poll_put_char(struct tty_driver *driver, int line, char ch)
 	struct tty_struct *tty = driver->ttys[0];
 	struct hvc_struct *hp = tty->driver_data;
 	int n;
+	unsigned long flags;
+
+	if (!hp || !hp->c)
+		return;
 
 	do {
-		n = hp->ops->put_chars(hp->vtermno, &ch, 1);
+		spin_lock_irqsave(&hp->c_lock, flags);
+		hp->c[0] = ch;
+		n = hp->ops->put_chars(hp->vtermno, hp->c, 1);
+		spin_unlock_irqrestore(&hp->c_lock, flags);
 	} while (n <= 0);
 }
 #endif
@@ -922,8 +930,7 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
 			return ERR_PTR(err);
 	}
 
-	hp = kzalloc(ALIGN(sizeof(*hp), sizeof(long)) + outbuf_size,
-			GFP_KERNEL);
+	hp = kzalloc(struct_size(hp, outbuf, outbuf_size), GFP_KERNEL);
 	if (!hp)
 		return ERR_PTR(-ENOMEM);
 
@@ -931,13 +938,13 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
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
@@ -964,6 +971,7 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
 	if (i < MAX_NR_HVC_CONSOLES) {
 		cons_ops[i] = ops;
 		vtermnos[i] = vtermno;
+		cons_hvcs[i] = hp;
 	}
 
 	list_add_tail(&(hp->next), &hvc_structs);
@@ -988,6 +996,7 @@ int hvc_remove(struct hvc_struct *hp)
 	if (hp->index < MAX_NR_HVC_CONSOLES) {
 		vtermnos[hp->index] = -1;
 		cons_ops[hp->index] = NULL;
+		cons_hvcs[hp->index] = NULL;
 	}
 
 	/* Don't whack hp->irq because tty_hangup() will need to free the irq. */
diff --git a/drivers/tty/hvc/hvc_console.h b/drivers/tty/hvc/hvc_console.h
index 18d005814..97a5f1e0f 100644
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
+#define __ALIGNED__ __attribute__((__aligned__(L1_CACHE_BYTES)))
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

