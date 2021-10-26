Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D041D43AE80
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 11:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhJZJF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 05:05:56 -0400
Received: from mail-ua1-f42.google.com ([209.85.222.42]:45908 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbhJZJFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 05:05:52 -0400
Received: by mail-ua1-f42.google.com with SMTP id f24so8586213uav.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 02:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WP4KMCUXl+rWEf2feu/35l51pXt02OCY9vDl3R9CVSQ=;
        b=ocmm1T/fLVs7tuAnKsx0KMQdfBv4RxIXcJkuSE4L/0cz1lZGO1lpNUqV3t7ByZ1AeW
         9GD1kQRoP3A5i8dktqVehqYP+Ei9p0+i2D1V9yqHFd2PnT08mZZj+eDCdnbt+xQi4QHS
         /G5iylx5pcHPUJAlfYDIq4kVc2dA9om3K8EljZsJENxU8JCxm7WAW/JIsVXR5THJ3BMM
         XpTiUuVkJoy1pjNEXRFGOjsrbb/pUvFbOsTNLK9pcz9lwPM3UfUIYweC4jDVzhnsxMDt
         3JBzpL8iJMuj8NFfDBZfBJ8/ultDkK+O0VjCYNuipcSdAidwZlOAhr4GM44snfrbxWS1
         /Tag==
X-Gm-Message-State: AOAM533cdD9syCf5qI4xjaK6HW4EXJfxLIrIuPrCcBSDyF6X0hx6atUb
        cleVqvB+DyHn7oUFd1EUU62vgH6qNZtfuQ==
X-Google-Smtp-Source: ABdhPJyRt557JpGe12gw3l9R/uEcSDnn8wCw2pjfOX4VbSWG9zqXApvS4SD3htR0pIONQk0EwiZeNQ==
X-Received: by 2002:ab0:5542:: with SMTP id u2mr21852938uaa.62.1635239008181;
        Tue, 26 Oct 2021 02:03:28 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id k185sm10471363vsc.21.2021.10.26.02.03.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 02:03:27 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id e10so27790042uab.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 02:03:27 -0700 (PDT)
X-Received: by 2002:a67:cb0a:: with SMTP id b10mr21592387vsl.9.1635239007608;
 Tue, 26 Oct 2021 02:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdUPWOjJfJohxLJefHOrJBtXZ0xfHQt4=hXpUXnasiN+AQ@mail.gmail.com>
 <CAOnJCULgjUsnb__QrUFdop3Nr9t6G5WtSsG+EE2d4_e+b7Dy5Q@mail.gmail.com>
In-Reply-To: <CAOnJCULgjUsnb__QrUFdop3Nr9t6G5WtSsG+EE2d4_e+b7Dy5Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 Oct 2021 11:03:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUBFE+dzg0Lqechmj8D4ssJS5O_UCrDBtToWn-EP+0T_g@mail.gmail.com>
Message-ID: <CAMuHMdUBFE+dzg0Lqechmj8D4ssJS5O_UCrDBtToWn-EP+0T_g@mail.gmail.com>
Subject: Re: Out-of-bounds access when hartid >= NR_CPUS
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atish,

On Tue, Oct 26, 2021 at 10:55 AM Atish Patra <atishp@atishpatra.org> wrote:
> On Mon, Oct 25, 2021 at 8:54 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > When booting a kernel with CONFIG_NR_CPUS=4 on Microchip PolarFire,
> > the 4th CPU either fails to come online, or the system crashes.
> >
> > This happens because PolarFire has 5 CPU cores: hart 0 is an e51,
> > and harts 1-4 are u54s, with the latter becoming CPUs 0-3 in Linux:
> >   - unused core has hartid 0 (sifive,e51),
> >   - processor 0 has hartid 1 (sifive,u74-mc),
> >   - processor 1 has hartid 2 (sifive,u74-mc),
> >   - processor 2 has hartid 3 (sifive,u74-mc),
> >   - processor 3 has hartid 4 (sifive,u74-mc).
> >
> > I assume the same issue is present on the SiFive fu540 and fu740
> > SoCs, but I don't have access to these.  The issue is not present
> > on StarFive JH7100, as processor 0 has hartid 1, and processor 1 has
> > hartid 0.
> >
> > arch/riscv/kernel/cpu_ops.c has:
> >
> >     void *__cpu_up_stack_pointer[NR_CPUS] __section(".data");
> >     void *__cpu_up_task_pointer[NR_CPUS] __section(".data");
> >
> >     void cpu_update_secondary_bootdata(unsigned int cpuid,
> >                                        struct task_struct *tidle)
> >     {
> >             int hartid = cpuid_to_hartid_map(cpuid);
> >
> >             /* Make sure tidle is updated */
> >             smp_mb();
> >             WRITE_ONCE(__cpu_up_stack_pointer[hartid],
> >                        task_stack_page(tidle) + THREAD_SIZE);
> >             WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);
> >
> > The above two writes cause out-of-bound accesses beyond
> > __cpu_up_{stack,pointer}_pointer[] if hartid >= CONFIG_NR_CPUS.
> >
> >     }
> >
>
> Thanks for reporting this. We need to fix this and definitely shouldn't hide it
> using configs. I guess I never tested with lower values (2 or 4) for
> CONFIG_NR_CPUS which explains how this bug was not noticed until now.

> > How to fix this?
> >
> > We could skip hartids >= NR_CPUS, but that feels strange to me, as
> > you need NR_CPUS to be larger (much larger if the first usable hartid
> > is a large number) than the number of CPUs used.
> >
> > We could store the minimum hartid, and always subtract that when
> > accessing __cpu_up_{stack,pointer}_pointer[] (also in
> > arch/riscv/kernel/head.S), but that means unused cores cannot be in the
> > middle of the hartid range.
>
> Yeah. Both of the above proposed solutions are not ideal.
>
> >
> > Are hartids guaranteed to be continuous? If not, we have no choice but
> > to index __cpu_up_{stack,pointer}_pointer[] by cpuid instead, which
> > needs a more expensive conversion in arch/riscv/kernel/head.S.
>
> This will work for ordered booting with SBI HSM extension. However, it may
> fail for spinwait booting because cpuid_to_hartid_map might not have setup
> depending on when secondary harts are jumping to linux.
>
> Ideally, the size of the __cpu_up_{stack,task}_pointer[] should be the maximum
> hartid possible. How about adding a config for that ?

(reading more RISC-V specs)
Hart IDs can use up to XLEN (32, 64, or 128) bits. So creative sparse
multi-level encodings like used in MPIDR on ARM[1] makes using a
simple array infeasible.

[1] arch/arm{,64}/include/asm/cputype.h

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
