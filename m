Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE993A5F3E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 11:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbhFNJm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 05:42:57 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:35552 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbhFNJm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 05:42:56 -0400
Received: by mail-ej1-f45.google.com with SMTP id h24so15604385ejy.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 02:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c46qke8DxgxIDv3IuVIKJnlJyIG+YTeThnBZsvtK/rg=;
        b=fSErw+ts71RNPUmlh7u6mSMZev10ZGJ0qXD5C7j/jV3fM/NbMzS1FXDytLuZM1CgdV
         beonRP3Fe04w7WDObZtfBQ9KJ1acL1ln420Kie1ZIQ4qfDa7Dhx3f9UwRA+PCiXZojko
         zVzPodQvw4HAH2YsL9cib9ivdGdVKW4B8YZv+k5d1Ba9VeFSYwpF7h8pwEaTR8vn7Ubb
         is/gyp9xav5oRylPB2pqjo2co6nYsGtLlZHKd00un3fdYFCER7p/nPmkqb2fvRqfrbaZ
         48GTOFPh4zMtEwBlfPDido8+yzPju1VCZEXv+YYhxvcLofHLUBYhs2hW1M7Mzpiy/FeO
         O62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c46qke8DxgxIDv3IuVIKJnlJyIG+YTeThnBZsvtK/rg=;
        b=GsZr0bRp8RJX5d/z1/dRkXj2JGUqn/jb6+cTqKg+59HWQ8/KCldt0jWibKe6apqG38
         iBXLmlaZqSCjV/mwzZF7gKmcfXwg4Hp4v1lLx+/ypTYSDM4cKoDtkaD6P5krsW4//vUb
         pzBsMQpIxL3SC3ycYi8QSbBP6X7afV5e1bzn0Kqj+K8OxNgEUUggSTeLxIC1+Hq+Fbw3
         Uoap0wdXOoz3hrZ53dxdf/sS/n16bwozx06df38k5LUURfYHp9b2LxwEdJnCZtXLVfnp
         01So1LO2BscqPBbpi6zTzBgz6uhrHLKca8nvbCxX2dllnPKr2OGXxNAoNb5yt9Scqwog
         SHFw==
X-Gm-Message-State: AOAM533t6OtDverD8qgjFyt4VAKtdJPcOrdRJAWCuXshndfY2u2TJC7F
        34p9YpBoXRMNRqFKj/xhWMHXk9fwj2SN2JcqsTY7
X-Google-Smtp-Source: ABdhPJxopeMnR4SqxM25xYYX5rjY7pdAvEWg+ASkQl7823v5VCussGPx7cWRPnb8Bcn3wXE3paDcbXklIuXpxRCTIfg=
X-Received: by 2002:a17:906:7188:: with SMTP id h8mr14584262ejk.529.1623663592637;
 Mon, 14 Jun 2021 02:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210111081821.3041587-1-morbo@google.com> <20210407211704.367039-1-morbo@google.com>
 <YMTn9yjuemKFLbws@hirez.programming.kicks-ass.net> <CAGG=3QXjD1DQjACu=CQQSP=whue-14Pw8FcNcXrJZfLC_E+y9w@mail.gmail.com>
 <YMT5xZsZMX0PpDKQ@hirez.programming.kicks-ass.net> <CAGG=3QVHkkJ236mCJ8Jt_6JtgYtWHV9b4aVXnoj6ypc7GOnc0A@mail.gmail.com>
 <20210612202505.GG68208@worktop.programming.kicks-ass.net>
 <CAGG=3QUZ9tXGNLhbOr+AFDTJABDujZuaG1mYaLKdTcJZguEDWw@mail.gmail.com> <YMca2aa+t+3VrpN9@hirez.programming.kicks-ass.net>
In-Reply-To: <YMca2aa+t+3VrpN9@hirez.programming.kicks-ass.net>
From:   Bill Wendling <morbo@google.com>
Date:   Mon, 14 Jun 2021 02:39:41 -0700
Message-ID: <CAGG=3QVPCuAx9UMTOzQp+8MJk8KVyOfaYeV0yehpVwbCaYMVpg@mail.gmail.com>
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
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        andreyknvl@gmail.com, dvyukov@google.com, elver@google.com,
        johannes.berg@intel.com, oberpar@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 2:01 AM Peter Zijlstra <peterz@infradead.org> wrote:
> On Sat, Jun 12, 2021 at 01:56:41PM -0700, Bill Wendling wrote:
> > On Sat, Jun 12, 2021 at 1:25 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Sat, Jun 12, 2021 at 12:10:03PM -0700, Bill Wendling wrote:
> > > Yes it is, but is that sufficient in this case? It very much isn't for
> > > KASAN, UBSAN, and a whole host of other instrumentation crud. They all
> > > needed their own 'bugger-off' attributes.
> > >
> > > > > We've got KCOV and GCOV support already. Coverage is also not an
> > > > > argument mentioned anywhere else. Coverage can go pound sand, we really
> > > > > don't need a third means of getting that.
> > > > >
> > > > Those aren't useful for clang-based implementations. And I like to
> > > > look forward to potential improvements.
> > >
> > > I look forward to less things doing the same over and over. The obvious
> > > solution if of course to make clang use what we have, not the other way
> > > around.
> > >
> > That is not the obvious "solution".
>
> Because having GCOV, KCOV and PGO all do essentially the same thing
> differently, makes heaps of sense?
>
It does when you're dealing with one toolchain without access to another.

> I understand that the compilers actually generates radically different
> instrumentation for the various cases, but essentially they're all
> collecting (function/branch) arcs.
>
That's true, but there's no one format for profiling data that's
usable between all compilers. I'm not even sure there's a good way to
translate between, say, gcov and llvm's format. To make matters more
complicated, each compiler's format is tightly coupled to a specific
version of that compiler. And depending on *how* the data is collected
(e.g. sampling or instrumentation), it may not give us the full
benefit of FDO/PGO.

> I'm thinking it might be about time to build _one_ infrastructure for
> that and define a kernel arc format and call it a day.
>
That may be nice, but it's a rather large request.

> Note that if your compiler does arcs with functions (like gcc, unlike
> clang) we can also trivially augment the arcs with PMU counter data. I
> once did that for userspace.
