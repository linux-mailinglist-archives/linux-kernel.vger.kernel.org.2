Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A6F3D5CAA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 17:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbhGZO30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 10:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbhGZO3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 10:29:25 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4DAC061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 08:09:53 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 68-20020a9d0f4a0000b02904b1f1d7c5f4so9280005ott.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 08:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9y5LahECIAbm3f5+aXFvAJE77WeSPYzFpoV3JjO/OcA=;
        b=abB+W/oYtV5GIKVFYivlzZtIQyVFozF4dr5iM0XT7dfDjsLzSqMFjViC7T7E28FMjc
         HHX7uctGg1AerMKza/DiDRwYv0IYKGqepuhbLccSJrwmYd0dpLphglHM8xgt2NoXFWQo
         jH/eZoVt+cJpjRHatY8kW2v2PdrjhJ+Sxx0fuhiz1V4pIgiQGnpoHPNXpkRf1icW8NSv
         06b2V0xERM+VUsVmkazdJZI6F+nW+hEiwuAb250ifE9EMznxjhGzywKy8ec+khfWgDJ0
         lu92ufvLUIwPjHSBgEmYblFTIaqBHVlDHv6tTywqRvgmsoZFgsMjXg0nHpf3g1wvy61b
         QjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9y5LahECIAbm3f5+aXFvAJE77WeSPYzFpoV3JjO/OcA=;
        b=BP+Pa6JEgesybZOvFOGDbd1gR8Pu8QnhwRnykurIUo3WQEQB4xlyodiIfTIj2xVTEb
         Cf5PLcEP8zdVbOPQMznLtAyLsc6HYb1/eKz9Lz14UnJu7tRrNhoma/29zBdoUlmR0IGY
         9k9HOXh5UVWcYdhbvxIBzGDKLvCQYEYW0fJ3NQ+LNmFvwBBHkvcI0C4/T5AoAG4Grluw
         X83UX5Fo8bnGyy/HX4Wyq7evOnj3pimsu39WmZPR6dhLHJ3naVVZgczagB5f0jXGcrbg
         fMp+F61WZZaHIU3a+tyy7E/tcHyquh3pqx71OsYwa6iTi43jcoPYZjLd5ps5wTgVoenS
         7iMw==
X-Gm-Message-State: AOAM532D4sRB1OTW9rbP7ZgKiQDD0PvVMH6sJqMhJH3ZXZI5TRIL4iCQ
        0rHenMs5TSdYrBZQT1zq3ZMV9msQZag=
X-Google-Smtp-Source: ABdhPJwXJ1SBm7ggRywbdbC9XLBKlLOsXbwuORU/tF5+YW22/dp7Zb778l8T0L5poN8C/JKb13m7xQ==
X-Received: by 2002:a9d:2782:: with SMTP id c2mr12152793otb.323.1627312192706;
        Mon, 26 Jul 2021 08:09:52 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id m19sm34109otp.55.2021.07.26.08.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 08:09:52 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH] staging: rtl8188eu: remove braces from single line if
 blocks
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210726092129.30334-1-straube.linux@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <a4eb0dea-a34b-8dd9-03c6-aa0d87e68986@lwfinger.net>
Date:   Mon, 26 Jul 2021 10:09:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210726092129.30334-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/21 4:21 AM, Michael Straube wrote:
> Remove braces from single line if blocks to clear checkpatch warnings.
> WARNING: braces {} are not necessary for single statement blocks
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>   drivers/staging/rtl8188eu/core/rtw_cmd.c          | 3 +--
>   drivers/staging/rtl8188eu/core/rtw_mlme.c         | 3 +--
>   drivers/staging/rtl8188eu/core/rtw_xmit.c         | 3 +--
>   drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c | 3 +--
>   drivers/staging/rtl8188eu/hal/usb_halinit.c       | 6 ++----
>   5 files changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_cmd.c b/drivers/staging/rtl8188eu/core/rtw_cmd.c
> index eb89a52aa4e3..56ece839c9ca 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_cmd.c
> @@ -1159,9 +1159,8 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
>   		psta = rtw_get_stainfo(&padapter->stapriv, pnetwork->MacAddress);
>   		if (!psta) {
>   			psta = rtw_alloc_stainfo(&padapter->stapriv, pnetwork->MacAddress);
> -			if (!psta) {
> +			if (!psta)
>   				goto createbss_cmd_fail;
> -			}
>   		}
>   
>   		rtw_indicate_connect(padapter);
> diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
> index 71d205f3d73d..0d334aba9a3f 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
> @@ -953,9 +953,8 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
>   			}
>   
>   			/* s4. indicate connect */
> -			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
> +			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
>   				rtw_indicate_connect(adapter);
> -			}
>   
>   			/* s5. Cancel assoc_timer */
>   			del_timer_sync(&pmlmepriv->assoc_timer);
> diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
> index d5fc59417ec6..c77ebd18f40c 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
> @@ -1124,9 +1124,8 @@ struct xmit_buf *rtw_alloc_xmitbuf(struct xmit_priv *pxmitpriv)
>   		list_del_init(&pxmitbuf->list);
>   		pxmitpriv->free_xmitbuf_cnt--;
>   		pxmitbuf->priv_data = NULL;
> -		if (pxmitbuf->sctx) {
> +		if (pxmitbuf->sctx)
>   			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
> -		}
>   	}
>   	spin_unlock_irqrestore(&pfree_xmitbuf_queue->lock, irql);
>   
> diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
> index 6cf87312bc36..a67615708745 100644
> --- a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
> +++ b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
> @@ -510,7 +510,6 @@ void Hal_ReadThermalMeter_88E(struct adapter *Adapter, u8 *PROMContent, bool Aut
>   	else
>   		pHalData->EEPROMThermalMeter = EEPROM_Default_ThermalMeter_88E;
>   
> -	if (pHalData->EEPROMThermalMeter == 0xff || AutoloadFail) {
> +	if (pHalData->EEPROMThermalMeter == 0xff || AutoloadFail)
>   		pHalData->EEPROMThermalMeter = EEPROM_Default_ThermalMeter_88E;
> -	}
>   }
> diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
> index 1d7d5037ce89..3e8f7315d377 100644
> --- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
> +++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
> @@ -641,9 +641,8 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
>   	}
>   
>   	status = rtw_hal_power_on(Adapter);
> -	if (status == _FAIL) {
> +	if (status == _FAIL)
>   		goto exit;
> -	}
>   
>   	/*  Save target channel */
>   	haldata->CurrentChannel = 6;/* default set to 6 */
> @@ -696,9 +695,8 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
>   	_InitTxBufferBoundary(Adapter, txpktbuf_bndy);
>   
>   	status =  InitLLTTable(Adapter, txpktbuf_bndy);
> -	if (status == _FAIL) {
> +	if (status == _FAIL)
>   		goto exit;
> -	}
>   
>   	/*  Get Rx PHY status in order to report RSSI and others. */
>   	_InitDriverInfoSize(Adapter, DRVINFO_SZ);
> 

Michael,

You might as well stop looking at drivers/staging/rtl8188eu. There is a pending 
patch that blows away that directory and replaces it with a new version from the 
GitHub repo. The new one will be in drivers/staging/r8188eu.

NACKed by Larry.Finger <Larry.Finger@lwfinger.net>

Larry

