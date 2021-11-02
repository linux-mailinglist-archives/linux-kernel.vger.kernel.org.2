Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0633744395E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 00:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhKBXQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 19:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhKBXQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 19:16:19 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72F1C061203
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 16:13:43 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id om14so3703pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 16:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=P+2+2UdacnJO8z2gt7JNQevIZ7/zHOIbjdcX/ZBVveI=;
        b=lgR2cuLgCR4lsnMcKa5/kRHJGyL9RcyTh8lWCzb6l5B7J43Ohko3pMqDCtq22C/bG8
         dtsv8BM1VWh4Dhhwh0Q66ubwzL74ipZRvCocAdTXcNrsnf7v72Qj7RHYvFQXamm4Qo19
         BCGiybyyrG2bAU2KHs12f5a4T+/hPFkq9MLyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=P+2+2UdacnJO8z2gt7JNQevIZ7/zHOIbjdcX/ZBVveI=;
        b=D7IpT+fF79iDkO3tgIfFJrVO8LNpn8NzxmnIYI2KXyTqLMEUoWDrqqrHvDxIOwqGSp
         Vc5/5QQJpAUNChqbIj2090WOcvXF31euw8buYF9Z6wvbV2Vhbs5gAyweyQmLATIKAiqR
         OoMpsDOY1pZiHIIF7riIQOiPeru5RY562pj0Y86ky06AnWckQIEat8Xjv2Cdv+j0QIGH
         O69gleH+GAEHH2kNK8c1yOuMn5qRLZo51OMbwomne7BfZrzklmKAFAPKGJwlnu10XoPi
         lXkH/+kvQGi4JBqcADzdtzpTwBD9J6UkS0B0WqwHKCdEMJB4gEbRv6/a+tm1uAhiXoX3
         zPwQ==
X-Gm-Message-State: AOAM530NtoVPe1ElPcqd5cafuTc9nEnTqXpx3bNC/6Wg+L7pE8Zsmd0P
        +8eiFvL6b3xIXmOIZsebqcgJAg==
X-Google-Smtp-Source: ABdhPJxr0e0Fp31b+VAcq4pO1Ru/YiQ6pPiXr8HihnrV8pmpy7HItFuviWR41n/H96NqPboZ4yuozg==
X-Received: by 2002:a17:90b:4b4e:: with SMTP id mi14mr10536981pjb.6.1635894822717;
        Tue, 02 Nov 2021 16:13:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z73sm143841pgz.23.2021.11.02.16.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 16:13:42 -0700 (PDT)
Date:   Tue, 2 Nov 2021 16:13:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH] static_call,x86: Robustify trampoline patching
Message-ID: <202111021603.EDE5780FE@keescook>
References: <CAMj1kXHk5vbrT49yRCivX3phrEkN6Xbb+g8WEmavL_d1iE0OxQ@mail.gmail.com>
 <YX74Ch9/DtvYxzh/@hirez.programming.kicks-ass.net>
 <CAMj1kXG+MuGaG3BHk8pnE1MKVmRf5E+nRNoFMHxOA1y84eGikg@mail.gmail.com>
 <YX8AQJqyB+H3PF1d@hirez.programming.kicks-ass.net>
 <CAMj1kXF3n-oQ1WP8=asb60K6UjSYOtz5RVhrcoCoNq3v7mZdQg@mail.gmail.com>
 <20211101090155.GW174703@worktop.programming.kicks-ass.net>
 <CAMj1kXGhRmdM3om289Q2-s1Pzfob3D2iSDMorzggfhSk1oj53A@mail.gmail.com>
 <YYE1yPClPMHvyvIt@hirez.programming.kicks-ass.net>
 <202111021040.6570189A5@keescook>
 <90a14299-ce56-41d5-9df9-f625aae1ac70@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90a14299-ce56-41d5-9df9-f625aae1ac70@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 02:02:38PM -0700, Andy Lutomirski wrote:
