Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725EC3BDC81
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 19:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhGFRxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 13:53:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229787AbhGFRxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 13:53:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CFD2461C63;
        Tue,  6 Jul 2021 17:50:55 +0000 (UTC)
Date:   Tue, 6 Jul 2021 18:50:52 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Chen Huang <chenhuang5@huawei.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] arm64: an infinite loop in generic_perform_write()
Message-ID: <20210706175052.GD15218@arm.com>
References: <1c635945-fb25-8871-7b34-f475f75b2caf@huawei.com>
 <YNP6/p/yJzLLr8M8@casper.infradead.org>
 <YNQuZ8ykN7aR+1MP@infradead.org>
 <YNRpYli/5/GWvaTT@casper.infradead.org>
 <27fbb8c1-2a65-738f-6bec-13f450395ab7@arm.com>
 <YNSyZaZtPTmTa5P8@zeniv-ca.linux.org.uk>
 <20210624185554.GC25097@arm.com>
 <e8e87aba-22f7-d039-ceaa-a93591b04b1e@arm.com>
 <20210625103905.GA20835@arm.com>
 <7f14271a-9b2f-1afc-3caf-c4e5b36efa73@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f14271a-9b2f-1afc-3caf-c4e5b36efa73@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 05:22:30PM +0100, Robin Murphy wrote:
> diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
> index 043da90f5dd7..cfb598ae4812 100644
> --- a/arch/arm64/lib/copy_to_user.S
> +++ b/arch/arm64/lib/copy_to_user.S
> @@ -32,7 +32,7 @@
>  	.endm
>  	.macro strh1 reg, ptr, val
> -	user_ldst 9998f, sttrh, \reg, \ptr, \val
> +	user_ldst 9997f, sttrh, \reg, \ptr, \val
>  	.endm
>  	.macro ldr1 reg, ptr, val
> @@ -40,7 +40,7 @@
>  	.endm
>  	.macro str1 reg, ptr, val
> -	user_ldst 9998f, sttr, \reg, \ptr, \val
> +	user_ldst 9997f, sttr, \reg, \ptr, \val
>  	.endm
>  	.macro ldp1 reg1, reg2, ptr, val
> @@ -48,12 +48,14 @@
>  	.endm
>  	.macro stp1 reg1, reg2, ptr, val
> -	user_stp 9998f, \reg1, \reg2, \ptr, \val
> +	user_stp 9997f, \reg1, \reg2, \ptr, \val
>  	.endm
>  end	.req	x5
> +srcin	.req	x15
>  SYM_FUNC_START(__arch_copy_to_user)
>  	add	end, x0, x2
> +	mov	srcin, x1
>  #include "copy_template.S"
>  	mov	x0, #0
>  	ret
> @@ -62,6 +64,12 @@ EXPORT_SYMBOL(__arch_copy_to_user)
>  	.section .fixup,"ax"
>  	.align	2
> +9997:	cmp	dst, dstin
> +	b.ne	9998f
> +	// Before being absolutely sure we couldn't copy anything, try harder
> +	ldrb	tmp1w, [srcin]
> +USER(9998f, sttrb tmp1w, [dstin])
> +	add	dst, dstin, #1
>  9998:	sub	x0, end, dst			// bytes not copied
>  	ret
>  	.previous

I think it's worth doing the copy_to_user() fallback in a loop until it
faults or hits the end of the buffer. This would solve the problem we
currently have with writing more bytes than actually reported. The
copy_from_user() is not necessary, a byte would suffice.

-- 
Catalin
