Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A56E3EFCF9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 08:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238577AbhHRGl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 02:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238284AbhHRGlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 02:41:25 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB29C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 23:40:50 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gr13so2792683ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 23:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l0GE7O9lgTGJhOP7fE0g74eXRovQf9cW+0IjH4bHJbA=;
        b=ccWcM8AXjUhcSVmHYJXhvqv/LY8yZJeP49V8eVhiaYYp3prmRr4Y95buOjVap82Qnm
         Ly6ZW1FBf0cex2Uknwt1nNpJazOao86lWh/iMSAO2LceYoYavdjGGXBB4cj+tTuFXty2
         GSSVwgnz/15PEL1dZggfebasIgWhnAG7ntcuexwhKGkwivGIhvnaGFArI93dvY43DAvh
         +Q0gDfNOqGua+d7TXtN3UOOExUoOdeaEEHhJf3Y8Ba/TcDABxKttWzS4XMokdHapTUsN
         ISjIH5rQ/FWKpM91ujfZpAl5dFG2sMQYAPU/6yN/DgQapBelktPlgiHG6XXfzDT4Ey38
         n7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l0GE7O9lgTGJhOP7fE0g74eXRovQf9cW+0IjH4bHJbA=;
        b=Dpx5KBegVYqCZdFKbXFL82oowGxh0mqHW+08Cby8v1vUE7e+cLu0/qYCAzNLKtdlb/
         eB67srTmKcizZdtFoGEQr1gHTqKgLos9c1ouMYaNUv+nI+nSrXjtN1ebwLSF0KWv+j/Y
         mA31Zw85Hwz9HT0HMln6YPWA+ipABW3ohcbKHWfIb9wxTWhf4UzmpxgqEgn1+xZNPVVm
         AQQd+7crpVtuY4vz3qR3Z3u+90a1guA6g4tywKLcaPyN5Ur2FJ/iU4l2qqaUq0Ro0Zs6
         eszd+tEetUf4oMkneWnp3w8lAEfb9rUKTEnkAmuHKTwILGJDpgywvW33NwLsJjyYRVQa
         ucYQ==
X-Gm-Message-State: AOAM530nkRWhkaO/vyckzDpvUUFDGsbZePHgp5PzIXHXhZUsApB6gAN6
        SGWnB3NRmS1Oqnimj//Aq3/GI4AxStg=
X-Google-Smtp-Source: ABdhPJw0jFKRAtlaFluKfoZSoXIdCnCAw7WU6OmdSLXHsK9LCpQ+/d8H9b30W4RiTPTzt21up7tu1A==
X-Received: by 2002:a17:906:704e:: with SMTP id r14mr8141339ejj.293.1629268849643;
        Tue, 17 Aug 2021 23:40:49 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::687e? ([2a02:8108:96c0:3b88::687e])
        by smtp.gmail.com with ESMTPSA id c21sm2059686edv.27.2021.08.17.23.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 23:40:49 -0700 (PDT)
Subject: Re: [PATCH v3] staging: r8188eu: Remove unused including
 <linux/version.h>
To:     Cai Huoqing <caihuoqing@baidu.com>, dan.carpenter@oracle.com,
        greg@kroah.com, yangyingliang@huawei.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210818063653.2851-1-caihuoqing@baidu.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <ccfad7c8-35df-6ffb-4bc1-d45ee59ba0e7@gmail.com>
Date:   Wed, 18 Aug 2021 08:40:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210818063653.2851-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/21 8:36 AM, Cai Huoqing wrote:
> Remove including <linux/version.h> that don't need it
> 
> v1->v2: remove "based on staging-next" from commit message
> v2->v3: add changelog to commit message

You should put the v1->v2 lines below the --- line, so it
will not appear in the final commit message.

> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---

--> here

>   drivers/staging/r8188eu/core/rtw_mlme.c      | 1 -
>   drivers/staging/r8188eu/os_dep/os_intfs.c    | 1 -
>   drivers/staging/r8188eu/os_dep/rtw_android.c | 1 -
>   drivers/staging/r8188eu/os_dep/xmit_linux.c  | 1 -
>   4 files changed, 4 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
> index d5ef5783f4ad..82b74ebdaabd 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme.c
> @@ -3,7 +3,6 @@
>   
>   #define _RTW_MLME_C_
>   
> -#include <linux/version.h>
>   #include "../include/osdep_service.h"
>   #include "../include/drv_types.h"
>   #include "../include/recv_osdep.h"
> diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
> index f4bf4732578a..aef978eef4d7 100644
> --- a/drivers/staging/r8188eu/os_dep/os_intfs.c
> +++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
> @@ -12,7 +12,6 @@
>   
>   #include "../include/usb_osintf.h"
>   #include "../include/rtw_br_ext.h"
> -#include <linux/version.h>
>   
>   MODULE_LICENSE("GPL");
>   MODULE_DESCRIPTION("Realtek Wireless Lan Driver");
> diff --git a/drivers/staging/r8188eu/os_dep/rtw_android.c b/drivers/staging/r8188eu/os_dep/rtw_android.c
> index bdd381606ba6..af0072e2cb5f 100644
> --- a/drivers/staging/r8188eu/os_dep/rtw_android.c
> +++ b/drivers/staging/r8188eu/os_dep/rtw_android.c
> @@ -3,7 +3,6 @@
>   
>   #include <linux/module.h>
>   #include <linux/netdevice.h>
> -#include <linux/version.h>
>   #include "../include/rtw_android.h"
>   #include "../include/osdep_service.h"
>   #include "../include/rtw_debug.h"
> diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
> index 4f1ce346b3a5..69966c696130 100644
> --- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
> @@ -3,7 +3,6 @@
>   
>   #define _XMIT_OSDEP_C_
>   
> -#include <linux/version.h>
>   #include "../include/osdep_service.h"
>   #include "../include/drv_types.h"
>   #include "../include/if_ether.h"
> 

Thanks,
Michael
