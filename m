Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F5E39CC84
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 05:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhFFDgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 23:36:37 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:42743 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhFFDgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 23:36:36 -0400
Received: by mail-ot1-f48.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so8868379oth.9
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 20:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pCeXT9a5d7ZMX7CdNxFcTb0it+4u0J15VMolhmJ0Wz8=;
        b=jLUj0OTdBRJU8X4s/4Dw8+4TLW4dp4o0uyEPSwy9JKQvZLvQP8/ZCDHPRK4LWTF1t+
         yGoN2Uz9RLtuq3Utg1bXI0z0N18psLrCUJp+luhFeOoyE0r1wnEk5jGrYCh/ockICZks
         cyIaF4lhHR51bzVk9IKjTu9RkWMMBjKwFECX0jUkpnJIv/5az/imrGtddE6k+A6CDbpl
         dU8AfGo0efxg7JjGmdRx/tBRZAqIX/A5OewSUmnyO/FCG5V7PgnESpNCFdzzTItA79Dm
         aZAN96FaVmSPA9BOVgwMvlh6AxTD8a3NpD2yiIzDYt8mONTBY94wOwGOphY3uSiRfYRT
         Uz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pCeXT9a5d7ZMX7CdNxFcTb0it+4u0J15VMolhmJ0Wz8=;
        b=pn5iYwUoUxoWo3fdIAbTM1N9vpWgYmZYadpzdp2J7fkauH2qtJF+YM17wmihAnTZP8
         +jQaDa1Ql/EHtHLxvvhT0dFJvVpjDSb3WvLZsXiQAn0aPpt9R/5I5RkBj6lrsz9Ltu5K
         o+S/DF30RhsI0a4O1zFl7BcMnpvrwKjWwYoZZWAgrHyQo/IThSvmIzDfKCUb7a2u7hop
         9ElfHQou8p0YHT3JBvKn82H4FXZ86NfVyJYIeiVufNl2wmlaJnhIjH4lD3TAa4XqgGTr
         fmeXKZKNhibY7tGzqjK1VqsdY3YxfayQIdy5kMz9B/izhh5yqzB3IUyVo+3UhAzbyqnO
         SjMQ==
X-Gm-Message-State: AOAM531k0RzabAXnZ7hVRPQd2cArXbaKEFVBf29s46WnQvi6qaB9DiNK
        GKa6ceCJZn2ZI/QhoT1EncyL6g==
X-Google-Smtp-Source: ABdhPJxNeagQXELCYW+nbXCZDSKD7v5lxDpyV1kAtWIlIA4tc9aIwmCKQVLx7D+Mh0TiElFBDqSMRw==
X-Received: by 2002:a9d:249:: with SMTP id 67mr9271547otb.356.1622950427019;
        Sat, 05 Jun 2021 20:33:47 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t32sm551510oiw.44.2021.06.05.20.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 20:33:46 -0700 (PDT)
Date:   Sat, 5 Jun 2021 22:33:44 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lee.jones@linaro.org, agross@kernel.org, gurus@codeaurora.org,
        dmitry.baryshkov@linaro.org
Subject: Re: [PATCH net-next v3] mfd: pm8008: Fix return value check in
 pm8008_probe()
Message-ID: <YLxCGLALLlO4i14n@builder.lan>
References: <20210605022446.4119978-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210605022446.4119978-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04 Jun 21:24 CDT 2021, Yang Yingliang wrote:

> In case of error, the function devm_regmap_init_i2c() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check
> should be replaced with IS_ERR().
> 
> Fixes: 6b149f3310a4 ("mfd: pm8008: Add driver for QCOM PM8008 PMIC")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
> v3:
>   return PTR_ERR(chip->regmap) instead of ENODEV
> ---
>  drivers/mfd/qcom-pm8008.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
> index c472d7f8103c..fb8915a682ad 100644
> --- a/drivers/mfd/qcom-pm8008.c
> +++ b/drivers/mfd/qcom-pm8008.c
> @@ -228,8 +228,8 @@ static int pm8008_probe(struct i2c_client *client)
>  
>  	chip->dev = &client->dev;
>  	chip->regmap = devm_regmap_init_i2c(client, &qcom_mfd_regmap_cfg);
> -	if (!chip->regmap)
> -		return -ENODEV;
> +	if (IS_ERR(chip->regmap))
> +		return PTR_ERR(chip->regmap);
>  
>  	i2c_set_clientdata(client, chip);
>  
> -- 
> 2.25.1
> 
