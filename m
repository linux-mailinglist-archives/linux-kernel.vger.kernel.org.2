Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511EE3B68AD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 20:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbhF1Sta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 14:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbhF1St2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 14:49:28 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39342C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 11:47:01 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id v20so13071431eji.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 11:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YNTrWfcoiPrPW+WzaIxT5A0s+McPLMj+Y/fAIS8NTGU=;
        b=tfXqgJkBLD1l0dM32m90zIPv6WZJFDB42pT1FNu0Cfe7Zm9P+KB3hbOSIBxKA3ViYh
         97jkGNc/EweQ/KbhlqsvRKdlpwN1iSyM0190wQrGdm2veNhzbniffMz+2hK8RhGYNchc
         z0mvEP/uwk+xr/wchjVG8pzCyM0k4LUWSyLjuBjJmChtTF5JT2hs1aeZdR8k3LCC7rZo
         ZefxDMPWZC+Sr4Bjzglcz2RqQiNXZWc5RBwvjSSsMnilWBOXt9wvCYN/V7P+jmW336mU
         iikOnHVWGNXAl6CoKJ4xvKFkRI1lnw4qr0JdJJFc9xO7FaaOXmk+nkF7/S6Si4OStjXB
         WbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=YNTrWfcoiPrPW+WzaIxT5A0s+McPLMj+Y/fAIS8NTGU=;
        b=qxkQb/RetpuGA4DDsHUS+IAea3a8xtrNbwXQLg7DH+sfiT7IYN73HakhN4ICpXDOjB
         kW+UNRLvL+JWJwxhToRCcWSzDX5C4b3L9EW7IplIODAf3JtMQ/D1xMZti5CVhwljncWD
         vxGg/fQk+X5I7QVIGDVHssmUTd6ioUHsbrUoBJJe3rrJyN0ZociOnXn3oxSsj77g9nf1
         gYiEx1tIdZgWuGG0YrBMClst21vs96sM0L/kaF5tlnWD5WyAffQ+RT5ClOaMlGU4+jEj
         JZXDVdavOwW5sHqXfVE7EwfSWBfKWFJ+ThtSyNU0ytYPTwmCiupqZB2ECr5wpXbvQUMp
         bLsg==
X-Gm-Message-State: AOAM530LtzvMPBqG0E9udHbotg06lN7lUHmOpza2fp2LrYjGr7imZNCB
        LSYxCv1REqYYTlQpTWalReI=
X-Google-Smtp-Source: ABdhPJxImjO2UEAVzOJpKEDUb/FY1YK09W+7WIa35c0RF4umK5X0xzr5RWM786g8ZMfDf2gS644bHA==
X-Received: by 2002:a17:906:2dd3:: with SMTP id h19mr26060594eji.272.1624906019820;
        Mon, 28 Jun 2021 11:46:59 -0700 (PDT)
Received: from gmail.com (94-21-131-96.pool.digikabel.hu. [94.21.131.96])
        by smtp.gmail.com with ESMTPSA id n2sm9887738edi.32.2021.06.28.11.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 11:46:59 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 28 Jun 2021 20:46:57 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] sigqueue cache fix
Message-ID: <YNoZIVgboj6YKo3V@gmail.com>
References: <YNQwgTR3n3mSO9+3@gmail.com>
 <CAHk-=wiebYt6ZG4Cp8fWqVnNqxMN4pybDZQ6gwsTWFc0XP=XPw@mail.gmail.com>
 <CAHk-=wgEyk9X5NefUL7gaqXOSDkdzCEDi6RafxGvG+Uq8rGrgA@mail.gmail.com>
 <CAHk-=wiJq0Ns7_AFRW+rvZcD_m+1t5cYgvQRO-Gbp8TEK1x1bQ@mail.gmail.com>
 <YNlapAKObfeVPoQO@gmail.com>
 <CAHk-=wjLNCm5kNnbHkw38c1t80FAPVYmNOOiTvdqedNm1SQRZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjLNCm5kNnbHkw38c1t80FAPVYmNOOiTvdqedNm1SQRZg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, Jun 27, 2021 at 10:14 PM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > The most fundamental race we can have is this:
> 
> No. It's this (all on the same CPU):
> 
>    sigqueue_cache_or_free():
> 
>        if (!READ_ONCE(current->sigqueue_cache))
>                      <-- Interrupt happens here
>                WRITE_ONCE(current->sigqueue_cache, q);

Indeed - I was under the impression that this cannot happen, because 
interrupts are disabled - but I was wrong:

__sigqueue_free() is the only user of sigqueue_cache_or_free().

Callers of __sigqueue_free():

 - flush_sigqueue():
    # flush_signals() is holding the siglock & disables IRQs
    # __exit_signal() isn't holding the siglock but has IRQs disabled
    # selinux_bprm_committed_creds() is holding the siglock & disables IRQs

 - __flush_itimer_signals()
    # Its single caller is holding the siglock & disables IRQs

 - collect_signal()
    # Its single caller is holding the siglock & disables IRQs

 - dequeue_synchronous_signal()
    # Its single caller is holding the siglock & disables IRQs

 - flush_sigqueue_mask():
    # All callers are holding the siglock & disable IRQs

 - sigqueue_free()
    ...    

Boom, the last one on the list, sigqueue_free(), does __sigqueue_free() 
while not holding the siglock and not disabling interrupts. :-/

It does it in various syscall paths in the POSIX timers code through 
release_posix_timer(), with interrupts clearly enabled.

> and then the interrupt sends a SIGCONT, which ends up flushing
> previous process control signals, which ends up freeing them, which
> ends up in sigqueue_cache_or_free() again, at which point you have
> 
>        if (!READ_ONCE(current->sigqueue_cache))
>                WRITE_ONCE(current->sigqueue_cache, q);
> 
> again.
> 
> And both the original and the interrupting one sees a NULL
> current->sigqueue_cache, so both of them will do that WRITE_ONCE(),
> and when the interrupt returns, the original case will overwrite the
> value that the interrupt free'd.
> 
> Boom - memory leak.
> 
> It does seem to be very small race window, and it's "only" a memory
> leak, but it's a very simple example of how this cache was broken even
> on UP.

Yeah - a clear Producer <-> Producer IRQ preemptability race that can leak 
freed sigqueue structures.

Thanks for catching this ...

But even if release_posix_timer() is changed to call sigqueue_free() with 
IRQs disabled, or sigqueue_free() disables interrupts itself, I think we 
need to be mindful of the Consumer <-> Producer SMP races, which only 
appear to be safe due to an accidental barrier by free_uid().

Plus a lockdep_assert_irqs_disabled() would have helped a lot in catching 
this sooner.

Thanks,

	Ingo
