Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082A2356B0B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 13:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241613AbhDGLXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 07:23:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44243 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231138AbhDGLXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 07:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617794573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vi6mmAZvR34GygMPmuboiq8nvRacIFz1ApMzney+KHo=;
        b=Q2RGwKQcxl9ULb1f5Ejpm1kR/Xg9IVaDssHZQ15C65Obc3MOUr+6HH5Shj8Yk4FGy+1POr
        HRwnr7xJaoJQ9p5CIRv/YPEvc3vJz/6nXuWistloZYxMF6wQXPzfU2aFCA3ZScpPvqb4mm
        WupNO5e/soAtUu9GTa0tlWnLOjAleB8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-PvP9DU4hO0izYmmzg7BgXw-1; Wed, 07 Apr 2021 07:22:50 -0400
X-MC-Unique: PvP9DU4hO0izYmmzg7BgXw-1
Received: by mail-ed1-f71.google.com with SMTP id h9so4965296edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 04:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vi6mmAZvR34GygMPmuboiq8nvRacIFz1ApMzney+KHo=;
        b=r848E0zLUd/5u5BlF7qo+ZaHDyxn+x03IguEexhtTd38qbDEBlJ7+CWlh/FAdXSvm5
         yfFq1y2Ao94Xfm+uxaNA1Kz8eCgqCHmlOCcNw2seEe8GAi7B23QBCDK0DRa/r85NVBHk
         R9zRhcSS1UyzQaHsEGOaXCeZiACF+D+z6kVSAsdnXnqr0U6RWEZCmPku8gsIrc91QVVp
         krSQ/i1duvyY3UA7AL9GpqQeSkyWyFzFzyBKY8OynnQMT2cWSaeTCtO6LaDnQvqOaMOY
         blYBROh8J/3ZoFH9rxCBC5fcOJvSegD70kgUt9Vk25mHL5Dk9B6w/EWYQhM2foifLydc
         WMqQ==
X-Gm-Message-State: AOAM532h6xZnfP2ar9ZdA1G8XAUbQujJ+IDHZQo1HXrixBb1O2eJ/qHx
        RL6sJmPZdBdloSaPsF5VgJOHwbRMpnZaCSYa7zpGBCGiVocvCixodUup9io7Y1wX+ePzKn0qw7P
        J7rq1+EbS8vYgu1r7lsNTleln73uxDaPHYKDKMdqjLnwicwICBsIwu7eQjBfKfgQVXp1YuYteqx
        yD
X-Received: by 2002:aa7:dc0b:: with SMTP id b11mr3839934edu.124.1617794569102;
        Wed, 07 Apr 2021 04:22:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLRW5PlDd6Dkn0bNfGdzeKg0oo5GGmVEYz0R4lD0wLLioxKvGHcePkwg9NHRv9JzoisN2JKg==
X-Received: by 2002:aa7:dc0b:: with SMTP id b11mr3839910edu.124.1617794568897;
        Wed, 07 Apr 2021 04:22:48 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id jo12sm4465038ejb.52.2021.04.07.04.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 04:22:48 -0700 (PDT)
Subject: Re: [PATCH v3] platform/x86: asus-wmi: Add param to turn fn-lock mode
 on by default
To:     Luca Stefani <luca.stefani.ge1@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210323202505.141496-1-luca.stefani.ge1@gmail.com>
 <20210323210126.145286-1-luca.stefani.ge1@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4e816e9e-b35e-49ff-db91-82476fc4c9f7@redhat.com>
Date:   Wed, 7 Apr 2021 13:22:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210323210126.145286-1-luca.stefani.ge1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/23/21 10:01 PM, Luca Stefani wrote:
> * On recent ZenBooks the fn-lock is disabled
>   by default on boot while running Windows.
> 
> * Add a module param ( fnlock_default ) that allows
>   changing the default at probe time
> > Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>

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
>  drivers/platform/x86/asus-wmi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 9ca15f724343..ebaeb7bb80f5 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -47,6 +47,9 @@ MODULE_AUTHOR("Corentin Chary <corentin.chary@gmail.com>, "
>  MODULE_DESCRIPTION("Asus Generic WMI Driver");
>  MODULE_LICENSE("GPL");
>  
> +static bool fnlock_default = true;
> +module_param(fnlock_default, bool, 0444);
> +
>  #define to_asus_wmi_driver(pdrv)					\
>  	(container_of((pdrv), struct asus_wmi_driver, platform_driver))
>  
> @@ -2673,7 +2676,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>  		err = asus_wmi_set_devstate(ASUS_WMI_DEVID_BACKLIGHT, 2, NULL);
>  
>  	if (asus_wmi_has_fnlock_key(asus)) {
> -		asus->fnlock_locked = true;
> +		asus->fnlock_locked = fnlock_default;
>  		asus_wmi_fnlock_update(asus);
>  	}
>  
> 

