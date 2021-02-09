Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5969B31543E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 17:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbhBIQq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 11:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbhBIQnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:43:04 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DC3C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 08:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GCUCgWrw3gm85lFgy7Enr/nqnYPKWtudEizUO/rcNQ0=; b=YdjXtDxQ3cfGSVhL2/05QbbqqH
        nzNhJwFFfnlehGdzNugz5IVv3nLAeB02Suge1b9JoDKfBXjhIU4EqUuaybty4uNEERRnUUAok45HJ
        +KvrKZgI/Nes4e4ufVT33ask1utXEFV3NNDlCkJ7+9/27matn01NGqoxghxvF4mdPN7FiwjaoioaU
        +CI8cv3dKjl8k0PL3Sid7z0ck7imW/8nJOtqfmuJSDFZhjhhfAn2i+ydKSKwvZ1Uf4QkjSRJVsXse
        1Hx7a71m5xf0FxufiWfvYuep1wJ7sNNHW62+d8yjoyZG7nIm6socntwH0wh45LQ7cg6Up5/Rrv6j9
        eH3kLtqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l9W5e-00018w-PS; Tue, 09 Feb 2021 16:42:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5F64E304BAE;
        Tue,  9 Feb 2021 17:42:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4AF6F20084EA1; Tue,  9 Feb 2021 17:42:13 +0100 (CET)
Date:   Tue, 9 Feb 2021 17:42:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] objtool,x86: Additionally decode: mov %rsp, (%reg)
Message-ID: <YCK7ZYt92ZFeD5IE@hirez.programming.kicks-ass.net>
References: <20210209091600.075402197@infradead.org>
 <20210209093521.924097404@infradead.org>
 <20210209163255.epr2gxndsweyfpzi@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209163255.epr2gxndsweyfpzi@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 10:32:55AM -0600, Josh Poimboeuf wrote:
> On Tue, Feb 09, 2021 at 10:16:02AM +0100, Peter Zijlstra wrote:
> > Where we already decode: mov %rsp, %reg, also decode mov %rsp, (%reg).
> > 
> > Nothing should match for this new stack-op.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  tools/objtool/arch/x86/decode.c |   23 ++++++++++++++++++-----
> >  1 file changed, 18 insertions(+), 5 deletions(-)
> > 
> > --- a/tools/objtool/arch/x86/decode.c
> > +++ b/tools/objtool/arch/x86/decode.c
> > @@ -222,14 +222,24 @@ int arch_decode_instruction(const struct
> >  		break;
> >  
> >  	case 0x89:
> > -		if (rex_w && !rex_r && modrm_mod == 3 && modrm_reg == 4) {
> > +		if (rex_w && !rex_r && modrm_reg == 4) {
> >  
> > -			/* mov %rsp, reg */
> > +			/* mov %rsp, */
> >  			ADD_OP(op) {
> >  				op->src.type = OP_SRC_REG;
> >  				op->src.reg = CFI_SP;
> > -				op->dest.type = OP_DEST_REG;
> > -				op->dest.reg = op_to_cfi_reg[modrm_rm][rex_b];
> > +				if (modrm_mod == 3) {
> > +
> > +					/* mov %rsp, reg */
> > +					op->dest.type = OP_DEST_REG;
> > +					op->dest.reg = op_to_cfi_reg[modrm_rm][rex_b];
> > +
> > +				} else if (modrm_mod == 0) {
> > +
> > +					/* mov %rsp, (%reg) */
> > +					op->dest.type = OP_DEST_REG_INDIRECT;
> > +					op->dest.reg = op_to_cfi_reg[modrm_rm][rex_b];
> > +				}
> 
> What if modrm_mod is 1 or 2?   Should 'if' below the 'case' make sure
> it's 0 or 3?

For 1,2 we need to look at the SIB byte or something. IIRC you get that
encoding for stuff like: mov %rsp, off(%reg).

Didn't want to dive too deep into the instruction encoding thing again,
this is all we need.

> >  			}
> >  			break;
> >  		}
> > @@ -259,8 +269,10 @@ int arch_decode_instruction(const struct
> >  				op->dest.reg = CFI_BP;
> >  				op->dest.offset = insn.displacement.value;
> >  			}
> > +			break;
> > +		}
> >  
> > -		} else if (rex_w && !rex_b && modrm_rm == 4 && sib == 0x24) {
> > +		if (rex_w && !rex_b && modrm_rm == 4 && sib == 0x24) {
> >  
> >  			/* mov reg, disp(%rsp) */
> >  			ADD_OP(op) {
> > @@ -270,6 +282,7 @@ int arch_decode_instruction(const struct
> >  				op->dest.reg = CFI_SP;
> >  				op->dest.offset = insn.displacement.value;
> >  			}
> > +			break;
> >  		}
> >  
> >  		break;
> > 
> 
> Did this change have a point?

Consistency, but yeah, I see what you mean.
