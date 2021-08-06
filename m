Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6743E2BBC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 15:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344238AbhHFNnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 09:43:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31494 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235812AbhHFNnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 09:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628257363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M/UqUcyoK0Gz7dJ8bseYtoRK9cLAYk3EsEW0lh8ULus=;
        b=fiqicerrg7gm8ttudCR5/QrrA1GIKJqBa0j8aipO1RsOXyqIjZ58W5P0n2SfMRlV4ZlAqc
        WUOpM8v7up//atdx/D4zLLXB3al9wGCpMHqZJIGm2ek5SX/mhJ0l/7/rUgvFlxFkHYWWb7
        HPwyF43FMFDnJARJTLbC6RYeLDFNOzY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-1Dp2a1CzOsC63sK1svVFVA-1; Fri, 06 Aug 2021 09:42:42 -0400
X-MC-Unique: 1Dp2a1CzOsC63sK1svVFVA-1
Received: by mail-ej1-f72.google.com with SMTP id qf6-20020a1709077f06b029057e66b6665aso3139073ejc.18
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 06:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M/UqUcyoK0Gz7dJ8bseYtoRK9cLAYk3EsEW0lh8ULus=;
        b=QXli6a2jSYe3ZoNCWryyeMHSYMwBJWu13JAoP0o8LCOKuRIv/N/9SLUB29zUWe19wN
         tqyCOVT4sq3iPQJkt72kJ+qHmlqnnw6cjUWk3JXlGcN2TvO3BPfx4rLmZav1i0t5zhFy
         UMt8QMOToTt4H2PYTJ0aqQK1aAws1Sli/FfwJ+GiKQt46HPS6jQXzbpBCtYYlre8gsJt
         GFo9doZWzZOHiUP2D9ih9xUkWEQaEZhjjFhfo7KI23XUdS9OlZps48wDw2oCauvYgkwb
         i7BMOT5oDAGGJexve+5PjazAkldziHtmRhXLxKf7RttjsTB4HHEi2MaZntsjN9bPplUH
         diEw==
X-Gm-Message-State: AOAM530XG/Ip6ktq41WDQH30syXZgxtHSrIUUbHe/9+oA8+6NAPdG4eW
        0Ul51z3wHG7jkKSoDINYwsrcNqkyDpqpPO7nSs/SeBmf0oiALruuXziNLO+rNAHOkeJoed+1Bsh
        1BME/67hhfVs0JsmR/HJHI0dP
X-Received: by 2002:a05:6402:291d:: with SMTP id ee29mr13169685edb.289.1628257361442;
        Fri, 06 Aug 2021 06:42:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFfxzVuVeMpXupRjOlALuObFtLtK+bIJcovZf39hkS7NpoGg+2PN9MMOhdwZdB2Gcc3o6pPA==
X-Received: by 2002:a05:6402:291d:: with SMTP id ee29mr13169666edb.289.1628257361260;
        Fri, 06 Aug 2021 06:42:41 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id o7sm2860221ejy.48.2021.08.06.06.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 06:42:40 -0700 (PDT)
Subject: Re: [RFT, PATCH v1 1/1] platform/x86: hp_accel: Convert to be a
 platform driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eric Piel <eric.piel@tremplin-utc.net>,
        Mark Gross <mgross@linux.intel.com>
References: <20210803200820.3259-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <48332796-1b9a-c897-c695-e66b116386be@redhat.com>
Date:   Fri, 6 Aug 2021 15:42:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210803200820.3259-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/3/21 10:08 PM, Andy Shevchenko wrote:
> ACPI core in conjunction with platform driver core provides
> an infrastructure to enumerate ACPI devices. Use it in order
> to remove a lot of boilerplate code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> Not sure what buys us to run _INI on PM calls. It's against the spec AFAICT.
> In any case ACPICA runs _INI as per specification when devices are
> instantiated.

_INI used to also be ran on resume for some reason, but that was recently
changed.

You're right that calling it is no longer necessary now that we no longer
do that.

But the changes related to this are really separate from the platform
driver conversion, please split this into 2 patches.

Also for the next version please Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
and ask him to test, I think he has access to hardware to test this.

Regards,

Hans


