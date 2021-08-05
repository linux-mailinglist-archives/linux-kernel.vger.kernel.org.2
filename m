Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F7C3E17F5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242223AbhHEP1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242127AbhHEP06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:26:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9202C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 08:26:43 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628177201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Am0ocKpy+2pGpqm9JCRDZYqJCT1OWyUtNSJNcsG07JY=;
        b=XH8M6OzweAtKAkh4iJj7Cf+MNMviDqdfaO2EFp+BdEV2tRZVDGryqVMZpf3OREy5TrKz1u
        ZvO+eK2BUPcuoZbBuQeZpMBwkNgvWMfaVeqlUAgf2IcqnXwLNHtRtq85d7EfPbUfzOs6ba
        /6NPHqQ8oNcKt5id8/LyEulwyhQoiGB/mb4snoayA0cOYisKGu8QQWLaEUQjWGj3Kjcpkc
        MbbQT5Dv3gGfdfAfpc94d+69BTM+ttkR/edps0sSyvWSG6fv3d2KXjdUWJKY5+rso3fo53
        zbMZDPdXK8Ka554Hvn462Wd1DyCw6CjoabZTCc7UOpey6z76DujZTqxNwF+65g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628177201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Am0ocKpy+2pGpqm9JCRDZYqJCT1OWyUtNSJNcsG07JY=;
        b=q9OWkyBpSSO7g/5rjPrv/A+l+8bdvty3T+x3aDYII0nAuRmGz1yIE3bOnj/RMWc312cc1A
        G/h1oh5jdJ1NxsCA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1 06/10] printk: use seqcount_latch for console_seq
In-Reply-To: <YQvWuzpAv1Tw/CoQ@alley>
References: <20210803131301.5588-1-john.ogness@linutronix.de> <20210803131301.5588-7-john.ogness@linutronix.de> <YQvWuzpAv1Tw/CoQ@alley>
Date:   Thu, 05 Aug 2021 17:32:40 +0206
Message-ID: <87bl6bx68f.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-05, Petr Mladek <pmladek@suse.com> wrote:
> On Tue 2021-08-03 15:18:57, John Ogness wrote:
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index d07d98c1e846..f8f46d9fba9b 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -2912,18 +2920,19 @@ void console_unblank(void)
>>   */
>>  void console_flush_on_panic(enum con_flush_mode mode)
>>  {
>> -	/*
>> -	 * If someone else is holding the console lock, trylock will fail
>> -	 * and may_schedule may be set.  Ignore and proceed to unlock so
>> -	 * that messages are flushed out.  As this can be called from any
>> -	 * context and we don't want to get preempted while flushing,
>> -	 * ensure may_schedule is cleared.
>> -	 */
>> -	console_trylock();
>> -	console_may_schedule = 0;
>> -
>> -	if (mode == CONSOLE_REPLAY_ALL)
>> -		console_seq = prb_first_valid_seq(prb);
>> +	if (console_trylock()) {
>> +		if (mode == CONSOLE_REPLAY_ALL)
>> +			latched_seq_write(&console_seq, prb_first_valid_seq(prb));
>
> I am scratching my head about this. Of course, latched_seq_write() does
> not guarantee the result when the console lock it taken by another process.
> But console_lock(), called below, will call latched_seq_write()
> anyway.
>
> Also CONSOLE_REPLAY_ALL is used by panic_print_sys_info().
> It is called the following way:
>
> void panic(const char *fmt, ...)
> {
> [...]
> 	debug_locks_off();
> 	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
>
> 	panic_print_sys_info();
> [...]
> }
>
> On one hand, console_flush_on_panic(CONSOLE_FLUSH_PENDING) will
> most likely take over the console lock even when it was taken
> by another CPU before. And the 2nd console_flush_on_panic()
> called from panic_print_sys_info() will not even notice.
>
> On the other hand, CONSOLE_REPLAY_ALL would not even try to
> reply the log when the console log was not available.
>
> The risk of broken console_seq is neglible. console_unlock()
> should be safe even with invalid console_seq.
>
> My opinion:
>
> I suggest to keep the original logic and maybe add some comment:
>
> void console_flush_on_panic(enum con_flush_mode mode)
> {
> 	/*
> 	 * If someone else is holding the console lock, trylock will fail
> 	 * and may_schedule may be set.  Ignore and proceed to unlock so
> 	 * that messages are flushed out.  As this can be called from any
> 	 * context and we don't want to get preempted while flushing,
> 	 * ensure may_schedule is cleared.
> 	 */
> 	console_trylock();
> 	console_may_schedule = 0;
>
> 	/*
> 	 * latched_seq_write() does not guarantee consistent values
> 	 * when console_trylock() failed. But this is the best effort.
> 	 * console_unlock() will update anyway console_seq. prb_read_valid()
> 	 * handles even invalid sequence numbers.
> 	 */
> 	if (mode == CONSOLE_REPLAY_ALL)
> 		latched_seq_write(&console_seq, prb_first_valid_seq(prb));
>
> 	console_unlock();
> }

I see now that CONSOLE_REPLAY_ALL is not handled correctly. And in the
follow-up patch "printk: introduce kernel sync mode" the situation gets
worse. I am trying to find ways to handle things without blindly
ignoring locks and hoping for the best.

I need to re-evaluate how to correctly support this feature.

John Ogness
