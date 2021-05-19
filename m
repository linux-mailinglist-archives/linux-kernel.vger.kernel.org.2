Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3760388EAC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 15:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346575AbhESNNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 09:13:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47795 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346503AbhESNNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 09:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621429905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E4iqCQQcWH0B7eHMG9iFWGbs/tWadPcG1oUL8R8VzZU=;
        b=avjoNBqEASq2NiHq6kd9/yQPBju6GKNCF4f1h1+RwUPhNYvTbL8l6N9T6xeESjt54MG+xM
        A8BJYZtPuW8l6ER4bIwvu1NOvxBzMiv82L0SLhxgkjcDf/jUPZlR6H613NmC+PpBPEJbZD
        1m5lNdSuQzw6UGEQflIW5YdN7oo62hE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-HagzlWO8O1mO-dDGHqLVWg-1; Wed, 19 May 2021 09:11:41 -0400
X-MC-Unique: HagzlWO8O1mO-dDGHqLVWg-1
Received: by mail-ed1-f70.google.com with SMTP id h18-20020a05640250d2b029038cc3938914so7672443edb.17
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 06:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E4iqCQQcWH0B7eHMG9iFWGbs/tWadPcG1oUL8R8VzZU=;
        b=WMvgr6Zn939M6lsE+JPT5zHozDmGCLBUYKdwYI8x7D8wWl4VfN4yZvzPAaCSF8jMbs
         WZo2sjwpDRMMv70DbXdkCTAz+Y3XY35Ii7/GFEnUsln6eUePBYacfgRIvoB0dQePomNZ
         vUOspWT7UG4YyOr0bLxrR5XU5A7mBVhCzwH8iwVojaO1EawDvfumXh7qykvQIz3joZ4U
         RbD4egdm1HCR4g8IKcxaA5ctXmUSETWO9REWnyqmWX5K0Nr4gMXkuKMPtOBUPW6UFojn
         Lb9rlgAGkowImXjiiho0bhcB9QgPQ+GgcBKg+Z0svFSJPET1HKqASOlA017YxIVqQRpm
         RpxA==
X-Gm-Message-State: AOAM5316JZSKdr1N9VBapiOCX2WbiHKmms8URjD+orM+fAYi9SKHjgG6
        d2cxVHLbTuujMcZKVLeF8OLXYtoIsW4vc47zAnp3YRcMmPhHIIU04XFcc9AZ/38/MiGOROQ5P6y
        63aFWdi7g9KrQt2pgbz4/GMR9skVTznO52Lyp7Oe4r48UToN+Jq4JvPEXZchOMSGOGmoGOxTGZ8
        QR
X-Received: by 2002:a17:906:79c8:: with SMTP id m8mr12731204ejo.260.1621429900385;
        Wed, 19 May 2021 06:11:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpW5YZWL01KOdHo9+Pc+VXn0YrDq232IN9c3w6uGoa/uK8WQL+Qf1aFEKzZC50INEVt6tB8Q==
X-Received: by 2002:a17:906:79c8:: with SMTP id m8mr12731184ejo.260.1621429900200;
        Wed, 19 May 2021 06:11:40 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id w14sm16048395edj.6.2021.05.19.06.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 06:11:39 -0700 (PDT)
Subject: Re: [PATCH] platform/surface: aggregator: Do not mark interrupt as
 shared
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210505133635.1499703-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <17e63def-42ed-42d6-156d-cdde573b5e40@redhat.com>
Date:   Wed, 19 May 2021 15:11:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210505133635.1499703-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/5/21 3:36 PM, Maximilian Luz wrote:
> Having both IRQF_NO_AUTOEN and IRQF_SHARED set causes
> request_threaded_irq() to return with -EINVAL (see comment in flag
> validation in that function). As the interrupt is currently not shared
> between multiple devices, drop the IRQF_SHARED flag.
> 
> Fixes: 507cf5a2f1e2 ("platform/surface: aggregator: move to use request_irq by IRQF_NO_AUTOEN flag")
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

I will also include this in the next pdx86-fixes pull-req for 5.13.

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
>  drivers/platform/surface/aggregator/controller.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
> index 69e86cd599d3..8a70df60142c 100644
> --- a/drivers/platform/surface/aggregator/controller.c
> +++ b/drivers/platform/surface/aggregator/controller.c
> @@ -2483,8 +2483,7 @@ int ssam_irq_setup(struct ssam_controller *ctrl)
>  	 * interrupt, and let the SAM resume callback during the controller
>  	 * resume process clear it.
>  	 */
> -	const int irqf = IRQF_SHARED | IRQF_ONESHOT |
> -			 IRQF_TRIGGER_RISING | IRQF_NO_AUTOEN;
> +	const int irqf = IRQF_ONESHOT | IRQF_TRIGGER_RISING | IRQF_NO_AUTOEN;
>  
>  	gpiod = gpiod_get(dev, "ssam_wakeup-int", GPIOD_ASIS);
>  	if (IS_ERR(gpiod))
> 

