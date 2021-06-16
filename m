Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676EB3AA2DA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 20:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhFPSHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 14:07:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46497 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231479AbhFPSHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 14:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623866702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4xT1saQU128AxyzVuss1zrmEdIxNhp6j1Em1jnlU658=;
        b=ckoyEPw89qzroxGPeJ9+AgmHW+pD0nsZVLPO2Y0X/Vr4K2Cn3Aou9Hpj0Qb4n+G9OPtb/C
        Dgm51MYDmMLvJ3/zZ2dpKqyuVxxynEj4cHns2519ZZR6Y06Ch71YBXrT1UF9DVvr50Blph
        kNJOHpa0PkGuN0zt1NzXNVcUnY+imhk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-CzOObnMtM-6LIAkA9JMtLQ-1; Wed, 16 Jun 2021 14:05:00 -0400
X-MC-Unique: CzOObnMtM-6LIAkA9JMtLQ-1
Received: by mail-ed1-f72.google.com with SMTP id q7-20020aa7cc070000b029038f59dab1c5so92668edt.23
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 11:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4xT1saQU128AxyzVuss1zrmEdIxNhp6j1Em1jnlU658=;
        b=r8yn1j0fxPUKjpjSUqCi3Vc8kt6AlvzezuU5C5M5EiCj5SJQ8Ti/ClT3dPDYq1qZE9
         nd4sFemDxZEhbuo00E9Gtt+nxHf8W08PCMHMgwIFQuSiNDICG8N4ld8/tpY6G9EkKxuY
         1/foCc3X+Xedd6A35DytiydcwyQFqMzmqDB4U/6RyZc8t6ChkMSqnq8lSUnd3lvjJ3EC
         8nkxYFA8th8x7vCDfhJLUTUPhpCKpQ8vTYtuvAXwn8g/2e0+7EjJzT75bzPYCqgkMjHU
         f+aOafffCe7qLfsXZpkIgP3bFYvoHdvAvOfNq2qszWikzTP63NmjtA7ZAftjhANM5IJc
         4cBQ==
X-Gm-Message-State: AOAM531Tgd/h5cVUCHxU87GKv6Xsk0eRSZW+TE9S/F3XC3iC2//A5uDb
        59xSVJCr3x7nScVlupEP03kPEI3xdEqn++8rbkb81LSHY5gEsKCvG6hoBSjvdVUIsgrvIXlMMtc
        8RgfeXMh25HpomtMHy9NpVC9PPNtbLdU5EAkIYLq6MLycoAf8t1YRgGCINT4LTnBvKumG/UE37B
        oD
X-Received: by 2002:a17:906:430f:: with SMTP id j15mr736316ejm.445.1623866699392;
        Wed, 16 Jun 2021 11:04:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwIcSFXevkrdUqdR7vlMjxGdoNi3ZMuFXrML+cFZ5zxJRb805KidDx/vbVabJ5yN9kII/82w==
X-Received: by 2002:a17:906:430f:: with SMTP id j15mr736292ejm.445.1623866699197;
        Wed, 16 Jun 2021 11:04:59 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id f23sm2016868ejb.101.2021.06.16.11.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 11:04:58 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] ACPI: scan: Fix race related to dropping
 dependencies
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <3140195.44csPzL39Z@kreacher> <3070024.5fSG56mABF@kreacher>
 <11783109.O9o76ZdvQC@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ad236554-2915-1c32-b35e-7e0300bbfda5@redhat.com>
Date:   Wed, 16 Jun 2021 20:04:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <11783109.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/16/21 8:00 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If acpi_add_single_object() runs concurrently with respect to
> acpi_scan_clear_dep() which deletes a dependencies list entry where
> the device being added is the consumer, the device's dep_unmet
> counter may not be updated to reflect that change.
> 
> Namely, if the dependencies list entry is deleted right after
> calling acpi_scan_dep_init() and before calling acpi_device_add(),
> acpi_scan_clear_dep() will not find the device object corresponding
> to the consumer device ACPI handle and it will not update its
> dep_unmet counter to reflect the deletion of the list entry.
> Consequently, the dep_unmet counter of the device will never
> become zero going forward which may prevent it from being
> completely enumerated.
> 
> To address this problem, modify acpi_add_single_object() to run
> acpi_tie_acpi_dev(), to attach the ACPI device object created by it
> to the corresponding ACPI namespace node, under acpi_dep_list_lock
> along with acpi_scan_dep_init() whenever the latter is called.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

