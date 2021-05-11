Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0CA37A5B2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 13:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhEKLZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 07:25:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24200 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231300AbhEKLZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 07:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620732289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TvbaFwSYYjAUZTuPvSvQYf9X6DDDELP5dsVq9R9ADSA=;
        b=Uc+SFfpKfU8IWUe0seJcSN7gz7Vu1t4R3/0SyTM6cJTITE06/hh9xr2hmH1rpxQtWL0q1j
        FHEaahlfC+jmZnR80f7DpUoUQZWwkrhf12meT0ubNuA/f0RaUfoRJp/0gA1Llwn66za2d+
        j5dUt/NxFpSIQ1QaWvS5gLs8GkLfZfI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-hZaKharNPgGmlPkUo9UcXw-1; Tue, 11 May 2021 07:24:47 -0400
X-MC-Unique: hZaKharNPgGmlPkUo9UcXw-1
Received: by mail-ej1-f70.google.com with SMTP id z6-20020a17090665c6b02903700252d1ccso5800044ejn.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 04:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TvbaFwSYYjAUZTuPvSvQYf9X6DDDELP5dsVq9R9ADSA=;
        b=mr05HrVGwEShXFmDsM8Q5EXO6A7n0Qj2Ascn5FtewKvW6GF0g7hBEDMaS84YuCUQxD
         pjoKfzY5xwZwgj+eLawPNTKd5bQsRIZDMtPcS0NNvUUjbM/1vPGoPGFqNFxjTNifZ01H
         I/GW7Jsz2w0OwO6jKhXJlsMoOpMDOT/WCf1cglNipctwDVUeyJ7D1hidi9MV6DgTTUFJ
         VUsfY3jhZ1vccMBlSME3KJB0FSXJr6UNEZuDlZ+mNDhBrsJgpv7l91KaDH+O6AdVtMUF
         8EmFxGuZvsS/CknMHHUbzYiNI7SU7WqJFeaqc55WQqoc/wJ4qIRPaT/iHfS39o9QzNA8
         owpg==
X-Gm-Message-State: AOAM532Xj0izLyuHPLEn+FiPJ2McJYi87Z3yGpWNt/88n0F0G708mvbn
        /8WRbl1ie98fjvavWMe4hgzN3IZiDtFtMMqGeabtTWU78FY4ojIcSmtvv/O/mSqQp9VufOEUlEZ
        WvUQSkxSfJAK0o9VUlobfruNqzJcFWdbLcGMHkaRie45uIiL/Bvyn0YydbeJPgjFQbhNiGLHkZI
        jU
X-Received: by 2002:a17:906:31c6:: with SMTP id f6mr31225927ejf.446.1620732286327;
        Tue, 11 May 2021 04:24:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1TQf/s1Q7sU8IJi4M+JmIcbvmOHrm3Yd5jf/InM7qe9/jdUFemtPRnJFtxoEFmUFtFFhySw==
X-Received: by 2002:a17:906:31c6:: with SMTP id f6mr31225905ejf.446.1620732286089;
        Tue, 11 May 2021 04:24:46 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id ch30sm14234648edb.92.2021.05.11.04.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 04:24:45 -0700 (PDT)
Subject: Re: [PATCH] ACPI: scan: Rearrange dep_unmet initialization
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <2607573.mvXUDI8C0e@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <44ec7350-38ee-b880-bcaf-fba5ddc288e9@redhat.com>
Date:   Tue, 11 May 2021 13:24:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2607573.mvXUDI8C0e@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 5/10/21 7:53 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The dep_unmet field in struct acpi_device is used to store the
> number of unresolved _DEP dependencies (that is, operation region
> dependencies for which there are no drivers present) for the ACPI
> device object represented by it.
> 
> That field is initialized to 1 for all ACPI device objects in
> acpi_add_single_object(), via acpi_init_device_object(), so as to
> avoid evaluating _STA prematurely for battery device objects in
> acpi_scan_init_status(), and it is "fixed up" in acpi_bus_check_add()
> after the acpi_add_single_object() called by it has returned.
> 
> This is not particularly straightforward and causes dep_unmet to
> remain 1 for device objects without dependencies created by invoking
> acpi_add_single_object() directly, outside acpi_bus_check_add().
> 
> For this reason, rearrange acpi_add_single_object() to initialize
> dep_unmet completely before calling acpi_scan_init_status(), which
> requires passing one extra bool argument to it, and update all of
> its callers accordingly.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks, one small nitpick below.

