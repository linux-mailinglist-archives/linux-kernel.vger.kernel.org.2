Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F353207B2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 00:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhBTXbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 18:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhBTXXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 18:23:22 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D860DC0617A9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 15:22:34 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id t25so7782462pga.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 15:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7M+92SgST0WvDA4OozZDloQac7xs4/nLD+KIsErn5co=;
        b=jpyVOblqrhBJhysj61sDEaWuP3uNMnPmmGPmeRxkHlgoY1JlEmx/Ngem7bIQASCq3o
         7rxUFlSHzvUt8N+m46OFrl4i5uQ1P6sMjzGm6BshhpcKXtxzpR7hmYzRQ/xUucjW+V2r
         jAPgqTfk22Da/WuKRQ2NE337UwqOnCKxT8EYbRP/6ych0LvyY5cGj2rmPjMjTUsIZGPw
         lx7z87xLwXnyMUc56LDjucvQpM0wYZSYxM+7D9V7Phz2fPl8QK/wkUUPHpSjf3iYLYc2
         jkC+T2cJQ8aXjbX/kBgYXrnlISr5CeKalnjTVkcvnkRgGfA3+49vGuRS1pBi9mAgd4Kr
         RPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7M+92SgST0WvDA4OozZDloQac7xs4/nLD+KIsErn5co=;
        b=q/UoNG2Bwguz4+20nOR+HZYqaOIARUfIwx++RdbN/ci7KhW/XuKgXsbG8yKq5VxRMj
         1ThQB6d4NuFbaEXVkvNBnU9M5RK7TQU75rd8ybmc1Ojm0s+f64GqNhS5sQn6vm3ms2Kl
         tweeElRbBLDM91ukZtgBFPMhMaRHruSJqPDOeXnNtecDhoZ2W+mWnQptVaKMz3lqOggF
         yo26PuPx54wZFvfcrzgb9PEcVbXjo3fPrAworLw3cQ6oJ7GNeYKWx4CFKJ2AiMallolT
         I39SfBsBFrDxLuYxqU57c4g88Tiaf2o8B90pNk2U1O0OzSXDLd4q5RYOZaGNJnqVdRtA
         WGcQ==
X-Gm-Message-State: AOAM53141xPK5JkNsD0oTEBldKC5aeGHwpIHL9fyWB2tJZXqfLKvpZji
        Wm70CZg1+2PBZyjUkgZTm7bcGgRIpMW/WQ==
X-Google-Smtp-Source: ABdhPJxR6DKm+ypePtXJH7jAr7A41rGfB13cNV8t41wg6+F1nCyEsZq7H7gnjkSysMFsIP1jnOVD2g==
X-Received: by 2002:aa7:8d04:0:b029:1ed:2328:f677 with SMTP id j4-20020aa78d040000b02901ed2328f677mr8028075pfe.26.1613863353878;
        Sat, 20 Feb 2021 15:22:33 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id 4sm13171538pjc.23.2021.02.20.15.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 15:22:33 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v6 9/9] smp: inline on_each_cpu_cond() and on_each_cpu()
Date:   Sat, 20 Feb 2021 15:17:12 -0800
Message-Id: <20210220231712.2475218-10-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210220231712.2475218-1-namit@vmware.com>
References: <20210220231712.2475218-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Simplify the code and avoid having an additional function on the stack
by inlining on_each_cpu_cond() and on_each_cpu().

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 include/linux/smp.h | 50 ++++++++++++++++++++++++++++------------
 kernel/smp.c        | 56 ---------------------------------------------
 2 files changed, 36 insertions(+), 70 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 70c6f6284dcf..84a0b4828f66 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -50,30 +50,52 @@ extern unsigned int total_cpus;
 int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
 			     int wait);
 
+void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
+			   void *info, bool wait, const struct cpumask *mask);
+
+int smp_call_function_single_async(int cpu, call_single_data_t *csd);
+
 /*
  * Call a function on all processors
  */
-void on_each_cpu(smp_call_func_t func, void *info, int wait);
+static inline void on_each_cpu(smp_call_func_t func, void *info, int wait)
+{
+	on_each_cpu_cond_mask(NULL, func, info, wait, cpu_online_mask);
+}
 
