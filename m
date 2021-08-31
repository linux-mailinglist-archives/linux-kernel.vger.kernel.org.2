Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE193FCEC9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 22:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241203AbhHaUtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 16:49:09 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:44649 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240484AbhHaUtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 16:49:07 -0400
Received: by mail-ot1-f50.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so745727otg.11;
        Tue, 31 Aug 2021 13:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wNNp70ZeS1CkFL+U1J77pDYe0j7gaaFJgPTD6drutso=;
        b=pDw6ijVRW4J8fOCCa8sxrQ20XQSQp9sWQBr3nsvoVqL55z7rsXk4Nqthzo2o3C6N+t
         aF4vqeoBWuw9u5RLO81jw3nQjyU1k56ZwjW8LuttPRNjb0ZuXJ17LcGgM2tnPc6bYhOt
         fkG7t9uWU4NAKjZX8MiZq0Ve+bjeKmi765ZJzC5q8K1nJ2vIxDsgKfa49R3ISrlliJQI
         xZcZq7e6OBg6amlxNTcCM4W2rkIZHIwwajdoelzZgokJ4AEZ45okflDmSK6w5IFXyHgH
         l1yKt/n8+t+P9Jq9SQiQ6xrVGX0/29sIVzepGeN5BtaePRIGP8hvITgq+L3mp2YLZMis
         bamw==
X-Gm-Message-State: AOAM532uhxFkJIRfKy9EqNuo7zqQn0Gq5iskSvxnlTcPerUBPxgMY/8i
        KC15eA8VGReDNgPzMFIyUA==
X-Google-Smtp-Source: ABdhPJzFy3Ujv5wUhcg6/TUy2Ei8DusEEY8iaFpVICUkEJ+8N0SrQvTJ0un7XWJKW550cQ27rF9Dng==
X-Received: by 2002:a9d:4a8d:: with SMTP id i13mr2190320otf.180.1630442890470;
        Tue, 31 Aug 2021 13:48:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bg38sm2211456oib.26.2021.08.31.13.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:48:09 -0700 (PDT)
Received: (nullmailer pid 623003 invoked by uid 1000);
        Tue, 31 Aug 2021 20:48:09 -0000
Date:   Tue, 31 Aug 2021 15:48:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, frowand.list@gmail.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        saravanak@google.com, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, Ruizhe Lin <linruizhe@huawei.com>
Subject: Re: [PATCH v2 4/4] amba: Properly handle device probe without IRQ
 domain
Message-ID: <YS6ViZ98JGa/KJ+Z@robh.at.kernel.org>
References: <20210827150600.78811-1-wangkefeng.wang@huawei.com>
 <20210827150600.78811-5-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827150600.78811-5-wangkefeng.wang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 11:06:00PM +0800, Kefeng Wang wrote:
> of_amba_device_create() uses irq_of_parse_and_map() to translate
> a DT interrupt specification into a Linux virtual interrupt number.
> 
> But it doesn't properly handle the case where the interrupt controller
> is not yet available, eg, when pl011 interrupt is connected to MBIGEN
> interrupt controller, because the mbigen initialization is too late,
> which will lead to no IRQ due to no IRQ domain found, log is shown below,
>   "irq: no irq domain found for uart0 !"
> 
> use of_irq_get() to return -EPROBE_DEFER as above, and in the driver
> deferred probe, it will properly handle in such case, also return 0
> in other fail cases to be consistent as before.
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Reported-by: Ruizhe Lin <linruizhe@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/amba/bus.c    | 27 +++++++++++++++++++++++++++
>  drivers/of/platform.c |  6 +-----
>  2 files changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 4d3a565ca079..96e84ce66e9a 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -19,6 +19,7 @@
>  #include <linux/clk/clk-conf.h>
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
> +#include <linux/of_irq.h>
>  
>  #define to_amba_driver(d)	container_of(d, struct amba_driver, drv)
>  
> @@ -170,6 +171,28 @@ static int amba_uevent(struct device *dev, struct kobj_uevent_env *env)
>  	return retval;
>  }
>  
> +static int of_amba_device_decode_irq(struct amba_device *dev)
> +{
> +	struct device_node *node = dev->dev.of_node;
> +	int i, irq;
> +
> +	if (IS_ENABLED(CONFIG_OF_IRQ) && node) {

I don't think this check is needed. If either is false, we should return 
an errno from of_irq_get().

> +		/* Decode the IRQs and address ranges */
> +		for (i = 0; i < AMBA_NR_IRQS; i++) {
> +			irq = of_irq_get(node, i);
> +			if (irq < 0) {
> +				if (irq == -EPROBE_DEFER)
> +					return irq;
> +				irq = 0;
> +			}
> +
> +			dev->irq[i] = irq;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * These are the device model conversion veneers; they convert the
>   * device model structures to our more specific structures.
> @@ -182,6 +205,10 @@ static int amba_probe(struct device *dev)
>  	int ret;
>  
>  	do {
> +		ret = of_amba_device_decode_irq(pcdev);
> +		if (ret)
> +			break;
> +
>  		ret = of_clk_set_defaults(dev->of_node, false);
>  		if (ret < 0)
>  			break;
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 74afbb7a4f5e..32d5ff8df747 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -222,7 +222,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>  {
>  	struct amba_device *dev;
>  	const void *prop;
> -	int i, ret;
> +	int ret;
>  
>  	pr_debug("Creating amba device %pOF\n", node);
>  
> @@ -253,10 +253,6 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>  	if (prop)
>  		dev->periphid = of_read_ulong(prop, 1);
>  
> -	/* Decode the IRQs and address ranges */
> -	for (i = 0; i < AMBA_NR_IRQS; i++)
> -		dev->irq[i] = irq_of_parse_and_map(node, i);
> -
>  	ret = of_address_to_resource(node, 0, &dev->res);
>  	if (ret) {
>  		pr_err("amba: of_address_to_resource() failed (%d) for %pOF\n",
> -- 
> 2.18.0.huawei.25
> 
> 
