Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8AC3FD516
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 10:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243066AbhIAIP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 04:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243081AbhIAIPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 04:15:52 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C48C0613C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 01:14:56 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t15so3133655wrg.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 01:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cFYWmSVza/PDqmeG9+mx1DB+NWXTWb3lrfYbe+Cf8H0=;
        b=MLrEW9JLxfB6p+wAyuTPj6dSuKUhqYV2DIIcmmqqQXSdgNZgeWa19wk4Z42umtT+C0
         KSGP6E93x+6FOJP5foOpfKL9JwClHiYl/Y937aO5gZxezRL3g50OeppPRXdPcRLACy/e
         t0PgyB+L54MPEoMxpI/kAi3i/5Qqbeyo/IuKQtdsgYTHt3jVCt+Tkf2OZx7vVt3yb3mr
         SrPtVHeXjXMG7pHeGIkUfp56qhVLXFnuMLvfgdlMZ0rMyy8gY3044o5dd/682PaRMKML
         3NEfo//PRsnBpIe4gqr63OZLY5ybBZBUk2TQufzPRCqkpXEaq9Lq7CBRNzZZoWV45kGB
         VcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cFYWmSVza/PDqmeG9+mx1DB+NWXTWb3lrfYbe+Cf8H0=;
        b=OFLkY/HUhR7+LhrRU7mlGnOsDI9U2l6BIKiQvgLrmKzGAuLmcq7Z7cur1NCr0dDP76
         jYs8raAz9S3475OFdfOnEg5Z7someMFFDeA3XKbGsRQYzwrGtk4Jjyj2RwyU4urDJg71
         JQO2ggKBRlyOGphaT8EPjYuxiAsS7acAbxI5MHN57Zzb3ZRZLkJmnFPJq1vBW4VloKBX
         MRd6mW4binR8aBiMZ6fEIfKQI1Uenz6GPp+HieSmHNK4tK6BeHYReqVUDafiZDG1eiAS
         8ypQ5Swgn4DELR3f0nFEXQj2DmkR1AjyQNd9I6hyGyPK2cs/MoLkh9yp5xsuYqxkN/UN
         zDCA==
X-Gm-Message-State: AOAM531hyR3AczZR+63h+9PD+eqUOtSxX1Qj3b9gz+xrwPsl3M8/+px0
        TASQdHQvlNY7kdw1mi6clcvhAiGbOIDl1um+
X-Google-Smtp-Source: ABdhPJxLni/w6zWQomeDOrFtWu/rq9Z2RFy8vK4jBYwFD7uQ/9lPOEPwsdlI8KL0b/AnY3L7iVV1zw==
X-Received: by 2002:adf:df0c:: with SMTP id y12mr35443384wrl.155.1630484094200;
        Wed, 01 Sep 2021 01:14:54 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:dc57:bccf:6106:11d1? ([2001:861:44c0:66c0:dc57:bccf:6106:11d1])
        by smtp.gmail.com with ESMTPSA id d6sm18556934wra.5.2021.09.01.01.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 01:14:53 -0700 (PDT)
Subject: Re: [PATCH] media: rc: meson-ir: Make use of the helper function
 devm_platform_ioremap_resource()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210901055440.7079-1-caihuoqing@baidu.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <c8b8f064-7887-9608-573c-525799641c6d@baylibre.com>
Date:   Wed, 1 Sep 2021 10:14:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210901055440.7079-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2021 07:54, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/media/rc/meson-ir.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/media/rc/meson-ir.c b/drivers/media/rc/meson-ir.c
> index dad55950dfc6..4b769111f78e 100644
> --- a/drivers/media/rc/meson-ir.c
> +++ b/drivers/media/rc/meson-ir.c
> @@ -102,7 +102,6 @@ static int meson_ir_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct device_node *node = dev->of_node;
> -	struct resource *res;
>  	const char *map_name;
>  	struct meson_ir *ir;
>  	int irq, ret;
> @@ -111,8 +110,7 @@ static int meson_ir_probe(struct platform_device *pdev)
>  	if (!ir)
>  		return -ENOMEM;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	ir->reg = devm_ioremap_resource(dev, res);
> +	ir->reg = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(ir->reg))
>  		return PTR_ERR(ir->reg);
>  
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
