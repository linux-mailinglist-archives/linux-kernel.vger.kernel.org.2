Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6571834ECAD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbhC3PgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:36:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44712 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbhC3Pf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:35:27 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617118514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hpZPpb5s+OSli12JBjIDbKsYD4lp7jELMHC4ub4txEU=;
        b=3GEqpILKrmNr1t28obDNP1E6FiKei10EqzscgL0r09ZnkQjgjy4bjBWE7vTfPFt0AocKmz
        UOHMPD01lgEZSiX9JNZ3mtEovd4QIyVi39OJWLbeeHUO72wnE2b4YInp1g+I/sn2YyjKrK
        VUlsezD7c0GrSYomdJz/0oCh/cg3I7aJWN3eKhlw55Vm+ASc7BQje1AQSUThxR/RMjZoW3
        ieZxqUwQDaaOEo96lqYIVxIf5mQAleyvjt6vfNVJHDRTcj4tKLsZ3LZFOPsjUjaRgUg+0F
        7zF34rE/UYQ1suDv/Nc1EzVFmux0VBxuWPqBnnNF01DhReFXVnd68fr76ueK6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617118514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hpZPpb5s+OSli12JBjIDbKsYD4lp7jELMHC4ub4txEU=;
        b=wZxfjMiNhE9arFFJFe2w1EV+Cpc6xg9RX/ATAXQQ4eJLdugR02KW2fXp+hd4rHgtbaoEPD
        Otk0W2IE+9shhkDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 1/5] printk: track/limit recursion
Date:   Tue, 30 Mar 2021 17:35:08 +0200
Message-Id: <20210330153512.1182-2-john.ogness@linutronix.de>
In-Reply-To: <20210330153512.1182-1-john.ogness@linutronix.de>
References: <20210330153512.1182-1-john.ogness@linutronix.de>
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
---
 kernel/printk/printk.c | 83 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 421c35571797..e971c0a9ec9e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1940,6 +1940,74 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
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
+static u8 *printk_recursion_counter(void)
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
+ * The caller must check the return value to see if the recursion is allowed.
+ * On failure, interrupts are not disabled.
+ */
+static bool printk_enter_irqsave(unsigned long *flags)
+{
+	u8 *count;
+
+	local_irq_save(*flags);
+	count = printk_recursion_counter();
+	if (*count > PRINTK_MAX_RECURSION) {
+		local_irq_restore(*flags);
+		return false;
+	}
+	(*count)++;
+
+	return true;
+}
+
+/* Exit recursion tracking, restoring interrupts. */
+static void printk_exit_irqrestore(unsigned long flags)
+{
+	u8 *count;
+
+	count = printk_recursion_counter();
+	(*count)--;
+	local_irq_restore(flags);
+}
+
 int printk_delay_msec __read_mostly;
 
 static inline void printk_delay(void)
@@ -2040,11 +2108,13 @@ int vprintk_store(int facility, int level,
 	struct prb_reserved_entry e;
 	enum log_flags lflags = 0;
 	struct printk_record r;
+	unsigned long irqflags;
 	u16 trunc_msg_len = 0;
 	char prefix_buf[8];
 	u16 reserve_size;
 	va_list args2;
 	u16 text_len;
+	int ret = 0;
 	u64 ts_nsec;
 
 	/*
@@ -2055,6 +2125,9 @@ int vprintk_store(int facility, int level,
 	 */
 	ts_nsec = local_clock();
 
+	if (!printk_enter_irqsave(&irqflags))
+		return 0;
+
 	/*
 	 * The sprintf needs to come first since the syslog prefix might be
 	 * passed in as a parameter. An extra byte must be reserved so that
@@ -2092,7 +2165,8 @@ int vprintk_store(int facility, int level,
 				prb_commit(&e);
 			}
 
-			return text_len;
+			ret = text_len;
+			goto out;
 		}
 	}
 
@@ -2108,7 +2182,7 @@ int vprintk_store(int facility, int level,
 
 		prb_rec_init_wr(&r, reserve_size + trunc_msg_len);
 		if (!prb_reserve(&e, prb, &r))
-			return 0;
+			goto out;
 	}
 
 	/* fill message */
@@ -2130,7 +2204,10 @@ int vprintk_store(int facility, int level,
 	else
 		prb_final_commit(&e);
 
-	return (text_len + trunc_msg_len);
+	ret = text_len + trunc_msg_len;
+out:
+	printk_exit_irqrestore(irqflags);
+	return ret;
 }
 
 asmlinkage int vprintk_emit(int facility, int level,
-- 
2.20.1

