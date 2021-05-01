Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2780370483
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 02:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhEAAmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 20:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhEAAl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 20:41:59 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3640BC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 17:41:09 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id d15so240118ljo.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 17:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=94RJ8Mzed9hEK2GvRJDwkdGFD+7EIt8LpelWc7KS5BY=;
        b=s+JgcfohLFxD7FqELgsoPWVdWhFWfC1e/LMCWf3K23GImmi66swaqfCpEjg9gEM15o
         shX8gIHcpeYztZENwdwsnj6xrYDUCI7evFWc3XyuWlThFqfe4ZDVklCu/Td6+JYXaFIt
         TVAe8xJIVCiNsZ0kuk4/O7w3PA7TzVaPesMOpjUwJ47xVsIrLIAYESSy2R48Ab0QkHK3
         KxnNe8duLUiC5Tsswy1f+zTxZc7LbiZ/9gZtOGTIFtdPgJBPZNARYH7PSSuvg1gCt94C
         bC+G7SO5G4f2Q4zPGkROgzvj6FDU1soI5LAefOkuiLu+Cf4EPDJm3KTPNQKoULYT4LJH
         2mBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=94RJ8Mzed9hEK2GvRJDwkdGFD+7EIt8LpelWc7KS5BY=;
        b=XTA2JY5WhWKOY9nVRDfPZfRSxZEkD9i1ugvsb8rqLdipq4ON6qd6M64Yj3YfRv37qu
         IUmTAte0l06j+VeR8WLiudSlhLSF/6iPb2U38tvXq9qOkA5/PCnQ1gmVWfhZwPb+hvyV
         gsEKUGH3w1HP/syS8YOGCv6psjL21I2fg1chMCHonGuwJer5txK9SMPIF/y185rWIKXp
         cjbEPx2yXH/9oxHIIxsbvLxq/uhB8x/JezATRe+kVKQUaf7EBMBZD5Xc+ttgCxEA0qTa
         NkP2Lq3dveRG7FhfJmJwuCEsym5KHD/XuG0hGwwSenHwFpP2oH4qm+/WjQvVC9P5vOVo
         EjLQ==
X-Gm-Message-State: AOAM532+/F0Md7WK5KqIBYPsWtvxNHTyRWNHXpX5dZAewzjY01ZUEiJA
        LV31GuGfuh0QC3Wl9r1C1OTlKnKxx76sl8bDV9CtAV1AyRtZEw==
X-Google-Smtp-Source: ABdhPJwrMPZ+Rc971IRG4vPmXmZfQOqU/A4FtmMs5HDJS9EXBC7FmbwEFHXKOhp12L0rgvZLgI6EBKA1VElkkSKl9fQ=
X-Received: by 2002:a2e:7f1c:: with SMTP id a28mr5587921ljd.341.1619829667567;
 Fri, 30 Apr 2021 17:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjmNOoX8iPtYsM8PVa+7DE1=5bv-XVe_egP0ZOiuT=7CQ@mail.gmail.com>
 <CAKwvOdmMF_v9TzBtFn2S1qSS_yCDO8D-u3WhBehUM7gzjcdjUQ@mail.gmail.com>
 <CAKwvOdk+V2dc31guafFM=N2ez4SrwCmah+mimUG3MzPMx_2efQ@mail.gmail.com>
 <CAKwvOdn3uXniVedgtpD8QFAd-hdVuVjGPa4-n0h64PTxT4XhWg@mail.gmail.com>
 <CAKwvOdm3D=dqKw=kx46PLaiqfHOZJL3QFKGc8kxqJqpwdFFWqw@mail.gmail.com> <CAKwvOdkp_P8BCtFuKqDrtC_=A89ZfDf66Yr3FL2e=ojwv4KaMA@mail.gmail.com>
In-Reply-To: <CAKwvOdkp_P8BCtFuKqDrtC_=A89ZfDf66Yr3FL2e=ojwv4KaMA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 30 Apr 2021 17:40:56 -0700
Message-ID: <CAKwvOd=56=XJ9UPKVYJ=pTRGMNzdQe5k-rsx=66XQhWtrwtEqQ@mail.gmail.com>
Subject: Re: Very slow clang kernel config ..
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 5:25 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Apr 30, 2021 at 5:23 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Fri, Apr 30, 2021 at 5:19 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > A quick:
> > > $ perf record -e cycles:pp --call-graph lbr make LLVM=1 LLVM_IAS=1
> > > -j72 allmodconfig
> > > $ perf report --no-children --sort=dso,symbol
> > > shows:
> > >      2.35%  [unknown]                [k] 0xffffffffabc00fc7
> > > +    2.29%  libc-2.31.so             [.] _int_malloc
> > >      1.24%  libc-2.31.so             [.] _int_free
> > > +    1.23%  ld-2.31.so               [.] do_lookup_x
> >
> > ^ bfd
>
>
> > > +    0.63%  ld-2.31.so               [.] _dl_lookup_symbol_x
> >
> > ^ bfd
>
> Ah, no, sorry, these are the runtime link editor/loader. So probably
> spending quite some time resolving symbols in large binaries.

I don't see NOW in:
$ llvm-readelf -Wd `which clang`
so I don't think clang was linked as `-Wl,-z,now`. I also see both
.hash and .gnu.hash in
$ llvm-readelf -S `which clang`.

The presence of NOW or lack of .gnu.hash would have been my guess for
symbol lookup issues. Perhaps the length of C++ mangled symbols
doesn't help.
-- 
Thanks,
~Nick Desaulniers
