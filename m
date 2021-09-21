Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6871541315C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbhIUKNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:13:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58331 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231732AbhIUKNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632219124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S95vJaZvdW3Rjy/q5vksCypaVcKeTTH1YRRDd1/MExg=;
        b=Wt7rA4JNOpNRiQV4qNblHxTAFV57OJpUtefG3SVviBTFI5g5vjgVWudxMw1YfE4Nuj7W0j
        eXBlDh3g3thNfAinSQXe2zrgvYSJpeKdiAiRXwzUII0M3TvGQ7bEJr+XciAeTLhvxTH8SZ
        lDZ4mAQQHbR/1jeDkuOug1D2DXHjg24=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-53BWCF3HP2S7KwANYDcNlw-1; Tue, 21 Sep 2021 06:12:03 -0400
X-MC-Unique: 53BWCF3HP2S7KwANYDcNlw-1
Received: by mail-ed1-f70.google.com with SMTP id r11-20020aa7cfcb000000b003d4fbd652b9so18522431edy.14
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 03:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S95vJaZvdW3Rjy/q5vksCypaVcKeTTH1YRRDd1/MExg=;
        b=ZXkVsdQ14nfxGHhoRv7gPidxIxK4MQcTklF1yXVdCAF8htkvFGMwyPuosOcNYBeUT4
         sUdCQ8+JECoulKxzaLLdLYFXizeqTxi77DblTCIvGLcD1+19lcDEzBZttGHFNIUkTIp+
         6T1ePOf2TPua9dD8dgd4VoQ4s8tUqUonqgzqM3Zn2qSFLwDfmGZQftBYf99BoH/HIRnl
         YqpPCJgTHCOhqWjCMq/GnpAsm+EuzWJjfVO4WLlIjTjome4771esYHHBXnerkwxsit7B
         lyrXhol+vadaLi3mYKOz4pxi88cwid54iL6ZIyD7iGU2V7ZvZsTSaMpUIz6EuLw/8y4x
         Xm/g==
X-Gm-Message-State: AOAM533tyMD8364+xsUnZTAsnODr7ZNnJaxELffPCR2jrN2gs+ys0ifh
        +Wx5Y3BhmhGAh39aaLP+LnKRCwssspJ/BkjPtK3Xse9lPh/wPNgmZ7Iuwr26GcX/5TpfgN9OwCX
        a2YIxf+f/ZRThF575bctCJmYCJKCgXYNCkU5UdmvMu1w8+7bdJCgh2MnlG+2cAnNATal7h0PUrl
        B1
X-Received: by 2002:a17:906:dbcb:: with SMTP id yc11mr34196008ejb.111.1632219122347;
        Tue, 21 Sep 2021 03:12:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBmOme1WLErYjb1HfEY6REFZSXl8oa+SRi4rTgDIyk5BmHc61uXV754GCR7RK+lY04WFEtdQ==
X-Received: by 2002:a17:906:dbcb:: with SMTP id yc11mr34195977ejb.111.1632219122075;
        Tue, 21 Sep 2021 03:12:02 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id k4sm8154937edq.92.2021.09.21.03.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 03:12:01 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: lg-laptop: Fix possible NULL pointer
 derefence
To:     Arnd Bergmann <arnd@kernel.org>, Matan Ziv-Av <matan@svgalib.org>,
        Mark Gross <mgross@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210920095556.1175269-1-arnd@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <76bfc870-b229-c8b9-4458-62e239b7663b@redhat.com>
Date:   Tue, 21 Sep 2021 12:12:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210920095556.1175269-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 9/20/21 11:55 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_DMI is disabled, dmi_get_system_info() returns a NULL
> pointer, which is now caught by a warning:
> 
> In function 'strlen',
>     inlined from 'acpi_add.part.0' at drivers/platform/x86/lg-laptop.c:658:6:
> include/linux/fortify-string.h:25:33: error: argument 1 null where non-null expected [-Werror=nonnull]
>    25 | #define __underlying_strlen     __builtin_strlen
>       |                                 ^
> include/linux/fortify-string.h:60:24: note: in expansion of macro '__underlying_strlen'
>    60 |                 return __underlying_strlen(p);
>       |                        ^~~~~~~~~~~~~~~~~~~
> drivers/platform/x86/lg-laptop.c: In function 'acpi_add.part.0':
> include/linux/fortify-string.h:25:33: note: in a call to built-in function '__builtin_strlen'
>    25 | #define __underlying_strlen     __builtin_strlen
>       |                                 ^
> include/linux/fortify-string.h:60:24: note: in expansion of macro '__underlying_strlen'
>    60 |                 return __underlying_strlen(p);
>       |                        ^~~~~~~~~~~~~~~~~~~
> 
> The code in there does not appear essential, so an explicit
> NULL check should be sufficient. The string is also printed
> to the console, but printk() is able to handle NULL pointer
> arguments gracefully.
> 
> Fixes: 8983bfd58d61 ("platform/x86: lg-laptop: Support for battery charge limit on newer models")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thank you for the patch, but this is already fixed in the pdx86 fixes branch:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?h=fixes&id=4c4a3d7cffb42da21ea8891fc7e6808ae05dbcb5

Regards,

Hans


> ---
>  drivers/platform/x86/lg-laptop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
> index 3e520d5bca07..88b551caeaaf 100644
> --- a/drivers/platform/x86/lg-laptop.c
> +++ b/drivers/platform/x86/lg-laptop.c
> @@ -655,7 +655,7 @@ static int acpi_add(struct acpi_device *device)
>  		goto out_platform_registered;
>  	}
>  	product = dmi_get_system_info(DMI_PRODUCT_NAME);
> -	if (strlen(product) > 4)
> +	if (product && strlen(product) > 4)
>  		switch (product[4]) {
>  		case '5':
>  		case '6':
> 

