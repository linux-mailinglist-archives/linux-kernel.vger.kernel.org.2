Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645C63CAD45
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 21:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242105AbhGOT40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 15:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347252AbhGOTwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 15:52:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B913C061762
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 12:34:03 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626377641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JJ21FxtuFR+FumgV0AWpYS6juqkOZR6mM/sh6Q9pi2g=;
        b=uhGrnl9pf15geKoJNNRPLO/SsO2ZfQ4ZAsvtOAe2uECHCezE5iOvQBbyrY9VujSmvNBbsl
        d/jMpr+hx6IxVLRnw79p8WiDBOXzfSBY9YEGRmYWRd22sXnbIzHO5AMQFIntttdeZDn4Xa
        aSzYaRUyo2sW9xnSxFoDc7f9W4fxet+SJoFCVVcovmRwe6/0uAMW0J/VMVwtSUFt68BDYy
        Ff0ZzaZ7EfTRZdyziakwAhQZpyMJys9xPLl+VlYCXyZl1Y0OH66lhHpQRoeho9ErT1t4bc
        LDxzH40ixeWFCxzM8YPWsoRp8y5sGfVifQ3WweB7CHVpQzHvABryjqHMWJ0luQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626377641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JJ21FxtuFR+FumgV0AWpYS6juqkOZR6mM/sh6Q9pi2g=;
        b=+K7leu4YpCTymyFilTX9m5EGJRfpQYHmGvsEhgqR/uPQqleTOF92k3pGM/o3i/moKZpiKu
        wQbFiHT5ooa5acBw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 2/6] printk: track/limit recursion
Date:   Thu, 15 Jul 2021 21:39:55 +0206
Message-Id: <20210715193359.25946-3-john.ogness@linutronix.de>
In-Reply-To: <20210715193359.25946-1-john.ogness@linutronix.de>
References: <20210715193359.25946-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the printk safe buffers provide a form of recursion
protection by redirecting to the safe buffers whenever printk() is
recursively called.

In preparation for removal of the safe buffers, provide an alternate
explicit recursion protection. Recursion is limited to 3 levels
per-CPU and per-context.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 86 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6dad7da8f383..2f9d783373ed 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1940,6 +1940,76 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
 	}
 }
 
+/*
+ * Recursion is tracked separately on each CPU. If NMIs are supported, an
+ * additional NMI context per CPU is also separately tracked. Until per-CPU
+ * is available, a separate "early tracking" is performed.
+ */
+static DEFINE_PER_CPU(u8, printk_count);
+static u8 printk_count_early;
+#ifdef CONFIG_HAVE_NMI
+static DEFINE_PER_CPU(u8, printk_count_nmi);
+static u8 printk_count_nmi_early;
+#endif
+
+/*
+ * Recursion is limited to keep the output sane. printk() should not require
+ * more than 1 level of recursion (allowing, for example, printk() to trigger
+ * a WARN), but a higher value is used in case some printk-internal errors
+ * exist, such as the ringbuffer validation checks failing.
+ */
+#define PRINTK_MAX_RECURSION 3
+
+/*
+ * Return a pointer to the dedicated counter for the CPU+context of the
+ * caller.
+ */
+static u8 *__printk_recursion_counter(void)
+{
+#ifdef CONFIG_HAVE_NMI
+	if (in_nmi()) {
+		if (printk_percpu_data_ready())
+			return this_cpu_ptr(&printk_count_nmi);
+		return &printk_count_nmi_early;
+	}
+#endif
+	if (printk_percpu_data_ready())
+		return this_cpu_ptr(&printk_count);
+	return &printk_count_early;
+}
+
+/*
+ * Enter recursion tracking. Interrupts are disabled to simplify tracking.
+ * The caller must check the boolean return value to see if the recursion is
+ * allowed. On failure, interrupts are not disabled.
+ *
+ * @recursion_ptr must be a variable of type (u8 *) and is the same variable
+ * that is passed to printk_exit_irqrestore().
+ */
+#define printk_enter_irqsave(recursion_ptr, flags)	\
+({							\
+	bool success = true;				\
+							\
+	typecheck(u8 *, recursion_ptr);			\
+	local_irq_save(flags);				\
+	(recursion_ptr) = __printk_recursion_counter();	\
+	if (*(recursion_ptr) > PRINTK_MAX_RECURSION) {	\
+		local_irq_restore(flags);		\
+		success = false;			\
+	} else {					\
+		(*(recursion_ptr))++;			\
+	}						\
+	success;					\
+})
+
+/* Exit recursion tracking, restoring interrupts. */
+#define printk_exit_irqrestore(recursion_ptr, flags)	\
+	do {						\
+		typecheck(u8 *, recursion_ptr);		\
+		(*(recursion_ptr))--;			\
+		local_irq_restore(flags);		\
+	} while (0)
+
 int printk_delay_msec __read_mostly;
 
 static inline void printk_delay(void)
@@ -2040,11 +2110,14 @@ int vprintk_store(int facility, int level,
 	struct prb_reserved_entry e;
 	enum log_flags lflags = 0;
 	struct printk_record r;
+	unsigned long irqflags;
 	u16 trunc_msg_len = 0;
 	char prefix_buf[8];
+	u8 *recursion_ptr;
 	u16 reserve_size;
 	va_list args2;
 	u16 text_len;
+	int ret = 0;
 	u64 ts_nsec;
 
 	/*
@@ -2055,6 +2128,9 @@ int vprintk_store(int facility, int level,
 	 */
 	ts_nsec = local_clock();
 
+	if (!printk_enter_irqsave(recursion_ptr, irqflags))
+		return 0;
+
 	/*
 	 * The sprintf needs to come first since the syslog prefix might be
 	 * passed in as a parameter. An extra byte must be reserved so that
@@ -2092,7 +2168,8 @@ int vprintk_store(int facility, int level,
 				prb_commit(&e);
 			}
 
-			return text_len;
+			ret = text_len;
+			goto out;
 		}
 	}
 
@@ -2108,7 +2185,7 @@ int vprintk_store(int facility, int level,
 
 		prb_rec_init_wr(&r, reserve_size + trunc_msg_len);
 		if (!prb_reserve(&e, prb, &r))
-			return 0;
+			goto out;
 	}
 
 	/* fill message */
@@ -2130,7 +2207,10 @@ int vprintk_store(int facility, int level,
 	else
 		prb_final_commit(&e);
 
-	return (text_len + trunc_msg_len);
+	ret = text_len + trunc_msg_len;
+out:
+	printk_exit_irqrestore(recursion_ptr, irqflags);
+	return ret;
 }
 
 asmlinkage int vprintk_emit(int facility, int level,
-- 
2.20.1

