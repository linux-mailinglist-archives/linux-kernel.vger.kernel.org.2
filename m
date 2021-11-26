Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413DF45F4B3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 19:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242162AbhKZSiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 13:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242915AbhKZSgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 13:36:02 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9DEC07E5F1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 10:09:59 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id o13so20285226wrs.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 10:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CQ9+nHVpn42LTQNYEUfzDXxUAO4mDA7nE1poNU8n5pk=;
        b=VXbEyndq3QA5CiwDaOxcrVWv8Bd3mvKOV8eEMYHNRZWZMngnflMrS7c4+QQBkmqMCd
         srAF3TmjukMygyr1hpgGfxApWTmguPTYms42e0Pn8wn7pp418xGCm2YOhd8tvDOorYPY
         osysKGqD5/fVz+5Me9/cs9F71kip83RZf6pZiBCGI1C5W5Tp48PwAiT60BrR8IvH74VL
         OWVTY77cYKJFqZmezKrGluZcrQoGaadVFQMLxruxt0m2fvrjieVAtm9q7tNN+1uL0Mwd
         /+WgWxatQQoXvmP9l9VYx99b38ISH0qw8T2gKdrd10Gfr94utAlae3lEaeD/5La7eqvi
         dBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CQ9+nHVpn42LTQNYEUfzDXxUAO4mDA7nE1poNU8n5pk=;
        b=ouZmMcr986XRQPGRAn48qrVPm+v2nbfbUrTCOW1A0kK+7h9dtoQlXK3H9tS1KHew8/
         +zBkvytoxUU+du44Bb5Iu9eeYdvr1Y52UjY8Kb7VxgGICF6mmLAuUSA1saxkEb/9bKVe
         PMi5AXToyFwB0flbOQFLn8LMC5yeZSC0C8CRNjkJbNMPCvlBLCBdQy1ANmdqTk7MyqFt
         r7nQ1WAFyYsM5LYYXotMVFbz69KnpMawVb+dH+kSLJRYaOFL2bvAlxYPg0Bpb4Pg6vcd
         zaXEC5nv1G6Lb1VYfNsmKnGYL48ogVFRzLctUfTyR7EH3wf+GnJZB18/ofHV+74bSTTp
         zMaA==
X-Gm-Message-State: AOAM532NU/cfqu6blBPVX6TBnqVltkTjNvKmI4Ei2cjrt8KqtLQ25Ky7
        WBeT/ve1TlnmHGd2r8DoCaMLbYlROH1nn6YbyC/Uuw==
X-Google-Smtp-Source: ABdhPJzJaVcGjzkyR8mea8rfrcMRyTpXieZOeweIM64D7iCWuDB8bgIjy/mG/y/J0b+po17sM44CO+aPtvZ3QKAXL4Q=
X-Received: by 2002:adf:9b95:: with SMTP id d21mr15624863wrc.527.1637950197504;
 Fri, 26 Nov 2021 10:09:57 -0800 (PST)
MIME-Version: 1.0
References: <CANn89i+hQTn26hK-4CA=cAwCxEMzogqD30PYdqz4NP8kjmH2gg@mail.gmail.com>
 <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com>
 <619eee05.1c69fb81.4b686.4bbc@mx.google.com> <CANn89iJdQ1VTLYUKu1hYNm4wF__ZzrwNYr28v_vGM0MCybJpxg@mail.gmail.com>
 <CAFUsyf+5zp+p_0TPFLr-fMNry0M_CnNAFDG30PKDuy2jA5MhNw@mail.gmail.com>
 <CANn89iLtZmSyBYtvJ0nxdrM3CKyf3D9y9AWBC4GVbPCxtjOROw@mail.gmail.com> <4dbf7f8d095b46a8a45e285d0ec8f8b0@AcuMS.aculab.com>
In-Reply-To: <4dbf7f8d095b46a8a45e285d0ec8f8b0@AcuMS.aculab.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 26 Nov 2021 10:09:45 -0800
Message-ID: <CANn89iJubuJxjVp4fx78-bjKBN3e9JsdAwZxj4XO6g2_7ZPqJQ@mail.gmail.com>
Subject: Re: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
To:     David Laight <David.Laight@aculab.com>
Cc:     Noah Goldstein <goldstein.w.n@gmail.com>,
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

On Fri, Nov 26, 2021 at 9:18 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Eric Dumazet
> > Sent: 25 November 2021 04:01
> ...
> > > The outputs seem to match if `buff` is aligned to 64-bit. Still see
> > > difference with `csum_fold(csum_partial())` if `buff` is not 64-bit aligned.
> > >
> > > The comment at the top says it's "best" to have `buff` 64-bit aligned but
> > > the code logic seems meant to support the misaligned case so not
> > > sure if it's an issue.
> > >
> >
> > It is an issue in general, not in standard cases because network
> > headers are aligned.
> >
> > I think it came when I folded csum_partial() and do_csum(), I forgot
> > to ror() the seed.
> >
> > I suspect the following would help:
> >
> > diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
> > index 1eb8f2d11f7c785be624eba315fe9ca7989fd56d..ee7b0e7a6055bcbef42d22f7e1d8f52ddbd6be6d
> > 100644
> > --- a/arch/x86/lib/csum-partial_64.c
> > +++ b/arch/x86/lib/csum-partial_64.c
> > @@ -41,6 +41,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
> >         if (unlikely(odd)) {
> >                 if (unlikely(len == 0))
> >                         return sum;
> > +               temp64 = ror32((__force u64)sum, 8);
> >                 temp64 += (*(unsigned char *)buff << 8);
> >                 len--;
> >                 buff++;
>
> You can save an instruction (as if this path matters) by:
>                         temp64 = sum + *(unsigned char *)buff;

This might overflow, sum is 32bit.

Given that we have temp64 = (__force u64)sum;  already done at this
point, we can instead

temp64 += *(u8 *)buff;

>                         temp64 <<= 8;



> Although that probably falls foul of 64bit shifts being slow.

Are they slower than the ror32(sum, 8) ?

> So maybe just:
>                         sum += *(unsigned char *)buff;

we might miss a carry/overflow here

>                         temp64 = bswap32(sum);


> AFAICT (from a pdf) bswap32() and ror(x, 8) are likely to be
> the same speed but may use different execution units.
>
> Intel seem so have managed to slow down ror(x, %cl) to 3 clocks
> in sandy bridge - and still not fixed it.
> Although the compiler might be making a pigs-breakfast of the
> register allocation when you tried setting 'odd = 8'.
>
> Weeks can be spent fiddling with this code :-(

Yes, and in the end, it won't be able to compete with  a
specialized/inlined ipv6_csum_partial()
