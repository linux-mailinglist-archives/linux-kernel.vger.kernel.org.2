Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC7944B2EA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 19:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242825AbhKIS5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 13:57:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:34372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242481AbhKIS5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 13:57:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DCE9611AF
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 18:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636484075;
        bh=PhYXgD2L6/ysPXkKNuVrDzH7xz+6jYYzXhmSA6THCdo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pDF/ngHAkWReWpzVv+qvNEwQQIDqLJpoHHrroVwA5QDck58B1+Eak2fSfvsYwJ4n+
         wnPQwlLoHelNhodWC+if2iwutHdmWwd+vW8Q0KTm7klURSjSGXucttd3Pq/ou3akra
         K36j8xSNavwCaCZDp2xpMyBmB08vaKnG4L5EGwM/Sy4+d64xKfnZLF9Ccg4jitekAJ
         Ha4ww/MHkxmHKLpg4RqEIgjQv+TGN0d7EkoCLBU576EIPHLEzanv/1GdNbce0iiZ81
         VYed0+gdn2K/tzzTKT2ENKl3uAULQvzXruPPV4+qrF4R4Ar7iY6zkh1Qa+85bmzGFl
         Bjwmhrdul2i1A==
Received: by mail-ot1-f47.google.com with SMTP id o15-20020a9d410f000000b0055c942cc7a0so96663ote.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 10:54:35 -0800 (PST)
X-Gm-Message-State: AOAM530MN++JS2LlPaVdNJx2zCEPemA4BUEWLiWynr+P2YyKvS/O9Ty6
        k2fWR+5H7kXGAnI9pCCQudBwbOfFV68RFwodklk=
X-Google-Smtp-Source: ABdhPJyLjEEx35kPxpN0wXWFAk7hWFSgVnImVJYrPLWmZr/7OFq2573eFP3NNR4g1u7+/fOzvNz0zv2h05VI/vZ1SOQ=
X-Received: by 2002:a05:6830:1514:: with SMTP id k20mr7667802otp.147.1636484074714;
 Tue, 09 Nov 2021 10:54:34 -0800 (PST)
MIME-Version: 1.0
References: <20211109164549.1724710-1-ardb@kernel.org> <20211109164549.1724710-4-ardb@kernel.org>
 <YYrDkUsJVcOzxMPL@hirez.programming.kicks-ass.net>
In-Reply-To: <YYrDkUsJVcOzxMPL@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 9 Nov 2021 19:54:23 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEW72y1p-qR+X6EBqM8Rf5+fZnEs2WSSz7b+eU=zvPt6w@mail.gmail.com>
Message-ID: <CAMj1kXEW72y1p-qR+X6EBqM8Rf5+fZnEs2WSSz7b+eU=zvPt6w@mail.gmail.com>
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

On Tue, 9 Nov 2021 at 19:53, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Nov 09, 2021 at 05:45:45PM +0100, Ard Biesheuvel wrote:
> > @@ -196,13 +190,21 @@ extern long __static_call_return0(void);
> >       EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));                       \
> >       EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
> >
> > +#define EXPORT_STATIC_CALL_GETKEY_HELPER(name)                               \
> > +     struct static_call_key *STATIC_CALL_GETKEY(name)(void) {        \
> > +             BUG_ON(!core_kernel_text(                               \
> > +                     (unsigned long)__builtin_return_address(0)));   \
> > +             return &STATIC_CALL_KEY(name);                          \
> > +     }                                                               \
> > +     EXPORT_SYMBOL_GPL(STATIC_CALL_GETKEY(name))
>
> So if I were a nevarious module, I would look up the above symbol from
> kallsyms (it is exported and easily obtainable) and then simply
> read the text to discover the key address and we're in business.
>

Yeah I realised that. So would you prefer to have a
.static_call_tramp_key section in each module and look up the keys in
the module loader?
