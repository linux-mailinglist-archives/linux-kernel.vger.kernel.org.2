Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17FD43AE6F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 10:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhJZJAD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Oct 2021 05:00:03 -0400
Received: from mail-ua1-f52.google.com ([209.85.222.52]:37862 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhJZJAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 05:00:02 -0400
Received: by mail-ua1-f52.google.com with SMTP id f4so27704594uad.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 01:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wHMJT8hsNB0mIrUoXmplhj21JrUEEtFBSYSzEEGXMi4=;
        b=hJCkJZMCV+dTS6cZkMAWDA+YVUUy/IIXqLhZK4mQF2O4v0AHXJJF52rM2DCJlmtyaw
         pzDaG6ev+WTTmXVaWTHK1px0JDhtv9H9erorRbZje38tUssA9SffQjAYu6utly84UTt4
         9XnsMPQDlebMqPX/h9oLlQ0HvnDdLSuCy0eBCWr6bdNxFqttp1UfoBluNGfbL0yNOMuw
         rV1WrietKYo5pIKm3OSCobcG0RyL2YMJLDNDY0SxFOgQxQlFwWmWxW3a2+XY+d6/NnNY
         tFippQ3NWoCPrcfmzGYXisxkddPE6aj4ZWQ0U1FIur8FTGL5HX5q+tmZFk7PUKSjXoi6
         ZULA==
X-Gm-Message-State: AOAM531jP9/PwYdFnjofj6aaarFMbDOlXug2jzLjTIqnFflpZR2mIlA3
        M2DoAj+XzUjWwWWqhdsraNso9deG8hVmKA==
X-Google-Smtp-Source: ABdhPJyh2TqfrE8B7IwOhQCxdd1iPere20d4YiDhU47XL8pfKh5sZhv6EDXjp+PRO5rAxM94oMpiPw==
X-Received: by 2002:a67:ed07:: with SMTP id l7mr21204031vsp.40.1635238658069;
        Tue, 26 Oct 2021 01:57:38 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id d27sm41319vkq.16.2021.10.26.01.57.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 01:57:37 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id s4so3477300uaq.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 01:57:37 -0700 (PDT)
X-Received: by 2002:ab0:3154:: with SMTP id e20mr21946342uam.14.1635238657335;
 Tue, 26 Oct 2021 01:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdUPWOjJfJohxLJefHOrJBtXZ0xfHQt4=hXpUXnasiN+AQ@mail.gmail.com>
 <830eda64-6e66-c61b-ceaa-57be87783b2c@w6rz.net> <CAMuHMdU+jgNK8QCEysHnURkpUcazPOoepK32XzV8UGwVQdL5tw@mail.gmail.com>
 <2328512.Zi2KH1A685@diego>
In-Reply-To: <2328512.Zi2KH1A685@diego>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 Oct 2021 10:57:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW7NCC3siVp6avaTRffrdFr+OMXvLeGzdHZJOg+B5aGJw@mail.gmail.com>
Message-ID: <CAMuHMdW7NCC3siVp6avaTRffrdFr+OMXvLeGzdHZJOg+B5aGJw@mail.gmail.com>
Subject: Re: Out-of-bounds access when hartid >= NR_CPUS
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     re@w6rz.net, linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Tue, Oct 26, 2021 at 10:53 AM Heiko Stübner <heiko@sntech.de> wrote:
> Am Dienstag, 26. Oktober 2021, 08:44:31 CEST schrieb Geert Uytterhoeven:
> > On Tue, Oct 26, 2021 at 2:37 AM Ron Economos <re@w6rz.net> wrote:
> > > On 10/25/21 8:54 AM, Geert Uytterhoeven wrote:
> > > > When booting a kernel with CONFIG_NR_CPUS=4 on Microchip PolarFire,
> > > > the 4th CPU either fails to come online, or the system crashes.
> > > >
> > > > This happens because PolarFire has 5 CPU cores: hart 0 is an e51,
> > > > and harts 1-4 are u54s, with the latter becoming CPUs 0-3 in Linux:
> > > >    - unused core has hartid 0 (sifive,e51),
> > > >    - processor 0 has hartid 1 (sifive,u74-mc),
> > > >    - processor 1 has hartid 2 (sifive,u74-mc),
> > > >    - processor 2 has hartid 3 (sifive,u74-mc),
> > > >    - processor 3 has hartid 4 (sifive,u74-mc).
> > > >
> > > > I assume the same issue is present on the SiFive fu540 and fu740
> > > > SoCs, but I don't have access to these.  The issue is not present
> > > > on StarFive JH7100, as processor 0 has hartid 1, and processor 1 has
> > > > hartid 0.
> > > >
> > > > arch/riscv/kernel/cpu_ops.c has:
> > > >
> > > >      void *__cpu_up_stack_pointer[NR_CPUS] __section(".data");
> > > >      void *__cpu_up_task_pointer[NR_CPUS] __section(".data");
> > > >
> > > >      void cpu_update_secondary_bootdata(unsigned int cpuid,
> > > >                                         struct task_struct *tidle)
> > > >      {
> > > >              int hartid = cpuid_to_hartid_map(cpuid);
> > > >
> > > >              /* Make sure tidle is updated */
> > > >              smp_mb();
> > > >              WRITE_ONCE(__cpu_up_stack_pointer[hartid],
> > > >                         task_stack_page(tidle) + THREAD_SIZE);
> > > >              WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);
> > > >
> > > > The above two writes cause out-of-bound accesses beyond
> > > > __cpu_up_{stack,pointer}_pointer[] if hartid >= CONFIG_NR_CPUS.
> > > >
> > > >      }

> > https://riscv.org/wp-content/uploads/2017/05/riscv-privileged-v1.10.pdf
> > says:
> >
> >     Hart IDs might not necessarily be numbered contiguously in a
> >     multiprocessor system, but at least one hart must have a hart
> >     ID of zero.
> >
> > Which means indexing arrays by hart ID is a no-go?
>
> Isn't that also similar on aarch64?
>
> On a rk3399 you get 0-3 and 100-101 and with the paragraph above
> something like this could very well exist on some riscv cpu too I guess.

Yes, it looks like hart IDs are similar to MPIDRs on ARM.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
