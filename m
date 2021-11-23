Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63D445AD0B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 21:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240241AbhKWULy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 15:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbhKWULw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 15:11:52 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A5DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 12:08:44 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z5so117405edd.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 12:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SFMYyax3hXkADdwbcLPOWruPeG8tiidGWtjfGAih1B0=;
        b=Uwpf7l6cnj39UigtgCx/Cz34EWqDSLy3Hup4xjIxMV0fcikWmooXR/BQe88mEU/bY8
         iaFhaC2qfR7F6uxhoy1mZd0XxA6C/OH4yeet/Q58spPjeC/I+VMXwGq6iWEy2Kqjr5HX
         +fKc5G8N7h/8bpntgdaTiMiAiplW8OKM1PKlp78R1vldStU1z+BRPtQeYdop2OsJ0FuB
         sJJ8A5oJOcg2knVL/df6mK3ZC51SSKkIgaHm1FlveWtDAxTdJBWAUBJeIeOtKzzMKFoy
         MsFTy7zNP2r73L6sEtSIj/TGAPQX6xQDdTG8nVfmqWsy5+/0i7AcyNaRnWyoGdGMoF62
         Sumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SFMYyax3hXkADdwbcLPOWruPeG8tiidGWtjfGAih1B0=;
        b=ULRlsmvBys+u2TLIb8QhG3ExnDHVDhfv4kKXhPj4JZF6/sI+cVOdPRV9wtqU1FnkGZ
         rxmUfBBmJI00N4lYLVe1rnNLM3ijr2zxQ8RmgB38XSNpvaXzdcfBYhAwYXFgipwMfXjh
         Dbz9nO/mZzpScL5OAFnOuvSv8irLjrvR3DGzNxBA+Rn/Medb1GQrUsNeYe5BonWUEruo
         rAaAUrGdE5MXbQhmv9JCI7Bcf3tzWwBNFmXICuNvEZ38NS+AVKPlCdJ9tu9OuxmBZDm0
         A/p9QprOMtQrpKNqi7cJrVT8DrxSSZXuRD2SogyDsfczM7GAOoJLCSPM+QqaYQ+RjsG1
         cHHA==
X-Gm-Message-State: AOAM530iQ5TFQHdY7wbkjvSvhXGKdpzXfCkEv/LZyNuqx6KvA8h6Qu71
        pIgDGlUuvGpXqyLtvtEFYCQ=
X-Google-Smtp-Source: ABdhPJwkm4ZX/KcmFzde/PRPvxI2lILabxTFxvTz3o08C1PdfthIpah568zpI4tO56KsYmcK0c7Bjw==
X-Received: by 2002:a17:906:f74a:: with SMTP id jp10mr11072785ejb.358.1637698122779;
        Tue, 23 Nov 2021 12:08:42 -0800 (PST)
Received: from tom-desktop (net-93-150-197-192.cust.dsl.teletu.it. [93.150.197.192])
        by smtp.gmail.com with ESMTPSA id e13sm5618682eje.95.2021.11.23.12.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 12:08:37 -0800 (PST)
Date:   Tue, 23 Nov 2021 21:08:32 +0100
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
Message-ID: <20211123200832.GA3206@tom-desktop>
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

Look's okay.

Acked-by: Tommaso Merciai <tommaso.merciai@gmail.com>

Regards,
Tommaso
