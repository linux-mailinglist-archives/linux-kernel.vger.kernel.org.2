Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4FE3477EE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 13:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhCXMLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 08:11:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233100AbhCXMLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:11:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E044261A0A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616587863;
        bh=kEx0TIsJHajLeIyFUwPJAU5kpomMAoLZGOL83edNDYM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AnSjMG9UhEB4+85PdfpildgQIi/Yq58nviKe6bZkBkVeXl/4OMOhzilxaoK5MqKhJ
         kvzWlpvlIhUG8JNvkVzUlU3g5UiUl4btFKKJiYg/bu6cbuwUKghX7vwudnOj6P8Gk7
         rvlXPJy761kqBC76BhZ1+wLV/y750e8e5CBV0edSKzqi95C9xNv1PQ5QD4jbr9z3gy
         TMa7jNLIC+mqs+qlQ4BmkdO8+W5ngc5X80y9f3G18/1FLsnF5BEn2ErmUjU+A9G9Ka
         N7GHZZATIKFxcGEE8QhEoZBYr2Nyt3w8Dpo/xdR7Unksp79H7KYOMxtiOvvxdoSdRV
         Tr1FshV3f1I4g==
Received: by mail-lj1-f175.google.com with SMTP id z8so29847257ljm.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 05:11:02 -0700 (PDT)
X-Gm-Message-State: AOAM530/vydhLGAGd/SqXRSSD7GUV3IZS6XXJAyYlmipXUdEO1Eg2deu
        onBizf4SWkOqr76kOQrWO8M1qUm002SHSoPQqO8=
X-Google-Smtp-Source: ABdhPJzViXtP8zyzgXEgbL2g8vAs/9lwuvKdvQdVrCRF9Rz67/eCIn1+cEAu3zCO2mhfx2EctG6Feq95zSC122HKV9w=
X-Received: by 2002:a2e:994e:: with SMTP id r14mr1940414ljj.115.1616587861091;
 Wed, 24 Mar 2021 05:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <1616580892-80815-1-git-send-email-guoren@kernel.org> <YFsd7A6xzrWXi1l5@hirez.programming.kicks-ass.net>
In-Reply-To: <YFsd7A6xzrWXi1l5@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 24 Mar 2021 20:10:49 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTuraEf7uzVYJfZhFT3cGAo8w8AhLUuj8H-+TKFBmWk0A@mail.gmail.com>
Message-ID: <CAJF2gTTuraEf7uzVYJfZhFT3cGAo8w8AhLUuj8H-+TKFBmWk0A@mail.gmail.com>
Subject: Re: [PATCH] riscv: locks: introduce ticket-based spinlock implementation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Anup Patel <anup@brainfault.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Peter,

On Wed, Mar 24, 2021 at 7:09 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Mar 24, 2021 at 10:14:52AM +0000, guoren@kernel.org wrote:
> > +static inline void arch_spin_lock(arch_spinlock_t *lock)
> > +{
> > +     arch_spinlock_t lockval;
> > +     u32 tmp;
> > +
> > +     asm volatile (
> > +             "1:     lr.w    %0, %2          \n"
> > +             "       mv      %1, %0          \n"
> > +             "       addw    %0, %0, %3      \n"
> > +             "       sc.w    %0, %0, %2      \n"
> > +             "       bnez    %0, 1b          \n"
> > +             : "=&r" (tmp), "=&r" (lockval), "+A" (lock->lock)
> > +             : "r" (1 << TICKET_NEXT)
> > +             : "memory");
> >
> > +     while (lockval.tickets.next != lockval.tickets.owner) {
> > +             /*
> > +              * FIXME - we need wfi/wfe here to prevent:
> > +              *  - cache line bouncing
> > +              *  - saving cpu pipeline in multi-harts-per-core
> > +              *    processor
> > +              */
> > +             lockval.tickets.owner = READ_ONCE(lock->tickets.owner);
> > +     }
> >
> > +     __atomic_acquire_fence();
> >  }
>
> > +static inline void arch_spin_unlock(arch_spinlock_t *lock)
> >  {
> > +     smp_store_release(&lock->tickets.owner, lock->tickets.owner + 1);
> > +     /* FIXME - we need ipi/sev here to notify above */
> >  }
>
> Urgh, are you saying your WFE requires an explicit SEV like on ARM ? The
Yes, I'm considering that kind of code.

> ARM64 model is far superious IMO, and then you can use
> smp_cond_load_acquire() in arch_spin_lock() and call it a day.
Great tip, thx. I'll follow that.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
