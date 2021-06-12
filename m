Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3D03A5046
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 21:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhFLTNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 15:13:16 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:39843 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhFLTNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 15:13:15 -0400
Received: by mail-ed1-f43.google.com with SMTP id dj8so41089642edb.6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 12:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BF4KTa2Agq0jbJMydgzuSSPg/d4XEACgY0H+fIBjXaw=;
        b=srFpC0SeLeMkVrDjlzK1DW3HKDXhgIITNsH1dfNDZIW98UQGzwOjxIsfL4oL/Par+m
         c325BPpRkPl+4uPJznfiMMw7K2cnTPKKPhxMmSpG37iPrSA1T3WHK7bXik4gzuEu/wyc
         31SiUM5cp8kGuZyoC6TJ0E5SNnylKtM6oIFXlVXhuZT2abo/g0jaqNy3BTW1QSgdkGTr
         3nXeZaipGtuuyWN5IeOMXVRivOnUS5ld7q0xAPSQJVTVIR56tvaL63vVUVxpxyDtqqBP
         mXFfee3XX/86wOJFUUlgn/QkWD3yH2i09HfpVWOYukEUPsl32LVj2mBotqEd7mNaEOhF
         ZCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BF4KTa2Agq0jbJMydgzuSSPg/d4XEACgY0H+fIBjXaw=;
        b=DRIIcnG9i8wFEN1lpUQnRueROZUh1wJV2KYW/XTSox8NYhLFiMGG0nN88nT35pwzqQ
         jbRMPwAXCeTh8kcKInIQkApUVTVzLPchZsBEcJ1++xfGvckhlCb122MSV9HSosD0276d
         2/bFtorD1UIcYs/svYyvnfpmYEEP0RlWPikW9qXwnSHKmvK4vAv0s5MUO9lO/uBEgUe7
         yJCWXSeupo+8pQHNvnqHlwnG82z1hIct7lHSPWv7RmNRjGbJlhEsVf2/CJz3+DNhbuSo
         +yZ7RevesopMvomXdc5FqRk8PZLyvEOmpAlNvPDh8sbBiBQE+G/fY4/fxVwUrCmAAe1m
         BE+g==
X-Gm-Message-State: AOAM530GjG6krXaLEHZkSRV9794MFk/4HCxrsxapgrOZ9ug5WpPLs/RW
        6NceEQZrDF951GioNOZwJcUKzcoSl4W+5rXZKGTb
X-Google-Smtp-Source: ABdhPJwqQz6M3ATeXs9AKuLxnc18TagDqn4vmELAttLKvYikYYiBAp4p1LMRAX02oCZAi3M7C7gTAQXrwzciEN+qB30=
X-Received: by 2002:aa7:c782:: with SMTP id n2mr9796203eds.77.1623525014362;
 Sat, 12 Jun 2021 12:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210111081821.3041587-1-morbo@google.com> <20210407211704.367039-1-morbo@google.com>
 <YMTn9yjuemKFLbws@hirez.programming.kicks-ass.net> <CAGG=3QXjD1DQjACu=CQQSP=whue-14Pw8FcNcXrJZfLC_E+y9w@mail.gmail.com>
 <YMT5xZsZMX0PpDKQ@hirez.programming.kicks-ass.net>
In-Reply-To: <YMT5xZsZMX0PpDKQ@hirez.programming.kicks-ass.net>
From:   Bill Wendling <morbo@google.com>
Date:   Sat, 12 Jun 2021 12:10:03 -0700
Message-ID: <CAGG=3QVHkkJ236mCJ8Jt_6JtgYtWHV9b4aVXnoj6ypc7GOnc0A@mail.gmail.com>
Subject: Re: [PATCH v9] pgo: add clang's Profile Guided Optimization infrastructure
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Fangrui Song <maskray@google.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

