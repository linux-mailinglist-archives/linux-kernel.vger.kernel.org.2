Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040A144D432
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 10:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhKKJmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 04:42:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49322 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229668AbhKKJmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 04:42:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636623586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8A9sVJufAuIdaNe7x8dJ0Ddp0v4f7DQdTfgFJT+P8vA=;
        b=Ac5KpheEBWzgXZvMYRpmuiiZaGmGWoyOV3B064t5FMjjwWH3GcHpbS4+3JjywnRXg1g5PO
        RGeZJlEIonlQ1aXzLtx1OfgXRx+S24gYtdMbM0LyZ/+a5n26tJv1T7RcM3kbhoUOwHlpd8
        dfSu5ubFi8iILLESRzq9ShfmQMg/OdE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-g3xCykVyO6yU1KMlQTaHcg-1; Thu, 11 Nov 2021 04:39:44 -0500
X-MC-Unique: g3xCykVyO6yU1KMlQTaHcg-1
Received: by mail-ed1-f69.google.com with SMTP id o15-20020a056402438f00b003e32b274b24so4889426edc.21
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 01:39:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8A9sVJufAuIdaNe7x8dJ0Ddp0v4f7DQdTfgFJT+P8vA=;
        b=aaKZv9DwqvUCn00lEGMQSsEAlBb3asYXuRJqrHsSUH+JYrhJC/EyhG91j12uJ6cAKA
         v2FCVfSYj5yphRYn/xADV/ZTugUkk0gA80a4acA6LTYvEzfVN8gdyeIDIPvg18ytY9Hf
         59Qp3jzCVah17dV2YBjHFH87szouGQMaFP3iI7EPqof69S8DvLEgJ26SETA+3ilznzLl
         IoihmI2/yzvyRJAlzm7OzGPD/M9LJvEuxnXMv15JiSEl7YBpR7+dsJ7X1kmK+HXiz9zZ
         GOM6VLntZFk1ylFySwJRAXafvf258gzgp2AAzb4/zTc9WlmPjur6VqyhHicOGN0krvzJ
         I+/g==
X-Gm-Message-State: AOAM530kJQr7791fOWGBv91HlDFyLycIb0oWzA+9CIjX19beR+rIL1bN
        Zvyi5PT7Du5QxyrrXLSZqlGM0/0SSwaJoxPMjFZT4VKBevTguCxML8S+qdf7ky2hdxkOfQzNBuv
        UmFLjzv0skIcMMtVcj6IRg3tX
X-Received: by 2002:a17:907:7ba2:: with SMTP id ne34mr7498520ejc.290.1636623583570;
        Thu, 11 Nov 2021 01:39:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyuoHa8hwpXCSBF0GN4WZXjPr6iZAzu10fiY2oFHBW8HB1yCMQctFLMeKmFp+uq/Y53CyZbWA==
X-Received: by 2002:a17:907:7ba2:: with SMTP id ne34mr7498494ejc.290.1636623583366;
        Thu, 11 Nov 2021 01:39:43 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id gb2sm1052259ejc.52.2021.11.11.01.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 01:39:43 -0800 (PST)
Message-ID: <fc9c3cb4-5d58-7ee6-7e8f-15a4ab77cd11@redhat.com>
Date:   Thu, 11 Nov 2021 10:39:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] platform/surface: surfacepro3_button: don't load on
 amd variant
Content-Language: en-US
To:     Sachi King <nakato@nakato.io>, Chen Yu <yu.c.chen@intel.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211109081125.41410-1-nakato@nakato.io>
 <20211109081125.41410-2-nakato@nakato.io>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211109081125.41410-2-nakato@nakato.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sachi,

On 11/9/21 09:11, Sachi King wrote:
> The AMD variant of the Surface Laptop report 0 for their OEM platform
> revision.  The Surface devices that require the surfacepro3_button
> driver do not have the _DSM that gets the OEM platform revision.  If the
> method does not exist, load surfacepro3_button.
> 
> Fixes: 64dd243d7356 ("platform/x86: surfacepro3_button: Fix device check")
> Co-developed-by: Maximilian Luz <luzmaximilian@gmail.com>
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> Signed-off-by: Sachi King <nakato@nakato.io>

