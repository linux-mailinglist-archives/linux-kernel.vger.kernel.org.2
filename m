Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C113FC47E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240417AbhHaIzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 04:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240380AbhHaIzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 04:55:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BAAC061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 01:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f3fv6g3WY1dNgkG1wWMP0wIKttOnssZK8A7WNBphc38=; b=FhH9lOPu/UT4X9v1NnmpLuw2EZ
        5m6zNh3HxcxPVEZn9orUKyQESgZfnWmM4cBdWQHXL17LPDEJ9M+eVFGkzzzKpGYvyHKkg8bN3kq2h
        PWlMv4gbuCOGgWN7uF/wQSmnk1dBVkHbFDnZJ+sgqH5+GNdmgi7aIGFuiYeBoixBVvax+BVhG2zgU
        Yn6gokFvr+M0kPUDN0x+cQHeN3lElOwiCSFdcTlTmWstGKTTZwBXyBVUr/lVR8d7XHL1AoOIj3j6X
        lMDMIwUF+KEY8oe88w2E8SIYJpuw9sPoaFm6faSl7xDW9z/xZA4giX4VDdmmQDFhzsjBOfxga65Nw
        t8vfKdZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKzWD-00Eeoz-Hi; Tue, 31 Aug 2021 08:53:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3D918300109;
        Tue, 31 Aug 2021 10:53:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1780A2C7BAE48; Tue, 31 Aug 2021 10:53:18 +0200 (CEST)
Date:   Tue, 31 Aug 2021 10:53:18 +0200
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
Subject: Re: [PATCH] powerpc/32: Add support for out-of-line static calls
Message-ID: <YS3t/s9nojyCn9ev@hirez.programming.kicks-ass.net>
References: <cbfc0376461d02867c75cee72bb9167e16f4d0b0.1630396954.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbfc0376461d02867c75cee72bb9167e16f4d0b0.1630396954.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 08:05:21AM +0000, Christophe Leroy wrote:

> +#define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)			\
> +	asm(".pushsection .text, \"ax\"				\n"	\
> +	    ".align 4						\n"	\
> +	    ".globl " STATIC_CALL_TRAMP_STR(name) "		\n"	\
> +	    STATIC_CALL_TRAMP_STR(name) ":			\n"	\
> +	    "	blr						\n"	\
> +	    "	nop						\n"	\
> +	    "	nop						\n"	\
> +	    "	nop						\n"	\
> +	    ".type " STATIC_CALL_TRAMP_STR(name) ", @function	\n"	\
> +	    ".size " STATIC_CALL_TRAMP_STR(name) ", . - " STATIC_CALL_TRAMP_STR(name) " \n" \
> +	    ".popsection					\n")

> +static int patch_trampoline_32(u32 *addr, unsigned long target)
> +{
> +	int err;
> +
> +	err = patch_instruction(addr++, ppc_inst(PPC_RAW_LIS(_R12, PPC_HA(target))));
> +	err |= patch_instruction(addr++, ppc_inst(PPC_RAW_ADDI(_R12, _R12, PPC_LO(target))));
> +	err |= patch_instruction(addr++, ppc_inst(PPC_RAW_MTCTR(_R12)));
> +	err |= patch_instruction(addr, ppc_inst(PPC_RAW_BCTR()));
> +
> +	return err;
> +}

There can be concurrent execution and modification; the above doesn't
look safe in that regard. What happens if you've say, done the first
two, but not the latter two and execution happens (on a different
CPU or through IRQ context, etc..)?

> +void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
> +{
> +	int err;
> +	unsigned long target = (long)func;
> +
> +	if (!tramp)
> +		return;
> +
> +	mutex_lock(&text_mutex);
> +
> +	if (!func)
> +		err = patch_instruction(tramp, ppc_inst(PPC_RAW_BLR()));
> +	else if (is_offset_in_branch_range((long)target - (long)tramp))
> +		err = patch_branch(tramp, target, 0);

These two are single instruction modifications and I'm assuming the
hardware is sane enough that execution sees either the old or the new
instruction. So this should work.

> +	else if (IS_ENABLED(CONFIG_PPC32))
> +		err = patch_trampoline_32(tramp, target);
> +	else
> +		BUILD_BUG();
> +
> +	mutex_unlock(&text_mutex);
> +
> +	if (err)
> +		panic("%s: patching failed %pS at %pS\n", __func__, func, tramp);
> +}
> +EXPORT_SYMBOL_GPL(arch_static_call_transform);

One possible solution that we explored on ARM64, was having the
trampoline be in 2 slots:


	b 1f

1:	blr
	nop
	nop
	nop

2:	blr
	nop
	nop
	nop

Where initially the first slot is active (per "b 1f"), then you write
the second slot, and as a final act, re-write the initial branch to
point to slot 2.

Then you execute synchronize_rcu_tasks() under your text mutex
(careful!) to ensure all users of your slot1 are gone and the next
modification repeats the whole thing, except for using slot1 etc..

Eventually I think Ard came up with the latest ARM64 proposal which puts
a literal in a RO section (could be the text section I suppose) and
loads and branches to that.

Anyway, the thing is, you can really only modify a single instruction at
the time and need to ensure concurrent execution is correct.
