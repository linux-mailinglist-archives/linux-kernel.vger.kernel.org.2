Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DF0446055
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 08:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbhKEH45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 03:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbhKEH4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 03:56:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3DEC061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 00:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=EN1ky5xW4RXQDs/CDyUj1ofEHG0SDxBSLsyPT/52uKw=; b=pshIbdfDrUyECGAPstzdXTOM3x
        ggsfUIWy3/JcXL70uvbm0S/gKcv4jcOEyrt9+ta6PKaEG4QBSjDEF5W4QyI0t/0q4cT/53lCF9luR
        HCPVXMtXkBz8JUarezlR3nYF60PyHa8AakVqhauRrjFVvfO9ot1SY2NgNqNPhjbmhrmBqbfFjyyI2
        qKV/BkGkEXr34LkoSuUjZdcdtdj/wBXfuJLu256JZJIzN4o7ewYjKTN9aAFR/C/qDL1hBHHLlD9jz
        dEgX1nlKYyURkcBsyF0SpmmDUsNw4EsMugkLY9+iKtgiCe9dk/zSQsyvFbTDYh5XHH7BZDdvbM13P
        FfmBIcJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miu2z-00EJDF-7c; Fri, 05 Nov 2021 07:54:01 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E2F4B98632E; Fri,  5 Nov 2021 08:54:00 +0100 (CET)
Date:   Fri, 5 Nov 2021 08:54:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, seanjc@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH 07/22] x86,extable: Extend extable functionality
Message-ID: <20211105075400.GG174703@worktop.programming.kicks-ass.net>
References: <20211104164729.226550532@infradead.org>
 <20211104165524.925401847@infradead.org>
 <20211104214935.xl54xlr3snwmtyna@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211104214935.xl54xlr3snwmtyna@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 02:49:35PM -0700, Josh Poimboeuf wrote:
> On Thu, Nov 04, 2021 at 05:47:36PM +0100, Peter Zijlstra wrote:
> > +asm(
> > +"	.macro extable_type_reg type:req reg:req\n"
> > +"	.set regnr, 0\n"
> > +"	.irp rs,rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14,r15\n"
> > +"	.ifc \\reg, %\\rs\n"
> > +"	.long \\type + (regnr << 8)\n"
> > +"	.endif\n"
> > +"	.set regnr, regnr+1\n"
> > +"	.endr\n"
> > +"	.set regnr, 0\n"
> > +"	.irp rs,eax,ecx,edx,ebx,esp,ebp,esi,edi,r8d,r9d,r10d,r11d,r12d,r13d,r14d,r15d\n"
> > +"	.ifc \\reg, %\\rs\n"
> > +"	.long \\type + (regnr << 8)\n"
> > +"	.endif\n"
> > +"	.set regnr, regnr+1\n"
> > +"	.endr\n"
> > +"	.endm\n"
> > +);
> 
> How about some error checking to detect a typo, or a forgotten '%':
> 
> diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
> index 5d0ff8c60983..95bb23082b87 100644
> --- a/arch/x86/include/asm/asm.h
> +++ b/arch/x86/include/asm/asm.h
> @@ -154,9 +154,11 @@
>  
>  asm(
>  "	.macro extable_type_reg type:req reg:req\n"
> +"	.set found, 0\n"
>  "	.set regnr, 0\n"
>  "	.irp rs,rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14,r15\n"
>  "	.ifc \\reg, %\\rs\n"
> +"	.set found, found+1\n"
>  "	.long \\type + (regnr << 8)\n"
>  "	.endif\n"
>  "	.set regnr, regnr+1\n"
> @@ -164,10 +166,14 @@ asm(
>  "	.set regnr, 0\n"
>  "	.irp rs,eax,ecx,edx,ebx,esp,ebp,esi,edi,r8d,r9d,r10d,r11d,r12d,r13d,r14d,r15d\n"
>  "	.ifc \\reg, %\\rs\n"
> +"	.set found, found+1\n"
>  "	.long \\type + (regnr << 8)\n"
>  "	.endif\n"
>  "	.set regnr, regnr+1\n"
>  "	.endr\n"
> +"	.if (found != 1)\n"
> +"	.error \"extable_type_reg: bad register argument\"\n"
> +"	.endif\n"
>  "	.endm\n"
>  );

Ooh, nice! I'd actually triggered that once. At the time it was objtool
complaining .extable size wasn't a multiple of 12. Took me a while to
figure out which one had gone missing.

> > +#define EX_FLAG_CLR_AX			EX_TYPE_FLAG(1)
> > +#define EX_FLAG_CLR_DX			EX_TYPE_FLAG(2)
> > +#define EX_FLAG_CLR_AX_DX		EX_TYPE_FLAG(3)
> 
> I'd like to buy two vowels: CL̲E̲AR

Yes, can do. The macro name was longer earlier on, but in this form we
can add the two characters.

> (I hope that Wheel of Fortune reference isn't too US-centric.)

Sadly not, TV was infested with crap like that here in .nl as well.

> > +static inline unsigned long *pt_regs_nr(struct pt_regs *regs, int nr)
> > +{
> > +	/* because having pt_regs in machine order was too much to ask */
> > +	switch (nr) {
> > +	case 0:		return &regs->ax;
> > +	case 1:		return &regs->cx;
> > +	case 2:		return &regs->dx;
> > +	case 3:		return &regs->bx;
> > +	case 4:		return &regs->sp;
> > +	case 5:		return &regs->bp;
> > +	case 6:		return &regs->si;
> > +	case 7:		return &regs->di;
> > +#ifdef CONFIG_X86_64
> > +	case 8:		return &regs->r8;
> > +	case 9:		return &regs->r9;
> > +	case 10:	return &regs->r10;
> > +	case 11:	return &regs->r11;
> > +	case 12:	return &regs->r12;
> > +	case 13:	return &regs->r13;
> > +	case 14:	return &regs->r14;
> > +	case 15:	return &regs->r15;
> > +#endif
> > +	default:	return NULL;
> > +	}
> > +}
> 
> Instead of all this craziness, why not just admit defeat and put them in
> pt_regs order in the 'extable_type_reg' macro?

That makes the macro different between 32bit and 64bit :/ Also, I just
found another, extant, copy of this function, so I can get rid of it and
use that one, see get_reg_offset() in insn-eval.c

> > +static bool ex_handler_imm_reg(const struct exception_table_entry *fixup,
> > +			       struct pt_regs *regs, int reg, int imm)
> > +{
> > +	*pt_regs_nr(regs, reg) = (long)imm;
> > +	return ex_handler_default(fixup, regs);
> > +}
> > +
> > +#define EX_TYPE_MASK	0x000000FF
> > +#define EX_REG_MASK	0x00000F00
> > +#define EX_FLAG_MASK	0x0000F000
> > +#define EX_IMM_MASK	0xFFFF0000
> 
> To avoid mismatches these should probably be in the header file next to
> EX_TYPE_*_SHIFT?

Can do.

> > +
> >  int ex_get_fixup_type(unsigned long ip)
> >  {
> >  	const struct exception_table_entry *e = search_exception_tables(ip);
> >  
> > -	return e ? e->type : EX_TYPE_NONE;
> > +	return e ? FIELD_GET(EX_TYPE_MASK, e->type) : EX_TYPE_NONE;
> 
> Maybe the 'type' field should be renamed, to better represent its new
> use, and to try to discourage direct access.  Not that I have any good
> ideas.  Some not-so-good ideas: "handler", "flags", "_type".

How about the non-descript: "data" ?
