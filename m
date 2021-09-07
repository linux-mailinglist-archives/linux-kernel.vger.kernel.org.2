Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E465402C91
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 18:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244356AbhIGQHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 12:07:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243976AbhIGQHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 12:07:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8529A61106
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 16:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631030769;
        bh=1L/ng3m4NIBOnr8uJkim7/Whttmr/PGC9aOgg/t9Axg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MSYCdzfG4ct3IH+Drqzg4YYE0HMENTgnPq2jUOnU71YIf7AAn2NM6J6yOVqwu7M5a
         Yss0GwkvIYPpEYuRsUpkW+CdNuehP9jHZbjR21v3cdiLOXBywJHHNDaSw7Fq9UPXZz
         1ffY4V6cC9A+P079htCwPbMUYslcwzu+dcTUePXMCt3KViNdzxTZa0UE0Mt/daNic5
         dQ7PClxqvQbAvHTkJIMiY29eNJ8NslH+g1IaKg5ah5QJX2DxRyx96zUP2GWE7D79lM
         fP2qAhRdnOEY8I+mgP1k0EPz2sTYCpLZAJ7WnxXUC8+FJZsva3h+ZToigTJbD8hbhN
         Z2CSikksmQjGA==
Received: by mail-oo1-f50.google.com with SMTP id y16-20020a4ad6500000b0290258a7ff4058so3055627oos.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 09:06:09 -0700 (PDT)
X-Gm-Message-State: AOAM530YeAz4/zYCsLMcSZNp7xDgyvUp/YJJVzQI+qxntQdYuCNDAgW1
        yt7q7LvugxZKSG/pPopz+JRK0DDhG+lTxaPbWWc=
X-Google-Smtp-Source: ABdhPJzCHK/gFgjxE677WaXrrlZNPfq5Xf3OssXYH00UAECgEt6c16PeLBnUnBaGFDeDwFDWHl8W3OIfmHf2xWev+Hg=
X-Received: by 2002:a4a:c904:: with SMTP id v4mr537358ooq.26.1631030768782;
 Tue, 07 Sep 2021 09:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210902155429.3987201-1-keithp@keithp.com> <20210904060908.1310204-1-keithp@keithp.com>
 <20210904060908.1310204-3-keithp@keithp.com> <CAMj1kXHHb_d4Exg7_5OdB-Ah=EQxVEUgEv1agUQZg-Rz8pLd5Q@mail.gmail.com>
 <8735qifcy6.fsf@keithp.com> <CAMj1kXFQHX-PDQXaRXGNjyJNn_frf9tYNFND06DAYC095JhDbw@mail.gmail.com>
 <874kawcssr.fsf@keithp.com>
In-Reply-To: <874kawcssr.fsf@keithp.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 7 Sep 2021 18:05:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHA-GiAj2u4vRbEsnJ6O=cxiNOEgPHWHP+71dB-sp9Nww@mail.gmail.com>
Message-ID: <CAMj1kXHA-GiAj2u4vRbEsnJ6O=cxiNOEgPHWHP+71dB-sp9Nww@mail.gmail.com>
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

On Tue, 7 Sept 2021 at 17:24, Keith Packard <keithp@keithp.com> wrote:
>
> Ard Biesheuvel <ardb@kernel.org> writes:
>
> > Sure, so it is precisely for that reason that it is better to isolate
> > changes that can be isolated.
>
> I'll go ahead and split this apart then; that is how I did development,
> after all.
>
> > All the time. 'current' essentially never changes value from the POV
> > of code running in task context, so there is usually no reason to care
> > about preemption/migration when referring to it. Using per-CPU
> > variables is what creates the problem here.
>
> Thanks for helping me -- I just got the wrong model stuck in my head
> over the weekend somehow.
>
> If I do have this figured out, we should be able to stick the
> per_cpu_offset value in thread_info and use TPIDRPRW to hold 'current'
> as code using per_cpu_offset should already be disabling
> preemption. That should be an easier change than putting a kernel
> pointer in a user-visible register.
>

That is still a bit tricky, given that you now have to swap out the
per-CPU offset when you migrate a task, and the generic code is not
really set up for that.

> > Given that we are already relying on the MP extensions for this
> > anyway, I personally think that using another thread ID register to
> > carry 'current' is a reasonable approach as well, since it would also
> > allow us to get per-task stack protector support into the compiler.
> > But I would like to hear from some other folks on cc as well.
>
> That would be awesome; I assume that doesn't require leaving
> per_cpu_offset in a thread ID register?
>
> In any case, I'll give my plan a try, and then see about trying your
> plan as well so I can compare the complexity of the two solutions.
>

I had a stab at this myself today (long boring day with no Internet connection).

https://android-kvm.googlesource.com/linux/+log/refs/heads/ardb/arm32-ti-in-task

It resembles your code in some places - I suppose we went on the same
journey in a sense :-) We'll fix up the credits before this gets
resubmitted.

Fixing the per-task stack protector plugin on top of these changes
should be trivial but I need a coffee first.
