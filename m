Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7EF63DE616
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 07:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbhHCFQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 01:16:05 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:56712 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbhHCFQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 01:16:03 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 1735FUxA030522
        for <linux-kernel@vger.kernel.org>; Tue, 3 Aug 2021 14:15:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 1735FUxA030522
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1627967731;
        bh=iHeXBesWUS2LCnqq0FNp8apyHLY35m9QWyodGS+VgPk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q/ZsEm1PrCwyoPgn0pA4Je8ot8owjylV7TFHFSXuq44tyxlCCk6dMqSHpx3oVGg6L
         9/JvaPwqUrIZFoZEIi7ydjLZZEyOZNvEd4KiM131nVUigIdkXQGPoZ7rXB2BevKolY
         fRCHh2XkQn4CIQF8A/upBfVdpKD9guV/5pZyuirBcK5G7AVu/D8FuDAEEHNkXdWPhP
         WAQPcpp7NmxVtL9mAxUnzNQsMij8WqzWIFk8vh7MTuKGsLGHRnaVFG6AWwE3TPoi4I
         eZgonN7Tz3sAvp5gGiRhej4VY5nIGHwARBQJQUitUHRvGjJcRCeMmpm2c05tpwvwWO
         aCIauBbD87qUw==
X-Nifty-SrcIP: [209.85.216.54]
Received: by mail-pj1-f54.google.com with SMTP id b1-20020a17090a8001b029017700de3903so1861161pjn.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 22:15:30 -0700 (PDT)
X-Gm-Message-State: AOAM532s3Y+7fUXqw9Iq2Inq+8S6q9+JJ9XBb05v/KClJot4xIe9EeUA
        8H85by+KHhl7mIbcXApeNKA6kduggNEQmZ4K7Lk=
X-Google-Smtp-Source: ABdhPJya0UaFWRL/wAns8OuGrhondN5/7fuMS/ZcyeiSGCtK1/aIkwAYkwuDE76eM23xpsOhIdEL6ipXQYbSQ9koa+4=
X-Received: by 2002:a65:498a:: with SMTP id r10mr418992pgs.7.1627967729975;
 Mon, 02 Aug 2021 22:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210731052233.4703-1-masahiroy@kernel.org> <20210731052233.4703-3-masahiroy@kernel.org>
 <20210802092952.3047bb99@oasis.local.home>
In-Reply-To: <20210802092952.3047bb99@oasis.local.home>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 3 Aug 2021 14:14:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNARrkM7fAN8h792fFz8R3EEcLBJ74XXhP7ZKaATBy9KsrA@mail.gmail.com>
Message-ID: <CAK7LNARrkM7fAN8h792fFz8R3EEcLBJ74XXhP7ZKaATBy9KsrA@mail.gmail.com>
Subject: Re: [PATCH 3/3] trace: remove redundant dependency from IRQSOFF_TRACER
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 2, 2021 at 10:29 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sat, 31 Jul 2021 14:22:33 +0900
> Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> > IRQSOFF_TRACE is already guarded by a stronger condition,
> > TRACING_SUPPORT.
> >
> > 'depends on TRACE_IRQFLAGS_SUPPORT' is redundant.
>
> I'm fine with the other two patches, but this one concerns me. I'm not
> sure TRACING_SUPPORT really needs to depend on TRACE_IRQFLAGS_SUPPORT.
> When tracing was first introduced, the main use case was the irqsoff
> tracer. Today, with function graph tracing and events being introduced,
> it's one of the minor use cases of tracing support.
>
> I believe the only thing that requires the TRACE_IRQFLAGS_SUPPORT is
> the irqsoff tracer (and friends), so if anything, we should remove that
> dependency from TRACING_SUPPORT, not here.


OK.
The first two are more trivial, so please pick up
1/3 and 2/3, then drop this one.



BTW, I personally prefer HAVE_* to *_SUPPORT.

Maybe renaming as follows makes the code more consistent.

   STACKTRACE_SUPPORT      -> HAVE_STACKTRACE
   TRACE_IRQFLAGS_SUPPORT  -> HAVE_TRACE_IRQFLAGS



Documentation/kbuild/kconfig-language.rst says
HAVE_* style is the recommended way.



It is a common idiom to implement a feature/functionality that are
relevant for some architectures but not all.
The recommended way to do so is to use a config variable named HAVE_*
that is defined in a common Kconfig file and selected by the relevant
architectures.
An example is the generic IOMAP functionality.

We would in lib/Kconfig see::

  # Generic IOMAP is used to ...
  config HAVE_GENERIC_IOMAP

  config GENERIC_IOMAP
       depends on HAVE_GENERIC_IOMAP && FOO






> -- Steve
>
>
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  kernel/trace/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index 9d3f918b5867..b39e67db644e 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -265,7 +265,6 @@ config TRACE_PREEMPT_TOGGLE
> >  config IRQSOFF_TRACER
> >       bool "Interrupts-off Latency Tracer"
> >       default n
> > -     depends on TRACE_IRQFLAGS_SUPPORT
> >       select TRACE_IRQFLAGS
> >       select GENERIC_TRACER
> >       select TRACER_MAX_TRACE
>


--
Best Regards
Masahiro Yamada
