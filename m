Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95019410753
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 17:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239806AbhIRPWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 11:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbhIRPWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 11:22:13 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23FCC061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 08:20:49 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id z2so543438wmc.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 08:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RAL2EFHw8vm039txkZHoI1GfYY5SI4ZiEGZRtsk4UEM=;
        b=XsIBIJ089DbWSwamDZWQnAifk3SM8eRpvE6bpwp3LlHsUC5FxspTdEAOdHqyN2gzVB
         Xx8DdG2VQPaAcpiU7gN8NzUiI4V8X+XpZR7WJitjwF9tIXQleQTxopxwn9eY7Z8zfvTb
         EEjgCJp1JdzdALDl1Cx0Mk27X4SLuMrl8qTl/zBVO98qfFvQ8rYSr2D+W75AJbHSjevD
         2yDxxlB5kXkHZzGQqmPUlCJij8QVrC8kkwwogXHu7ZPmHWNpwcMxAISvEP6hY5F4hqam
         38R7M5kkfXV9kQ5WCbIVSrcP6sQBfB63NcqbmMW8JlX1n7T3aOJGw6kcqI+KBG7wCe2t
         FuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RAL2EFHw8vm039txkZHoI1GfYY5SI4ZiEGZRtsk4UEM=;
        b=5GS0YRXH8fjtWvCFVtoWEn5Ji1jHl4t1onOnO1El8XzYnlZUV43TA97dzluOpyKfHp
         I4ppKyr10dHteE8pqCeVXqVMcSRUENsclEkieCcLONVUWX6suyHfPiFU6/veuFiOGfjT
         OUbLZGn9og2imnNtH5vUv0bPQLpOx8I8jpsY7O1UhOjnf19461WwXMjLTgYXlWAU0K9v
         NJMOx1FjRoqyOvHFiouADAaQdvZerp8ITw1Vw5/SgFzV8tHl9gTPzloBaMoCIK3tUGeh
         woV6Z3QGuLLNCGfw83J/6BB/5jgfubD1Y937ioLg2EPzTxqSKPjObQpB4mwwHM93HC2n
         Yatg==
X-Gm-Message-State: AOAM530IBbIWlfO4a0AUKZvbvG5kSBTWLFhme0GlfvMP8vFQs+rKy1Z8
        oj5cnIsmtF5Bz8D0cdfDGwk=
X-Google-Smtp-Source: ABdhPJyDN8R5DvAc+BBpCIk+uOmbHJwBH4HgfU/0Fk1o4gl4PNDFI427to644HdNMfXgkEMJ2hAjlg==
X-Received: by 2002:a1c:7e87:: with SMTP id z129mr7606008wmc.75.1631978448377;
        Sat, 18 Sep 2021 08:20:48 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::cde? ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id h8sm13391021wmb.35.2021.09.18.08.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Sep 2021 08:20:48 -0700 (PDT)
Message-ID: <9eb9d781-8603-4e0d-ecc3-4bd7e4808c0b@gmail.com>
Date:   Sat, 18 Sep 2021 17:20:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] staging: r8188eu: remove the HW_VAR_CHECK_TXBUF "hal
 variable"
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210918141034.28481-1-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20210918141034.28481-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/21 16:10, Martin Kaiser wrote:
> Setting HW_VAR_CHECK_TXBUF is an empty operation.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c | 1 -
>   drivers/staging/r8188eu/hal/usb_halinit.c   | 2 --
>   drivers/staging/r8188eu/include/hal_intf.h  | 1 -
>   3 files changed, 4 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> index 26e14e91a42c..38ab1ab18872 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> @@ -7785,7 +7785,6 @@ u8 sitesurvey_cmd_hdl(struct adapter *padapter, u8 *pbuf)
>   
>   	if (pmlmeext->sitesurvey_res.state == SCAN_DISABLE) {
>   		/* for first time sitesurvey_cmd */
> -		rtw_hal_set_hwreg(padapter, HW_VAR_CHECK_TXBUF, NULL);
>   
>   		pmlmeext->sitesurvey_res.state = SCAN_START;
>   		pmlmeext->sitesurvey_res.bss_cnt = 0;
> diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
> index 5133d533674f..8bb2466d71a2 100644
> --- a/drivers/staging/r8188eu/hal/usb_halinit.c
> +++ b/drivers/staging/r8188eu/hal/usb_halinit.c
> @@ -1813,8 +1813,6 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
>   			}
>   		}
>   		break;
> -	case HW_VAR_CHECK_TXBUF:
> -		break;
>   	case HW_VAR_APFM_ON_MAC:
>   		haldata->bMacPwrCtrlOn = *val;
>   		DBG_88E("%s: bMacPwrCtrlOn=%d\n", __func__, haldata->bMacPwrCtrlOn);
> diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
> index cc8db98cd200..f1ebb6a2395d 100644
> --- a/drivers/staging/r8188eu/include/hal_intf.h
> +++ b/drivers/staging/r8188eu/include/hal_intf.h
> @@ -84,7 +84,6 @@ enum hw_variables {
>   	HW_VAR_EFUSE_BT_USAGE,
>   	HW_VAR_EFUSE_BT_BYTES,
>   	HW_VAR_FIFO_CLEARN_UP,
> -	HW_VAR_CHECK_TXBUF,
>   	HW_VAR_APFM_ON_MAC, /* Auto FSM to Turn On, include clock, isolation,
>   			     * power control for MAC only */
>   	/*  The valid upper nav range for the HW updating, if the true value is
> 

Looks good to me.

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael
