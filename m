Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D36734A62E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 12:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhCZLNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 07:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhCZLMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 07:12:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085E4C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 04:12:45 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616757158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7RxLJNwSY/A5SoVhWSfv2pmplPu4MvBBsF6rRlDKAJ0=;
        b=IM/b29laeEiAoFSv+02zMVKnUvwBIVAYGQtqO0mk287ab7q370BFBxTgBvdwauorRqW8ka
        3OJTWc6XhWgKfbDrAHBDen1simtfKPKuZ0bI0IzpM/JJ8IQZGEj0CkfkWYeM95aI6XN7kJ
        rpbuADUHsCTRy9HYjgv/l5qjydPZM3lVD4xoSAEqVO4cZ9Gs3Z3RQwwTgpAXom9fvnVW6N
        e8JW42vfPbqQtgX88zR5Q+fSxvePgbmIl8WXh0TodTDQQhjjTPElXgbUXKhbR1mq4NdYkS
        rZL0cj2H+Q0xPWIg0papxzdKddU2Zi25SnLz6tG9E3HhWvd0Crn9JV9qVbUC5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616757158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7RxLJNwSY/A5SoVhWSfv2pmplPu4MvBBsF6rRlDKAJ0=;
        b=4oEUatYSA7YP5RGM/INPugkii8zZ4EjltzCG2fwMvg7n0iLo1Rqh0Z4Do/UMMnpfULteXb
        re5uVkGdenKtW2Bg==
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
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alistair Popple <alistair@popple.id.au>,
        Jordan Niethe <jniethe5@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Yue Hu <huyue2@yulong.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Rafael Aquini <aquini@redhat.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org
Subject: Re: [PATCH next v1 2/3] printk: remove safe buffers
In-Reply-To: <YFnHKlCvIA2nI41c@alley>
References: <20210316233326.10778-1-john.ogness@linutronix.de> <20210316233326.10778-3-john.ogness@linutronix.de> <YFnHKlCvIA2nI41c@alley>
Date:   Fri, 26 Mar 2021 12:12:37 +0100
Message-ID: <87pmzmi2xm.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-23, Petr Mladek <pmladek@suse.com> wrote:
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -1142,8 +1126,6 @@ void __init setup_log_buf(int early)
>>  		 new_descs, ilog2(new_descs_count),
>>  		 new_infos);
>>  
>> -	printk_safe_enter_irqsave(flags);
>> -
>>  	log_buf_len = new_log_buf_len;
>>  	log_buf = new_log_buf;
>>  	new_log_buf_len = 0;
>> @@ -1159,8 +1141,6 @@ void __init setup_log_buf(int early)
>>  	 */
>>  	prb = &printk_rb_dynamic;
>>  
>> -	printk_safe_exit_irqrestore(flags);
>
> This will allow to add new messages from the IRQ context when we
> are copying them to the new buffer. They might get lost in
> the small race window.
>
> Also the messages from NMI might get lost because they are not
> longer stored in the per-CPU buffer.
>
> A possible solution might be to do something like this:
>
> 	prb_for_each_record(0, &printk_rb_static, seq, &r)
> 		free -= add_to_rb(&printk_rb_dynamic, &r);
>
> 	prb = &printk_rb_dynamic;
>
> 	/*
> 	 * Copy the remaining messages that might have appeared
> 	 * from IRQ or NMI context after we ended copying and
> 	 * before we switched the buffers. They must be finalized
> 	 * because only one CPU is up at this stage.
> 	 */
> 	prb_for_each_record(seq, &printk_rb_static, seq, &r)
> 		free -= add_to_rb(&printk_rb_dynamic, &r);

OK. I'll probably rework it some and combine it with the "dropped" test
so that we can identify if messages were dropped during the transition
(because of static ringbuffer overrun).

>> -
>>  	if (seq != prb_next_seq(&printk_rb_static)) {
>>  		pr_err("dropped %llu messages\n",
>>  		       prb_next_seq(&printk_rb_static) - seq);
>> @@ -2666,7 +2631,6 @@ void console_unlock(void)
>>  		size_t ext_len = 0;
>>  		size_t len;
>>  
>> -		printk_safe_enter_irqsave(flags);
>>  skip:
>>  		if (!prb_read_valid(prb, console_seq, &r))
>>  			break;
>> @@ -2711,6 +2675,8 @@ void console_unlock(void)
>>  				printk_time);
>>  		console_seq++;
>>  
>> +		printk_safe_enter_irqsave(flags);
>
> What is the purpose of the printk_safe context here, please?

console_lock_spinning_enable() needs to be called with interrupts
disabled. I should have just used local_irq_save().

I could add local_irq_save() to console_lock_spinning_enable() and
restore them at the end of console_lock_spinning_disable_and_check(),
but then I would need to add a @flags argument to both functions. I
think it is simpler to just do the disable/enable from the caller,
console_unlock().

BTW, I could not find any sane way of disabling interrupts via a
raw_spin_lock_irqsave() of @console_owner_lock because of the how it is
used with lockdep. In particular for
console_lock_spinning_disable_and_check().

John Ogness
