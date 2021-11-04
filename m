Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D3E445BD4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 22:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbhKDVwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 17:52:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54644 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229924AbhKDVwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 17:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636062581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l8Pir9d0D1XiHMiSpLu7fjdsjPxWz4KvgEb7x8RaGAE=;
        b=BlAk10UkhMRXbTrFV0qkOt2AraqamHIkwLqDL53oeOXRN5wximEbpiz+Wl0AwUXRPYaPOf
        hHMH4zJpYtBZCH4Qkt0wtQEbhsYkvTwjSffbh1XcNOipZJX2TKc8KK5E/0jCK4snnz5U6a
        TSG8/PMa5XdhhTkK24P3wNLOG+XivPk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-gXGCfL58OhaO43lXCNBnOg-1; Thu, 04 Nov 2021 17:49:40 -0400
X-MC-Unique: gXGCfL58OhaO43lXCNBnOg-1
Received: by mail-qt1-f197.google.com with SMTP id c14-20020ac87d8e000000b002ac69908b09so4222402qtd.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 14:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=l8Pir9d0D1XiHMiSpLu7fjdsjPxWz4KvgEb7x8RaGAE=;
        b=m5TBLWKR1l0NSaQAPRyOSTjHWswbf4G3IAqdlKr6rju88rNBZ8fFtwNvzIq3mnKd/G
         tz837/T5Vw5t3YGmCfbgR9G0GcXGih//wPE3HeGyvCNfuzkq3PlkQ+/cWBKuYqkbMGot
         2gOjf3BvI9VFtLCYriCI6HY39MU+4/MxvnEeNRfHQYHRr0RawqiN/oT3GIFJXo6pHK5M
         9aaihmRzZ/ZWbRPUysTaRd2rBSqvJs3BDl/GQfJReTongXZ0EF+llMV9scUCBV1lWD/l
         6243EXntweHbeZPXLU229g4YFlxSuS8keHVTUTsxuAWwbwQ9T2pxxGjFOiMCrLtnyBam
         WnoA==
X-Gm-Message-State: AOAM533Do2Sk9UKV4ePrhrKnVkviKogzjjy9wo3XBUYf4GkMYX81Mq5q
        07Uf9SH57asU0Ruf5H8czctjNJJTDyACl9Sr6q7l5XE9iQmPOIRJir19JmY4kQhv1zP+1Edavtl
        mlEc0w94Xu6OfXWRiRHo1UsmG
X-Received: by 2002:ac8:7fd5:: with SMTP id b21mr58580165qtk.101.1636062580360;
        Thu, 04 Nov 2021 14:49:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxO8UIEW8GX5tvoU+NJae00fBrRukDL3cHYfv1js8ka3IAAGLac31JObIaY556X4QD3qjU3tw==
X-Received: by 2002:ac8:7fd5:: with SMTP id b21mr58580148qtk.101.1636062580152;
        Thu, 04 Nov 2021 14:49:40 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id o10sm4937023qtx.43.2021.11.04.14.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 14:49:39 -0700 (PDT)
Date:   Thu, 4 Nov 2021 14:49:35 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, seanjc@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH 07/22] x86,extable: Extend extable functionality
Message-ID: <20211104214935.xl54xlr3snwmtyna@treble>
References: <20211104164729.226550532@infradead.org>
 <20211104165524.925401847@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211104165524.925401847@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 05:47:36PM +0100, Peter Zijlstra wrote:
> +asm(
> +"	.macro extable_type_reg type:req reg:req\n"
> +"	.set regnr, 0\n"
> +"	.irp rs,rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14,r15\n"
> +"	.ifc \\reg, %\\rs\n"
> +"	.long \\type + (regnr << 8)\n"
> +"	.endif\n"
> +"	.set regnr, regnr+1\n"
> +"	.endr\n"
> +"	.set regnr, 0\n"
> +"	.irp rs,eax,ecx,edx,ebx,esp,ebp,esi,edi,r8d,r9d,r10d,r11d,r12d,r13d,r14d,r15d\n"
> +"	.ifc \\reg, %\\rs\n"
> +"	.long \\type + (regnr << 8)\n"
> +"	.endif\n"
> +"	.set regnr, regnr+1\n"
> +"	.endr\n"
> +"	.endm\n"
> +);

