Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99213FAB7A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 14:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbhH2MtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 08:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbhH2MtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 08:49:02 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E19C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 05:48:10 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id t19so24752765ejr.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 05:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fx2U/XtzQdPMmzz3ViClmHkgP7ZRkumubzXlcaMQAgc=;
        b=H7J+kJ0FaROaSAEynu14/HHVZ7CW4MZShaUQBSZW+7FzWI/CNBHzVd1d4LJS05zrT6
         QuJEJzHHbycc3CirYzrYyEIcJwA5oTcenjy+6lSvA8/X5LuLGiifCkJzQojiAuSIp+NC
         vUtR5o9YfDl4fU4U66GGLb8ukikmRFaSESPZaUhusSJWtYFQqJZ+NanVpb1bGrAjMaWt
         th/5+7jm3DxXGsrdkW5NOipxUWdbB/R7FM2QvecvM+QgUjArRWxMmCTGejJCNvZZOBFv
         d1/mfVDcf8M/UWr5R7uO2rAPvUI/IYIHaM0ya3P6q2GajyXOAG27CDIaMFifVoppyk53
         UZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fx2U/XtzQdPMmzz3ViClmHkgP7ZRkumubzXlcaMQAgc=;
        b=FSfZYBCgnM58QA80VZT+d9y5LBPxGHLJ5qK2srEvmXoDvzJEFQ/u/ev/Q5em36C1lE
         JDR8O6OXuv9TWlbaDYI/HEFGWGGBWye7vJiKX132BNmC+XyCdIQPpLchzEIMvPUmxvFG
         9wUWuc2JxHSTwqVzZHY7doJjg8AzEvyiEL4pwIXlU7x41+dQXy2Yu3wBMCKEF2aA8KIZ
         p13sLwMmIkICEMnP8uHUAPCIrX8M1H6dqEtYZ7ESD8lhDz+JwGK+qDG85Vp/x8KRs2y9
         XbgNAmxaUBMOcxaXxaSmw03zUMvIRPww16R9ibMpW4vUbd/4t+YGO295gMqY8PXhrH7s
         RqJA==
X-Gm-Message-State: AOAM5339GoVv5gc1XiZGItMHfTYe5M1R1HqJu2xTSsKaGi9ed3d2cpST
        hHvSw7nzn28IIP2al3QRMJm6bami++U1+w==
X-Google-Smtp-Source: ABdhPJyQXKQ2ht5+zMqKD0ywC/NdJXwdMwtgrwZPoAVAoOQhRvOxBQyX7Sk38fQnW9SmT48k3JjPBA==
X-Received: by 2002:a17:906:3ed2:: with SMTP id d18mr19158501ejj.311.1630241288257;
        Sun, 29 Aug 2021 05:48:08 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::16fa? ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with UTF8SMTPSA id i19sm6091154edx.54.2021.08.29.05.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Aug 2021 05:48:07 -0700 (PDT)
Message-ID: <67d0244b-03d8-7775-8384-88a25b17769e@gmail.com>
Date:   Sun, 29 Aug 2021 14:48:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH] staging: r8188eu: core: remove condition with no effect
Content-Language: en-US
To:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
References: <YStM2wxtkDAnRemt@user>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <YStM2wxtkDAnRemt@user>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/21 11:01, Saurav Girepunje wrote:
> Remove the condition with no effect (if == else) and group multiple
> cases which execute same statement in rtw_mlme_ext.c
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> index 5a472a4954b0..4178b3c1ff57 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> @@ -453,17 +453,8 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
>   		fallthrough;
>   	case WIFI_ASSOCREQ:
>   	case WIFI_REASSOCREQ:
> -		_mgt_dispatcher(padapter, ptable, precv_frame);
> -		break;
>   	case WIFI_PROBEREQ:
> -		if (check_fwstate(pmlmepriv, WIFI_AP_STATE))
> -			_mgt_dispatcher(padapter, ptable, precv_frame);
> -		else
> -			_mgt_dispatcher(padapter, ptable, precv_frame);
> -		break;
>   	case WIFI_BEACON:
> -		_mgt_dispatcher(padapter, ptable, precv_frame);
> -		break;
>   	case WIFI_ACTION:
>   		_mgt_dispatcher(padapter, ptable, precv_frame);
>   		break;
> --
> 2.32.0
> 

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael
