Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178963AE5E9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 11:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhFUJYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 05:24:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40789 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhFUJYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 05:24:52 -0400
Received: from mail-ej1-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lvG8b-0000a7-En
        for linux-kernel@vger.kernel.org; Mon, 21 Jun 2021 09:22:37 +0000
Received: by mail-ej1-f71.google.com with SMTP id nd10-20020a170907628ab02903a324b229bfso6132780ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 02:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lFki3J4aiGoaJoSHiqdWzrvE2ADBGFOB1MBQxny61RQ=;
        b=NjISFPqV2RlosI0WbdUxPiAdzYv+jCSGqxe2y7I/peURRhNI5jJVmIn4+kqdJR7wsJ
         idL/0dKpzOKVMdarlibLxEjH0qCzu9PixyvTRabrIl81pZAQirga1mps3vNOfw76NeT3
         yvlWpq1Hzq1pTq4Ea+ScnshUkXd3/wKJQ6fA6kzEj0MRGm6qpInNqEgm3wKs0lJeWI4A
         3G/ZAGfNrPuXfh3SoP7ynlClurpuFAksRIyAzD86Az7U7upmMFVZUB1CW9fTM4YE6DHO
         UQ35pOosjcf8UNELKDbHThxlX0rFl6ZWhW+oxXBYSbpBmXNE1JpkKOxA8SWMgdE+zhU8
         tU/A==
X-Gm-Message-State: AOAM5301WVRUm4hDpgBi48Sw+R+hG9ib2ahOfnKnEoQPhs01NbBR4UUd
        OEEGbhn2JBBO5ekbUwKHI1iAzDnunTGal8bCHAnLbOtLXMFB7GpNX7zHPExmXkD5Gb+SQgGoxER
        CpNo2GfH77PFZcl7Jn7kKnwRDx3wYPyaZ9bDaX23O5Q==
X-Received: by 2002:a17:906:ae85:: with SMTP id md5mr23700222ejb.93.1624267357258;
        Mon, 21 Jun 2021 02:22:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJys4r+Z83OlHvoCM0AG3+WxmdWA+czemIHfk9Y1zu2ld/0q2m7OEVksFdXru0oGi52t90ECrA==
X-Received: by 2002:a17:906:ae85:: with SMTP id md5mr23700209ejb.93.1624267357154;
        Mon, 21 Jun 2021 02:22:37 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id n2sm10348412edi.32.2021.06.21.02.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 02:22:36 -0700 (PDT)
Subject: Re: [PATCH -next 3/4] ASoC: samsung: s3c2412-i2s: Use
 devm_platform_get_and_ioremap_resource()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     s.nawrocki@samsung.com, broonie@kernel.org
References: <20210616091652.2552927-1-yangyingliang@huawei.com>
 <20210616091652.2552927-4-yangyingliang@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <9aabb88e-c40a-352b-3403-9ed6a728a9ba@canonical.com>
Date:   Mon, 21 Jun 2021 11:22:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210616091652.2552927-4-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2021 11:16, Yang Yingliang wrote:
> Use devm_platform_get_and_ioremap_resource() to simplify
> code.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  sound/soc/samsung/s3c2412-i2s.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
> index 81f416ac457e..ec1c6f9d76ac 100644
> --- a/sound/soc/samsung/s3c2412-i2s.c
> +++ b/sound/soc/samsung/s3c2412-i2s.c
> @@ -208,8 +208,7 @@ static int s3c2412_iis_dev_probe(struct platform_device *pdev)
>  		return -ENXIO;
>  	}
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	s3c2412_i2s.regs = devm_ioremap_resource(&pdev->dev, res);
> +	s3c2412_i2s.regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>  	if (IS_ERR(s3c2412_i2s.regs))
>  		return PTR_ERR(s3c2412_i2s.regs);
>  
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
