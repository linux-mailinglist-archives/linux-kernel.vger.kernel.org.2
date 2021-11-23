Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930F845AEE5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 23:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238520AbhKWWSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 17:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhKWWSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 17:18:14 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5ABC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 14:15:06 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id v1so1336306edx.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 14:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xZ8kpcJ8FcEc4hthcURg+cToFoJKv+ChdFGl33yfFBs=;
        b=BPCNtwF7gun9sqAfZsyfIzC1JB0vir3Cbw48gArKJ2lK+KgjG53P23tw4Qk3YVJswS
         QzfgJJtvy8GxGgFhhK2WMMY0IkqoHutG/WoiUJzalvQ8lLIDGyHxbOJfcU0cbfVgFdm7
         wbtcHAJ0GG46Em5MDyU6vF0jD/N2e1qZfGljz3KfZ/KSTC1Vz7jxm4UHoCCLRPW7z4ur
         oJbrHXpOvFWzlHfskN28HJvlPuOxwuIsSzFNoDAPYvdz7DgWhuXIXPZpo1WvjZEI0oJt
         0sxn9fKlE5pzE8VoZroA4a4fHyvphofUBWSpRzhlbMh+HOuWifm001BmnASDNCwOjou0
         XQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xZ8kpcJ8FcEc4hthcURg+cToFoJKv+ChdFGl33yfFBs=;
        b=wbwsiknayPVZxW8IlOG9MOVsDsdzDjyjSFq4RXHFV05hFopJCX5d+rJ5V9FkCh24Pl
         eohzq9kqXCFgACp9JxF05fa2AmET85iE+juD58xdvfIkJRwC3ePEa/sGhpvAbYBA7f84
         HfmZJpF9TAoM1iqjOUuIYDQQNwxwbI1l8w4cSvbT3aImAMlPYLAPC6SDiN1AQaM0yjPe
         YOqOWHJRlWteeop5+C9D6ID0yVxjHT/Uumly4fGwaq8D8/q3zuMcpLWQFVt41JX6cQ/x
         U+E+tWfau+xUxCJeA2LMy5RbL4bo8NcAcZauBZSQfFEYdD2zAF1dZQxUjIwiZRS39IkE
         Jufw==
X-Gm-Message-State: AOAM530Y6UJRvZwF6TMj/mV43bu2v4MdR7v6x/saLgP0FUytYPuKy38a
        9zF4dXCNHuwd42E1cpgPAMA=
X-Google-Smtp-Source: ABdhPJxJ1BrPSESRiZ+jGDJpQnUaP4XiTBh8CrFCMFlliRZYDsDW3a3CDT5n0oa/HMxn8bIJfxMz2A==
X-Received: by 2002:a17:906:fcbb:: with SMTP id qw27mr12385744ejb.320.1637705704632;
        Tue, 23 Nov 2021 14:15:04 -0800 (PST)
Received: from tom-ThinkPad-T470p (net-93-150-197-192.cust.dsl.teletu.it. [93.150.197.192])
        by smtp.gmail.com with ESMTPSA id b2sm6536228edv.73.2021.11.23.14.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 14:15:03 -0800 (PST)
Date:   Tue, 23 Nov 2021 23:15:03 +0100
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: rename variable bHWRadioOff
Message-ID: <20211123221503.GA5439@tom-ThinkPad-T470p>
References: <20211121112000.632456-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211121112000.632456-1-alb3rt0.m3rciai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2021 at 12:19:59PM +0100, Alberto Merciai wrote:
> Replace camelcase hungarian notated variable "bHWRadioOff"
> into linux kernel coding style equivalent variable "hw_radio_off".
> 
> Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
> ---
>  drivers/staging/vt6655/device.h      | 2 +-
>  drivers/staging/vt6655/device_main.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
> index ff171acc11f4..e9d1b56d8809 100644
> --- a/drivers/staging/vt6655/device.h
> +++ b/drivers/staging/vt6655/device.h
> @@ -229,7 +229,7 @@ struct vnt_private {
>  	/* GPIO Radio Control */
>  	unsigned char byRadioCtl;
>  	unsigned char byGPIO;
> -	bool bHWRadioOff;
> +	bool hw_radio_off;
>  	bool bPrvActive4RadioOFF;
>  	bool bGPIOBlockRead;
>  
> diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
> index 1f98f2b069c4..897d70cf32b8 100644
> --- a/drivers/staging/vt6655/device_main.c
> +++ b/drivers/staging/vt6655/device_main.c
> @@ -373,7 +373,7 @@ static void device_init_registers(struct vnt_private *priv)
>  
>  	priv->byRadioCtl = SROMbyReadEmbedded(priv->port_offset,
>  					      EEP_OFS_RADIOCTL);
> -	priv->bHWRadioOff = false;
> +	priv->hw_radio_off = false;
>  
>  	if (priv->byRadioCtl & EEP_RADIOCTL_ENABLE) {
>  		/* Get GPIO */
> @@ -383,10 +383,10 @@ static void device_init_registers(struct vnt_private *priv)
>  		     !(priv->byRadioCtl & EEP_RADIOCTL_INV)) ||
>  		     (!(priv->byGPIO & GPIO0_DATA) &&
>  		     (priv->byRadioCtl & EEP_RADIOCTL_INV)))
> -			priv->bHWRadioOff = true;
> +			priv->hw_radio_off = true;
>  	}
>  
> -	if (priv->bHWRadioOff || priv->bRadioControlOff)
> +	if (priv->hw_radio_off || priv->bRadioControlOff)
>  		CARDbRadioPowerOff(priv);
>  
>  	/* get Permanent network address */
> -- 
> 2.25.1
>

Hi,
Sorry, bad mail address on acked by. Meanwhile I test the build.
It's look's fine too.

Acked-by: Tommaso Merciai <tomm.merciai@gmail.com>
Tested-by: Tommaso Merciai <tomm.merciai@gmail.com>

Regards,
Tommaso
