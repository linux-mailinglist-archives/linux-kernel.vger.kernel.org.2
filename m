Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FF8314D4F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhBIKni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbhBIKgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:36:16 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F6EC061788
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 02:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TR9KySGPrVEPFHq9xTT60kdyppdvtvIMXnHHCxSctyE=; b=fdYO2ThEXPPvDbgecpMVKtur5H
        rPwHNUT0W3/DQF8x5EHEwO0KeCsoaYvIIR7E+OBqWWhzIRtTyzeYlftZ8Rc8f+WlGDYTryI63miZG
        Gqhhx+5kFQ1p66KBtqJIIQOFdgwEZoqxN8OohX40CMCq8Ls2a7vg9u3pqHvWm8nctzEktOG1LT1Wt
        ZLr4NzGnthr0g12LmqENnlIgIb6FROEcsT5JWw7FE8QcxZKNBlPK9wrr3P4a1GwUVwBYiDZA/OqA7
        4S4sKe1p6V1ihI6YiMWEXL6Ye4krdhaF4yAwfix/HsslVTn+Hb4odvau+fm57Q/DKVUUWr+l8PkWT
        mvR3lZ1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l9QMj-0000DX-N3; Tue, 09 Feb 2021 10:35:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 65E4B3010D2;
        Tue,  9 Feb 2021 11:35:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D7B12D4E46ED; Tue,  9 Feb 2021 11:35:28 +0100 (CET)
Date:   Tue, 9 Feb 2021 11:35:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] objtool: Support stack-swizzle
Message-ID: <YCJlcI5fYRoX/sOA@hirez.programming.kicks-ass.net>
References: <20210209091600.075402197@infradead.org>
 <20210209093521.994069508@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209093521.994069508@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 10:16:03AM +0100, Peter Zijlstra wrote:
> @@ -2193,6 +2232,12 @@ static int update_cfi_state(struct instr
>  			/* mov reg, disp(%rsp) */
>  			save_reg(cfi, op->src.reg, CFI_CFA,
>  				 op->dest.offset - cfi->stack_size);
> +
> +		} else if (op->src.reg == CFI_SP && op->dest.offset == 0) {
> +
> +			/* mov %rsp, (%reg); # setup a stack swizzle. */
> +			cfi->vals[op->dest.reg].base = CFI_SP_INDIRECT;
> +			cfi->vals[op->dest.reg].offset = cfi->cfa.offset;

I'll change that to:

			cfi->vals[op->dest.reg].offset = cfa->offset;

To be more consistent with the rest of the code.

>  		}
>  
>  		break;
> 
> 
