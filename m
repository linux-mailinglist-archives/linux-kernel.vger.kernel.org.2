Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96FF45F5A6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 21:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239711AbhKZUKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 15:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbhKZUIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 15:08:53 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B376C0613A5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 11:50:43 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b13so7330089plg.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 11:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ihpr76Fg4RsQkX74L0fK9BDVcRtYb65VFs1JnQjauaA=;
        b=qXrMVfCHSvJUKxicgrjfE/aIEqCQ6cXRqQt9TL0Yeh/l5GWpNk3eh/NGUCXgBVHCdd
         wQag7sYx48Dny4EF6WPk7RjVzFFeQFp1yT4cQ5bjaCDPjAssiG+ci+V7td1RTFp9wWJz
         AzFjRACqLGnEGj/yOJmz76r4ImVcK7LQld4A+8mG57zXcGcGYzAmKrP0jc0rnyo1Bfz7
         +80QKMyjS78nguOlO8R4UWoLyeggSiBd/+cUXNWf/wPjIS+g47oRbTvRSiegrpYtTdiK
         nBoJTvz5bIu1wDn/HH23/YqLhjRphjgbGUHeyTsZhDEmjdAlslApvAUF0/3wtZRW95br
         Wy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ihpr76Fg4RsQkX74L0fK9BDVcRtYb65VFs1JnQjauaA=;
        b=3AFVmrUpkgozkx8ktVWLCt5Qza8fCbS245QBrmO7oG1v4HWcq88vEwrA4YZzJwOLJ9
         tFsUsYwP2F64jSs8ex2+7C0XkRc8dU9lJfh4xn5y3Pig62WJuuQRFNfE8qIe7ZL9N0Sl
         WmeGt6P2QTJlhVTNEdFa8hUoO31pzc5fuaKvbdvl20xUF7g0nDFK/qAvWBSqCMaatJuO
         KnQYUao0wQpScEkDtl0gqMZSg7lc+azs8nP/uafW6ifBNInympIfvemFeieJs53/oDPR
         0GzgrGHspTMXbV/zrJLq4Tqpc80yburNwzqyF84IO8E+7oPX+KTnpnXM0wm3LI7xztU0
         95EA==
X-Gm-Message-State: AOAM530BYIl94QrzVD6ePakqNFrKe8Qb23//nwPuTDwF/6lH1i7cZqvo
        YkpM1zuX1mELONddJ3Pxz4whFWhOVDky3u40doE=
X-Google-Smtp-Source: ABdhPJxmFkm9zvSEXxuQh+XoY8XDrMiX2hb7jb09gyOQQnkTnbAxoQjjpqZWP1YioQX8qCiNQKJLMghiQjGozGOzFQA=
X-Received: by 2002:a17:90a:bf0b:: with SMTP id c11mr17654729pjs.208.1637956243171;
 Fri, 26 Nov 2021 11:50:43 -0800 (PST)
MIME-Version: 1.0
References: <20211125193852.3617-1-goldstein.w.n@gmail.com>
 <CANn89iLnH5B11CtzZ14nMFP7b--7aOfnQqgmsER+NYNzvnVurQ@mail.gmail.com>
 <CAFUsyfK-znRWJN7FTMdJaDTd45DgtBQ9ckKGyh8qYqn0eFMMFA@mail.gmail.com>
 <CANn89iJA1JOevgLSK019VYXKkLJsMjV-u9ZHvrgZ+XUypRWwfQ@mail.gmail.com>
 <CAFUsyfLeVGW8etXHuSGvYy_RoS3RGaA1L+NLKnpc7EsSMVORBg@mail.gmail.com>
 <CANn89iJxMhGfp364rPu6p_ZLrKnM1qWF_NWrw4_oL_KG+piByg@mail.gmail.com>
 <CAFUsyfJ33cKFQdUagHQ_b4N80CfBtGQZhyA4CN_JLgEmXEX=DA@mail.gmail.com>
 <CAFUsyf+TuU2Xe5Guy5yiFWsV-JZSjUJxcGZv=f0BYDSmODV+_w@mail.gmail.com> <CANn89iLjw7YeWNGNtVNi690adJfoSVwgLScrtx-zSyh=COZRsQ@mail.gmail.com>
