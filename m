Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FE74462F6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 12:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhKELqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 07:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbhKELqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 07:46:07 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5518EC061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 04:43:28 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so3116390pjc.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 04:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=OlEHppWAEvpYn9+XvoiWW9upQ5mcf4U4IvlwV+Xqr1A=;
        b=etOBa30OHg/r13PGLK2dha+O07jWA61ODxdE0kjpA9LHbrd6KfmvL1vQph9+HX6eEt
         YxiSwKiTr8/WcwZ2zRXhsTfuV0jgp/+T98SHMmt9gpCXGHcRPmsymc7vw94RK/Zpr787
         K0lXiATFy3p/dskfUhZdSMUXdBy6zhSx/QDbTH+VRtUVYFpu2Hg2yYkarYfhiCADD77g
         wyG2JoKkIyNmDpnIhtv3F4wdssfp/Al4j8Jfq0L+dG3pZE1pMj2/0cC2RuYdkxm3hqCq
         H6aUtAH56C20+JHpLk+nZUgCaDkD475+MpF+bmoYyLO1MuSTmcEHP7naFp0tvZJIybqH
         djVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=OlEHppWAEvpYn9+XvoiWW9upQ5mcf4U4IvlwV+Xqr1A=;
        b=V0H8bGzH5z4rzYtbhRG2vllQt7pUd68h6EKJOY0VEq0KjG7tH+l2uJXR/1ZM14a3Ob
         LQsx2sHiUOtvSHcbirxrDWwlGoRKYsvC6IuqekPjg9D+QQnhNDnZXFNY/SlBpFaJnV/4
         uKA9Se7PiCX6TVtbiC0s1A4M8tkutOoO1Kp1rayekJ6pV7hF0NDaWCqv1CLYklHQ2ei+
         vTvW+xfq20rrTSDXSsP2jiBnO/L1YHrpYlg5hK3JBK0fpZwIBgOQPLMMHOPSPrlKs4k6
         f7+rycb9JZs1w/WtUcBSYUPI0R/xLEjcDssYvSo9OR8mK5aKko3ibOzhxK7Xal8KClsA
         Ie+w==
X-Gm-Message-State: AOAM531lWXyGjE57HCodjufkcOBwOyDtee41dU8LcxX8x91jGiJ/WHkc
        P0dJCI5do6RfoU0g+HoN83A=
X-Google-Smtp-Source: ABdhPJyPvsIpFSnmLoHrvoGDmiSRTPERN9Ss2URz6/xMxZa3mWCgwObgIa3AlLdzemY1R6f/2G4LQw==
X-Received: by 2002:a17:902:6acc:b0:141:69d7:9275 with SMTP id i12-20020a1709026acc00b0014169d79275mr50851430plt.45.1636112607785;
        Fri, 05 Nov 2021 04:43:27 -0700 (PDT)
Received: from localhost (60-241-46-56.tpgi.com.au. [60.241.46.56])
        by smtp.gmail.com with ESMTPSA id d6sm7147707pfa.39.2021.11.05.04.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 04:43:27 -0700 (PDT)
Date:   Fri, 05 Nov 2021 21:43:21 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: Removal of printk safe buffers delays NMI context printk
To:     John Ogness <john.ogness@linutronix.de>
Cc:     =?iso-8859-1?q?Laurent=0A?= Dufour <ldufour@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
References: <1636039236.y415994wfa.astroid@bobo.none>
        <87ee7vki7f.fsf@jogness.linutronix.de>
        <1636073838.qpmyp6q17i.astroid@bobo.none>
        <87r1bv2aga.fsf@jogness.linutronix.de>
