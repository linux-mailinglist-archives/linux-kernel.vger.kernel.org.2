Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43CC4579F7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 01:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbhKTAJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 19:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbhKTAJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 19:09:10 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE18C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 16:06:07 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so12114452pju.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 16:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mm+pwIGTsIA/L/SI5G1FVoHQZMrXeKirNp4laTxkLeI=;
        b=Lzd9MHOwtyZOMdIITqDVD7cE3GRlUwJiYm6aX47GwqWG67bWcFU670mHID2XNwavLp
         k2JjsqOmSscTjwUScH51GTUmRTcpo119xcc+DLL5f31nTswbzdTNGgzFB3yOJVYL8B0V
         QYaylyCkpDcJmNHPwGL4ONtPqmm2gsPkA4VH/ULtMdImZsIFMmbn4BVuRbCvGWE6+NKT
         ybqJWdDfOCGuhr8ozJS5fgX2hSPuVRutwGm7zet6MMGxTCyQv3/8Wa3xairD1JdgNZ58
         n1G4VdguXumzKSbrW4QnMZ3kVy1dSw8230HKUgn4qIimvlrqrBcz6OriNfbtOs4X1e7R
         5XEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mm+pwIGTsIA/L/SI5G1FVoHQZMrXeKirNp4laTxkLeI=;
        b=gASKzHI7WdYHsBY5JcIQZUQDDzQ17Xx4yAXzsf2Ji/Y8KKjQqgQxr5GMrTU5GuTFoX
         1LDHgNWE2TVSE9zM/vLyb1KIuedQE9Eo3cq/H9oos8q4rfH0JkgrJRE8VWoNoLcqAlnb
         n9rUWcQs2otuwoVmnP4aNXDE6c3sBBbulWLKSDsSu2mhVaV73Aon8mo3ezVpi0THu4rN
         DqLs9JpyrQ67xb1Sc2mGvvmJLvL6qQ0HQb6NWlMrKjo37a5F55gBdd9MWdXUVXbAEN9I
         C/bNORuQ9cJH0UN7uwzvY9tu+YKgxslbBVLugtms3gjAd78d2c/3jM3uQUem+PncFp2d
         ks/Q==
X-Gm-Message-State: AOAM533lUA2rVdL7liSx/RC4nDCVjMiV3DT4j6TZ1IZcAmy0y3grXiku
        gCkSGlIDhaD/9IKQiXNJGD3BCRcBG5HJKgcKRqA=
X-Google-Smtp-Source: ABdhPJyed2nWBCc+r8Ucmq8Vlz9U08Z/MMDsLK/5/A2dWoa3my0nlj9p6G5lZoLTn+c3aPNoAMVymLBstCv6y7Cabr8=
X-Received: by 2002:a17:902:6905:b0:142:9e19:702e with SMTP id
 j5-20020a170902690500b001429e19702emr83613583plk.34.1637366767455; Fri, 19
 Nov 2021 16:06:07 -0800 (PST)
MIME-Version: 1.0
References: <20211101044955.2295495-1-goldstein.w.n@gmail.com>
 <20211117210245.843374-1-goldstein.w.n@gmail.com> <bc0297a1b97a4b129fa3ea1b155f6062@AcuMS.aculab.com>
 <CAFUsyfJTuFjVXHMgYi0uggVNW=1WW1uVYa7avVjW5VBb2cmAkQ@mail.gmail.com> <e41913010e61429bbd2980a5c5ccfb39@AcuMS.aculab.com>
In-Reply-To: <e41913010e61429bbd2980a5c5ccfb39@AcuMS.aculab.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Fri, 19 Nov 2021 18:05:56 -0600
Message-ID: <CAFUsyfLUQLj5py1AQ+4NptM6htWxV5i0qxkeXDUdFPfAnqRY2w@mail.gmail.com>
Subject: Re: [PATCH v4] arch/x86: Improve 'rep movs{b|q}' usage in memmove_64.S
To:     David Laight <David.Laight@aculab.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 4:31 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Noah Goldstein
> > Sent: 17 November 2021 22:45
> >
> > On Wed, Nov 17, 2021 at 4:31 PM David Laight <David.Laight@aculab.com> wrote:
> > >
> > > From: Noah Goldstein
> > > > Sent: 17 November 2021 21:03
> > > >
> > > > Add check for "short distance movsb" for forwards FSRM usage and
> > > > entirely remove backwards 'rep movsq'. Both of these usages hit "slow
> > > > modes" that are an order of magnitude slower than usual.
> > > >
> > > > 'rep movsb' has some noticeable VERY slow modes that the current
> > > > implementation is either 1) not checking for or 2) intentionally
> > > > using.
> > >
> > > How does this relate to the decision that glibc made a few years
> > > ago to use backwards 'rep movs' for non-overlapping copies?
> >
> > GLIBC doesn't use backwards `rep movs`.  Since the regions are
> > non-overlapping it just uses forward copy. Backwards `rep movs` is
> > from setting the direction flag (`std`) and is a very slow byte
> > copy. For overlapping regions where backwards copy is necessary GLIBC
> > uses 4x vec copy loop.
>
> Try to find this commit 6fb8cbcb58a29fff73eb2101b34caa19a7f88eba
>
> Or follow links from https://www.win.tue.nl/~aeb/linux/misc/gcc-semibug.html
> But I can't find the actual patch.
>
> The claims were a massive performance increase for the reverse copy.
>

I don't think that's referring to optimizations around `rep movs`. It
appears to be referring to fallout from this patch:
https://sourceware.org/git/?p=glibc.git;a=commit;h=6fb8cbcb58a29fff73eb2101b34caa19a7f88eba

which broken programs misusing `memcpy` with overlapping regions
resulting in this fix:
https://sourceware.org/git/?p=glibc.git;a=commit;h=0354e355014b7bfda32622e0255399d859862fcd

AFAICT support for ERMS was only added around:
https://sourceware.org/git/?p=glibc.git;a=commit;h=13efa86ece61bf84daca50cab30db1b0902fe2db

Either way GLIBC memcpy/memmove moment most certainly does not
use backwards `rep movs`:
https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S;hb=HEAD#l655

as it is very slow.

> The pdf from www.agner.org/optimize may well indicate why some
> copies are unexpectedly slow due to cache access aliasing.

Even in the `4k` aliasing case `rep movsb` seems to stay within a
factor of 2 of optimal whereas the `std` backwards `rep movs` loses
by a factor of 10.

Either way, `4k` aliasing detection is mostly a concern of `memcpy` as
the direction of copy for `memmove` is a correctness question, not
an optimization.


>
> I'm pretty sure that Intel cpu (possibly from Ivy bridge onwards)
> can be persuaded to copy 8 bytes/clock for in-cache data with
> a fairly simple loop that contains 2 reads (maybe misaligned)
> and two writes (so 16 bytes per iteration).
> Extra unrolling just adds extra code top and bottom.
>
> You might want a loop like:
>         1:      mov     0(%rsi, %rcx),%rax
>                 mov     8(%rsi, %rcx),%rdx
>                 mov     %rax, 0(%rdi, %rcx)
>                 mov     %rdx, 8(%rdi, %rcx)
>                 add     $16, %rcx
>                 jnz     1b
>
>         David

The backwards loop already has 4x unrolled `movq` loop.

>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
