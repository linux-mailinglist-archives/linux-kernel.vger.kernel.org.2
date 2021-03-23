Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F535346A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 21:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbhCWU7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 16:59:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41556 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233442AbhCWU64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 16:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616533135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fQBO+u481DlzoGNQ69nNMTbn2tlelS5FZZUNirAyOj4=;
        b=DOgTD8OC5gCkdviLZVQi0pWB6lBJFt/Oz5RTxjLjzGwIdFSmlxJsiU9aO+dwTIYeRCbaLK
        RkK+oFs+9zfSg/ES3lA5Tqdj4C73w4QC1nb4CuGSXTcWu0u3fQILQ8TAcefdmdDyk1rmqS
        O6Y/qfLlWkkYOemHA0oeyOZPBszojnU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-Xti6Fwf6NWONVNX8RlEBOA-1; Tue, 23 Mar 2021 16:58:53 -0400
X-MC-Unique: Xti6Fwf6NWONVNX8RlEBOA-1
Received: by mail-ed1-f71.google.com with SMTP id f9so1562063edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 13:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fQBO+u481DlzoGNQ69nNMTbn2tlelS5FZZUNirAyOj4=;
        b=LUYB7pl4I4kczsT4IQ8eWbfA+ACFu61S43jZSpheeIEa9upx7Lnwotyqpoos1TWWuL
         znqUBOlTr47lutbUWltiUfp6HHmB1bp1X+7RKOu4iIIgj3iiQm2urQiYlCga3VTS4CaX
         JgsdlkEVilIGs/dlrkILz0v7bEQA5mSA0BHuPxKEdSqgMiJSIlqHza+Hf8za4HRKoQer
         uzMtCSNtpI51SP8ozHwzGi/qbeR3noU1JKeaT/p2WFaJAS47vHk+iI9pg7F6R49JIpP7
         ED1AFnkC9h5d9DPNZaaYXI6mNdSLSFwL4bYtqT+S++qo11kh/TnOG4bmv/GhfGn4nAUc
         2uOw==
X-Gm-Message-State: AOAM531yhf1acqJuqtS4xLF1VqAoUMkibccqPE9bjegeXCaxwhql5spH
        EwATC3fiuxuRs9qngBCjLkZw6nFR+30slMyqEeC0JDx3alDNqBRlIecJloaZmFNqB50q/OtUxWC
        DOXx1tC9nbRtd+Ab1XCB0XFT2bXBHiwr+I8+02Pj7ji9ZujLnqxQiA52EoFrURrlolcVi6+Bb5Q
        rf
X-Received: by 2002:a05:6402:375:: with SMTP id s21mr6390702edw.287.1616533131684;
        Tue, 23 Mar 2021 13:58:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKsqe20kZE+DFpcsbQKUpdRPl2U5AN4NySfbhaqdMoaLK+U8RZaTHXlZLNRxug8MwfPPGMwg==
X-Received: by 2002:a05:6402:375:: with SMTP id s21mr6390693edw.287.1616533131537;
        Tue, 23 Mar 2021 13:58:51 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id v25sm73057edr.18.2021.03.23.13.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 13:58:51 -0700 (PDT)
Subject: Re: [PATCH v2] platform/x86: asus-wmi: Add param to turn fn-lock mode
 on by default
To:     Luca Stefani <luca.stefani.ge1@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210323202505.141496-1-luca.stefani.ge1@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <097b8aff-70f4-bd0f-e561-60a773b3231c@redhat.com>
Date:   Tue, 23 Mar 2021 21:58:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210323202505.141496-1-luca.stefani.ge1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/23/21 9:25 PM, Luca Stefani wrote:
> * On recent ZenBooks the fn-lock is disabled
>   by default on boot while running Windows.
> 
> * Add a module param ( fnlock_default ) that allows
>   changing the default at probe time
> 
> Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
> ---
>  drivers/platform/x86/asus-wmi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 9ca15f724343..f3ed72f01462 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -47,6 +47,9 @@ MODULE_AUTHOR("Corentin Chary <corentin.chary@gmail.com>, "
>  MODULE_DESCRIPTION("Asus Generic WMI Driver");
>  MODULE_LICENSE("GPL");
>  
> +static bool fnlock_default = false;

The initial value of this needs to be true, so that there is no behavioral
change when people upgrade from a kernel without this to one with it.

And then people who want a different behavior can get that by setting
the module option.

Regards,

Hans


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