> ---
>  drivers/acpi/scan.c |   62 +++++++++++++++++++++++++---------------------------
>  1 file changed, 30 insertions(+), 32 deletions(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -1670,8 +1670,22 @@ void acpi_init_device_object(struct acpi
>  	device_initialize(&device->dev);
>  	dev_set_uevent_suppress(&device->dev, true);
>  	acpi_init_coherency(device);
> -	/* Assume there are unmet deps to start with. */
> -	device->dep_unmet = 1;
> +}
> +
> +static void acpi_scan_dep_init(struct acpi_device *adev)
> +{
> +	struct acpi_dep_data *dep;
> +
> +	adev->dep_unmet = 0;

Now that we don't set dep_unmet to 1 in acpi_init_device_object()
anymore this line is no longer necessary.

dep_unmet is set to 0 by the kzalloc of the adev and we are already
relying on that in the case where the dep_init parameter to
acpi_add_single_object() is false.

But if you want to keep this that is fine too, either way
this patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans








> +
> +	mutex_lock(&acpi_dep_list_lock);
> +
> +	list_for_each_entry(dep, &acpi_dep_list, node) {
> +		if (dep->consumer == adev->handle)
> +			adev->dep_unmet++;
> +	}
> +
> +	mutex_unlock(&acpi_dep_list_lock);
>  }
>  
>  void acpi_device_add_finalize(struct acpi_device *device)
> @@ -1687,7 +1701,7 @@ static void acpi_scan_init_status(struct
>  }
>  
>  static int acpi_add_single_object(struct acpi_device **child,
> -				  acpi_handle handle, int type)
> +				  acpi_handle handle, int type, bool dep_init)
>  {
>  	struct acpi_device *device;
>  	int result;
> @@ -1702,8 +1716,12 @@ static int acpi_add_single_object(struct
>  	 * acpi_bus_get_status() and use its quirk handling.  Note that
>  	 * this must be done before the get power-/wakeup_dev-flags calls.
>  	 */
> -	if (type == ACPI_BUS_TYPE_DEVICE || type == ACPI_BUS_TYPE_PROCESSOR)
> +	if (type == ACPI_BUS_TYPE_DEVICE || type == ACPI_BUS_TYPE_PROCESSOR) {
> +		if (dep_init)
> +			acpi_scan_dep_init(device);
> +
>  		acpi_scan_init_status(device);
> +	}
>  
>  	acpi_bus_get_power_flags(device);
>  	acpi_bus_get_wakeup_device_flags(device);
> @@ -1885,22 +1903,6 @@ static u32 acpi_scan_check_dep(acpi_hand
>  	return count;
>  }
>  
> -static void acpi_scan_dep_init(struct acpi_device *adev)
> -{
> -	struct acpi_dep_data *dep;
> -
> -	adev->dep_unmet = 0;
> -
> -	mutex_lock(&acpi_dep_list_lock);
> -
> -	list_for_each_entry(dep, &acpi_dep_list, node) {
> -		if (dep->consumer == adev->handle)
> -			adev->dep_unmet++;
> -	}
> -
> -	mutex_unlock(&acpi_dep_list_lock);
> -}
> -
>  static bool acpi_bus_scan_second_pass;
>  
>  static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
> @@ -1948,19 +1950,15 @@ static acpi_status acpi_bus_check_add(ac
>  		return AE_OK;
>  	}
>  
> -	acpi_add_single_object(&device, handle, type);
> -	if (!device)
> -		return AE_CTRL_DEPTH;
> -
> -	acpi_scan_init_hotplug(device);
>  	/*
>  	 * If check_dep is true at this point, the device has no dependencies,
>  	 * or the creation of the device object would have been postponed above.
>  	 */
> -	if (check_dep)
> -		device->dep_unmet = 0;
> -	else
> -		acpi_scan_dep_init(device);
> +	acpi_add_single_object(&device, handle, type, !check_dep);
> +	if (!device)
> +		return AE_CTRL_DEPTH;
> +
> +	acpi_scan_init_hotplug(device);
>  
>  out:
>  	if (!*adev_p)
> @@ -2222,7 +2220,7 @@ int acpi_bus_register_early_device(int t
>  	struct acpi_device *device = NULL;
>  	int result;
>  
> -	result = acpi_add_single_object(&device, NULL, type);
> +	result = acpi_add_single_object(&device, NULL, type, false);
>  	if (result)
>  		return result;
>  
> @@ -2242,7 +2240,7 @@ static int acpi_bus_scan_fixed(void)
>  		struct acpi_device *device = NULL;
>  
>  		result = acpi_add_single_object(&device, NULL,
> -						ACPI_BUS_TYPE_POWER_BUTTON);
> +						ACPI_BUS_TYPE_POWER_BUTTON, false);
>  		if (result)
>  			return result;
>  
> @@ -2258,7 +2256,7 @@ static int acpi_bus_scan_fixed(void)
>  		struct acpi_device *device = NULL;
>  
>  		result = acpi_add_single_object(&device, NULL,
> -						ACPI_BUS_TYPE_SLEEP_BUTTON);
> +						ACPI_BUS_TYPE_SLEEP_BUTTON, false);
>  		if (result)
>  			return result;
>  
> 
> 
> 

