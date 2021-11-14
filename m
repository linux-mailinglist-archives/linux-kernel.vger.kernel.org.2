Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DCA44FA25
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 20:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbhKNT1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 14:27:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39622 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhKNT12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 14:27:28 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636917870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=63PLfVb7dW8lL65XTFb1oxy68bJvoBTXpVEUNgWvzmc=;
        b=fZIEy/vBGZhQzpxBVjflGWHCUj4DSC8MDzSOnxcMRhsZwJtPKViJ5i74bC07xrrr8HRXF9
        39gbJVuJNl8GH6s62adfFL8smty7HpKDs+aim4g0uZgU4nfnSU/ACYE9q0VQZzSWxkQORg
        HSm8Ydy2koQe+bIKMnpcYchlCQDpz/ane5q8eIsyvvE8ujFbGrwgv5gQLWP7F5Cbyx7Ki/
        g7a0D35pzZltgsJWrmTcEvd3UOKr0lDJ1pSo83NDyt7CYOZiMe8ZWtvnX0ELx12W7/THWw
        hL0Uc2Z7qIM3EJI1/MdUzcqSf3su22ncUnje3nwYNffxMgldt74jnSQZDO9FCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636917870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=63PLfVb7dW8lL65XTFb1oxy68bJvoBTXpVEUNgWvzmc=;
        b=p0XZzqli/gu8VJrZCXhb51gz2oU06hUhDt/Dih7+aKym+7PDM9JvVE1OjkEuTSaQhE7hSk
        ii/MU8R0Tvp32SDQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT pull] timers/urgent for v5.16-rc1
In-Reply-To: <CAHk-=wjQxHwdC61ore062Hc5PAF2o6CJnDG_NsQe+e599RovJw@mail.gmail.com>
References: <163689642456.3249160.13397023971040961440.tglx@xen13>
 <163689642744.3249160.6971106813056927807.tglx@xen13>
 <CAHk-=wjQxHwdC61ore062Hc5PAF2o6CJnDG_NsQe+e599RovJw@mail.gmail.com>
Date:   Sun, 14 Nov 2021 20:24:29 +0100
Message-ID: <87pmr2pmky.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14 2021 at 11:02, Linus Torvalds wrote:
> On Sun, Nov 14, 2021 at 5:31 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> +       /*
>> +        * A copied work entry from the old task is not meaningful, clear it.
>> +        * N.B. init_task_work will not do this.
>> +        */
>> +       memset(&p->posix_cputimers_work.work, 0,
>> +              sizeof(p->posix_cputimers_work.work));
>> +       init_task_work(&p->posix_cputimers_work.work,
>> +                      posix_cpu_timers_work);
>
> Ugh.
>
> Instead of the added four lines of comment, and two lines of
> "memset()", maybe this should just have made init_task_work() DTRT?
>
> Yes,. I see this:
>
>         /* Protect against double add, see task_tick_numa and task_numa_work */
>         p->numa_work.next               = &p->numa_work;
>         ...
>         init_task_work(&p->numa_work, task_numa_work);
>
> but I think that one is so subtle and such a special case that it
> should have been updated - just make that magic special flag happen
> after the init_task_work.
>
> A lot of the other cases seem to zero-initialize things elsewhere
> (generally with kzalloc()), but I note that at least
> io_ring_exit_work() seems to have this:
>
>         struct io_tctx_exit exit;
>         ...
>         init_task_work(&exit.task_work, io_tctx_exit_cb);
>
> and the ->next pointer is never set to NULL.
>
> Now, in 99% of all cases the ->next pointer simply doesn't matter,
> because task_work_add() will only set it, not caring about the old
> value.
>
> But apparently it matters for posix_cputimers_work and for numa_work,
> and so I think it's very illogical that init_task_work() will not
> actually initialize it properly.
>
> Hmm?
>
> I've pulled this, but it really looks like the wrong solution to the
> whole "uninitialized data".
>
> And that task_tick_numa() special case is truly horrendous, and really
> should go after the init_task_work() regardless, exactly because you'd
> expect that init_task_work() to initialize the work even if it doesn't
> happen to right now.
>
> Or is somebody doing init_task_work() to only change the work-function
> on an already initialized work entry? Becuase that sounds both racy
> and broken to me, and none of the things I looked at from a quick grep
> looked like that at all.

I'll have a deeper look at that tomorrow.

Thanks,

        tglx
