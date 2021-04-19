Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4CB6364717
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 17:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240837AbhDSP10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 11:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbhDSP1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 11:27:19 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C397C061761
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 08:26:48 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id c195so39197455ybf.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 08:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tzb/+EbwYHLN4nxTuV4UKFwyv5D43rDbhLkuAljBUMc=;
        b=r/yqG7pUEvuWmvwcAN+ZsOp88DSLN5Szqm7c64htgXhv6NnxyzEj31HM+u8SeAPgxF
         Y3r8QWzKV85aBZzq3d4zwsejv01NJ980SfWWo93Znlm+wDcPHK4fYNHX8KG0tokTGDEq
         tsPfZCbSk4okWCvn7fvayQ9bXEk1NgKsAFzIrzSPQh/T3BEbPvrDgNgp9lZLYe5rW7cs
         AOtvee6E4GE6+V6CSsKklT8e8dt9F8gBjgl6iPN8D7of6i5t7/jI6tSrbQtkCBnbKR3m
         6XYn7QLBY+xZo6fTmCigBgcZGIkuuYsB2gMPoIrVR3dlLslNjf8q2TiVtHmCRJ2i7D+E
         HjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tzb/+EbwYHLN4nxTuV4UKFwyv5D43rDbhLkuAljBUMc=;
        b=n2x6XLB5bSFyGz+Z1u3Sf3vzJF7LHypPmR5IrEDUlzNskq7/XGo74A2T4nJfo1MFzE
         nM3rf8g6yO9oRAuWUmigZfHV55Vz+tQw7hJEpDhJ99voOQ/HJebriWoCdzMA9Ee5XcFw
         f3CMLvxjIsDMkBopMOOAaiyOpDy8Xq9ljjfuPSdss3AAnQKBynEd06GFd8+6htslm3ME
         05na9kYmGRgcLaWTUUs0en9AMptLPbgGOfwYfHuHP1G2rkTMxO8NUyv+5gwWrrsgeAEJ
         oWGQ5+AKc2M+VanskOLL8VlB+9c2BDaEZ8Jthzgy/aI3LNKBP1BsjQ9DPuUu2d/DzlRb
         oA2Q==
X-Gm-Message-State: AOAM532AqgVh6T2xM51cOjcEcxN4nWewCDqNhjEkedYl5BGkLUKVK3is
        m/WMRcBjB7+gxs9h0MKS0ONlOMAa3nnzXYk+gjZ110rw6XM=
X-Google-Smtp-Source: ABdhPJzTzl74OJPzMlU029c1MRTT0Th9IJfji30PLdlkZRVuJD6XS699NNKbJAHdTdd8WjDP7igb5Lkx5vEYFH1yORQ=
X-Received: by 2002:a25:ba06:: with SMTP id t6mr10459679ybg.459.1618846007267;
 Mon, 19 Apr 2021 08:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-10-samitolvanen@google.com> <YHrIc0L5AQukw525@hirez.programming.kicks-ass.net>
In-Reply-To: <YHrIc0L5AQukw525@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 19 Apr 2021 08:26:36 -0700
Message-ID: <CABCJKuevfuVbKZPtLrFacXZLk+VtbFgebbyLeK8Xxe7Z3YmwQA@mail.gmail.com>
Subject: Re: [PATCH 09/15] x86/alternatives: Use C int3 selftest but disable KASAN
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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

On Sat, Apr 17, 2021 at 4:37 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Apr 16, 2021 at 01:38:38PM -0700, Sami Tolvanen wrote:
> > From: Kees Cook <keescook@chromium.org>
> >
> > Instead of using inline asm for the int3 selftest (which confuses the
> > Clang's ThinLTO pass), this restores the C function but disables KASAN
> > (and tracing for good measure) to keep the things simple and avoid
> > unexpected side-effects. This attempts to keep the fix from commit
> > ecc606103837 ("x86/alternatives: Fix int3_emulate_call() selftest stack
> > corruption") without using inline asm.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  arch/x86/kernel/alternative.c | 21 ++++-----------------
> >  1 file changed, 4 insertions(+), 17 deletions(-)
> >
> > diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> > index 6974b5174495..669a23454c09 100644
> > --- a/arch/x86/kernel/alternative.c
> > +++ b/arch/x86/kernel/alternative.c
> > @@ -496,23 +496,10 @@ extern struct paravirt_patch_site __start_parainstructions[],
> >   *
> >   * See entry_{32,64}.S for more details.
> >   */
> > -
> > -/*
> > - * We define the int3_magic() function in assembly to control the calling
> > - * convention such that we can 'call' it from assembly.
> > - */
> > -
> > -extern void int3_magic(unsigned int *ptr); /* defined in asm */
> > -
> > -asm (
> > -"    .pushsection    .init.text, \"ax\", @progbits\n"
> > -"    .type           int3_magic, @function\n"
> > -"int3_magic:\n"
> > -"    movl    $1, (%" _ASM_ARG1 ")\n"
> > -"    ret\n"
> > -"    .size           int3_magic, .-int3_magic\n"
> > -"    .popsection\n"
> > -);
> > +static void __init __no_sanitize_address notrace int3_magic(unsigned int *ptr)
> > +{
> > +     *ptr = 1;
> > +}
>
> I really don't like this. the compiler is free to mess this up in all
> sorts of ways.
>
> The problem is that the call-site does not respect the regular calling
> convention, so calling a regular C function is just asking for trouble,
> which is why it ended up being asm, then we fully control the calling
> convention.

Ack. The problem here is that we can't declare an extern static
function in C. How would you feel about making int3_magic a global
instead to match the C declaration?

Sami
