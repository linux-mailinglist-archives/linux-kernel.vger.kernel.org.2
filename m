Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A68360572
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhDOJQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbhDOJQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:16:50 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1789EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:16:28 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id o9-20020a1c41090000b029012c8dac9d47so4797992wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DeXDeXRzRy6XeBITm1wvQ0gcDeECEHBICqvLtdhOGSI=;
        b=ULxk+4yqlbHmpoJ3Qp2um9iggnfyBOrzKWB7u1KSZhsBa65PQnGBDN6jN7SH1iMOfk
         QtZHd4OazysP8bnTLU8AckxlKctvNP6DH4sfHDiIaaPrlT4QOb3voDfAFCMWjzxGh4VA
         1PS5mF0xyWCxvTcjornEABaPoCm3jXPrNW5uxDoZcgq4OXbZXTG8Rr6t6CEnAewDhoIg
         8lfz7jfWml9d1IbP+aiU0f9pw6XoEkLGgLLbVqggUwexYBAL+f6DPezbyrCBLaOWeJRj
         DEYIc7DNUiaJ824nyU+2psNISzyXIQ5u8aVVZIrq6WnRTX4Im+g7AWiz0vb05qBYMF0k
         dNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DeXDeXRzRy6XeBITm1wvQ0gcDeECEHBICqvLtdhOGSI=;
        b=Ur7CM15dOa28fhkkhyXJcsZBy4DDxDkVeKP/irHYXGj48gxWdBZXofZBTVb01p22R4
         9ai1Xt0hmCchvNrjLReyOWHDu+mZW95KzaQbIDHq1rqSdu/sIrhGrM/FBF8qRvmgoiu5
         jqaHIiav57nYAL6LknzUCk4YZ6/DW0ew8ZKx53tqmhGNS1428ns/ZvxJcR6RNzFRz3bI
         aXloEWxbUV2mmTl+UaHtwmFV/HEK1/fUeMiqh5OeNTV+TYvSVQ1pv/uXEOodg4qkJNYx
         0WV09GF53HbKFovMj1ZNppOaWPQdhzjL1lQK0uKz2eULthqo/xsFngarwn7A7x1wAc5r
         3ETw==
X-Gm-Message-State: AOAM533GPc6hcqweobRcHpPsityLEZRosxR2uY8Pad7EWE399gHAF9vV
        WUcqr/ltuW6yzqaXwb3155aWerIY+TE=
X-Google-Smtp-Source: ABdhPJwCZ9qaO20cLQTF7H4S2efkWPm+h/6++I/OvtzI19nUe/EehNvLrSrEm06Aaf37GZ6NLN/cNQ==
X-Received: by 2002:a05:600c:25ca:: with SMTP id 10mr2223182wml.0.1618478186813;
        Thu, 15 Apr 2021 02:16:26 -0700 (PDT)
Received: from agape.jhs ([5.171.72.223])
        by smtp.gmail.com with ESMTPSA id 3sm1993895wma.45.2021.04.15.02.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 02:16:26 -0700 (PDT)
Date:   Thu, 15 Apr 2021 11:16:23 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stanley@BB.SD3, linux-staging@lists.linux.dev
Subject: Re: [PATCH 57/57] staging: rtl8723bs: hal: sdio_halinit: Remove
 unused variable 'ret'
Message-ID: <20210415091622.GC1431@agape.jhs>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
 <20210414181129.1628598-58-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210414181129.1628598-58-lee.jones@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 07:11:29PM +0100, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/staging/rtl8723bs/hal/sdio_halinit.c: In function ‘CardDisableRTL8723BSdio’:
>  drivers/staging/rtl8723bs/hal/sdio_halinit.c:881:5: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
>  drivers/staging/rtl8723bs/hal/sdio_halinit.c: In function ‘CardDisableRTL8723BSdio’:
>  drivers/staging/rtl8723bs/hal/sdio_halinit.c:881:5: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
>  drivers/staging/rtl8723bs/hal/sdio_halinit.c: In function ‘CardDisableRTL8723BSdio’:
>  drivers/staging/rtl8723bs/hal/sdio_halinit.c:881:5: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
>  drivers/staging/rtl8723bs/hal/sdio_halinit.c: In function ‘CardDisableRTL8723BSdio’:
>  drivers/staging/rtl8723bs/hal/sdio_halinit.c:881:5: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
>  drivers/staging/rtl8723bs/hal/sdio_halinit.c: In function ‘CardDisableRTL8723BSdio’:
>  drivers/staging/rtl8723bs/hal/sdio_halinit.c:881:5: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Fabio Aiuto <fabioaiuto83@gmail.com>
> Cc: Stanley@BB.SD3
> Cc: linux-staging@lists.linux.dev
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/staging/rtl8723bs/hal/sdio_halinit.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> index f6d734dd1a24f..60d3d6d1ba678 100644
> --- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> +++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> @@ -878,10 +878,9 @@ static void CardDisableRTL8723BSdio(struct adapter *padapter)
>  {
>  	u8 u1bTmp;
>  	u8 bMacPwrCtrlOn;
> -	u8 ret = _FAIL;
>  
>  	/*  Run LPS WL RFOFF flow */
> -	ret = HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_enter_lps_flow);
> +	HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_enter_lps_flow);
>  
>  	/* 	==== Reset digital sequence   ====== */
>  
> @@ -909,9 +908,8 @@ static void CardDisableRTL8723BSdio(struct adapter *padapter)
>  	/* 	==== Reset digital sequence end ====== */
>  
>  	bMacPwrCtrlOn = false;	/*  Disable CMD53 R/W */
> -	ret = false;
>  	rtw_hal_set_hwreg(padapter, HW_VAR_APFM_ON_MAC, &bMacPwrCtrlOn);
> -	ret = HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_card_disable_flow);
> +	HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_card_disable_flow);
>  }
>  
>  static u32 rtl8723bs_hal_deinit(struct adapter *padapter)
> -- 
> 2.27.0
> 

perhaps it's better to check the return value and return it
to the caller if something goes wrong,

https://lore.kernel.org/linux-staging/YHQVKPOoGS3auAeQ@kroah.com/

thank you,

fabio
