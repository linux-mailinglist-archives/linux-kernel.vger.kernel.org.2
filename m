Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C219C4609EC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 22:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358356AbhK1VFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 16:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237186AbhK1VDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 16:03:02 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B99C061756
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 12:59:45 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b11so10388793pld.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 12:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PF7JllFcyeGRUi7owsbg+8vGGeO0cpWlm5Ptr7fCVfc=;
        b=AY23yjMIbgBl3u/Zravz24Uv05a6REq/Jui8qzKR8tGr6Ww44YHAO4w+a5Fth1iUNb
         ByKbglA/OMqa6KwoqOL0wVdjENMVqV5NsH/bkUXC8CSI3/Ppc5vpM640sgobcoXKRbw6
         WMIs5EvmvsWi7/MVcU1BIMD+GWwsb/JAaejjP1IFkBLYA93A/9MYEmyQN2Sfw6ZIXnhF
         OmlPVUXiwlLnCQYhLGVdlaPHYTadHlx3iXrpFvuxUG0WLpryaLTUopNm8fcw7EZG/Tst
         Z2bHOWBRytYcvlH3O+YcTamoqS8h3j4ljpHg3IqCdbBbwYFcZ3c6zOIC0mGzPJlEKkB8
         Wnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PF7JllFcyeGRUi7owsbg+8vGGeO0cpWlm5Ptr7fCVfc=;
        b=u63tExW4lXBkUEgHG4l9zzjyC/OibC4aAKw4zoUCjjXNkxuDR6/+ZLCHRFVh3ZNEj8
         1QHg1lz4nrT08BYEde9GWZTP25LjGKxwrKl5C/C/6esGrKO+xYD1RB+YAXlstjbgXUe2
         4FgJ7jGbB3rrrDvTeghYstTfPkm70ekQ9vmmokHmyxKnr1sHL1lITNZujiOaR/ssz7N3
         qO7FZugWlaM9KjVFpKCM40ehMyZyLrVlHCtiPXGFJ4Gqq1SC147dVdjRFHtrwXKZoh69
         H85jtwuBaee0BxW8YAHyEP99QgJTCl97liggw9TdZGsWTgvmjriAzZn0sdGAfx8IiUPD
         idoQ==
X-Gm-Message-State: AOAM5326oEc0o2bM2WKeqIN4zQ0PnhwH3vkkl1wxcNAnrn4PxKE5yqyp
        Ua261qTBOFqzGxDT/77OsZCP3cTxldpg5VyrO5Y=
X-Google-Smtp-Source: ABdhPJxs+JUVv4n+Qp0u575NljJPIE/UP5Z6iatw5daPetpZaIB/dshOFYYPnY9ohEzqwH+mzqvF9VTOFbQNQ4FGgbg=
X-Received: by 2002:a17:902:ab14:b0:143:77d8:2558 with SMTP id
 ik20-20020a170902ab1400b0014377d82558mr54822843plb.54.1638133185235; Sun, 28
 Nov 2021 12:59:45 -0800 (PST)
MIME-Version: 1.0
References: <20211125193852.3617-1-goldstein.w.n@gmail.com>
 <CANn89iLnH5B11CtzZ14nMFP7b--7aOfnQqgmsER+NYNzvnVurQ@mail.gmail.com>
 <CAFUsyfK-znRWJN7FTMdJaDTd45DgtBQ9ckKGyh8qYqn0eFMMFA@mail.gmail.com>
 <CAFUsyfLKqonuKAh4k2qdBa24H1wQtR5FkAmmtXQGBpyizi6xvQ@mail.gmail.com>
 <CAFUsyfJ619Jx_BS515Se0V_zRdypOg3_2YzbKUk5zDBNaixhaQ@mail.gmail.com> <8e4961ae0cf04a5ca4dffdec7da2e57b@AcuMS.aculab.com>
