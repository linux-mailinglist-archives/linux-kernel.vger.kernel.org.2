Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2633FC99D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbhHaOVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:21:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38008 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230135AbhHaOVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630419608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kuHdMLn18IKwwH4QQSWLOw+X0/FNLXCUYkqXo3AG1Jk=;
        b=GbowEyRVoAtR1J8FXUhpxEdeIgnxtW6eLhOSwnjdYJmYip/pkGpFYEZnrLr1jdThigX3Z2
        Ft0KtU+1j9W6/seZrnWSgp4sY8aa6S7FU/uVkGFCPd8j/sTkJNEnW2lh4r6NbI38WtaNZ4
        0GXNFarOroJe3Sh7jngo98NpmLxIDEo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-UUGUCBl-Pz6QehdmDmA8bA-1; Tue, 31 Aug 2021 10:20:06 -0400
X-MC-Unique: UUGUCBl-Pz6QehdmDmA8bA-1
Received: by mail-ej1-f72.google.com with SMTP id x21-20020a170906135500b005d8d4900c5eso687361ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kuHdMLn18IKwwH4QQSWLOw+X0/FNLXCUYkqXo3AG1Jk=;
        b=s/nIkx5rAuKn6J2meKRWIIVN7DKeDHRgk4CXFKj4VIArAzC9UPdbmEwDo4qaY2QjA3
         3pBnAyizfPo3MFsYvEMHmQ8aKXh+GgvmJ/qUQaGMclXeZwBrHRAc3VCCdT6aMPTitF4b
         hE5JsIfqgxurGLPY4C/x47EN7D1+isIUb3C+dwlLIKlFLavV41E+sLsRAzB2KUJh25ol
         G7NWKzYGFmKqanoywfBQvqXLJ82XmOlwDV9fsD2dLtUAjR2CUpRpH4yufAI1j3z2yZXn
         jlEo2dcjCALgfPS6RIDLXeEpQqNsGd1jQFW7Aa5bq8rUl4jcKMrR/F6aG2YXH0WgdH23
         Uktg==
X-Gm-Message-State: AOAM532uPtYjoq+vK3khcvc3T8PZ/apLcjF4P23QmYsdMHG1GHU3vkZA
        kVbKhgVnnPBOMc/2Ej5SqD3t8ArCfBtOmfUpuO/xQUIW3366BIkkIWxC6vQ3y12qU8MLuek3xmG
        2GVXfKbfaT0WmPJ5rK712icG8
X-Received: by 2002:a17:906:4482:: with SMTP id y2mr11838348ejo.484.1630419605674;
        Tue, 31 Aug 2021 07:20:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCxB/XR66pzE/FFXAseDZAL6q3C0BZpaBf1FpxaPmkMLrL2KcZjS2xPKREZptzzbalDzsEyA==
X-Received: by 2002:a17:906:4482:: with SMTP id y2mr11838314ejo.484.1630419605313;
        Tue, 31 Aug 2021 07:20:05 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id h7sm3392356edr.4.2021.08.31.07.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 07:20:04 -0700 (PDT)
Subject: Re: [PATCH regression fix] firmware/dmi: Move product_sku info to the
 end of the modalias
To:     Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>,
        Erwan Velu <e.velu@criteo.com>
References: <20210831130508.14511-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0a96f1de-c0a0-40ce-e4dc-0acacfa2c7a8@redhat.com>
Date:   Tue, 31 Aug 2021 16:20:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210831130508.14511-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/31/21 3:05 PM, Hans de Goede wrote:
> Commit e26f023e01ef ("firmware/dmi: Include product_sku info to modalias")
> added a new field to the modalias in the middle of the modalias, breaking
> some existing udev/hwdb matches on the whole modalias without a wildcard
> ('*') in between the pvr and rvn fields.
> 
> All modalias matches in e.g. :
> https://github.com/systemd/systemd/blob/main/hwdb.d/60-sensor.hwdb
> deliberately end in ':*' so that new fields can be added at *the end* of
> the modalias, but adding a new field in the middle like this breaks things.
> 
> Move the new sku field to the end of the modalias to fix some hwdb
> entries no longer matching.
> 
> The new sku field has already been put to use in 2 new hwdb entries:
> 
>  sensor:modalias:platform:HID-SENSOR-200073:dmi:*svnDell*:sku0A3E:*
>   ACCEL_LOCATION=base
> 
>  sensor:modalias:platform:HID-SENSOR-200073:dmi:*svnDell*:sku0B0B:*
>   ACCEL_LOCATION=base
> 
> The wildcard use before and after the sku in these matches means that they
> should keep working with the sku moved to the end.
> 
> Note that there is a second instance of in essence the same problem,
> commit f5152f4ded3c ("firmware/dmi: Report DMI Bios & EC firmware release")
> 
> Added 2 new br and efr fields in the middle of the modalias. This too
> breaks some hwdb modalias matches, but this has gone unnoticed for over
> a year. So some newer hwdb modalias matches actually depend on these
> fields being in the middle of the string. Moving these to the end now
> would break 3 hwdb entries, while fixing 8 entries.
> 
> Since there is no good answer for the new br and efr fields I have chosen
> to leave these as is. Instead I'll submit a hwdb update to put a wildcard
> at the place where these fields may or may not be present depending on the
> kernel version.

In case anyone is interested here is the systemd pull-req fixing this from
the hwdb side: https://github.com/systemd/systemd/pull/20599

Regards,

Hans



> BugLink: https://github.com/systemd/systemd/issues/20550
> Link: https://github.com/systemd/systemd/pull/20562
> Fixes: e26f023e01ef ("firmware/dmi: Include product_sku info to modalias")
> Cc: stable@vger.kernel.org
> Cc: Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
> Cc: Erwan Velu <e.velu@criteo.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/firmware/dmi-id.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/dmi-id.c b/drivers/firmware/dmi-id.c
> index 4d5421d14a41..940ddf916202 100644
> --- a/drivers/firmware/dmi-id.c
> +++ b/drivers/firmware/dmi-id.c
> @@ -73,6 +73,10 @@ static void ascii_filter(char *d, const char *s)
>  
>  static ssize_t get_modalias(char *buffer, size_t buffer_size)
>  {
> +	/*
> +	 * Note new fields need to be added at the end to keep compatibility
> +	 * with udev's hwdb which does matches on "`cat dmi/id/modalias`*".
> +	 */
>  	static const struct mafield {
>  		const char *prefix;
>  		int field;
> @@ -85,13 +89,13 @@ static ssize_t get_modalias(char *buffer, size_t buffer_size)
>  		{ "svn", DMI_SYS_VENDOR },
>  		{ "pn",  DMI_PRODUCT_NAME },
>  		{ "pvr", DMI_PRODUCT_VERSION },
> -		{ "sku", DMI_PRODUCT_SKU },
>  		{ "rvn", DMI_BOARD_VENDOR },
>  		{ "rn",  DMI_BOARD_NAME },
>  		{ "rvr", DMI_BOARD_VERSION },
>  		{ "cvn", DMI_CHASSIS_VENDOR },
>  		{ "ct",  DMI_CHASSIS_TYPE },
>  		{ "cvr", DMI_CHASSIS_VERSION },
> +		{ "sku", DMI_PRODUCT_SKU },
>  		{ NULL,  DMI_NONE }
>  	};
>  
> 

