Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555C8322A70
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 13:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbhBWMYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 07:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbhBWMYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 07:24:14 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F58CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 04:23:34 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 21F753D5; Tue, 23 Feb 2021 13:23:31 +0100 (CET)
Date:   Tue, 23 Feb 2021 13:23:27 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/sev-es: Remove subtraction of res variable
Message-ID: <20210223122327.GA9649@8bytes.org>
References: <20210223111130.16201-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223111130.16201-1-bp@alien8.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 12:11:30PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> vc_decode_insn() calls copy_from_kernel_nofault() by way of
> vc_fetch_insn_kernel() to fetch 15 bytes max of opcodes to decode.
> 
> copy_from_kernel_nofault() returns negative on error and 0 on success.
> The error case is handled by returning ES_EXCEPTION.
> 
> In the success case, the ret variable which contains the return value is
> 0 so there's no need to subtract it from MAX_INSN_SIZE when initializing
> the insn buffer for further decoding. Remove it.
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>

Reviewed-by: Joerg Roedel <jroedel@suse.de>

> ---
>  arch/x86/kernel/sev-es.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
> index 84c1821819af..1e78f4bd7bf2 100644
> --- a/arch/x86/kernel/sev-es.c
> +++ b/arch/x86/kernel/sev-es.c
> @@ -267,7 +267,7 @@ static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
>  			return ES_EXCEPTION;
>  		}
>  
> -		insn_init(&ctxt->insn, buffer, MAX_INSN_SIZE - res, 1);
> +		insn_init(&ctxt->insn, buffer, MAX_INSN_SIZE, 1);
>  		insn_get_length(&ctxt->insn);
>  	}
>  
> -- 
> 2.29.2
