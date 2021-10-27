Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974E243CF7D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 19:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243193AbhJ0RN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 13:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239755AbhJ0RNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 13:13:55 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6B2C061745
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 10:11:30 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t5-20020a17090a4e4500b001a0a284fcc2so5671532pjl.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 10:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SPqzlmEweI7r1mGXnYdr5XuSqmGXW0SkyZAuxP8LyMQ=;
        b=TxzOqOdAm06wISQQDG9AUQtMp6CPyx+4EqB3sWwvACs6OPGjSg0kvIFotrs3f5Hr/g
         36y0FvkG5ulwsPM+LeYfBGcFyNbRXJWvHyVi0cqnMkMIdWKizVF1QhDWJMEjCdnBnbJu
         Qbar4HPvzJ08E92cM3uqXKFxfn33qSa2sqNMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SPqzlmEweI7r1mGXnYdr5XuSqmGXW0SkyZAuxP8LyMQ=;
        b=Bf5KYcO0t3lUrGh6Or4N9cDC0cn8VoFdK6cNTtFja2t/VAMc0thwmV6ua3U8i41zYK
         yrEZw+uNp2oN8G2AtxEk029j1fk07x4fJQs/NVa6y9VrvKHmQuby2snj628f0OSE5LUx
         JekjW+y+6wVr6dR4Lj7Z5HocrF1XlONKJvG2U5gWeLzv27nAYq1RIl7gI66XTkJWRCAD
         9cld1abJa0HU1lCIFq31/r27YBY4cT3YfuFyL7mNgEBdC1eOidej4NxqZwlD50Qo8IId
         PQOxGApV01JfsBiUmlGg43ZOAj2c5Ar+liYBUzoZJsbIxw+OIIeYvQ0cpYinnCrjomIQ
         Wyng==
X-Gm-Message-State: AOAM530faIcNL5yIVQbnZIBfmkCxJuJSDg817m8cMBJfOZx6nnDhyPWq
        1c5PHoeP6Fre4ITfYnRsGZOztVNnlL59/A==
X-Google-Smtp-Source: ABdhPJwgWDIYDf0NpCmMyVHgq1qs37SgEq9KpumyZm5ASVCwSt/ixYZxeJ6+qsDmxHYqkOsI+ohUzg==
X-Received: by 2002:a17:90b:17d2:: with SMTP id me18mr6983821pjb.98.1635354689817;
        Wed, 27 Oct 2021 10:11:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lb5sm315185pjb.11.2021.10.27.10.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 10:11:29 -0700 (PDT)
Date:   Wed, 27 Oct 2021 10:11:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 00/15] x86: Add support for Clang CFI
Message-ID: <202110270939.F5C79CC@keescook>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211026201622.GG174703@worktop.programming.kicks-ass.net>
 <20211027120515.GC54628@C02TD0UTHF1T.local>
 <CAMj1kXEx10gC8eH7rV-GbZZj2M3uDue6HYsKb+A5J01zOxm_FA@mail.gmail.com>
 <20211027124852.GK174703@worktop.programming.kicks-ass.net>
 <YXlOd1lyKZKAcJfA@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXlOd1lyKZKAcJfA@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 03:04:55PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 27, 2021 at 02:48:52PM +0200, Peter Zijlstra wrote:
> > On Wed, Oct 27, 2021 at 02:22:27PM +0200, Ard Biesheuvel wrote:
> > > On Wed, 27 Oct 2021 at 14:05, Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > > > > Should not this jump-table thingy get converted to an actual function
> > > > > address somewhere around arch_static_call_transform() ? This also seems
> > > > > relevant for arm64 (which already has CLANG_CFI supported) given:
> > > > >
> > > > >   https://lkml.kernel.org/r/20211025122102.46089-3-frederic@kernel.org
> > > >
> > > > Ugh, yeah, we'll need to do the function_nocfi() dance somewhere...
> > > >
> > > 
> > > Sadly, that only works on symbol names, so we cannot use it to strip
> > > CFI-ness from void *func arguments passed into the static call API,
> > > unfortunately.
> > 
> > Right, and while mostly static_call_update() is used, whcih is a macro
> > and could possibly be used to wrap this, we very much rely on
> > __static_call_update() also working without that wrapper and then we're
> > up a creek without no paddles.
> 
> Specifically, we support code like:
> 
> struct foo {
> 	void (*func1)(args1);
> 	void (*func2)(args2);
> }
> 
> struct foo global_foo;

And global_foo is intentionally non-const?

> 
> ...
> 
> DEFINE_STATIC_CALL_NULL(func1, *global_foo.func1);
> 
> ...
> 
> __init foo_init()
> {
> 	// whatever code that fills out foo
> 
> 	static_call_update(func1, global_foo.func1);
> }
> 
> ...
> 
> hot_function()
> {
> 	...
> 	static_cal(func1)(args1);
> 	...
> }
> 
> cold_function()
> {
> 	...
> 	global_foo->func1(args1);
> 	...
> }

If global_foo is non-const, then the static call stuff is just an
obfuscated indirect call. The attack CFI attempts to block is having
a controlled write flaw turn into controlled execution. For example,
in the above, an attacker would use a flaw that could aim a write to
global_foo->func1, and then get the kernel to take an execution path
that executes global_foo->func1 (i.e. through cold_function).

If static_call_update() accepts an arbitrary function argument, then it
needs to perform the same validation that is currently being injected
at indirect call sites to avoid having static calls weaken CFI. If
things are left alone, static calls will just insert a direct call to
the jump table, and things "work" (with an extra jump), but nothing
is actually protected (it just requires the attacker locate a more
narrow set of kernel call flows that includes static_call_update). Any
attacker write to global_foo->func1, followed by a static_call_update(),
will create a direct call (with no CFI checking) to the attacker's
destination. (It's likely harder to find the needed execution path to
induce a static_call_update(), but that shouldn't stop us from trying
to protect it.)

Getting a "jump table to actual function" primitive only avoids the added
jump -- all the CFI checking remains bypassed. If static call function
address storage isn't const, for CFI to work as expected the update()
routine will need to do the same checking that is done at indirect call
sites when extracting the "real" function for writing into a direct call.
(i.e. it will need to be function prototype aware, be able to find the
real matching jump table and size, and verify the given function is
actually in the table. Just dereferencing the jump table to find the
address isn't a protection: the attacker just has to write to func1 with
a pointer to an attacker-constructed jump table.)

I think it's not unreasonable to solve this in phases, though. Given that
static calls work with CFI as-is (albeit with an extra jump), and that
static calls do offer some hardening of existing indirect call targets (by
narrowing the execution path needed to actually bring the func1 value into
the kernel execution flow), I don't see either feature blocking the other.

Adding proper CFI function prototype checking to static calls seems
like a security improvement with or without CFI, and a minor performance
improvement under CFI.

To avoid all of this, though, it'd be better if static calls only
switched between one of a per-site const list of possible functions,
which would make it a much tighter hand-rolled CFI system itself. :)
(i.e. it would operate from a specific and short list of expected
functions rather than the "best effort" approach of matching function
prototypes as done by Clang CFI.)

-- 
Kees Cook