Thank you for your patch.

I'm afraid that I do not entirely understand the problem and thus
I also cannot review this patch properly.

Can you please send a new version with a more complete commit message,
explaining things like:

1. On which models this driver currently loads
2. On which models where it loads it should not load
3. The presence / lack of the OEM platform revision _DSM and the
   returned value by the _DSM if present on each of the models on
   which this driver currently loads.

Also I'm wondering, since this is only used on a few
systems, if it would not be better to just use
a dmi_system_id table with a list of systems on which this
should actually load, and also use that list to set the
modalias (using MODULE_DEVICE_TABLE(dmi, ...) ?

That will avoid this module auto-loading at all on devices
where it is not necessary thus speeding up booting a bit
and also not wasting memory by having an unused module sit
in memory.

Note the driver can still bind by the ACPI ids, that is fine
you would just:

1. Add a DMI table + MODULE_DEVICE_TABLE(dmi, ...)
2. Add a DMI check to surface_button_check_MSHW0040()
3. Drop MODULE_DEVICE_TABLE(acpi, surface_button_device_ids);

And then presto, the module will not even load on devices
where it should not be used.

###

2 more requests related to this patch

1. If for the next version you stick with the _DSM presence check
   approach please also add some documentation inside the driver
   in the form of a more elaborate comment.

2. I see this is part of a series for the next version please
   Cc platform-driver-x86@vger.kernel.org for the entire series.

Regards,

Hans



> ---
>  drivers/platform/surface/surfacepro3_button.c | 30 ++++---------------
>  1 file changed, 6 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/platform/surface/surfacepro3_button.c b/drivers/platform/surface/surfacepro3_button.c
> index 242fb690dcaf..30eea54dbb47 100644
> --- a/drivers/platform/surface/surfacepro3_button.c
> +++ b/drivers/platform/surface/surfacepro3_button.c
> @@ -149,7 +149,8 @@ static int surface_button_resume(struct device *dev)
>  /*
>   * Surface Pro 4 and Surface Book 2 / Surface Pro 2017 use the same device
>   * ID (MSHW0040) for the power/volume buttons. Make sure this is the right
> - * device by checking for the _DSM method and OEM Platform Revision.
> + * device by checking for the _DSM method and OEM Platform Revision DSM
> + * function.
>   *
>   * Returns true if the driver should bind to this device, i.e. the device is
>   * either MSWH0028 (Pro 3) or MSHW0040 on a Pro 4 or Book 1.
> @@ -157,30 +158,11 @@ static int surface_button_resume(struct device *dev)
>  static bool surface_button_check_MSHW0040(struct acpi_device *dev)
>  {
>  	acpi_handle handle = dev->handle;
> -	union acpi_object *result;
> -	u64 oem_platform_rev = 0;	// valid revisions are nonzero
> -
> -	// get OEM platform revision
> -	result = acpi_evaluate_dsm_typed(handle, &MSHW0040_DSM_UUID,
> -					 MSHW0040_DSM_REVISION,
> -					 MSHW0040_DSM_GET_OMPR,
> -					 NULL, ACPI_TYPE_INTEGER);
> -
> -	/*
> -	 * If evaluating the _DSM fails, the method is not present. This means
> -	 * that we have either MSHW0028 or MSHW0040 on Pro 4 or Book 1, so we
> -	 * should use this driver. We use revision 0 indicating it is
> -	 * unavailable.
> -	 */
> -
> -	if (result) {
> -		oem_platform_rev = result->integer.value;
> -		ACPI_FREE(result);
> -	}
> -
> -	dev_dbg(&dev->dev, "OEM Platform Revision %llu\n", oem_platform_rev);
>  
> -	return oem_platform_rev == 0;
> +	// make sure that OEM platform revision DSM call does not exist
> +	return !acpi_check_dsm(handle, &MSHW0040_DSM_UUID,
> +			       MSHW0040_DSM_REVISION,
> +			       BIT(MSHW0040_DSM_GET_OMPR));
>  }
>  
>  
> 

