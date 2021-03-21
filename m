Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1A4343483
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 21:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhCUUGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 16:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbhCUUGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 16:06:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514EDC061762
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 13:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w9fVuu4ijKfT/SM9xHqc97jxMHshuj1pg66tuy8DPKw=; b=JiEbpi326aRR3rM4kJej9m9Blp
        mDodxuUJfwmBgEUiF+oMegnaxrV9sOIDk8vqcmcyOFPXr32YnG0wnOVSF/mU4EWx5WrEn2ejJ0bvU
        +CH9a1jIz+XjcoEznwllUZBzNpK1VE2qw2ZNUArKIuAvjd88sckrQuVD3OdD+0nkPu9+PgzyHdizv
        4G8UcfZOVQF3bacumuKkt3sTz3NdapUyXe2/8wgtqO6FcbdIrXaBsmtPQlrJdT4N/jXjta3i6fRKn
        VpInhWmJbU7BvaT3murc28HYvNNGhZGnqXTI6ssFK1rIMatMnN+c3AEOzRgy6hBQZIGTmO4le35Bx
        PDVIem4g==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lO4LF-002UH9-Cd; Sun, 21 Mar 2021 20:06:30 +0000
Date:   Sun, 21 Mar 2021 13:06:29 -0700 (PDT)
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, jroedel@suse.de, mhiramat@kernel.org,
        gustavoars@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/insn-eval: Few typo fixes
In-Reply-To: <20210321200211.487449-1-unixbhaskar@gmail.com>
Message-ID: <959c2b7c-5723-8b82-bfd7-3361f128ddc@infradead.org>
References: <20210321200211.487449-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210321_130629_453289_8F1D8C4B 
X-CRM114-Status: GOOD (  13.69  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Mon, 22 Mar 2021, Bhaskar Chowdhury wrote: > > s/deterimine/determine/
    > s/invalild/invalid/ > > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
    Acked-by: Randy Dunlap <rdunlap@infradead.org> 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Mar 2021, Bhaskar Chowdhury wrote:

>
> s/deterimine/determine/
> s/invalild/invalid/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> arch/x86/lib/insn-eval.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
> index bb0b3fe1e0a0..fdd9226863d3 100644
> --- a/arch/x86/lib/insn-eval.c
> +++ b/arch/x86/lib/insn-eval.c
> @@ -232,7 +232,7 @@ static int resolve_default_seg(struct insn *insn, struct pt_regs *regs, int off)
>  * resolve_seg_reg() - obtain segment register index
>  * @insn:	Instruction with operands
>  * @regs:	Register values as seen when entering kernel mode
> - * @regoff:	Operand offset, in pt_regs, used to deterimine segment register
> + * @regoff:	Operand offset, in pt_regs, used to determine segment register
>  *
>  * Determine the segment register associated with the operands and, if
>  * applicable, prefixes and the instruction pointed by @insn.
> @@ -576,7 +576,7 @@ static int get_reg_offset_16(struct insn *insn, struct pt_regs *regs,
> 	 * If ModRM.mod is 0 and ModRM.rm is 110b, then we use displacement-
> 	 * only addressing. This means that no registers are involved in
> 	 * computing the effective address. Thus, ensure that the first
> -	 * register offset is invalild. The second register offset is already
> +	 * register offset is invalid. The second register offset is already
> 	 * invalid under the aforementioned conditions.
> 	 */
> 	if ((X86_MODRM_MOD(insn->modrm.value) == 0) &&
> --
> 2.31.0
>
>
