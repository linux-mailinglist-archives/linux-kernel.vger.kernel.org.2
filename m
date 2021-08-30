Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01EC13FBD33
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 21:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbhH3T6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 15:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbhH3T6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 15:58:49 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BA1C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 12:57:55 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id c206so9815219ybb.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 12:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E4eWYvLXqtDCW55gS9rY1AWkuU5oblAvUHBbE8tFwPM=;
        b=OGS3yhWXTyzWkpkWUMNaVxVTFC+AJsJpa1DFA/leGUMaTbpMJCmekJnDQQ4LplT57V
         jqNNZXj6JX7NOfeLnm+uT5dA0mLCg8pwGj1o0mYZdsP9Quvy5T5hSYvF5qmD9jfroMs2
         qPasNy6wNFNrWWLGUhw/SxSku/7Jy8no4SwyhhtopI+m/AyfB/hgwTGCjSSgtwhu2a7+
         FKUpLNZNgZ/Q5M1oSQsCFw3Sk4FXFmxqPBLJj7j9sNKn1/KD2yYZ732zInXTsWT7lC0T
         FYlAc0L7oTnv1eOt77XImOLWiEKn6m2ZSntrQB+KftmGlZJfZO07ewXz/XnvAxEUIHzY
         vDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E4eWYvLXqtDCW55gS9rY1AWkuU5oblAvUHBbE8tFwPM=;
        b=iFWPiNw/RF9aL4Hzm3w6TBHxLOd1/O3rDuBx8JiXv4gGRgtfiiEQ+ERBny+Gnsdx4F
         wF8dUeoGA/4ouWQYgDkYSy2k3YIHQqQKCbNfvAGiwTvM5NAMjkuiqmyStPVyJeZ+W2CQ
         fmfnG2yWShhLprTnSKfrwdzpbmJ80pnpHhkPgQtyiqty3La+ng3qohZMmNzEbnIY0fA+
         cXe5YBT/Z+OvPa6EfEjGxFPBUsLvokUGYwfTgE9WGHFhMjcY4oAorwh6/Qb8DNk667Ra
         /UBkANHdjFr9MvP0fKUt4YfXxUkr3KaB6NamsIDzqeqeg7SSV7dtHyO65YVmvMvRnK20
         gDBQ==
X-Gm-Message-State: AOAM531bGX1MUN4M88+puH7EMxt4VWKODS3X/P2rbI84XdHcEnrEG7tY
        Rl6Jvi8KjuPYqfmw0RVYN3FoNwBdgPrhYr4JjD2JVA==
X-Google-Smtp-Source: ABdhPJzfPVC/aqfGdEcBrN11+dQpuqIHr6C0XzX81vMefCFwtWvmVxyFoBlwpKAw7HaWmKsQxG3hWFuvfK71fynvpXY=
X-Received: by 2002:a05:6902:703:: with SMTP id k3mr24784014ybt.47.1630353474553;
 Mon, 30 Aug 2021 12:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com>
 <20210823171318.2801096-9-samitolvanen@google.com> <e33bdfc8-6de9-0e91-eec6-39e6aca61758@kernel.org>
In-Reply-To: <e33bdfc8-6de9-0e91-eec6-39e6aca61758@kernel.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 30 Aug 2021 12:57:43 -0700
Message-ID: <CABCJKufsdcfdSQ4JMx1dw1HXgqk4rtqGRoHMUdK6r5cxzrEg3Q@mail.gmail.com>
Subject: Re: [PATCH v2 08/14] x86/extable: Do not mark exception callback as CFI
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
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

On Thu, Aug 26, 2021 at 9:56 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> On 8/23/21 10:13 AM, Sami Tolvanen wrote:
> > From: Kees Cook <keescook@chromium.org>
> >
> > The exception table entries are constructed out of a relative offset
> > and point to the actual function, not the CFI table entry. For now,
> > just mark the caller as not checking CFI
>
> Does this *mark* the caller as not checking CFI or does it actually make
> the caller stop checking CFI?  What are the semantics of a __nocfi function?

__nocfi disables CFI checking in the function, so in this case,
fixup_exception can make an indirect call anywhere.

> > The failure is most visible
> > at boot with CONFIG_DEBUG_RODATA_TEST=y.
>
> What's the failure?
>
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  arch/x86/mm/extable.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
> > index e1664e9f969c..d150d4d12d53 100644
> > --- a/arch/x86/mm/extable.c
> > +++ b/arch/x86/mm/extable.c
> > @@ -155,6 +155,7 @@ enum handler_type ex_get_fault_handler_type(unsigned long ip)
> >               return EX_HANDLER_OTHER;
> >  }
> >
> > +__nocfi
> >  int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
> >                   unsigned long fault_addr)
> >  {
> >
>
>
> This at least needs a comment explaining what's going on.  But maybe it
> could be fixed better by either having the extable entry resolve to the
> magic CFI table entry (can this be done?) or by marking the actual
> indirect call or the type of the variable through which the call is done
> as being a non-CFI call.

We can avoid the __nocfi here by marking the handlers __cficanonical.
This attribute tells the compiler to rename the function and point the
original name to the CFI jump table, which allows addresses taken in
assembly code to also pass CFI checking. I'll change this in v3.

Sami