-/*
- * Call a function on processors specified by mask, which might include
- * the local one.
+/**
+ * on_each_cpu_mask(): Run a function on processors specified by
+ * cpumask, which may include the local processor.
+ * @mask: The set of cpus to run on (only runs on online subset).
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @wait: If true, wait (atomically) until function has completed
+ *        on other CPUs.
+ *
+ * If @wait is true, then returns once @func has returned.
+ *
+ * You must not call this function with disabled interrupts or from a
+ * hardware interrupt handler or from a bottom half handler.  The
+ * exception is that it may be used during early boot while
+ * early_boot_irqs_disabled is set.
  */
-void on_each_cpu_mask(const struct cpumask *mask, smp_call_func_t func,
-		void *info, bool wait);
+static inline void on_each_cpu_mask(const struct cpumask *mask,
+				    smp_call_func_t func, void *info, bool wait)
+{
+	on_each_cpu_cond_mask(NULL, func, info, wait, mask);
+}
 
 /*
  * Call a function on each processor for which the supplied function
  * cond_func returns a positive value. This may include the local
- * processor.
+ * processor.  May be used during early boot while early_boot_irqs_disabled is
+ * set. Use local_irq_save/restore() instead of local_irq_disable/enable().
  */
-void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
-		      void *info, bool wait);
-
-void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
-			   void *info, bool wait, const struct cpumask *mask);
-
-int smp_call_function_single_async(int cpu, call_single_data_t *csd);
+static inline void on_each_cpu_cond(smp_cond_func_t cond_func,
+				    smp_call_func_t func, void *info, bool wait)
+{
+	on_each_cpu_cond_mask(cond_func, func, info, wait, cpu_online_mask);
+}
 
 #ifdef CONFIG_SMP
 
diff --git a/kernel/smp.c b/kernel/smp.c
index c8a5a1facc1a..b6375d775e93 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -847,55 +847,6 @@ void __init smp_init(void)
 	smp_cpus_done(setup_max_cpus);
 }
 
-/*
- * Call a function on all processors.  May be used during early boot while
- * early_boot_irqs_disabled is set.  Use local_irq_save/restore() instead
- * of local_irq_disable/enable().
- */
-void on_each_cpu(smp_call_func_t func, void *info, int wait)
-{
-	unsigned long flags;
-
-	preempt_disable();
-	smp_call_function(func, info, wait);
-	local_irq_save(flags);
-	func(info);
-	local_irq_restore(flags);
-	preempt_enable();
-}
-EXPORT_SYMBOL(on_each_cpu);
-
-/**
- * on_each_cpu_mask(): Run a function on processors specified by
- * cpumask, which may include the local processor.
- * @mask: The set of cpus to run on (only runs on online subset).
- * @func: The function to run. This must be fast and non-blocking.
- * @info: An arbitrary pointer to pass to the function.
- * @wait: If true, wait (atomically) until function has completed
- *        on other CPUs.
- *
- * If @wait is true, then returns once @func has returned.
- *
- * You must not call this function with disabled interrupts or from a
- * hardware interrupt handler or from a bottom half handler.  The
- * exception is that it may be used during early boot while
- * early_boot_irqs_disabled is set.
- */
-void on_each_cpu_mask(const struct cpumask *mask, smp_call_func_t func,
-			void *info, bool wait)
-{
-	unsigned int scf_flags;
-
-	scf_flags = SCF_RUN_LOCAL;
-	if (wait)
-		scf_flags |= SCF_WAIT;
-
-	preempt_disable();
-	smp_call_function_many_cond(mask, func, info, scf_flags, NULL);
-	preempt_enable();
-}
-EXPORT_SYMBOL(on_each_cpu_mask);
-
 /*
  * on_each_cpu_cond(): Call a function on each processor for which
  * the supplied function cond_func returns true, optionally waiting
@@ -932,13 +883,6 @@ void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
 }
 EXPORT_SYMBOL(on_each_cpu_cond_mask);
 
-void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
-		      void *info, bool wait)
-{
-	on_each_cpu_cond_mask(cond_func, func, info, wait, cpu_online_mask);
-}
-EXPORT_SYMBOL(on_each_cpu_cond);
-
 static void do_nothing(void *unused)
 {
 }
-- 
2.25.1