FWIW this looks good to me now.

Regards,

Hans


> ---
> 
> -> v2:
>    * Fix memory leak spotted by Hans.
>    * Add the R-by tag from Hans.
> 
> ---
>  drivers/acpi/scan.c |   50 ++++++++++++++++++++++++++++++++------------------
>  1 file changed, 32 insertions(+), 18 deletions(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -657,16 +652,12 @@ static int acpi_tie_acpi_dev(struct acpi
>  	return 0;
>  }
>  
> -int acpi_device_add(struct acpi_device *device,
> -		    void (*release)(struct device *))
> +int __acpi_device_add(struct acpi_device *device,
> +		      void (*release)(struct device *))
>  {
>  	struct acpi_device_bus_id *acpi_device_bus_id;
>  	int result;
>  
> -	result = acpi_tie_acpi_dev(device);
> -	if (result)
> -		return result;
> -
>  	/*
>  	 * Linkage
>  	 * -------
> @@ -755,6 +746,17 @@ err_unlock:
>  	return result;
>  }
>  
> +int acpi_device_add(struct acpi_device *adev, void (*release)(struct device *))
> +{
> +	int ret;
> +
> +	ret = acpi_tie_acpi_dev(adev);
> +	if (ret)
> +		return ret;
> +
> +	return __acpi_device_add(adev, release);
> +}
> +
>  /* --------------------------------------------------------------------------
>                                   Device Enumeration
>     -------------------------------------------------------------------------- */
> @@ -1681,14 +1683,10 @@ static void acpi_scan_dep_init(struct ac
>  {
>  	struct acpi_dep_data *dep;
>  
> -	mutex_lock(&acpi_dep_list_lock);
> -
>  	list_for_each_entry(dep, &acpi_dep_list, node) {
>  		if (dep->consumer == adev->handle)
>  			adev->dep_unmet++;
>  	}
> -
> -	mutex_unlock(&acpi_dep_list_lock);
>  }
>  
>  void acpi_device_add_finalize(struct acpi_device *device)
> @@ -1707,6 +1705,7 @@ static int acpi_add_single_object(struct
>  				  acpi_handle handle, int type, bool dep_init)
>  {
>  	struct acpi_device *device;
> +	bool release_dep_lock = false;
>  	int result;
>  
>  	device = kzalloc(sizeof(struct acpi_device), GFP_KERNEL);
> @@ -1720,16 +1719,31 @@ static int acpi_add_single_object(struct
>  	 * this must be done before the get power-/wakeup_dev-flags calls.
>  	 */
>  	if (type == ACPI_BUS_TYPE_DEVICE || type == ACPI_BUS_TYPE_PROCESSOR) {
> -		if (dep_init)
> +		if (dep_init) {
> +			mutex_lock(&acpi_dep_list_lock);
> +			/*
> +			 * Hold the lock until the acpi_tie_acpi_dev() call
> +			 * below to prevent concurrent acpi_scan_clear_dep()
> +			 * from deleting a dependency list entry without
> +			 * updating dep_unmet for the device.
> +			 */
> +			release_dep_lock = true;
>  			acpi_scan_dep_init(device);
> -
> +		}
>  		acpi_scan_init_status(device);
>  	}
>  
>  	acpi_bus_get_power_flags(device);
>  	acpi_bus_get_wakeup_device_flags(device);
>  
> -	result = acpi_device_add(device, acpi_device_release);
> +	result = acpi_tie_acpi_dev(device);
> +
> +	if (release_dep_lock)
> +		mutex_unlock(&acpi_dep_list_lock);
> +
> +	if (!result)
> +		result = __acpi_device_add(device, acpi_device_release);
> +
>  	if (result) {
>  		acpi_device_release(&device->dev);
>  		return result;
> 
> 
> 

