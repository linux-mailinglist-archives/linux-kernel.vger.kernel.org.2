Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5C63791C1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236986AbhEJPAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 11:00:38 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:33515 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbhEJO6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:58:09 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N9Mh8-1lU8su1wGq-015MkI for <linux-kernel@vger.kernel.org>; Mon, 10 May
 2021 16:56:56 +0200
Received: by mail-wr1-f42.google.com with SMTP id a4so16965461wrr.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 07:56:56 -0700 (PDT)
X-Gm-Message-State: AOAM532Ju+NLboerowGgvzrUmtF/VD4iRZFpdTGPE6/ZHF4eUZTJPvIO
        HTbvTkCqgYLYifjIwQp3bFWI9e8mrjeVB4VMbSA=
X-Google-Smtp-Source: ABdhPJzLhK+6dK2kVa9PC0jEFJzY6lmYEY2jSX/DeT/kT+KEtvjw7WX9R3JpxZUEMpRv8BlZSHIfK4v5FJpASf/adYI=
X-Received: by 2002:a5d:4452:: with SMTP id x18mr32127556wrr.286.1620658616195;
 Mon, 10 May 2021 07:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210510093753.40683-1-mark.rutland@arm.com>
In-Reply-To: <20210510093753.40683-1-mark.rutland@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 10 May 2021 16:56:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0pO=Jqbd503Kx-H_S1AzikcPjHT5=40ACZuxSF3dUFNQ@mail.gmail.com>
Message-ID: <CAK8P3a0pO=Jqbd503Kx-H_S1AzikcPjHT5=40ACZuxSF3dUFNQ@mail.gmail.com>
Subject: Re: [PATCH 00/33] locking/atomic: convert all architectures to ARCH_ATOMIC
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Brian Cain <bcain@codeaurora.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Zankel <chris@zankel.net>, Rich Felker <dalias@libc.org>,
        David Miller <davem@davemloft.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>, Guo Ren <guoren@kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Richard Henderson <rth@twiddle.net>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:f+TJbClpnUzvyohwXNw7YAK6C2y3NUvZhrdoN8WDgL6aSfRCsPc
 HOodKFCtHEYlsFNozHwEeTo5JCn7xUBl/Ha2bMcKYYDwXVfdhhytmtxRmIeG0hBgXranGXk
 XIhKmX4+KQLQBTOfn/mLhpv7Xlbov4QGKdn9TsyzTUHy1gYhANSE/mxyEuFHitdx/+JTyQF
 soetJv5k9kg4MOxT9jDdQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fH2mYd4u7w8=:g296hBbgzmrVqQWl7UTr1m
 MXc8KS03jeTqWBRtynDPtQ1EOukMbWP0LxaTiBlc9QQ0P8uUxmOZA1DBK6a93p89bjWcAnala
 ncX5TqXD47gwcOvW59j1WrVR06slmFBCN2yMY8k3BqffaaX6GogMIXnxUX+0Csy7ovz5Fw7cQ
 gnAQInBWDL1wCsA6D20fQP8Jh4d+LVr05/A8+EMudk0m7C8wQh3wQVLoOGtrU7cnirKX1OLZr
 tkfXBD4uryxQl8ilJFl3LE2iaaq2x5Oxl2hdtlMZKAYhrespJFIRAr/Hx66j7b6+ftU+Ivch8
 GEta80O+AhmYzBly0AhxJbW7x437T+6yuHZYvxMgZgJehZ3nUw+Uec04DNb3cq3HfKalAE1zF
 Cv+eY8QhZUGEaLywfgJLwichOWpxo/k3WqISXkkR5yEg1rzL5APA6tWK3RV0jvWDDpRPRYo5k
 IUWppY+wXz/czfWWRJhKwqMSDEkDowl2jpq84Z1Eh3ZuSJVflD37bQtUyqXs2LwrH99XN4m4z
 Gpcx1G/SJ5e3z2ijSt9Fco/GTgV8keoZRkVMbiKBVbEVzNoIyKxqo+ODrwqqeKrEGYCeWvgRS
 1H3xRs9nGA35jLBYIFjV+RZlUar/dQfYAFi7aKhNeL1fh0LArwwD+JrDaB1L7xS0K8YaNYdp6
 S3Jw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 11:39 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> This series (based on v5.13-rc1) converts all architectures to
> ARCH_ATOMIC. This will allow the use of instrumented atomics on all
> architectures (e.g. for KASAN and similar), and simplifies the core
> atomic code (which should allow for easier rework of the fallbacks and
> other bits in future).
>
> The series is split into three parts:
>
> 1) Some preparatory work is done to prepare architectures and common
>    code for the conversion. In this phase h8300 and microblaze are
>    converted to use the asm-generic atomics exclusively, and the
>    asm-generic implementations are made to function with or without
>    ARCH_ATOMIC.
>
> 2) Architectures are converted one-by-one to use the ARCH_ATOMIC
>    interface. I've converted each architecture with its own patch (even
>    where the conversion is trivial) to make review and bisection easier.
>
> 3) The code handling !ARCH_ATOMIC is removed.
>
> Note: I've generated the patches with:
>
>   git format-patch -C -M -D
>
> ... so the preimage of include/linux/atomic-fallback.h is not included
> in the diff when it is deleted.
>
> The series can also be found in my atomics/arch-atomic branch on
> kernel.org:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=atomics/arch-atomic
>   git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git atomics/arch-atomic

Nice work!

I had recently tried experimented with cleanups around cmpxchg(),
adding fixed-length
versions of that which can be used to implement the atomics with less bloated
preprocessor output. My patches will clearly conflict with your
series, but it seems
that we should do yours first in any case.

I'm happy to put this into the asm-generic tree once you have
collected enough Acks.

       Arnd