How about some error checking to detect a typo, or a forgotten '%':

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 5d0ff8c60983..95bb23082b87 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -154,9 +154,11 @@
 
 asm(
 "	.macro extable_type_reg type:req reg:req\n"
+"	.set found, 0\n"
 "	.set regnr, 0\n"
 "	.irp rs,rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14,r15\n"
 "	.ifc \\reg, %\\rs\n"
+"	.set found, found+1\n"
 "	.long \\type + (regnr << 8)\n"
 "	.endif\n"
 "	.set regnr, regnr+1\n"
@@ -164,10 +166,14 @@ asm(
 "	.set regnr, 0\n"
 "	.irp rs,eax,ecx,edx,ebx,esp,ebp,esi,edi,r8d,r9d,r10d,r11d,r12d,r13d,r14d,r15d\n"
 "	.ifc \\reg, %\\rs\n"
+"	.set found, found+1\n"
 "	.long \\type + (regnr << 8)\n"
 "	.endif\n"
 "	.set regnr, regnr+1\n"
 "	.endr\n"
+"	.if (found != 1)\n"
+"	.error \"extable_type_reg: bad register argument\"\n"
+"	.endif\n"
 "	.endm\n"
 );
 
> +#define EX_FLAG_CLR_AX			EX_TYPE_FLAG(1)
> +#define EX_FLAG_CLR_DX			EX_TYPE_FLAG(2)
> +#define EX_FLAG_CLR_AX_DX		EX_TYPE_FLAG(3)

I'd like to buy two vowels: CL̲E̲AR

(I hope that Wheel of Fortune reference isn't too US-centric.)

> +static inline unsigned long *pt_regs_nr(struct pt_regs *regs, int nr)
> +{
> +	/* because having pt_regs in machine order was too much to ask */
> +	switch (nr) {
> +	case 0:		return &regs->ax;
> +	case 1:		return &regs->cx;
> +	case 2:		return &regs->dx;
> +	case 3:		return &regs->bx;
> +	case 4:		return &regs->sp;
> +	case 5:		return &regs->bp;
> +	case 6:		return &regs->si;
> +	case 7:		return &regs->di;
> +#ifdef CONFIG_X86_64
> +	case 8:		return &regs->r8;
> +	case 9:		return &regs->r9;
> +	case 10:	return &regs->r10;
> +	case 11:	return &regs->r11;
> +	case 12:	return &regs->r12;
> +	case 13:	return &regs->r13;
> +	case 14:	return &regs->r14;
> +	case 15:	return &regs->r15;
> +#endif
> +	default:	return NULL;
> +	}
> +}

Instead of all this craziness, why not just admit defeat and put them in
pt_regs order in the 'extable_type_reg' macro?

> +static bool ex_handler_imm_reg(const struct exception_table_entry *fixup,
> +			       struct pt_regs *regs, int reg, int imm)
> +{
> +	*pt_regs_nr(regs, reg) = (long)imm;
> +	return ex_handler_default(fixup, regs);
> +}
> +
> +#define EX_TYPE_MASK	0x000000FF
> +#define EX_REG_MASK	0x00000F00
> +#define EX_FLAG_MASK	0x0000F000
> +#define EX_IMM_MASK	0xFFFF0000

To avoid mismatches these should probably be in the header file next to
EX_TYPE_*_SHIFT?

> +
>  int ex_get_fixup_type(unsigned long ip)
>  {
>  	const struct exception_table_entry *e = search_exception_tables(ip);
>  
> -	return e ? e->type : EX_TYPE_NONE;
> +	return e ? FIELD_GET(EX_TYPE_MASK, e->type) : EX_TYPE_NONE;

Maybe the 'type' field should be renamed, to better represent its new
use, and to try to discourage direct access.  Not that I have any good
ideas.  Some not-so-good ideas: "handler", "flags", "_type".

-- 
Josh

