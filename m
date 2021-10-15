Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E9142F5C0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 16:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240572AbhJOOnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 10:43:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240636AbhJOOnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 10:43:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DA3361073
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 14:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634308871;
        bh=3XcFcSTdDuaBZvT4X6ivFNuNq8b+jyD0BZAbI/9zmJo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E7NCpliLQPe8kjkpVCfMyV0ROO90T85LPbn9DFKZD7elKoLCI2niGKgXA1bHbkJ4w
         RU50fd2IbHe1RHHQBYy6i20edABMMBhuXWql/tqGFrdksfwEQeEKaGd2bgtkckoTU3
         dwEWZO2vLX0hdMc+sH7GTBFTF0rM6uoLJJgxpMhvFoMybFw73RIM3DqM3gP/VmI+Bs
         NOxEhZx/XBAWJrHUCySX6p8/XRvB8DraVK6vcPzqU5N4ngcupzcg38xUqbgljYSGxQ
         WHy7C/mudOLwNadj+xIZKOFXahKdDDcZb0js2ZMF1GF/TOgzwIWDwOkG5Fo9c9dOm3
         sRO57c1umTh4w==
Received: by mail-wm1-f52.google.com with SMTP id z2so2748742wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 07:41:11 -0700 (PDT)
X-Gm-Message-State: AOAM531rl09k5cFDsp8bkCiWRCwjOodyfTxQ/SKIb0fZJbEvq7fR+5Y4
        HFWzK+UEAuftYA8Qpuc7cNzKl4s6QKJuA2AnKwE=
X-Google-Smtp-Source: ABdhPJxo0VPgx+thRuW8p7bIln8etgLAM6ec5/6RcjdcBohlt3cutk7inHMaUeurJSLgK4LP4HIsUG6+tBxPUxch/ag=
X-Received: by 2002:a1c:2358:: with SMTP id j85mr26313102wmj.1.1634308869706;
 Fri, 15 Oct 2021 07:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211015083447.760448-1-arnd@kernel.org> <20211015095704.49a99859@gandalf.local.home>
In-Reply-To: <20211015095704.49a99859@gandalf.local.home>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 15 Oct 2021 16:40:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1oTpirhdvYLNV=vw1pr6kZCkaHf=y-nuvHy8=9GOrO2A@mail.gmail.com>
Message-ID: <CAK8P3a1oTpirhdvYLNV=vw1pr6kZCkaHf=y-nuvHy8=9GOrO2A@mail.gmail.com>
Subject: Re: [PATCH] tracing: use %ps format string to print symbols
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 3:57 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 15 Oct 2021 10:34:31 +0200
> Arnd Bergmann <arnd@kernel.org> wrote:
>
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > clang started warning about excessive stack usage in
> > hist_trigger_print_key()
> >
> > kernel/trace/trace_events_hist.c:4723:13: error: stack frame size (1336) exceeds limit (1024) in function 'hist_trigger_print_key' [-Werror,-Wframe-larger-than]
> >
> > The problem is that there are two 512-byte arrays on the stack if
> > hist_trigger_stacktrace_print() gets inlined. I don't think this has
> > changed in the past five years, but something probably changed the
> > inlining decisions made by the compiler, so the problem is now made
> > more obvious.
>
> Could we just add "noinline" attribute to that function?

It would avoid the warning, but not reduce the overall stack
usage. If that's good enough for you, I'm fine with that as well.

> > @@ -4715,8 +4714,7 @@ static void hist_trigger_stacktrace_print(struct seq_file *m,
> >                       return;
> >
> >               seq_printf(m, "%*c", 1 + spaces, ' ');
> > -             sprint_symbol(str, stacktrace_entries[i]);
> > -             seq_printf(m, "%s\n", str);
> > +             seq_printf(m, "%pS\n", stacktrace_entries[i]);

I just noticed this needs an extra cast to (void*) to avoid a warning
with clang,
not sure why I saw it build cleanly before.

> > @@ -4747,14 +4744,12 @@ static void hist_trigger_print_key(struct seq_file *m,
> >                       seq_printf(m, "%s: %llx", field_name, uval);
> >               } else if (key_field->flags & HIST_FIELD_FL_SYM) {
> >                       uval = *(u64 *)(key + key_field->offset);
> > -                     sprint_symbol_no_offset(str, uval);
> > -                     seq_printf(m, "%s: [%llx] %-45s", field_name,
> > -                                uval, str);
> > +                     seq_printf(m, "%s: [%llx] %-45ps", field_name,
> > +                                uval, (void *)uval);
> >               } else if (key_field->flags & HIST_FIELD_FL_SYM_OFFSET) {
> >                       uval = *(u64 *)(key + key_field->offset);
> > -                     sprint_symbol(str, uval);
> > -                     seq_printf(m, "%s: [%llx] %-55s", field_name,
> > -                                uval, str);
> > +                     seq_printf(m, "%s: [%llx] %-55ps", field_name,
> > +                                uval, (void *)uval);
>
> The above requires "Ps" not "ps".

you mean "%-55pS", right?

> But other than that, I could test if this doesn't change the formatting and
> functionality at all.

Ok, let me know if I should resend with the two small changes I mentioned,
or if you want to just go with the 'noinline_for_stack' annotation.

        Arnd
