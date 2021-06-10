Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB31D3A24B0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 08:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhFJGqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 02:46:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39876 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhFJGqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 02:46:37 -0400
Received: from mail-wm1-f71.google.com ([209.85.128.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lrEQj-0005Iy-2W
        for linux-kernel@vger.kernel.org; Thu, 10 Jun 2021 06:44:41 +0000
Received: by mail-wm1-f71.google.com with SMTP id v25-20020a1cf7190000b0290197a4be97b7so2661058wmh.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 23:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZIH1YbpeqNHlMEBnKgKmQmbv724BvB7zNbPXQ0+g4iI=;
        b=KXALFmUP64DQAPX7WbUVDAen17u8uknAJiSTHOf5Uum31YUgYc9xxeZpunYul3IY38
         FrHKRUDVv3U1QSVeKCstvIShLiVmqj0ABgL2Np8O77LINEsH00jbOeB5+1cL+oiunX2w
         OW6M+DrZRplwHk3Z51497kWpESS7tTI/y09NlkNogNQyBpsWS/NlVF7kJ4Jwq81dY12E
         xArgMg0pN4x2IMDf16Bt6tnkUZkedaCIObsDqY7nMcfwBWY3K6tnSTRU+m05/LcVpoG+
         T1NxZE7dN7MXiQxy5t8JNDSDbL3HGK13eMPgzjJB5O5zutWyxxjLUoKLQtidx11jDLn8
         diIQ==
X-Gm-Message-State: AOAM531/kKNU4I4BvbK1LTNhk50QOHvyt62jbD99ErOxXQpQwfAnl0EF
        lz5ng8E+yHtpImqSaxfq3E8cJh/x4C6JqOjjACDqFXMg0ui3TQ5MvDtFsD7qVhDwbQdCFmU20F4
        NFdLlU9ZMOy1jzW+OUTQwcrc0PGCCoidlH88ovN0R/g==
X-Received: by 2002:a7b:c44f:: with SMTP id l15mr13534859wmi.151.1623307480514;
        Wed, 09 Jun 2021 23:44:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPyiGqI2GWbCsI6J6N5fwz5wdl2B6k+bXM/ln08oHjXkJRT4CwBQGCjoKdKK7cFdZIe6d06g==
X-Received: by 2002:a7b:c44f:: with SMTP id l15mr13534844wmi.151.1623307480347;
        Wed, 09 Jun 2021 23:44:40 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id i9sm2854026wrn.54.2021.06.09.23.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 23:44:39 -0700 (PDT)
Subject: Re: [PATCH 1/1] irqchip/exynos-combiner: remove unnecessary oom
 message
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210609140335.14425-1-thunder.leizhen@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <99380b46-d677-822a-fb46-7a1a59e559ad@canonical.com>
Date:   Thu, 10 Jun 2021 08:44:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210609140335.14425-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2021 16:03, Zhen Lei wrote:
> Fixes scripts/checkpatch.pl warning:
> WARNING: Possible unnecessary 'out of memory' message
> 
> Remove it can help us save a bit of memory.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/irqchip/exynos-combiner.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/exynos-combiner.c b/drivers/irqchip/exynos-combiner.c
> index 14106126cbf3262..552aa04ff063123 100644
> --- a/drivers/irqchip/exynos-combiner.c
> +++ b/drivers/irqchip/exynos-combiner.c
> @@ -177,10 +177,8 @@ static void __init combiner_init(void __iomem *combiner_base,
>  	nr_irq = max_nr * IRQ_IN_COMBINER;
>  
>  	combiner_data = kcalloc(max_nr, sizeof (*combiner_data), GFP_KERNEL);
> -	if (!combiner_data) {
> -		pr_warn("%s: could not allocate combiner data\n", __func__);
> +	if (!combiner_data)
>  		return;
> -	}
>  
>  	combiner_irq_domain = irq_domain_add_linear(np, nr_irq,
>  				&combiner_irq_domain_ops, combiner_data);
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
