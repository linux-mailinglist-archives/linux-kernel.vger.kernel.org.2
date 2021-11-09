Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEEF44B2E9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 19:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242814AbhKIS4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 13:56:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:34058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242281AbhKIS4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 13:56:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 909C761186
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 18:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636484025;
        bh=Y6c/hx60BYko/6uBMRAlqIid7080OuuDa8DpIJcy+Mk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BrApohIglM+je7NbAJKPCZtL3ovKPtXW/AulRdzNDQXCKP8hsbYOrr09GNlkzqcvr
         kqPm4nyAwVCaCNQwtHMFQ6+lHPwqKKAYIULz0k0ixAHnvuYDDqaQ51XD/n5aBVfV0h
         9cHWL04qggQLLT2Oupbs6w7AGrO7/X4261rrao7cXPaHgRkq6P5DKXQELfsaImG+6v
         e9L7+kyoOD9cVkCPvXuzrEjyKBO9/EcH9eG6XYfW+n7+Y/Uoq1jr8DVOIoe4UZYiNY
         tioCAZycM46SABpFR++HhPCiQm/hSNTtk9rQOwzi+FRWglXKzDwSk/HuyzEdyH6Jzj
         kZHR0rjlAxuVg==
Received: by mail-oi1-f169.google.com with SMTP id q124so452056oig.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 10:53:45 -0800 (PST)
X-Gm-Message-State: AOAM531+kLwUjcS8NEe+K01KQ147LGVRvgHBH0smo7sFcyVkSL7FgIv5
        /HsZi5PImv7auq2yCK0qXN2lJ4I3aJwgf9Zs9mE=
X-Google-Smtp-Source: ABdhPJwwoYteUDUAaHG47HrIgd5Ci8KXvfRhQ45VBK9DFgqHm1A/5mmyOXoz2lbuN+VI/5vxMfIcfpnmfNxpIDitUvs=
X-Received: by 2002:a05:6808:1919:: with SMTP id bf25mr7795460oib.33.1636484024839;
 Tue, 09 Nov 2021 10:53:44 -0800 (PST)
MIME-Version: 1.0
References: <20211109164549.1724710-1-ardb@kernel.org> <20211109164549.1724710-3-ardb@kernel.org>
 <YYrCn3mc+EbY+OB/@hirez.programming.kicks-ass.net>
In-Reply-To: <YYrCn3mc+EbY+OB/@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 9 Nov 2021 19:53:33 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHArfyvZ-b11vLshpj84drDtuU+T_o+h+cWqhtajpon0A@mail.gmail.com>
Message-ID: <CAMj1kXHArfyvZ-b11vLshpj84drDtuU+T_o+h+cWqhtajpon0A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/7] static_call: deal with unexported keys without
 cluttering up the API
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Nov 2021 at 19:49, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Nov 09, 2021 at 05:45:44PM +0100, Ard Biesheuvel wrote:
>
> > diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
> > index 5a00b8b2cf9f..0bb36294cce7 100644
> > --- a/include/linux/static_call_types.h
> > +++ b/include/linux/static_call_types.h
> > @@ -32,15 +32,20 @@
> >  struct static_call_site {
> >       s32 addr;
> >       s32 key;
> > +     s32 tramp;
> >  };
>
> I can't say I'm thrilled at growing this thing, but the cleanup is nice.
> Perhaps we can increase alignment on struct static_call_key and instead
> frob it in .key still?
>

This is already a place-relative field, and one points into the data
section and the other into text. So I don't see how we can squeeze
enough bits out of it to make this fit.

> >
> >  #define DECLARE_STATIC_CALL(name, func)                                      \
> > -     extern struct static_call_key STATIC_CALL_KEY(name);            \
> > +     extern __weak struct static_call_key STATIC_CALL_KEY(name);     \
> >       extern typeof(func) STATIC_CALL_TRAMP(name);
>
> I'm a little bit confused on how this actually works. What does a __weak
> extern data symbol do?
>
> A __weak function definition would create a module local instance of the
> function barring a strong override.
>
> But what does a __weak extern do?
>

It is simply a reference that is permitted to remain undefined.

That is why (in another patch) I do sth like

extern __weak foo;

if (&foo)
  ... use foo
else
   ... use sth else


> > diff --git a/kernel/static_call.c b/kernel/static_call.c
> > index 43ba0b1e0edb..360cc3cd0fbf 100644
> > --- a/kernel/static_call.c
> > +++ b/kernel/static_call.c
> > @@ -366,18 +366,18 @@ static int static_call_add_module(struct module *mod)
> >                * means modules are allowed to call static_call_update() on
> >                * it.
> >                *
> > -              * Otherwise, the key isn't exported, and 'addr' points to the
> > +              * Otherwise, the key isn't exported, and 'tramp' points to the
> >                * trampoline so we need to lookup the key.
> >                *
> >                * We go through this dance to prevent crazy modules from
> >                * abusing sensitive static calls.
> >                */
> > -             if (!kernel_text_address(addr))
> > +             if (addr)
> >                       continue;
>
> This seems to imply that the __weak extern symbol gets resolved to 0 at
> module link time.
>

Yes, if the referenced symbol is not exported, it just uses 0x0 for its value.

> >
> > -             key = tramp_key_lookup(addr);
> > +             key = tramp_key_lookup((unsigned long)offset_to_ptr(&site->tramp));
> >               if (!key) {
> > -                     pr_warn("Failed to fixup __raw_static_call() usage at: %ps\n",
> > +                     pr_warn("Failed to fixup static_call() usage at: %ps\n",
> >                               static_call_addr(site));
> >                       return -EINVAL;
>
> >               }
