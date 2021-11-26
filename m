Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5946645E44B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 03:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242839AbhKZCUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 21:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243945AbhKZCS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 21:18:29 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C079BC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 18:15:16 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id i12so7446453pfd.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 18:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=peTQQ3OyRRX7Ti+eou8CYY+ChAKf/7l+zSaI8RTBkU4=;
        b=TCfLWTeNdqjCCZfUv3XMLWXbhEgQ4kfyBGkp6SCVEqxFmCSNv7yAqRL16UwW/RlndT
         PwkF1l2rnwG0sKGqqwZcIqml4RSmGteX3aiIWIj7Htavq9AARQYltoq4Kt6E26H3Pv7C
         Lh54j0V905EYtLLhrh75ED9RSuNneKghqUmd1YYAVM/QFdhQ/C6fWgbm+gi0ciJWjyiD
         t2u0bg3BRybe01cIrAbdrfC0vizcs2nfVJxXkPsXnkT7tVX9jM9nGK+VRR+ZPuGpUh4L
         Nv1hJcV3MWZ0Mj1CY+81SgCIP9Biva+gkAYcu9JjntGt6BTtVAJ4AV0gZIOMjnjBH7j1
         oj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=peTQQ3OyRRX7Ti+eou8CYY+ChAKf/7l+zSaI8RTBkU4=;
        b=AN5XWTYawVO4CGTbrOqru1hRKHdePEfzVBFqzLuDI2uD1d5epItySrDS2UErzGJTPG
         jrEnkimglLfZcpiOZnv2uUavc2tKOykOw1egF+5z1+SUf5Y/1BySAvS/aThEtJhQuQ19
         LSxZ+q/6B05MBjV+af10CJK8Xx+WWI2+X8JVsy5/bj9hLOsDBtDCEC9+84s03wQUcHoS
         2YrEIBDXH5Tc54U2l2KwOCN+W30RpCm18/yvmIYouihfaMDuJGJfIwiv9OJ0FcaqfvMF
         cJqGJlh/xIUKbdnzm5zpaPVNfBBO5m1F3LNUjHZ3dzKsJ+jvLJL6JQw8eDQKARw4Ift9
         tDzw==
X-Gm-Message-State: AOAM530K5dM9mGPQV/HijGd8DZ21anEhGgYxgGH0ioDIDSdM1UCbezWG
        ExPu4TcZxlilDmAxXt1tSeUPImgsQcHl1Vpinoc=
X-Google-Smtp-Source: ABdhPJz6auhAy++81PiQ9rm3fDOI9Odyn2NMBJoYQzF258LBC9952zbGkGurvxtiuiwehbLhOmuh4PCN6ozwjIUs1yE=
X-Received: by 2002:a05:6a00:1a8d:b0:49f:de63:d9c0 with SMTP id
 e13-20020a056a001a8d00b0049fde63d9c0mr17812618pfv.79.1637892915037; Thu, 25
 Nov 2021 18:15:15 -0800 (PST)
MIME-Version: 1.0
References: <20211125193852.3617-1-goldstein.w.n@gmail.com> <CANn89iLnH5B11CtzZ14nMFP7b--7aOfnQqgmsER+NYNzvnVurQ@mail.gmail.com>
In-Reply-To: <CANn89iLnH5B11CtzZ14nMFP7b--7aOfnQqgmsER+NYNzvnVurQ@mail.gmail.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Thu, 25 Nov 2021 20:15:04 -0600
Message-ID: <CAFUsyfK-znRWJN7FTMdJaDTd45DgtBQ9ckKGyh8qYqn0eFMMFA@mail.gmail.com>
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

On Thu, Nov 25, 2021 at 7:50 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Thu, Nov 25, 2021 at 11:38 AM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
> >
> > Modify the 8x loop to that it uses two independent
> > accumulators. Despite adding more instructions the latency and
> > throughput of the loop is improved because the `adc` chains can now
> > take advantage of multiple execution units.
>
> Nice !
>
> Note that I get better results if I do a different split, because the
> second chain gets shorter.
>
> First chain adds 5*8 bytes from the buffer, but first bytes are a mere
> load, so that is really 4+1 additions.
>
> Second chain adds 3*8 bytes from the buffer, plus the result coming
> from the first chain, also 4+1 additions.

Good call. With that approach I also see an improvement for the 32 byte
case (which is on the hot path) so this change might actually matter :)

>
> asm("movq 0*8(%[src]),%[res_tmp]\n\t"
>     "addq 1*8(%[src]),%[res_tmp]\n\t"
>     "adcq 2*8(%[src]),%[res_tmp]\n\t"
>     "adcq 3*8(%[src]),%[res_tmp]\n\t"
>     "adcq 4*8(%[src]),%[res_tmp]\n\t"
>     "adcq $0,%[res_tmp]\n\t"
>     "addq 5*8(%[src]),%[res]\n\t"
>     "adcq 6*8(%[src]),%[res]\n\t"
>     "adcq 7*8(%[src]),%[res]\n\t"
>     "adcq %[res_tmp],%[res]\n\t"
>     "adcq $0,%[res]"
>     : [res] "+r" (temp64), [res_tmp] "=&r"(temp_accum)
>     : [src] "r" (buff)
>     : "memory");
>
>
> >
> > Make the memory clobbers more precise. 'buff' is read only and we know
> > the exact usage range. There is no reason to write-clobber all memory.
>
> Not sure if that matters in this function ? Or do we expect it being inlined ?

It may matter for LTO build. I also think it can matter for the loop
case. I didn't see
any difference when playing around with the function in userland with:

```
gcc -O3 -march=native -mtune=native checksum.c -o checksum
```

but IIRC if the clobber is loops with inline assembly payloads can be
de-optimized if GCC can't prove the iterations don't affect each other.


>
> Personally, I find the "memory" constraint to be more readable than these casts
> "m"(*(const char(*)[64])buff));
>

Hmm, I personally find it more readable if I can tell what memory
transforms happen
just from reading the clobbers, but you're the maintainer.

Do you want it changed in V2?

> >
> > Relative performance changes on Tigerlake:
> >
> > Time Unit: Ref Cycles
> > Size Unit: Bytes
> >
> > size,   lat old,    lat new,    tput old,   tput new
> >    0,     4.972,      5.054,       4.864,      4.870
>
> Really what matters in modern networking is the case for 40 bytes, and
> eventually 8 bytes.
>
> Can you add these two cases in this nice table ?
>

Sure, with your suggestion in the 32 byte cases there is an improvement there
too.

> We hardly have to checksum anything with NIC that are not decades old.
>
> Apparently making the 64byte loop slightly longer incentives  gcc to
> move it away (our intent with the unlikely() hint).
>
> Anyway I am thinking of providing a specialized inline version for
> IPv6 header checksums (40 + x*8 bytes, x being 0  pretty much all the
> time),
> so we will likely not use csum_partial() anymore.

I see. For now is it worth adding a case for 40 in this implementation?

    if(likely(len == 40)) {
        // optimized 40 + buff aligned case
    }
    else {
        // existing code
    }


>
> Thanks !
