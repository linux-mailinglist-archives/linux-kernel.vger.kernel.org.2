Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2DE3EE6F1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 09:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238270AbhHQHDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 03:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238112AbhHQHDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 03:03:02 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF533C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 00:02:29 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id i6so30177640edu.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 00:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UFmYgHQVoxPuJsPynH02ftjkrBh0tl5MvF/mFLmK8vY=;
        b=WMW9FNP9R3dolzpH193woafwzBLLaKspQXrMN+UCxK7fyWvdEeOEQ29MqyUy6U3FVd
         jiwao0ij2hZYf+uVcrBtrUtpIF7fSu7E0gGwNVHT8iejcrQexSePT59XNCyOVIrBQSKD
         FclKzIrcXMsA0O9q54F33d/m+6qJ7NL17o3UzWsTtjXlT2pc2CnOgaQhKgHj/btUH0SU
         a8ww2PU7fz99e0AVbZnhVhlSP27K9EZRZklm/fbmB9pztHnQ9tT9b9S9Np9Wd0TdFHwu
         ghSBFm5+rJhKrOWX6/wdKhluxeIUVicRbINcZhpGnDXE0E/+1Gma2EUSn3CQAL+6pcQD
         /7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UFmYgHQVoxPuJsPynH02ftjkrBh0tl5MvF/mFLmK8vY=;
        b=XBKt38OUDspwmQ+K7YxrDg1JMUl+zS+cXhIx9S72d71fs4z5HsguepxuSM+77LWtW9
         CP6jRE7duR3yAP1Dk514R7ppdf1NcbbMUlqzQM8fYNVUQ+ywd60WPpRfYAADnEhzEL+V
         agBO7llqSu2ta78Hh/48LrcfabjtFu6+L7371+6F9oN8KXcpn59IclppSxFcn7h2Cv+4
         R6+GYk4ZLegeVz7Atrp7cB5j3dU4K81KXU45zMFYFUKxWh1us4zZa/CSoWkBk0/NaZ8B
         P1b89HMB+7UT7F6+YVCeFcpEsC4LC4SKe9gSDjgYH2C4nUYMVd2VVpo5cQskFkkXmdQE
         Dffw==
X-Gm-Message-State: AOAM532oe0CNSMZTHL7PsDGIjGujkpJuQMQdSYJwZGaqZ9I0G0KuQPjE
        qrXr1RT516xR+kTjjOUxpQaMkgRYPRk=
X-Google-Smtp-Source: ABdhPJyyvtVN6v8ACSLA2KGbgoNOP+qQ0I2BmP0yw5MFg4DGt0KZ+a8e7aOoPneL+xKYzOrJxvuAfQ==
X-Received: by 2002:a05:6402:274d:: with SMTP id z13mr2472971edd.386.1629183748321;
        Tue, 17 Aug 2021 00:02:28 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::4058? ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id g14sm571343edr.47.2021.08.17.00.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 00:02:27 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] staging: r8188eu: remove set but unused variable
 from rtl8188e_Add_RateATid
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20210816234459.132239-1-phil@philpotter.co.uk>
 <20210816234459.132239-2-phil@philpotter.co.uk>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <4f02cbe9-ee5e-dcef-4b53-08baf5ad22ce@gmail.com>
Date:   Tue, 17 Aug 2021 09:01:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210816234459.132239-2-phil@philpotter.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/21 1:44 AM, Phillip Potter wrote:
> Remove set but unused variable init_rate from the rtl8188e_Add_RateATid
> function in hal/rtl8188eu_cmd.c, as this fixes a kernel test robot
> warning. Removing the call to get_highest_rate_idx has no side effects
> here so is safe.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>   drivers/staging/r8188eu/hal/rtl8188e_cmd.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
> index 6cbda9ab6e3f..4302054c6c83 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
> @@ -155,7 +155,7 @@ void rtl8188e_Add_RateATid(struct adapter *pAdapter, u32 bitmap, u8 arg, u8 rssi
>   {
>   	struct hal_data_8188e *haldata = GET_HAL_DATA(pAdapter);
>   
> -	u8 macid, init_rate, raid, shortGIrate = false;
> +	u8 macid, raid, shortGIrate = false;
>   
>   	macid = arg&0x1f;
>   
> @@ -167,13 +167,8 @@ void rtl8188e_Add_RateATid(struct adapter *pAdapter, u32 bitmap, u8 arg, u8 rssi
>   
>   	bitmap |= ((raid<<28)&0xf0000000);
>   
> -	init_rate = get_highest_rate_idx(bitmap&0x0fffffff)&0x3f;
> -
>   	shortGIrate = (arg&BIT(5)) ? true : false;
>   
> -	if (shortGIrate)
> -		init_rate |= BIT(6);
> -
>   	raid = (bitmap>>28) & 0x0f;
>   
>   	bitmap &= 0x0fffffff;
> 

Looks good to me.

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael
