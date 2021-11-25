Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF5545DCC7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 15:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355961AbhKYPCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 10:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245356AbhKYPAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 10:00:21 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B254C0613F1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 06:55:35 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso8538420wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 06:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7JCAKf9oYA7x3BAXSjfEiB48U74HpvNrlO45NEfGpZU=;
        b=TJXyQopU1zrLMJj4DitXJIx6dMnxF2L5hsFjVqN2Y86nPWEr+YOlT/l40Y6h0DOi9I
         ANmF1H4bvNRWTkDW48hHQ7q8j1yObs2neZyGZhHyYJb/vGalcgSmrfzLnyYNspIbHUd/
         XfSQK7mWY9DXPUcOz9kdDyBCUif4rM0tVPlhTswh5pAmdL70f6EKRlzc6AML+8SG4eDS
         hhYI5xd4Jc2Pkzb8SLozfz4I4tfV4vt8yoaZWHtqneNosrK9dWdtGcsYUjeTzp+XwX1Q
         e3ppwCFt0/HOKdMz1ZASn6f79I3S5boXf9HVWdRRCDLbZn7JgeoJz8ebduusa6Frxtrq
         ItiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7JCAKf9oYA7x3BAXSjfEiB48U74HpvNrlO45NEfGpZU=;
        b=llK0SqwFLhna5wy5XNoNbqGjsAwmoHG3uYb4rV4qctXeGlNmfRlTK84ElwNHUvlL9e
         WibIzZ7e7VjNRxdyKDDqwwIRtD6khgDypUrJmMiUX8Udntn3b0kwu6geadUeZjmo5hhH
         Clnxcu1+NC6gx1RB1/2zFZzdToD8WbJQFX+3H4oUGpnMbWQI4hPdcswOCLeFAp36NzMR
         nh9fEkzt/9oN/PFhZDg5m215ZburscYL+NeqRuaBhpPcwNRhIGNdskUuY1vBznSdRuE/
         dr6/guXnAvhwJ6RHOSdf4Umx10X/xYoGnb+ZbkxVW8QkTfJYNi3sazadlr89LYXf2vx/
         6gGw==
X-Gm-Message-State: AOAM5329n4funPmxS5hLtexBSXkvNU6vKAzQ2Pt0nXxEcEYRUEvl7EAO
        xQySJbgdsds2eRZEO/bOZmroOWf1asobMw==
X-Google-Smtp-Source: ABdhPJx0PsgG06/T0eZFPZ8IBA/Oi3tBMWd4vmX+FvqdV1Qa7NyY0LC4/WzGyyyoRIbxD6AQd5lJTQ==
X-Received: by 2002:a7b:cf02:: with SMTP id l2mr2402934wmg.78.1637852133685;
        Thu, 25 Nov 2021 06:55:33 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id d15sm4465576wri.50.2021.11.25.06.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 06:55:33 -0800 (PST)
Subject: Re: [PATCH 2/5] misc: fastrpc: Add secure device node support
To:     Jeya R <jeyr@codeaurora.org>, linux-arm-msm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        fastrpc.upstream@qti.qualcomm.com
References: <1637849744-24844-1-git-send-email-jeyr@codeaurora.org>
 <1637849744-24844-3-git-send-email-jeyr@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <11cc9ff8-3852-d352-7105-fd1d223d69bf@linaro.org>
Date:   Thu, 25 Nov 2021 14:55:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1637849744-24844-3-git-send-email-jeyr@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeya,

Thanks for the patch,

