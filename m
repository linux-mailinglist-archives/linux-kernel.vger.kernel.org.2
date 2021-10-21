Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEC8435F01
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 12:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhJUK3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 06:29:37 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:56812 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhJUK3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 06:29:36 -0400
Date:   Thu, 21 Oct 2021 10:27:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1634812035; bh=u9dXeRHmyJjJ/lRfD7FnZKxrYeIO9pbRnhaEFiIApHA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=gF/MS+RdqblRdgH+fw/8LduG7fvCXAKuqA0bgpPF+hbc0/+Kw69rDI1cuvnLasAuU
         9+S6pR3opgbGDcWGcqQeLFFkrkDoQMYg45kX+cyZ8FYKTtRgNAsFbWTLmTa4rRK/4P
         5lw7SdMy256qFG54vaXLhgzJqMqR4Bnu1aM2J4OUMZbdFqa9rg7VgoYWGX6wK4UYCA
         tlCabXp35jPeuuDvo29ZNMTmMKKvfxtZMS66Hg1jRt/rGMnIApHYp5rdQP3OwY65CO
         eiyFjjGgaFZOeS042BBFKN6waG6Ymg0aqB5+FZD8DwaMhAtIRtDRTYPhLcPiHrU4Jq
         zR+bwdYwEAUdg==
To:     Sami Tolvanen <samitolvanen@google.com>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Alexander Lobakin <alobakin@pm.me>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, x86@kernel.org
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: Re: [PATCH v5 00/15] x86: Add support for Clang CFI
Message-ID: <20211021102033.113197-1-alobakin@pm.me>
In-Reply-To: <20211013181658.1020262-1-samitolvanen@google.com>
References: <20211013181658.1020262-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 13 Oct 2021 11:16:43 -0700

> This series adds support for Clang's Control-Flow Integrity (CFI)
> checking to x86_64. With CFI, the compiler injects a runtime
> check before each indirect function call to ensure the target is
> a valid function with the correct static type. This restricts
> possible call targets and makes it more difficult for an attacker
> to exploit bugs that allow the modification of stored function
> pointers. For more details, see:
>
>   https://clang.llvm.org/docs/ControlFlowIntegrity.html
>
> Note that v5 is based on tip/master. The first two patches contain
> objtool support for CFI, the remaining patches change function
> declarations to use opaque types, fix type mismatch issues that
> confuse the compiler, and disable CFI where it can't be used.
>
> You can also pull this series from
>
>   https://github.com/samitolvanen/linux.git x86-cfi-v5

[ snip ]

I've been using it since the end of May on my x86_64, so for v5
(with changing retpoline thunks prototypes to opaque):

Reviwed-by: Alexander Lobakin <alobakin@pm.me>
Tested-by: Alexander Lobakin <alobakin@pm.me>

Thanks!
Al

