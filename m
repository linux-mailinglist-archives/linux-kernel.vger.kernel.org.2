Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153C433AB04
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 06:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhCOF1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 01:27:55 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:42822 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhCOF1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 01:27:37 -0400
Received: by mail-lj1-f170.google.com with SMTP id 184so14705060ljf.9;
        Sun, 14 Mar 2021 22:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=wOKNiBuyV2EBb5bEXF6m0Zu6EfHeC7lgHHf+sekEJJM=;
        b=byd3KCAfm2cKjDIW6fWihG1DsTg71uONWxtwq9IcBHvwxbJ7sxHGuAo78fsg5thgSj
         UXDQpImBsqaIaAxpm+BUWNiD2zaLOD6mNuTQ6rv7kdq091k3pDySqoFQGnKYYqh+k1gw
         Hms2zWQCjaPVeCnnWACRMNA1UmW7gq4uHDW/xgk+eFTBg45cfFMyNrf/FUH+l0jrrWP2
         1ZKewFhP+umSrudIdrhrrohJu2jWKNnyWabAOdm63bdnbFYCI2MVZmIFfFFWRzwF6WGT
         fzog384I8d4Rv5klPtBMt8p+s0txGKPua6qePBKoXUdrPOi9KIT5PFgb2Tw7NQK634UN
         3aoQ==
X-Gm-Message-State: AOAM530oh4x8aZpgM2r2Fw4Wb5NkHinjJtwf2rAgjgTiSoZfS1cUG2Vw
        8eeR1UpNBNRGPv22W+3HvrdddzowsBY=
X-Google-Smtp-Source: ABdhPJzy77AmdCgrI712x2ZghN5JBTxRTVJcDmEL731Vu4qs2tt98XBeq4lW93Od1QGmaMX9kzSzfw==
X-Received: by 2002:a05:651c:118a:: with SMTP id w10mr9296774ljo.431.1615786055762;
        Sun, 14 Mar 2021 22:27:35 -0700 (PDT)
Received: from dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id v11sm2757386ljp.63.2021.03.14.22.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 22:27:34 -0700 (PDT)
Message-ID: <0d1bdcff83fcd875a968cc4fe5c4943e08e44a6b.camel@fi.rohmeurope.com>
Subject: Re: [PATCH] regulator: bd9576: Fix return from bd957x_probe()
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-power@fi.rohmeurope.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <YEsbfLJfEWtnRpoU@mwanda>
References: <YEsbfLJfEWtnRpoU@mwanda>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Mon, 15 Mar 2021 07:27:25 +0200
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2021-03-12 at 10:42 +0300, Dan Carpenter wrote:
> The probe() function returns an uninitialized variable in the success
> path.  There is no need for the "err" variable at all, just delete
> it.
> 
> Fixes: b014e9fae7e7 ("regulator: Support ROHM BD9576MUF and
> BD9573MUF")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks for killing the bug Dan! Very much appreciated.

By the way, this is going to conflict with the regulator notification
extension RFC series. I will rebase the RFC when this gets in tree.

Reviewed-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

> ---
>  drivers/regulator/bd9576-regulator.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/regulator/bd9576-regulator.c
> b/drivers/regulator/bd9576-regulator.c
> index a8b5832a5a1b..204a2da054f5 100644
> --- a/drivers/regulator/bd9576-regulator.c
> +++ b/drivers/regulator/bd9576-regulator.c
> @@ -206,7 +206,7 @@ static int bd957x_probe(struct platform_device
> *pdev)
>  {
>  	struct regmap *regmap;
>  	struct regulator_config config = { 0 };
> -	int i, err;
> +	int i;
>  	bool vout_mode, ddr_sel;
>  	const struct bd957x_regulator_data *reg_data =
> &bd9576_regulators[0];
>  	unsigned int num_reg_data = ARRAY_SIZE(bd9576_regulators);
> @@ -279,8 +279,7 @@ static int bd957x_probe(struct platform_device
> *pdev)
>  		break;
>  	default:
>  		dev_err(&pdev->dev, "Unsupported chip type\n");
> -		err = -EINVAL;
> -		goto err;
> +		return -EINVAL;
>  	}
>  
>  	config.dev = pdev->dev.parent;
> @@ -300,8 +299,7 @@ static int bd957x_probe(struct platform_device
> *pdev)
>  			dev_err(&pdev->dev,
>  				"failed to register %s regulator\n",
>  				desc->name);
> -			err = PTR_ERR(rdev);
> -			goto err;
> +			return PTR_ERR(rdev);
>  		}
>  		/*
>  		 * Clear the VOUT1 GPIO setting - rest of the
> regulators do not
> @@ -310,8 +308,7 @@ static int bd957x_probe(struct platform_device
> *pdev)
>  		config.ena_gpiod = NULL;
>  	}
>  
> -err:
> -	return err;
> +	return 0;
>  }
>  
>  static const struct platform_device_id bd957x_pmic_id[] = {

