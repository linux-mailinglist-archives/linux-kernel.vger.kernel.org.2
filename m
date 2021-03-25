Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5A6348A5A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhCYHqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:46:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhCYHqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:46:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EB0A61A1E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616658368;
        bh=urWTServCtxCJX98E/tfAkTHjzvy+O9XuEj2LiVFDvw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rgBCa1gaQh/waTUpg6cJOQjfaY25azwtqiNzrmZzev/pr7XSMMDddyTizUNBe+k6B
         k4NcklOk8msBdTquCaAN9xpTh4NhVnr2DVpEMDEnm5NZKdvkqozwG25RmcUfCxKZwi
         9dL4tysVARLTphmF/Ban9rntGoch7KME95OE/6hCF0KBevWIKVvfozBU/shAChQANv
         KHUhtnCdSpaB2zsXTg6SCx0TSwAjvd0hpjW8egWIP3+Im33mO5gxswmTJXR8V5lpIV
         w+I2B84gQcqgKuanrgFEplh3v3Kr6Uw1aCHAZ9kKnUJVSYCorKsSv7DS17bCT4aCPP
         U5xMuFN1+X6OQ==
Received: by mail-oo1-f43.google.com with SMTP id j20-20020a4ad6d40000b02901b66fe8acd6so266295oot.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 00:46:08 -0700 (PDT)
X-Gm-Message-State: AOAM532Bjymf1Y2raaVb/6F/hcecW5XI5dTtVYh8zhAXb66g5KPG9Q4y
        mwHs8bhrFWkC1XkzQdsqgSHxaSx9958U5kI8iaA=
X-Google-Smtp-Source: ABdhPJzep4Pg2i8KPbq2YHIB8mXn/PTGrG59koY6+IsXfSbRbKnvLvglteo4dzIX2jBhOICJyUL2ak1Y8vvFiLDukig=
X-Received: by 2002:a4a:395d:: with SMTP id x29mr5968148oog.41.1616658367226;
 Thu, 25 Mar 2021 00:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <YFmdJlESrCh4iC9A@hirez.programming.kicks-ass.net>
 <0f4679d6-44a4-d045-f249-a9cffb126fd4@rasmusvillemoes.dk> <CABCJKuf1-GWda9_BiBO=nNP_drh3a8471G+LEqPzdVrLBhVqZQ@mail.gmail.com>
 <b2d77e78-751e-283c-8cff-e9c4f16e27ef@prevas.dk> <YFt382FImjQQ+10f@hirez.programming.kicks-ass.net>
 <a758cace-99ed-5c60-e59c-9f4f6b3a39c7@rasmusvillemoes.dk> <CABCJKuek8Set48v5wa2sbCN1fN7DYSczJ9MdH4BcQBdky1YNaA@mail.gmail.com>
 <2b38d13f-9f90-b94b-7de4-c924696e6a9f@rasmusvillemoes.dk> <CABCJKudx9bkvkOsAVi7Wzgr3AVFGwa64Kre1d59v0tTr6GOgcA@mail.gmail.com>
 <170687fb-13ef-e9b8-ac69-032202b344fe@rasmusvillemoes.dk> <YFw+4Ba5ci/Bmg0k@hirez.programming.kicks-ass.net>
In-Reply-To: <YFw+4Ba5ci/Bmg0k@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 25 Mar 2021 08:45:56 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF9_Z5epEqyohCPWSfyYse+msq+Oyoekr9C_LXg+Pbx5w@mail.gmail.com>
Message-ID: <CAMj1kXF9_Z5epEqyohCPWSfyYse+msq+Oyoekr9C_LXg+Pbx5w@mail.gmail.com>
Subject: Re: [PATCH] static_call: fix function type mismatch
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sami Tolvanen <samitolvanen@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2021 at 08:43, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Mar 25, 2021 at 01:42:41AM +0100, Rasmus Villemoes wrote:
> > > Actually, it looks like I can't select PREEMPT_DYNAMIC> and tweaking Kconfig
> >
> > Ah, there's no prompt on the "bool" line, so it doesn't show up. That
> > seems to be a mistake, since there's an elaborate help text which says
> >
> >           The runtime overhead is negligible with
> > HAVE_STATIC_CALL_INLINE enabled
> >           but if runtime patching is not available for the specific
> > architecture
> >           then the potential overhead should be considered.
> >
> > So it seems that it was meant to be "you can enable this if you really
> > want".
> >
> > to force enable it on arm64 results in a build error
>
> Right, PREEMPT_DYNAMIC really hard relies on HAVE_STATIC_CALL
>
> There's an implicit dependency in the select:
>
> config PREEMPT
>         ...
>         select PREEMPT_DYNAMIC if HAVE_PREEMPT_DYNAMIC
>
> > > ("implicit declaration of function 'static_call_mod'").
> >
> > Seems to be an omission in the last !HAVE_STATIC_CALL branch in
> > static_call_types.h, and there's also no
> > EXPORT_STATIC_CALL_TRAMP{,_GPL} in static_call.h for that case.
>
> That interface doesn't make sense for !HAVE_STATIC_CALL. It's impossible
> to not export the function pointer itself but still call it for
> !HAVE_STATIC_CALL.

I proposed an implementation for the indirect static call variety for
arm64 here [0] but we haven't yet decided whether it is needed, given
that indirect calls are mostly fine on arm64 (modulo CFI of course)

Maybe this helps?


[0] https://lore.kernel.org/linux-arm-kernel/20201120082103.4840-1-ardb@kernel.org/
