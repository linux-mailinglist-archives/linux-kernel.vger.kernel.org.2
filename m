Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C893747D0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 20:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbhEESFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 14:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbhEESEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 14:04:34 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E296EC04682F
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 10:55:23 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id g38so3780849ybi.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 10:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JRrWDm6hzoXBYkMYgzRKxH03l5/cMdlHpkGRxjVY6Vc=;
        b=eQKGx1guDvHwxN5vTy0GDXI58bnIFoJ0vFbeT43gm2kxemZAHNKxXjR+6J2fEvdWyS
         0iJBNRookiebnuLF9MaEFtDfcmO1JhwGICRlMFglMOBbup0HVeQcQl/b7+aUUVu89+rL
         uEt0JPUFptZSyQvf16g3d9BRHJVqU2PGcD2eo5OpAZBL0RJdp696Xjs699Cb9AMUQLdf
         iwyQcx8oiQ6gCxsVMkSvZMI3Xj0qMaHE03MsOrQ0sBiGDQcg76Rawzf/IPv+MrUAkRB1
         0Ox2xBfa4LIONi8LqCF3ubT4Bi8BOosO9QOewt1+22tt5hJf/2c3pl7URDok2BZEtGgv
         P2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JRrWDm6hzoXBYkMYgzRKxH03l5/cMdlHpkGRxjVY6Vc=;
        b=aMds1Wme7nGS2yrnGZ/+4jhPdOPtxah9ITesnnQsxcgVRFkc2TofW5tTejW2TGKGuw
         80Yqmkf3QX5bqtuT70TrMSjnv5rWvATj2Uh78fo9k96tEVZmFGbm8TORCkzQRq/bfA/I
         GJTzNgRwF6HBJO0V/wZA915oNv8iQREnwHZEkL9izmKaN6NeGkxCQLWBrsbo8YfzEs3E
         8zCHtPw1LADeBkkgga4xuwj/hy4mxsIU1Uu++1kiuKnl3O926CuML09FNVK/YIXpxfZZ
         TV4I+rIgEf7v5USdMErnCJ0cDPR5RDs5hmfxVDj2oERYWLZR3JEXFlNhFxtmC/KvUOhn
         vdRg==
X-Gm-Message-State: AOAM531lMIFAGVvGkXo7sp5bi42vWuLtbRd8h3U3LC90GKDUpOqihTwi
        tc/EALaGO+6fMdDrx8z+iFHZY5vb/H5awtZpFEE=
X-Google-Smtp-Source: ABdhPJwVMxbf8vlQIwVEJFRANO+gao9C76bvFSL0nqB9yuRBDcc47EIYjnT8+B25t/jdiKCU7AgSkcSJK7oJgcOVlko=
X-Received: by 2002:a25:bc8b:: with SMTP id e11mr44494005ybk.115.1620237323235;
 Wed, 05 May 2021 10:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjmNOoX8iPtYsM8PVa+7DE1=5bv-XVe_egP0ZOiuT=7CQ@mail.gmail.com>
 <CAKwvOdmMF_v9TzBtFn2S1qSS_yCDO8D-u3WhBehUM7gzjcdjUQ@mail.gmail.com>
 <CAKwvOdk+V2dc31guafFM=N2ez4SrwCmah+mimUG3MzPMx_2efQ@mail.gmail.com>
 <CAKwvOdn3uXniVedgtpD8QFAd-hdVuVjGPa4-n0h64PTxT4XhWg@mail.gmail.com>
 <CAKwvOdm3D=dqKw=kx46PLaiqfHOZJL3QFKGc8kxqJqpwdFFWqw@mail.gmail.com>
 <CAKwvOdkp_P8BCtFuKqDrtC_=A89ZfDf66Yr3FL2e=ojwv4KaMA@mail.gmail.com>
 <CAHk-=wi1yiBBr3b3RbCEte6-yzAApsZN5zRdr3xoW8Av9jOX=Q@mail.gmail.com>
 <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com>
 <1c5e05fa-a246-9456-ff4e-287960acb18c@redhat.com> <CAHk-=whs8QZf3YnifdLv57+FhBi5_WeNTG1B-suOES=RcUSmQg@mail.gmail.com>
 <20210502093123.GC12293@localhost> <CANiq72=aK-JJhpnZdeeGBtADrnXhyEp1Whw5+5rK6a4u85PhxA@mail.gmail.com>
 <5256ed6b6f7d423daeb36fcbfc837fbc@AcuMS.aculab.com> <CANiq72mq-SP5n_0cVr+eaP19xqJTP15V+JKUeqLiT910x=3NdA@mail.gmail.com>
 <3ab89c4f8b1d455ba46781b392ef0b2d@AcuMS.aculab.com> <CANiq72kPx48wTKCfgohwb2CbAf=SG3gyhv3htd3n_17aGAq2FA@mail.gmail.com>
 <42fdc9f1b4b44136b4eeffa0957ebc3e@AcuMS.aculab.com>
In-Reply-To: <42fdc9f1b4b44136b4eeffa0957ebc3e@AcuMS.aculab.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 5 May 2021 19:55:12 +0200
Message-ID: <CANiq72mX-F_EX0pydAgmHBMFEM5EPzCo8gqxS6h_YmmQ8u1POA@mail.gmail.com>
Subject: Re: Very slow clang kernel config ..
To:     David Laight <David.Laight@aculab.com>
Cc:     Adrian Bunk <bunk@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Stellard <tstellar@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Serge Guelton <sguelton@redhat.com>,
        Sylvestre Ledru <sylvestre@mozilla.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 5, 2021 at 6:25 PM David Laight <David.Laight@aculab.com> wrote:
>
> But it is the customer's customer who comes back to you saying
> that something in your library is broken.
> This is when you really don't what static linking - ever.

In that case, you need to refer them to your (direct) customer. I
understand where you are coming from (e.g. Microsoft also encourages
developers to avoid static linking their CRT), but there is no good
solution for that -- some of your direct customers will require you
provide the version for static linking nevertheless, so your only
approach would be gating access to the static version somehow.

> Static linking is much worse because different parts of the 'system'
> are provided by different people.
> With a little care a C shared library can be implemented by different
> companies while still meeting the same ABI.

I assume you are talking about things like program plugins in the form
of shared libraries (e.g. a different renderers in 3D suites,
different chess engines, mods in a videogame, etc.).

In that case, well, if you really need a customer of yours to swap
libraries without rebuilding the host program, because you want other
companies to provide plugins, then obviously static linking is not the
way to go. But shared libraries are just one possible solution in that
space anyway, there is also IPC of different kinds, bytecode VMs,
interpreters, etc.

> It this case it was done to give the software engineers some
> experience of writing C++.
> Technically it was a big mistake.
>
> Bad C++ is also infinitely worse that bad C.
> Exception handling (which you might think of as a gain)
> is very easy to get badly wrong.
> Class member overloads make it impossible to work out where data is used.
> Function overloads are sometimes nice - but unnecessary.

Agreed! While, in general, this applies to any language, it is
specially dangerous in languages with UB. And, among those, C++ is
very complex, which in turn can produce very subtle UB issues. This
was understood by Rust designers, and the language is an attempt to
minimize UB while, at the same time, providing higher-level features
than C.

Cheers,
Miguel
