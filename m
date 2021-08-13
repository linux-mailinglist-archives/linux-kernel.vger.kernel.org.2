Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F8D3EB618
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 15:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240642AbhHMNec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 09:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240095AbhHMNeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 09:34:31 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4D6C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 06:34:02 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z9so13247093wrh.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 06:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mN7MYIays/XFnrwXeEvXA0NNGnQRv8r6bR7JAyW0q9c=;
        b=dOI1WyQIyonl4RYgU8lq8nk0rZhyrAcDoofESYiX+9MsDn2bqylF6aWJ9EeedI5WV1
         Zfy/1nk2yrTl+8Ldl5qPE57v+rMjXzvQI1wDQo9J7dGMVGS4040BU3po6Y7sk0X1lKpy
         T2nIwlU9Khut0u6yOuVaUi+G5OZ8syKKA9j8ukHYfdyuU4a8LZMgTF+LQ3SIjlb9VAH2
         0fskJ1KV0H5Z7EH5Gh4RQ52JmPsUn8CkEMut2W0yTh3lmnV2ImuzfAm7ZGiflBmddEH4
         yOJoMLrOc742xBGE0M5W9yaUHmCmLZANUYCyRqUWlNh6InqJgzZCxTDpZTORm55wrlPB
         GUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mN7MYIays/XFnrwXeEvXA0NNGnQRv8r6bR7JAyW0q9c=;
        b=ersQuYSxHv+bI6y1+NqI1SxMptcuEoAmP4qZGZcerhoxikO9LnJrc/82pYzS+icpKU
         FKcOszZ70I0eQR2NsW5Y33RrnXKTOIoRmf1gQb7nnRXdOODMnFccjQTIbiAlbcsL/V5x
         Ts92BE6W12ZGqWIEUQmPSIy40JQGaDHpYcBUmGz1txGjlpjTKxceTIQJtseCeVuuwQVI
         VrQcIBtohU152OZRpWfJJsz2D+n9/GOll5gHC6/Iu3gpwWSmEwvqDCPaxdihIsjJdvCw
         VrUER8foO2+EX3BqBrZ8j+J0K3S+Z/kP+NG5mn7Jexupjk1AN2PVhfdeDQ4oHcatuLoL
         7lKw==
X-Gm-Message-State: AOAM530O+88Acr3bv9ygPNiMBIRSqSk/YZ2t9tSg5gdeiRoOZdBZDQgp
        udlvXGZaIe16rPgjbSewVuTkumggJilw44DK
X-Google-Smtp-Source: ABdhPJzu6Fum02kFZe4eIeCvjJGItdUESFvXsrKc9BrUKIqHYe63at4G+KHUAcH+XpUiGgSb+LI2VQ==
X-Received: by 2002:adf:e7d1:: with SMTP id e17mr334425wrn.151.1628861640388;
        Fri, 13 Aug 2021 06:34:00 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5df3:d0eb:3945:640d? ([2a01:e34:ed2f:f020:5df3:d0eb:3945:640d])
        by smtp.googlemail.com with ESMTPSA id d13sm1124997wra.70.2021.08.13.06.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 06:33:59 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] drivers/clocksource/timer-of: Remove __init
 markings
To:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210715065455.392923-1-zhang.lyra@gmail.com>
 <20210715065455.392923-2-zhang.lyra@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3a173a51-2abe-c1bf-41a5-d0be15290452@linaro.org>
Date:   Fri, 13 Aug 2021 15:33:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715065455.392923-2-zhang.lyra@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/2021 08:54, Chunyan Zhang wrote:
> From: Saravana Kannan <saravanak@google.com>
> 
> This allows timer drivers to be compiled as modules.

Why ?

These changes will create a precedence with the timers being loaded as
modules. A longer description is important.

Also, loading the timers may be fine but unloading them is not supported
AFAICT from the time framework. That should be described also and the
code should make sure the unloading will be never supported in any
module conversion.

> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  drivers/clocksource/timer-of.c | 17 +++++++++--------
>  drivers/clocksource/timer-of.h |  4 ++--
>  2 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
> index 529cc6a51cdb..7f108978fd51 100644
> --- a/drivers/clocksource/timer-of.c
> +++ b/drivers/clocksource/timer-of.c
> @@ -19,7 +19,7 @@
>   *
>   * Free the irq resource
>   */
> -static __init void timer_of_irq_exit(struct of_timer_irq *of_irq)
> +static void timer_of_irq_exit(struct of_timer_irq *of_irq)
>  {
>  	struct timer_of *to = container_of(of_irq, struct timer_of, of_irq);
>  
> @@ -47,7 +47,7 @@ static __init void timer_of_irq_exit(struct of_timer_irq *of_irq)
>   *
>   * Returns 0 on success, < 0 otherwise
>   */
> -static __init int timer_of_irq_init(struct device_node *np,
> +static int timer_of_irq_init(struct device_node *np,
>  				    struct of_timer_irq *of_irq)
>  {
>  	int ret;
> @@ -91,7 +91,7 @@ static __init int timer_of_irq_init(struct device_node *np,
>   *
>   * Disables and releases the refcount on the clk
>   */
> -static __init void timer_of_clk_exit(struct of_timer_clk *of_clk)
> +static void timer_of_clk_exit(struct of_timer_clk *of_clk)
>  {
>  	of_clk->rate = 0;
>  	clk_disable_unprepare(of_clk->clk);
> @@ -107,7 +107,7 @@ static __init void timer_of_clk_exit(struct of_timer_clk *of_clk)
>   *
>   * Returns 0 on success, < 0 otherwise
>   */
> -static __init int timer_of_clk_init(struct device_node *np,
> +static int timer_of_clk_init(struct device_node *np,
>  				    struct of_timer_clk *of_clk)
>  {
>  	int ret;
> @@ -146,12 +146,12 @@ static __init int timer_of_clk_init(struct device_node *np,
>  	goto out;
>  }
>  
> -static __init void timer_of_base_exit(struct of_timer_base *of_base)
> +static void timer_of_base_exit(struct of_timer_base *of_base)
>  {
>  	iounmap(of_base->base);
>  }
>  
> -static __init int timer_of_base_init(struct device_node *np,
> +static int timer_of_base_init(struct device_node *np,
>  				     struct of_timer_base *of_base)
>  {
>  	of_base->base = of_base->name ?
> @@ -165,7 +165,7 @@ static __init int timer_of_base_init(struct device_node *np,
>  	return 0;
>  }
>  
> -int __init timer_of_init(struct device_node *np, struct timer_of *to)
> +int timer_of_init(struct device_node *np, struct timer_of *to)
>  {
>  	int ret = -EINVAL;
>  	int flags = 0;
> @@ -209,6 +209,7 @@ int __init timer_of_init(struct device_node *np, struct timer_of *to)
>  		timer_of_base_exit(&to->of_base);
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(timer_of_init);
>  
>  /**
>   * timer_of_cleanup - release timer_of resources
> @@ -217,7 +218,7 @@ int __init timer_of_init(struct device_node *np, struct timer_of *to)
>   * Release the resources that has been used in timer_of_init().
>   * This function should be called in init error cases
>   */
> -void __init timer_of_cleanup(struct timer_of *to)
> +void timer_of_cleanup(struct timer_of *to)
>  {
>  	if (to->flags & TIMER_OF_IRQ)
>  		timer_of_irq_exit(&to->of_irq);
> diff --git a/drivers/clocksource/timer-of.h b/drivers/clocksource/timer-of.h
> index a5478f3e8589..1b8cfac5900a 100644
> --- a/drivers/clocksource/timer-of.h
> +++ b/drivers/clocksource/timer-of.h
> @@ -66,9 +66,9 @@ static inline unsigned long timer_of_period(struct timer_of *to)
>  	return to->of_clk.period;
>  }
>  
> -extern int __init timer_of_init(struct device_node *np,
> +extern int timer_of_init(struct device_node *np,
>  				struct timer_of *to);
>  
> -extern void __init timer_of_cleanup(struct timer_of *to);
> +extern void timer_of_cleanup(struct timer_of *to);
>  
>  #endif
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
