Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86063346961
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 20:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbhCWT4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 15:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37220 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231319AbhCWT4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 15:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616529380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8vRsMQ+sfRfDVRWc4E1WN8Yx9M3DrPO7l6jjTBCQXyA=;
        b=ObNNZTvg40ouSyWvBK2pCMoLSzg01iIPO2nx9wory2Z8LRb5P3Ypw56ZpbPpGGm0lTVG/d
        GSVkQlkVbvaulcjklF6fwgQl0KhF60DkJRhFaHpLb4OJoT1Ge8i5X5qYVzrUE1Soa24Tlw
        WE5+WhaCIvOSbyIQPInVSt709hESTtU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-Ylb8winSOS-tWylFNBDeGg-1; Tue, 23 Mar 2021 15:56:16 -0400
X-MC-Unique: Ylb8winSOS-tWylFNBDeGg-1
Received: by mail-ej1-f69.google.com with SMTP id gv58so1547398ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 12:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8vRsMQ+sfRfDVRWc4E1WN8Yx9M3DrPO7l6jjTBCQXyA=;
        b=dYRmZnkhhl6YUz2MWzMwi4boniRo95CeVebjPAKMYDF8KVx/eEX9dZ5sQfxztdeLWm
         5KcV1PuQZmNF6WRVMDScd1wiE4xR9ibVJ6jmijPoL+cqb0b9gy2wAi2l7ON3UwO1amOj
         Tw7GeXBA6xo4zUko6RAE/VSDHGSqXHwsBak9kw7mt/XKQSqlMle85TZFgkfePgz7V5wY
         syHYb9lXy7p1MZFc3+ZulACdEj9I8LdTKhZe+t/grqPSwAlS3HbVd7dsxTxDeh3FOI7U
         RjYWb0ephdqDBB5fyJbiUC8x+YHSVgBcIDW5Vakk6WsX8DUsj1pProNEtlZSz7YyZgDZ
         hDFg==
X-Gm-Message-State: AOAM5338Fyvifr9Xp7/jssPo0h+jv4lo02QmPz9uQQHu7uEDxlGVB1g+
        mjYvILFuYnCOBKecbrfkKHZ7DXgTXIdKb2BoTkyKPVyGHoi4vosw+YjTK9rbsCwmBPT+rOzYIqV
        asrpIyqUaqhNQ/WWyGeSlqoHhJRXSLw2Vz9qr+bINtlcrWat5IRHsRFAhrRix1/clEzNjEG/Xy2
        3z
X-Received: by 2002:a17:907:9709:: with SMTP id jg9mr6358715ejc.276.1616529374936;
        Tue, 23 Mar 2021 12:56:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5eSG03WTPXO6UbAZOOvNIUSID357ZEHF4QL9u4Y/vqiWyzai9kXrV9wEAPPNlJIdYpoWVVA==
X-Received: by 2002:a17:907:9709:: with SMTP id jg9mr6358692ejc.276.1616529374679;
        Tue, 23 Mar 2021 12:56:14 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id ga28sm7046278ejc.82.2021.03.23.12.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 12:56:14 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: asus-wmi: Disable fn-lock mode by default
To:     Luca Stefani <luca.stefani.ge1@gmail.com>
Cc:     chiu@endlessm.com, Corentin Chary <corentin.chary@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210316221747.90829-1-luca.stefani.ge1@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2b060044-1010-4c8c-571f-b037d96670bb@redhat.com>
Date:   Tue, 23 Mar 2021 20:56:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210316221747.90829-1-luca.stefani.ge1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/16/21 11:17 PM, Luca Stefani wrote:
> * On recent ZenBooks the fn-lock is disabled
>   by default on boot while running Windows.
> 
> * Follow the same paradigm also here.
> 
> Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>

This will be a behavioral change for many users where their F-keys will
now all of a sudden work different after boot under Linux then they
did before.

As such this seems like a bad idea, so I'm not going to merge this patch.

What might be an option is adding a module-option which allows users to
configure the default setting at boot that way, while keeping the current
default.

Regards,

Hans



> ---
>  drivers/platform/x86/asus-wmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 9ca15f724343..32319f7d6e17 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -2673,7 +2673,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>  		err = asus_wmi_set_devstate(ASUS_WMI_DEVID_BACKLIGHT, 2, NULL);
>  
>  	if (asus_wmi_has_fnlock_key(asus)) {
> -		asus->fnlock_locked = true;
> +		asus->fnlock_locked = false;
>  		asus_wmi_fnlock_update(asus);
>  	}
>  
> 

