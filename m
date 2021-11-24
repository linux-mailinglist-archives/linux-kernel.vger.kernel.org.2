Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD6645B7CB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 10:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239916AbhKXJx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 04:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbhKXJxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 04:53:24 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154D2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 01:50:15 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id v22so2038623qtx.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 01:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a4UIF5PwI9JEhE41/mv5NdEHtmlln1VA/6VmE86RQ7E=;
        b=bdEK2MiflBM0Wl3B08XP+LZ4MgpveoqVSTXe+kqJqhmfq0g7qEXgkGo6XTK/KxVDMd
         +ZoS7gklT9ARQX9fckgEmhOPY2FwWY+vQu0nvK3gEeznITkZu1rGSaIz5w/h1mxk0whY
         U01/WvhuM7gXlEz0eQ6Tzu7t9i335xEahXm1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a4UIF5PwI9JEhE41/mv5NdEHtmlln1VA/6VmE86RQ7E=;
        b=W59CY83TcTvo35bBKBcNpO4J5ovttaRhEe8jYxuUtweHJmA6E2ak8JoVy/oCbO1eKp
         gO2m5bzDkE3PLUdkeXShGzZzI9fsYjqYwyHP67M34jeK1diIWIR8cpLsxDb9PTh8nXdJ
         V3eROImNdYb6FeGyNr6EcJHkgkjeuqhUb+VkF+ChTDrTYTm4dwYSOBDPiUUKYPm2Ym2Z
         BGBgk+90mKsOh0wLm9VHMnv+SGSNEvxjT0Ryeu27kcOxS/LOmS1NoA8Rs9HiZWlYpV2K
         J1PXg4Q/a+CTf9xFBdOdcSkLWoOQHMgC+3ai+onbLWFv0aD5YCgmPOt5cfl3vF1JiJTq
         ixlA==
X-Gm-Message-State: AOAM533eSTFyzJQhdjDNgq+RiUUxscu9FDIwUsufqU7iQRsJEPxAKCL3
        S+qrd+Xb/rgg1s+Fr2xep9huRGIXk44TlrwHtjE=
X-Google-Smtp-Source: ABdhPJy6GzbB4D2zJxxVEqK2rARHn/wnYym2enOfxFcyg3IVpUwCOOxs306fuf/cj8vsEhKRcMJCw5thQh+kvqODXXE=
X-Received: by 2002:ac8:674a:: with SMTP id n10mr5160904qtp.145.1637747414112;
 Wed, 24 Nov 2021 01:50:14 -0800 (PST)
MIME-Version: 1.0
References: <20211124094348.11621-1-billy_tsai@aspeedtech.com>
In-Reply-To: <20211124094348.11621-1-billy_tsai@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 24 Nov 2021 09:50:01 +0000
Message-ID: <CACPK8XeyCbKzjPF6sSj=CZOd3dYmyAzhZDFRRDERMHykwvSMAg@mail.gmail.com>
Subject: Re: [PATCH] irqchip: Replace update_bits with write_bits.
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     Eddie James <eajames@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021 at 09:43, Billy Tsai <billy_tsai@aspeedtech.com> wrote:
>
> The interrupt status bits are cleared by writing 1, we should force a
> write to clear the interrupt without checking if the value has changed.
>
> Fixes: 04f605906ff0 ("irqchip: Add Aspeed SCU interrupt controller")
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Good catch. This should go to stable too.

Reviewed-by: Joel Stanley <joel@jms.id.au>

Is there any reason to use the regmap abstraction in this driver?
AFAICT the registers aren't shared, so we could replace the regmap
calls with readl/writel. Such a cleanup probably wouldn't be
backported, so this patch is still useful.

> ---
>  drivers/irqchip/irq-aspeed-scu-ic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed-scu-ic.c
> index f3c6855a4cef..18b77c3e6db4 100644
> --- a/drivers/irqchip/irq-aspeed-scu-ic.c
> +++ b/drivers/irqchip/irq-aspeed-scu-ic.c
> @@ -76,8 +76,8 @@ static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
>                 generic_handle_domain_irq(scu_ic->irq_domain,
>                                           bit - scu_ic->irq_shift);
>
> -               regmap_update_bits(scu_ic->scu, scu_ic->reg, mask,
> -                                  BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT));
> +               regmap_write_bits(scu_ic->scu, scu_ic->reg, mask,
> +                                 BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT));
>         }
>
>         chained_irq_exit(chip, desc);
> --
> 2.25.1
>
