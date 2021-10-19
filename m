Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD57433330
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 12:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbhJSKI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 06:08:57 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:41300 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbhJSKI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 06:08:56 -0400
Date:   Tue, 19 Oct 2021 10:06:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1634637998; bh=LOFsSQgEL4w+fS68cEWnarmWnUdXiUZe2VQW9yMhlYk=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=kgnUhhOx8j6ksT5RA6+ox2FUcgrA4VVcqOldtTlgDhhKSNfUVd498eXSm5hL82SQn
         Vm3wvVOK0PrS3vSnid7gZE6SBQBntl4WR/Omv6Cq4Idpv6TJUU+pgbBB1XGTN1MYiT
         hNIk4CI43LHFyiElLWwvfQYkg0hJLXQrHSuGtYE8cw9xFo58ByNHjnTL7Mhk3WzwyN
         08R/zkYS6jzfHnRjsWKuTL6BybGW+N7dAMV+Rd+b7FVIpJ8eXw0V4z3KeIxMpP+QAp
         nGqASZ2lfKwKJw1L75wTS8+Prb7EzGYyhsz+08EzUZjo0s3SkKNhwkJLmgWpd60aoP
         kHly93G10ZO4Q==
To:     Sami Tolvanen <samitolvanen@google.com>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Alexander Lobakin <alobakin@pm.me>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: Re: [PATCH v5 00/15] x86: Add support for Clang CFI
Message-ID: <20211019095947.89257-1-alobakin@pm.me>
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

Hi,

I found [0] while was testing Peter's retpoline series, wanted to
ask / double check if that is because I'm using ClangCFI for x86
on unsupported Clang 12. It is fixed in 13 I suppose?

[0] https://lore.kernel.org/all/20211019094038.80569-1-alobakin@pm.me

Thanks,
Al

