Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB602353292
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 06:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhDCEPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 00:15:00 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52925 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhDCEO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 00:14:59 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1334EtBN042147;
        Sat, 3 Apr 2021 13:14:55 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp);
 Sat, 03 Apr 2021 13:14:55 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1334EkKp041831
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 3 Apr 2021 13:14:55 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] tty: use printk_safe context at tty_msg()
Date:   Sat,  3 Apr 2021 13:14:44 +0900
Message-Id: <20210403041444.4081-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is reporting circular locking dependency due to calling printk()
with port lock held [1]. When this problem was reported, we worried
whether printk_safe context will remain available in future kernels [2],
and then this problem was forgotten. But in order to utilize syzbot's
resource for finding other bugs/reproducers by closing this one of top
crashers, let's apply a patch which counts on availability of printk_safe
context.

syzbot is also reporting same dependency due to memory allocation fault
injection at tty_buffer_alloc(). Although __GFP_NOWARN cannot prevent
memory allocation fault injection from calling printk(), let's use
__GFP_NOWARN at tty_buffer_alloc() in addition to using printk_safe
context, for generating many lines of messages due to warn_alloc() is
annoying. If we want to report it, we can use pr_warn() instead.

[1] https://syzkaller.appspot.com/bug?id=39ea6caa479af471183997376dc7e90bc7d64a6a
[2] https://lkml.kernel.org/r/20190218054649.GA26686@jagdpanzerIV

Reported-by: syzbot <syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com>
Reported-by: syzbot <syzbot+3ed715090790806d8b18@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: b6da31b2c07c46f2 ("tty: Fix data race in tty_insert_flip_string_fixed_flag")
Cc: <stable@vger.kernel.org> # 4.18+
---
 drivers/tty/tty_buffer.c | 5 ++++-
 include/linux/tty.h      | 9 ++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 6d4995a5f318..d59f7873bc49 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -156,6 +156,7 @@ static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
 {
 	struct llist_node *free;
 	struct tty_buffer *p;
+	unsigned long flags;
 
 	/* Round the buffer size out */
 	size = __ALIGN_MASK(size, TTYB_ALIGN_MASK);
@@ -172,7 +173,9 @@ static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
 	   have queued and recycle that ? */
 	if (atomic_read(&port->buf.mem_used) > port->buf.mem_limit)
 		return NULL;
-	p = kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC);
+	printk_safe_enter_irqsave(flags);
+	p = kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC | __GFP_NOWARN);
+	printk_safe_exit_irqrestore(flags);
 	if (p == NULL)
 		return NULL;
 
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 95fc2f100f12..7ae8eb46fec3 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -14,6 +14,7 @@
 #include <uapi/linux/tty.h>
 #include <linux/rwsem.h>
 #include <linux/llist.h>
+#include <../../kernel/printk/internal.h>
 
 
 /*
@@ -773,7 +774,13 @@ static inline void proc_tty_unregister_driver(struct tty_driver *d) {}
 #endif
 
 #define tty_msg(fn, tty, f, ...) \
-	fn("%s %s: " f, tty_driver_name(tty), tty_name(tty), ##__VA_ARGS__)
+	do {						\
+		unsigned long flags;			\
+							\
+		printk_safe_enter_irqsave(flags);	\
+		fn("%s %s: " f, tty_driver_name(tty), tty_name(tty), ##__VA_ARGS__); \
+		printk_safe_exit_irqrestore(flags);	\
+	} while (0)
 
 #define tty_debug(tty, f, ...)	tty_msg(pr_debug, tty, f, ##__VA_ARGS__)
 #define tty_info(tty, f, ...)	tty_msg(pr_info, tty, f, ##__VA_ARGS__)
-- 
2.18.4

