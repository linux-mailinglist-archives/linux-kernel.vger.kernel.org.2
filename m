Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C2B3B2D5E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 13:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhFXLOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 07:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbhFXLOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 07:14:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33E0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 04:11:51 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624533110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=57h/eheZ1TjVcwrE98dzFg6VdX4+qrwZWPHxbmUTVXw=;
        b=BuIg6KwYjk0lgzipWpSw5Ni9FaKANpQVejPOPydp75RyF1LwrsPlF4FRZr6tvUUWOQafWz
        7v3QesVGsn8lTDtPwuvdOvbamTFNuesI/46wX/OJ/o9cc8is/1nD5LwJ212bAwkIBUkM+R
        GbR6rbhAlPxRHRhRZsEAmui+e+7+6x+OaHAThiJ/0hBt7s3XPd1iBCOX8rJaTXgZUrw/q6
        vhnVWOrDa+xjsgUCRSlUKF4ZHDwiCcYqa+unJl8NoDrjN858IKZnTO27YaTJC+HMg/Fetl
        DA/a7F1VOTSBNOlETee0G5UPR/neqY4vxHhPCWi/tKxdXhJs58WkAdhWTh5WpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624533110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=57h/eheZ1TjVcwrE98dzFg6VdX4+qrwZWPHxbmUTVXw=;
        b=7iyubBgcf+yAdjb/MO3Wc/QPWK4z0bcM736kOgI9U/yZSaZcaW2VHA3JsY3KoKlK22vsyI
        +lKMRXneIZyHIvDw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 2/6] printk: track/limit recursion
Date:   Thu, 24 Jun 2021 13:17:44 +0206
Message-Id: <20210624111148.5190-3-john.ogness@linutronix.de>
In-Reply-To: <20210624111148.5190-1-john.ogness@linutronix.de>
References: <20210624111148.5190-1-john.ogness@linutronix.de>
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
 kernel/printk/printk.c | 86 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 142a58d124d9..7fa0b4d91975 100644
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

