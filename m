Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70153265E5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 17:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhBZQxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 11:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhBZQxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 11:53:34 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6138C06174A;
        Fri, 26 Feb 2021 08:52:51 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d12so4090252pfo.7;
        Fri, 26 Feb 2021 08:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=caRvlzKeZCwZCXCDqu+48wHhGcclJlGyLeU2ooguUWk=;
        b=YNXgbGQ88/iMEZR8HkZe53EcnGTDPVQe+AygraOZB+2C5EreOAAD6NGmMTGkhZCJS0
         M64QCturuu3MlLQiOHRXGGLZI7XyowmhQE23hoOvFgq1+O4hZiD/ijaLy3n3CIITHg2i
         uYSjK32s9c7JCKhJM93dTpEanbjPzL/UNi+2gD2EaAGFTRBuK/FYA2LxMy3Qtp3+oEn6
         fqoTSx2wQ+pwqcLwXasEBE/sbtF0e9Qx7bFjTVhrpfByKkJG6nOPoVSrjNlhQXZXKO2T
         FTcIoT9oyKRuGgQjCa2wqwejSU/GK7cm9Tgh2r5s3qiW+VoWnf6y3W1TBEOOnCN7UVb2
         9J2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=caRvlzKeZCwZCXCDqu+48wHhGcclJlGyLeU2ooguUWk=;
        b=P7D3WA+cGkxJ3jd2labNJYh2IdEKqPRjNDrwyfTIbdFLtsKB8jr1qKx0I2Xr4ZTs/J
         OnFi/fUURvPEnVYrNRS/UHbNgfhzHQ+Yv5g7wusg3d0gpmk2/fjnznb34ru7lZ8hrXPx
         dqm/UqGVdS5I6mJ5SY8bxsY3G2BGEwClYMYLpaxQ4n79Kq8q90l5EgcodkstNPYPqPMb
         0zGX7s8NfeQ3sWeiu0MGf97jlNZiBi79VghmpzloXE1F7BdRjCg3gWyKcWiXoAL4KPpQ
         bbFrnQZTVAm07M97ORLyp7erDuRAUt0dmILjM1J6uNZhYPwRN/mCzy6KuumllvzhA3b+
         6MNw==
X-Gm-Message-State: AOAM53037iCLOWJSROtqWd1pjsus7YJnc01nhRkLcAJDs5Qzn8DlvHAO
        004HvuDh9stiBmj4nxW5pFE=
X-Google-Smtp-Source: ABdhPJy4TYujm2RcZnuPZrcZjoAOTPx53fJcRTB521JN8cVbqd/utfMS5jC3swp8eOHZWjkp5TJtFQ==
X-Received: by 2002:a63:4207:: with SMTP id p7mr3695325pga.406.1614358371158;
        Fri, 26 Feb 2021 08:52:51 -0800 (PST)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id i2sm9363685pgs.82.2021.02.26.08.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 08:52:50 -0800 (PST)
Subject: Re: [RFC 04/19] devfreq: imx-bus: Decouple imx-bus from icc made
To:     Abel Vesa <abel.vesa@nxp.com>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <djakov@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Martin Kepplinger <martink@posteo.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>
References: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
 <1613750416-11901-5-git-send-email-abel.vesa@nxp.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <970ea39a-d371-6d17-3aa8-768ca4821809@gmail.com>
Date:   Sat, 27 Feb 2021 01:52:42 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1613750416-11901-5-git-send-email-abel.vesa@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21. 2. 20. 오전 1:00, Abel Vesa wrote:
> The link between an imx-bus device and its icc id will be done
> through the fsl,icc-id property in each dts node. The imx
> interconnect driver will pick up all the dts nodes that have that
> property defined and will link them to the rightfull icc id.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>   drivers/devfreq/imx-bus.c | 40 +++------------------------------------
>   1 file changed, 3 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c
> index 1c0c92d0eb08..9f0df88b29c1 100644
> --- a/drivers/devfreq/imx-bus.c
> +++ b/drivers/devfreq/imx-bus.c
> @@ -65,36 +65,6 @@ static void imx_bus_exit(struct device *dev)
>   	platform_device_unregister(priv->icc_pdev);
>   }
>   
> -/* imx_bus_init_icc() - register matching icc provider if required */
> -static int imx_bus_init_icc(struct device *dev)
> -{
> -	struct imx_bus *priv = dev_get_drvdata(dev);
> -	const char *icc_driver_name;
> -
> -	if (!of_get_property(dev->of_node, "#interconnect-cells", 0))
> -		return 0;
> -	if (!IS_ENABLED(CONFIG_INTERCONNECT_IMX)) {
> -		dev_warn(dev, "imx interconnect drivers disabled\n");
> -		return 0;
> -	}
> -
> -	icc_driver_name = of_device_get_match_data(dev);
> -	if (!icc_driver_name) {
> -		dev_err(dev, "unknown interconnect driver\n");
> -		return 0;
> -	}
> -
> -	priv->icc_pdev = platform_device_register_data(
> -			dev, icc_driver_name, -1, NULL, 0);
> -	if (IS_ERR(priv->icc_pdev)) {
> -		dev_err(dev, "failed to register icc provider %s: %ld\n",
> -				icc_driver_name, PTR_ERR(priv->icc_pdev));
> -		return PTR_ERR(priv->icc_pdev);
> -	}
> -
> -	return 0;
> -}
> -
>   static int imx_bus_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> @@ -144,10 +114,6 @@ static int imx_bus_probe(struct platform_device *pdev)
>   		goto err;
>   	}
>   
> -	ret = imx_bus_init_icc(dev);
> -	if (ret)
> -		goto err;
> -
>   	return 0;
>   
>   err:
> @@ -156,9 +122,9 @@ static int imx_bus_probe(struct platform_device *pdev)
>   }
>   
>   static const struct of_device_id imx_bus_of_match[] = {
> -	{ .compatible = "fsl,imx8mq-noc", .data = "imx8mq-interconnect", },
> -	{ .compatible = "fsl,imx8mm-noc", .data = "imx8mm-interconnect", },
> -	{ .compatible = "fsl,imx8mn-noc", .data = "imx8mn-interconnect", },
> +	{ .compatible = "fsl,imx8mq-noc",},
> +	{ .compatible = "fsl,imx8mm-noc",},
> +	{ .compatible = "fsl,imx8mn-noc",},
>   	{ .compatible = "fsl,imx8m-noc", },
>   	{ .compatible = "fsl,imx8m-nic", },
>   	{ /* sentinel */ },
> 

For this patch, you need to get the ack of use of new 'fsl,icc-id 
property'. IMO, looks good to me.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>


And you must update the DT binding document.
[1] Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml

Thanks,
Chanwoo Choi
