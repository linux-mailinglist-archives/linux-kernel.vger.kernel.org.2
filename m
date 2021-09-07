Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E454028FA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 14:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344331AbhIGMiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 08:38:20 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:37848
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344294AbhIGMiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 08:38:00 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4C64540198
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 12:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631018212;
        bh=kUQBNqvLjn5SJ3y1jqXZ48A4UtyVFge6gK8Eh6dxOP4=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=WyrhTmj9zgO6keP82oaUqcmbwMuau7JlVaMqnxjWaBT6sUFNJFf3AKFAIBRo7b1QA
         5XRqJ5ornpG95nePylV0w9IUBAofuktk+ciXlwPyDy9SAN/amrsYTGn/JafUWVt8Ah
         JODYA43k9J68OT6C1/NRF+HJXn2cI/muFXlfwe9fp0FICUD0Kl1T1UszXts6FtmO+V
         ctq2zZ/1vX1gKRY56B9f7KNrOGEAY0vRKTdXX5fmZC8OWV/pkWLlB3M3BAz9lZURes
         tmP4VUDgJUi27/B0HNv11k5iXhEeW5/2COd2uZmV34aknHu7GR5Lw+CpZmSYPkuQK9
         xQ9pjHMjkbpmA==
Received: by mail-wr1-f71.google.com with SMTP id z16-20020adfdf90000000b00159083b5966so2047253wrl.23
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 05:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kUQBNqvLjn5SJ3y1jqXZ48A4UtyVFge6gK8Eh6dxOP4=;
        b=hU4g7zqysxRwhiwRmBr0xmOJdGtIDZ0siYL7VoEv/+idf9eZFruR9nvMZBboi1CIcD
         +DNhUmGmXHkt06jtDFMydF1pzeOEjH6AJYIoZkTsDn27/wBNY9EW/d3H0P1cpH/f+d+z
         v9/X2HsQMH7L0gOaFcrjipIKYofLigrFgn8CnN8TifAXVx5zsblVJRuAfPvwaLV9b85h
         jf6xVUpYt5tJa8K6nb88nKVoRA3SBu/CUebLIzCIPq4HTxoQlAEPT6B5daq3D9H8RnH+
         mm+NJpjnKUVvRqTcpdKYAURN5ZuRF0sX3bN7Bo+TE0UJDG82jnX55Ea3sZ/SxIOxC/Mo
         PXlw==
X-Gm-Message-State: AOAM53089YEQu7+DVz7hzsiixoAxcqLkHJKoYGi0XXulCB60drhR/wyy
        VmiyxCO1Xd9iwbZASeWT5t8/VvQg8DsdGx2cB6xC9Ca9m1gM97Y0QTjDU7bzLhW+jCu9xi498c7
        WvvFSL78auvdBbtG0tW0CZZHNdPgnEHSVAqEFWjQF7Q==
X-Received: by 2002:a05:6000:18a:: with SMTP id p10mr17958050wrx.40.1631018208533;
        Tue, 07 Sep 2021 05:36:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyinpXYU71XtwrZ3JCIxVV95srjFG3YvDI9n19gDYcDpDB5gs1mVCHI2a/OvPBFynEGh2zVEg==
X-Received: by 2002:a05:6000:18a:: with SMTP id p10mr17958032wrx.40.1631018208383;
        Tue, 07 Sep 2021 05:36:48 -0700 (PDT)
Received: from [192.168.3.211] ([79.98.113.233])
        by smtp.gmail.com with ESMTPSA id i9sm753657wmi.44.2021.09.07.05.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 05:36:47 -0700 (PDT)
Subject: Re: [PATCH v3 8/8] memory: gpmc-omap: "gpmc,device-width" DT property
 is optional
To:     Roger Quadros <rogerq@kernel.org>, tony@atomide.com
Cc:     robh+dt@kernel.org, grygorii.strashko@ti.com, nm@ti.com,
        lokeshvutla@ti.com, nsekhar@ti.com, miquel.raynal@bootlin.com,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210907113226.31876-1-rogerq@kernel.org>
 <20210907113226.31876-9-rogerq@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <aa465bd9-b3d5-8d75-3e59-e86c2cd093cd@canonical.com>
Date:   Tue, 7 Sep 2021 14:36:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210907113226.31876-9-rogerq@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2021 13:32, Roger Quadros wrote:
> Check for valid gpmc,device-width, nand-bus-width and bank-width
> at one place. Default to 8-bit width if none present.

I don't understand the message in the context of the patch. The title
says one property is optional - that's it. The message says you
consolidate checks. How is this related to the title?

The patch itself moves around checking of properties and reads
nand-bus-width *always*. It does not "check at one place" but rather
"check always". In the same time, the patch does not remove
gpmc,device-width check in other place.

All three elements - the title, message and patch - do different things.
What did you want to achieve here? Can you help in clarifying it?


Best regards,
Krzysztof


> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  drivers/memory/omap-gpmc.c | 41 ++++++++++++++++++++++++--------------
>  1 file changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> index f80c2ea39ca4..32d7c665f33c 100644
> --- a/drivers/memory/omap-gpmc.c
> +++ b/drivers/memory/omap-gpmc.c
> @@ -2171,10 +2171,8 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>  		}
>  	}
>  
> -	if (of_device_is_compatible(child, "ti,omap2-nand")) {
> -		/* NAND specific setup */
> -		val = 8;
> -		of_property_read_u32(child, "nand-bus-width", &val);
> +	/* DT node can have "nand-bus-width" or "bank-width" or "gpmc,device-width" */
> +	if (!of_property_read_u32(child, "nand-bus-width", &val)) {
>  		switch (val) {
>  		case 8:
>  			gpmc_s.device_width = GPMC_DEVWIDTH_8BIT;
> @@ -2183,24 +2181,37 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>  			gpmc_s.device_width = GPMC_DEVWIDTH_16BIT;
>  			break;
>  		default:
> -			dev_err(&pdev->dev, "%pOFn: invalid 'nand-bus-width'\n",
> -				child);
> +			dev_err(&pdev->dev,
> +				"%pOFn: invalid 'nand-bus-width':%d\n", child, val);
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +	} else if (!of_property_read_u32(child, "bank-width", &val)) {
> +		if (val != 1 && val != 2) {
> +			dev_err(&pdev->dev,
> +				"%pOFn: invalid 'bank-width':%d\n", child, val);
>  			ret = -EINVAL;
>  			goto err;
>  		}
> +		gpmc_s.device_width = val;
> +	} else if (!of_property_read_u32(child, "gpmc,device-width", &val)) {
> +		if (val != 1 && val != 2) {
> +			dev_err(&pdev->dev,
> +				"%pOFn: invalid 'gpmc,device-width':%d\n", child, val);
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +		gpmc_s.device_width = val;
> +	} else {
> +		/* default to 8-bit */
> +		gpmc_s.device_width = GPMC_DEVWIDTH_8BIT;
> +	}
>  
> +	if (of_device_is_compatible(child, "ti,omap2-nand")) {
> +		/* NAND specific setup */
>  		/* disable write protect */
>  		gpmc_configure(GPMC_CONFIG_WP, 0);
>  		gpmc_s.device_nand = true;
> -	} else {
> -		ret = of_property_read_u32(child, "bank-width",
> -					   &gpmc_s.device_width);
> -		if (ret < 0 && !gpmc_s.device_width) {
> -			dev_err(&pdev->dev,
> -				"%pOF has no 'gpmc,device-width' property\n",
> -				child);
> -			goto err;
> -		}
>  	}
>  
>  	/* Reserve wait pin if it is required and valid */
> 


