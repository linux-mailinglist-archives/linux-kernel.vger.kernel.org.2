Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C815D433360
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 12:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbhJSKVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 06:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhJSKVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 06:21:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C37C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 03:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WPO1tcl+nQzbYjUbrWeYUy/RLR5bIBcWyLg3WBA/gTI=; b=I9fXKh1ASw1ngjNalvwrHTEpAt
        +Kf2/dlh34g/wKkLuWWGbm2IBTLGC7B6OfjMIjfRs/7GanjWNv2W4OxoPOBr2h2nCz//7mpOmtGcz
        4rm5eBfr728iAXP4d5mkZc+hzLn8m/5CDmYVL0ZJ3nI7/gZYFjpMInFwhhcPqeNo+afxvGdxBHmWs
        ASwuaqEcSicNJ+UcFbK/++goK59P8PGZFltSGrABfgXruj74vZPInRcdwmKX4WdseiLB5QVsl5Pf0
        CZs0PxUFXAwNHIz5n3h5aAFv9BLmEI2Tfx9zYDwy7XveLMdP1E/bbK8z2rsmN4d4yNJXJb1TdZOo/
        NIVj8OVA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcmAG-00Bg3g-3B; Tue, 19 Oct 2021 10:16:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EB574300221;
        Tue, 19 Oct 2021 12:16:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D0D0721BE9697; Tue, 19 Oct 2021 12:16:11 +0200 (CEST)
Date:   Tue, 19 Oct 2021 12:16:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com, samitolvanen@google.com
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
Message-ID: <YW6a67fGzM2AyHot@hirez.programming.kicks-ass.net>
References: <20211013122217.304265366@infradead.org>
 <20211013123645.002402102@infradead.org>
 <YWmPCF+g+sF4+ieh@zn.tnic>
 <20211015165635.GH174703@worktop.programming.kicks-ass.net>
 <20211018225905.86034-1-alobakin@pm.me>
 <20211019001845.85256-1-alobakin@pm.me>
 <20211019094038.80569-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019094038.80569-1-alobakin@pm.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


+ Sami

(Sami, for context:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=objtool/core

which contains the following code:

+	void (*target)(void);
+	int reg, i = 0;
+
+	target = addr + insn->length + insn->immediate.value;
+	reg = (target - &__x86_indirect_thunk_rax) /
+	      (&__x86_indirect_thunk_rcx - &__x86_indirect_thunk_rax);
+
+	if (WARN_ON_ONCE(reg & ~0xf))
+		return -1;

which blows up something fierce on clang-cfi)

On Tue, Oct 19, 2021 at 09:47:26AM +0000, Alexander Lobakin wrote:

> Oh okay, it's because of ClangCFI:
> 
> SMP alternatives: You were looking for __typeid__ZTSFvvE_global_addr+0x370/0x1410 at 0xffffffffa523cd60,>
> SMP alternatives: rax is __typeid__ZTSFvvE_global_addr+0x360/0x1410 at 0xffffffffa523cd50
> 
> Sorry for confusing, seems like it's a side effect of using it on
> Clang 12 while the original series supports only 13+. I'll double
> check and let know if find something.

I'm thinking CFI will totally screw this up regardless, seeing how a
function pointer is taken, and the CFI magicks will turn that into one
of those weird trampolines instead of the actual symbol.

The compiler could of course deduce that these addresses are never
called and don't escape the function, and therefore doesn't need to do
the CFI transformation on then, but I'm guessing it isn't quite that
clever.

Also doing CFI on retpoline thunks seems 'weird', they have a very
particular calling convention, excplicitly very much not the standard C
one. Can't we mark them using asmlinkage or something to tell the
compiler to politely 'bugger off' or somesuch ;-)
