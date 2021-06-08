Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B26039F869
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbhFHOGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:06:40 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:35426 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbhFHOGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:06:39 -0400
Received: by mail-wr1-f43.google.com with SMTP id m18so21736070wrv.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 07:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NaK1+lYG1Dq2ohG86ztg+A+J19QU+VeexGuHlrBTL4M=;
        b=QnR0ZPeDMVl5mFkTYoygIuB2xrRtp7A5EldyhgMPKAHRC4Zz+elCvghiHn+3QJhqVW
         X4NhajY9aUbN8z00rH6unAvRvV7tOhqotN1kv61ATApWUUrBFCU7N2yInSJgXlLqsZmZ
         AADPPQ1MHoyhPmtZXZGiqjNWvfEuEXpPYockBslll/VkydgphiGndXQo7RSELtK0ezz3
         99/60z2PYTwT8Bkpg5sgmOTZ2t/wf+2Ok5HYL8ZXHIAaXU5arIuK2NUV10z01lXcGWdU
         EcqP4Vn5pOJ1xVz7YTJ3skG4iUACmK1OMjrIZqSpRQ6kghTcD6uAvFArRkkfvzDBDQEB
         HAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NaK1+lYG1Dq2ohG86ztg+A+J19QU+VeexGuHlrBTL4M=;
        b=og6DCxTPS0EZAR3hfCZvCea9bH51YHFctz6E3pOLGNziYxdmpxW6CDFmOM0nBhGOWf
         IxPV9Lhjw3ak2M4hOAE6UUnRAhXf8vJyaaixXmx6bYuMzIgkDZmE2wQHQxgd5v1Tdbza
         cq9ZoPlP5N9btWHtpnn1p6VKM6fAwHG1pkm66Aa8bNSijwNnIbqhCcmbo98oudSYaovH
         1yh7sUW0YrwLr/zK9nZkZwd98PziePcz8jocXjs2fO6SpOdoab6IC8BBtVefYkyFItEa
         i2/Zjm6nnp0ve4SH3XP6zpfPyyN3DFFhgU9357vAuUOJw5AUlbEYo5tskpAckzyc3E5Z
         uiwA==
X-Gm-Message-State: AOAM5322nL4wNUMQf7D4L9AXYQukw6kLiIzLeEzT7okXT76tSNjTe7lX
        zGj6eoUPlJHtJkm71nkWY6I=
X-Google-Smtp-Source: ABdhPJw7hiK5UyCsmwgNkBj09BL5a7zqwZAAPJozK804Fu94hcGYc6OWe1h82lrHqE7VIfU6yKq15Q==
X-Received: by 2002:a5d:4538:: with SMTP id j24mr5253449wra.391.1623161009316;
        Tue, 08 Jun 2021 07:03:29 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id j11sm7014740wmq.4.2021.06.08.07.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 07:03:28 -0700 (PDT)
Subject: Re: [PATCH] irqchip/irq-mst: Use ARCH_MSTARV7 as default value for
 MST_IRQ
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com
References: <20210607035943.30292-1-mark-pk.tsai@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <90e2330d-4e7b-17ed-1c63-eafdf6db89fa@gmail.com>
Date:   Tue, 8 Jun 2021 16:03:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210607035943.30292-1-mark-pk.tsai@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/06/2021 05:59, Mark-PK Tsai wrote:
> Only TV SoCs of Mediatek products have this controller
> which inherit from MStar TV SoCs.
> Don't enable it by default if ARCH_MEDIATEK is selected.
> Instead, use ARCH_MSTARV7 as default value.
> 
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> ---
>  drivers/irqchip/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 62543a4eccc0..30f578e18a11 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -576,7 +576,7 @@ config LOONGSON_PCH_MSI
>  config MST_IRQ
>  	bool "MStar Interrupt Controller"
>  	depends on ARCH_MEDIATEK || ARCH_MSTARV7 || COMPILE_TEST

We should also delete ARCH_MEDIATEK dependency.

Regards,
Matthias

> -	default ARCH_MEDIATEK
> +	default ARCH_MSTARV7
>  	select IRQ_DOMAIN
>  	select IRQ_DOMAIN_HIERARCHY
>  	help
> 
