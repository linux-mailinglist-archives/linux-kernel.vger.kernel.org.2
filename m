Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800053CBC64
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 21:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbhGPTZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 15:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhGPTZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 15:25:45 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E1BC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 12:22:50 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id h9so15480815ljm.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 12:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c7SncrRVXEiSFd5s6P7BNWlKCS7FA25Smw587Zq+ifE=;
        b=PiTfme1HBOHgHN0oX/l8kLDCRglKqymUSTind+C9sQuE085SB1yc+33Zhc3fZLhASQ
         4xcqJFyoC96DmjJtmoFAcKvnKVdSAFT+cEk8Ma1iP6AsE4wTX069/VYnh8+IhTKi+geL
         PiIixZXlZma4U7TmAsK6J7wN2CXdsRDGKpYrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c7SncrRVXEiSFd5s6P7BNWlKCS7FA25Smw587Zq+ifE=;
        b=eErlHkuGL7H10NtD6Gr29jP2owwUC5vsMSO25GBvhr2Y5ust2775OxjKMnVhlvRQ4w
         IWZLIVFgMnqbPTIZ6m15Nw7/ynINxZnVEcufKrbezSjD0JYKl5tLMWg2Mc5mgqwRJUfQ
         V9vjYSb3xypL0h1zpEbJWpvqP7yjJcqn0kc3E8r8fhPtLl1s7FAWOcHMnbp/qcGB2pba
         jm+2eIXdAQfaIwk4kyHVwjSxQCG2Zeu61m7ZxtwwuN90hwr7+Lfax5LEawusa9O/p6w3
         rZREIZO+pLMwVArIXtVjJssc6vc6dxcDbUUwbmsC4sWdmFjBiy+4WjoH0OIe/gZ1XNQ5
         RwTQ==
X-Gm-Message-State: AOAM533GKY+Vzc2soZZ4XDNpWMca10nFGy087m3FAk3dhFF+LJegu+35
        Cl1c/hNZv0sAjHmdHhU+iQ1LByL8NzmWhtN/
X-Google-Smtp-Source: ABdhPJwYHxUXOeArkGWEgfgLBLCAqyZ94ncl+aLIdDHY30wOnBXRXCac0Yv/+PNZZl3hUODklOLhIQ==
X-Received: by 2002:a05:651c:544:: with SMTP id q4mr10353295ljp.105.1626463368670;
        Fri, 16 Jul 2021 12:22:48 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id i11sm707794lfd.147.2021.07.16.12.22.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 12:22:48 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id y42so17759926lfa.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 12:22:48 -0700 (PDT)
X-Received: by 2002:a05:6512:404:: with SMTP id u4mr8574325lfk.40.1626463367816;
 Fri, 16 Jul 2021 12:22:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210714200523.GA10606@embeddedor> <CAHk-=wjQeeUiv+P_4cZfCy-hY13yGqCGS-scKGhuJ-SAzz2doA@mail.gmail.com>
 <YPHUJsiaOuqzW0Od@archlinux-ax161>
In-Reply-To: <YPHUJsiaOuqzW0Od@archlinux-ax161>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 16 Jul 2021 12:22:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg-qBVjhqoRiV0EdkFSpP1FebmRYwjiv-=GM3EVQYbBqg@mail.gmail.com>
Message-ID: <CAHk-=wg-qBVjhqoRiV0EdkFSpP1FebmRYwjiv-=GM3EVQYbBqg@mail.gmail.com>
Subject: Re: [GIT PULL] fallthrough fixes for Clang for 5.14-rc2
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 11:47 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> I am not really sure how to resolve that within checkFallThroughIntoBlock() or
> fillReachableBlocks() but given that this is something specific to the kernel,

It's not at all specific to the kernel. Yes, the particular example
was from the kernel, but the issue is very much generic.

Yes, that particular example was from the kernel and used a CONFIG option.

But I can actually point to user-space code that looks very much like it:

   https://sources.debian.org/src/libreoffice/1:7.0.4-4/stoc/source/simpleregistry/simpleregistry.cxx/?hl=223#L223

look at that code, and tell me it makes sense.

You want to have the fallthrough for the case where abort() isn't
marked as noreturn, but you don't want to get a warning for the case
where a compile environment *does* have that noreturn thing.

See the issue? EXACT SAME THING.

This is in no way kernel-specific. The fact is, code can be
unreachable without it being a bug.

A common example of unreachable code is things like this:

  https://sources.debian.org/src/apparmor/2.13.6-10/parser/libapparmor_re/chfa.cc/?hl=338#L338

Look, it's a "switch (sizeof())", which means that only one of the
cases is ever going to be reachable.

That code doesn't actually use "[[fallthrough]]" right now, and just
uses the implicit fallthrough. But imagine if it was converted to use
that fallthrough annotation. If the "sizeof()" isn't the largest size,
those fallthrough's will be fundamentally unreachable, because the
whole case is unreachable.

Warning about unreachable code is simply WRONG. It happens very
naturally in C, exactly becuse people do conditionals based on
compile-time constants. Those compile-time constants may be about
things like "sizeof", they may be about things like that "abort() may
be no-return or not".

But it can also easily be about patterns where you always check error
returns, and some functions are inline and never (or always) return
errors, so that your code ends up having stuff that is just statically
always true (or always false), and then the implication is that there
is unreachable code that the compiler will just compile away.

And no, this is in no way kernel-specific at all.

That warning needs

 (a) a different flag - because "warn about unreachable" is completely
different from "warn about implicit fallthrough"

 (b) point to where the warning is

but honestly, it would be better to just remove the warning entirely,
because it is just fundamentally wrong for all the reasons outlined
above.

                  Linus
