Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CCB380FD4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 20:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbhENSgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 14:36:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229952AbhENSgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 14:36:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03C296144C
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 18:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621017302;
        bh=CuuEkwV+N8t2BonQ3agVLWbtPd5DOE4Jjt+nL4AYZS0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UByPVfl+Q3LhIDTkxB9HsxmJ3A8tATi2yXk+rB8M/p5BwdQ3tolUtjrsKc/iNlHg+
         /t5wgdnTsEvoioeVmjpAfFMmwvIfVJweiI6oVL27T4YNDwyc2GIwjaG6IE4ceKGybP
         aGV1ZDe9xrYvwRhrYIxrHLpgTWSFTvNhLOudLUQpibCaBcZr6AGQtHuaIGGXK4uzS2
         tz15YjKqJYyIMQIakkQIN22igZjOOMk5El6Jfhx6AFsvBBTKKKt9BTqFb+2q6ZOyTs
         x2+V53fuIQWaE/6rj7CJdJpnzIic96lnowI2LwKRNeb5nfbHwsM3cmMJnSFyqYzTfe
         828+uPTLuuNEQ==
Received: by mail-wr1-f45.google.com with SMTP id h4so148704wrt.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 11:35:01 -0700 (PDT)
X-Gm-Message-State: AOAM5329KpeRMC/5NTfD5dhvRf6PzmaOxXIsvuzLwReMw6mm2eC18loE
        KfgmxVrVXUPE8Beaxh4g21urQ9DgEczCNAbGwZg=
X-Google-Smtp-Source: ABdhPJxgbKjN9tZU+5zwe6LBkqv6M7JLWeSOjqJnE189j0ZtTOrSkgSSj0cNHvs9kwrItnzEJ4r0U8CrPKwn2AJJH58=
X-Received: by 2002:a5d:6dc4:: with SMTP id d4mr61902203wrz.105.1621017300619;
 Fri, 14 May 2021 11:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210514140429.3334181-1-arnd@kernel.org> <20210514101610.4392adbc@gandalf.local.home>
In-Reply-To: <20210514101610.4392adbc@gandalf.local.home>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 14 May 2021 20:33:58 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1bZ6DBFRy+HCax-=jj2rTa+hCkK8VOSRvX56CLAz23Ew@mail.gmail.com>
Message-ID: <CAK8P3a1bZ6DBFRy+HCax-=jj2rTa+hCkK8VOSRvX56CLAz23Ew@mail.gmail.com>
Subject: Re: [PATCH] tracing: events_hist: avoid using excessive stack space
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Steven Rostedt (VMware)" <rostedt@godmis.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Qiujun Huang <hqjagain@gmail.com>, Tom Rix <trix@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 4:16 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> On Fri, 14 May 2021 16:04:25 +0200 Arnd Bergmann <arnd@kernel.org> wrote:
>
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > In some configurations, clang produces a warning about an overly large
> > amount of stack space used in hist_trigger_print_key():
> >
> > kernel/trace/trace_events_hist.c:4594:13: error: stack frame size of 1248 bytes in function 'hist_trigger_print_key' [-Werror,-Wframe-larger-than=]
> > static void hist_trigger_print_key(struct seq_file *m,
> >
> > Moving the 'str' variable into a more local scope in the two places
> > where it gets used actually reduces the the used stack space here
> > and gets it below the warning limit, because the compiler can now
> > assume that it is safe to use the same stack slot that it has for
> > the stack of any inline function.
>
> Thanks Arnd for the nice explanation of the rationale for this change.
>
> But I still find it too subtle to my liking that we need to move the
> declaration like this (and duplicate it twice) for internal behavior of the
> compiler (where it can't figure out itself by the use cases if it can
> optimize the stack).

It's not really internal behavior of the compiler that causes the smaller
scope to help here, I'm sure gcc has to do the same thing regarding
the placement of this variable on the stack. Clang does have some related
cases that it doesn't do as well as gcc, but I don't think this is one of them.

The difference between the compilers or configurations is the way that
inlining decisions are made, so if a compiler inlines another function into this
one that also uses a lot of stack space, that will trigger the warning, while
a compiler that does not inline that would not warn but also not use any
less stack space in the code path that uses the nested function.

> > diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> > index c1abd63f1d6c..e3fe84f017a8 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -4597,7 +4597,6 @@ static void hist_trigger_print_key(struct seq_file *m,
> >                                  struct tracing_map_elt *elt)
> >  {
> >       struct hist_field *key_field;
> > -     char str[KSYM_SYMBOL_LEN];
>
> Instead, I think we should just make str static, as this should only be
> called under the event_mutex. To be sure, we can also add:
>
>         /* To protect the static str variable */
>         lockdep_assert_held(&event_mutex);

Ok, I changed my local version to this, will send v2 once it passes
some more randconfig builds.

         Arnd
