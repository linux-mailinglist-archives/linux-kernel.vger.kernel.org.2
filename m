Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B32C45E45D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 03:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357645AbhKZCYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 21:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243836AbhKZCWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 21:22:40 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BD0C06175E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 18:19:00 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id b13so5717379plg.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 18:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bM6Fsy903VGJv2jAMfpfXYHtBI784i695Cw2d2teF3E=;
        b=e8xG/DFaA2GH2poFwsbLQk0wCUsz7UDPd7xomkVjV448uNiKE/EfdBSnXvQOVNokwl
         mJoTxDfGuseAOgqjTliOwXLN4EfTfIrcJ5Lxj7SV9J4Hjr/jwwsdQfmCvlCO2w4W5UcC
         tgKulVv0IJqsT1o2q/Zf9/wXY+f4/lSkeHp9mxW6Upf/CfHpI843nEa9LDxsUhjrTaXj
         n3ixHILEGem5dUiX57B4VWUs5m+jQxSfwwEkXPsdarHXossAuwy0/Ayu2xl8PGvu4MRa
         8XlfNW880vcnIffzXH7KvwMSdguYvpVbj6sFi/gANaNic//rUSBChAaR51R24BD5QKBj
         GBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bM6Fsy903VGJv2jAMfpfXYHtBI784i695Cw2d2teF3E=;
        b=Fui4IxhSj5uNieTKpbOT/Qlbv3nokEIXUjAVoBIM6OxP+ne09VRV96UYYzUboqvwvo
         Na3rklRbx+en0a8lmxDTBZia/zCvNtNRUztE74SiFRM2YKQr2RCnTU/z0man7BQyFJfU
         9pi1/cBIqw8g5HShbnNUDFEhXQaKr3C9El/Dkhoko5Bni5jX7qARRROZNt+Ab7ARBhru
         axkuLTbNIWsib2O8fMEMCkvi+o/3Otak+P2F60Khy3Z1zE3uehyigAQTgjM85t/R3yn8
         GUku01/XAw/BuKaHqzM7eD0UVx7JFDYlVjrJjTIeZyVtDhb6JpdXoPw7vF4RNVXLnuwA
         1wdg==
X-Gm-Message-State: AOAM530Lx26WwCjtBFXXm9YBdLEzNcAP+iR8HzkJDmVIFYguNncWQWhH
        7IQVQSSVtETUqEKYcBc7ziZE37ucMSt5lpB0QUE=
X-Google-Smtp-Source: ABdhPJx4dPZ8mx012CRXXtmmqXjq+RU7Kf4jVTZO6ayM6WX3pY+ErgHai+24a0OdkMcaTIzeUfgICx2bePPNGwsFxo4=
X-Received: by 2002:a17:902:ab14:b0:143:77d8:2558 with SMTP id
 ik20-20020a170902ab1400b0014377d82558mr34926759plb.54.1637893140374; Thu, 25
 Nov 2021 18:19:00 -0800 (PST)
MIME-Version: 1.0
References: <20211125193852.3617-1-goldstein.w.n@gmail.com>
 <CANn89iLnH5B11CtzZ14nMFP7b--7aOfnQqgmsER+NYNzvnVurQ@mail.gmail.com> <CAFUsyfK-znRWJN7FTMdJaDTd45DgtBQ9ckKGyh8qYqn0eFMMFA@mail.gmail.com>
In-Reply-To: <CAFUsyfK-znRWJN7FTMdJaDTd45DgtBQ9ckKGyh8qYqn0eFMMFA@mail.gmail.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Thu, 25 Nov 2021 20:18:49 -0600
Message-ID: <CAFUsyfLKqonuKAh4k2qdBa24H1wQtR5FkAmmtXQGBpyizi6xvQ@mail.gmail.com>
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

