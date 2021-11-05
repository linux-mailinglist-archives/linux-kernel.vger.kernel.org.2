Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB750445D46
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 02:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhKEB3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 21:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhKEB3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 21:29:20 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9955FC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 18:26:41 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 75so6998228pga.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 18:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=XRAycEtCIAMgixkfoco3GL6VHP+318YiJGvQcHGBP2Q=;
        b=AM1XKJjseMkzZEIQ/02OcxoHfF3A+xbHmxpwDsQ4Z0SqMWOYbNS1jukn2JZDezpNKp
         mJXrfjxtCrp/Xz5ky9Dngt2FZfhCjLKyb6JeMqMwnY+1hu+d2ZKMoiZ5K0L6tw4Es95W
         yU94010Cx8cDM4SYlc0p1E8fk7bsu/03j+tYcyiPWSPzEUHN1oZsn6NFZQxBoSMwjWk/
         zHmQ3cL+7NmjcunO2KKsn8ajFMShzLD2kL3x1MBhi62kKznGUZpn/53Q25+oMZIEXA18
         ykI+rxE3vxEsC7pC7Q0Lsv5rRXZlvL48dI5uLkI+ipIp/7hYYxTWkPtsc7u4ufJcXfQL
         qHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=XRAycEtCIAMgixkfoco3GL6VHP+318YiJGvQcHGBP2Q=;
        b=v/uCSJE3O5ohjbM8je8t1isBxGXhIvPzvyki3yyRIBQyLwIkiLE6y9TawEGl3MXyO5
         Pr1wKhnAfehpdK4f1fEeYmiSakBK2Jgee7m9f3F6p7qscHk+KoeC5QL98eyDfqFwMmTD
         zFbmrL6ZXzLsdX8ktXurY8Qge7JHUqkvk5fbheLXi8P6KSEswyp6w+9h56z91isGEEn9
         +0SI0ongqsX4/UwZ+TbEuRIZt26rTvNJUf3Xo5ZsSzORIbyEsQzOBK+NoUfgdMFwoS9Z
         zSuczn2YfKpLaZRl0R8vXcGegkU7KGDp8sf9KiFEPD9UbxC7O5hjwrlwhuvqfFHH4D6p
         eELw==
X-Gm-Message-State: AOAM533+ODXZROg3pfJMILQSpsU86Y47c5S0xg7ooNG61gUu4z1VsxDE
        3PiIGaJIL3YSxo8A2Y9o/kw=
X-Google-Smtp-Source: ABdhPJxWPdeFNpKWE8Ab081pEbRSSeu8Piaz4Rah09yufm9KQtuBIpoJ2AdzzThhMLBm7CcO30YqAg==
X-Received: by 2002:a63:f52:: with SMTP id 18mr31217562pgp.58.1636075601142;
        Thu, 04 Nov 2021 18:26:41 -0700 (PDT)
Received: from localhost (60-241-46-56.tpgi.com.au. [60.241.46.56])
        by smtp.gmail.com with ESMTPSA id u6sm5904093pfg.30.2021.11.04.18.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 18:26:40 -0700 (PDT)
Date:   Fri, 05 Nov 2021 11:26:35 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: Removal of printk safe buffers delays NMI context printk
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Laurent Dufour <ldufour@linux.ibm.com>
References: <1636039236.y415994wfa.astroid@bobo.none>
        <87ee7vki7f.fsf@jogness.linutronix.de>