")On Sat, Jun 12, 2021 at 11:15 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sat, Jun 12, 2021 at 10:25:57AM -0700, Bill Wendling wrote:
> > On Sat, Jun 12, 2021 at 9:59 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Apr 07, 2021 at 02:17:04PM -0700, Bill Wendling wrote:
> > > > From: Sami Tolvanen <samitolvanen@google.com>
> > > >
> > > > Enable the use of clang's Profile-Guided Optimization[1]. To generate a
> > > > profile, the kernel is instrumented with PGO counters, a representative
> > > > workload is run, and the raw profile data is collected from
> > > > /sys/kernel/debug/pgo/profraw.
> > > >
> > > > The raw profile data must be processed by clang's "llvm-profdata" tool
> > > > before it can be used during recompilation:
> > > >
> > > >   $ cp /sys/kernel/debug/pgo/profraw vmlinux.profraw
> > > >   $ llvm-profdata merge --output=vmlinux.profdata vmlinux.profraw
> > > >
> > > > Multiple raw profiles may be merged during this step.
> > > >
> > > > The data can now be used by the compiler:
> > > >
> > > >   $ make LLVM=1 KCFLAGS=-fprofile-use=vmlinux.profdata ...
> > > >
> > > > This initial submission is restricted to x86, as that's the platform we
> > > > know works. This restriction can be lifted once other platforms have
> > > > been verified to work with PGO.
> > >
> > > *sigh*, and not a single x86 person on Cc, how nice :-/
> > >
> > This tool is generic and, despite the fact that it's first enabled for
> > x86, it contains no x86-specific code. The reason we're restricting it
> > to x86 is because it's the platform we tested on.
>
> You're modifying a lot of x86 files, you don't think it's good to let us
> know?  Worse, afaict this -fprofile-generate changes code generation,
> and we definitely want to know about that.
>
I got the list of people to add from the scripts/get_maintainer.pl.
The files you list below are mostly changes in Makefile, so it added
the kbuild maintainers and list. There's a small change to the linker
script to add the clang PGO data section, which is defined in
"include/asm-generic/vmlinux.lds.h". Using the "kernel/gcov" initial
implementation as a guildlline
(2521f2c228ad750701ba4702484e31d876dbc386), there's one intel people
CC'ed, but he didn't sign off on it. These patches were available for
review for months now, and posted to all of the lists and CC'ed to the
people from scripts/get_maintainers.pl. Perhaps that program should be
improved?

> > > >  arch/x86/Kconfig                      |   1 +
> > > >  arch/x86/boot/Makefile                |   1 +
> > > >  arch/x86/boot/compressed/Makefile     |   1 +
> > > >  arch/x86/crypto/Makefile              |   4 +
> > > >  arch/x86/entry/vdso/Makefile          |   1 +
> > > >  arch/x86/kernel/vmlinux.lds.S         |   2 +
> > > >  arch/x86/platform/efi/Makefile        |   1 +
> > > >  arch/x86/purgatory/Makefile           |   1 +
> > > >  arch/x86/realmode/rm/Makefile         |   1 +
> > > >  arch/x86/um/vdso/Makefile             |   1 +
>
>
> > > > +CFLAGS_PGO_CLANG := -fprofile-generate
> > > > +export CFLAGS_PGO_CLANG
>
> > > And which of the many flags in noinstr disables this?
> > >
> > These flags aren't used with PGO. So there's no need to disable them.
>
> Supposedly -fprofile-generate adds instrumentation to the generated
> code. noinstr *MUST* disable that. If not, this is a complete
> non-starter for x86.

"noinstr" has "notrace", which is defined as
"__attribute__((__no_instrument_function__))", which is honored by
both gcc and clang.

> > > Also, and I don't see this answered *anywhere*, why are you not using
> > > perf for this? Your link even mentions Sampling Profilers (and I happen
> > > to know there's been significant effort to make perf output work as
> > > input for the PGO passes of the various compilers).
> > >
> > Instruction-based (non-sampling) profiling gives us a better
> > context-sensitive profile, making PGO more impactful. It's also useful
> > for coverage whereas sampling profiles cannot.
>
> We've got KCOV and GCOV support already. Coverage is also not an
> argument mentioned anywhere else. Coverage can go pound sand, we really
> don't need a third means of getting that.
>
Those aren't useful for clang-based implementations. And I like to
look forward to potential improvements.

> Do you have actual numbers that back up the sampling vs instrumented
> argument? Having the instrumentation will affect performance which can
> scew the profile just the same.
>
Instrumentation counts the number of times a branch is taken. Sampling
is at a gross level, where if the sampling time is fine enough, you
can get an idea of where the hot spots are, but it won't give you the
fine-grained information that clang finds useful. Essentially, while
sampling can "capture the hot spots very well", relying solely on
sampling is basically leaving optimization on the floor.

Our optimizations experts here have determined, through data of
course, that instrumentation is the best option for PGO.

> Also, sampling tends to capture the hot spots very well.


-bw