> 
>  drivers/platform/x86/hp_accel.c | 74 +++++++--------------------------
>  1 file changed, 14 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp_accel.c b/drivers/platform/x86/hp_accel.c
> index 8c0867bda828..69f86b761c7f 100644
> --- a/drivers/platform/x86/hp_accel.c
> +++ b/drivers/platform/x86/hp_accel.c
> @@ -29,7 +29,6 @@
>  #include "../../misc/lis3lv02d/lis3lv02d.h"
>  
>  #define DRIVER_NAME     "hp_accel"
> -#define ACPI_MDPS_CLASS "accelerometer"
>  
>  /* Delayed LEDs infrastructure ------------------------------------ */
>  
> @@ -78,7 +77,6 @@ static const struct acpi_device_id lis3lv02d_device_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, lis3lv02d_device_ids);
>  
> -
>  /**
>   * lis3lv02d_acpi_init - ACPI _INI method: initialize the device.
>   * @lis3: pointer to the device struct
> @@ -87,14 +85,6 @@ MODULE_DEVICE_TABLE(acpi, lis3lv02d_device_ids);
>   */
>  static int lis3lv02d_acpi_init(struct lis3lv02d *lis3)
>  {
> -	struct acpi_device *dev = lis3->bus_priv;
> -	if (!lis3->init_required)
> -		return 0;
> -
> -	if (acpi_evaluate_object(dev->handle, METHOD_NAME__INI,
> -				 NULL, NULL) != AE_OK)
> -		return -EINVAL;
> -
>  	return 0;
>  }
>  
> @@ -278,30 +268,6 @@ static struct delayed_led_classdev hpled_led = {
>  	.set_brightness = hpled_set,
>  };
>  
> -static acpi_status
> -lis3lv02d_get_resource(struct acpi_resource *resource, void *context)
> -{
> -	if (resource->type == ACPI_RESOURCE_TYPE_EXTENDED_IRQ) {
> -		struct acpi_resource_extended_irq *irq;
> -		u32 *device_irq = context;
> -
> -		irq = &resource->data.extended_irq;
> -		*device_irq = irq->interrupts[0];
> -	}
> -
> -	return AE_OK;
> -}
> -
> -static void lis3lv02d_enum_resources(struct acpi_device *device)
> -{
> -	acpi_status status;
> -
> -	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
> -					lis3lv02d_get_resource, &lis3_dev.irq);
> -	if (ACPI_FAILURE(status))
> -		printk(KERN_DEBUG DRIVER_NAME ": Error getting resources\n");
> -}
> -
>  static bool hp_accel_i8042_filter(unsigned char data, unsigned char str,
>  				  struct serio *port)
>  {
> @@ -331,23 +297,19 @@ static bool hp_accel_i8042_filter(unsigned char data, unsigned char str,
>  	return false;
>  }
>  
> -static int lis3lv02d_add(struct acpi_device *device)
> +static int lis3lv02d_probe(struct platform_device *device)
>  {
>  	int ret;
>  
> -	if (!device)
> -		return -EINVAL;
> -
> -	lis3_dev.bus_priv = device;
> +	lis3_dev.bus_priv = ACPI_COMPANION(&device->dev);
>  	lis3_dev.init = lis3lv02d_acpi_init;
>  	lis3_dev.read = lis3lv02d_acpi_read;
>  	lis3_dev.write = lis3lv02d_acpi_write;
> -	strcpy(acpi_device_name(device), DRIVER_NAME);
> -	strcpy(acpi_device_class(device), ACPI_MDPS_CLASS);
> -	device->driver_data = &lis3_dev;
>  
>  	/* obtain IRQ number of our device from ACPI */
> -	lis3lv02d_enum_resources(device);
> +	ret = platform_get_irq_optional(device, 0);
> +	if (ret > 0)
> +		lis3_dev.irq = ret;
>  
>  	/* If possible use a "standard" axes order */
>  	if (lis3_dev.ac.x && lis3_dev.ac.y && lis3_dev.ac.z) {
> @@ -359,7 +321,6 @@ static int lis3lv02d_add(struct acpi_device *device)
>  	}
>  
>  	/* call the core layer do its init */
> -	lis3_dev.init_required = true;
>  	ret = lis3lv02d_init_device(&lis3_dev);
>  	if (ret)
>  		return ret;
> @@ -381,11 +342,8 @@ static int lis3lv02d_add(struct acpi_device *device)
>  	return ret;
>  }
>  
> -static int lis3lv02d_remove(struct acpi_device *device)
> +static int lis3lv02d_remove(struct platform_device *device)
>  {
> -	if (!device)
> -		return -EINVAL;
> -
>  	i8042_remove_filter(hp_accel_i8042_filter);
>  	lis3lv02d_joystick_disable(&lis3_dev);
>  	lis3lv02d_poweroff(&lis3_dev);
> @@ -396,7 +354,6 @@ static int lis3lv02d_remove(struct acpi_device *device)
>  	return lis3lv02d_remove_fs(&lis3_dev);
>  }
>  
> -
>  #ifdef CONFIG_PM_SLEEP
>  static int lis3lv02d_suspend(struct device *dev)
>  {
> @@ -407,14 +364,12 @@ static int lis3lv02d_suspend(struct device *dev)
>  
>  static int lis3lv02d_resume(struct device *dev)
>  {
> -	lis3_dev.init_required = false;
>  	lis3lv02d_poweron(&lis3_dev);
>  	return 0;
>  }
>  
>  static int lis3lv02d_restore(struct device *dev)
>  {
> -	lis3_dev.init_required = true;
>  	lis3lv02d_poweron(&lis3_dev);
>  	return 0;
>  }
> @@ -434,17 +389,16 @@ static const struct dev_pm_ops hp_accel_pm = {
>  #endif
>  
>  /* For the HP MDPS aka 3D Driveguard */
> -static struct acpi_driver lis3lv02d_driver = {
> -	.name  = DRIVER_NAME,
> -	.class = ACPI_MDPS_CLASS,
> -	.ids   = lis3lv02d_device_ids,
> -	.ops = {
> -		.add     = lis3lv02d_add,
> -		.remove  = lis3lv02d_remove,
> +static struct platform_driver lis3lv02d_driver = {
> +	.probe	= lis3lv02d_probe,
> +	.remove	= lis3lv02d_remove,
> +	.driver	= {
> +		.name	= DRIVER_NAME,
> +		.pm	= HP_ACCEL_PM,
> +		.acpi_match_table = lis3lv02d_device_ids,
>  	},
> -	.drv.pm = HP_ACCEL_PM,
>  };
> -module_acpi_driver(lis3lv02d_driver);
> +module_platform_driver(lis3lv02d_driver);
>  
>  MODULE_DESCRIPTION("Glue between LIS3LV02Dx and HP ACPI BIOS and support for disk protection LED.");
>  MODULE_AUTHOR("Yan Burman, Eric Piel, Pavel Machek");
> 