In-Reply-To: <87ee7vki7f.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Message-Id: <1636073838.qpmyp6q17i.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from John Ogness's message of November 5, 2021 2:18 am:
> Hi Nick,
>=20
> On 2021-11-05, Nicholas Piggin <npiggin@gmail.com> wrote:
>> It seems printk from NMI context is now delayed indefinitely and
>> there is no printk_safe_flush equivalent (or I can't see one) to
>> allow a NMI buffer to be flushed by a different CPU.
>=20
> NMI flushing is triggered using irq work (for the same CPU). This should
> not have changed recently. Are you reporting a new issue?

Previously prink_safe_flush from another CPU would flush those out.

>> This causes hard lockup watchdog messages to not get shown on the
>> console. I can call printk from a different CPU and that seems to
>> flush the stuck CPU's NMI buffer immediately.
>=20
> Perhaps we should be triggering the irq work on multiple CPUs if from
> NMI context?

Possibly. I don't know if it's really needed because the irq work should=20
usually be fine, the problem are lockup detector messages where the
printing CPU does not enable irqs after it returns from NMI.

>=20
>> What's the best way to expose this? Can we have something like tihs?
>>
>> void printk_flush(void)
>> {
>> 	preempt_disable();
>> 	if (console_trylock_spinning())
>> 		console_unlock();
>> 	preempt_enable();
>>         wake_up_klogd();
>> }
>=20
> We are planning on implementing a pr_flush() that will do something
> similar. But I am wondering how you are planning on triggering a CPU to
> call that function.

Similar way as was removed by commit 93d102f094b ("printk: remove safe=20
buffers") fro nmi_backtrace and powerpc watchdog. The following patch
is what I'm using which seems to work for me.

What would pr_flush do differently and where were you planning to use=20
it?

Thanks,
Nick
--
    printk: restore flushing of NMI buffers on remote CPUs after NMI backtr=
aces
   =20
    printk from NMI context relies on irq work being raised on the local CP=
U
    to print to console. This can be a problem if the NMI was raised by a
    lockup detector to print lockup stack and regs, because the CPU may not
    enable irqs (because it is locked up).
   =20
    Introduce printk_flush() that can be called from non-NMI context on
    another CPU to try to get those messages to the console.
   =20
    Fixes: 93d102f094be ("printk: remove safe buffers")
    Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.=
c
index 5f69ba4de1f3..59ddb24797ae 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -227,6 +227,12 @@ static void watchdog_smp_panic(int cpu)
 		cpumask_clear(&wd_smp_cpus_ipi);
 	}
=20
+	/*
+	 * Force flush any remote buffers that might be stuck in IRQ context
+	 * and therefore could not run their irq_work.
+	 */
+	printk_flush();
+
 	if (hardlockup_panic)
 		nmi_panic(NULL, "Hard LOCKUP");
=20
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 85b656f82d75..50424ad87fb5 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -198,6 +198,7 @@ void dump_stack_print_info(const char *log_lvl);
 void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
+void printk_flush(void);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -274,6 +275,9 @@ static inline void dump_stack_lvl(const char *log_lvl)
 static inline void dump_stack(void)
 {
 }
+static inline void printk_flush(void)
+{
+}
 #endif
=20
 #ifdef CONFIG_SMP
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index a8d0a58deebc..dd9471bb58c2 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2206,6 +2206,26 @@ int vprintk_store(int facility, int level,
 	return ret;
 }
=20
+void printk_flush(void)
+{
+	/*
+	 * Disable preemption to avoid being preempted while holding
+	 * console_sem which would prevent anyone from printing to
+	 * console
+	 */
+	preempt_disable();
+	/*
+	 * Try to acquire and then immediately release the console
+	 * semaphore.  The release will print out buffers and wake up
+	 * /dev/kmsg and syslog() users.
+	 */
+	if (console_trylock_spinning())
+		console_unlock();
+	preempt_enable();
+
+	wake_up_klogd();
+}
+
 asmlinkage int vprintk_emit(int facility, int level,
 			    const struct dev_printk_info *dev_info,
 			    const char *fmt, va_list args)
@@ -2228,24 +2248,11 @@ asmlinkage int vprintk_emit(int facility, int level=
,
 	printed_len =3D vprintk_store(facility, level, dev_info, fmt, args);
=20
 	/* If called from the scheduler, we can not call up(). */
-	if (!in_sched) {
-		/*
-		 * Disable preemption to avoid being preempted while holding
-		 * console_sem which would prevent anyone from printing to
-		 * console
-		 */
-		preempt_disable();
-		/*
-		 * Try to acquire and then immediately release the console
-		 * semaphore.  The release will print out buffers and wake up
-		 * /dev/kmsg and syslog() users.
-		 */
-		if (console_trylock_spinning())
-			console_unlock();
-		preempt_enable();
-	}
+	if (!in_sched)
+		printk_flush();
+	else
+		wake_up_klogd();
=20
-	wake_up_klogd();
 	return printed_len;
 }
 EXPORT_SYMBOL(vprintk_emit);
diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index f9e89001b52e..b735b2e24902 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -75,6 +75,12 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask=
,
 		touch_softlockup_watchdog();
 	}
=20
+	/*
+	 * Force flush any remote buffers that might be stuck in IRQ context
+	 * and therefore could not run their irq_work.
+	 */
+	printk_flush();
+
 	clear_bit_unlock(0, &backtrace_flag);
 	put_cpu();
 }

