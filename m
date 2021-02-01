Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9988030A54F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbhBAK2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbhBAK2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:28:17 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02C4C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 02:27:35 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id e12so516321pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 02:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1MTIHhJX1O4hk4+Ti0yHeouXkswp7Flek8M1CIpakcY=;
        b=Tf6B8EjTVy1LlLvwHSfx7T2lX46ujALgbNUlaMw1atfoBcsBLVEU2NNBxZ+GAxeTRw
         hvWk6jWV6LzM5ifTxILcCZ9mFFuoo9halqlrEw2f2hSiqfsrmA0zdsSSFV3XcuvfiHeI
         7brBcC08z4PJfhzjBj4udS0VIfVa3akjzhdqPkR4wZYcUbpeO7CY/CidltL/zwZTflR5
         fEmbw7jfLnzIYNV4hShfG7moHtbxWIvvKnkQu/xrxAHFxb2HI2azAi7MQzNwStuCZZ17
         4s7UErvkzXDC3TLBwgJdyPymanOZAsPXAhKkkzVY89/QO2yG5DkmFr0vzgqMJuVUcO8b
         930g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1MTIHhJX1O4hk4+Ti0yHeouXkswp7Flek8M1CIpakcY=;
        b=CuE6kQrKNnfl2YSyMN5OREUlLuJmxd8iOtQFKrhcGTv44/EE7UIYUZUpRnM/7OCMqZ
         9f+r0DNEVfUnKFwo5ahx7qWDgxGc/30EVxoC0Em3veGJ10HwdiPcIitXHI6eMGPvlz4m
         g9fbItAu8s++yJA/jkLN6jJ/OBjrty0cdYeWdwSiqcQeWKMBDogakA02SJ6tZ7Ia1/vn
         BMZMFFF8quikw7qi+DhSYYiCoJu1cVkWKv3Hv+S1UagL3JhrI/94t4UM/yZVftt8lnaJ
         wC50kYvCtwZS/2Xqnkw2VI21m9uxN3nkVNOGS4VobU2hnNy9LOz9LU+OEgkAfMOzJaEc
         v0fQ==
X-Gm-Message-State: AOAM533W0Ij7r0zk3penmJiG1SjA4Dp7Qeoqs/QnngQGtyEdHDXBACSa
        hoA1FKGl2nwjz6EpuCaUglN7Qg==
X-Google-Smtp-Source: ABdhPJzU+gbbyIUZvww1kouBfaZ6Rk2clS+zQkw2+01BvPBIshmv1YHaWAUsXVTy11RmOnDVacJzTQ==
X-Received: by 2002:a17:90a:9414:: with SMTP id r20mr15932562pjo.222.1612175255433;
        Mon, 01 Feb 2021 02:27:35 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id e12sm17995218pga.13.2021.02.01.02.27.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 02:27:34 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] printk: fix deadlock when kernel panic
Date:   Mon,  1 Feb 2021 18:26:01 +0800
Message-Id: <20210201102601.87168-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found a deadlock bug on our server when the kernel panic. It can be
described in the following diagram.

CPU0:                                         CPU1:
panic                                         rcu_dump_cpu_stacks
  kdump_nmi_shootdown_cpus                      nmi_trigger_cpumask_backtrace
    register_nmi_handler(crash_nmi_callback)      printk_safe_flush
                                                    __printk_safe_flush
                                                      raw_spin_lock_irqsave(&read_lock)
    // send NMI to other processors
    apic_send_IPI_allbutself(NMI_VECTOR)
                                                        // NMI interrupt, dead loop
                                                        crash_nmi_callback
  printk_safe_flush_on_panic
    printk_safe_flush
      __printk_safe_flush
        // deal lock
        raw_spin_lock_irqsave(&read_lock)

The register_nmi_handler() can be called in the __crash_kexec() or the
crash_smp_send_stop() on the x86-64. Because CPU1 is interrupted by the
NMI with holding the read_lock and crash_nmi_callback() never returns,
CPU0 can deadlock when printk_safe_flush_on_panic() is called.

When we hold the read_lock and then interrupted by the NMI, if the NMI
handler call nmi_panic(), it is also can lead to deadlock.

In order to fix it, we should call printk_safe_flush_on_panic without
holding the read_lock.

