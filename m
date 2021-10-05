Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C607423338
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 00:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbhJEWJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 18:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbhJEWJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 18:09:25 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07925C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 15:07:34 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j8so2323915wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 15:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=h9BC/lpH9+H/+LNBCuOS7nJFIHUjUqzgDBt5IUM8lc0=;
        b=n/R5zpFrmW148ixEmxyWlSX0QOdrBkmTIe4bEVIZqKJuYcypBzmbigsMQWOPtF6v7Q
         4LVNOS3gE4vgJuEqxbDaLN+tcVuHdvS2v1AJZV+Mt3Xq6VCE7040+db84qczr3xVBGIt
         UzTIwJVVEBReN8NECb/DiGzZ+zeRGWnLcL5MFNAICYubgXFQCG+P0CN569FmWm7bB0hm
         zLU/T+8dmaa5y+o6h4g22FY95NQBpFK3gWOO/fW9SB4azoVdFr6GRPkNFmNYLtg51ZeD
         sRQ3J/0V6skZMa8+JOIOxbbzjEeELlha2VVcXtLChGOOOhLDvOTKhYU1EDKruAw6Xre3
         wPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h9BC/lpH9+H/+LNBCuOS7nJFIHUjUqzgDBt5IUM8lc0=;
        b=6a6YokR9pIuC3PGJD6kFU/WvVUHn+b+p6UoxFZqUHoia9qvH3LIMfnxVn3IohcwYTb
         k2zg4CcS6m9QMBGJdtKdc/gXqzWw+Dnoqk6ZkTmkttf4igNs4aVH2pI9Wf2sYpnSJigj
         So5X/TjDaxr/Ah9CUrkEd4X55hPSALrMWDVPe/f2xB6QYUBhoohl89enzjNYir71V5ta
         6ln0aXZQi145i58t6wBR2Mr+h6caF7914IG4Vk6cV4CThrUn/ObWlmXh7N8se+JaG/3V
         +IUqhxPYQ9hSPr7UrSS2OlDIPjqBaqUELhN8A+fDp/zSs4qKU0oiTp/DXr19kljDiT9Q
         m1Vg==
X-Gm-Message-State: AOAM532Pzn0ccMnFQBi8QUAcnqQPgffNv20UYV464//rnyvdYEhmkZ6d
        W+uW/EKd0J/jb7C6MYu47I0fd/GmZkg=
X-Google-Smtp-Source: ABdhPJz6mJVjopPeUFWczfV1BSj4iWUIBZEoVDXII1Xba0+M0dBTDn8dHWymgv6tWSvUm50cqRmLGA==
X-Received: by 2002:a05:600c:2256:: with SMTP id a22mr4839667wmm.61.1633471652695;
        Tue, 05 Oct 2021 15:07:32 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::f816? ([2a02:8108:96c0:3b88::f816])
        by smtp.gmail.com with ESMTPSA id c204sm3313398wme.11.2021.10.05.15.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 15:07:32 -0700 (PDT)
Message-ID: <67971ba2-ac6c-6ad8-a568-740846222fff@gmail.com>
Date:   Wed, 6 Oct 2021 00:07:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 8/9] staging: r8188eu: interface type is always usb
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211005200821.19783-1-martin@kaiser.cx>
 <20211005200821.19783-8-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211005200821.19783-8-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/21 22:08, Martin Kaiser wrote:
> This driver only supports chips that connect via usb. Remove
> interface_type from struct adapter, use a constant in the one
> place where the interface type is needed.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/hal/rtl8188e_dm.c   | 5 +----
>   drivers/staging/r8188eu/include/drv_types.h | 1 -
>   drivers/staging/r8188eu/include/hal_intf.h  | 7 -------
>   drivers/staging/r8188eu/os_dep/usb_intf.c   | 3 ---
>   4 files changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
> index 21494adf2a19..1a0176a60704 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
> @@ -40,10 +40,7 @@ static void Init_ODM_ComInfo_88E(struct adapter *Adapter)
>   
>   	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_PLATFORM, ODM_CE);
>   
> -	if (Adapter->interface_type == RTW_GSPI)
> -		ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_INTERFACE, ODM_ITRF_SDIO);
> -	else
> -		ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_INTERFACE, Adapter->interface_type);/* RTL871X_HCI_TYPE */
> +	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_INTERFACE, ODM_ITRF_USB);
>   
>   	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_IC_TYPE, ODM_RTL8188E);
>   
> diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
> index 9b9f7d89519c..3c972acf329c 100644
> --- a/drivers/staging/r8188eu/include/drv_types.h
> +++ b/drivers/staging/r8188eu/include/drv_types.h
> @@ -205,7 +205,6 @@ struct adapter {
>   			     * replace module. */
>   	int	pid[3];/* process id from UI, 0:wps, 1:hostapd, 2:dhcpcd */
>   	int	bDongle;/* build-in module or external dongle */
> -	u16	interface_type;/* USB,SDIO,SPI,PCI */
>   
>   	struct dvobj_priv *dvobj;
>   	struct	mlme_priv mlmepriv;
> diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
> index 89bd6f4b06e2..ffed6ddadd3f 100644
> --- a/drivers/staging/r8188eu/include/hal_intf.h
> +++ b/drivers/staging/r8188eu/include/hal_intf.h
> @@ -8,13 +8,6 @@
>   #include "drv_types.h"
>   #include "Hal8188EPhyCfg.h"
>   
> -enum RTL871X_HCI_TYPE {
> -	RTW_PCIE	= BIT(0),
> -	RTW_USB		= BIT(1),
> -	RTW_SDIO	= BIT(2),
> -	RTW_GSPI	= BIT(3),
> -};
> -
>   enum hw_variables {
>   	HW_VAR_MEDIA_STATUS,
>   	HW_VAR_MEDIA_STATUS1,
> diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> index 193b5faac56a..5699c44a722b 100644
> --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> @@ -379,9 +379,6 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
>   
>   	padapter->hw_init_mutex = &usb_drv->hw_init_mutex;
>   
> -	/* step 1-1., decide the chip_type via vid/pid */
> -	padapter->interface_type = RTW_USB;
> -
>   	if (rtw_handle_dualmac(padapter, 1) != _SUCCESS)
>   		goto free_adapter;
>   
> 

Looks good to me.

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael
