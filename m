Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026E73D667D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 20:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbhGZR1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 13:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbhGZR1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 13:27:44 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B44C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 11:08:13 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h14so4188115wrx.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 11:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tsf0a3AvWRqDTexWqFdji1NJV723gxbeeO4aZ8esbCY=;
        b=RTUIlaJd4QwYbQl4SR4G4iWzZaARC/TbgYp2m3JhQtmYj+XpArOCEAPcvyzDO1ureA
         gL1lVGk5nKiDBmEgTla7ZWYJXKFyzuze3ywPj2vHg32PAEtBndmi8gC+2Ylpw/vaGA4U
         QOGnE3lpyx1J1Pv/TYbMno0MADcbcQexm7BFYZhtD6KQpcbUuq06MOIEPGPNJp/1RMWa
         igIfEgdjeI6uPDMdP7OSV6ygPjSjtE3U0ek06NlBsk72FR8hNf0KdQh99aYjF1dIvpz/
         yHZEaOzeZSXnaWzDr3zDt3GbInARcgrIyRnEP8ue6etRxwhc6ku6RReP7BvVbscDvBF3
         D5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tsf0a3AvWRqDTexWqFdji1NJV723gxbeeO4aZ8esbCY=;
        b=JFORoyXCPuI4B8Jdco8T+C1TF56LAEgkwv4ad6nZw6umS5kmL0RwkrSgE1I5x+ogex
         Gp5RGgc5lnBH91ldjfKJUNrVR9Kiu7YVg4OXFlsW8Qtcg3hKKLaiwYsE1l2edvbJBfTA
         Xsg4srvEYl6tpCPVkw8Bw1b7lIZ9mFFUI9CKIfRoyOe5CsmSgPygl8q2Nwne9JfIt2xp
         UG+1sg5O02FpYEH9gZ1lv/sEYvWIHPkL3NllpHEcU8cy0stOHTIHpIs/nODnzAVm5NbL
         RnDZIu13a167bTOC+Pe7TaZG8I6SYXPh2BqGDrQt/78q4kNFqvb1MGyrzWBdhpD5U/Fe
         cz+Q==
X-Gm-Message-State: AOAM532hKYDyJOAoxFtstzdgl3e9uZH/t4IUJdq0UKZysqszQMAPALuh
        QPNloY4QPun/3BqWTzLUer6PP0BpCxw=
X-Google-Smtp-Source: ABdhPJyh+hmqf/cFlwAMkqo7SDzKRv7gg6h/QOz8vezaua9C5i70oMg91SwQLqwHIelxvhtGTstIew==
X-Received: by 2002:a5d:4d07:: with SMTP id z7mr21810782wrt.244.1627322891718;
        Mon, 26 Jul 2021 11:08:11 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::4bf9? ([2a02:8108:96c0:3b88::4bf9])
        by smtp.gmail.com with ESMTPSA id p3sm211943wmp.25.2021.07.26.11.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 11:08:11 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8188eu: remove braces from single line if
 blocks
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210726092129.30334-1-straube.linux@gmail.com>
 <a4eb0dea-a34b-8dd9-03c6-aa0d87e68986@lwfinger.net>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <4c9c29c0-1cc8-d1fe-0057-3fcc28a9922b@gmail.com>
