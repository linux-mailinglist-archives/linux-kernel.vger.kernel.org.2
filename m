Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B6544B2CB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 19:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242544AbhKISoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 13:44:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:59166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238608AbhKISoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 13:44:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4552861181
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 18:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636483275;
        bh=KLG2E+BwCMYq+3yzwEato8H/I2GlZKSMT5NJJfj0uoo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cvDVsO+qm1CiBGa4jyMNmLXadK1qAcw5Qv9cOC0JElP3ugA1s8Nkj0YreVKx86UTW
         Vu0TPt2FPudqAKOfJ0sdRR68OwshfyY1OghkVwRkN+A85VXWM7XRn1OQUez6oiJkvQ
         9FWltgpQGD/1hnaadG3QfA2nxY8qM4BLYKfZG7TOI0SZU5Izi1Lpe1c3LRSGJjIZph
         Yj11D4jr64kzUrJWTX4dGc0JACiHicYvwMkUju1zZRSVm85f6H7HsPkHyWk7KafFAP
         KRffyiswbX9NzHmo1rM3G3XBt2jWcncTe91Qxzq/zCO5O/xsA7UryNkgx3htVQunMe
         rk5igvbmwZa5Q==
Received: by mail-ot1-f53.google.com with SMTP id h16-20020a9d7990000000b0055c7ae44dd2so21519otm.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 10:41:15 -0800 (PST)
X-Gm-Message-State: AOAM532Vc3cJCvUYbJXcO9xPxbW2dlaiFs9v+FL/iP9h8NInPTPw1X/h
        sjBW933wbr5EVi8/26gAVqO8xI90KVUFLT8x7rs=
X-Google-Smtp-Source: ABdhPJyOsO9WSB6zSlqUnZq9wXPk8D+A1q6rpTg+mUMsz4cl+fhGGDMeZiiqxWkPYAC8c1n52JEZ6vJSuWMFcXvY5hM=
X-Received: by 2002:a9d:830:: with SMTP id 45mr8046039oty.112.1636483274561;
 Tue, 09 Nov 2021 10:41:14 -0800 (PST)
MIME-Version: 1.0
References: <20211109164549.1724710-1-ardb@kernel.org> <20211109164549.1724710-2-ardb@kernel.org>
 <YYrAHMy8xmPXj4ql@hirez.programming.kicks-ass.net>
In-Reply-To: <YYrAHMy8xmPXj4ql@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 9 Nov 2021 19:41:03 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGdqDQ-WKLBcLhGNofmXpf-Xt8wAE18EBEGeTe9wNqZog@mail.gmail.com>
Message-ID: <CAMj1kXGdqDQ-WKLBcLhGNofmXpf-Xt8wAE18EBEGeTe9wNqZog@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] static_call: get rid of static_call_cond()
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

On Tue, 9 Nov 2021 at 19:38, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Nov 09, 2021 at 05:45:43PM +0100, Ard Biesheuvel wrote:
> > The main reason for the existence of static_call_cond() seems to be that
> > in theory, when using the generic implementation of static calls, it may
> > be possible for a compiler to elide the indirect call entirely if the
> > target is NULL, while still guaranteeing that all side effects of
> > argument evaluation occur as expected.
> >
> > This is rather optimistic: as documented by an existing code comment,
> > both GCC and Clang (version 10) get this wrong, and even if they ever
> > get it right, this is far too subtle to rely on for a code path that is
> > expected to be used only by the 'remaining' architectures once all the
> > best supported ones implement either the out-of-line or inline optimized
> > variety of static calls.
> >
> > Given that having static_call_cond() clutters up the API, and puts the
> > burden on the caller to go and check what kind of static call they are
> > dealing with, let's just get rid of the distinction.
>
> No, static_call_cond() signifies the function can be NULL. Both gcc and
> clang generate correct (but wildly ineffecient) code for this. Without
> static_call_cond() the generic implementation will do a NULL deref.
>
> That is, static_call_cond() does properly encapuslate:
>
>         func = READ_ONCE(key.func);
>         if (func)
>                 func(ARGS);
>
> You can't take that out.

I actually address that in the patch.

AIUI, the compiler generates an indirect call to __static_call_nop(),
right? So why not simply set .func to the address of
__static_call_nop() when NULL is passed to update / the initializer?
