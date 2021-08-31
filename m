Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8426A3FC94C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbhHaOEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbhHaOEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:04:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FE0C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZgzwjZwCf/ykABrZU5jktR0OjgK20KPldkEgMC3u/pM=; b=iMhGAYk8TgJk6vqXPzJH30eIpU
        ToQBbegMORlZFXCmgjtDqES1d45uMUGrqOzqxy+MgrDJCvMwR5FuHYFs35lhi9jtMUK/8cL7VAQT/
        1nseKClnmJqNOd8uXKcxdEYcxoB/PKkY8yzS0N2rU4Oyr02kaHcu2y0H/OuBi0l/jFv7NxPAOYFGg
        kDOh3Ko8Zm7gxxB2jj9KtZDKwvQKB7/zcfQjCCeNvctR5Is/GfI91NsK40PsFy8Am4Bwixv6+siGq
        n0zIUF6dmfciKAc9bzTIEgZLIA5USAVSlXShsmWUm9doaWk57dk6LA0kYiMRM+B6ikrNpIj4KcyQI
        0E5pcHVw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mL4JN-001GfJ-AY; Tue, 31 Aug 2021 14:00:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 19B6F300299;
        Tue, 31 Aug 2021 16:00:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B542120AEBF27; Tue, 31 Aug 2021 16:00:20 +0200 (CEST)
Date:   Tue, 31 Aug 2021 16:00:20 +0200
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
Subject: Re: [PATCH v2] powerpc/32: Add support for out-of-line static calls
Message-ID: <YS419Exj6PpESVc/@hirez.programming.kicks-ass.net>
References: <97f252fcd63e145f54fbf85124c75fb01e96e1bb.1630415517.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97f252fcd63e145f54fbf85124c75fb01e96e1bb.1630415517.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 01:12:26PM +0000, Christophe Leroy wrote:
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 36b72d972568..a0fe69d8ec83 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -247,6 +247,7 @@ config PPC
>  	select HAVE_SOFTIRQ_ON_OWN_STACK
>  	select HAVE_STACKPROTECTOR		if PPC32 && $(cc-option,-mstack-protector-guard=tls -mstack-protector-guard-reg=r2)
>  	select HAVE_STACKPROTECTOR		if PPC64 && $(cc-option,-mstack-protector-guard=tls -mstack-protector-guard-reg=r13)
> +	select HAVE_STATIC_CALL			if PPC32
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select HAVE_VIRT_CPU_ACCOUNTING
>  	select HUGETLB_PAGE_SIZE_VARIABLE	if PPC_BOOK3S_64 && HUGETLB_PAGE
> diff --git a/arch/powerpc/include/asm/static_call.h b/arch/powerpc/include/asm/static_call.h
> new file mode 100644
> index 000000000000..2402c6d32439
> --- /dev/null
> +++ b/arch/powerpc/include/asm/static_call.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_POWERPC_STATIC_CALL_H
> +#define _ASM_POWERPC_STATIC_CALL_H
> +
> +#define __POWERPC_SCT(name, inst)					\
> +	asm(".pushsection .text, \"ax\"				\n"	\
> +	    ".align 5						\n"	\
> +	    ".globl " STATIC_CALL_TRAMP_STR(name) "		\n"	\
> +	    STATIC_CALL_TRAMP_STR(name) ":			\n"	\
> +	    inst "						\n"	\
> +	    "	lis	12,1f@ha				\n"	\
> +	    "	lwz	12,1f@l(12)				\n"	\
> +	    "	mtctr	12					\n"	\
> +	    "	bctr						\n"	\
> +	    "1:	.long 0						\n"	\
> +	    "	nop						\n"	\
> +	    "	nop						\n"	\
> +	    ".type " STATIC_CALL_TRAMP_STR(name) ", @function	\n"	\
> +	    ".size " STATIC_CALL_TRAMP_STR(name) ", . - " STATIC_CALL_TRAMP_STR(name) " \n" \
> +	    ".popsection					\n")
> +
> +#define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)	__POWERPC_SCT(name, "b " #func)
> +#define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)	__POWERPC_SCT(name, "blr")
> +
> +#endif /* _ASM_POWERPC_STATIC_CALL_H */

> diff --git a/arch/powerpc/kernel/static_call.c b/arch/powerpc/kernel/static_call.c
> new file mode 100644
> index 000000000000..e5e78205ccb4
> --- /dev/null
> +++ b/arch/powerpc/kernel/static_call.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/memory.h>
> +#include <linux/static_call.h>
> +
> +#include <asm/code-patching.h>
> +
> +void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
> +{
> +	int err;
> +	unsigned long target = (long)func;
> +	bool is_short = is_offset_in_branch_range((long)target - (long)tramp);
> +
> +	if (!tramp)
> +		return;
> +
> +	mutex_lock(&text_mutex);
> +
> +	if (func && !is_short) {
> +		err = patch_instruction(tramp + 20, ppc_inst(target));
> +		if (err)
> +			goto out;
> +	}
> +
> +	if (!func)
> +		err = patch_instruction(tramp, ppc_inst(PPC_RAW_BLR()));
> +	else if (is_short)
> +		err = patch_branch(tramp, target, 0);
> +	else
> +		err = patch_instruction(tramp, ppc_inst(PPC_RAW_NOP()));
> +out:
> +	mutex_unlock(&text_mutex);
> +
> +	if (err)
> +		panic("%s: patching failed %pS at %pS\n", __func__, func, tramp);
> +}
> +EXPORT_SYMBOL_GPL(arch_static_call_transform);

Yes, this should work nicely!

Since you have the two nop's at the end, you could frob in an
optimization for __static_call_return0 without too much issue.

Replace the two nops with (excuse my ppc asm):

	li r3, 0
	blr

and augment arch_static_call_transform() with something like:

	if (func == &__static_call_return0)
		err = patch_branch(tramp, tramp+24, 0);

