Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92B5436A96
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 20:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhJUSf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 14:35:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28467 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230020AbhJUSfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 14:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634841211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fJv7bUttzHzeUKPod/KfL06tCpY98UdeXt9wFfAbFRI=;
        b=gK/ETO2gn8zJxxm0zWQmTE0/rQZzo1GTnjBoZz1J71Jp6WqJtB4z5KNE5BjKSZwAEuhZuC
        EBk/cp9vN94VcOLiFXTp9YprWNZwe29gnt31Mtoj80cPSv9b9+hzCLMUR7FbL33Idud5AG
        AXNtzy4ojMLOcv7vN6gssrKZDBe32/Y=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-7x4Y1bVgMRORsRYT0Jrz2w-1; Thu, 21 Oct 2021 14:33:28 -0400
X-MC-Unique: 7x4Y1bVgMRORsRYT0Jrz2w-1
Received: by mail-ed1-f69.google.com with SMTP id h19-20020aa7de13000000b003db6ad5245bso1272301edv.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 11:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fJv7bUttzHzeUKPod/KfL06tCpY98UdeXt9wFfAbFRI=;
        b=3TW7a0Z3IQdHqSR/r08NTmGH/HGVgmkHl3HwkBChQF87SjAKXgoExZZDH5V6iLnd71
         CSiA1qD/iP7XYx7G8YqTqpHAnEkkF6Cx0jK9X1/u2qIPNjhGuBRj+9mRwagc2X5veMBa
         XbhMuGdDwm/Mp1AZH8Kwyhy322iVnf+PRw1bFbAGK1fyBKBgo1gh3zeDcrfk4YlvLPnQ
         fIBfuko8o4DD2fx07Ps4JYz3ft0E1RMTDqmx505Y3+F/wqVVzoVMK3gswiq1Hpv0BEhQ
         PfExRMzmeAWGVTWNBuxootwiQybDwByIbcJSALqN0E5QKqa20rpY7LtUATPN6PuKFFSe
         vQyw==
X-Gm-Message-State: AOAM530vMVztJEALl7/s1Dycxd2y9F21xRSlL2chJuRVqfupm577OdB/
        rVOjZg8TPmpYNRTcmO4AG89v6SOPyK9+i7HcoZ0pLaBb7unlgwxJK76kUrOdkqnLetlm89R8gPM
        S2goYwFQ2jb5wsr24l78Lz5Es
X-Received: by 2002:a50:9b06:: with SMTP id o6mr10029319edi.284.1634841207331;
        Thu, 21 Oct 2021 11:33:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpP27IAl5diPSXUSRyhAfup3C5V1r5HFXZJeAuZaSNfUHqMNSsodhp5yV84qCICK121UKCwQ==
X-Received: by 2002:a50:9b06:: with SMTP id o6mr10029296edi.284.1634841207182;
        Thu, 21 Oct 2021 11:33:27 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id n6sm3137103eds.10.2021.10.21.11.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 11:33:26 -0700 (PDT)
Message-ID: <db6b4b82-01e6-d211-e8e9-5e3db6943bd7@redhat.com>
Date:   Thu, 21 Oct 2021 20:33:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] platform/surface: gpe: Add support for Surface Laptop
 Studio
Content-Language: en-US
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211021111053.564133-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211021111053.564133-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/21/21 13:10, Maximilian Luz wrote:
> The new Surface Laptop Studio uses GPEs for lid events as well. Add an
> entry for that so that the lid can be used to wake the device.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

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
>  drivers/platform/surface/surface_gpe.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/platform/surface/surface_gpe.c b/drivers/platform/surface/surface_gpe.c
> index 86f6991b1215..c1775db29efb 100644
> --- a/drivers/platform/surface/surface_gpe.c
> +++ b/drivers/platform/surface/surface_gpe.c
> @@ -26,6 +26,11 @@ static const struct property_entry lid_device_props_l17[] = {
>  	{},
>  };
>  
> +static const struct property_entry lid_device_props_l4B[] = {
> +	PROPERTY_ENTRY_U32("gpe", 0x4B),
> +	{},
> +};
> +
>  static const struct property_entry lid_device_props_l4D[] = {
>  	PROPERTY_ENTRY_U32("gpe", 0x4D),
>  	{},
> @@ -158,6 +163,14 @@ static const struct dmi_system_id dmi_lid_device_table[] = {
>  		},
>  		.driver_data = (void *)lid_device_props_l4D,
>  	},
> +	{
> +		.ident = "Surface Laptop Studio",
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Surface Laptop Studio"),
> +		},
> +		.driver_data = (void *)lid_device_props_l4B,
> +	},
>  	{ }
>  };
>  
> 

