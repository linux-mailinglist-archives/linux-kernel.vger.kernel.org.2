Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBD8433ABC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhJSPjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhJSPjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:39:39 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E88C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:37:27 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id u32so4502927ybd.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w917/ktKM6on+Bvbrc+xV7eLa3jb4j+37w1OXONaj5Y=;
        b=bsbUOWaC6VkS+nsJIyycc97utc/SYrz1j/Zbj59OaziG59gHXiDhWfy+G2OSHftSaw
         HK+5xUt/stHksZf/PyONXON64duAOC2m6VEMFpUIE8hmbAMpcVkPM5B/hB+fsMTnnRqH
         ZR71FU1LKlwz/UfEDt+YHA7Hpz/MF5XK10eu0169KpCicw+CgHkZNr5gR60acKKrqzCT
         mx73V2sN8B2gunZi/oNXFCPN6Sk5KNM6TOlKC9e5NywvxUPLmgQuxvPDn+KgZX/nf8Uq
         iLOJ+M46fgXrXlbpFsuG7raLgoepqw8b06tRjFUlzwtQxouUupoqcZJpAHpW+N+2f6nt
         dowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w917/ktKM6on+Bvbrc+xV7eLa3jb4j+37w1OXONaj5Y=;
        b=SC0bnc1NLEU0V4nw9kdcslgYJEX3sXSpL4fJPiEyzFxkUIHtAbVlhXj3TqJHYPCMFB
         wRISPEo06kuVr6h6b5AGJk1s/J+zw84jJfcRzc+p53gJEhhcZOT6Oia2Ofj/tdaIa+Vs
         36UWieE9K2KkB3VqNICkVm3gdsbUOHtbeE226aw9RsFElmVAkSvrUsM19kY1jAVwAhqU
         Dzp1Vh63LUET6dqE1sxBrOSCbTGTwEg2l21OJvBAZOtD0PKuojEUopuK7+ngQrgUPhcf
         D77OWDPKp3xuwynaPnQxFlvjj6mNsjLJgp9KxsudA5Ttb2GciFitF1GoqXXuJ5PJqC8D
         Xd+w==
X-Gm-Message-State: AOAM531mDIW+ixPJI5vuo7C6vFPXGAittpc2f1jEryHSiow6qUKNVz0v
        /SqmyUvlwjlkbSCJrsy5m3wJ5Au6HJuRHYvA5q3blw==
X-Google-Smtp-Source: ABdhPJwxlv1kVXX4PG6NP2Cc/UTRqFNz7VUqkUW2TEwg3Zfg24E9F5i02Q5sl9F9cS+0FZQws6tWeiPbKr8pWs/5Cgc=
X-Received: by 2002:a25:8b8b:: with SMTP id j11mr39111241ybl.160.1634657845863;
 Tue, 19 Oct 2021 08:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211013122217.304265366@infradead.org> <20211013123645.002402102@infradead.org>
 <YWmPCF+g+sF4+ieh@zn.tnic> <20211015165635.GH174703@worktop.programming.kicks-ass.net>
 <20211018225905.86034-1-alobakin@pm.me> <20211019001845.85256-1-alobakin@pm.me>
 <20211019094038.80569-1-alobakin@pm.me> <YW6a67fGzM2AyHot@hirez.programming.kicks-ass.net>
In-Reply-To: <YW6a67fGzM2AyHot@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 19 Oct 2021 08:37:14 -0700
Message-ID: <CABCJKudtYwFtYPAES_Y1uU1TYrApf0D054H8soJo2J_Mx51wkg@mail.gmail.com>
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Lobakin <alobakin@pm.me>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        andrew.cooper3@citrix.com, LKML <linux-kernel@vger.kernel.org>,
        alexei.starovoitov@gmail.com,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 3:17 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> + Sami
>
> (Sami, for context:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=objtool/core
>
> which contains the following code:
>
> +       void (*target)(void);
> +       int reg, i = 0;
> +
> +       target = addr + insn->length + insn->immediate.value;
> +       reg = (target - &__x86_indirect_thunk_rax) /
> +             (&__x86_indirect_thunk_rcx - &__x86_indirect_thunk_rax);
> +
> +       if (WARN_ON_ONCE(reg & ~0xf))
> +               return -1;
>
> which blows up something fierce on clang-cfi)
>
> On Tue, Oct 19, 2021 at 09:47:26AM +0000, Alexander Lobakin wrote:
>
> > Oh okay, it's because of ClangCFI:
> >
> > SMP alternatives: You were looking for __typeid__ZTSFvvE_global_addr+0x370/0x1410 at 0xffffffffa523cd60,>
> > SMP alternatives: rax is __typeid__ZTSFvvE_global_addr+0x360/0x1410 at 0xffffffffa523cd50
> >
> > Sorry for confusing, seems like it's a side effect of using it on
> > Clang 12 while the original series supports only 13+. I'll double
> > check and let know if find something.
>
> I'm thinking CFI will totally screw this up regardless, seeing how a
> function pointer is taken, and the CFI magicks will turn that into one
> of those weird trampolines instead of the actual symbol.
>
> The compiler could of course deduce that these addresses are never
> called and don't escape the function, and therefore doesn't need to do
> the CFI transformation on then, but I'm guessing it isn't quite that
> clever.

Yes, it's unfortunately not that clever.

> Also doing CFI on retpoline thunks seems 'weird', they have a very
> particular calling convention, excplicitly very much not the standard C
> one. Can't we mark them using asmlinkage or something to tell the
> compiler to politely 'bugger off' or somesuch ;-)

I confirmed that using an opaque type for the thunk declaration fixes
this issue with CFI. It also makes it obvious that these are not
callable from C code.

Sami