On 25/11/2021 14:15, Jeya R wrote:
> Register and deregister secure device node. Check for device name during
> device open get proper channel context.
> 
> Signed-off-by: Jeya R <jeyr@codeaurora.org>
> ---
>   drivers/misc/fastrpc.c | 33 +++++++++++++++++++++++++++++++--
>   1 file changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 39aca77..0775554e 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -79,6 +79,7 @@
>   #define SENSORS_PD	(2)
>   
>   #define miscdev_to_cctx(d) container_of(d, struct fastrpc_channel_ctx, miscdev)
> +#define securedev_to_cctx(d) container_of(d, struct fastrpc_channel_ctx, securedev)
>   
>   static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
>   						"sdsp", "cdsp"};
> @@ -213,6 +214,7 @@ struct fastrpc_channel_ctx {
>   	struct idr ctx_idr;
>   	struct list_head users;
>   	struct miscdevice miscdev;
> +	struct miscdevice securedev;
>   	struct kref refcount;
>   };
>   
> @@ -1218,10 +1220,23 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
>   
>   static int fastrpc_device_open(struct inode *inode, struct file *filp)
>   {
> -	struct fastrpc_channel_ctx *cctx = miscdev_to_cctx(filp->private_data);
> +	struct fastrpc_channel_ctx *cctx = NULL;
>   	struct fastrpc_user *fl = NULL;
> +	struct miscdevice *currdev = NULL;
>   	unsigned long flags;
>   
> +	if (!filp)
> +		return -EFAULT;
> +
> +	currdev = (struct miscdevice *)(filp->private_data);
> +	if (!currdev)
> +		return -EFAULT;
> +
> +	if (strstr(currdev->name, "secure") != NULL)
> +		cctx = securedev_to_cctx(filp->private_data);
> +	else
> +		cctx = miscdev_to_cctx(filp->private_data);
> +


Now we only have one of the two possibilities,
Either device node is "non secure" or a "secure"

If you create just one device node based on the device tree bindings 
then you would not need to do any of these runtime checks.

something like this in fastrpc_rpmsg_probe() should do:

----------------------->cut<----------------------------------
data->secure = !(of_property_read_bool(rdev->of_node, 
"qcom,non-secure-domain"));
data->miscdev.minor = MISC_DYNAMIC_MINOR;
data->miscdev.name = devm_kasprintf(rdev, GFP_KERNEL, "fastrpc-%s-%s",
				    domains[domain_id],
				    data->secure ? "secure" : "");
data->miscdev.fops = &fastrpc_fops;
err = misc_register(&data->miscdev);
if (err) {
	kfree(data);
	return err;
}
----------------------->cut<----------------------------------


--srini

>   	fl = kzalloc(sizeof(*fl), GFP_KERNEL);
>   	if (!fl)
>   		return -ENOMEM;
> @@ -1644,6 +1659,15 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>   		kfree(data);
>   		return err;
>   	}
> +	data->securedev.minor = MISC_DYNAMIC_MINOR;
> +	data->securedev.name = devm_kasprintf(rdev, GFP_KERNEL,
> +				"fastrpc-%s-secure", domains[domain_id]);
> +	data->securedev.fops = &fastrpc_fops;
> +	err = misc_register(&data->securedev);
> +	if (err) {
> +		kfree(data);
> +		return err;
> +	}
>   
>   	kref_init(&data->refcount);
>   
> @@ -1655,7 +1679,11 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>   	data->domain_id = domain_id;
>   	data->rpdev = rpdev;
>   
> -	return of_platform_populate(rdev->of_node, NULL, NULL, rdev);
> +	err = of_platform_populate(rdev->of_node, NULL, NULL, rdev);
> +	dev_info(rdev, "%s done for %s with nodes non-secure(%d), secure(%d) return: %d\n",
> +		__func__, domains[domain_id],
> +		data->miscdev.minor, data->securedev.minor, err);
> +	return err;
>   }
>   
>   static void fastrpc_notify_users(struct fastrpc_user *user)
> @@ -1680,6 +1708,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>   	spin_unlock_irqrestore(&cctx->lock, flags);
>   
>   	misc_deregister(&cctx->miscdev);
> +	misc_deregister(&cctx->securedev);
>   	of_platform_depopulate(&rpdev->dev);
>   
>   	cctx->rpdev = NULL;
> 
