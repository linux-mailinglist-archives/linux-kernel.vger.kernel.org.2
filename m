Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C74633E231
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 00:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhCPXdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 19:33:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45360 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhCPXd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 19:33:29 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615937608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DPEbS8EENZd+6UxIQP+0wBMd5xtfR6sjyg6AAKLVwXo=;
        b=h9QsPno5Vo/XanI8eiIoM4TeZMNULvO8A7WVWE1Tbpog5WJWGePgJckW2jf+fb+V4f4PZD
        fFY0KO2ZnwQnxEmOKzHxAzq6iST82HTjQy2Tr5DlYK61jYdLd42hN/lxQiV+c+72ynNLH6
        9B+hsw/F23WAvoOzNCrlTSuGPSABptoxr/2B/lcZ9gdozBOLkF5ZRfRf9Se5eaW70aj62o
        7oIgUwakcQWL3woaxLNvPEHN3yb0R//v3fLCHDCC1+MQ4qWrNQAmLHdSpH1s6rDUOYkFcn
        nnaIYz37WQ5MQr8TIXZXHZm970lwor4TcHghWH1Rgj023mhCaYH+qeGwt7HRYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615937608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DPEbS8EENZd+6UxIQP+0wBMd5xtfR6sjyg6AAKLVwXo=;
        b=NI68i/PlYoZl7UuqWa6T+TC23JHnpQ1Ob7daIv2Ld+yoGYEafHBB4ak8uAmi1IPy3cD5ZC
        6Q9qSP6sS4/PXcCA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v1 1/3] printk: track/limit recursion
Date:   Wed, 17 Mar 2021 00:33:24 +0100
Message-Id: <20210316233326.10778-2-john.ogness@linutronix.de>
In-Reply-To: <20210316233326.10778-1-john.ogness@linutronix.de>
References: <20210316233326.10778-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Track printk() recursion and limit it to 3 levels per-CPU and per-context.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 80 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2f829fbf0a13..c666e3e43f0c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1940,6 +1940,71 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
 	}
 }
 
+/*
+ * Recursion is tracked separately on each CPU. If NMIs are supported, an
+ * additional NMI context per CPU is also separately tracked. Until per-CPU
+ * is available, a separate "early tracking" is performed.
+ */
+#ifdef CONFIG_PRINTK_NMI
+#define PRINTK_CTX_NUM 2
+#else
+#define PRINTK_CTX_NUM 1
+#endif
+static DEFINE_PER_CPU(char [PRINTK_CTX_NUM], printk_count);
+static char printk_count_early[PRINTK_CTX_NUM];
+
+/*
+ * Recursion is limited to keep the output sane. printk() should not require
+ * more than 1 level of recursion (allowing, for example, printk() to trigger
+ * a WARN), but a higher value is used in case some printk-internal errors
+ * exist, such as the ringbuffer validation checks failing.
+ */
+#define PRINTK_MAX_RECURSION 3
+
+/* Return a pointer to the dedicated counter for the CPU+context of the caller. */
+static char *printk_recursion_counter(void)
+{
+	int ctx = 0;
+
+#ifdef CONFIG_PRINTK_NMI
+	if (in_nmi())
+		ctx = 1;
+#endif
+	if (!printk_percpu_data_ready())
+		return &printk_count_early[ctx];
+	return &((*this_cpu_ptr(&printk_count))[ctx]);
+}
+
+/*
+ * Enter recursion tracking. Interrupts are disabled to simplify tracking.
+ * The caller must check the return value to see if the recursion is allowed.
+ * On failure, interrupts are not disabled.
+ */
+static bool printk_enter_irqsave(unsigned long *flags)
+{
+	char *count;
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
+	char *count;
+
+	count = printk_recursion_counter();
+	(*count)--;
+	local_irq_restore(flags);
+}
+
 int printk_delay_msec __read_mostly;
 
 static inline void printk_delay(void)
@@ -2040,11 +2105,13 @@ int vprintk_store(int facility, int level,
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
@@ -2055,6 +2122,9 @@ int vprintk_store(int facility, int level,
 	 */
 	ts_nsec = local_clock();
 
+	if (!printk_enter_irqsave(&irqflags))
+		return 0;
+
 	/*
 	 * The sprintf needs to come first since the syslog prefix might be
 	 * passed in as a parameter. An extra byte must be reserved so that
@@ -2092,7 +2162,8 @@ int vprintk_store(int facility, int level,
 				prb_commit(&e);
 			}
 
-			return text_len;
+			ret = text_len;
+			goto out;
 		}
 	}
 
@@ -2108,7 +2179,7 @@ int vprintk_store(int facility, int level,
 
 		prb_rec_init_wr(&r, reserve_size + trunc_msg_len);
 		if (!prb_reserve(&e, prb, &r))
-			return 0;
+			goto out;
 	}
 
 	/* fill message */
@@ -2130,7 +2201,10 @@ int vprintk_store(int facility, int level,
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

