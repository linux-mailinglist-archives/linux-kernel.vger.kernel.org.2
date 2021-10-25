Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC87B4397E4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 15:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbhJYNyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 09:54:45 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:50827 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbhJYNyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 09:54:44 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N0Fh1-1mqjoo05Rv-00xLJp for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021
 15:52:21 +0200
Received: by mail-wm1-f52.google.com with SMTP id 62-20020a1c0241000000b0032ca21cffeeso57283wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 06:52:20 -0700 (PDT)
X-Gm-Message-State: AOAM531GXwx3zEWKPUenSZPlmkp78w5aNvN/wTX1di4YQo4PUXGfRTIe
        UEb+f9hWnDSBRgnPA1p/lRKxpxpudGzC+cJU3/w=
X-Google-Smtp-Source: ABdhPJwaJcrBtY86i4D1V1CSBhdIvIQ/LWqjMQ+YyJEpQqkqpHYlJV6F/5yQIfqqPp89amPjp1QHtVPQrejznaCMJGY=
X-Received: by 2002:a1c:4489:: with SMTP id r131mr19352496wma.1.1635169940730;
 Mon, 25 Oct 2021 06:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190307091514.2489338-1-arnd@arndb.de> <X9S28TcEXd2zghzp@elver.google.com>
 <87czzeg5ep.fsf@nanos.tec.linutronix.de> <YPnPp9grFPTFrn4c@archlinux-ax161>
In-Reply-To: <YPnPp9grFPTFrn4c@archlinux-ax161>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Oct 2021 15:52:04 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Nxn2feQnqi9xxGjLBYgHR1VVrPhpurmSVZ4tmcu6kSQ@mail.gmail.com>
Message-ID: <CAK8P3a0Nxn2feQnqi9xxGjLBYgHR1VVrPhpurmSVZ4tmcu6kSQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] futex: mark futex_detect_cmpxchg() as 'noinline'
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:7am2OXC8HNsqYqEibiS6ppIZZteO3PY7ZF3hLzedeSpdQpg/KQu
 9pw8YMfYkmLUbStL83NJfTrCBGY8RxeJT1J7HNprTeiTa422q9DPdAgDuVgafMq6/S2pnKw
 4KZrqx7MhTISPUGPMPMRgTJyagnObDs2bsSuJynNtshNGAiaZm6xoMPn0kmaxA/3l0XyiDv
 uc/GzvZMR5LoW9YjLCAlQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wCzXCWRfAtI=:PEFcvB/QwB4hYKxlIzCsd6
 hTfnxvYDTZXqepCPBx69Q+b1Lh+NWbKKvSCwv/ClaI7vbtjLZ50BfFToYZZmPphr6cBFMsSjq
 Efsl/SOmUJ8rnqvkc6KpLqVLmJVjZLZfYk3eCMiBk/v08eouu+kL0pDFDrqr+Ly1C9hGr6ArM
 i6K128LJg5jh7wvExzh7a6KmCny7VbRceaaZgOqhyqJ4CKIys6kNBSF81Th9VfsyMPm1TuhwE
 9gpEzRwW88I8I5M7c6dqVe+OujhYORYusLSYh3Y/+gTNq5giLbf6K9ZRaEGtduoDlBQMfykPe
 95usH9/78wMW1wK4r8IruAInHQOhZ1ZUUi2fKaWaKtwVefQwtMg3fJTUyanBxhnhGiR1lBWkR
 DTMGnRUazp3LFHAKXQelpVorTtK1SmSvoPnbCLWRpEjLA6Af6ryHtOemLA1Qrn/vOzQe3QY7I
 N1uW5VurX8kQkAwCboHPBRDODcZlrcBJ8CcPv1a9duASDJZbWYx3tGiTjHzfSgeRf1kxLa025
 NYZqvKWpU70akCfVBEwrw7jk6m7ksPbS1hf39oGjdC5gkX3ahtLHE/ugfXBVLGxTLR0AD5uEP
 Sbo6L6jxgDwTJ63wdkbmUnEFYOPehXvtM4X4o5JAlFON3MsEjKPqoRZFaatiYJQ/1ETotoyuc
 xpIpaJZo6Pnp7yZ7ZfLsAoT5G5RkYdH5f0Z+ZKhrccnELiDyNvgGO2Jet8ii9AOjOadU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 10:05 PM Nathan Chancellor <nathan@kernel.org> wrote:
> On Sat, Dec 12, 2020 at 09:01:34PM +0100, Thomas Gleixner wrote:
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -86,6 +86,7 @@ config ARM
> >       select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> >       select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL && !CC_IS_CLANG
> >       select HAVE_FUNCTION_TRACER if !XIP_KERNEL
> > +     select HAVE_FUTEX_CMPXCHG if FUTEX
> >       select HAVE_GCC_PLUGINS
> >       select HAVE_HW_BREAKPOINT if PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)
> >       select HAVE_IDE if PCI || ISA || PCMCIA
>
> Did this ever get sent along as a formal patch? I just ran into another
> issue that seems to be similar to the one Arnd sent the initial patch in
> this thread for and it is resolved by this change.

Nick sent this patch in September, and Russell applied it as commit
9d417cbe36ee ("ARM: 9122/1: select HAVE_FUTEX_CMPXCHG").
This addresses the problem for arm, but I think we should really
just remove HAVE_FUTEX_CMPXCHG entirely and require it to
be there for SMP.

I have a patch for that, but that needs a separate fix for sparc32,
which I think nobody is interested in working on. I can post it anyway
to get discussion moving again.

         Arnd
