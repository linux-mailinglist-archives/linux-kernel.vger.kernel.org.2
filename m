Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CC7311BA1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 06:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhBFFmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 00:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhBFFmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 00:42:13 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9D7C06174A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 21:41:33 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id l18so5002612pji.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 21:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bNFuERZtgElUwSwPcuopIAKfEJzr5N/WLsw0DMTHunA=;
        b=rJn/klKUTijUmoLIlHkDH59l/AeupUiiCYyaoxM29m+Mfg/xIoydcVDCfHZ7aS46OX
         ypPqFXcxQLNhhgka3TV91FynhqtLG50qH/w+aABe1iY/epLI5p3Qn0oGdPq1WZD8O+AB
         eVeud68s4ATuQbzHTDSe8EiSGigna8SIlQnAQwHLQHJayRdE1qzpAUpW9hqJyxbVklyP
         gLT1xoVouC8moi624zTLKgq0DildevJzWBJsnDvH8JQNEd+OwBvy7ISyzp72bPMW3OgK
         jPuCB5MHTZPtFKvLwoMOWLJmhv06z5xftH+2hkx7Ah8dQUCdb9rwb4GnPiIL78JW4A5U
         32vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bNFuERZtgElUwSwPcuopIAKfEJzr5N/WLsw0DMTHunA=;
        b=RGEt6zBLjK5/IJz1V9ErMNQ61vrNxmVGnVVNpr6D8QQCbDQndvHJ1syRnmZhCDPYnA
         +q5tPTAqgn4YHbhAziif9uo45GFZULoXWygkcCykqS2zN+m29fporhYke5RUe02bn5dj
         QttjwQ9rjPyrau+LxgPEWfPDc3i2hBGgwPuL9x4PAl1d3scHExmjADgd/f/NNeyGL5K/
         XvcDP5l/zhpChGZYZ+BqmGOWhzGgcG2Hvj1xvecYwLJSpIDfcqRFuNs3EpgT4PF1Gdzm
         2wDJZEjyWU9VbeRUUMb8TjFKiwKrHUSlocV/+QzBjMtkkRpxbB/VT++Ru80vSdq0efMt
         zKcg==
X-Gm-Message-State: AOAM533iLUbqCy+SeLROG4jQ/Ql6AHTGIYjVsumlWkU0H6kNzcN4AInh
        inp3DdwKqa2D4nn9cl9eomYzZQ==
X-Google-Smtp-Source: ABdhPJwbke4hHmUaHQwAs84+fOqYCB1yJJMpcOBDUIRk/hEKkVPmw7DWZu1U+WVd6BACBW8A/FVzeQ==
X-Received: by 2002:a17:90a:4148:: with SMTP id m8mr7278642pjg.184.1612590092638;
        Fri, 05 Feb 2021 21:41:32 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id x17sm11500816pff.180.2021.02.05.21.41.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2021 21:41:32 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] printk: fix deadlock when kernel panic
Date:   Sat,  6 Feb 2021 13:41:24 +0800
Message-Id: <20210206054124.6743-1-songmuchun@bytedance.com>
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
        // deadlock
        raw_spin_lock_irqsave(&read_lock)

The register_nmi_handler() can be called in the __crash_kexec() or the
crash_smp_send_stop() on the x86-64. Because CPU1 is interrupted by the
NMI with holding the read_lock and crash_nmi_callback() never returns,
CPU0 can deadlock when printk_safe_flush_on_panic() is called.

When we hold the read_lock and then interrupted by the NMI, if the NMI
handler call nmi_panic(), it is also can lead to deadlock.

In order to fix it, we make read_lock global and rename it to
safe_read_lock. And we handle safe_read_lock the same way in
printk_safe_flush_on_panic() as we handle logbuf_lock there.

Fixes: cf9b1106c81c ("printk/nmi: flush NMI messages on the system panic")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v2:
 - handle read_lock the same way as we handle logbuf_lock there.

 Thanks Petr.

 kernel/printk/printk_safe.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index a0e6f746de6c..2e9e3ed7d63e 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -45,6 +45,8 @@ struct printk_safe_seq_buf {
 static DEFINE_PER_CPU(struct printk_safe_seq_buf, safe_print_seq);
 static DEFINE_PER_CPU(int, printk_context);
 
+static DEFINE_RAW_SPINLOCK(safe_read_lock);
+
 #ifdef CONFIG_PRINTK_NMI
 static DEFINE_PER_CPU(struct printk_safe_seq_buf, nmi_print_seq);
 #endif
@@ -180,8 +182,6 @@ static void report_message_lost(struct printk_safe_seq_buf *s)
  */
 static void __printk_safe_flush(struct irq_work *work)
 {
-	static raw_spinlock_t read_lock =
-		__RAW_SPIN_LOCK_INITIALIZER(read_lock);
 	struct printk_safe_seq_buf *s =
 		container_of(work, struct printk_safe_seq_buf, work);
 	unsigned long flags;
@@ -195,7 +195,7 @@ static void __printk_safe_flush(struct irq_work *work)
 	 * different CPUs. This is especially important when printing
 	 * a backtrace.
 	 */
-	raw_spin_lock_irqsave(&read_lock, flags);
+	raw_spin_lock_irqsave(&safe_read_lock, flags);
 
 	i = 0;
 more:
@@ -232,7 +232,7 @@ static void __printk_safe_flush(struct irq_work *work)
 
 out:
 	report_message_lost(s);
-	raw_spin_unlock_irqrestore(&read_lock, flags);
+	raw_spin_unlock_irqrestore(&safe_read_lock, flags);
 }
 
 /**
@@ -278,6 +278,14 @@ void printk_safe_flush_on_panic(void)
 		raw_spin_lock_init(&logbuf_lock);
 	}
 
+	if (raw_spin_is_locked(&safe_read_lock)) {
+		if (num_online_cpus() > 1)
+			return;
+
+		debug_locks_off();
+		raw_spin_lock_init(&safe_read_lock);
+	}
+
 	printk_safe_flush();
 }
 
-- 
2.11.0

