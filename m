Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1242543E75A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 19:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhJ1RbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 13:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhJ1RbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 13:31:18 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10D6C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 10:28:51 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id m11so4516727oif.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 10:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O9gKdfytpS0ETlomyYSsjGI4TqLquogD4Y9EGuDbpqo=;
        b=ZQ8OfmG8/00uBwV3v0/BRpFtsA7Qz1XmVA+MyHSoSh8WhmxB2jO79mcxWny3RnIHyy
         nO8AALjhFBfhgHY0ONW6E/nixyOEM7y0JmJ98Prj6T876lhBTTyRYlpUx5Ea3jcxgF98
         SIInIjVR8SRguYrww3oFixmpJIcA8W+wkcAZeaZ9WsUyBGGx3FMvWCm1evWhi6vvV9pf
         2AyJHER4LJJS0Lu+GPIvMYtRw5iZsuK2OlGWoJ/4p58M07ipcthcA/YUhu32XMWL1/+D
         HgU8EKY4lDoklB9D1P/rVZhzr0Dmts65KB4MXwkInhJH3e42jAgc4dF2hZCWwaqvw3On
         RWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=O9gKdfytpS0ETlomyYSsjGI4TqLquogD4Y9EGuDbpqo=;
        b=2gu+6U9SPkGzLlYuRG81Ydtw8X9XTYNaJV8z16jEP0vPIOfCeAQ2wp6SCpj6u6WFnE
         rFuHV/luTefgt3f37/q4tqM7A6YSLi+pXClSb4GQc5y5RwCxATv8+qhpUEkZIPH+Rj8H
         MyC1xQcWxM/0PZedqgCBQg7S7Uoaiix3DlXrSN/zhMFaDjPqQSzvSVQOTiEt5U1g1eGY
         +SswYY+8axZBdzH3B0UIQ7fsPuUOMoSJ1q9dSUe7/tfU3lpP1ICHeunslYjMNnj+ay2i
         ycZiLgo9j2GUtlqRtJ0xehftXwZGsu4Lf2oQhVLTMf4j5vhR1GysXA3NEuH7bwJkuGLC
         4oHg==
X-Gm-Message-State: AOAM531MdU2EcakZDY4wHnlM+doL7LnBjpb/e6SvlNkP7E6KXH1TuUzG
        q9FuMuqrXyaBbzSyNqHnTvY=
X-Google-Smtp-Source: ABdhPJyUBeCk04uLLNvO6ogdmO4P81+qT5sHGx1zxRY22Y4DkJbmi52HjxuLcNBKQVOHLwQFwi0BQQ==
X-Received: by 2002:a05:6808:1302:: with SMTP id y2mr9657025oiv.24.1635442130995;
        Thu, 28 Oct 2021 10:28:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bo35sm449507oib.40.2021.10.28.10.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 10:28:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 28 Oct 2021 10:28:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] irqchip: Provide stronger type checking for
 IRQCHIP_MATCH/IRQCHIP_DECLARE
Message-ID: <20211028172849.GA701812@roeck-us.net>
References: <20211020104527.3066268-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020104527.3066268-1-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 11:45:27AM +0100, Marc Zyngier wrote:
> Both IRQCHIP_DECLARE() and IRQCHIP_MATCH() use an underlying of_device_id()
> structure to encode the matching property and the init callback.
> However, this callback is stored in as a void * pointer, which obviously
> defeat any attempt at stronger type checking.
> 
> Work around this by providing a new macro that builds on top of the
> __typecheck() primitive, and that can be used to warn when there is
> a discrepency between the drivers and core code.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

This patch results in:

In file included from include/linux/irq.h:589,
                 from include/linux/of_irq.h:7,
                 from include/linux/irqchip.h:17,
                 from arch/h8300/include/asm/irq.h:5,
                 from arch/h8300/kernel/traps.c:27:
include/linux/irqdesc.h:113:33: error: 'NR_IRQS' undeclared here (not in a function)
  113 | extern struct irq_desc irq_desc[NR_IRQS];

and many similar errors when trying to build h8300 images.

Guenter

> ---
>  include/linux/irqchip.h | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
> index 67351aac65ef..5de0dfc5d64d 100644
> --- a/include/linux/irqchip.h
> +++ b/include/linux/irqchip.h
> @@ -14,8 +14,15 @@
>  #include <linux/acpi.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  
> +/* Undefined on purpose */
> +extern of_irq_init_cb_t typecheck_irq_init_cb;
> +
> +#define typecheck_irq_init_cb(fn)					\
> +	(__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)
> +
>  /*
>   * This macro must be used by the different irqchip drivers to declare
>   * the association between their DT compatible string and their
> @@ -26,14 +33,16 @@
>   * @compstr: compatible string of the irqchip driver
>   * @fn: initialization function
>   */
> -#define IRQCHIP_DECLARE(name, compat, fn) OF_DECLARE_2(irqchip, name, compat, fn)
> +#define IRQCHIP_DECLARE(name, compat, fn)	\
> +	OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
>  
>  extern int platform_irqchip_probe(struct platform_device *pdev);
>  
>  #define IRQCHIP_PLATFORM_DRIVER_BEGIN(drv_name) \
>  static const struct of_device_id drv_name##_irqchip_match_table[] = {
>  
> -#define IRQCHIP_MATCH(compat, fn) { .compatible = compat, .data = fn },
> +#define IRQCHIP_MATCH(compat, fn) { .compatible = compat,		\
> +				    .data = typecheck_irq_init_cb(fn), },
>  
>  #define IRQCHIP_PLATFORM_DRIVER_END(drv_name)				\
>  	{},								\
> -- 
> 2.30.2
> 
