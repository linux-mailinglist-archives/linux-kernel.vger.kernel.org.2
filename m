Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452FC45F18E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 17:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378490AbhKZQTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 11:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378573AbhKZQRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 11:17:47 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F9EC061375
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 08:09:08 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v11so19630987wrw.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 08:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fVqgPbdCqAbEzlvjWpziuPsXc61al7DEzYKdit7Y154=;
        b=sVA2tnjtUqKnjDu6BtbTqkPUBrVyzauZRqoeKXakeJl+IwqwFbkEhDV2ACvkcEgAfw
         RByWGI40NjgfQmek38KBRHgenVARk26KytHTsQnk03kHWlP2Q1zM0enlqc6LYA7Ep6Ou
         XUc/8Kv67N4N5AWsM+uEQVXpn8WFfuF7lFYGiIodIzNAEgbeHBu0JddmK/aSmNOHzOXp
         m6CxJYEhAeboYIxHQszFqDZCJMqERMCWQnbg/ol7yw7Bv4ouKW2yR2QT36cfMxaSUoP2
         CbMWyI7c/7ehHSMe8j0Wmk1hn9ktUdYtt+FdXdf9RhKCra3UuS0+mreFTDloN5ma0Yu7
         yXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fVqgPbdCqAbEzlvjWpziuPsXc61al7DEzYKdit7Y154=;
        b=jDuKRMpbFRalnFt9pegrdq3PPeA5deUpumF21+b98mS694tVMlpLfHo4h1KX7zEjhw
         Ue62WkoPYojy9rbmZuJCxCQ1/e0PM1cUmgm7zFbdP3o4YV4EzFNORSVM1WQe9rJDZPlU
         kdpAdqiqVKGSk8sY+SRQG6hK/otEXZsZdltK60zgzGwZ8vyINPMcG8Gj5hRgywp2saFd
         AYTkc+lu4hq9yhMWYqAltFUT4Q3fe8jQdgY/oY+ASL6r5yIzepaFxCUOn2/eHjrDcaW4
         xeUieoK6/VRuS3F+DGTbPMqCShvaZfJtrfhkQ+m05cBvx3mY6OgygKyQqxC1SuAGd6Wa
         QX+g==
X-Gm-Message-State: AOAM531MIEqRWkgRJELTWmhWBBwitoWjQqYIeJGU5JlaxOfMlKPYw9Ej
        mMpZPKjC57OOPleMHdyVDCt6DBuzY936rBCX4LL9GQ==
X-Google-Smtp-Source: ABdhPJwfJUPMg7qTDP12kMtPVN8I/A2NxXikbTCEJIgmLf8ht+GaZoMKE6vxGtyDj/joo+1XzAZ3NQxmtmET5ImLldk=
X-Received: by 2002:adf:ef4f:: with SMTP id c15mr15503342wrp.226.1637942946482;
 Fri, 26 Nov 2021 08:09:06 -0800 (PST)
MIME-Version: 1.0
References: <20211125193852.3617-1-goldstein.w.n@gmail.com>
 <CANn89iLnH5B11CtzZ14nMFP7b--7aOfnQqgmsER+NYNzvnVurQ@mail.gmail.com> <CAFUsyfK-znRWJN7FTMdJaDTd45DgtBQ9ckKGyh8qYqn0eFMMFA@mail.gmail.com>
In-Reply-To: <CAFUsyfK-znRWJN7FTMdJaDTd45DgtBQ9ckKGyh8qYqn0eFMMFA@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 26 Nov 2021 08:08:54 -0800
Message-ID: <CANn89iJA1JOevgLSK019VYXKkLJsMjV-u9ZHvrgZ+XUypRWwfQ@mail.gmail.com>
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

On Thu, Nov 25, 2021 at 6:15 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
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

I am not x86 maintainer at all, I was only giving an opinion.

>
> Do you want it changed in V2?

Let's hear from x86 maintainers :)

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

This is what I had first in my tree to demonstrate what gains could be achieved.

But decided to keep csum_partial() as a generic function, yet optimize it a bit.

My plan is to have a new inline helper, that could be a mere
csum_partial() on arches that do not have
an optimized version.

Preliminary patch to show the idea (this only compiles on x86, we have
to add the generic definition)
First call point is in GRO stack.
Note some of us in the US are not working until next Monday.

diff --git a/arch/x86/include/asm/checksum_64.h
b/arch/x86/include/asm/checksum_64.h
index 407beebadaf45a748f91a36b78bd1d023449b132..af93fb53b480ab7102db71c32ab6ca9604c6b5fb
100644
--- a/arch/x86/include/asm/checksum_64.h
+++ b/arch/x86/include/asm/checksum_64.h
@@ -182,4 +182,26 @@ static inline __wsum csum_add(__wsum csum, __wsum addend)
                                                (__force unsigned)addend);
 }

+static inline __wsum ipv6_csum_partial(const void *buff, int len, __wsum sum)
+{
+       u64 temp64;
+
+       if (unlikely(len == 40))
+               return csum_partial(buff, len, sum);
+
+       temp64 = (__force u64)sum;
+       asm("addq 0*8(%[src]),%[res]\n\t"
+           "adcq 1*8(%[src]),%[res]\n\t"
+           "adcq 2*8(%[src]),%[res]\n\t"
+           "adcq 3*8(%[src]),%[res]\n\t"
+           "adcq 4*8(%[src]),%[res]\n\t"
+           "adcq 5*8(%[src]),%[res]\n\t"
+           "adcq $0,%[res]"
+           : [res] "+r" (temp64)
+           : [src] "r" (buff)
+           : "memory");
+       return (__force __wsum)add32_with_carry(temp64 >> 32, temp64);
+}
+#define ipv6_csum_partial ipv6_csum_partial
+
 #endif /* _ASM_X86_CHECKSUM_64_H */
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 1b9827ff8ccf48e61e233e39d671aa67c8fff0ab..50d1d0c92bdce37ac2f48ded8edec02e1ba9096d
100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -274,7 +274,9 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff
*ipv6_gro_receive(struct list_head *head,
        NAPI_GRO_CB(skb)->is_atomic = true;
        NAPI_GRO_CB(skb)->flush |= flush;

-       skb_gro_postpull_rcsum(skb, iph, nlen);
+       if (NAPI_GRO_CB(skb)->csum_valid)
+               NAPI_GRO_CB(skb)->csum = ~ipv6_csum_partial(iph, nlen,
+                                               ~NAPI_GRO_CB(skb)->csum);

        pp = indirect_call_gro_receive_l4(tcp6_gro_receive, udp6_gro_receive,
                                         ops->callbacks.gro_receive, head, skb);