On Thu, Nov 25, 2021 at 8:15 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
>
> On Thu, Nov 25, 2021 at 7:50 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Thu, Nov 25, 2021 at 11:38 AM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
> > >
> > > Modify the 8x loop to that it uses two independent
> > > accumulators. Despite adding more instructions the latency and
> > > throughput of the loop is improved because the `adc` chains can now
> > > take advantage of multiple execution units.
> >
> > Nice !
> >
> > Note that I get better results if I do a different split, because the
> > second chain gets shorter.
> >
> > First chain adds 5*8 bytes from the buffer, but first bytes are a mere
> > load, so that is really 4+1 additions.
> >
> > Second chain adds 3*8 bytes from the buffer, plus the result coming
> > from the first chain, also 4+1 additions.
>
> Good call. With that approach I also see an improvement for the 32 byte
> case (which is on the hot path) so this change might actually matter :)
>
> >
> > asm("movq 0*8(%[src]),%[res_tmp]\n\t"
> >     "addq 1*8(%[src]),%[res_tmp]\n\t"
> >     "adcq 2*8(%[src]),%[res_tmp]\n\t"
> >     "adcq 3*8(%[src]),%[res_tmp]\n\t"
> >     "adcq 4*8(%[src]),%[res_tmp]\n\t"
> >     "adcq $0,%[res_tmp]\n\t"
> >     "addq 5*8(%[src]),%[res]\n\t"
> >     "adcq 6*8(%[src]),%[res]\n\t"
> >     "adcq 7*8(%[src]),%[res]\n\t"
> >     "adcq %[res_tmp],%[res]\n\t"
> >     "adcq $0,%[res]"
> >     : [res] "+r" (temp64), [res_tmp] "=&r"(temp_accum)
> >     : [src] "r" (buff)
> >     : "memory");
> >
> >
> > >
> > > Make the memory clobbers more precise. 'buff' is read only and we know
> > > the exact usage range. There is no reason to write-clobber all memory.
> >
> > Not sure if that matters in this function ? Or do we expect it being inlined ?
>
> It may matter for LTO build. I also think it can matter for the loop
> case. I didn't see
> any difference when playing around with the function in userland with:
>
> ```
> gcc -O3 -march=native -mtune=native checksum.c -o checksum
> ```
>
> but IIRC if the clobber is loops with inline assembly payloads can be
> de-optimized if GCC can't prove the iterations don't affect each other.
>
>
> >
> > Personally, I find the "memory" constraint to be more readable than these casts
> > "m"(*(const char(*)[64])buff));
> >
>
> Hmm, I personally find it more readable if I can tell what memory
> transforms happen
> just from reading the clobbers, but you're the maintainer.
>
> Do you want it changed in V2?
>
> > >
> > > Relative performance changes on Tigerlake:
> > >
> > > Time Unit: Ref Cycles
> > > Size Unit: Bytes
> > >
> > > size,   lat old,    lat new,    tput old,   tput new
> > >    0,     4.972,      5.054,       4.864,      4.870
> >
> > Really what matters in modern networking is the case for 40 bytes, and
> > eventually 8 bytes.
> >
> > Can you add these two cases in this nice table ?
> >
>
> Sure, with your suggestion in the 32 byte cases there is an improvement there
> too.
>
> > We hardly have to checksum anything with NIC that are not decades old.
> >
> > Apparently making the 64byte loop slightly longer incentives  gcc to
> > move it away (our intent with the unlikely() hint).

Do you think the 40/48 byte case might be better of in GAS assembly. It's
a bit difficult to get proper control flow optimization with GCC +
inline assembly
even with likely/unlikely (i.e expanding the 64 byte case moves it off hotpath,
cmov + ror instead of fallthrough for hotpath).
> >
> > Anyway I am thinking of providing a specialized inline version for
> > IPv6 header checksums (40 + x*8 bytes, x being 0  pretty much all the
> > time),
> > so we will likely not use csum_partial() anymore.
>
> I see. For now is it worth adding a case for 40 in this implementation?
>
>     if(likely(len == 40)) {
>         // optimized 40 + buff aligned case
>     }
>     else {
>         // existing code
>     }
>
>
> >
> > Thanks !
