Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45FC3A5054
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 21:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhFLTar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 15:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhFLTaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 15:30:46 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AF2C061767
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 12:28:46 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id g20so9727721ejt.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 12:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HEcAR/YBJ4tG1SxjPx2PGfcPs966hhlEtWLnEUkitOw=;
        b=HdUb91RPhEPJn0AJi54CADEH5e99znvd/HCzRmxFCRbHbQDIw3t38RjLP4AOTuXpq7
         eBeiUhPOuAFvGEBupIMtag9pb0dDxuiLm9Qzp3ITDBh8hFpCgFSur0hinT/UKDQxTgeu
         n34Ukzr/vq2pOpY7y33jg18lWLWn/6Zj3sjUqd0QbXWgi4iVe12T8TxrVcoqyTbB/x3Z
         3Hc6GqbQ/VCTjYfVsxPAPkiNWfsD7SzUMH87LTDE6Ho9Xb59Yri9CBLcmFeDTron1wWF
         FqP/s1ldrZ19a6IkoMnl2wuvpTZKQk2MeqOnBOHowLu8TxvuIu869lUTxVN8zoptLPSa
         DZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HEcAR/YBJ4tG1SxjPx2PGfcPs966hhlEtWLnEUkitOw=;
        b=QZoySare/rozSUK/4s4ZRVSygwZmNfHey69e/7ztPPsNwxYiSOtUApt+FntHt2jJG2
         oqH7GSTrOZlPq5xdC8r9e4gDqXik7WEANgZtS62+qneRnSJunXfMawoFYJVYA/j2KMkb
         t+84pgnUSPEO+gY35EejwkYA2/yqy7P7XfAyYmWqCCen3pjeiorXNM0AvnqeAggOgEo5
         I9apzrDg2XTCUt6kJqNemDgL+aUQAFrKVysMujRkaHzkrAVlfPzoS1SJ8BnnqhFESybc
         GjmwdXGySFhpP6ixMsdXs+n8eqbQVXwK1jC0L5xe8sh2xqC78yNStmbKhea9IQW77FPa
         C9WA==
X-Gm-Message-State: AOAM532XauMZo8E5XDY8w04nnX+rkroA9P6oCF824EeeMi1P/9XDPbYN
        o6SuGjJ8b4NrWU5wt2KQjCBZhZ/MHdKppafK8fKu
X-Google-Smtp-Source: ABdhPJxP1ZoP/KXjCt4Svz+0ucDKjT/tA+5Q+aPsUCqfc19pDRdSbymlxJjQnjgiodRIo08pom1+mXIyfuqS/4JquBU=
X-Received: by 2002:a17:906:1c4d:: with SMTP id l13mr8893522ejg.531.1623526124416;
 Sat, 12 Jun 2021 12:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210111081821.3041587-1-morbo@google.com> <20210407211704.367039-1-morbo@google.com>
 <YMTn9yjuemKFLbws@hirez.programming.kicks-ass.net> <CAGG=3QXjD1DQjACu=CQQSP=whue-14Pw8FcNcXrJZfLC_E+y9w@mail.gmail.com>
 <YMT5xZsZMX0PpDKQ@hirez.programming.kicks-ass.net> <CAGG=3QVHkkJ236mCJ8Jt_6JtgYtWHV9b4aVXnoj6ypc7GOnc0A@mail.gmail.com>
In-Reply-To: <CAGG=3QVHkkJ236mCJ8Jt_6JtgYtWHV9b4aVXnoj6ypc7GOnc0A@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Sat, 12 Jun 2021 12:28:33 -0700
Message-ID: <CAGG=3QXTa5ZbXZE5Obo96V0a13-YTGE_Tgmc9yytv8-USLGkKQ@mail.gmail.com>
Subject: Re: [PATCH v9] pgo: add clang's Profile Guided Optimization infrastructure
To:     Peter Zijlstra <peterz@infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
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
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 12:10 PM Bill Wendling <morbo@google.com> wrote:
> ")On Sat, Jun 12, 2021 at 11:15 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > On Sat, Jun 12, 2021 at 10:25:57AM -0700, Bill Wendling wrote:
> > > On Sat, Jun 12, 2021 at 9:59 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Wed, Apr 07, 2021 at 02:17:04PM -0700, Bill Wendling wrote:
> > > > > From: Sami Tolvanen <samitolvanen@google.com>
> > > > >
> > > > > Enable the use of clang's Profile-Guided Optimization[1]. To generate a
> > > > > profile, the kernel is instrumented with PGO counters, a representative
> > > > > workload is run, and the raw profile data is collected from
> > > > > /sys/kernel/debug/pgo/profraw.
> > > > >
> > > > > The raw profile data must be processed by clang's "llvm-profdata" tool
> > > > > before it can be used during recompilation:
> > > > >
> > > > >   $ cp /sys/kernel/debug/pgo/profraw vmlinux.profraw
> > > > >   $ llvm-profdata merge --output=vmlinux.profdata vmlinux.profraw
> > > > >
> > > > > Multiple raw profiles may be merged during this step.
> > > > >
> > > > > The data can now be used by the compiler:
> > > > >
> > > > >   $ make LLVM=1 KCFLAGS=-fprofile-use=vmlinux.profdata ...
> > > > >
> > > > > This initial submission is restricted to x86, as that's the platform we
> > > > > know works. This restriction can be lifted once other platforms have
> > > > > been verified to work with PGO.
> > > >
> > > > *sigh*, and not a single x86 person on Cc, how nice :-/
> > > >
> > > This tool is generic and, despite the fact that it's first enabled for
> > > x86, it contains no x86-specific code. The reason we're restricting it
> > > to x86 is because it's the platform we tested on.
> >
> > You're modifying a lot of x86 files, you don't think it's good to let us
> > know?  Worse, afaict this -fprofile-generate changes code generation,
> > and we definitely want to know about that.
> >
> I got the list of people to add from the scripts/get_maintainer.pl.
> The files you list below are mostly changes in Makefile, so it added
> the kbuild maintainers and list. There's a small change to the linker
> script to add the clang PGO data section, which is defined in
> "include/asm-generic/vmlinux.lds.h". Using the "kernel/gcov" initial
> implementation as a guildlline
> (2521f2c228ad750701ba4702484e31d876dbc386), there's one intel people
> CC'ed, but he didn't sign off on it. These patches were available for
> review for months now, and posted to all of the lists and CC'ed to the
> people from scripts/get_maintainers.pl. Perhaps that program should be
> improved?
>
Correction: I see now that it lists X86 maintainers. That was somehow
missed in my initial submission. Sorry about that. Please add any
reviewers you think are necessary.

-bw
