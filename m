Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48926446B93
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 01:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhKFA27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 20:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbhKFA25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 20:28:57 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB73C061205
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 17:26:17 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id s24so12120701plp.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 17:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=Crt/PTh78XJKn/EXCj3NCFw7rVkrtpZ9Yjpzof6KWbE=;
        b=ObsfDdz3bHeI/sIjLlvqIa5WqznwNTKGpXcm7eYsI4n5xFmpa+ZI3DXEfDvauoWuoM
         5hzp3KaQOnTIui4A2IVn9C+Kq1p8eEk4cT2/2yJUmqcunscW1mX8X6u3nl7S4LIt1qfz
         I6yVZxjbLgjJm6gW3f8ldUeyjzIvk1YBNsMNepUTMxs6S7yFM/g0Tud3Ou9E9qUuTZ7x
         06i2LPIK4BDTF6nzBT6kSBzAGWLbMAOmOdXD4GW4AU8JyAW3Z/AS2Hm6PIe1ksHpjzHQ
         FRgycbA0YaTnIFQAwgrXnRidHvl/oiPrH5VVc/h+zkiV3gWSObmZXoytVyqzUPguodXO
         S+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=Crt/PTh78XJKn/EXCj3NCFw7rVkrtpZ9Yjpzof6KWbE=;
        b=a3HlW4X1O/iBqcNfxOsJOx5x+tfpoCEIXfHprJHoJkHuq1lJBOQxWHxuhlEgHjvsOj
         GrPCZgqX90Pf9Pe0qNjvjibZ18GWzd3xIEQaCnMJIxIXsLnFvLTRf4OMRsz3GidVg73d
         NSHH6wCXUrBxFFJdlRtBoxJyGAARijkBuB0FS42JWuX6IoiOPe0G5P8/TZNt51nwhVDf
         9ZgiegvRr0Hb8c6/KsdLfIEzz9Bd7p31wrOOlS1GlcQgkZKYLctAbVpdKxvZ6wBgDmvy
         L8mNH3Ht79tdfLkOkrGXjfHToym1Qr/AbACpkY83aC1gbuRybKP7AlOHPHROIKIK4Gqi
         xHOw==
X-Gm-Message-State: AOAM531YKTJ/Mgq59H7+NiOTIKVa60BdKBA6O3u+CzgjgeJF4Y6KyLA5
        b1ksM0xz5bZHweMKtTs4B/XvXRq+tzA=
X-Google-Smtp-Source: ABdhPJwkhpM8LKvrt8iGHgNYeyDWcz3Y1KcLoYAzobd7RYEaz6KKNw5tdV87eozUTV6jHfRDrWqrsg==
X-Received: by 2002:a17:903:230b:b0:141:e3ce:2738 with SMTP id d11-20020a170903230b00b00141e3ce2738mr36257421plh.57.1636158377013;
        Fri, 05 Nov 2021 17:26:17 -0700 (PDT)
Received: from localhost (60-241-46-56.tpgi.com.au. [60.241.46.56])
        by smtp.gmail.com with ESMTPSA id o129sm829126pfg.44.2021.11.05.17.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 17:26:16 -0700 (PDT)
Date:   Sat, 06 Nov 2021 10:26:11 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: Removal of printk safe buffers delays NMI context printk
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        linux-kernel@vger.kernel.org
References: <1636039236.y415994wfa.astroid@bobo.none>
        <87ee7vki7f.fsf@jogness.linutronix.de>
        <1636073838.qpmyp6q17i.astroid@bobo.none>
        <87r1bv2aga.fsf@jogness.linutronix.de>
        <1636111599.wwppq55w4t.astroid@bobo.none>
        <87h7cqg0xk.fsf@jogness.linutronix.de> <YYVakNdzjrYuBmhf@alley>
        <87lf22eem7.fsf@jogness.linutronix.de>
In-Reply-To: <87lf22eem7.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Message-Id: <1636158295.cxlln6r0kk.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from John Ogness's message of November 6, 2021 2:44 am:
> On 2021-11-05, Petr Mladek <pmladek@suse.com> wrote:
>> On Fri 2021-11-05 15:03:27, John Ogness wrote:
>>> On 2021-11-05, Nicholas Piggin <npiggin@gmail.com> wrote:
>>>> but we do need that printk flush capability back there and for
>>>> nmi_backtrace.
>>>=20
>>> Agreed. I had not considered this necessary side-effect when I
>>> removed the NMI safe buffers.
>>
>> Honestly, I do not understand why it stopped working or how
>> it worked before.
>=20
> IIUC, Nick is presenting a problem where a lockup on the other CPUs is
> detected. Those CPUs will dump their backtraces per NMI context. But in
> their lockup state the irq_work for those CPUs is not functional. So
> even though the messages are in the buffer, there is no one printing the
> buffer.

Yep.

> printk_safe_flush() would dump the NMI safe buffers for all the CPUs
> into the printk buffer, then trigger an irq_work on itself (the
> non-locked-up CPU).
>=20
> That irq_work trigger was critical, because the other CPUs (which also
> triggered irq_works for themselves) aren't able to process irq_works. I
> did not consider this case. Which is why we still need to trigger
> irq_work here. (Or, as the removed comment hinted at, add some printk()
> call to either directly print or trigger the irq_work.)

This patch seems to work, I can submit it if you'd like?

Thanks,
Nick

---
 arch/powerpc/kernel/watchdog.c | 6 ++++++
 include/linux/printk.h         | 4 ++++
 kernel/printk/printk.c         | 5 +++++
 lib/nmi_backtrace.c            | 6 ++++++
 4 files changed, 21 insertions(+)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.=
c
index 5f69ba4de1f3..c8017bc23b00 100644
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
+	printk_trigger_flush();
+
 	if (hardlockup_panic)
 		nmi_panic(NULL, "Hard LOCKUP");
=20
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
=20
 #ifdef CONFIG_SMP
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index a8d0a58deebc..99221b016c68 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3252,6 +3252,11 @@ void defer_console_output(void)
 	preempt_enable();
 }
=20
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
@@ -75,6 +75,12 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask=
,
 		touch_softlockup_watchdog();
 	}
=20
+	/*
+	 * Force flush any remote buffers that might be stuck in IRQ context
+	 * and therefore could not run their irq_work.
+	 */
+	printk_trigger_flush();
+
 	clear_bit_unlock(0, &backtrace_flag);
 	put_cpu();
 }
--=20
2.23.0

