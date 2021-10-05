Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA75423337
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 00:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbhJEWJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 18:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbhJEWJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 18:09:08 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52849C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 15:07:17 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r7so2283915wrc.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 15:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CjObwV75ehLZnSVmvWOQDxCfMBy93mRCI9CdS9ZUuPM=;
        b=kZRfKZLR2kUhIkrcfWq8NG8RvmLNgsDDLFWg7rAQVIajuJBm0f3H9W9wALXJsnJyF/
         WO4H2P4OGrc6NTPZpgVL1sFzKgxDvYjsT+2hjNlRutgtF6epWxBVLQEZACzkzZqJrLZ3
         YC4psS3LF9c8gEKJH2BPCHk1YnrM3+LbLwhCtM9H5/w1r7KCqNur182fwDhSv70kne2e
         cyHXO+p2PNlGrSYJ+HCqcOczCIK7x2F4iaTNR6WmcHfK1YtnrfI11Bilzp4GTUeXlbwU
         Y6ORqnfZL/SDJfgLCEx8iggvlvY942PkpH7ZnEDpeEBWSDAkbEGruxtLDO4YOCtXFzPC
         NCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CjObwV75ehLZnSVmvWOQDxCfMBy93mRCI9CdS9ZUuPM=;
        b=SSSMagY1O2qOYsBqJbiXk4InphLSBEu5ICGZZm36V6BzveYDq/bzdoZWUh2rlnMZYi
         nKqRbdeJUWb8Y3N2s088PHBNjCB0LsOWZGTHrUgFibNszri19782rwRx0DC627bimobT
         kdZGF0F4dQP8UaNTQNRNrUrwHy2J3PcEx5NOxaqaJcl1g+EaLodH/SBNYRdPrlOjEbi4
         jn8QaiGG+mAgKddfMqe23YUyNSYbxCu2tvE5gNh2ZiYAtrYffLr/crMRVSl3yLz/HH0h
         nQ0jWtBrfsteWh6OXIdspxASUR9coGV1wM56syOjbKJ0v71GvMG5H4KCEEH055vkkvS3
         rwmA==
X-Gm-Message-State: AOAM531R/MFtKTYJpHS/a78IgKaSB2eYyUjcKMPMaHA3ib8tvP/0bNlS
        nqudeNga/LntdCWPQ9QlvXc=
X-Google-Smtp-Source: ABdhPJzW0B+WPl5TW1fUjnGL1QDYWkAFKxMrkYbA4YGfjOvokBhLTAxNwsXmGZzwzH0JjQiUJb07QQ==
X-Received: by 2002:a05:600c:35c6:: with SMTP id r6mr6132695wmq.24.1633471635962;
        Tue, 05 Oct 2021 15:07:15 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::f816? ([2a02:8108:96c0:3b88::f816])
        by smtp.gmail.com with ESMTPSA id x21sm3339148wmc.14.2021.10.05.15.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 15:07:15 -0700 (PDT)
Message-ID: <fc896fc5-3c1e-ccaf-06c2-345ad2c2e063@gmail.com>
Date:   Wed, 6 Oct 2021 00:07:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 7/9] staging: r8188eu: chip_type is write-only
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211005200821.19783-1-martin@kaiser.cx>
 <20211005200821.19783-7-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211005200821.19783-7-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/21 22:08, Martin Kaiser wrote:
> chip_type in struct adapter is never read. Remove the component
> and the code to initialise it.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/hal/usb_ops_linux.c |  6 ------
>   drivers/staging/r8188eu/include/drv_types.h |  1 -
>   drivers/staging/r8188eu/include/hal_intf.h  | 10 ----------
>   drivers/staging/r8188eu/include/usb_ops.h   |  3 ---
>   drivers/staging/r8188eu/os_dep/usb_intf.c   |  7 -------
>   5 files changed, 27 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> index 9544300fab65..4c1974cc9a16 100644
> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> @@ -558,9 +558,3 @@ void rtl8188eu_xmit_tasklet(unsigned long priv)
>   			break;
>   	}
>   }
> -
> -void rtl8188eu_set_hw_type(struct adapter *adapt)
> -{
> -	adapt->chip_type = RTL8188E;
> -	DBG_88E("CHIP TYPE: RTL8188E\n");
> -}
> diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
> index 9fa561ad340b..9b9f7d89519c 100644
> --- a/drivers/staging/r8188eu/include/drv_types.h
> +++ b/drivers/staging/r8188eu/include/drv_types.h
> @@ -205,7 +205,6 @@ struct adapter {
>   			     * replace module. */
>   	int	pid[3];/* process id from UI, 0:wps, 1:hostapd, 2:dhcpcd */
>   	int	bDongle;/* build-in module or external dongle */
> -	u16	chip_type;
>   	u16	interface_type;/* USB,SDIO,SPI,PCI */
>   
>   	struct dvobj_priv *dvobj;
> diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
> index ee8e67dafe7c..89bd6f4b06e2 100644
> --- a/drivers/staging/r8188eu/include/hal_intf.h
> +++ b/drivers/staging/r8188eu/include/hal_intf.h
> @@ -15,16 +15,6 @@ enum RTL871X_HCI_TYPE {
>   	RTW_GSPI	= BIT(3),
>   };
>   
> -enum _CHIP_TYPE {
> -	NULL_CHIP_TYPE,
> -	RTL8712_8188S_8191S_8192S,
> -	RTL8188C_8192C,
> -	RTL8192D,
> -	RTL8723A,
> -	RTL8188E,
> -	MAX_CHIP_TYPE
> -};
> -
>   enum hw_variables {
>   	HW_VAR_MEDIA_STATUS,
>   	HW_VAR_MEDIA_STATUS1,
> diff --git a/drivers/staging/r8188eu/include/usb_ops.h b/drivers/staging/r8188eu/include/usb_ops.h
> index 1939b781b097..0a1155bbc7b8 100644
> --- a/drivers/staging/r8188eu/include/usb_ops.h
> +++ b/drivers/staging/r8188eu/include/usb_ops.h
> @@ -19,9 +19,6 @@
>   
>   #include "usb_ops_linux.h"
>   
> -void rtl8188eu_set_hw_type(struct adapter *padapter);
> -#define hal_set_hw_type rtl8188eu_set_hw_type
> -
>   /*
>    * Increase and check if the continual_urb_error of this @param dvobjprivei
>    * is larger than MAX_CONTINUAL_URB_ERR
> diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> index b5e0c6561108..193b5faac56a 100644
> --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> @@ -172,12 +172,6 @@ static void usb_dvobj_deinit(struct usb_interface *usb_intf)
>   
>   }
>   
> -static void chip_by_usb_id(struct adapter *padapter)
> -{
> -	padapter->chip_type = NULL_CHIP_TYPE;
> -	hal_set_hw_type(padapter);
> -}
> -
>   static void usb_intf_start(struct adapter *padapter)
>   {
>   	rtl8188eu_inirp_init(padapter);
> @@ -387,7 +381,6 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
>   
>   	/* step 1-1., decide the chip_type via vid/pid */
>   	padapter->interface_type = RTW_USB;
> -	chip_by_usb_id(padapter);
>   
>   	if (rtw_handle_dualmac(padapter, 1) != _SUCCESS)
>   		goto free_adapter;
> 

Looks good to me.

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael
