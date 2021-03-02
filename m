Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B457232A2B8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376940AbhCBISW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 03:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1837224AbhCBIII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:08:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12DFC061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 00:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aF5QpyiukkBI21SbloK3u+Cas83GKy3SpzT4AciiVH4=; b=kaq8D/iH6Ax90VqbAwDi4i6n9Q
        eElkBP6Pad9RsCQzwHFdMiqPC480g/Ahrkg8HDRQpqoVdymPW6rbD31KKdb8dRyv3LhYNcLv3oQlL
        BqOA0idxO5Oo8bF3azC/nn6qODQ4B0/j3Z+JmPyHUTdOjHIutah2nLmCVflzle6oxDf3ikY/+EjqQ
        3Uc5B83ao4KLFMr0jniTBUllH09GW3cGw2KeuPN3AOsO0SmPNqkta8Qcl1s2rI47jexB/ZtBDQUlS
        AXcKwSFQTUg25Ag8TdyKZ86+fhoDNRhBajQq92uoVxKyzXFLMU4Jjrcqu105cUYDo9+fcRZcUE+RD
        P8+EYW3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lH03P-00GnFL-84; Tue, 02 Mar 2021 08:06:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F0D633003E1;
        Tue,  2 Mar 2021 09:06:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8612C2215BD38; Tue,  2 Mar 2021 09:06:47 +0100 (CET)
Date:   Tue, 2 Mar 2021 09:06:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 1/1] x86/kprobes: Use int3 instead of debug trap for
 single-step
Message-ID: <YD3yF2DnZgzmLlY1@hirez.programming.kicks-ass.net>
References: <161460768474.430263.18425867006584111900.stgit@devnote2>
 <161460769556.430263.12936080446789384938.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161460769556.430263.12936080446789384938.stgit@devnote2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 11:08:15PM +0900, Masami Hiramatsu wrote:

> +static void kprobe_emulate_jmp(struct kprobe *p, struct pt_regs *regs)
> +{
> +	unsigned long ip = regs->ip - INT3_INSN_SIZE + p->ainsn.size;
> +
> +	ip += p->ainsn.rel32;
> +	int3_emulate_jmp(regs, ip);
> +}
> +NOKPROBE_SYMBOL(kprobe_emulate_jmp);

Would it make sense to have this be something like:

static void kprobe_emulate_jmp(struct kprobe *p, struct pt_regs *regs, bool cond)
{
	unsigned long ip = regs->ip - INT3_INSN_SIZE + p->ainsn.size;

	if (cond)
		ip += p->ainsn.rel32;
	int3_emulate_jmp(regs, ip);
}

> +static void kprobe_emulate_jcc(struct kprobe *p, struct pt_regs *regs)
> +{
> +	bool invert = p->ainsn.jcc.type & 1;
> +	bool match;
> +
> +	if (p->ainsn.jcc.type < 0xc) {
> +		match = regs->flags & jcc_mask[p->ainsn.jcc.type >> 1];
> +	} else {
> +		match = ((regs->flags & X86_EFLAGS_SF) >> X86_EFLAGS_SF_BIT) ^
> +			((regs->flags & X86_EFLAGS_OF) >> X86_EFLAGS_OF_BIT);
> +		if (p->ainsn.jcc.type >= 0xe)
> +			match = match && (regs->flags & X86_EFLAGS_ZF);
> +	}
> +	if ((match && !invert) || (!match && invert))
> +		kprobe_emulate_jmp(p, regs);
> +	else
> +		regs->ip = regs->ip - INT3_INSN_SIZE + p->ainsn.size;

Then you can do:

	kprobe_emulate_jmp(p, regs, match);

> +}
> +NOKPROBE_SYMBOL(kprobe_emulate_jcc);
> +
> +static void kprobe_emulate_loop(struct kprobe *p, struct pt_regs *regs)
> +{
> +	bool match;
> +
> +	if (p->ainsn.loop.type != 3) {	/* LOOP* */
> +		if (p->ainsn.loop.asize == 32)
> +			match = ((*(u32 *)&regs->cx)--) != 0;
> +#ifdef CONFIG_X86_64
> +		else if (p->ainsn.loop.asize == 64)
> +			match = ((*(u64 *)&regs->cx)--) != 0;
> +#endif
> +		else
> +			match = ((*(u16 *)&regs->cx)--) != 0;
> +	} else {			/* JCXZ */
> +		if (p->ainsn.loop.asize == 32)
> +			match = *(u32 *)(&regs->cx) == 0;
> +#ifdef CONFIG_X86_64
> +		else if (p->ainsn.loop.asize == 64)
> +			match = *(u64 *)(&regs->cx) == 0;
> +#endif
> +		else
> +			match = *(u16 *)(&regs->cx) == 0;
> +	}
> +
> +	if (p->ainsn.loop.type == 0)	/* LOOPNE */
> +		match = match && !(regs->flags & X86_EFLAGS_ZF);
> +	else if (p->ainsn.loop.type == 1)	/* LOOPE */
> +		match = match && (regs->flags & X86_EFLAGS_ZF);
> +
> +	if (match)
> +		kprobe_emulate_jmp(p, regs);
> +	else
> +		regs->ip = regs->ip - INT3_INSN_SIZE + p->ainsn.size;

and here.

> +}
> +NOKPROBE_SYMBOL(kprobe_emulate_loop);
