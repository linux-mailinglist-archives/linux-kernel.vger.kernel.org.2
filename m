Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D050444B37C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 20:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243889AbhKITsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 14:48:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:51116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236838AbhKITsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 14:48:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EA6561175
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 19:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636487154;
        bh=kDbcn4XPz7+SxL3CpEYOVVAgG/CoYcLmCTIoRUpFe04=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gt4oCqruPrgOy+Iv6k8PoDH3xzZdi6ylRen92P6AMJyy0hV0aChuWz/sO/ot9ZASw
         7S7u5Lj+sO9BvNiKCqxkAZEr2ry9I9cp1UCsmqHUBqpXZzWalfbFx9DHz8bFq+wJwm
         ZQg3WhoRREdcuIQcFGMCbiqjySLwrIxSOkDD+Bps5Pu+u6HIhjOLhAkjsjz6M0Y5VK
         p2btjOKooZqgzDG6+UHo7Ob2Tg5SRsI6op7OwEeQki3v9NDs4kJesI0a56NBZdKefp
         4i2+TuwzZXkmn8h9mbfBvx+dS+DV7NkgA4OTOfEMTgmmxA/mh+rYvpaqM5C7d1rYri
         aWSDBP7fsHagg==
Received: by mail-ot1-f41.google.com with SMTP id g91-20020a9d12e4000000b0055ae68cfc3dso303699otg.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 11:45:54 -0800 (PST)
X-Gm-Message-State: AOAM532CBkk1yFxSP35TNlhimr1hsnpshbtPhsNdR+rY37JOn9AoHAC1
        TSfLlj4b2OlTD3Nuso1229/k6xfRIbRvhVA2Fy4=
X-Google-Smtp-Source: ABdhPJyfXHToQssIz57Hcc9Se7+G7+XiUbjFMWhc7LJ9nhQCqIgg7ckkV9fpJbCjbt0BuI/ufQTiYMx/VBxif/8bsn4=
X-Received: by 2002:a05:6830:1445:: with SMTP id w5mr299561otp.112.1636487153833;
 Tue, 09 Nov 2021 11:45:53 -0800 (PST)
MIME-Version: 1.0
References: <20211109164549.1724710-1-ardb@kernel.org> <20211109164549.1724710-4-ardb@kernel.org>
 <YYrDkUsJVcOzxMPL@hirez.programming.kicks-ass.net> <CAMj1kXEW72y1p-qR+X6EBqM8Rf5+fZnEs2WSSz7b+eU=zvPt6w@mail.gmail.com>
 <YYrPJXlyQV5pXPHt@hirez.programming.kicks-ass.net>
In-Reply-To: <YYrPJXlyQV5pXPHt@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 9 Nov 2021 20:45:42 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHERUa=btvKfaM7JwXmQM=9+XCtHShHuWBQKiV5V9Qidg@mail.gmail.com>
Message-ID: <CAMj1kXHERUa=btvKfaM7JwXmQM=9+XCtHShHuWBQKiV5V9Qidg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] static_call: use helper to access non-exported key
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

On Tue, 9 Nov 2021 at 20:42, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Nov 09, 2021 at 07:54:23PM +0100, Ard Biesheuvel wrote:
> > On Tue, 9 Nov 2021 at 19:53, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, Nov 09, 2021 at 05:45:45PM +0100, Ard Biesheuvel wrote:
> > > > @@ -196,13 +190,21 @@ extern long __static_call_return0(void);
> > > >       EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));                       \
> > > >       EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
> > > >
> > > > +#define EXPORT_STATIC_CALL_GETKEY_HELPER(name)                               \
> > > > +     struct static_call_key *STATIC_CALL_GETKEY(name)(void) {        \
> > > > +             BUG_ON(!core_kernel_text(                               \
> > > > +                     (unsigned long)__builtin_return_address(0)));   \
> > > > +             return &STATIC_CALL_KEY(name);                          \
> > > > +     }                                                               \
> > > > +     EXPORT_SYMBOL_GPL(STATIC_CALL_GETKEY(name))
> > >
> > > So if I were a nevarious module, I would look up the above symbol from
> > > kallsyms (it is exported and easily obtainable) and then simply
> > > read the text to discover the key address and we're in business.
> > >
> >
> > Yeah I realised that. So would you prefer to have a
> > .static_call_tramp_key section in each module and look up the keys in
> > the module loader?
>
> Think so... do you actually have a need for this?

Well, not exactly. But the XOR patch I sent earlier today does cover
this use case, and would be broken if we implemented inline static
calls on arm64.

So the easy fix is to allow EXPORT_STATIC_CALL_RO() only from the core
kernel, and require EXPORT_STATIC_CALL_RW() otherwise. That way, this
can never end up being used in a way that breaks at runtime. Would you
prefer doing that instead?
