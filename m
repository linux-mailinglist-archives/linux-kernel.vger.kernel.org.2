Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9E73AE5EC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 11:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhFUJY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 05:24:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40795 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhFUJYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 05:24:55 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lvG8f-0000c9-1f
        for linux-kernel@vger.kernel.org; Mon, 21 Jun 2021 09:22:41 +0000
Received: by mail-ed1-f69.google.com with SMTP id p23-20020aa7cc970000b02903948bc39fd5so5363890edt.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 02:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hZC3Rg3BvJB4BQwVaSuLDsENz/aC3X5mhOq0Jc6AB58=;
        b=dTP0bX+HXEruJGRRks9zB/S3Mb+sOG+XBjz1ETFv+a/6G9JxUZcPOEhAzcIbh4ztLn
         deNOJy6givJVfyqhb1J0JZL5l44isDD1L257UqlLFXl3vShKxZpXYwkRtlvJBIMDjMp1
         Kjnwj89wjsm43wAoMd+u+oPVV32VBbJynnvdrfTwYCYC97JjAkfrwt07X471vvhrxe/d
         b8PYZL/d79vYoTikl4xC9llqzTT/HCGQvHtV371ZqeRjAYKhRr61mckng5Vh7wQssJxJ
         SJfI8ehp8LcBzDhlwiHsLsor9v7taVx+oYWoLNs5+lqXAVExaLc2R1SDo6l5Jjdp3DUz
         rCLA==
X-Gm-Message-State: AOAM531L6RkC3YoQZoa7rg9+lpWsEgJ9zA+Ph8xCaiXmniZDyxFrApSX
        Wz1WcOea3kl5nfw3eDu4AITsGKpFhOXFVz+qQZNutOnAHnc6zUewmE8jjd16tHl5nHiqcfuVely
        V5t1Evp60ls7CsZsxlTtdX8BLXsSOiJMAudhpxCQAKw==
X-Received: by 2002:a05:6402:b17:: with SMTP id bm23mr1884935edb.173.1624267360873;
        Mon, 21 Jun 2021 02:22:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwfZk5ISqN2ouBhxsLkXdlM8l0yr/wsX851g9ngedNHQwRH0qR983JIMEqkYLCHTg+bWq3Yw==
X-Received: by 2002:a05:6402:b17:: with SMTP id bm23mr1884925edb.173.1624267360791;
        Mon, 21 Jun 2021 02:22:40 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id q20sm4633633ejb.71.2021.06.21.02.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 02:22:40 -0700 (PDT)
Subject: Re: [PATCH -next 1/4] ASoC: samsung: i2s: Use
 devm_platform_get_and_ioremap_resource()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     s.nawrocki@samsung.com, broonie@kernel.org
References: <20210616091652.2552927-1-yangyingliang@huawei.com>
 <20210616091652.2552927-2-yangyingliang@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <aaf277d2-a163-1658-4d01-b5843ea95b81@canonical.com>
Date:   Mon, 21 Jun 2021 11:22:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210616091652.2552927-2-yangyingliang@huawei.com>
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
>  sound/soc/samsung/i2s.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
> index c632842d42eb..309badc97290 100644
> --- a/sound/soc/samsung/i2s.c
> +++ b/sound/soc/samsung/i2s.c
> @@ -1441,8 +1441,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	priv->addr = devm_ioremap_resource(&pdev->dev, res);
> +	priv->addr = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>  	if (IS_ERR(priv->addr))
>  		return PTR_ERR(priv->addr);
>  
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
