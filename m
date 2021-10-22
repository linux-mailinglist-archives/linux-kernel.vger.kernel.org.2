Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E23437495
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhJVJSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:18:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47792 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232580AbhJVJSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:18:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634894158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UQGDJah/KreCof6wR/rgfBuc6vkWJYHgPEBv9eX/JPc=;
        b=d1kwAftVlLQUzoNasjzT4JCiDV7LTR2SpM2RPIxBpSu+jMXYEjVUR6n1kkRwL3qiDOYFMW
        RC0iRW5vyfDYcjlIkr0y3lfwF242ulfpo5ASvqDatwhOIyFtFUO41loeAVTooYAU/InMNW
        bGi47YA8iS+i27R3UhJAYwzS/CANcwo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-gyuGcRQpMJigV3jEsxBj2g-1; Fri, 22 Oct 2021 05:15:56 -0400
X-MC-Unique: gyuGcRQpMJigV3jEsxBj2g-1
Received: by mail-ed1-f71.google.com with SMTP id v9-20020a50d849000000b003dcb31eabaaso3088054edj.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 02:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UQGDJah/KreCof6wR/rgfBuc6vkWJYHgPEBv9eX/JPc=;
        b=Dc/v3FFUumgp3de6imB8qW46H2hR1Eb1Q3TACk1KzH0a9qpfyzKR6qkSZ2ImJ6tlMq
         vPprUxCmIZD7/ETrtPeRAEkrjcJZeKFu3hroY1kgFHtBS3Ob80Z6uj1SDmwDiLMhzW2c
         79+1V897BZg3znHUiwuyZ/zIwahMvCzynQrmdOkyBUAdIlNr0KYj1m8DTUaV1YemX1Jm
         YBPQo0uAUn+wYXgMgbnDGiueQwnhYNooEcKxjyp+ijty2Wm5ijEaMsU92vrOKeOGLKSq
         nI4viciwEZRBXXiDfgjevjjIr7hvhlZSx6ISlk44CR6bJoEmC3Ybcacwy6ONXbNmNlwi
         jJiQ==
X-Gm-Message-State: AOAM533GR0L45j8Ty4vogLVG6sRl1kAkxO7+KQrqul64n+xSKhqtJWdr
        AHKMR/5JZL41sID+VxXU1kbuOBYXKR22crQhiy9w068nn9N41neGZmN/0/gG5L1eoAAA1sy9MFf
        wXkaC744Jjj96D2aSedFOks9l
X-Received: by 2002:a17:906:3842:: with SMTP id w2mr14414241ejc.28.1634894154922;
        Fri, 22 Oct 2021 02:15:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfQltY1u0ItXDgZL8i6ARy0Vt6IVTLGAMHyDBta8ooLrUu+EKZ/xwgXevj9QBKoe2HYJE57A==
X-Received: by 2002:a17:906:3842:: with SMTP id w2mr14414225ejc.28.1634894154746;
        Fri, 22 Oct 2021 02:15:54 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id mp5sm1775558ejc.68.2021.10.22.02.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 02:14:57 -0700 (PDT)
Message-ID: <39927c6d-8c55-5667-4aa0-31d746df90cc@redhat.com>
Date:   Fri, 22 Oct 2021 11:14:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] platform/x86: lg-laptop: replace snprintf in show
 functions with sysfs_emit
Content-Language: en-US
To:     cgel.zte@gmail.com, matan@svgalib.org
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Guojin <ye.guojin@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20211022090722.1065457-1-ye.guojin@zte.com.cn>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211022090722.1065457-1-ye.guojin@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/22/21 11:07, cgel.zte@gmail.com wrote:
> From: Ye Guojin <ye.guojin@zte.com.cn>
> 
> coccicheck complains about the use of snprintf() in sysfs show
> functions:
> WARNING  use scnprintf or sprintf
> 
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  drivers/platform/x86/lg-laptop.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
> index 7e9351c36389..ae9293024c77 100644
> --- a/drivers/platform/x86/lg-laptop.c
> +++ b/drivers/platform/x86/lg-laptop.c
> @@ -330,7 +330,7 @@ static ssize_t fan_mode_show(struct device *dev,
>  	status = r->integer.value & 0x01;
>  	kfree(r);
>  
> -	return snprintf(buffer, PAGE_SIZE, "%d\n", status);
> +	return sysfs_emit(buffer, "%d\n", status);
>  }
>  
>  static ssize_t usb_charge_store(struct device *dev,
> @@ -372,7 +372,7 @@ static ssize_t usb_charge_show(struct device *dev,
>  
>  	kfree(r);
>  
> -	return snprintf(buffer, PAGE_SIZE, "%d\n", status);
> +	return sysfs_emit(buffer, "%d\n", status);
>  }
>  
>  static ssize_t reader_mode_store(struct device *dev,
> @@ -414,7 +414,7 @@ static ssize_t reader_mode_show(struct device *dev,
>  
>  	kfree(r);
>  
> -	return snprintf(buffer, PAGE_SIZE, "%d\n", status);
> +	return sysfs_emit(buffer, "%d\n", status);
>  }
>  
>  static ssize_t fn_lock_store(struct device *dev,
> @@ -455,7 +455,7 @@ static ssize_t fn_lock_show(struct device *dev,
>  	status = !!r->buffer.pointer[0];
>  	kfree(r);
>  
> -	return snprintf(buffer, PAGE_SIZE, "%d\n", status);
> +	return sysfs_emit(buffer, "%d\n", status);
>  }
>  
>  static ssize_t battery_care_limit_store(struct device *dev,
> @@ -520,7 +520,7 @@ static ssize_t battery_care_limit_show(struct device *dev,
>  	if (status != 80 && status != 100)
>  		status = 0;
>  
> -	return snprintf(buffer, PAGE_SIZE, "%d\n", status);
> +	return sysfs_emit(buffer, "%d\n", status);
>  }
>  
>  static DEVICE_ATTR_RW(fan_mode);
> 

