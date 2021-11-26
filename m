Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC70245E670
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 04:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245633AbhKZDPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 22:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbhKZDNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 22:13:39 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4CDC08EA6B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 18:38:41 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id g28so6807471pgg.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 18:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=24BSv7Rf5v7fnWBjErfcI1hmwF4Vny6Ot9NlgzAmMBw=;
        b=H0ofM762Fwc3K0KA938QEJsnNbiw9rj+Soj0Dzvm89BvlFSmczLflrianyK7b63Mqk
         bK4TSRUrY7x0i5DDJA3bfwW6HzJMx7lr04gWkm+D/cfFaNL16bjVhtvnplEmjxxmMwsH
         WTxc/i9gn9ZNxB6Nnlz1S3+79x4qRp2/URuqggcpvVaQ8q+nivbqMlJB64LUA01+/gcF
         B6QVhEQqLg55u+3e/1GXUdaMmfHffhVXapwrPrWcoyukkA6QusiBZD29F9qeqULUFWyZ
         F/wziYwvVIHT2n0C2PxDrnUSLT9IgLbLunNhRhSdwj5QugcbRY8mcW8V2plwbVLNxNto
         YWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=24BSv7Rf5v7fnWBjErfcI1hmwF4Vny6Ot9NlgzAmMBw=;
        b=TuMhKtcJQ7EJqyBuNpPaRp+VRmLJd/L/7fehncTisVAIft8dBcP+QBfeJqnxgmUMDN
         /PAvYwhSiJOSZlHo7rLoErHO4wWwyIubc1ZleoBgvG7uoq+fq799Z2YVe+BAvTsqwxw+
         6mNjpCcUsBIPegcPs6bDvzzMaH9YXh4znTMCFFS1a9rDhe9eJvMlk8sssHJsT2eYf9OC
         HVXpDAPbjIl0PfzoSYBs4oxyx08EPT5xq51TgKhZz5hpmo65iB8YWwzYkDqQgSme7bLz
         Y4miT2Lb8A4WOBVsD9rrkf4qpeUsuldlvdwvQ/MmV3UDimudYvCvooZkCOEoyEL1Ck+8
         2j7A==
X-Gm-Message-State: AOAM531gOn2ygiFIqeutuG6qAqJfPGv9JVAPAfqUiQGOybCS4WKvA27j
        dYz0aAlruWWfk2O9mnVzDkxIm3n8Q6OpPPPrmis=
X-Google-Smtp-Source: ABdhPJx7XMW4UG1usMJtfH0L2JxWlTzICUzQiaymzp609gS4vbjigkxexNrRHPBDfjOxk8NdqLz7eVAIpKu9QIYd32k=
X-Received: by 2002:a63:31ce:: with SMTP id x197mr16674000pgx.14.1637894321353;
 Thu, 25 Nov 2021 18:38:41 -0800 (PST)
MIME-Version: 1.0
References: <20211125193852.3617-1-goldstein.w.n@gmail.com>
 <CANn89iLnH5B11CtzZ14nMFP7b--7aOfnQqgmsER+NYNzvnVurQ@mail.gmail.com>
 <CAFUsyfK-znRWJN7FTMdJaDTd45DgtBQ9ckKGyh8qYqn0eFMMFA@mail.gmail.com> <CAFUsyfLKqonuKAh4k2qdBa24H1wQtR5FkAmmtXQGBpyizi6xvQ@mail.gmail.com>
In-Reply-To: <CAFUsyfLKqonuKAh4k2qdBa24H1wQtR5FkAmmtXQGBpyizi6xvQ@mail.gmail.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Thu, 25 Nov 2021 20:38:30 -0600
Message-ID: <CAFUsyfJ619Jx_BS515Se0V_zRdypOg3_2YzbKUk5zDBNaixhaQ@mail.gmail.com>
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

