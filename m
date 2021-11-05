Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0949B4467F3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbhKERfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbhKERe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:34:59 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B4EC061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:32:19 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso3866011pjo.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 10:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P/IttwCntz6OefDEcqNm4d1DXbn/ikIeyFyLM4viNo0=;
        b=KPZfro/0ifS0qM0agHLRmY0b4Dq80Ai6CW+86yXbAEAx/MKmbUCG64tW/AB2kc6ZuZ
         8MDknf8TT5A2z9OnkGphsGplf1b6LxaDIjIE9pZ93xy3Th4bYjs7kFc3o6gyZ7apRUp7
         Kzwg9zEr1pqx+pXMesVIztTVf9D78YKhjuxnEt108VKnQRZuwTqlNV3ThcvzR3ObnqZk
         pzM8+27tMg9P5UKUeUTHi5jCJq36pseTMhgDiB0gRWVGA7OUslDVR8p2NYvDeX32Yf4+
         wMt1aQppI+Hapn0ghLOnSjsbWl93K+Ni9YdqTMbArbC6DCi/FpN6G29z7iLkDziGkTdu
         wzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P/IttwCntz6OefDEcqNm4d1DXbn/ikIeyFyLM4viNo0=;
        b=MNq4FQBD5pMOKziuspqpOaZKr2M4nUv4hxwPFOTA4VcWjIovPqQ4J+nOoaCC/YCyoA
         BVSdu5ejtENH5ZJnfuzLfpr4poZz16B9YpeByY+svtUvThgvTjyEz4ajuIvGVf2K280o
         pvEc9jwvmi5RFpYO41uAp16f3K0xhfcRvjzrVvLGAekZJ0YJ0CE1cQGcDFiHMlkVS9Q2
         1xrWeAmCWqx0cTpRRdG8FDQa1ouE59fQAydFYiCKEFqBf6HEVKf5LszjfWvHDAmIlAJI
         ODecw4wWmyQ3uewgUdJ/fjPR92pTCJwNyj7dHIqVVYSGp5+CT/Jj1RJghjoaEO29MCum
         d03w==
X-Gm-Message-State: AOAM530bLH0N+iYDrX7U95RinqAXfkvvSf9O2VgCLv6uxcfftptGmu7n
        g/udRbpA5rjK4WxmBzgpGWZgbw==
X-Google-Smtp-Source: ABdhPJxLmFXOHVGXxnaHleGj/B+7hceY0BWRDv9Lr+/s+BtbkcCzJPdtOUMBWrA4lxCRBmE9TkNxWA==
X-Received: by 2002:a17:90a:c85:: with SMTP id v5mr32266767pja.47.1636133538794;
        Fri, 05 Nov 2021 10:32:18 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z8sm6783739pgi.45.2021.11.05.10.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 10:32:18 -0700 (PDT)
Date:   Fri, 5 Nov 2021 17:32:14 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH 07/22] x86,extable: Extend extable functionality
Message-ID: <YYVqnr+gql9RpL4C@google.com>
References: <20211104164729.226550532@infradead.org>
 <20211104165524.925401847@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104165524.925401847@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021, Peter Zijlstra wrote:
> +static bool ex_handler_imm_reg(const struct exception_table_entry *fixup,
> +			       struct pt_regs *regs, int reg, int imm)
> +{
> +	*pt_regs_nr(regs, reg) = (long)imm;

This doesn't work for the -EFAULT case because despite being an 'int', @imm is
effectively an 'unsigned short'.  More below.

> +	return ex_handler_default(fixup, regs);
> +}
> +
> +#define EX_TYPE_MASK	0x000000FF
> +#define EX_REG_MASK	0x00000F00
> +#define EX_FLAG_MASK	0x0000F000
> +#define EX_IMM_MASK	0xFFFF0000
> +
>  int ex_get_fixup_type(unsigned long ip)
>  {
>  	const struct exception_table_entry *e = search_exception_tables(ip);
>  
> -	return e ? e->type : EX_TYPE_NONE;
> +	return e ? FIELD_GET(EX_TYPE_MASK, e->type) : EX_TYPE_NONE;
>  }
>  
>  int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
>  		    unsigned long fault_addr)
>  {
>  	const struct exception_table_entry *e;
> +	int type, reg, imm;
>  
>  #ifdef CONFIG_PNPBIOS
>  	if (unlikely(SEGMENT_IS_PNP_CODE(regs->cs))) {
> @@ -136,7 +181,11 @@ int fixup_exception(struct pt_regs *regs
>  	if (!e)
>  		return 0;
>  
> -	switch (e->type) {
> +	type = FIELD_GET(EX_TYPE_MASK, e->type);
> +	reg  = FIELD_GET(EX_REG_MASK,  e->type);
> +	imm  = FIELD_GET(EX_IMM_MASK,  e->type);

FIELD_GET casts the result based on the type of the mask, but doesn't explicitly
sign extend the masked field, i.e. there's no intermediate cast to tell the compiler
that the imm is a 16-bit value that should be sign extended.

Modifying FIELD_GET to sign extended is probably a bad idea as I'm guessing the
vast, vast majority of use cases don't want that behavior.  I'm not sure how that
would even work with masks that are e.g. 5 bits or so.

This hack makes things work as expected.

diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 9dc0685366e5..182d62c11404 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -223,7 +223,7 @@ int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,

        type = FIELD_GET(EX_TYPE_MASK, e->type);
        reg  = FIELD_GET(EX_REG_MASK,  e->type);
-       imm  = FIELD_GET(EX_IMM_MASK,  e->type);
+       imm  = (int)(short)FIELD_GET(EX_IMM_MASK,  e->type);

        switch (type) {
        case EX_TYPE_DEFAULT:


> +
> +	switch (type) {
>  	case EX_TYPE_DEFAULT:
>  	case EX_TYPE_DEFAULT_MCE_SAFE:
>  		return ex_handler_default(e, regs);
> @@ -165,6 +214,8 @@ int fixup_exception(struct pt_regs *regs
>  		break;
>  	case EX_TYPE_POP_SEG:
>  		return ex_handler_pop_seg(e, regs);
> +	case EX_TYPE_IMM_REG:
> +		return ex_handler_imm_reg(e, regs, reg, imm);
>  	}
>  	BUG();
>  }
> 
> 
