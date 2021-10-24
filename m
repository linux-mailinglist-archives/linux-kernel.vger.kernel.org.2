Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189A8438750
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 10:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhJXIWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 04:22:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38963 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231172AbhJXIWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 04:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635063584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iEA+bOsDY0+9yg7R/acNp9qvWIVajgO8oDCJI28qcNg=;
        b=Lkfzny+wD1AfQqXGAvUKreA+pEWmb3drBkbgc7U8Y0WoaUR08m/o7R/gouCzVqnrvj0AQv
        vD2k+oNmGGuHIPcVipW79UfR96hgjXtVGoFLXCGFsQ079CBp1MpvDmS78i1a8dmfZpyy7r
        C0nemIRG7K24LAYLY1MEqnZVL+FZ6a4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-5DifLekNPJOQ7azQgZb1dw-1; Sun, 24 Oct 2021 04:19:43 -0400
X-MC-Unique: 5DifLekNPJOQ7azQgZb1dw-1
Received: by mail-ed1-f72.google.com with SMTP id s18-20020a056402521200b003dd5902f4f3so235344edd.23
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 01:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iEA+bOsDY0+9yg7R/acNp9qvWIVajgO8oDCJI28qcNg=;
        b=MkZofwZzpiQz2CHBG//cCvNVlNBzYiPmL3LjQv4sKY4mlpjNDSqJHz9UCdjbc4oi9g
         6Y2bF9tQ1IGQsVMr/7FKk4vn6ftQxPqyS8XqbmKUb92Zl3MeSf8dv8IH7JaTIs1SxEWQ
         MAFDUd1u1DngXo+NcPzAwCS0f5LrnuA9RYvqHvZtDmNsDsnRdJ1PR55pNQ39VUvNVdgx
         IKUCUNzN9JX0qSUXJI5C+apHiHBMwCaj2JaGY9dLXc6jeiVu7E0yJX+Kd/CgHvaYJUSY
         qx4KBdVVzk7/l8TAEYeBQZDT+sQJ4zX1YQMg5Zs05ILBFwNjDviR5TBoPNvu9qDImDI6
         2sTA==
X-Gm-Message-State: AOAM530IpHOH3TxLUiy6/IdyIjjh/yOifuqBUieotbV8w5lFmxAjNkNY
        pWpu4Tt/+z0Yfje/bGwo8zmk+c/IXpD8JB/tM1Go8DP31pJUun2cI/lYGzbnCa+JgRufguC9Wkl
        swUg6o2trmsiDpMo5uySiFT4n
X-Received: by 2002:aa7:c952:: with SMTP id h18mr16344382edt.18.1635063581667;
        Sun, 24 Oct 2021 01:19:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5rtFBpYqxF0K9CIYe+eHutxNObi8ukisQuZC6nx0OFjTu3p+Z581qSKvqb5oWD+F57MrVvA==
X-Received: by 2002:aa7:c952:: with SMTP id h18mr16344365edt.18.1635063581499;
        Sun, 24 Oct 2021 01:19:41 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id y22sm7607114edc.76.2021.10.24.01.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Oct 2021 01:19:41 -0700 (PDT)
Message-ID: <f52acae3-42b8-72e5-84dd-68eb41ff0efa@redhat.com>
Date:   Sun, 24 Oct 2021 10:19:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] platform/x86: system76_acpi: fix Kconfig dependencies
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Mark Gross <markgross@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Tim Crawford <tcrawford@system76.com>,
        Jeremy Soller <jeremy@system76.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20211022154901.904984-1-arnd@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211022154901.904984-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/22/21 17:48, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_INPUT is disabled, this driver now fails to link:
> 
> ld.lld: error: undefined symbol: devm_input_allocate_device
>>>> referenced by system76_acpi.c
>>>>               platform/x86/system76_acpi.o:(system76_add) in archive drivers/built-in.a
> 
> ld.lld: error: undefined symbol: input_set_capability
>>>> referenced by system76_acpi.c
>>>>               platform/x86/system76_acpi.o:(system76_add) in archive drivers/built-in.a
> 
> ld.lld: error: undefined symbol: devm_hwmon_device_register_with_info
>>>> referenced by system76_acpi.c
>>>>               platform/x86/system76_acpi.o:(system76_add) in archive drivers/built-in.a
> 
> ld.lld: error: undefined symbol: battery_hook_unregister
>>>> referenced by system76_acpi.c
>>>>               platform/x86/system76_acpi.o:(system76_remove) in archive drivers/built-in.a
> 
> Add Kconfig dependencies for each of these three.
> 
> Fixes: 0de30fc684b3 ("platform/x86: system76_acpi: Replace Fn+F2 function for OLED models")
> Fixes: 95563d45b5da ("platform/x86: system76_acpi: Report temperature and fan speed")
> Fixes: 76f7eba3e0a2 ("platform/x86: system76_acpi: Add battery charging thresholds")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

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
>  drivers/platform/x86/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 56bcf80da60a..c422ee785c56 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -923,6 +923,9 @@ config SONYPI_COMPAT
>  config SYSTEM76_ACPI
>  	tristate "System76 ACPI Driver"
>  	depends on ACPI
> +	depends on ACPI_BATTERY
> +	depends on HWMON
> +	depends on INPUT
>  	select NEW_LEDS
>  	select LEDS_CLASS
>  	select LEDS_TRIGGERS
> 