On Thu, Nov 25, 2021 at 8:18 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
>
> On Thu, Nov 25, 2021 at 8:15 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
> >
> > On Thu, Nov 25, 2021 at 7:50 PM Eric Dumazet <edumazet@google.com> wrote:
> > >
> > > On Thu, Nov 25, 2021 at 11:38 AM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
> > > >
> > > > Modify the 8x loop to that it uses two independent
> > > > accumulators. Despite adding more instructions the latency and
> > > > throughput of the loop is improved because the `adc` chains can now
> > > > take advantage of multiple execution units.
> > >
> > > Nice !
> > >
> > > Note that I get better results if I do a different split, because the
> > > second chain gets shorter.
> > >
> > > First chain adds 5*8 bytes from the buffer, but first bytes are a mere
> > > load, so that is really 4+1 additions.
> > >
> > > Second chain adds 3*8 bytes from the buffer, plus the result coming
> > > from the first chain, also 4+1 additions.
> >
> > Good call. With that approach I also see an improvement for the 32 byte
> > case (which is on the hot path) so this change might actually matter :)
> >
> > >
> > > asm("movq 0*8(%[src]),%[res_tmp]\n\t"
> > >     "addq 1*8(%[src]),%[res_tmp]\n\t"
> > >     "adcq 2*8(%[src]),%[res_tmp]\n\t"
> > >     "adcq 3*8(%[src]),%[res_tmp]\n\t"
> > >     "adcq 4*8(%[src]),%[res_tmp]\n\t"
> > >     "adcq $0,%[res_tmp]\n\t"
> > >     "addq 5*8(%[src]),%[res]\n\t"
> > >     "adcq 6*8(%[src]),%[res]\n\t"
> > >     "adcq 7*8(%[src]),%[res]\n\t"
> > >     "adcq %[res_tmp],%[res]\n\t"
> > >     "adcq $0,%[res]"
> > >     : [res] "+r" (temp64), [res_tmp] "=&r"(temp_accum)
> > >     : [src] "r" (buff)
> > >     : "memory");
> > >
> > >
> > > >
> > > > Make the memory clobbers more precise. 'buff' is read only and we know
> > > > the exact usage range. There is no reason to write-clobber all memory.
> > >
> > > Not sure if that matters in this function ? Or do we expect it being inlined ?
> >
> > It may matter for LTO build. I also think it can matter for the loop
> > case. I didn't see
> > any difference when playing around with the function in userland with:
> >
> > ```
> > gcc -O3 -march=native -mtune=native checksum.c -o checksum
> > ```
> >
> > but IIRC if the clobber is loops with inline assembly payloads can be
> > de-optimized if GCC can't prove the iterations don't affect each other.
> >
> >
> > >
> > > Personally, I find the "memory" constraint to be more readable than these casts
> > > "m"(*(const char(*)[64])buff));
> > >
> >
> > Hmm, I personally find it more readable if I can tell what memory
> > transforms happen
> > just from reading the clobbers, but you're the maintainer.
> >
> > Do you want it changed in V2?
> >
> > > >
> > > > Relative performance changes on Tigerlake:
> > > >
> > > > Time Unit: Ref Cycles
> > > > Size Unit: Bytes
> > > >
> > > > size,   lat old,    lat new,    tput old,   tput new
> > > >    0,     4.972,      5.054,       4.864,      4.870
> > >
> > > Really what matters in modern networking is the case for 40 bytes, and
> > > eventually 8 bytes.
> > >
> > > Can you add these two cases in this nice table ?

Regarding the 32 byte case, adding two accumulators helps with the latency
numbers but causes a regression in throughput for the 40/48 byte cases. Which
is the more important metric for the usage of csum_partial()?

Here are the numbers for the smaller sizes:

size, lat old,    lat ver2,    lat ver1,    tput old,   tput ver2,   tput ver1
   0,   4.961,       4.503,       4.901,       4.887,       4.399,       4.951
   8,   5.590,       5.594,       5.620,       4.227,       4.110,       4.252
  16,   6.182,       6.398,       6.202,       4.233,       4.062,       4.278
  24,   7.392,       7.591,       7.380,       4.256,       4.246,       4.279
  32,   7.371,       6.366,       7.390,       4.550,       4.900,       4.537
  40,   8.621,       7.496,       8.601,       4.862,       5.162,       4.836
  48,   9.406,       8.128,       9.374,       5.206,       5.736,       5.234
  56,  10.535,       9.189,      10.522,       5.416,       5.772,       5.447
  64,  10.000,       7.487,       7.590,       6.946,       6.975,       6.989
  72,  11.192,       8.639,       8.763,       7.210,       7.311,       7.277
  80,  11.734,       9.179,       9.409,       7.605,       7.620,       7.548
  88,  12.933,      10.545,      10.584,       7.878,       7.902,       7.858
  96,  12.952,       9.331,      10.625,       8.168,       8.470,       8.206
 104,  14.206,      10.424,      11.839,       8.491,       8.785,       8.502
 112,  14.763,      11.403,      12.416,       8.798,       9.134,       8.771
 120,  15.955,      12.635,      13.651,       9.175,       9.494,       9.130
 128,  15.271,      10.599,      10.724,       9.726,       9.672,       9.655

'ver2' uses two accumulators for 32 byte case and has better latency numbers
but regressions in tput compared to 'old' and 'ver1'. 'ver1' is the
implementation
posted which has essentially the same numbers for tput/lat as 'old'
for sizes [0, 63].


> > >
> >
> > Sure, with your suggestion in the 32 byte cases there is an improvement there
> > too.
> >
> > > We hardly have to checksum anything with NIC that are not decades old.
> > >
> > > Apparently making the 64byte loop slightly longer incentives  gcc to
> > > move it away (our intent with the unlikely() hint).
>
> Do you think the 40/48 byte case might be better of in GAS assembly. It's
> a bit difficult to get proper control flow optimization with GCC +
> inline assembly
> even with likely/unlikely (i.e expanding the 64 byte case moves it off hotpath,
> cmov + ror instead of fallthrough for hotpath).
> > >
> > > Anyway I am thinking of providing a specialized inline version for
> > > IPv6 header checksums (40 + x*8 bytes, x being 0  pretty much all the
> > > time),
> > > so we will likely not use csum_partial() anymore.
> >
> > I see. For now is it worth adding a case for 40 in this implementation?
> >
> >     if(likely(len == 40)) {
> >         // optimized 40 + buff aligned case
> >     }
> >     else {
> >         // existing code
> >     }
> >
> >
> > >
> > > Thanks !
