Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658683F011D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 11:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhHRJ6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 05:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbhHRJ61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 05:58:27 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0D4C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 02:57:53 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id qk33so3754012ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 02:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cOrU+6OcE97uL6ouGjWh0x6thEo5SKV/Sco0r/RwJFI=;
        b=d1t5xwP5b/qjhfYN7HTvkxsnltgZi9S/CAqn+ye7pz/aqd/Ez713er+ABELcRJjSVB
         EVPwXK3wLaHN5LMusCTKMeYb9Mug1C3+SQ0aw4Iji+C7d9pJaIv0qT9bJXuKbrOwHAMJ
         IhPGzhW+LsphGGus+Uav/YbCni1G8P34e9w1kCnujJcvIPwiP6JR+JmyLPyJ4gEZYHox
         qDeivCKW54Oe2vWjvXmUaN6Jlx213XVQXYujDTBaN84uY8tYhWSLUjm+9URcdpQSpQQl
         4NB3me7WWZew85P0gKOQ0qGrTLGXFX2HfMb7I0zibnH1t6MX1p5Bt3SyABqiKxu38imp
         Q/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cOrU+6OcE97uL6ouGjWh0x6thEo5SKV/Sco0r/RwJFI=;
        b=qYKZJRoFBVlOnTZ2Mia1MhKZ5BoP6+8Gi7I7UEUDOXjjWc6/mnfJIE9ETlOC3LhQyo
         Ud33tgOyEzi5EP3W40SNoB3tqtUtXpAaq73s3nZK69aNnzXGpxUuByhTmFqkcu14NxPn
         mTENQ7OPGbs1CMy9J2cJHpA35p++UWZSickG3TqD5HdpAmfPsVdRod6pkTz9kZUJT8vf
         9wQzSAD2QzL0ziIGtLaggkyfpY2uz1pLgb+0tYVW9/0pdje+AEAc5BouUYFoqCHD22v6
         HlQXbUwcqt4aSB3ihxTtG7vqI2hZu8X1Ep7GDdb88qlDR+BhTnd8cvGrG5XrE09bMQ1q
         v6hA==
X-Gm-Message-State: AOAM532Gmrafelcwxs9eVs9ZTkU9IG7rNIvsqNvjpm29EVOWxDGglV9o
        o9PwyfbJM1Ay1K6Bd+TWCn4xCBKH0YY=
X-Google-Smtp-Source: ABdhPJw9vrTdd9brdlKky3LZ0QUj1iq2VaVLZ7IO5nQZ5fqttDA+mqfcaZ78SV6h/BHbTbf4ttiaDA==
X-Received: by 2002:a17:907:f86:: with SMTP id kb6mr9076647ejc.138.1629280671747;
        Wed, 18 Aug 2021 02:57:51 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::687e? ([2a02:8108:96c0:3b88::687e])
        by smtp.gmail.com with ESMTPSA id h13sm1817031ejq.77.2021.08.18.02.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 02:57:51 -0700 (PDT)
Subject: Re: [PATCH v4] staging: r8188eu: Remove unused including
 <linux/version.h>
To:     Cai Huoqing <caihuoqing@baidu.com>, dan.carpenter@oracle.com,
        greg@kroah.com, yangyingliang@huawei.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210818095331.3422-1-caihuoqing@baidu.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <b66cf51b-b363-53d7-48be-dec524f3c8ac@gmail.com>
Date:   Wed, 18 Aug 2021 11:57:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210818095331.3422-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/21 11:53 AM, Cai Huoqing wrote:
> Remove including <linux/version.h> that don't need it
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
> v1->v2: remove "based on staging-next" from commit message
> v2->v3: add changelog to commit message
> v3->v4: move the modified change under the --- line
> 
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

Looks good to me now.

Acked-by: Michael Straube <straube.linux@gmail.com>


Thanks,

Michael
