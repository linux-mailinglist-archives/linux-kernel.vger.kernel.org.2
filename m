Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2B93646FA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 17:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240125AbhDSPUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 11:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238909AbhDSPUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 11:20:52 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B8FC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 08:20:21 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id i4so1621266ybe.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 08:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5AB0J56DB0+rKOzeKwffFNSyBpKCgRBJJxrIGM5WtAQ=;
        b=G2vOdpjGyGGoTTBP2Ko6rtwtVn2X7zBQXijVTXkDMjKRzqZehI5NA0MG2JrCGqqrBM
         MlTaOO5RuWm9QAiUmE2N3deT2aT3LxDbmwCj0o4+H38Fy5FqxqBeCJue32x8JN62MaQg
         fvwvWSpd1VlNVGBp1Bw+fCAbziP1Jz8pGtWRRoEtfmC5vGwHKk5xf9LoZ0gqYyyFH2kZ
         kglMik63OFcPc5A7Q4aExNrv4mBq0tIxWyN3n1LjteifwSPV9cxt88urjEqQFs2gA6X8
         AgQt0RJkoU+I+FuVmh8KkYIGArZKAQlCm61MhFJG+QWS/jHxiIyzOMNBuMnyYcFr6zTH
         J5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5AB0J56DB0+rKOzeKwffFNSyBpKCgRBJJxrIGM5WtAQ=;
        b=eJj63H4O4IoqPbPoTZBIO3ECVkhl+aC8JgUH/6aijpTAzyd5gWink0MNSHr2Zwuksa
         1zBQVwsNAgs4J5nXkfyd4p1LLqR86fGcrvZTJlHKa/a6KOQasrdMo8jbz3PVd3QhM4N/
         BWQ02nZ9xkjA21EmeHj4aTL0QltnV/WMCAdYiR+kk37VrEBWk8zXGaScMHwVpjJr67tP
         hOhyC2zGiN3JvtV7InUwjqE4CsT5qMVmRr/iHyLmDLmOSA/CT8B4Wx/zrAOypVR4Hf8R
         zFqezubZ4MTq8B275H6Ej1ucJBhMVEWCv7O9qw/jLazpZunUP9XDRpYFUsYa88IZR4cI
         JBVw==
X-Gm-Message-State: AOAM530s5Zsk6Sn6qYBNlXGjMxEAcEidi7FKt9nZt9x+t5hGEHs0iB1f
        OnTB+DFVbPKl5EFlCwDulxezoPvH2SHSvWs0NR8lkQ==
X-Google-Smtp-Source: ABdhPJwo5knAYBVE+scoHvT1tW2evDZf/Kc8N06WPxDzLsBETelFrQAEB70IA2UV2Fala91XL032+2ANwH6P5Sv6CEU=
X-Received: by 2002:a25:7085:: with SMTP id l127mr18347488ybc.293.1618845620724;
 Mon, 19 Apr 2021 08:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-6-samitolvanen@google.com> <20210416211855.GD22348@zn.tnic>
 <CABCJKud8TvzhcjHCpsrtCJ4B50ZUfaL48F42EhZ2zWKLteAc0Q@mail.gmail.com>
 <20210416220251.GE22348@zn.tnic> <CALCETrVTtKqD6fonUmT_qr0HJ0X9TWzLGq-wpm+A7XKyjn3W5g@mail.gmail.com>
 <202104161519.1D37B6D26@keescook> <CALCETrV6WYx7dt56aCuUYsrrFya==zYR+p-YZnaATptnaO7w2A@mail.gmail.com>
 <202104161601.CFB2CCF84F@keescook> <CALCETrWUS52tzLNiWL5sAVVB5-ko1EW73-TEiO=eZ5jF_QyGPQ@mail.gmail.com>
 <877dl0sc2m.ffs@nanos.tec.linutronix.de> <CALCETrVEhL9N_DEM8=rbAzp8Nb2pDitRCZGRAVcE288MBrJ4ug@mail.gmail.com>
 <871rb7sh31.ffs@nanos.tec.linutronix.de> <CALCETrXRHhEivNK0hqEdRz+gN8c9jhdsjJC=4EQKMWB1roYw3A@mail.gmail.com>
In-Reply-To: <CALCETrXRHhEivNK0hqEdRz+gN8c9jhdsjJC=4EQKMWB1roYw3A@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 19 Apr 2021 08:20:09 -0700
Message-ID: <CABCJKufQqhXsP0Nv1hu60YoH=Tetp35=yENS_9LWZvzptFvjDQ@mail.gmail.com>
Subject: Re: [PATCH 05/15] x86: Implement function_nocfi
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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

On Sun, Apr 18, 2021 at 3:57 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Sun, Apr 18, 2021 at 9:17 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Sat, Apr 17 2021 at 17:11, Andy Lutomirski wrote:
> > > On Sat, Apr 17, 2021 at 4:53 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >> which works for
> > >>
> > >>       foo = function_nocfi(bar);
> > >
> > > I agree in general.  But right now, we have, in asm/proto.h:
> > >
> > > void entry_SYSCALL_64(void);
> > >
> > > and that's pure nonsense.  Depending on your point of view,
> > > entry_SYSCALL_64 is a symbol that resolves to an integer or it's an
> > > array of bytes containing instructions, but it is most definitely not
> > > a function void (void).  So, regardless of any CFI stuff, I propose
> > > that we standardize our handling of prototypes of symbols that are
> > > opaque to the C compiler.  Here are a couple of choices:
> > >
> > > Easy one:
> > >
> > > extern u8 entry_SYSCALL_64[];
> > >
> > > Slightly more complicated:
> > >
> > > struct opaque_symbol;
> > > extern struct opaque_symbol entry_SYSCALL_64;
> > >
> > > The opaque_symbol variant avoids any possible confusion over the weird
> > > status of arrays in C, and it's hard to misuse, since struct
> > > opaque_symbol is an incomplete type.
> >
> > Makes sense.
>
> Sami, do you want to do this as part of your series or should I write a patch?

I can certainly include this in the next version, but that might have
to wait a bit for compiler changes, so if you want this done sooner,
please go ahead.

Sami
