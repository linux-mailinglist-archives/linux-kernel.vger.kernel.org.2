Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9B243E6D2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 19:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhJ1RKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 13:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhJ1RKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 13:10:01 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15C6C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 10:07:34 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so9530372ote.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 10:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gZBgjz3etReQLTYp9UvuJj0WkrqB5NTdLLhetv3xijo=;
        b=C06U+26Ot/OLH0XlOSu84+pH/2WwhGGpzP2pUvYa8eCny8+/OyEGUV7s+xYsb2rQIG
         kyNay3It4UiRk9NCzz7AcIn9e+qhQe3DRwuGJa9k7xsE8LEcxNd0a3HdalhDl8kQ3xrr
         9MCPMc0j85G57l64mUVVvibVhj+r0FZX5yhjFPn4zoph5WrN4xW2jxBGXDWDwhHrD3Oc
         QeidVvZSpR/0H5AJqYlaw/RfC6WfKTigtNcoHo5iukngzNoh/3xWWSqyOyNzmmlZUe/s
         HGfxQ6d9yEHf3kyjjXOtPF/veqT6lkxCNrcyJlrfHyYGqLqpF9UnEfRXzb3Tid0u8GQ/
         fc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=gZBgjz3etReQLTYp9UvuJj0WkrqB5NTdLLhetv3xijo=;
        b=d0liEUYWw/s1So4ELPwjm5Z8rJeQf9TDRnd2J3iKPHWYcs15izUNMnueSJSy3g79gO
         HT0Yw3B1lt42oqqLrSaw+E9iSY7Fzc90Z113hkogcMmHMG7JqGkPhRbtgod/VcOS/bp9
         +rijk3dFvd9NfoGRiM7FVj5txZxiTFS3KdAXfj9Qi7l1KEpsi1sdFHYWAPYl/Ch+ca97
         Kge7wFx5/J+uIB2sovkuT7pSd+mEmNl0+pwtkbSELREDGfhKZ0huaEPutlOx+I4fk5Nu
         7FFSr7S0dRuqvtCj8lbC/aaB/mjohhjiaWJ2hOSz7/cw/KcXo0faCkEUdCjee8F+4V0w
         Ih3w==
X-Gm-Message-State: AOAM532BcBWdBQmMC/HiQVrxKu0FSz7GJwZNxHouzCEHL1BRhKio3dEm
        dkmT3en4OC29BUqDjI1lhkw=
X-Google-Smtp-Source: ABdhPJwqgUEP7rJvCkru1GLDfPLZkWmcZIcHmgnaF4zzZDcAPlCCxNbWKoRDKtOJpezhLekHQvxfxw==
X-Received: by 2002:a9d:d84:: with SMTP id 4mr4332743ots.383.1635440854093;
        Thu, 28 Oct 2021 10:07:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p190sm1135256ooa.1.2021.10.28.10.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 10:07:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 28 Oct 2021 10:07:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        catalin.marinas@arm.com, deanbo422@gmail.com, green.hu@gmail.com,
        guoren@kernel.org, jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        maz@kernel.org, nickhu@andestech.com, palmer@dabbelt.com,
        paulmck@kernel.org, paul.walmsley@sifive.com, peterz@infradead.org,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        tsbogend@alpha.franken.de, vgupta@kernel.org, will@kernel.org
Subject: Re: [PATCH 03/15] irq: mips: simplify do_domain_IRQ()
Message-ID: <20211028170732.GA507928@roeck-us.net>
References: <20211021180236.37428-1-mark.rutland@arm.com>
 <20211021180236.37428-4-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021180236.37428-4-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 07:02:24PM +0100, Mark Rutland wrote:
> There's no need fpr arch/mips's do_domain_IRQ() to open-code the NULL
> check performed by handle_irq_desc(), nor the resolution of the desc
> performed by generic_handle_domain_irq().
> 
> Use generic_handle_domain_irq() directly, as this is functioanlly
> equivalent and clearer.
> 
> There should be no functional change as a result of this patch.
> 

Except for this compile error:

arch/mips/kernel/irq.c: In function 'do_domain_IRQ':
arch/mips/kernel/irq.c:114:26: error: unused variable 'desc' [-Werror=unused-variable]
  114 |         struct irq_desc *desc;

Guenter

> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/mips/kernel/irq.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
> index d20e002b3246..1fee96ef8059 100644
> --- a/arch/mips/kernel/irq.c
> +++ b/arch/mips/kernel/irq.c
> @@ -115,11 +115,7 @@ void __irq_entry do_domain_IRQ(struct irq_domain *domain, unsigned int hwirq)
>  
>  	irq_enter();
>  	check_stack_overflow();
> -
> -	desc = irq_resolve_mapping(domain, hwirq);
> -	if (likely(desc))
> -		handle_irq_desc(desc);
> -
> +	generic_handle_domain_irq(domain, hwirq);
>  	irq_exit();
>  }
>  #endif
> -- 
> 2.11.0
> 