In-Reply-To: <87r1bv2aga.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Message-Id: <1636111599.wwppq55w4t.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from John Ogness's message of November 5, 2021 7:55 pm:
> On 2021-11-05, Nicholas Piggin <npiggin@gmail.com> wrote:
>>> We are planning on implementing a pr_flush() that will do something
>>> similar. But I am wondering how you are planning on triggering a CPU
>>> to call that function.
>>
>> Similar way as was removed by commit 93d102f094b ("printk: remove safe
>> buffers") fro nmi_backtrace and powerpc watchdog. The following patch
>> is what I'm using which seems to work for me.
>=20
> What was removed from 93d102f094b was irq_work triggering on all
> CPUs.

No, it was the caller executing the flush for all remote CPUs itself.
irq work was not involved (and irq work can't be raised in a remote
CPU from NMI context).

> Your patch is attempting to directly print from a non-NMI
> context. This is obviously a better approach if a caller is known to be
> non-NMI.
>=20
> Also, before 93d102f094b the safe buffer flushing was performed before
> triggering the NMI backtraces (in some cases). So clearly it worked
> before by accident rather than by design. (Not that that really
> matters.)

That's not the case, in the core nmi_backtrace.c, the flush happens
afterward.

In the powerpc code it's not actually the case either but it wasn't
obvious why at least should have been commented. powerpc's
trigger_allbutself_cpu_backtrace() is not a NMI IPI, just a normal
one. So if a CPU takes it then it will flush its own buffer via
irq_work. You only have to do the printk flush for the case of the
true NMI IPI which comes before.

That code does need a bit more work for other reasons, but we do
need that printk flush capability back there and for nmi_backtrace.

>> What would pr_flush do differently and where were you planning to use
>> it?
>=20
> Currently, and particularly when we move to threaded printers, printk
> callers do not know when their messages are actually visible. However,
> in some cases the printk caller (or some related task) wants to be sure
> the message is visible.
>=20
> pr_flush() will allow a task to block until all pending messages (at the
> time of the call) are output on all consoles.
>=20
> Your patch is doing something similar for non-NMI contexts, except that
> it will exit early if it fails to get the console lock. For your case
> this is probably acceptable because you are only concerned that some
> context is printing the messages, even if the latest messages may not
> have been printed yet.

Yep, if something else has the lock hopefully it should release it and
do the flush when it does. We're already 10 seconds delayed here so a
bit longer doesn't matter, just needs to get out at some point.

>>     printk: restore flushing of NMI buffers on remote CPUs after NMI bac=
ktraces
>>    =20
>>     printk from NMI context relies on irq work being raised on the local=
 CPU
>>     to print to console. This can be a problem if the NMI was raised by =
a
>>     lockup detector to print lockup stack and regs, because the CPU may =
not
>>     enable irqs (because it is locked up).
>>    =20
>>     Introduce printk_flush() that can be called from non-NMI context on
>>     another CPU to try to get those messages to the console.
>>    =20
>>     Fixes: 93d102f094be ("printk: remove safe buffers")
>>     Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>
>> diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchd=
og.c
>> index 5f69ba4de1f3..59ddb24797ae 100644
>> --- a/arch/powerpc/kernel/watchdog.c
>> +++ b/arch/powerpc/kernel/watchdog.c
>> @@ -227,6 +227,12 @@ static void watchdog_smp_panic(int cpu)
>>  		cpumask_clear(&wd_smp_cpus_ipi);
>>  	}
>> =20
>> +	/*
>> +	 * Force flush any remote buffers that might be stuck in IRQ context
>> +	 * and therefore could not run their irq_work.
>> +	 */
>> +	printk_flush();
>> +
>=20
> nmi_trigger_cpumask_backtrace() tracks and waits (up to 10 seconds) for
> the CPUs to print their backtrace before flushing. Here there is no
> waiting. I suppose in practice the NMI backtrace will be fast enough,
> but I am just wondering if there should be some sort of tracking/waiting
> like in nmi_trigger_cpumask_backtrace().

Yeah it has tended to work, but I have something to fix that up.

>=20
>>  	if (hardlockup_panic)
>>  		nmi_panic(NULL, "Hard LOCKUP");
>> =20
>> diff --git a/include/linux/printk.h b/include/linux/printk.h
>> index 85b656f82d75..50424ad87fb5 100644
>> --- a/include/linux/printk.h
>> +++ b/include/linux/printk.h
>> @@ -198,6 +198,7 @@ void dump_stack_print_info(const char *log_lvl);
>>  void show_regs_print_info(const char *log_lvl);
>>  extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
>>  extern asmlinkage void dump_stack(void) __cold;
>> +void printk_flush(void);
>>  #else
>>  static inline __printf(1, 0)
>>  int vprintk(const char *s, va_list args)
>> @@ -274,6 +275,9 @@ static inline void dump_stack_lvl(const char *log_lv=
l)
>>  static inline void dump_stack(void)
>>  {
>>  }
>> +static inline void printk_flush(void)
>> +{
>> +}
>>  #endif
>> =20
>>  #ifdef CONFIG_SMP
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index a8d0a58deebc..dd9471bb58c2 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -2206,6 +2206,26 @@ int vprintk_store(int facility, int level,
>>  	return ret;
>>  }
>> =20
>> +void printk_flush(void)
>> +{
>> +	/*
>> +	 * Disable preemption to avoid being preempted while holding
>> +	 * console_sem which would prevent anyone from printing to
>> +	 * console
>> +	 */
>> +	preempt_disable();
>> +	/*
>> +	 * Try to acquire and then immediately release the console
>> +	 * semaphore.  The release will print out buffers and wake up
>> +	 * /dev/kmsg and syslog() users.
>> +	 */
>> +	if (console_trylock_spinning())
>> +		console_unlock();
>> +	preempt_enable();
>> +
>> +	wake_up_klogd();
>> +}
>=20
> I have mixed feelings about this printk_flush() because it is exactly
> this code that is about to undergo massive reworking.

Better to fix up the regression before said massive reworking I think.

> If this function
> is accepted, then I wonder if printk_trigger_flush() might be a better
> name since it does not necessarily wait until the messages are
> printed. (There could be another task printing and already a queued
> handover printer. Or this task could handover printing before
> finishing.)

Sure I'm not wedded to the name. I can resend with the name change if
there's no other issues (the powerpc fixups will go as separate series).

Thanks,
Nick
