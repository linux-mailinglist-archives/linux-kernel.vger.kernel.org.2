Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40A231C623
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 06:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhBPFEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 00:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhBPFEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 00:04:37 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3B4C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 21:03:57 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id y25so2155808pfp.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 21:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:newsgroups:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2YpI+iKoMZZUD3Z1xVREz1xTJJ25V96V4TT5cVOnFeQ=;
        b=Sd1wCKsRm91PkghmzuNllFKEYbNkzmmiBtJGHAFP945o+9bTMHEwf3y3LMCiPr3hps
         iYEisGYMSrq2GiJpHmtAlBhxmaeTOr9B3DoFiiwgCqhs5OuH+t0eXTvqwM3DCeAHZ4rN
         YGmG6W45DCwHgeB57UOq8/PDmeVp7+lOp/zxQzQL+RtCoJmeHZNjXEzwNuABuPkzcTyf
         FYkqOiOo1/XIJfJvAkEBDJfk0mcUC7HBPXwjHB5N5zeITdvaIFZBHLnMjYM1aGA02y0k
         n0yALGp6Sbt4mvwprS9mS/DYE+aUzesxmhYHQDG2m3EVvRlGW6zHa8hXUIehO7cx+658
         qhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:newsgroups:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2YpI+iKoMZZUD3Z1xVREz1xTJJ25V96V4TT5cVOnFeQ=;
        b=L0Fxy74bJHyQRaeQt3Pg4zS5/4oh+phebTzHov3Ymqwv2+6P8uIBepOqSBJFpl3A8V
         l8Agi9A8E+UNbgX4tL1rv7myO0ww+C9gw3r8ZowiHMmIuRvCtuai7IX2geWWNFwiICpQ
         oHCkax7FZwibOCo0QQd4OwyC163cHBOfWMeBvVA4ISdO8TRAN74E2UaUWocwfPC5MZsg
         LfX0dBVc4jx38mFDaqkW3HQzy0xBpRepbmIIxoWVsA8C28aLdnpJ1yxoSzrj3gQWZHnG
         oibn/jaPtutfzaNmUQT8vgjPDQhIDLXbJpcnDFDinoskCVLsa/HUlXOCF886cq9p6KF9
         6N5Q==
X-Gm-Message-State: AOAM530yPeRuZ6ExFU2lLqtPB2BN8K3L3KOtklx0u1ZQMpB/2pMwB7Qi
        TIvzmnWWoJ8TAf1v06S4E8A=
X-Google-Smtp-Source: ABdhPJw88S3vcPyT95UPrUdri00RZDU3YF1IpdwPKN0Vk6npYU9ZRmtrVm7cDBWIhxQaBWyZaz+sRw==
X-Received: by 2002:aa7:9056:0:b029:1db:7a51:56df with SMTP id n22-20020aa790560000b02901db7a5156dfmr18200294pfo.48.1613451836928;
        Mon, 15 Feb 2021 21:03:56 -0800 (PST)
