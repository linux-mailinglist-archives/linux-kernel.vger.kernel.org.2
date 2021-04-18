Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4976736385B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 00:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235898AbhDRW6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 18:58:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232075AbhDRW6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 18:58:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3B89610CE
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 22:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618786652;
        bh=non+ChVWeE8XORlG2mTT2LEpY5Qi0iPeHnx5+TIBOnw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Hml6Xi8KIi3GG76p+sp/UYLXjyd5n9xus2Nld3dn9AZOiPUUC7YQtYfbkvhZ2NPd9
         KKAce5/1qzzEdSiqtF+FuV7QQo71ndLV5NuUOzRavunj00JJHi9C+pG94dXg5u7Mg1
         l4QTze+jxICEGftn8k3QUrJjF6XgAZYMrESpGBg9uo7xj8vKrGratd2qWckhTwA+lt
         WTvOrjQQD0iNmuoel3s9t1FEOWVpN+bO8I54sVCgilCu1B9+LELCh2wttNgVfa4Dg8
         Fn77mJFeXQt63d46so30tiTzRCo1b9tJ57hBFkF5qXHXs7auJa4VXC8cyYktPWXuIO
         FknZA9CPLXqOw==
Received: by mail-ej1-f49.google.com with SMTP id mh2so28485830ejb.8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 15:57:32 -0700 (PDT)
X-Gm-Message-State: AOAM531ee+q5it466gpCqV/7LWk+r/KxL5qW9xR1GbJGwuXHiSt7lg1l
        qJ/fVV8Wqm5J+FXzV9FvE8d9Ja3vVkuwVwHM41gQXA==
X-Google-Smtp-Source: ABdhPJxjNgfCFwVfPW9erl7ko9OHr6TFa02NZqnJKoE0yQbljqbGrNrNCwrifT6UMfhnIbV3pQj9DjxiaVPI/gTyu0I=
X-Received: by 2002:a17:906:4f91:: with SMTP id o17mr18987993eju.503.1618786651236;
 Sun, 18 Apr 2021 15:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-6-samitolvanen@google.com> <20210416211855.GD22348@zn.tnic>
 <CABCJKud8TvzhcjHCpsrtCJ4B50ZUfaL48F42EhZ2zWKLteAc0Q@mail.gmail.com>
 <20210416220251.GE22348@zn.tnic> <CALCETrVTtKqD6fonUmT_qr0HJ0X9TWzLGq-wpm+A7XKyjn3W5g@mail.gmail.com>
 <202104161519.1D37B6D26@keescook> <CALCETrV6WYx7dt56aCuUYsrrFya==zYR+p-YZnaATptnaO7w2A@mail.gmail.com>
 <202104161601.CFB2CCF84F@keescook> <CALCETrWUS52tzLNiWL5sAVVB5-ko1EW73-TEiO=eZ5jF_QyGPQ@mail.gmail.com>
 <877dl0sc2m.ffs@nanos.tec.linutronix.de> <CALCETrVEhL9N_DEM8=rbAzp8Nb2pDitRCZGRAVcE288MBrJ4ug@mail.gmail.com>
 <871rb7sh31.ffs@nanos.tec.linutronix.de>
In-Reply-To: <871rb7sh31.ffs@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 18 Apr 2021 15:57:19 -0700
X-Gmail-Original-Message-ID: <CALCETrXRHhEivNK0hqEdRz+gN8c9jhdsjJC=4EQKMWB1roYw3A@mail.gmail.com>
Message-ID: <CALCETrXRHhEivNK0hqEdRz+gN8c9jhdsjJC=4EQKMWB1roYw3A@mail.gmail.com>
Subject: Re: [PATCH 05/15] x86: Implement function_nocfi
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2021 at 9:17 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sat, Apr 17 2021 at 17:11, Andy Lutomirski wrote:
> > On Sat, Apr 17, 2021 at 4:53 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> which works for
> >>
> >>       foo = function_nocfi(bar);
> >
> > I agree in general.  But right now, we have, in asm/proto.h:
> >
> > void entry_SYSCALL_64(void);
> >
> > and that's pure nonsense.  Depending on your point of view,
> > entry_SYSCALL_64 is a symbol that resolves to an integer or it's an
> > array of bytes containing instructions, but it is most definitely not
> > a function void (void).  So, regardless of any CFI stuff, I propose
> > that we standardize our handling of prototypes of symbols that are
> > opaque to the C compiler.  Here are a couple of choices:
> >
> > Easy one:
> >
> > extern u8 entry_SYSCALL_64[];
> >
> > Slightly more complicated:
> >
> > struct opaque_symbol;
> > extern struct opaque_symbol entry_SYSCALL_64;
> >
> > The opaque_symbol variant avoids any possible confusion over the weird
> > status of arrays in C, and it's hard to misuse, since struct
> > opaque_symbol is an incomplete type.
>
> Makes sense.

Sami, do you want to do this as part of your series or should I write a patch?
