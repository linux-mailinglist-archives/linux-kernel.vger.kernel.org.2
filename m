Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C06845F710
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 00:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245123AbhKZXJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 18:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245686AbhKZXHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 18:07:45 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB3AC06175D
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 15:04:31 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id n26so10219536pff.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 15:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LClu/KYX8cLFX8iQdJDB097EW8fz40JeuiYE2gewzEw=;
        b=N8xbNnVBNyysDlmBVVlBesjXa7jnIPShLFXHCh3WoMWRcy21dsQu3TCUymadKecx6K
         AXVS7nv4lQEt7tj8BRTbxtUQVox+K+V5mSekXu5bwWUv7CkfCW9q8EiQE0yeLOmJsplu
         zdb3+xubV5ungpV3wo9fZpz1HFuG42Q1Omy/Co0QFLHogHTGSnyOSb0jiqQdfbm0hjIX
         Wd37uMf62aAtYb+ErgFF1x9gqCzs9tioJEtj+KoFjkbeXdzAshRhZNf9m/lvKo6RuUnh
         /tcFriy1VZnojoftH9H+rAW7ckL4CZ9RooJ3VIi9yaJketwDLreYXNqhK7MXNTjFu4+S
         j2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LClu/KYX8cLFX8iQdJDB097EW8fz40JeuiYE2gewzEw=;
        b=wmb8sTJe2wHchcETFpf3Z9/sB7uylcXnJJd6y0oEhvUxkKpWubWLVvk5sgq7IDPnK/
         gepuwsxHbP7AXDRhLcOLJq8+TwzYBi/7m9dH8UEv0MTEA5LReQSn3xIpOsW5+LJgxlHe
         ykLb8lMi6eW9V/f5n+Y8U53f3grrwj1ypnf7T1d+9SHECeczsjeWdghL4JvGaju1uJA5
         vfkSngIWVvasVmB/DmeKrn+46R3hGo5ObtU7K19PAUxiJK2mkkKnm5KXGinNANsIeJqr
         eCiLIrgs6JBHNeihwni4Scv2MNEWyM/3TUgibTnUD+pT9lVO82BaPYhgfcDdyejvd1rS
         qSZg==
X-Gm-Message-State: AOAM530l3n4qG7tDC4l9b6Wrwa5+Nk7w/spKb/Gbf3tZ1cpSp+OTXL1l
        BXGC7YdPOcFw8JMEGTcK819KQteMErorapdvtzs=
X-Google-Smtp-Source: ABdhPJw7x/2Qjs5PAI1vg+vDVsHjvbm7F/kONVPcI7oLyzn+rBYu8SQbd4XDzYD4BNFUSpxqfcJxNPdQ9arUnB2iZL4=
X-Received: by 2002:a62:8c55:0:b0:49f:df22:c4ca with SMTP id
 m82-20020a628c55000000b0049fdf22c4camr24206236pfd.11.1637967871512; Fri, 26
 Nov 2021 15:04:31 -0800 (PST)
MIME-Version: 1.0
References: <CANn89i+hQTn26hK-4CA=cAwCxEMzogqD30PYdqz4NP8kjmH2gg@mail.gmail.com>
 <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com>
 <619eee05.1c69fb81.4b686.4bbc@mx.google.com> <CANn89iJdQ1VTLYUKu1hYNm4wF__ZzrwNYr28v_vGM0MCybJpxg@mail.gmail.com>
 <CAFUsyf+5zp+p_0TPFLr-fMNry0M_CnNAFDG30PKDuy2jA5MhNw@mail.gmail.com>
 <CANn89iLtZmSyBYtvJ0nxdrM3CKyf3D9y9AWBC4GVbPCxtjOROw@mail.gmail.com>
 <4dbf7f8d095b46a8a45e285d0ec8f8b0@AcuMS.aculab.com> <CANn89iJubuJxjVp4fx78-bjKBN3e9JsdAwZxj4XO6g2_7ZPqJQ@mail.gmail.com>
 <8a6fe34e0f2f4739af39a5935a74b823@AcuMS.aculab.com>
In-Reply-To: <8a6fe34e0f2f4739af39a5935a74b823@AcuMS.aculab.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Fri, 26 Nov 2021 17:04:20 -0600
Message-ID: <CAFUsyfJmpFFzuMhHrH+oBVzcHggW0QZM9dvXtPQW88kAw_2_BQ@mail.gmail.com>
Subject: Re: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
To:     David Laight <David.Laight@aculab.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "alexanderduyck@fb.com" <alexanderduyck@fb.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 4:41 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Eric Dumazet
> > Sent: 26 November 2021 18:10
> ...
> > > AFAICT (from a pdf) bswap32() and ror(x, 8) are likely to be
> > > the same speed but may use different execution units.
>
> The 64bit shifts/rotates are also only one clock.
> It is the bswap64 that can be two.
>
> > > Intel seem so have managed to slow down ror(x, %cl) to 3 clocks
> > > in sandy bridge - and still not fixed it.
> > > Although the compiler might be making a pigs-breakfast of the
> > > register allocation when you tried setting 'odd = 8'.
> > >
> > > Weeks can be spent fiddling with this code :-(
> >
> > Yes, and in the end, it won't be able to compete with  a
> > specialized/inlined ipv6_csum_partial()
>
> I bet most of the gain comes from knowing there is a non-zero
> whole number of 32bit words.
> The pesky edge conditions cost.
>
> And even then you need to get it right!
> The one for summing the 5-word IPv4 header is actually horrid
> on Intel cpu prior to Haswell because 'adc' has a latency of 2.
> On Sandy bridge the carry output is valid on the next clock,
> so adding to alternate registers doubles throughput.
> (That could easily be done in the current function and will
> make a big different on those cpu.)
>
> But basically the current generic code has the loop unrolled
> further than is necessary for modern (non-atom) cpu.
> That just adds more code outside the loop.
>
> I did managed to get 12 bytes/clock using adco/adox with only
> 32 bytes each iteration.
> That will require aligned buffers.
>
> Alignment won't matter for 'adc' loops because there are two
> 'memory read' units - but there is the elephant:
>
> Sandy bridge Cache bank conflicts
> Each consecutive 128 bytes, or two cache lines, in the data cache is divided
> into 8 banks of 16 bytes each. It is not possible to do two memory reads in
> the same clock cycle if the two memory addresses have the same bank number,
> i.e. if bit 4 - 6 in the two addresses are the same.
>         ; Example 9.5. Sandy bridge cache bank conflict
>         mov eax, [rsi] ; Use bank 0, assuming rsi is divisible by 40H
>         mov ebx, [rsi+100H] ; Use bank 0. Cache bank conflict
>         mov ecx, [rsi+110H] ; Use bank 1. No cache bank conflict
>
> That isn't a problem on Haswell, but it is probably worth ordering
> the 'adc' in the loop to reduce the number of conflicts.
> I didn't try to look for that though.
> I only remember testing aligned buffers on Sandy/Ivy bridge.
> Adding to alternate registers helped no end.

Cant that just be solved by having the two independent adcx/adox chains work
from region that are 16+ bytes apart? For 40 byte ipv6 header it will be simple.
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
