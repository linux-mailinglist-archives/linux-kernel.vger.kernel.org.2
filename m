Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312023FCEBF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 22:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241161AbhHaUpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 16:45:18 -0400
Received: from mail-oo1-f51.google.com ([209.85.161.51]:34597 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241086AbhHaUpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 16:45:13 -0400
Received: by mail-oo1-f51.google.com with SMTP id g4-20020a4ab044000000b002900bf3b03fso160049oon.1;
        Tue, 31 Aug 2021 13:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KoxDg3lbpSnQr151KkbKM1S89BPuY4KcLMeYH+F7S4g=;
        b=DmObCyvMEFhQPKH0AO7cykKic7aOgyCy4oPuaDpJWhUjm9w0QiRnucTW4ndpvH87Dz
         vJhFlTJUzGqOGJUxdKGSV54GhxeE0oL1ypVuVHNarhxmwqSPevXkchIkM8fhtAWlJvwA
         yiZ7d61zvqlx9pzDogbD6My5xM9eTUpQTcLlZC57iBnn89J48xHu1EwGeE2JGRgQZL+7
         d0WGjyab/n37IbjPLjpyv0v6DcTaOwUca8oIGqXBnH2iVmUM3/OJtq3ZBju3nN089mi2
         DTR70/yKK8CbochMH/EAsX6RGj/qcEoxzMWtFyeTUaO1rz13xtvFg5nubngX50fs7EdL
         pgZw==
X-Gm-Message-State: AOAM530v9RHOQ7HmApBJU2DAIIbSvtOyxUz5HuZQphUgoe4NbBG2VYuI
        1Tww1PqDO9aA6SJKon0CWQ==
X-Google-Smtp-Source: ABdhPJyCwqoJD64/OVZ9UksTIfmo8qABQUUobE6qLsVAuKciKCKfZStkt7bUri6+JebZlVMM/kVxwQ==
X-Received: by 2002:a4a:3e58:: with SMTP id t85mr15965286oot.81.1630442657489;
        Tue, 31 Aug 2021 13:44:17 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g10sm3877928oof.37.2021.08.31.13.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:44:16 -0700 (PDT)
Received: (nullmailer pid 617941 invoked by uid 1000);
        Tue, 31 Aug 2021 20:44:15 -0000
Date:   Tue, 31 Aug 2021 15:44:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, frowand.list@gmail.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        saravanak@google.com, linus.walleij@linaro.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/4] amba: Kill sysfs attribute file of irq
Message-ID: <YS6Un+Zdbaj5qe63@robh.at.kernel.org>
References: <20210827150600.78811-1-wangkefeng.wang@huawei.com>
 <20210827150600.78811-4-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827150600.78811-4-wangkefeng.wang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 11:05:59PM +0800, Kefeng Wang wrote:
> As Rob said[1], there doesn't seem to be any users about the sysfs
> attribute file of irq[0] and irq[1]. And we don't need to include
> <asm/irq.h> as NO_IRQ has gone. Let's kill both of them.
>
> [1] https://lkml.org/lkml/2021/8/25/461
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/amba/bus.c | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

 
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 37fcd5592c6f..4d3a565ca079 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -20,8 +20,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
>  
> -#include <asm/irq.h>
> -
>  #define to_amba_driver(d)	container_of(d, struct amba_driver, drv)
>  
>  /* called on periphid match and class 0x9 coresight device. */
> @@ -135,8 +133,6 @@ static ssize_t name##_show(struct device *_dev,				\
>  static DEVICE_ATTR_RO(name)
>  
>  amba_attr_func(id, "%08x\n", dev->periphid);
> -amba_attr_func(irq0, "%u\n", dev->irq[0]);
> -amba_attr_func(irq1, "%u\n", dev->irq[1]);
>  amba_attr_func(resource, "\t%016llx\t%016llx\t%016lx\n",

Might want to get rid of this too. It's available thru other means (DT). 
That can be another patch.

>  	 (unsigned long long)dev->res.start, (unsigned long long)dev->res.end,
>  	 dev->res.flags);
> @@ -463,20 +459,10 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
>  
>   skip_probe:
>  	ret = device_add(&dev->dev);
> -	if (ret)
> -		goto err_release;
> -
> -	if (dev->irq[0])
> -		ret = device_create_file(&dev->dev, &dev_attr_irq0);
> -	if (ret == 0 && dev->irq[1])
> -		ret = device_create_file(&dev->dev, &dev_attr_irq1);
> -	if (ret == 0)
> -		return ret;
> -
> -	device_unregister(&dev->dev);
>  
>   err_release:
> -	release_resource(&dev->res);
> +	if (ret)
> +		release_resource(&dev->res);
>   err_out:
>  	return ret;
>  
> -- 
> 2.18.0.huawei.25
> 
> 
