Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667793F9ACD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 16:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbhH0OWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 10:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbhH0OWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 10:22:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A342C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 07:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y8x9M8FjjWKnIGCpIny8kZFfJn+oZ090wNvmw+tIVm0=; b=CgmuOYNseN5q+TmGcTa3Qc/e0L
        u9Tc1o8WZ9UP0/04f1Z4v3aNQiHqywy48M1pGD5bNEmOujt/SAlIKJnQECRfyhIkMp81pRJtkQOI4
        vRBFzdZ8/Cd0ec+JZlw30IoFjQ6CrC3dQN3Llgr4CtQ4dA/m8XcA8Oo0r/hIuZhjoz4LtSGOdyhkq
        f+mdY/PkiNMvvdZgN5e+tma0+3x3Jy4ujN+I+PydgMN4sgnyz1AG8Yqoh+2+VysaQk5To7rhWwsDw
        gQxNxzB0+4ddAEue6ZZbYKcZWANNHYl0kT/YvX5n6wXHDDJXHf0o9YkLOeSikCeMPhK5kMHM5aVPC
        L2GZ341g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJch0-00EdzB-Fq; Fri, 27 Aug 2021 14:19:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6E24F3005AD;
        Fri, 27 Aug 2021 16:18:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C1EB2CABE7F0; Fri, 27 Aug 2021 16:18:47 +0200 (CEST)
Date:   Fri, 27 Aug 2021 16:18:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [RFC PATCH] powerpc: Investigate static_call concept
Message-ID: <YSj0R6g6HeboSk9n@hirez.programming.kicks-ass.net>
References: <8077899fee81f08a7dffbf185569d3a1f7a2ab68.1630057495.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8077899fee81f08a7dffbf185569d3a1f7a2ab68.1630057495.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 09:45:37AM +0000, Christophe Leroy wrote:
> This RFC is to validate the concept of static_call on powerpc.
> 
> Highly copied from x86.
> 
> It replaces ppc_md.get_irq() which is called at every IRQ, by
> a static call.

The code looks saner, but does it actually improve performance? I'm
thinking the double branch also isn't free.

> When updating the call, we just replace the instruction at the
> trampoline address by a relative jump to the function.
> 
> For the time being, the case of out-of-range functions is not handled.

The paranoid in me would've made it:

	BUG_ON(patch_branch(...));

just to make sure to notice the target not fitting. Ohh, patch_branch()
doesn't return the create_branch() error, perhaps that wants to be
fixed?

Did you see the arm64 variant that deals with out-of-range functions in
their trampoline?

  https://lore.kernel.org/linux-arm-kernel/20201120082103.4840-1-ardb@kernel.org/

Not exactly 'nice' but supposedly that works.

> +#define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)			\
> +	asm(".pushsection .text, \"ax\"				\n"	\
> +	    ".align 4						\n"	\
> +	    ".globl " STATIC_CALL_TRAMP_STR(name) "		\n"	\
> +	    STATIC_CALL_TRAMP_STR(name) ":			\n"	\
> +	    "	blr						\n"	\
> +	    ".type " STATIC_CALL_TRAMP_STR(name) ", @function	\n"	\
> +	    ".size " STATIC_CALL_TRAMP_STR(name) ", . - " STATIC_CALL_TRAMP_STR(name) " \n" \
> +	    ".popsection					\n")
> +

Since you support CALL_NULL_TRAMP, your patch function below:

> +void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
> +{
> +	mutex_lock(&text_mutex);
> +
> +	if (tramp)
> +		patch_branch(tramp, (unsigned long)func, 0);
> +
> +	mutex_unlock(&text_mutex);
> +}
> +EXPORT_SYMBOL_GPL(arch_static_call_transform);

Ought to patch in "blr" when !func to be consistent :-)

I'm thinking that your core kernel text all fits in the native range and
only modules need out-of-range ?
