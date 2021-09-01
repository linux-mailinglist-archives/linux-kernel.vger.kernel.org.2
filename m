Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728943FD50A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 10:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243004AbhIAIP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 04:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242870AbhIAIP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 04:15:27 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9062C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 01:14:30 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o39-20020a05600c512700b002e74638b567so1298884wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 01:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YrKVWBO1f/vW38Nzw0ET7Dtvvx+9TDWUyIhOz8vqs7c=;
        b=i/B3G1QjYGIKPhWb4mR83VZKwR3jlpFDSE4OlAn/5FfTm2eOXa+r91g/pQQzhUDijQ
         cFIcs6CRQwVvdhJ+3kE4FRr6MYWfoJ0qA4NMIBLLgAdM5ckRXIbGikB/WLdyfHQrVfgf
         +WvquCPK7qoc9BfzkWKoIp7tZfdWNBd0CcK3LmXLn0PHXY3cnQ1sTo8E86GHzGxnnZB5
         Q7cThkviMKoosz4L3WVsAtLBWyh9iXnTAQGMjfXhgkLj9KCcbA4YjXuT2+tJNh9kNhPv
         H1zmPrjpA+MX2iIEcz7YiGtJ2gBfykfoUTBvPJjyGoJWFaRsQaHmdv4AxH/sPP0nvSCb
         YVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YrKVWBO1f/vW38Nzw0ET7Dtvvx+9TDWUyIhOz8vqs7c=;
        b=UyAyQHhS8/XyWZTMaPXHygXS32oLuequTeTZ7ONXEJYvNj0KlZrY967EDj3VfPFSx1
         QT9PXbEUn1a2r39oFaYHyjVDAefCeETv3ki/u8YzHFJKhUyRPoUdWlk0VFFI5u+NtiDQ
         wQMGiwn/qJUxHVMI1f7+s1YfDSL5Tn7c6n9YuOpiw9pnLA6HwjlFU6EGevV0GdfSSXvv
         xkD/s5MXd8T5epmIueMUxE+eA1lHlP4x1YQzdpLl6Q+QfLeXHQxPtoaR5nIY5OEWmMjD
         yWEu9PbJO+C+QmmPscQjbtUZC9G45U64kb/1/UJtiePybFRHRhQFr3N5sgpaIhaeA9Sk
         hPzg==
X-Gm-Message-State: AOAM531NyeN7CDtc5VnHBoLTxYVKCo+7LU7wPoQdQy6/U4vjK9/seNno
        wkDipJVeQgShppQdhhiWYHJdel//AqEwPm8o
X-Google-Smtp-Source: ABdhPJy56BIXwV6S+CNtfU74OvWAfHGQFSrCbv//ooL8zb7ycm/Q6XDk7np66gkBwQP0broPCUxdHA==
X-Received: by 2002:a1c:443:: with SMTP id 64mr8358428wme.180.1630484069127;
        Wed, 01 Sep 2021 01:14:29 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:dc57:bccf:6106:11d1? ([2001:861:44c0:66c0:dc57:bccf:6106:11d1])
        by smtp.gmail.com with ESMTPSA id o26sm4626093wmc.17.2021.09.01.01.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 01:14:28 -0700 (PDT)
Subject: Re: [PATCH] mtd: rawnand: oxnas: Make use of the helper function
 devm_platform_ioremap_resource()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io,
        linux-kernel@vger.kernel.org
References: <20210901074207.9333-1-caihuoqing@baidu.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <61ab65d3-bf52-5701-95d2-476b8c2d719c@baylibre.com>
Date:   Wed, 1 Sep 2021 10:14:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210901074207.9333-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2021 09:42, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/mtd/nand/raw/oxnas_nand.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/oxnas_nand.c b/drivers/mtd/nand/raw/oxnas_nand.c
> index f44947043e5a..cd112d45e0b5 100644
> --- a/drivers/mtd/nand/raw/oxnas_nand.c
> +++ b/drivers/mtd/nand/raw/oxnas_nand.c
> @@ -79,7 +79,6 @@ static int oxnas_nand_probe(struct platform_device *pdev)
>  	struct oxnas_nand_ctrl *oxnas;
>  	struct nand_chip *chip;
>  	struct mtd_info *mtd;
> -	struct resource *res;
>  	int count = 0;
>  	int err = 0;
>  	int i;
> @@ -92,8 +91,7 @@ static int oxnas_nand_probe(struct platform_device *pdev)
>  
>  	nand_controller_init(&oxnas->base);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	oxnas->io_base = devm_ioremap_resource(&pdev->dev, res);
> +	oxnas->io_base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(oxnas->io_base))
>  		return PTR_ERR(oxnas->io_base);
>  
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