> 
> 
> On Tue, Nov 2, 2021, at 11:10 AM, Kees Cook wrote:
> > On Tue, Nov 02, 2021 at 01:57:44PM +0100, Peter Zijlstra wrote:
> >> On Mon, Nov 01, 2021 at 03:14:41PM +0100, Ard Biesheuvel wrote:
> >> > On Mon, 1 Nov 2021 at 10:05, Peter Zijlstra <peterz@infradead.org> wrote:
> >> 
> >> > > How is that not true for the jump table approach? Like I showed earlier,
> >> > > it is *trivial* to reconstruct the actual function pointer from a
> >> > > jump-table entry pointer.
> >> > >
> >> > 
> >> > That is not the point. The point is that Clang instruments every
> >> > indirect call that it emits, to check whether the type of the jump
> >> > table entry it is about to call matches the type of the caller. IOW,
> >> > the indirect calls can only branch into jump tables, and all jump
> >> > table entries in a table each branch to the start of some function of
> >> > the same type.
> >> > 
> >> > So the only thing you could achieve by adding or subtracting a
> >> > constant value from the indirect call address is either calling
> >> > another function of the same type (if you are hitting another entry in
> >> > the same table), or failing the CFI type check.
> >> 
> >> Ah, I see, so the call-site needs to have a branch around the indirect
> >> call instruction.
> >> 
> >> > Instrumenting the callee only needs something like BTI, and a
> >> > consistent use of the landing pads to ensure that you cannot trivially
> >> > omit the check by landing right after it.
> >> 
> >> That does bring up another point tho; how are we going to do a kernel
> >> that's optimal for both software CFI and hardware aided CFI?
> >> 
> >> All questions that need answering I think.
> >
> > I'm totally fine with designing a new CFI for a future option,
> > but blocking the existing (working) one does not best serve our end
> > users. 
> 
> I like security, but I also like building working systems, and I think
> I disagree with you. There are a whole bunch of CFI schemes out there,
> with varying hardware requirements, and they provide varying degrees
> of fine grained protection and varying degrees of protection against
> improper speculation.  We do not want to merge clang CFI just because
> it’s “ready” and end up with a mess that makes it harder to support
> other schemes in the kernel.

Right, and I see the difficulties here. And speaking to Peter's
observation that CFI "accidentally" worked with static_calls, I don't
see it that way: it worked because it was designed to be as "invisible"
as possible. It's just that at a certain point of extreme binary output
control, it becomes an issue and I think that's going to be true for
*any* CFI system: they each will have different design characteristics.

One of the goals of the Clang CFI use in Linux was to make it as
minimally invasive as possible (and you can see this guiding Sami's
choices: e.g. he didn't go change all the opaque address uses to need a
"&" prefix added, etc). I think we're always going to have some
push/pull between the compiler's "general"ness and the kernel's
"specific"ness.

> So, yes, a good CFI scheme needs caller-side protection, especially if
> IBT isn’t in use.  But a good CFI scheme also needs to interoperate with
> the rest of the kernel, and this whole “canonical” and symbol-based
> lookup and static_call thing is nonsense.  I think we need a better
> implementation, whether it uses intrinsics or little C helpers or
> whatever.

I think we're very close already. Like I said, I think it's fine to nail
down some of these interoperability requirements; we've been doing it
all along. We got there with arm64, and it looks to me like we're almost
there on x86. There is this particular case with static_calls now, but I
don't think it's insurmountable.

> I’m not saying this needs to be incompatible with current clang
> releases, but I do think we need a clear story for how operations like
> static call patching are supposed to work.

Right -- and until very recently, it did all Just Work. I think we'll
always have these kinds of issues with whatever CFI implementations are
made available, and since we've already cleaned up so much of what's
needed to make the kernel work with *any* CFI, it makes sense to
continue with the one we've already got working for arm64.

> FYI, Ard, many years ago we merged kernel support for the original
> gcc stack protector. We have since *removed* it on x86_32 in favor of
> a nicer implementation that requires a newer toolchain.

Sure, and this is the kind of thing I mean: we had an awkward
implementation of a meaningful defense, and we improved on it. I think
it's important to be able to make these kinds of concessions to gain the
defensive features they provide. And yes, we can continue to improve it,
but in the meantime, we can stop entire classes of problems from
happening to our user base.

-- 
Kees Cook
