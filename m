Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97312373CB9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 15:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhEENyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 09:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhEENyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 09:54:49 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C878C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 06:53:53 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id i4so2771909ybe.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 06:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=clf2wb3Wvwg3HyTYmDIH3OCqRQ4Qu8WPQlaPdGBfodo=;
        b=JfKZNrdnuYgfNHUmgOCqOdIjMbuF/sBBzVGGzX9kLfLkWIIlloDiT5ky31jsg8DOtv
         DExpo1mE8Hml4L5w8N4MDActP/1g1nsoz/wfRWOrZqplALxFetR+3Uj+WU54aQvCmmCE
         xJk0IslbRFBKAWycow9Lzcz2Od3O80GUi3I22djW+tYjRUi1viMAhR939lwD36tfBST5
         xwIg+ai2ILqc59Dh9FbJFgI3IvKiCv1e5KTXo8qDvj3MQu75FuGY/f5zuCbXV3v2EXGt
         XXkuXAV+LmoKyj0kUNtdOYepJYQkS0iOxRG2bm7F5UCFJgrm3Uz00yNr6Gwkt8ke6EvE
         l/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=clf2wb3Wvwg3HyTYmDIH3OCqRQ4Qu8WPQlaPdGBfodo=;
        b=l7TFT80s4i0BJzHNKbBNSqHcwS60LHKqL5UEYbFydTS2MxibqSzEW1ycvaAuxKxZSL
         V/dx5WDsmmZw3OcbffL14bJJt/GVkwQ9DApA3HNzrDpMuX2v7K3+IHI/QJKDwifsh0Nm
         hSqUutR+912H2SHZ+aPXcSjnJlj4h9UQHW+gufxzwIhyvrOe32BRSectB8lFwvhP+Lwh
         kVdFlkDXdQFNMygrrQYrveJ1QlmcEBKfGbDeHyDwcBR8yC2WZWHMlEgCdoN8fr1eb727
         ljE/5eC2dvBJdTCzjoVlHrvFSWzOVaNaDwkrvpcjkuOKV2BDyt3opioWT6bZdIJ2VJou
         xzuQ==
X-Gm-Message-State: AOAM530OumavQAReKQgiXhILZwUR1iATzrZsOm11JP01Q5PAZ99LRDFH
        0FFk1rJmC+EEJSZO1ExTqtZodiZztp89jHJRyTpwLZsCFN5kWA==
X-Google-Smtp-Source: ABdhPJwt59zPhG3C7dBLxMIsKHiFesWF0LokA9gB7+aHvgW6h2cIYRqmUd2pqlVd/hmi748H50J3AuRXQjAbW8P7vCE=
X-Received: by 2002:a25:880f:: with SMTP id c15mr40989755ybl.247.1620222832436;
 Wed, 05 May 2021 06:53:52 -0700 (PDT)
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
 <5256ed6b6f7d423daeb36fcbfc837fbc@AcuMS.aculab.com>
In-Reply-To: <5256ed6b6f7d423daeb36fcbfc837fbc@AcuMS.aculab.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 5 May 2021 15:53:41 +0200
Message-ID: <CANiq72mq-SP5n_0cVr+eaP19xqJTP15V+JKUeqLiT910x=3NdA@mail.gmail.com>
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

On Wed, May 5, 2021 at 1:06 PM David Laight <David.Laight@aculab.com> wrote:
>
> The problem isn't the packages that come with the distribution.

My question was in the context of Adrian's emails who were mentioning
issues for Linux distribution etc.

> The problem is 3rd party programs supplied as binaries.
> They have 2 big requirements:
> 1) The same binary will run on all distributions (newer than some cutoff).

This is fine with the "everything statically linked" model.

> 2) Any serious bug fixes in system libraries get picked up when the
>    distribution updates the library.

For 3rd party software, this is usually done through an auto-update
mechanism of some kind. And since the vendor typically provides
everything, including dependencies (even libc in some cases!), they
can afford to statically link the world.

That model, of course, has issues -- the vendor may go out of
business, may be slow with security updates, etc.

But this is all orthogonal to Rust -- I replied mainly because it was
mentioned that Rust brought new issues to the table, which isn't true.

> There is also the possibility that the implementation of some
> function differs between distributions.
> So you absolutely need to use the version from the installed system
> not whatever was in some static library on the actual build machine.
>
> Both of these need stable ABI and shared libraries.

Not really. If you go for the "statically linked" model for your
application, you only need to care about the syscall layer (or
equivalent higher-level layers in e.g. Windows/macOS).

If you trust vendors a bit, you can instead go for "statically linked
except for major system libraries" (like libc or libm in Linux). This
is what Rust does by default for the glibc x86_64 target.

Given that nowadays statically linking is convenient, affordable and
improves performance, it seems like the right decision.

> Remember, as far as userspace is concerned, foo.h is the definition
> for 'foo' and foo.so is the current implementation.
> (yes, I know a little bit of info is taken from foo.so on the build
> system - but that ought to be absolutely minimal.)

No, that is only the C model for shared libraries.

C++ has had templates for decades now and no "C++ ABI" so far covers
them. Thus, if you want to provide templates as a library, they cannot
be "pre-compiled" and so the implementation is kept in the header.

This actually turned out to be quite convenient and nowadays many
libraries are developed as "header-only", in fact. Moreover, recently
the C++ standard introduced new features that simplify taking this
approach, e.g. C++17 `inline` variables.

Rust has the same issue with generics, but improves the situation a
bit: there is no need to reparse everything, every time, from scratch,
for each translation unit that uses a library with templates (which is
quite an issue for C++, with big projects going out of their way to
reduce the trees of includes).

Cheers,
Miguel