Received: from [192.168.50.50] (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id c22sm16840180pfc.12.2021.02.15.21.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Feb 2021 21:03:56 -0800 (PST)
Sender: Vineet Gupta <vineetg76@gmail.com>
Subject: Re: [PATCH] arc: Replace lkml.org links with lore
To:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Alexey Brodkin <abrodkin@synopsys.com>,
        Joe Perches <joe@perches.com>,
        linux-snps-arc@lists.infradead.org
Newsgroups: gmane.linux.kernel,gmane.linux.kernel.arc
References: <20210210232849.1358703-1-keescook@chromium.org>
From:   Vineet Gupta <vgupta@synopsys.com>
Message-ID: <8d0dd35a-4bc2-6762-3ae9-a0bf38961f5a@synopsys.com>
Date:   Mon, 15 Feb 2021 21:03:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210210232849.1358703-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/21 3:28 PM, Kees Cook wrote:
> As started by commit 05a5f51ca566 ("Documentation: Replace lkml.org
> links with lore"), replace lkml.org links with lore to better use a
> single source that's more likely to stay available long-term.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Vineet Gupta <vgupta@synopsys.com>

Let me know if you want me to pick this up.

Thx,
-Vineet

> ---
>   arch/arc/include/asm/irqflags-compact.h | 8 ++++++--
>   arch/arc/mm/dma.c                       | 2 +-
>   arch/arc/plat-axs10x/axs10x.c           | 2 +-
>   arch/arc/plat-hsdk/platform.c           | 2 +-
>   4 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arc/include/asm/irqflags-compact.h b/arch/arc/include/asm/irqflags-compact.h
> index 863d63ad18d6..0d63e568d64c 100644
> --- a/arch/arc/include/asm/irqflags-compact.h
> +++ b/arch/arc/include/asm/irqflags-compact.h
> @@ -50,8 +50,12 @@
>    * are redone after IRQs are re-enabled (and gcc doesn't reuse stale register)
>    *
>    * Noted at the time of Abilis Timer List corruption
> - *	Orig Bug + Rejected solution	: https://lkml.org/lkml/2013/3/29/67
> - *	Reasoning			: https://lkml.org/lkml/2013/4/8/15
> + *
> + * Orig Bug + Rejected solution:
> + * https://lore.kernel.org/lkml/1364553218-31255-1-git-send-email-vgupta@synopsys.com
> + *
> + * Reasoning:
> + * https://lore.kernel.org/lkml/CA+55aFyFWjpSVQM6M266tKrG_ZXJzZ-nYejpmXYQXbrr42mGPQ@mail.gmail.com
>    *
>    ******************************************************************/
>   
> diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
> index 517988e60cfc..2a7fbbb83b70 100644
> --- a/arch/arc/mm/dma.c
> +++ b/arch/arc/mm/dma.c
> @@ -32,7 +32,7 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
>   
>   /*
>    * Cache operations depending on function and direction argument, inspired by
> - * https://lkml.org/lkml/2018/5/18/979
> + * https://lore.kernel.org/lkml/20180518175004.GF17671@n2100.armlinux.org.uk
>    * "dma_sync_*_for_cpu and direction=TO_DEVICE (was Re: [PATCH 02/20]
>    * dma-mapping: provide a generic dma-noncoherent implementation)"
>    *
> diff --git a/arch/arc/plat-axs10x/axs10x.c b/arch/arc/plat-axs10x/axs10x.c
> index 63ea5a606ecd..b821df7b0089 100644
> --- a/arch/arc/plat-axs10x/axs10x.c
> +++ b/arch/arc/plat-axs10x/axs10x.c
> @@ -50,7 +50,7 @@ static void __init axs10x_enable_gpio_intc_wire(void)
>   	 * Current implementation of "irq-dw-apb-ictl" driver doesn't work well
>   	 * with stacked INTCs. In particular problem happens if its master INTC
>   	 * not yet instantiated. See discussion here -
> -	 * https://lkml.org/lkml/2015/3/4/755
> +	 * https://lore.kernel.org/lkml/54F6FE2C.7020309@synopsys.com
>   	 *
>   	 * So setup the first gpio block as a passive pass thru and hide it from
>   	 * DT hardware topology - connect MB intc directly to cpu intc
> diff --git a/arch/arc/plat-hsdk/platform.c b/arch/arc/plat-hsdk/platform.c
> index b3ea1fa11f87..c4a875b22352 100644
> --- a/arch/arc/plat-hsdk/platform.c
> +++ b/arch/arc/plat-hsdk/platform.c
> @@ -52,7 +52,7 @@ static void __init hsdk_enable_gpio_intc_wire(void)
>   	 * Current implementation of "irq-dw-apb-ictl" driver doesn't work well
>   	 * with stacked INTCs. In particular problem happens if its master INTC
>   	 * not yet instantiated. See discussion here -
> -	 * https://lkml.org/lkml/2015/3/4/755
> +	 * https://lore.kernel.org/lkml/54F6FE2C.7020309@synopsys.com
>   	 *
>   	 * So setup the first gpio block as a passive pass thru and hide it from
>   	 * DT hardware topology - connect intc directly to cpu intc
> 

