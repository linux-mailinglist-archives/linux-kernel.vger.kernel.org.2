Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05603447172
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 05:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhKGEyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 00:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbhKGEyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 00:54:11 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55C5C061570
        for <linux-kernel@vger.kernel.org>; Sat,  6 Nov 2021 21:51:28 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id p8so10705046pgh.11
        for <linux-kernel@vger.kernel.org>; Sat, 06 Nov 2021 21:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r2rXjUi6M3dll7CvOnGtJqFYJkBmpr+48DfiX81F9NU=;
        b=CQn+VwESIwE/ZZM9UXD3xig4mCU8abfGyUzrkmgkKHYAzcuJCOlB94RQAdiKJDqz8q
         8LdkIgEcRMC06/YT1YJERTdvpDYQZfP+I0Aq0SxTkEp+HAOgHltkD3D96Ro3PmI17pjH
         MbUO2UxG02A9Jc7mjP/22MvctL45xJmBhCdi0oCWslySGgnYsY3ryJMnmRwba1AARScq
         vBg1bYmCnCFtbkXVMw07mket51zzzsqm440PUanFZJ+xurbCrMXkA8xdHBZSsi9rfOEd
         fRPnota/8lRTTTUUkOnM2BAqdMaQuYQ0e3wUrdyAUZ6XlkWbkHyGAtx4f3RnuSUgTzaE
         pacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r2rXjUi6M3dll7CvOnGtJqFYJkBmpr+48DfiX81F9NU=;
        b=ZKPTLCPYdhEodP3pB/cnmZs1bT1ygI8ns2HVeMGbIwY9N2dBffjp4nDtnQmEUmGyZ3
         3OUWeF5FFEzKMB2eAR8alD8ofpSlbFLmj0iKYTjfMT4L51EQNUDQxDYjeh/TlpRpgsqZ
         fbTeekX32CG1HNRhHdJ7TuSdbKzc6sZAmvivFINlWPfFqgwbIEuJHCvoiDiz9rf5QyIf
         CA3Sl6WoIwm77rqpD73J7dm3ikCUX9TQPzLh+87hiF0i7fP1gb+7jOLgVR6yh+QOOp8f
         GrkTDbCnYj27UJKbuEGBMBUBaD6lEiOoZdMqoJ09c20YMQ98YJgbzcUXxV4UownVbiBs
         lbXg==
X-Gm-Message-State: AOAM533Kixi+0ZjcMx89YZuEj5MZbWSSLtldGLx+uuLyUefLQJOdlufN
        sT+cgK/WgIaCHQ/0kvZv9x5QDQUdg1o=
X-Google-Smtp-Source: ABdhPJyVQjXw3PViUPEj8DWYVeoaaOZ5DxfQSDjpH1x9SWISoV5WXuS073AnxOnhYM5rSRx8DF5+lw==
X-Received: by 2002:a05:6a00:22ca:b0:47e:37e0:8cd with SMTP id f10-20020a056a0022ca00b0047e37e008cdmr71123531pfj.13.1636260687959;
        Sat, 06 Nov 2021 21:51:27 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (60-241-46-56.tpgi.com.au. [60.241.46.56])
        by smtp.gmail.com with ESMTPSA id k16sm5045215pfu.183.2021.11.06.21.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 21:51:27 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] printk: restore flushing of NMI buffers on remote CPUs after NMI backtraces
Date:   Sun,  7 Nov 2021 14:51:16 +1000
Message-Id: <20211107045116.1754411-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

printk from NMI context relies on irq work being raised on the local CPU
to print to console. This can be a problem if the NMI was raised by a
lockup detector to print lockup stack and regs, because the CPU may not
enable irqs (because it is locked up).

Introduce printk_trigger_flush() that can be called another CPU to try
to get those messages to the console, call that where printk_safe_flush
was previously called.

Fixes: 93d102f094be ("printk: remove safe buffers")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/watchdog.c | 6 ++++++
 include/linux/printk.h         | 4 ++++
 kernel/printk/printk.c         | 5 +++++
 lib/nmi_backtrace.c            | 6 ++++++
 4 files changed, 21 insertions(+)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 5f69ba4de1f3..c8017bc23b00 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -227,6 +227,12 @@ static void watchdog_smp_panic(int cpu)
 		cpumask_clear(&wd_smp_cpus_ipi);
 	}
 
+	/*
+	 * Force flush any remote buffers that might be stuck in IRQ context
+	 * and therefore could not run their irq_work.
+	 */
+	printk_trigger_flush();
+
 	if (hardlockup_panic)
 		nmi_panic(NULL, "Hard LOCKUP");
 
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 85b656f82d75..9497f6b98339 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -198,6 +198,7 @@ void dump_stack_print_info(const char *log_lvl);
 void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
+void printk_trigger_flush(void);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -274,6 +275,9 @@ static inline void dump_stack_lvl(const char *log_lvl)
 static inline void dump_stack(void)
 {
 }
+static inline void printk_trigger_flush(void)
+{
+}
 #endif
 
 #ifdef CONFIG_SMP
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index a8d0a58deebc..99221b016c68 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3252,6 +3252,11 @@ void defer_console_output(void)
 	preempt_enable();
 }
 
+void printk_trigger_flush(void)
+{
+	defer_console_output();
+}
+
 int vprintk_deferred(const char *fmt, va_list args)
 {
 	int r;
diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index f9e89001b52e..199ab201d501 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -75,6 +75,12 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
 		touch_softlockup_watchdog();
 	}
 
+	/*
+	 * Force flush any remote buffers that might be stuck in IRQ context
+	 * and therefore could not run their irq_work.
+	 */
+	printk_trigger_flush();
+
 	clear_bit_unlock(0, &backtrace_flag);
 	put_cpu();
 }
-- 
2.23.0