Fixes: cf9b1106c81c ("printk/nmi: flush NMI messages on the system panic")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 kernel/printk/printk_safe.c | 58 ++++++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index a0e6f746de6c..86d9fa74ac5c 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -174,30 +174,13 @@ static void report_message_lost(struct printk_safe_seq_buf *s)
 		printk_deferred("Lost %d message(s)!\n", lost);
 }
 
-/*
- * Flush data from the associated per-CPU buffer. The function
- * can be called either via IRQ work or independently.
- */
-static void __printk_safe_flush(struct irq_work *work)
+static void __printk_safe_flush_work(struct irq_work *work)
 {
-	static raw_spinlock_t read_lock =
-		__RAW_SPIN_LOCK_INITIALIZER(read_lock);
 	struct printk_safe_seq_buf *s =
 		container_of(work, struct printk_safe_seq_buf, work);
-	unsigned long flags;
 	size_t len;
-	int i;
+	int i = 0;
 
-	/*
-	 * The lock has two functions. First, one reader has to flush all
-	 * available message to make the lockless synchronization with
-	 * writers easier. Second, we do not want to mix messages from
-	 * different CPUs. This is especially important when printing
-	 * a backtrace.
-	 */
-	raw_spin_lock_irqsave(&read_lock, flags);
-
-	i = 0;
 more:
 	len = atomic_read(&s->len);
 
@@ -232,6 +215,26 @@ static void __printk_safe_flush(struct irq_work *work)
 
 out:
 	report_message_lost(s);
+}
+
+/*
+ * Flush data from the associated per-CPU buffer. The function
+ * can be called either via IRQ work or independently.
+ */
+static void printk_safe_flush_work(struct irq_work *work)
+{
+	unsigned long flags;
+	static DEFINE_RAW_SPINLOCK(read_lock);
+
+	/*
+	 * The lock has two functions. First, one reader has to flush all
+	 * available message to make the lockless synchronization with
+	 * writers easier. Second, we do not want to mix messages from
+	 * different CPUs. This is especially important when printing
+	 * a backtrace.
+	 */
+	raw_spin_lock_irqsave(&read_lock, flags);
+	__printk_safe_flush_work(work);
 	raw_spin_unlock_irqrestore(&read_lock, flags);
 }
 
@@ -248,9 +251,9 @@ void printk_safe_flush(void)
 
 	for_each_possible_cpu(cpu) {
 #ifdef CONFIG_PRINTK_NMI
-		__printk_safe_flush(&per_cpu(nmi_print_seq, cpu).work);
+		printk_safe_flush_work(&per_cpu(nmi_print_seq, cpu).work);
 #endif
-		__printk_safe_flush(&per_cpu(safe_print_seq, cpu).work);
+		printk_safe_flush_work(&per_cpu(safe_print_seq, cpu).work);
 	}
 }
 
@@ -266,6 +269,8 @@ void printk_safe_flush(void)
  */
 void printk_safe_flush_on_panic(void)
 {
+	int cpu;
+
 	/*
 	 * Make sure that we could access the main ring buffer.
 	 * Do not risk a double release when more CPUs are up.
@@ -278,7 +283,12 @@ void printk_safe_flush_on_panic(void)
 		raw_spin_lock_init(&logbuf_lock);
 	}
 
-	printk_safe_flush();
+	for_each_possible_cpu(cpu) {
+#ifdef CONFIG_PRINTK_NMI
+		__printk_safe_flush_work(&per_cpu(nmi_print_seq, cpu).work);
+#endif
+		__printk_safe_flush_work(&per_cpu(safe_print_seq, cpu).work);
+	}
 }
 
 #ifdef CONFIG_PRINTK_NMI
@@ -401,11 +411,11 @@ void __init printk_safe_init(void)
 		struct printk_safe_seq_buf *s;
 
 		s = &per_cpu(safe_print_seq, cpu);
-		init_irq_work(&s->work, __printk_safe_flush);
+		init_irq_work(&s->work, printk_safe_flush_work);
 
 #ifdef CONFIG_PRINTK_NMI
 		s = &per_cpu(nmi_print_seq, cpu);
-		init_irq_work(&s->work, __printk_safe_flush);
+		init_irq_work(&s->work, printk_safe_flush_work);
 #endif
 	}
 
-- 
2.11.0

