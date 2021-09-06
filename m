Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EE240174F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 09:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240293AbhIFHuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 03:50:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240232AbhIFHuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 03:50:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFAF260F43
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 07:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630914585;
        bh=Gc0lprsv7w/okSpJYAt55fjl1xzEXuErDUTeV6+8RZ4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JqP03wy8XTp7qDt1TgdOCzYKiph2r9C8s08SL+DZr0/Ssf56d7gjsvNFoitU8FIcK
         ttUIED0qi0nr1tE6fzWtStAVsAQWfNlJdz4nWl7DqJ88ywAtzWVL1qK6CN8USnVLRS
         GziyBcDGCB9M8SDb6JErMmJjd8tSrUuqsIcO+MAo+HSkukbC9s9WrvesnwYM1eJguB
         UBkgBTeOU8H3sWLkx3goAhleGOunGjpstAM0ahnBpny5xrdHeN3YBb24AI6i87J2Nq
         PPvMTXedZIq/TlgW5ZO3QxzPlD+i0BJ4wWtRHIBlcFQ1AookCd2DfJzU20lfktVpEm
         UIc8s7yxyCXEQ==
Received: by mail-ot1-f54.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so7790950otg.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 00:49:45 -0700 (PDT)
X-Gm-Message-State: AOAM530LIx8Zisq64dQTEjlfkCWAv/0MPO3WONXKu9zAJdWMd+KkMh4Y
        s5kOnQyfjcc2ZBODp0Q2LJnKeUizZWLfsXpzAqI=
X-Google-Smtp-Source: ABdhPJw2KhJSX56bD1ujc4nIOhS/AujhCUCRQrLrbPPE+SfehRlXCts4tMFpDIOxUFDz2OkohPYafgZKcJSPeDIus0w=
X-Received: by 2002:a9d:12e2:: with SMTP id g89mr10172221otg.112.1630914585091;
 Mon, 06 Sep 2021 00:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210902155429.3987201-1-keithp@keithp.com> <20210904060908.1310204-1-keithp@keithp.com>
 <20210904060908.1310204-3-keithp@keithp.com> <CAMj1kXHHb_d4Exg7_5OdB-Ah=EQxVEUgEv1agUQZg-Rz8pLd5Q@mail.gmail.com>
 <8735qifcy6.fsf@keithp.com>
In-Reply-To: <8735qifcy6.fsf@keithp.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 6 Sep 2021 09:49:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFQHX-PDQXaRXGNjyJNn_frf9tYNFND06DAYC095JhDbw@mail.gmail.com>
Message-ID: <CAMj1kXFQHX-PDQXaRXGNjyJNn_frf9tYNFND06DAYC095JhDbw@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: Move thread_info into task_struct (v7 only)
To:     Keith Packard <keithp@keithp.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abbott Liu <liuwenliang@huawei.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Jens Axboe <axboe@kernel.dk>, Jian Cai <jiancai@google.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Wolfram Sang (Renesas)" <wsa+renesas@sang-engineering.com>,
        YiFei Zhu <yifeifz2@illinois.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Sept 2021 at 08:14, Keith Packard <keithp@keithp.com> wrote:
>
> Ard Biesheuvel <ardb@kernel.org> writes:
>
> > c13 is not a register, it is a value in one of the dimensions of the
> > ARM sysreg space, and probably covers other system registers that
> > pre-v7 cores do implement.
>
> > Better to use its architectural name (TPIDRPRW) and clarify that
> > pre-v6k/v7 cores simply don't implement it.
>
> Thanks, I'll reword the commit message
>
> > Could we split this up?
>
> I could split up the assembler macro changes which add a temporary
> register to the calls getting the current thread_info/task_struct value?
> If that would help get this reviewed, I'd be happy to do
> that. Otherwise, it's pretty much all-or-nothing as enabling
> THREAD_INFO_IN_TASK requires a bunch of synchronized changes.
>

Sure, so it is precisely for that reason that it is better to isolate
changes that can be isolated.

...
> >> +DECLARE_PER_CPU(struct task_struct *, current_task);
> >> +
> >> +static __always_inline struct task_struct *get_current(void)
> >> +{
> >> +       return raw_cpu_read(current_task);
> >
> > This needs to run with preemption disabled, or we might get migrated
> > to another CPU halfway through, and produce the wrong result (i.e.,
> > the current task of the CPU we migrated from). However, it appears
> > that manipulating the preempt count will create a circular dependency
> > here.
>
> Yeah, I really don't understand the restrictions of this API well. Any
> code fetching the current task pointer better not be subject to
> preemption or that value will be stale at some point after it was
> computed. Do you know if it could ever be run in a context allowing
> preemption?

All the time. 'current' essentially never changes value from the POV
of code running in task context, so there is usually no reason to care
about preemption/migration when referring to it. Using per-CPU
variables is what creates the problem here.

> >
> > Instead of using a per-CPU variable for current, I think it might be
> > better to borrow another system register (TPIDRURO or TPIDRURW) to
> > carry 'current' when THREAD_INFO_IN_TASK is in effect, similar to how
> > arm64 uses SP_EL0 - those registers could be preserved/restored in the
> > entry/exit from/to user space paths rather than in the context switch
> > path, and then be used any way we like while running in the kernel.
>
> Making sure these values don't leak through to user space somehow? I'm
> not excited by that prospect at all.

Moving the code that pokes the right user space value into these
registers from the context switch patch to the user space exit path
should be rather straight-forward, so I am not too concerned about
security issues here (famous last words)

> But, perhaps someone can help me
> understand the conditions under which the current task value can be
> computed where preemption was enabled and have that not be a problem for
> the enclosing code?
>

In principle, it should be sufficient to run the per-CPU variable load
sequence with preemption disabled. For instance, your asm version

       movw    \dst, #:lower16:\sym
       movt    \dst, #:upper16:\sym
       this_cpu_offset \tmp
       ldr     \dst, [\dst, \tmp]

must not be preempted and migrated right before the ldr instruction,
because that would end up accessing another CPU's value for 'current'.

However, the preempt_count itself is stored in thread_info as well, so
I'm not sure there is a way we can safely disable preemption for this
sequence to begin with, unless we run the above with interrupts
disabled.

Given that we are already relying on the MP extensions for this
anyway, I personally think that using another thread ID register to
carry 'current' is a reasonable approach as well, since it would also
allow us to get per-task stack protector support into the compiler.
But I would like to hear from some other folks on cc as well.
