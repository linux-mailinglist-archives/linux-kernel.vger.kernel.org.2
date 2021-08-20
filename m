Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490513F28B6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 10:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbhHTIyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 04:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbhHTIyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 04:54:03 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECE0C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 01:53:25 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k8so13114354wrn.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 01:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=muVxSSnWXrAGYCBfONFivzVwtzwUv5AlDfVwR+hS/y0=;
        b=YI4N8XTnAxShJ13vkSRvtaLf2+3vhldsVLM2/tsQxs2XsLTuBXF+lQJ5FEZrTJgy5v
         s7lEuAYomX9HEI0icY5Z8Pxs3m8PjIqr0phaDGQov2+mZrmWX/YWkvdyMKZPjcMilZ1L
         m3ZQhCe83k38e89DQHoNlSsqUXUvN/2NCjBhvVU1sEUosworvcPfixe+/pegHkXoTRPs
         juvI3WN3ThWxw/g4jKXIgh9U8K610MNQ8AGCSw7t8lAu27iq0zS0gC5fKby2hck4Hk+C
         szE2s3lThKLnqi+HQjGESGSANADL5V6Nu/Fe5jHoZNGgrZAQLGXsV6O967m+GwpoLUSd
         nO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=muVxSSnWXrAGYCBfONFivzVwtzwUv5AlDfVwR+hS/y0=;
        b=FstbINPvHuYwpGmjHQzx+YAHT9x4bXLyCL86x6+0rRaZSQBaLdx2HVD+R5lsIRrKBQ
         ZNdTQ3pCnkXAWPhU3r9H6kWVH49e/P5kB+GiaE+hHZWbDo7L/ZE469uLqiDJQIp7d8UR
         XnS3JLI4ECtQ8yXHpKrHL3ZTSM0/JoZDw+ZsTkhqUWvVkw5Ck8exITV+7qaSfwh02dx8
         kbntrRCP0QudTiSMM1Vd0TNqxj2HrG5IvfGDG1dm2lPhrD56g1ksG9hoU0/28N3/L9Sx
         VU+IAofJIh7V0kzsRTuoT7l+XPdH2cFEKnwb5AKVkayTU0tpyVEhOq8HQMAFVeOaCIg3
         BcKw==
X-Gm-Message-State: AOAM532MHEZYHGjhMD/N9mZWTYhkLvQAqJ9Au62ClFYw8PrTc8JuXAlQ
        OoXldwh5Vn2EmFhYTzO3b4PBuQ==
X-Google-Smtp-Source: ABdhPJzH3DIzHUq9oFHpk7M6g/EnGB2FPr7fK544S9iA2FVuCrfVU2QT32vXluI0GoMAt2gM9ZEaRA==
X-Received: by 2002:a5d:50cd:: with SMTP id f13mr8735656wrt.68.1629449603803;
        Fri, 20 Aug 2021 01:53:23 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c378:b01b:5d2d:5223? ([2a01:e34:ed2f:f020:c378:b01b:5d2d:5223])
        by smtp.googlemail.com with ESMTPSA id k1sm5441971wrz.61.2021.08.20.01.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 01:53:23 -0700 (PDT)
Subject: Re: [PATCH 2/2] clocksource/drivers/fttmr010: Be stricter on IRQs
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
        Joel Stanley <joel@jms.id.au>
References: <20210724224424.2085404-1-linus.walleij@linaro.org>
 <20210724224424.2085404-2-linus.walleij@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e997cca5-e6d4-1aac-4e0c-de15d7664a1b@linaro.org>
Date:   Fri, 20 Aug 2021 10:53:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210724224424.2085404-2-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2021 00:44, Linus Walleij wrote:
> Make sure we check that the right interrupt occurred before
> calling the event handler for timer 1. Report spurious IRQs
> as IRQ_NONE.

Does it not mean there is something wrong with the initial setup ?


> Cc: Cédric Le Goater <clg@kaod.org>
> Cc: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/clocksource/timer-fttmr010.c | 32 +++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
> index 126fb1f259b2..de29d424ec95 100644
> --- a/drivers/clocksource/timer-fttmr010.c
> +++ b/drivers/clocksource/timer-fttmr010.c
> @@ -253,20 +253,36 @@ static int fttmr010_timer_set_periodic(struct clock_event_device *evt)
>   */
>  static irqreturn_t fttmr010_timer_interrupt(int irq, void *dev_id)
>  {
> -	struct clock_event_device *evt = dev_id;
> +	struct fttmr010 *fttmr010 = dev_id;
> +	struct clock_event_device *evt = &fttmr010->clkevt;
> +	u32 val;
> +
> +	val = readl(fttmr010->base + TIMER_INTR_STATE);
> +	if (val & (TIMER_1_INT_MATCH1 | TIMER_1_INT_OVERFLOW))
> +		evt->event_handler(evt);
> +	else
> +		/* Spurious IRQ */
> +		return IRQ_NONE;
>  
> -	evt->event_handler(evt);
>  	return IRQ_HANDLED;
>  }
>  
>  static irqreturn_t ast2600_timer_interrupt(int irq, void *dev_id)
>  {
> -	struct clock_event_device *evt = dev_id;
> -	struct fttmr010 *fttmr010 = to_fttmr010(evt);
> +	struct fttmr010 *fttmr010 = dev_id;
> +	struct clock_event_device *evt = &fttmr010->clkevt;
> +	u32 val;
>  
> -	writel(0x1, fttmr010->base + TIMER_INTR_STATE);
> +	val = readl(fttmr010->base + TIMER_INTR_STATE);
> +	if (val & (TIMER_1_INT_MATCH1 | TIMER_1_INT_OVERFLOW)) {
> +		writel(TIMER_1_INT_MATCH1, fttmr010->base + TIMER_INTR_STATE);
> +		evt->event_handler(evt);
> +	} else {
> +		/* Just clear any spurious IRQs from the block */
> +		writel(val, fttmr010->base + TIMER_INTR_STATE);
> +		return IRQ_NONE;
> +	}
>  
> -	evt->event_handler(evt);
>  	return IRQ_HANDLED;
>  }
>  
> @@ -384,12 +400,12 @@ static int __init fttmr010_common_init(struct device_node *np,
>  		fttmr010->timer_shutdown = ast2600_timer_shutdown;
>  		ret = request_irq(irq, ast2600_timer_interrupt,
>  				  IRQF_TIMER, "FTTMR010-TIMER1",
> -				  &fttmr010->clkevt);
> +				  fttmr010);
>  	} else {
>  		fttmr010->timer_shutdown = fttmr010_timer_shutdown;
>  		ret = request_irq(irq, fttmr010_timer_interrupt,
>  				  IRQF_TIMER, "FTTMR010-TIMER1",
> -				  &fttmr010->clkevt);
> +				  fttmr010);
>  	}
>  	if (ret) {
>  		pr_err("FTTMR010-TIMER1 no IRQ\n");
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
