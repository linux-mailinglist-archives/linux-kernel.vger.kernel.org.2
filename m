Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078F044EC53
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 19:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbhKLSCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 13:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbhKLSCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 13:02:44 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630D5C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 09:59:53 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id i9so9759027ilu.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 09:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BKRCO+sPNEEvYF+1R9ZCLe7wHn/hQy/BNfRiIf8HXr0=;
        b=GoKcKMv9WzfvYS0Gew9fuFsDLEY6puVfcM5rtRtMyEwCbG97SBJnBI+escCTKozSx0
         2ju/DBJG40QSQ6GDknJJIQmzhdkRAZLFM7FfZlgxdWkG5r9odxrTCPak1lW8WRndPzKg
         wu9TKgjVYwD+MHCQKsXsJNqW5VeJJen0i4vIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BKRCO+sPNEEvYF+1R9ZCLe7wHn/hQy/BNfRiIf8HXr0=;
        b=e7Gql3SQVg5loWxU1RgFKJaZiCjP6c8pknf/rNV2sBLT/Vb80nU5aXrw8kmE9NQkdD
         30fX2g2A2RfEHtTvRk+oxYRyX3FyBznKqJ72ZO8SPD0Vo/6pqxmsGOiF7apamCVJZmHl
         tV8PfXRvCpLvz7yq+QyRsySdsTx2E2H+zM6gpIT5oe7y1606esppfE6W28BM9ARurRLY
         +qJqDHkdCFZpEbKNjIIw8kTlZZ/JOGDqDhBnzQfLNLP+qy/UU1omYTZgUU/v9Iacyco5
         5/3+2iICdG/0J2GxXxaxudJh0bmtbMhrw4AsQcCKJkVnKVvHf01jQsOpk5UuwJg3g1ua
         DuPg==
X-Gm-Message-State: AOAM533AX76y/Dgi1l8amsIEWVZSo2fY7R7ng/Tq1Bb+6Ke+ZQJqw/hH
        sVCNSFADuXETkE5bNOmtWshQhQ==
X-Google-Smtp-Source: ABdhPJyXxSU0LADwgxOeny7WaJv1uZzTRo7eRIlVFxQmIhvZQTdL2wSuZhZVjwaaWpmYucKl459Ihg==
X-Received: by 2002:a05:6e02:17c8:: with SMTP id z8mr10397843ilu.19.1636739992866;
        Fri, 12 Nov 2021 09:59:52 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f3sm4104897ilq.13.2021.11.12.09.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 09:59:52 -0800 (PST)
Subject: Re: [PATCH] usb: Remove redundant 'flush_workqueue()' calls
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        peter.chen@kernel.org, gregkh@linuxfoundation.org,
        balbi@kernel.org, valentina.manea.m@gmail.com, shuah@kernel.org,
        johan@kernel.org, zhengyongjun3@huawei.com, colin.king@intel.com,
        trix@redhat.com, Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <563123a8117d6cafae3f134e497587bd2b8bb7f4.1636734453.git.christophe.jaillet@wanadoo.fr>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7b37c4b8-1bfa-2367-a6ad-6b40f5523934@linuxfoundation.org>
Date:   Fri, 12 Nov 2021 10:59:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <563123a8117d6cafae3f134e497587bd2b8bb7f4.1636734453.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/21 9:30 AM, Christophe JAILLET wrote:
> 'destroy_workqueue()' already drains the queue before destroying it, so
> there is no need to flush it explicitly.
> 
> Remove the redundant 'flush_workqueue()' calls.
> 
> This was generated with coccinelle:
> 
> @@
> expression E;
> @@
> - 	flush_workqueue(E);
> 	destroy_workqueue(E);
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/usb/chipidea/otg.c           | 5 ++---
>   drivers/usb/gadget/udc/mv_udc_core.c | 4 +---
>   drivers/usb/host/u132-hcd.c          | 1 -
>   drivers/usb/phy/phy-mv-usb.c         | 5 +----
>   drivers/usb/usbip/usbip_event.c      | 1 -
>   5 files changed, 4 insertions(+), 12 deletions(-)
> 

> diff --git a/drivers/usb/usbip/usbip_event.c b/drivers/usb/usbip/usbip_event.c
> index 086ca76dd053..26513540bcdb 100644
> --- a/drivers/usb/usbip/usbip_event.c
> +++ b/drivers/usb/usbip/usbip_event.c
> @@ -137,7 +137,6 @@ int usbip_init_eh(void)
>   
>   void usbip_finish_eh(void)
>   {
> -	flush_workqueue(usbip_queue);
>   	destroy_workqueue(usbip_queue);
>   	usbip_queue = NULL;
>   }
> 

Might be better to generate per driver patches.

Looks good to me. For the usbip change in this patch:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
