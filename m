Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5703E29D3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 13:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245571AbhHFLi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 07:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238926AbhHFLi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:38:56 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B270C061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 04:38:40 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id p5so10695187wro.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 04:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=s9wnVnDyd/BCxuk/HASH4KODRxCJv7VlRo5y7kgnv28=;
        b=qJk2DxUF3xFKcfqISlcX5FsEolwmVRPARV1u5OIJr2JkgRn8MxeQrgpdJwgictJQXW
         68MHh5DsUeRKtY7grsf24MV7xFCfhzlIG192rze6AAV/bhP7kl6fotqQeK5N3VRBqLGf
         TLkFsGzO74BAZcl2NPQaVsPyof91VeIkrheYpzMBd1h5DCTbcQCaTez7DlVlOgIsa4G5
         QCTSPib/tvfv+yBnDp69b1NlqIK1JhSy/shdWP0AOeKXaBwQJEu1Vm7qCo3I4+CMeUrG
         IBwq675kfMkljraZull58XzT2wlvm6x2KrXxl/HAddxt+wUxKsIFSStuY+XGKHNSgvMd
         PrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=s9wnVnDyd/BCxuk/HASH4KODRxCJv7VlRo5y7kgnv28=;
        b=i28IOzb+5H6LOCwZhgx6YJ3+BRcqlvOY7EY0fTzeTgawUi2cPm3Fhr1LeqABkiy/64
         jB2NpDKImrrprtuo/t8dHwXyHegE0ljEWJm6Z2IwcCu8gxD75xwHbI6gl+KJfvjcrqF5
         iKHtirs/N6aMqCLU2nBNRxUFcbHjrNowUQ1Dbg+VXmfFTSyJEUgAH0pTat6qRs6PR/WP
         8NpCxrzdlTcNrYemaKRsbM+Ahd13aPbDlL2W+9fkN3e3V6BDgpe7goCyjR6xBhsQE96Y
         949t/VPZyKuSJdYqsQaTYnyO8NA7tfmcBVUhpY2J0m3Fq6ftVh/bJ+3hHr8INzNUTJ4V
         5X3g==
X-Gm-Message-State: AOAM530vJ05c5xpXUB8QlProXjhziAkvRrDWtgVWvjwrYXQzfwfKJQzB
        ZeBQrvPG7BJvCWq6JiwSvjH0yg==
X-Google-Smtp-Source: ABdhPJy3RvWjqo+uo7Q4r/toVYPAJ3vfivdBc8oWppyqpHaF+NSsJEUDyP5mAgQrwCkNPSzB2L393A==
X-Received: by 2002:a5d:6a89:: with SMTP id s9mr10293739wru.309.1628249918939;
        Fri, 06 Aug 2021 04:38:38 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id l5sm10683955wrc.90.2021.08.06.04.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 04:38:38 -0700 (PDT)
Date:   Fri, 6 Aug 2021 12:38:36 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com
Subject: Re: [PATCH v9 03/12] mfd: simple-mfd-i2c: Save the register client
 data
Message-ID: <YQ0fPEeZGYe7f1cC@google.com>
References: <20210806091058.141-1-alistair@alistair23.me>
 <20210806091058.141-4-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210806091058.141-4-alistair@alistair23.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Aug 2021, Alistair Francis wrote:

> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  drivers/mfd/simple-mfd-i2c.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> index 583e8c7924af..633a2b28b6cb 100644
> --- a/drivers/mfd/simple-mfd-i2c.c
> +++ b/drivers/mfd/simple-mfd-i2c.c
> @@ -48,6 +48,8 @@ static int simple_mfd_i2c_probe(struct i2c_client *i2c)
>  	if (IS_ERR(regmap))
>  		return PTR_ERR(regmap);
>  
> +	i2c_set_clientdata(i2c, regmap);
> +

No need to store this here.

Just do this in the child device:

     dev_get_regmap(pdev->dev.parent, NULL);

>  	/* If no MFD cells are spedified, use register the DT child nodes instead */
>  	if (!simple_mfd_data || !simple_mfd_data->mfd_cell)
>  		return devm_of_platform_populate(&i2c->dev);

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
