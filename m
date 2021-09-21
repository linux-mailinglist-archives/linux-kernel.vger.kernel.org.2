Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93126413396
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 14:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbhIUMyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 08:54:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48505 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232667AbhIUMyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 08:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632228752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QT7c1hyCu5qlCGLm4lU550mRBx+ss6BkQeQEtVJJ7O4=;
        b=et91dBfNIqfYBIWlXjMt56qQ1oy0PW5wUhRjh52zP3FwSTUxgqeKe9SyWGxQnxBzjMjTC3
        MLDY635dSM6uzHHhunJ4uxtpIxokPTKIjqG5SIGT0HDTezOxrdoOvp/BwiKVU2rs5FpsnY
        TfuIIh0/vr/P3xFRAfz1GTrZQ7EZbb0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-Hl7mrXghM6yvUfj0ZRN3lg-1; Tue, 21 Sep 2021 08:52:31 -0400
X-MC-Unique: Hl7mrXghM6yvUfj0ZRN3lg-1
Received: by mail-ed1-f71.google.com with SMTP id m20-20020aa7c2d4000000b003d1add00b8aso18947590edp.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 05:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QT7c1hyCu5qlCGLm4lU550mRBx+ss6BkQeQEtVJJ7O4=;
        b=pWHcHhxoiH1AheJM5tHT8TCdFe39+90BDXJIiFDeVdBPOtzziyJtgNFJWsiawGjkTn
         budtS68M5Qofr1ypmm2p1wlFbzOKPjIU/wAC3BVvtbh373ORKtikQD+6l5v9j71OkDzp
         pAbprLv4irj57W+9/jJsD8RbhK2Rjo19+FM3W8K2ccmKKuxXYWkKi9JyfP6UD5t1Eglt
         3O2QAGdN9wgs/8fukKq4S7G9Hy2c5RkdmGXIFVAiie7ax1Vm+ADqZKENrC5p1TurnG90
         1XYfJdlS6Uu/uv83ns0n0+GUp5WK75tzz/9C7lItlIu9mFdHKUGfYGqAiNOrWKGt3Ajb
         z10w==
X-Gm-Message-State: AOAM532GYJ4hMKZKsvHcuHQ5HKFJUHcVhHI2G9lfv2U4dhsmSL3wmE9d
        FPbw0Zar/taHLBkvFL8yWArKuqCBAtdB+Gc3CbHH7+eYq2aoZ8BqUp7M2tNnZDlxEVdyYTzhxQr
        qdlj4s8QaoPD2g17+ZoqEfR4L
X-Received: by 2002:aa7:d850:: with SMTP id f16mr35080562eds.176.1632228750482;
        Tue, 21 Sep 2021 05:52:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpsuNi5Q+WZay0piknbslOd2NnlEfRhQpdmEoN5ZN/nyc2tFUMYba8wi0JfcdtHWs0a/242w==
X-Received: by 2002:aa7:d850:: with SMTP id f16mr35080550eds.176.1632228750354;
        Tue, 21 Sep 2021 05:52:30 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id f2sm7323114eje.109.2021.09.21.05.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 05:52:30 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: dell: fix DELL_WMI_PRIVACY dependencies &
 build error
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Perry Yuan <Perry.Yuan@dell.com>, Dell.Client.Kernel@dell.com,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <mgross@linux.intel.com>
References: <20210918044829.19222-1-rdunlap@infradead.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3cd39888-d0ec-f3b2-b696-8d1cf86a7684@redhat.com>
Date:   Tue, 21 Sep 2021 14:52:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210918044829.19222-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/18/21 6:48 AM, Randy Dunlap wrote:
> When DELL_WMI=y, DELL_WMI_PRIVACY=y, and LEDS_TRIGGER_AUDIO=m, there
> is a linker error since the LEDS trigger code is built as a loadable
> module. This happens because DELL_WMI_PRIVACY is a bool that depends
> on a tristate (LEDS_TRIGGER_AUDIO=m), which can be dangerous.
> 
> ld: drivers/platform/x86/dell/dell-wmi-privacy.o: in function `dell_privacy_wmi_probe':
> dell-wmi-privacy.c:(.text+0x3df): undefined reference to `ledtrig_audio_get'
> 
> Fixes: 8af9fa37b8a3 ("platform/x86: dell-privacy: Add support for Dell hardware privacy")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Perry Yuan <Perry.Yuan@dell.com>
> Cc: Dell.Client.Kernel@dell.com
> Cc: platform-driver-x86@vger.kernel.org
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <mgross@linux.intel.com>

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
>  drivers/platform/x86/dell/Kconfig |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- linux-next-20210917.orig/drivers/platform/x86/dell/Kconfig
> +++ linux-next-20210917/drivers/platform/x86/dell/Kconfig
> @@ -166,8 +166,7 @@ config DELL_WMI
>  
>  config DELL_WMI_PRIVACY
>  	bool "Dell WMI Hardware Privacy Support"
> -	depends on DELL_WMI
> -	depends on LEDS_TRIGGER_AUDIO
> +	depends on LEDS_TRIGGER_AUDIO = y || DELL_WMI = LEDS_TRIGGER_AUDIO
>  	help
>  	  This option adds integration with the "Dell Hardware Privacy"
>  	  feature of Dell laptops to the dell-wmi driver.
> 

