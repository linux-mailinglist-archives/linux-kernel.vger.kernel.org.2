Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7825C3A9E0F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbhFPOv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:51:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56195 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234115AbhFPOv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623854959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sznSHfSbu6vIbtyYeAU9SEag45GkUwaYu2SUeh+1s9o=;
        b=iFo4rGwRVd0dJPcV2UYTioW3HqmJrHolfH6RByYbJpopkAhnnXoh7FrUTy+2ri2zg1zzVC
        YrvfW47q4JdCGfC/xlSxVTKWd4X1ZyOgR229Ao3P12adC78EkwN5541vggygA7e0QEJyLH
        rp1nUi8tVlmk7VGn+sYsmaffoNF1EQs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-cs9hY77SOxe6EaHEmrM4Mw-1; Wed, 16 Jun 2021 10:49:18 -0400
X-MC-Unique: cs9hY77SOxe6EaHEmrM4Mw-1
Received: by mail-ej1-f71.google.com with SMTP id 16-20020a1709063010b029037417ca2d43so1065491ejz.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 07:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sznSHfSbu6vIbtyYeAU9SEag45GkUwaYu2SUeh+1s9o=;
        b=Myjpv0BPYpBtsoMLOLVeudk7r8t8vrlQ/EyeFOOF4Lj8yHqX5c5g1nUGRrZlmuzl9R
         g2mACpBlPpNsHnLgB8lVUL1HsPL1OQCaQwJBdjtRFKUVn+L9dewaMvxfJfoV45iyFhuv
         z8/N2Tgs2SdDOrr1EIM3EQoCk6ogWACHEzEaaR9LnLW9tuCBrVfSpJYWfIaRDzmRPdFm
         kO8H80wIKgBIpMj9cHH7rHD7VojiEI0nQm5/MPAAMCXSFxxaTcj/T75NIP1lkxXWs7Eo
         D8WE1gX2xDsaMLWuqevy73LZMFFL3ckQYmoxAuMlINkdC9H3eqRkcBGXtWNkukBMpb27
         FQ/A==
X-Gm-Message-State: AOAM5333K/rlJk5TjbacCjZeuivNZ+AWJzwBMp1ZgNNuj64a5x9I6U4r
        m5QjucD2Ka7P39EQA+hcVU71ZrgRasaCuBiDUcpi5k7WWa4HodA+JEKsHkkniAhZb5iUpcnzrsD
        +9mP4cu8D4ndj+bxlqz93SGXpbgu+DfR/7rx87dihZY/XSHvNLL81wVcfAmGQDOfgvdUS5vvY8M
        Pw
X-Received: by 2002:a17:906:2da1:: with SMTP id g1mr164441eji.47.1623854957154;
        Wed, 16 Jun 2021 07:49:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkbUwdDM3v3utQRGWmdo04bZJQEe7yOBdrvwLR9UYl+hE0nVwW3gd/BDYx5zzZt3e1a9m6Ew==
X-Received: by 2002:a17:906:2da1:: with SMTP id g1mr164423eji.47.1623854956998;
        Wed, 16 Jun 2021 07:49:16 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id h19sm1701217ejy.82.2021.06.16.07.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 07:49:16 -0700 (PDT)
Subject: Re: [PATCH 4/5] ACPI: scan: Reorganize acpi_device_add()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <3140195.44csPzL39Z@kreacher> <3392385.iIbC2pHGDl@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <df7f7b9d-811f-326c-20bb-86a7c42ef859@redhat.com>
Date:   Wed, 16 Jun 2021 16:49:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <3392385.iIbC2pHGDl@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/16/21 4:24 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Move the invocation of acpi_attach_data() in acpi_device_add()
> into a separate function.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/acpi/scan.c |   31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -640,23 +640,32 @@ static int acpi_device_set_name(struct a
>  	return 0;
>  }
>  
> +static int acpi_tie_acpi_dev(struct acpi_device *adev)
> +{
> +	acpi_handle handle = adev->handle;
> +	acpi_status status;
> +
> +	if (!handle)
> +		return 0;
> +
> +	status = acpi_attach_data(handle, acpi_scan_drop_device, adev);
> +	if (ACPI_FAILURE(status)) {
> +		acpi_handle_err(handle, "Unable to attach device data\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
>  int acpi_device_add(struct acpi_device *device,
>  		    void (*release)(struct device *))
>  {
>  	struct acpi_device_bus_id *acpi_device_bus_id;
>  	int result;
>  
> -	if (device->handle) {
> -		acpi_status status;
> -
> -		status = acpi_attach_data(device->handle, acpi_scan_drop_device,
> -					  device);
> -		if (ACPI_FAILURE(status)) {
> -			acpi_handle_err(device->handle,
> -					"Unable to attach device data\n");
> -			return -ENODEV;
> -		}
> -	}
> +	result = acpi_tie_acpi_dev(device);
> +	if (result)
> +		return result;
>  
>  	/*
>  	 * Linkage
> 
> 
> 

