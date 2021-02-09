Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE8E3153FC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 17:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhBIQfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 11:35:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52112 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232825AbhBIQem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:34:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612888397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TpPewHFE2MVqf9Z/Y4xQ1jlFtNOfgvwTnjX04XxYNLs=;
        b=GutnhLNMCB0KjWhH/GuZb/GJGMsXDGc0LDfnYBaDzdFe3lAad16ARC9+za4WluI4PqdQmh
        cFJLHt0621exACRd/TEG1FZWPup/enHZ1ax8Bn7JYTh7OTVM14KCARn6uNkOmUVZQCpEM0
        XlGs5FtDLhvr6SjuciNaGDMmmYCSSNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-p-MvxQByOjiYbZifaadn7w-1; Tue, 09 Feb 2021 11:33:13 -0500
X-MC-Unique: p-MvxQByOjiYbZifaadn7w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5141F107AD90;
        Tue,  9 Feb 2021 16:32:58 +0000 (UTC)
Received: from treble (ovpn-120-169.rdu2.redhat.com [10.10.120.169])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4992560BD9;
        Tue,  9 Feb 2021 16:32:57 +0000 (UTC)
Date:   Tue, 9 Feb 2021 10:32:55 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] objtool,x86: Additionally decode: mov %rsp, (%reg)
Message-ID: <20210209163255.epr2gxndsweyfpzi@treble>
References: <20210209091600.075402197@infradead.org>
 <20210209093521.924097404@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210209093521.924097404@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 10:16:02AM +0100, Peter Zijlstra wrote:
> Where we already decode: mov %rsp, %reg, also decode mov %rsp, (%reg).
> 
> Nothing should match for this new stack-op.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  tools/objtool/arch/x86/decode.c |   23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -222,14 +222,24 @@ int arch_decode_instruction(const struct
>  		break;
>  
>  	case 0x89:
> -		if (rex_w && !rex_r && modrm_mod == 3 && modrm_reg == 4) {
> +		if (rex_w && !rex_r && modrm_reg == 4) {
>  
> -			/* mov %rsp, reg */
> +			/* mov %rsp, */
>  			ADD_OP(op) {
>  				op->src.type = OP_SRC_REG;
>  				op->src.reg = CFI_SP;
> -				op->dest.type = OP_DEST_REG;
> -				op->dest.reg = op_to_cfi_reg[modrm_rm][rex_b];
> +				if (modrm_mod == 3) {
> +
> +					/* mov %rsp, reg */
> +					op->dest.type = OP_DEST_REG;
> +					op->dest.reg = op_to_cfi_reg[modrm_rm][rex_b];
> +
> +				} else if (modrm_mod == 0) {
> +
> +					/* mov %rsp, (%reg) */
> +					op->dest.type = OP_DEST_REG_INDIRECT;
> +					op->dest.reg = op_to_cfi_reg[modrm_rm][rex_b];
> +				}

What if modrm_mod is 1 or 2?   Should 'if' below the 'case' make sure
it's 0 or 3?

>  			}
>  			break;
>  		}
> @@ -259,8 +269,10 @@ int arch_decode_instruction(const struct
>  				op->dest.reg = CFI_BP;
>  				op->dest.offset = insn.displacement.value;
>  			}
> +			break;
> +		}
>  
> -		} else if (rex_w && !rex_b && modrm_rm == 4 && sib == 0x24) {
> +		if (rex_w && !rex_b && modrm_rm == 4 && sib == 0x24) {
>  
>  			/* mov reg, disp(%rsp) */
>  			ADD_OP(op) {
> @@ -270,6 +282,7 @@ int arch_decode_instruction(const struct
>  				op->dest.reg = CFI_SP;
>  				op->dest.offset = insn.displacement.value;
>  			}
> +			break;
>  		}
>  
>  		break;
> 

Did this change have a point?

-- 
Josh

