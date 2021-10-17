Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DF2430854
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 13:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245475AbhJQL0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 07:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245454AbhJQLZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 07:25:59 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11557C061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 04:23:50 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r7so35606213wrc.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 04:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XLzWMUET//zFH6+EqC3Ryv3/pm+AIDuL+3+PhxzgVWE=;
        b=ImmV6G2XiqCoKPYiOWfACLw4pHscDkufjUVIMH5XGmu9sE2lBwcwoyN7bJUqoyKBzT
         D046tuplx7xtQE59fNquzDo8/LWvFoLL5qsMGMsqAuLWehDQW+jLS7zSjNT7m+eqRaW4
         I7zY21NpahI05l0Unw3qin0R24BgBs0yK9sJk7PBvSwAl6q3wE5VyuNMIsXv8OqoG2fb
         MrE0d/8GSUwszDVa8JmExsZWZzRD7XdxnvZKU9exVmCR7N0WIfB2ahWAHzuV0ia+MLat
         w/EGngpR/x44hFqfXMCwqToee09ZB3PfobpWdDgG2X/KxlTrzxj+Q/x+f9Ru5jqYhY0z
         Bf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XLzWMUET//zFH6+EqC3Ryv3/pm+AIDuL+3+PhxzgVWE=;
        b=b/25aJhMbbMleOQtrue6m2qz9LSDzPMIyNZCXoI9XkZHUpxvER3omZIiFlQIdeXhh3
         th9s5jOvviEwx+J99B/688ug44IoRr0126FYSNdrJA4ZRdUhxeDkgsaE3JRKSy+XkOkv
         BdQCsbYrJPK3Rh/qsj+FRDYaQRzrAoDDwjMj3GI3ucqYLmJsbVb8FnBHF3bxGQpIGTaI
         pchNIqPx/mewHwCNZZJysJtSu/awE848sDHZjh2B4qDaO7bSjT4JvuOp6zs+tFNdreuG
         7OymIAHj+5QSMoOoVpZSGCnI3DvWkhTohJhs9d8DfKooflqc+5WxajCZeUkNfFwKsUw5
         IVfQ==
X-Gm-Message-State: AOAM5331aikCGOsnT40vdb1Xfhz8I4TE9/lVo2J6OiYrZXi4x6L0teze
        J694/CYK6irX9DRsUde75mA=
X-Google-Smtp-Source: ABdhPJzJs8LHIqkt0iIOerCnRaVtxvC1nDkfOrS6SfYm//FRM9nz6jKfeF9Pnnz0dzFbLKtb4iXNXQ==
X-Received: by 2002:adf:9c02:: with SMTP id f2mr28691366wrc.329.1634469828571;
        Sun, 17 Oct 2021 04:23:48 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::d7f0? ([2a02:8108:96c0:3b88::d7f0])
        by smtp.gmail.com with ESMTPSA id g12sm15427812wme.3.2021.10.17.04.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 04:23:48 -0700 (PDT)
Message-ID: <bfb8ed6d-973b-d58e-3a06-9b1a00d3243e@gmail.com>
Date:   Sun, 17 Oct 2021 13:23:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/8] staging: r8188eu: remove empty trigger gpio code
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211016113008.27549-1-martin@kaiser.cx>
 <20211016113008.27549-2-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211016113008.27549-2-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/21 13:30, Martin Kaiser wrote:
> The hal variable HW_VAR_TRIGGER_GPIO_0 and the rtl8192cu_trigger_gpio_0
> function are not used. Remove them.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/hal/usb_halinit.c  | 8 --------
>   drivers/staging/r8188eu/include/hal_intf.h | 1 -
>   2 files changed, 9 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
> index abbd107ad3c1..cdc602fa9af8 100644
> --- a/drivers/staging/r8188eu/hal/usb_halinit.c
> +++ b/drivers/staging/r8188eu/hal/usb_halinit.c
> @@ -1087,11 +1087,6 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter)
>   	_ReadAdapterInfo8188EU(Adapter);
>   }
>   
> -#define GPIO_DEBUG_PORT_NUM 0
> -static void rtl8192cu_trigger_gpio_0(struct adapter *adapt)
> -{
> -}
> -
>   static void ResumeTxBeacon(struct adapter *adapt)
>   {
>   	struct hal_data_8188e *haldata = GET_HAL_DATA(adapt);
> @@ -1657,9 +1652,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
>   			}
>   		}
>   		break;
> -	case HW_VAR_TRIGGER_GPIO_0:
> -		rtl8192cu_trigger_gpio_0(Adapter);
> -		break;
>   	case HW_VAR_RPT_TIMER_SETTING:
>   		{
>   			u16 min_rpt_time = (*(u16 *)val);
> diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
> index 408168284b3f..d777ad9071e2 100644
> --- a/drivers/staging/r8188eu/include/hal_intf.h
> +++ b/drivers/staging/r8188eu/include/hal_intf.h
> @@ -55,7 +55,6 @@ enum hw_variables {
>   	HW_VAR_TDLS_RS_RCR,
>   	HW_VAR_TDLS_DONE_CH_SEN,
>   	HW_VAR_INITIAL_GAIN,
> -	HW_VAR_TRIGGER_GPIO_0,
>   	HW_VAR_BT_SET_COEXIST,
>   	HW_VAR_BT_ISSUE_DELBA,
>   	HW_VAR_CURRENT_ANTENNA,
> 


Acked-by: Michael Straube <straube.linux@gmail.com>
