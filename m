Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444D440785C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 15:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbhIKNdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 09:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbhIKNdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 09:33:50 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A953C061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:32:38 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d6so6851038wrc.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oIzPjX/18gjtmjPtMT0Q5tMQbXEiRiTEAyoWi1fuT58=;
        b=FJ/zuTIRyMBgsWzpgu2Pmsrn8+j4yi0UKfWW+M+oaS4Zm8Jtummv7cvU/a0PxEI08O
         jnegvDSfBo3EpVrvugbbvFxeQxRGTq1bVEz04olod+/7NTdPq1yCrYn82FIMSjS0ixXn
         lNBu2UQbwiFvLoZEnBjZQ2aNPn0Ua6uB/QPMstDdbd9z+77/UsnxNqald/gp0K61Y8Fe
         PTYgfABtFhumF6W2GXpg+9dTGxdcXRwz3I0QZKxI+HIAPR1Uno24PWGSW4sg+PmhS1mG
         i8BWi7UuVUVp3IW9Pb69G4yL0clpwyOo5DtTaag7reYEBAG09NBxRvDIF+wye4ZJCl9W
         9uBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oIzPjX/18gjtmjPtMT0Q5tMQbXEiRiTEAyoWi1fuT58=;
        b=jjrfmW88VeRBpnaqRDVT6dAiNcbQoHxYvHbT6bc4ZmNbmkjEkAoBdBIma3sI5zYjuD
         eJxHAHWCNUxD5Wkn1jtLGohxncFKVjc/0VI85hzepyJBBzQ7oL7yRzpgrqqBikGZEuDd
         220tjVuZLrzPxGOzuPfFomwC8APFtEOfsK8sTna/eWaQKx87ePNHx65QBGhnebrvWpdw
         DRxmXcB15LKLntmFyhwCllfFf0A8pMPibDK50X6PUJ//tL1gEOybp+h1ceflkPLoaWV/
         ZBwAOiQ5Ogpn8Yqek4vOqlntpoxwliJChoVK73VVokvjsxQT94OtDmzh4MdMjAjf+r5D
         TVVQ==
X-Gm-Message-State: AOAM533n+8Wm8+O6YTyZT2tvTNAOaLsGSGdQh8uafwrq4E5QQtjO+Zf/
        TDTIO+qDJmlfFtULKedT9WJArqHBRSEJfw==
X-Google-Smtp-Source: ABdhPJz1/YTdbTgNvwRulv9+DRG3D/K2pPQt/4BI5LAdTCIfus0mhOAimpnEeZw8lLynhoOx4cfTKA==
X-Received: by 2002:adf:e4c5:: with SMTP id v5mr3111332wrm.1.1631367156840;
        Sat, 11 Sep 2021 06:32:36 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::ae40? ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id q201sm1717160wme.2.2021.09.11.06.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Sep 2021 06:32:36 -0700 (PDT)
Message-ID: <58796c32-5105-b3a3-fdeb-bf38e97ecd6b@gmail.com>
Date:   Sat, 11 Sep 2021 15:32:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH] staging: r8188eu: remove write-only variable
 bLCKInProgress
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210911132338.1415-1-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20210911132338.1415-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/21 15:23, Martin Kaiser wrote:
> bLCKInProgress in struct odm_rf_cal is never read. Remove it.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/hal/HalPhyRf_8188e.c | 4 ----
>   drivers/staging/r8188eu/include/odm.h        | 1 -
>   2 files changed, 5 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
> index 6e0abaf58791..d9693c8014ce 100644
> --- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
> +++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
> @@ -1212,16 +1212,12 @@ void PHY_LCCalibrate_8188E(struct adapter *adapt)
>   		timecount += 50;
>   	}
>   
> -	dm_odm->RFCalibrateInfo.bLCKInProgress = true;
> -
>   	if (dm_odm->RFType == ODM_2T2R) {
>   		phy_LCCalibrate_8188E(adapt, true);
>   	} else {
>   		/*  For 88C 1T1R */
>   		phy_LCCalibrate_8188E(adapt, false);
>   	}
> -
> -	dm_odm->RFCalibrateInfo.bLCKInProgress = false;
>   }
>   
>   static void phy_setrfpathswitch_8188e(struct adapter *adapt, bool main, bool is2t)
> diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
> index 7c8f082930dd..cda8b3ffe0be 100644
> --- a/drivers/staging/r8188eu/include/odm.h
> +++ b/drivers/staging/r8188eu/include/odm.h
> @@ -679,7 +679,6 @@ struct odm_rf_cal {
>   	u32	Reg864;
>   
>   	bool	bIQKInitialized;
> -	bool	bLCKInProgress;
>   	bool	bAntennaDetected;
>   	u32	ADDA_backup[IQK_ADDA_REG_NUM];
>   	u32	IQK_MAC_backup[IQK_MAC_REG_NUM];
> 

Compiles and looks good to me, thanks.

Acked-by: Michael Straube <straube.linux@gmail.com>
