Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE0545C927
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 16:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242191AbhKXPwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 10:52:05 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57400 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbhKXPwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 10:52:03 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4E2C21FD2F;
        Wed, 24 Nov 2021 15:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637768932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=1cpS9WLkafUTWfWpKQaff/p3/s6mJTk8B5Fq1cl8zNI=;
        b=oaGTGXXFGdznXQyZ4LhIyDftIkyJ03l2Slt8fm+1a92KrIC2dFoIL5Q8RwD8UAELAT94Pz
        hY8Oo/A0EFxnC3edMllAqblRxwU1DR6UV03CywIGS44VRWjhRa0hxJ75Jse5Tg++n/BppO
        B2M7Ikcv7LlWnXS8aOsErXXxqQmO8O4=
Received: from alley.suse.cz (unknown [10.100.224.162])
        by relay2.suse.de (Postfix) with ESMTP id C5756A3B81;
        Wed, 24 Nov 2021 15:48:51 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [RFC] printk: More consistent loglevel for continuous lines
Date:   Wed, 24 Nov 2021 16:48:38 +0100
Message-Id: <20211124154838.5415-1-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pr_cont() tries to append the message to the previous one. It works
when the last message in the logbuffer was added by the same process
and IRQ context. Otherwise, it is stored as a new message with
the default message loglevel.

CONFIG_MESSAGE_LOGLEVEL_DEFAULT is "4" by default. It means that
the non-appendable pieces are printed with KERN_WARNING.

Many people monitor only more serial messages, including warnings.
They are confused when they see partial messages that do not make
any sense without the context. They even do not have any chance
to see the context when it is filtered by console_loglevel.

The commit 4bcc595ccd80decb424509 ("printk: reinstate KERN_CONT for
printing continuation lines") added possibility to define a particular
loglevel together with KERN_CONT, for example:

   pr_cont(KERN_INFO "more bla bla");

It has been added in v4.9-rc1, 5 years ago. But it seems that nobody
has used it since then. It is possible that people do not know about
it or nobody cared enough.

Anyway, it looks a bit non-practical to update all existing pr_cont()
callers:

	$> git grep "pr_cont" | wc -l
	2054

There seems to be much easier solution. We could remember the last
used loglevel per-context and use it for the continuous lines.

Note that it does not help when another message is printed between
the pieces in the same context, for example, a nested warning.
In this case, the explicit log level would work better. But the saved
loglevel should be good enough in most cases because pr_cont() is often
used in a relatively simple self-contained code. Also the same
caller is easy to detect when CONFIG_PRINTK_CALLER is enabled.

Is it worth it?

On one hand, printk() is the best effort approach. Messages are lost
when the logbuffer is overwritten before they are read by userspace
log daemons and shown on consoles. The continuous lines are even less
reliable. Only the last messages can be appended. Any temporary buffering
might cause losing the messages when the system crashes.

On the other hand, we have already accepted a lot of complexity by
introducing the record based logbuffer format. It was because
people wanted to have as consistent messages as possible.

pr_cont() is heavily used and removes ugly twists in the callers' code.
Some code complexity is acceptable on the printk() side.

The proposed solution is self-contained and quite trivial. It looks
worth trying.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/sched.h  |  4 +++
 kernel/printk/printk.c | 74 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 78c351e35fec..4a23f3341d29 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1140,6 +1140,10 @@ struct task_struct {
 	int				softirq_disable_cnt;
 #endif
 
+#ifdef CONFIG_PRINTK
+	u8				printk_loglevel;
+#endif
+
 #ifdef CONFIG_LOCKDEP
 # define MAX_LOCK_DEPTH			48UL
 	u64				curr_chain_key;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 57b132b658e1..b644dee8f897 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2021,6 +2021,62 @@ static inline u32 printk_caller_id(void)
 		0x80000000 + raw_smp_processor_id();
 }
 
+/* Support to use the loglevel of the last message for continuous lines. */
+#ifdef CONFIG_HAVE_NMI
+#define PRINTK_IRQ_CTX_NUM	3
+#else
+#define PRINTK_IRQ_CTX_NUM	2
+#endif
+
+static DEFINE_PER_CPU(u8, printk_loglevel_irq_ctx[PRINTK_IRQ_CTX_NUM]);
+static u8 printk_loglevel_irq_ctx_early[PRINTK_IRQ_CTX_NUM];
+
+/* Return pointer where the loglevel is stored for the current context. */
+static u8 *printk_loglevel_ctx_var(void)
+{
+	unsigned char irq_ctx_level = interrupt_context_level();
+
+	/* normal process context */
+	if (irq_ctx_level == 0)
+		return &current->printk_loglevel;
+
+	/* IRQ context */
+	if (WARN_ON_ONCE(irq_ctx_level > PRINTK_IRQ_CTX_NUM))
+		return NULL;
+
+	if (printk_percpu_data_ready())
+		return this_cpu_ptr(&printk_loglevel_irq_ctx[irq_ctx_level - 1]);
+	else
+		return &printk_loglevel_irq_ctx_early[irq_ctx_level - 1];
+}
+
+static void printk_write_loglevel_ctx(int loglevel)
+{
+	u8 *loglevel_var = printk_loglevel_ctx_var();
+
+	if (!loglevel_var)
+		return;
+
+	/*
+	 * Remember only the really used loglevels that can be stored
+	 * within 3 bytes in struct printk_info.
+	 */
+	if (WARN_ON_ONCE(loglevel != LOG_LEVEL(loglevel)))
+		return;
+
+	*loglevel_var = loglevel;
+}
+
+static u8 printk_read_loglevel_ctx(void)
+{
+	u8 *loglevel_var = printk_loglevel_ctx_var();
+
+	if (!loglevel_var)
+		return LOGLEVEL_DEFAULT;
+
+	return *loglevel_var;
+}
+
 /**
  * printk_parse_prefix - Parse level and control flags.
  *
@@ -2066,6 +2122,21 @@ u16 printk_parse_prefix(const char *text, int *level,
 	return prefix_len;
 }
 
+static int printk_sanitize_loglevel(int loglevel, enum printk_info_flags flags)
+{
+	/* For continuous lines, fallback to the previously used loglevel. */
+	if (flags & LOG_CONT && loglevel == LOGLEVEL_DEFAULT)
+		loglevel = printk_read_loglevel_ctx();
+
+	if (loglevel == LOGLEVEL_DEFAULT)
+		loglevel = default_message_loglevel;
+
+	/* Remember the really used loglevel for this context. */
+	printk_write_loglevel_ctx(loglevel);
+
+	return loglevel;
+}
+
 __printf(5, 0)
 static u16 printk_sprint(char *text, u16 size, int facility,
 			 enum printk_info_flags *flags, const char *fmt,
@@ -2142,8 +2213,7 @@ int vprintk_store(int facility, int level,
 	if (facility == 0)
 		printk_parse_prefix(&prefix_buf[0], &level, &flags);
 
-	if (level == LOGLEVEL_DEFAULT)
-		level = default_message_loglevel;
+	level = printk_sanitize_loglevel(level, flags);
 
 	if (dev_info)
 		flags |= LOG_NEWLINE;
-- 
2.26.2