Date:   Mon, 26 Jul 2021 20:07:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <a4eb0dea-a34b-8dd9-03c6-aa0d87e68986@lwfinger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 26.07.21 um 17:09 schrieb Larry Finger:
> On 7/26/21 4:21 AM, Michael Straube wrote:
>> Remove braces from single line if blocks to clear checkpatch warnings.
>> WARNING: braces {} are not necessary for single statement blocks
>>
>> Signed-off-by: Michael Straube <straube.linux@gmail.com>
>> ---
>>   drivers/staging/rtl8188eu/core/rtw_cmd.c          | 3 +--
>>   drivers/staging/rtl8188eu/core/rtw_mlme.c         | 3 +--
>>   drivers/staging/rtl8188eu/core/rtw_xmit.c         | 3 +--
>>   drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c | 3 +--
>>   drivers/staging/rtl8188eu/hal/usb_halinit.c       | 6 ++----
>>   5 files changed, 6 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8188eu/core/rtw_cmd.c 
>> b/drivers/staging/rtl8188eu/core/rtw_cmd.c
>> index eb89a52aa4e3..56ece839c9ca 100644
>> --- a/drivers/staging/rtl8188eu/core/rtw_cmd.c
>> +++ b/drivers/staging/rtl8188eu/core/rtw_cmd.c
>> @@ -1159,9 +1159,8 @@ void rtw_createbss_cmd_callback(struct adapter 
>> *padapter, struct cmd_obj *pcmd)
>>           psta = rtw_get_stainfo(&padapter->stapriv, 
>> pnetwork->MacAddress);
>>           if (!psta) {
>>               psta = rtw_alloc_stainfo(&padapter->stapriv, 
>> pnetwork->MacAddress);
>> -            if (!psta) {
>> +            if (!psta)
>>                   goto createbss_cmd_fail;
>> -            }
>>           }
>>           rtw_indicate_connect(padapter);
>> diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c 
>> b/drivers/staging/rtl8188eu/core/rtw_mlme.c
>> index 71d205f3d73d..0d334aba9a3f 100644
>> --- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
>> +++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
>> @@ -953,9 +953,8 @@ void rtw_joinbss_event_prehandle(struct adapter 
>> *adapter, u8 *pbuf)
>>               }
>>               /* s4. indicate connect */
>> -            if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
>> +            if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
>>                   rtw_indicate_connect(adapter);
>> -            }
>>               /* s5. Cancel assoc_timer */
>>               del_timer_sync(&pmlmepriv->assoc_timer);
>> diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c 
>> b/drivers/staging/rtl8188eu/core/rtw_xmit.c
>> index d5fc59417ec6..c77ebd18f40c 100644
>> --- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
>> +++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
>> @@ -1124,9 +1124,8 @@ struct xmit_buf *rtw_alloc_xmitbuf(struct 
>> xmit_priv *pxmitpriv)
>>           list_del_init(&pxmitbuf->list);
>>           pxmitpriv->free_xmitbuf_cnt--;
>>           pxmitbuf->priv_data = NULL;
>> -        if (pxmitbuf->sctx) {
>> +        if (pxmitbuf->sctx)
>>               rtw_sctx_done_err(&pxmitbuf->sctx, 
>> RTW_SCTX_DONE_BUF_ALLOC);
>> -        }
>>       }
>>       spin_unlock_irqrestore(&pfree_xmitbuf_queue->lock, irql);
>> diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c 
>> b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
>> index 6cf87312bc36..a67615708745 100644
>> --- a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
>> +++ b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
>> @@ -510,7 +510,6 @@ void Hal_ReadThermalMeter_88E(struct adapter 
>> *Adapter, u8 *PROMContent, bool Aut
>>       else
>>           pHalData->EEPROMThermalMeter = EEPROM_Default_ThermalMeter_88E;
>> -    if (pHalData->EEPROMThermalMeter == 0xff || AutoloadFail) {
>> +    if (pHalData->EEPROMThermalMeter == 0xff || AutoloadFail)
>>           pHalData->EEPROMThermalMeter = EEPROM_Default_ThermalMeter_88E;
>> -    }
>>   }
>> diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c 
>> b/drivers/staging/rtl8188eu/hal/usb_halinit.c
>> index 1d7d5037ce89..3e8f7315d377 100644
>> --- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
>> +++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
>> @@ -641,9 +641,8 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
>>       }
>>       status = rtw_hal_power_on(Adapter);
>> -    if (status == _FAIL) {
>> +    if (status == _FAIL)
>>           goto exit;
>> -    }
>>       /*  Save target channel */
>>       haldata->CurrentChannel = 6;/* default set to 6 */
>> @@ -696,9 +695,8 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
>>       _InitTxBufferBoundary(Adapter, txpktbuf_bndy);
>>       status =  InitLLTTable(Adapter, txpktbuf_bndy);
>> -    if (status == _FAIL) {
>> +    if (status == _FAIL)
>>           goto exit;
>> -    }
>>       /*  Get Rx PHY status in order to report RSSI and others. */
>>       _InitDriverInfoSize(Adapter, DRVINFO_SZ);
>>
> 
> Michael,
> 
> You might as well stop looking at drivers/staging/rtl8188eu. There is a 
> pending patch that blows away that directory and replaces it with a new 
> version from the GitHub repo. The new one will be in 
> drivers/staging/r8188eu.
> 
> NACKed by Larry.Finger <Larry.Finger@lwfinger.net>
> 
> Larry
> 

Ah ok, thank you for the information.

Michael