In-Reply-To: <8e4961ae0cf04a5ca4dffdec7da2e57b@AcuMS.aculab.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Sun, 28 Nov 2021 14:59:33 -0600
Message-ID: <CAFUsyfLoEckBrnYKUgqWC7AJPTBDfarjBOgBvtK7eGVZj9muYQ@mail.gmail.com>
Subject: Re: [PATCH v1] x86/lib: Optimize 8x loop and memory clobbers in csum_partial.c
To:     David Laight <David.Laight@aculab.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "alexanderduyck@fb.com" <alexanderduyck@fb.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2021 at 1:47 PM David Laight <David.Laight@aculab.com> wrote:
>
> ...
> > Regarding the 32 byte case, adding two accumulators helps with the latency
> > numbers but causes a regression in throughput for the 40/48 byte cases. Which
> > is the more important metric for the usage of csum_partial()?
> >
> > Here are the numbers for the smaller sizes:
> >
> > size, lat old,    lat ver2,    lat ver1,    tput old,   tput ver2,   tput ver1
> >    0,   4.961,       4.503,       4.901,       4.887,       4.399,       4.951
> >    8,   5.590,       5.594,       5.620,       4.227,       4.110,       4.252
> >   16,   6.182,       6.398,       6.202,       4.233,       4.062,       4.278
> >   24,   7.392,       7.591,       7.380,       4.256,       4.246,       4.279
> >   32,   7.371,       6.366,       7.390,       4.550,       4.900,       4.537
> >   40,   8.621,       7.496,       8.601,       4.862,       5.162,       4.836
> >   48,   9.406,       8.128,       9.374,       5.206,       5.736,       5.234
> >   56,  10.535,       9.189,      10.522,       5.416,       5.772,       5.447
> >   64,  10.000,       7.487,       7.590,       6.946,       6.975,       6.989
> >   72,  11.192,       8.639,       8.763,       7.210,       7.311,       7.277
> >   80,  11.734,       9.179,       9.409,       7.605,       7.620,       7.548
> >   88,  12.933,      10.545,      10.584,       7.878,       7.902,       7.858
> >   96,  12.952,       9.331,      10.625,       8.168,       8.470,       8.206
> >  104,  14.206,      10.424,      11.839,       8.491,       8.785,       8.502
> >  112,  14.763,      11.403,      12.416,       8.798,       9.134,       8.771
> >  120,  15.955,      12.635,      13.651,       9.175,       9.494,       9.130
> >  128,  15.271,      10.599,      10.724,       9.726,       9.672,       9.655
> >
> > 'ver2' uses two accumulators for 32 byte case and has better latency numbers
> > but regressions in tput compared to 'old' and 'ver1'. 'ver1' is the
> > implementation
> > posted which has essentially the same numbers for tput/lat as 'old'
> > for sizes [0, 63].
>
> Which cpu are you testing on - it will make a big difference ?

Tigerlake, although assuming `adc` as the bottleneck, the results
should be largely independent.

> And what are you measing throughput in?

Running back to back iterations with the same input without any
dependency between iterations. The OoO window will include
multiple iterations at once.

> And are you testing aligned or mis-aligned 64bit reads?

Aligned as that is the common case.

>
> I think one of the performance counters will give 'cpu clocks'.

Time is in Ref Cycles using `rdtsc`
>
> I did some tests early last year and got 8 bytes/clock on broadwell/haswell
> with code that 'loop carried' the carry flag (a single adc chain).
> On the older Intel cpu (Ivy bridge onwards) 'adc' has a latency of 2
> for the result, but the carry flag is available earlier.
> So alternating the target register in the 'adc' chain will give (nearly)
> 8 bytes/clock - I think I got to 7.5.
>
> That can all be done with only 4 reads per interaction.
> IIRC broadwell/haswell only need 2 reads/iteration.
>
> It is actually likely (certainly worth checking) that haswell/broadwell
> can do two misaligned memory reads every clock.
> So it may not be worth aligning the reads (which the old code did).
> In any case aren't tx packets likely to be aligned, and rx ones
> misaligned to some known 4n+2 boundary?
>
> Using adxc/adxo together is a right PITA.

I'm a bit hesitant about adxc/adxo because they are extensions so
support will need to be tested.

> I did get (about) 12 bytes/clock fo long buffers while loop carrying
> both the overflow and carry flags.
>
> Also is there a copy of the patched code anywhere?

https://lore.kernel.org/lkml/CANn89iLpFOok_tv=DKsLX1mxZGdHQgATdW4Xs0rc6oaXQEa5Ng@mail.gmail.com/T/


> I think I've missed some of the patches and they are difficult to follow.
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
