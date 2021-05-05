Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACAE9373F38
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 18:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbhEEQHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 12:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbhEEQHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 12:07:54 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFC2C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 09:06:56 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id m9so3365066ybm.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 09:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LcLBjTr6PtB5gcjnwMykXk7R0waSGnrXkO7bNa1DIzo=;
        b=a7eYkZ+MSK2FhAHYQ4q8LIZ/93zchJCq2kdcu7Epqa+oHnXhF70271BHgsvPkK/Ar6
         ajngFfLeEzig9MyHO1eHrSaHXFcpcVECUNs5HkBMGjPJU2qbQroOcIGMlQj7fdn38Txo
         d9dLmQmDJ7dcJrJLZSk0LpRYzLYeIRo0gL3WjrqhSIwCDu8xkoxcRiG/OSAPKDGOpqe0
         j3h8H5DOal4ke6oUdrk5agrc4qJ2gj2fudVKlVp/1rqEzFMd6AnueVcUKAFHTBsTYa5P
         Tfrt0RrbKyjzHBF6l0/e+eut/H9iS4hlSMq6uD/sHuujqRjtybfuU+9WAyYPVn9PPNTQ
         J3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LcLBjTr6PtB5gcjnwMykXk7R0waSGnrXkO7bNa1DIzo=;
        b=f+xJPq7MUMdyyo50Jf8pMbD8QuA6zuFUyJ+84hqqBAkYH3uvM5aYTz9Z6v/CzzXkvR
         WhonSfsSkZc1yy2nu7HRT/OmnYmFUg5bL8f6JEmGr9EU2Eos8fAmkgCMpnA8XKLerPjN
         BT+k9q1SsYuNXWFnZNuONQHwlgJlxIQ9HmzdmETLBYB85ElPkvexq8ASxRBnTF8/6uNC
         qpkEgFDDSRjUMf3AHD/FEv6kTaqJViFnau8lIE5FLmeSRFpvRxAEYqTWD7frBNr6HlZD
         HnEWmRMFfKCc3UbHqIC51ChTfdfzdNlD2rzeZJa0BMYmV5v20wvUaHGlpJPgGIUIV26f
         dO7w==
X-Gm-Message-State: AOAM531cAWEmLc74Y1BIyX2NyS/9ewMHtFjosEUycfh8hfEAdV5JhYh1
        3e8iSfK3s4Awq38ntnuOLb9sseYl9mBJJQv3K+g=
X-Google-Smtp-Source: ABdhPJxyKQPubSS6BfEfz06HKc4EYP+oZ6OQCw2nG0KEtMJbEkqBLaga8GklFYRK78Pjxl7GCuPoc4qlOgM69Ko65H8=
X-Received: by 2002:a25:d45:: with SMTP id 66mr20346980ybn.93.1620230815765;
 Wed, 05 May 2021 09:06:55 -0700 (PDT)
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
 <3ab89c4f8b1d455ba46781b392ef0b2d@AcuMS.aculab.com>
In-Reply-To: <3ab89c4f8b1d455ba46781b392ef0b2d@AcuMS.aculab.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 5 May 2021 18:06:44 +0200
Message-ID: <CANiq72kPx48wTKCfgohwb2CbAf=SG3gyhv3htd3n_17aGAq2FA@mail.gmail.com>
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

On Wed, May 5, 2021 at 4:13 PM David Laight <David.Laight@aculab.com> wrote:
>
> Many years ago the company I worked for found that the unix 'utmpx'
> file was getting corrupted (due to incorrect locking).
> The functions had been places in an archive part of libc (for
> various reasons).
> Getting the fix onto the customers machine (we were the OS vendor)
> involved determining which applications from 3rd (4th?) parties
> had been linked with the broken code and then applying enough
> 'gentle persuasion' to get them to relink the offending programs.
> Even this can be problematic because the source control systems
> of some companies isn't great (it is probably better these days).
> But getting the 'previous version' rebuilt with a new libc.a
> can be very problematic.

If you are a library vendor and you provide the fixed library, then
you are done. It is your customer's call to rebuild their software or
not; and they are the ones choosing static linking or not.

Sure, you want to offer the best service to your clients, and some
customers will choose static linking without fully understanding the
pros/cons, but you cannot do anything against that. And you still need
to provide the static version for those clients that know they need
it.

> No because there are messages sent to system daemons and file
> formats that can be system dependant.
> Not everything is a system call.

That is orthogonal to static linking or not, which was the topic at hand.

What you are talking about now are dependencies on external entities
and services. Static linking is not better nor worse just because you
depend on a local process, a file, a networked service, a particular
piece of hardware being present, etc.

> Remind be to request our management to let me remove all the C++
> from most of our programs.

Yeah, the problem exists since before 1998 :)

A stable, common C++ ABI etc. would have had some advantages, but it
did not happen.

> None of them actually need it, the reasons for C++ aren't technical.

Well, no program "needs" any particular language, but there are
advantages and disadvantages of using languages with more features
(and more complexity, too). It is a balance.

For the kernel, we believe Rust brings enough advantages over *both* C
and C++ to merit using it. C++ also has advantages over C, but it has
a big complexity burden, it has not had the luxury of being designed
from scratch with decades of hindsight from C and C++ like Rust has
had, and it does not have a UB-free subset.

> That sounds like it has all the same problems as pre-compiled headers.

PCHs are a hack to improve build times, yes.

In Rust, however, it is a more fundamental feature and the needed
information goes encoded into your library (.rlib, .so...).

Cheers,
Miguel
