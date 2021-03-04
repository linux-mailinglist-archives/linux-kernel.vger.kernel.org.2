Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A4B32D8FD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhCDRvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhCDRvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:51:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D164FC061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 09:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2DW2Co0RB9xg4b5eFIAQN/5DusRN3w46IBcu9lfCL7k=; b=sHygGiG5iQntfv5psK65YlVbOf
        Xp+R4VB1kSMOgiL0e0GmCkpMmV5uvqgVkBMlaUoDkWPDq645fPKC0krxdQsO35vObLl7HQgN0W8nr
        VaByTxONNky7eFUzySp25hU2eJvXYzolx9FZqMgLKfuDcTCqCf6PUV54pMRIvRjVLXmlDdCqJuozf
        XL9ly3SMoqFOxo7hG4n48rjZL0L9XHTNQJe3VepSCXFP6OdirBw7QY8MlBjrrjYiepf4r7W87QbL2
        BTysae37mE0xTKt8q3ZAlR7qdjTpvU/QJsnsfxT2Gu1tGx85xljkFftDg/TU94H0TfJyaW5W3PxHC
        4jMQMIXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lHs66-0084OS-7t; Thu, 04 Mar 2021 17:49:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 74244307890;
        Thu,  4 Mar 2021 18:49:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 558982D959140; Thu,  4 Mar 2021 18:49:08 +0100 (CET)
Date:   Thu, 4 Mar 2021 18:49:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 17/21] tools/objtool: Convert to insn_decode()
Message-ID: <YEEdlNN3OIi59hbr@hirez.programming.kicks-ass.net>
References: <20210304174237.31945-1-bp@alien8.de>
 <20210304174237.31945-18-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304174237.31945-18-bp@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 06:42:33PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Simplify code, no functional changes.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  tools/objtool/arch/x86/decode.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
> index 549813cff8ab..8380d0b1d933 100644
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -90,7 +90,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
>  			    struct list_head *ops_list)
>  {
>  	struct insn insn;
> -	int x86_64, sign;
> +	int x86_64, sign, ret;
>  	unsigned char op1, op2, rex = 0, rex_b = 0, rex_r = 0, rex_w = 0,
>  		      rex_x = 0, modrm = 0, modrm_mod = 0, modrm_rm = 0,
>  		      modrm_reg = 0, sib = 0;

This is going to have trivial rejects/fuzz against tip/objtool/core.
