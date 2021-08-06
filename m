Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471E43E2B86
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 15:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344138AbhHFNif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 09:38:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31732 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344121AbhHFNid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 09:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628257097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fYa8CRqasptaxs6yBt32BGt8NUuLhgiXe4Y6xRunAnw=;
        b=HEa0YZ953YMtddG/VbucmoFKw2HnHXJ2XzEzfxUdqKP6aEg4JHgbBAAw/EOGVgHunCrIuz
        WWwb+aDbh847V+12Wlo9Z4mWlLvZLxpA4vuXxbI5z7oZGbthzeZNOHmwcnxtIVePiLpR3w
        pmiQzD+GA0pMYo4AXuLc325aS0B3qWQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-OZ5gqisxMci3x-B4Zh7gEA-1; Fri, 06 Aug 2021 09:38:14 -0400
X-MC-Unique: OZ5gqisxMci3x-B4Zh7gEA-1
Received: by mail-ej1-f71.google.com with SMTP id nb40-20020a1709071ca8b02905992266c319so3091050ejc.21
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 06:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fYa8CRqasptaxs6yBt32BGt8NUuLhgiXe4Y6xRunAnw=;
        b=RkoBlNgEzp2OV73XuagXrXEmC/6pe1LwVu3YXx2QE6FrftEQsxgbNnE5Xptq/vWy9g
         Qy1BiqoZWHO3WVJugENZ4DkbFD0TP/Y3vx9YIGx7k0k5Ck5ZNzh+P4ZEnZ+ZC0Mvwt40
         Yppky5v6FMiTJcKk6Cu62v/q4k9wM/92VsEc1RFlXDGZ0GOJp3vPaTnJNmakuReDsaCn
         QiifJ36BhduW4zLPAYj/+L7Nqy4zU4E+Io0MYW9yWzER0cs7/cIb5bq2eKMO9mHxipEf
         TA12G5BPJU1LD5/I4QKmWv07lOyHr5hwaFuSnmCzfSBRJRJ/X6qgz+fq/0ApvIi/f0p8
         TcHw==
X-Gm-Message-State: AOAM533g3Dr/yErjBhIrZqIfiKaDNktfVtqNW9ZZfN7hXKhhQzwAJpnx
        jA9jJqEazh54xQ/BIjvekSfRnz2wmke+EGMHvN/WCh4YYy5u36qZZqzyRPZ5aPvSHg9WRJlU6hs
        YD4rVVqT4Ct0p9mSCxpFl/ZxY
X-Received: by 2002:aa7:c042:: with SMTP id k2mr13334958edo.104.1628257093439;
        Fri, 06 Aug 2021 06:38:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZn/rzGnyhcNYCt1sjBcqqMA7zco7p97DVv+8sA09OIOtnDGJqNrEGDKYG57+uhfsgiO3NTQ==
X-Received: by 2002:aa7:c042:: with SMTP id k2mr13334947edo.104.1628257093340;
        Fri, 06 Aug 2021 06:38:13 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id e7sm3959181edk.3.2021.08.06.06.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 06:38:13 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] platform/surface: surface3_power: Use
 i2c_acpi_get_i2c_resource() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>
References: <20210803163252.60141-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <69085eb2-7695-4998-dfb0-75e644d76131@redhat.com>
Date:   Fri, 6 Aug 2021 15:38:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210803163252.60141-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/3/21 6:32 PM, Andy Shevchenko wrote:
> ACPI provides a generic helper to get I²C Serial Bus resources.
> Use it instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

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
>  drivers/platform/surface/surface3_power.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/surface/surface3_power.c b/drivers/platform/surface/surface3_power.c
> index dea82aa1abd4..90c1568ea4e0 100644
> --- a/drivers/platform/surface/surface3_power.c
> +++ b/drivers/platform/surface/surface3_power.c
> @@ -384,13 +384,7 @@ mshw0011_space_handler(u32 function, acpi_physical_address command,
>  	if (ACPI_FAILURE(ret))
>  		return ret;
>  
> -	if (!value64 || ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS) {
> -		ret = AE_BAD_PARAMETER;
> -		goto err;
> -	}
> -
> -	sb = &ares->data.i2c_serial_bus;
> -	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_I2C) {
> +	if (!value64 || !i2c_acpi_get_i2c_resource(ares, &sb)) {
>  		ret = AE_BAD_PARAMETER;
>  		goto err;
>  	}
> 

