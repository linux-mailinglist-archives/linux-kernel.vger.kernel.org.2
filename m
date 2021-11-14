Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9450244FBAA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 21:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbhKNVBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 16:01:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30832 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234970AbhKNVBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 16:01:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636923498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pnp8pM+/uuwUVD415q7LbGa5W5h6Fo7vf4H24zop064=;
        b=LTHMTCZsWq43yPOh/J8lKO9KvTXvgmaNjGbpGl+PR16iGrTPfS9moG6we7Eue7IR8dYilm
        7NjXdmAfU9YEbTuft5rBfgw4oeXpGJWrdLU/7o2Ue0Bvd+OcfGEMWV9tWAaBuCi1XawyZp
        0sawqTHrFg7M7sO4pd1awN8xjp3Lb2Q=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-hPuOV6BPOWaVE3Jz8Mg1kg-1; Sun, 14 Nov 2021 15:58:17 -0500
X-MC-Unique: hPuOV6BPOWaVE3Jz8Mg1kg-1
Received: by mail-ed1-f69.google.com with SMTP id i9-20020a508709000000b003dd4b55a3caso12300718edb.19
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 12:58:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pnp8pM+/uuwUVD415q7LbGa5W5h6Fo7vf4H24zop064=;
        b=G4dOEjG5u8lK9d48n5bgeiVw9M8Ge8M+G2XqjEzvGZ91H3ATnBlYaon56YI0cG2yOm
         6KYWFAiMWtR8xRPFgeyOPEn+C3QuGkClfTeVJF/Df0ePLF9dhcATQvxaFUnSgrT26Jwd
         z6j0l5pxFLLTDbNujJF4LbfS27ddo9rkvwfj8MOzqyrXLFgAlIlT1nVbLYFTmMYITZpI
         rWAMhMhFjPB6TuQ5pZY6hgtt7mjG9HFvedmPRaZsWRQwuAyHXYfuESXZVP1PoYiCQxbq
         SwIezdckMvX5EYvEPWu+FxZYJzmB2DzKKmq1ZU1A3/dt3U+osTWnIWmdvoF51U4V+EjA
         QXfA==
X-Gm-Message-State: AOAM531NdkT5/s+FI6NO58+5gKExNYLAX6pvPKePVNNAbe+Cb4VReUnB
        l7CB4p+TCBG8IdgoPdkdyxHCDUuvCyN/9Rtj3RywVEDhR6IHDpvjydgYJKc4dhySYCb+Irzm8uQ
        lpXNsgLe7I5pLIFd/EhGWu4QD
X-Received: by 2002:a50:d492:: with SMTP id s18mr48552248edi.145.1636923496646;
        Sun, 14 Nov 2021 12:58:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyg14BGQiR3vH+syGpF58gTCsuYq8609RRTO6bbqnEexzVDYDB92LyXrOkZY4aJzL0T04ChcA==
X-Received: by 2002:a50:d492:: with SMTP id s18mr48552222edi.145.1636923496528;
        Sun, 14 Nov 2021 12:58:16 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id gb2sm5475548ejc.52.2021.11.14.12.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Nov 2021 12:58:16 -0800 (PST)
Message-ID: <029e4c99-3aa5-fdb8-6ddc-fd3b144e4253@redhat.com>
Date:   Sun, 14 Nov 2021 21:58:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] usb: dwc3: leave default DMA for PCI devices
Content-Language: en-US
To:     Fabio Aiuto <fabioaiuto83@gmail.com>, gregkh@linuxfoundation.org
Cc:     balbi@kernel.org, arnd@arndb.de, hch@lst.de, sven@svenpeter.dev,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211113142959.27191-1-fabioaiuto83@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211113142959.27191-1-fabioaiuto83@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/13/21 15:29, Fabio Aiuto wrote:
> in case of a PCI dwc3 controller, leave the default DMA
> mask. Calling of a 64 bit DMA mask breaks the driver on
> cherrytrail based tablets like Cyberbook T116.
> 
> Fixes: 45d39448b4d0 ("usb: dwc3: support 64 bit DMA in platform driver")
> Reported-by: Hans De Goede <hdegoede@redhat.com>
> Tested-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>

I can confirm that this fixes things for me to:

Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/usb/dwc3/core.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 643239d7d370..f4c09951b517 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1594,9 +1594,11 @@ static int dwc3_probe(struct platform_device *pdev)
>  
>  	dwc3_get_properties(dwc);
>  
> -	ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
> -	if (ret)
> -		return ret;
> +	if (!dwc->sysdev_is_parent) {
> +		ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
> +		if (ret)
> +			return ret;
> +	}
>  
>  	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
>  	if (IS_ERR(dwc->reset))
> 