In-Reply-To: <CANn89iLjw7YeWNGNtVNi690adJfoSVwgLScrtx-zSyh=COZRsQ@mail.gmail.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Fri, 26 Nov 2021 13:50:32 -0600
Message-ID: <CAFUsyfK5r+P6aQLBpYZoi0FSgvLwfawBUYTHtQL0TJRozujp3g@mail.gmail.com>
Subject: Re: [PATCH v1] x86/lib: Optimize 8x loop and memory clobbers in csum_partial.c
To:     Eric Dumazet <edumazet@google.com>
Cc:     tglx@linutronix.de, mingo@redhat.com,
        Borislav Petkov <bp@alien8.de>, dave.hansen@linux.intel.com,
        X86 ML <x86@kernel.org>, hpa@zytor.com, peterz@infradead.org,
        alexanderduyck@fb.com, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 1:21 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Fri, Nov 26, 2021 at 11:14 AM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
> >
> > On Fri, Nov 26, 2021 at 12:50 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
> > >
> > > On Fri, Nov 26, 2021 at 12:27 PM Eric Dumazet <edumazet@google.com> wrote:
> > > >
> > > > On Fri, Nov 26, 2021 at 10:17 AM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
> > > > >
> > > >
> > > > >
> > > > > Makes sense. Although if you inline I think you definitely will want a more
> > > > > conservative clobber than just "memory". Also I think with 40 you also will
> > > > > get some value from two counters.
> > > > >
> > > > > Did you see the number/question I posted about two accumulators for 32
> > > > > byte case?
> > > > > Its a judgement call about latency vs throughput that I don't really have an
> > > > > answer for.
> > > > >
> > > >
> > > > The thing I do not know is if using more units would slow down the
> > > > hyper thread ?
> >
> > Did some quick tests with the latency/throughput benchmarks running
> > in parallel on two hyperthreads on the same processors. The 32 byte case
> > latency advantage goes with 2 accum and there is still a slight regression
> > in throughput. The larger cases that hit the loop still still have improvements
> > both in tput and latency with 2 accum.
>
> Great. I also played with rorx instruction, because it removes one
> "adcl $0,..." step

Bright :) but it will need a BMI support check.

>
> __wsum ipv6_csum_partial(const void *buff, int len, __wsum sum)
> {
> u64 temp64;
> u64 tmp;
> u32 res32;
>
> if (unlikely(len != 40))
> return csum_partial(buff, len, sum);
>
> temp64 = (__force u64)sum;
> asm("addq 0*8(%[src]),%[temp64]\n\t"
>     "adcq 1*8(%[src]),%[temp64]\n\t"
>     "adcq 2*8(%[src]),%[temp64]\n\t"
>     "adcq 3*8(%[src]),%[temp64]\n\t"
>     "adcq 4*8(%[src]),%[temp64]\n\t"
>     "mov  %k[temp64],%[res32]\n\t"
>     "rorx $32,%[temp64],%[temp64]\n\t"
>     "adcl %k[temp64],%[res32]\n\t"
>     "adcl $0,%[res32]"
>     : [temp64] "+r" (temp64), [res32] "=r" (res32)
>     : [src] "r" (buff)
>     : "memory");
> return (__force __wsum)res32;
> }

I actually get better performance in hyperthread benchmarks with 2 accum:

Used:

        u64 res;
        temp64 = (__force uint64_t)sum;
        asm("movq 0*8(%[src]),%[res]\n\t"
            "addq 1*8(%[src]),%[res]\n\t"
            "adcq 2*8(%[src]),%[res]\n\t"
            "adcq   $0, %[res]\n"
            "addq 3*8(%[src]),%[temp64]\n\t"
            "adcq 4*8(%[src]),%[temp64]\n\t"
            "adcq   %[res], %[temp64]\n\t"
            "mov  %k[temp64],%k[res]\n\t"
            "rorx $32,%[temp64],%[temp64]\n\t"
            "adcl %k[temp64],%k[res]\n\t"
            "adcl $0,%k[res]"
            : [temp64] "+r"(temp64), [res] "=&r"(res)
            : [src] "r"(buff)
            : "memory");
        return (__force __wsum)res;

w/ hyperthread:
size,    2acc lat,    1acc lat,   2acc tput,   1acc tput
  40,       6.511,       7.863,       6.177,       6.157

w/o hyperthread:
size,    2acc lat,    1acc lat,   2acc tput,   1acc tput
  40,       5.577,       6.764,       3.150,       3.210
