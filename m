Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A792E3F6A18
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 21:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbhHXTr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 15:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhHXTr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 15:47:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19FDC061757;
        Tue, 24 Aug 2021 12:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5xmXB2Lw/5xwUTRzhqLNhETYzTNETFh6DtMn8eUe4N4=; b=GV04Oz1moYv6gNOH40ylMi/NQa
        metvJKbOP2iPdDUhWKcAC8Ky5DqjfpI6Yqk6gOUWOsKtTyyaTzcyZDpERAg/6ykMJCVJx76NCGt3T
        Rifsl17evmXj7yJiLKaoQCu4n9LEGMGHOLMTmLTS7IB5JFRqwoS42RzlUOLJm8XrTjWv6vHpsQ7Kh
        uq/TfeaXsTFIzm+eXTO/B7TGb09kwPk8vudY6XQjqnuhn8wMLCaYjPn8OXpDJAg/EOCTFRXzwiP+Z
        uiN58m6+nptSOvFikZVJcpPVMhCBTL9DPuL60e89nTC1Omdujf4+NdE0qnXwWK63PTzTH/R9rkoCm
        ZPIGPeJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIcNq-00CgII-Jj; Tue, 24 Aug 2021 19:46:54 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 493BA981198; Tue, 24 Aug 2021 21:46:52 +0200 (CEST)
Date:   Tue, 24 Aug 2021 21:46:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 00/14] x86: Add support for Clang CFI
Message-ID: <20210824194652.GB17784@worktop.programming.kicks-ass.net>
References: <20210823171318.2801096-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823171318.2801096-1-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 10:13:04AM -0700, Sami Tolvanen wrote:
> This series adds support for Clang's Control-Flow Integrity (CFI)
> checking to x86_64. With CFI, the compiler injects a runtime
> check before each indirect function call to ensure the target is
> a valid function with the correct static type. This restricts
> possible call targets and makes it more difficult for an attacker
> to exploit bugs that allow the modification of stored function
> pointers. For more details, see:

If I understand this right; tp_stub_func() in kernel/tracepoint.c
violates this (as would much of the HAVE_STATIC_CALL=n code, luckily
that is not a valid x86_64 configuration).

Specifically, we assign &tp_stub_func to tracepoint_func::func, but that
function pointer is only ever indirectly called when cast to the
tracepoint prototype:

  ((void(*)(void *, proto))(it_func))(__data, args);

(see DEFINE_TRACE_FN() in linux/tracepoint.h)

This means the indirect function type and the target function type
mismatch, resulting in that runtime check you added to trigger.

Hitting tp_stub_func() at runtime is exceedingly rare, but possible.

I realize this is strictly UB per C, but realistically any CDECL ABI
requires that any function with arbitrary signature:

  void foo(...)
  {
  }

translates to the exact same code. Specifically on x86-64, the super
impressive:

foo:
	RET

And as such this works just fine. Except now you wrecked it.
