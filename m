Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B64344793A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 05:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237386AbhKHESJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 23:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbhKHERz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 23:17:55 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F38FC061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 20:15:11 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id q126so10071520pgq.13
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 20:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0vTb2Eh26EDQpQcNXEmLn0oGcTGvpNGAV1iupzbirMM=;
        b=b7D2TToafJTPLm0i63Nn6QpKsrHmIbUzDnzU1fD92pSo3LOwtwXKUwZSrjsBqBCv/O
         TPaxhtp/XBjQpIl+0xzjzvDM9dZLu0MTUUk3sqMdpH+Y3CtLKjSRhHPPZdAd13RMvD4b
         d7azvHwMg7DLMzI6nBC2uQO0dIRezB+FODr+Umc+reQPp+L9iaC/njLKB/NiraDcWOOe
         eTTlEx8kG8SFY1U2BQ9wOH3Zksc+ud9gLSLum/uyQ4SW6xEGzGwT1ltqexc2WjvkdlDP
         BjYyOZ3oHv42EzQTdHeO128VA48Yo1XSsjbnTmQj+UehqsBODpSKSH0oCPjlaKkA56Cf
         k35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0vTb2Eh26EDQpQcNXEmLn0oGcTGvpNGAV1iupzbirMM=;
        b=sOKOqJMWIpJF5BJWx+XCwe7hnom2Sig/Vb4oLgfb/zEVqEwBhWqzIJe8uUdsg8DslB
         nJ0sz6FMo0UIKsym8ACPNanktoCfBQr6IyELfSS3UoVgay+trrcaTql5yTaUYvFKMhni
         pVfQCalo0VXkssoWOgW8eK3YbCeJw5kY4yq82CEXCKBt3t+SjQMIKoNH/hnu7Qug/5TM
         V2OEcrbmJFZOIkrgV/cc4l0ZxEWTQTnYGHySusLbUYqfbB3syIb9oVZyjtWxJo5r3U3u
         D6qYx1dWKccdin3t+JgupwWiA+vdsEeWpaFQVd+wR8OW2qZKFSnjc3nDayB2yKMeTZkv
         UUmQ==
X-Gm-Message-State: AOAM533deZq2zkjFcm4fHhcF6mHRbrpofdS6YlZKx8XC23+dhAE3Xu7X
        W4GI0pIgFYNe2QPJW6VnTls=
X-Google-Smtp-Source: ABdhPJyPWcaTTgqdCleaOpm+cehsHuGg/TzMXEj+bFjeOv2cr0G86yWMVT6bGW4mYgN1FAC9oXbYlA==
X-Received: by 2002:a63:8742:: with SMTP id i63mr43016950pge.282.1636344910874;
        Sun, 07 Nov 2021 20:15:10 -0800 (PST)
Received: from [192.168.1.2] ([59.88.109.27])
        by smtp.gmail.com with ESMTPSA id y32sm14997687pfa.145.2021.11.07.20.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Nov 2021 20:15:10 -0800 (PST)
Message-ID: <24befb64-0fdc-03ab-5a9a-c7be443be1a1@gmail.com>
Date:   Mon, 8 Nov 2021 09:45:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH] staging: rtl8192u: remove the if condition without effect
Content-Language: en-GB
To:     gregkh@linuxfoundation.org, kuba@kernel.org, lee.jones@linaro.org,
        nathan@kernel.org, clrrm@isep.ipp.pt, johan@kernel.org,
        dinghao.liu@zju.edu.cn, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
References: <YYijapuGOmObwM3S@Sauravs-MacBook-Air.local>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
In-Reply-To: <YYijapuGOmObwM3S@Sauravs-MacBook-Air.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/11/21 9:41 am, Saurav Girepunje wrote:
> In function rtl8192_adapter_start priv->pFirmware->firmware_status
> is assign to FW_STATUS_0_INIT just after assignment variable is
> again get check for same value. Therefore if condition will be
> always be true. So remove the if condition ,else if section and
> else section which will never get execute.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>  drivers/staging/rtl8192u/r8192U_core.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
> index 726d7ad9408b..f5d9e81f4ac7 100644
> --- a/drivers/staging/rtl8192u/r8192U_core.c
> +++ b/drivers/staging/rtl8192u/r8192U_core.c
> @@ -2666,14 +2666,7 @@ static bool rtl8192_adapter_start(struct net_device *dev)
>  	/* config CPUReset Register */
>  	/* Firmware Reset or not? */
>  	read_nic_dword(dev, CPU_GEN, &dwRegRead);
> -	if (priv->pFirmware->firmware_status == FW_STATUS_0_INIT)
> -		dwRegRead |= CPU_GEN_SYSTEM_RESET; /* do nothing here? */
> -	else if (priv->pFirmware->firmware_status == FW_STATUS_5_READY)
> -		dwRegRead |= CPU_GEN_FIRMWARE_RESET;
> -	else
> -		RT_TRACE(COMP_ERR,
> -			 "ERROR in %s(): undefined firmware state(%d)\n",
> -			 __func__,   priv->pFirmware->firmware_status);
> +	dwRegRead |= CPU_GEN_SYSTEM_RESET; /* do nothing here? */
> 
>  	write_nic_dword(dev, CPU_GEN, dwRegRead);
>  	/* config BB. */
> --
> 2.33.0
> 

read_nic_dword function call also does not update value of priv->pFirmware->firmware_status.
read_nic_dword return a value that never check by any caller function.
That can cover on another patch.

Regards,
Saurav
