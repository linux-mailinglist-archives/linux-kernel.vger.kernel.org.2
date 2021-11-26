Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C95D45F557
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 20:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbhKZTqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 14:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239711AbhKZToB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 14:44:01 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33200C0619E6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 11:21:48 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id c4so20674877wrd.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 11:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8nVNUR+3p/gnWY1XLO42iNk5LNWflOD5rmaXoMlYh38=;
        b=ctS/NxLBu+VrbpCp9QXMGMb/hqkSAAC1cuxwSxVAZIfZDC/YLiCGkL9jkcgJv6GcrW
         so3V2rGOYRxO7aTtr4Ln1eDi1g3bxHitMF0AUbfj8bLCiw5AIpGQ5oIkgV6S98Qn34OB
         He8JNN9JcgEAzM5liQj6c70Ye79pbipZ/Ct83mM6m+fxkCxLEvWfQ+7WNmRRiy/xz8zE
         eiI06KvRQCq1gOzG2s8oxaI5iKDIv6iThUcvMouFxqgP6+2bFHDaMrl1biNz0ENuXR8n
         01qMfdh9x780BdNsPS/KuJsJL20zMVHDJ/epDmVMCRcRGkitversqgvmOiGh0YXfSp61
         fYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8nVNUR+3p/gnWY1XLO42iNk5LNWflOD5rmaXoMlYh38=;
        b=y5BKGSDHjiNxS6gw8jpLbhoHfWO8Yq9alhO36d7HcYQOboJIqVQ6JxaAZSV2RwAq0h
         4SjL07C+JMR4SG4mBvSb2wNV6mBhdX8cvNDjeFPmkRvBW/fEp5+IC4ezS//tUSzP0ddn
         zHBA+EvXv5ftVab0tooyYoTCZEDw5qq57fos9vyOfDG/RYB8obokW7r0/Vs+xDVcUfig
         rApl2S1XfzBFCrZ9HiYOVBUHNXgk6EzGGfFyVL44DvN/YhP5r+cnG4qZtgfRGNWG2lJQ
         c8C4BwJ9PqLR8GNEFDH3aeJFhcaFyCNnLjzV2eOigAdF0YN7cGNVhbkFBgFDGmQJGy1p
         y9lw==
X-Gm-Message-State: AOAM531ANlc3sTmDktstityVZMaPohluRmaYU5sXy1XsdAnOgmubLj3I
        +ZCGdLTYEAGjGH6MN+uXOWjWNBP8tI6v1NA3WDBC1Q==
X-Google-Smtp-Source: ABdhPJwyCE4gize9e+DvxQJBq7TZCKBhAEc5Z+7ME7Sw+7sMPk64p5EvI8IAOXmvlFknilTeAPKX8a71//tXJrgcKa0=
X-Received: by 2002:adf:fb86:: with SMTP id a6mr16052623wrr.35.1637954506497;
 Fri, 26 Nov 2021 11:21:46 -0800 (PST)
MIME-Version: 1.0
References: <20211125193852.3617-1-goldstein.w.n@gmail.com>
 <CANn89iLnH5B11CtzZ14nMFP7b--7aOfnQqgmsER+NYNzvnVurQ@mail.gmail.com>
 <CAFUsyfK-znRWJN7FTMdJaDTd45DgtBQ9ckKGyh8qYqn0eFMMFA@mail.gmail.com>
 <CANn89iJA1JOevgLSK019VYXKkLJsMjV-u9ZHvrgZ+XUypRWwfQ@mail.gmail.com>
 <CAFUsyfLeVGW8etXHuSGvYy_RoS3RGaA1L+NLKnpc7EsSMVORBg@mail.gmail.com>
 <CANn89iJxMhGfp364rPu6p_ZLrKnM1qWF_NWrw4_oL_KG+piByg@mail.gmail.com>
 <CAFUsyfJ33cKFQdUagHQ_b4N80CfBtGQZhyA4CN_JLgEmXEX=DA@mail.gmail.com> <CAFUsyf+TuU2Xe5Guy5yiFWsV-JZSjUJxcGZv=f0BYDSmODV+_w@mail.gmail.com>
In-Reply-To: <CAFUsyf+TuU2Xe5Guy5yiFWsV-JZSjUJxcGZv=f0BYDSmODV+_w@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 26 Nov 2021 11:21:34 -0800
Message-ID: <CANn89iLjw7YeWNGNtVNi690adJfoSVwgLScrtx-zSyh=COZRsQ@mail.gmail.com>
Subject: Re: [PATCH v1] x86/lib: Optimize 8x loop and memory clobbers in csum_partial.c
To:     Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com,
        Borislav Petkov <bp@alien8.de>, dave.hansen@linux.intel.com,
        X86 ML <x86@kernel.org>, hpa@zytor.com, peterz@infradead.org,
        alexanderduyck@fb.com, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 11:14 AM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
>
> On Fri, Nov 26, 2021 at 12:50 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
> >
> > On Fri, Nov 26, 2021 at 12:27 PM Eric Dumazet <edumazet@google.com> wrote:
> > >
> > > On Fri, Nov 26, 2021 at 10:17 AM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
> > > >
> > >
> > > >
> > > > Makes sense. Although if you inline I think you definitely will want a more
> > > > conservative clobber than just "memory". Also I think with 40 you also will
> > > > get some value from two counters.
> > > >
> > > > Did you see the number/question I posted about two accumulators for 32
> > > > byte case?
> > > > Its a judgement call about latency vs throughput that I don't really have an
> > > > answer for.
> > > >
> > >
> > > The thing I do not know is if using more units would slow down the
> > > hyper thread ?
>
> Did some quick tests with the latency/throughput benchmarks running
> in parallel on two hyperthreads on the same processors. The 32 byte case
> latency advantage goes with 2 accum and there is still a slight regression
> in throughput. The larger cases that hit the loop still still have improvements
> both in tput and latency with 2 accum.

Great. I also played with rorx instruction, because it removes one
"adcl $0,..." step

__wsum ipv6_csum_partial(const void *buff, int len, __wsum sum)
{
u64 temp64;
u64 tmp;
u32 res32;

if (unlikely(len != 40))
return csum_partial(buff, len, sum);

temp64 = (__force u64)sum;
asm("addq 0*8(%[src]),%[temp64]\n\t"
    "adcq 1*8(%[src]),%[temp64]\n\t"
    "adcq 2*8(%[src]),%[temp64]\n\t"
    "adcq 3*8(%[src]),%[temp64]\n\t"
    "adcq 4*8(%[src]),%[temp64]\n\t"
    "mov  %k[temp64],%[res32]\n\t"
    "rorx $32,%[temp64],%[temp64]\n\t"
    "adcl %k[temp64],%[res32]\n\t"
    "adcl $0,%[res32]"
    : [temp64] "+r" (temp64), [res32] "=r" (res32)
    : [src] "r" (buff)
    : "memory");
return (__force __wsum)res32;
}
