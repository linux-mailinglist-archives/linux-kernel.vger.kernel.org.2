Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80034351C56
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239554AbhDASQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236795AbhDAR6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:58:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B00C08E81A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 06:20:02 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617283194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ropfd/50hZwFHygWvoKwWUv09SHlJREMcmKg0y/1COk=;
        b=w4oEaTFxHJvv3fqbRVPTIUlUbLzczXOhRKdyeF4GvLQP185Tberl86XRlFEJoX/AGcs+1N
        PFWuHAkJaPq/eyChQAN8RQHAy6FcaTZP/itmUCwpRj6Ws413xT6OkUB++KuMIpsSNjxhGR
        M1NS9Avk4diwz5/PMur9fUzzJRwKj4n9cS+HQVzXKva8E9UKXjamvB/9kntsOuCcwAbfqe
        bqvr0W/f0ltISNaSfpoBFOUG6HYkv5SBd0YTPHiT5W3ZZ+2HOC/ZcTZR88sMXHKtf4QcaD
        6qjwd/JpUfsZWIwddumcLQVSi8CRRObqQ+1vk3FB5GI300dd9g9I4nNwUOmV5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617283194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ropfd/50hZwFHygWvoKwWUv09SHlJREMcmKg0y/1COk=;
        b=GSHqJTUL1+ALVe/5Kh9GKkiAVzFtP+9xFkfM37puBv2WdO1AxshdgLE2Iv9js81yEIcZ3L
        eUZabLq8YYv87HBg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alistair Popple <alistair@popple.id.au>,
        Jordan Niethe <jniethe5@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Yue Hu <huyue2@yulong.com>, Rafael Aquini <aquini@redhat.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org
Subject: Re: [PATCH printk v2 2/5] printk: remove safe buffers
In-Reply-To: <YGW63/elFr/gYW1u@alley>
References: <20210330153512.1182-1-john.ogness@linutronix.de> <20210330153512.1182-3-john.ogness@linutronix.de> <YGW63/elFr/gYW1u@alley>
Date:   Thu, 01 Apr 2021 15:19:52 +0200
Message-ID: <87a6qiqgzr.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-01, Petr Mladek <pmladek@suse.com> wrote:
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -1142,24 +1128,37 @@ void __init setup_log_buf(int early)
>>  		 new_descs, ilog2(new_descs_count),
>>  		 new_infos);
>>  
>> -	printk_safe_enter_irqsave(flags);
>> +	local_irq_save(flags);
>
> IMHO, we actually do not have to disable IRQ here. We already copy
> messages that might appear in the small race window in NMI. It would
> work the same way also for IRQ context.

We do not have to, but why open up this window? We are still in early
boot and interrupts have always been disabled here. I am not happy that
this window even exists. I really prefer to keep it NMI-only.

>> --- a/lib/nmi_backtrace.c
>> +++ b/lib/nmi_backtrace.c
>> @@ -75,12 +75,6 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
>>  		touch_softlockup_watchdog();
>>  	}
>>  
>> -	/*
>> -	 * Force flush any remote buffers that might be stuck in IRQ context
>> -	 * and therefore could not run their irq_work.
>> -	 */
>> -	printk_safe_flush();
>
> Sigh, this reminds me that the nmi_safe buffers serialized backtraces
> from all CPUs.
>
> I am afraid that we have to put back the spinlock into
> nmi_cpu_backtrace().

Please no. That spinlock is a disaster. It can cause deadlocks with
other cpu-locks (such as in kdb) and it will cause a major problem for
atomic consoles. We need to be very careful about introducing locks
where NMIs are waiting on other CPUs.

> It has been repeatedly added and removed depending
> on whether the backtrace was printed into the main log buffer
> or into the per-CPU buffers. Last time it was removed by
> the commit 03fc7f9c99c1e7ae2925d ("printk/nmi: Prevent deadlock
> when accessing the main log buffer in NMI").
>
> It should be safe because there should not be any other locks in the
> code path. Note that only one backtrace might be triggered at the same
> time, see @backtrace_flag in nmi_trigger_cpumask_backtrace().

It is adding a lock around a lockless ringbuffer. For me that is a step
backwards.

> We _must_ serialize it somehow[*]. The lock in nmi_cpu_backtrace()
> looks less evil than the nmi_safe machinery. nmi_safe() shrinks
> too long backtraces, lose timestamps, needs to be explicitely
> flushed here and there, is a non-trivial code.
>
> [*] Non-serialized bactraces are real mess. Caller-id is visible
>     only on consoles or via syslogd interface. And it is not much
>     convenient.

Caller-id solves this problem and is easy to sort for anyone with
`grep'. Yes, it is a shame that `dmesg' does not show it, but directly
using any of the printk interfaces does show it (kmsg_dump, /dev/kmsg,
syslog, console).

>     I get this with "echo l >/proc/sysrq-trigger" and this patchset:

Of course. Without caller-id, it is a mess. But this has nothing to do
with NMI. The same problem exists for WARN_ON() on multiple CPUs
simultaneously. If the user is not using caller-id, they are
lost. Caller-id is the current solution to the interlaced logs.

For the long term, we should introduce a printk-context API that allows
callers to perfectly pack their multi-line output into a single
entry. We discussed [0][1] this back in August 2020.

John Ogness

[0] https://lore.kernel.org/lkml/472f2e553805b52d9834d64e4056db965edee329.camel@perches.com
[1] offlist message-id: 87d03k9ymz.fsf@jogness.linutronix.de
