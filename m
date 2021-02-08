Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA45831406F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbhBHU0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:26:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42920 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235958AbhBHTBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:01:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612810776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KtlCSpFAf3AXLa4Jj7JeGjW4QjI5cUdgdHDmCBZvUDM=;
        b=LxDoNPjFqenJUtz+FFPPb7Zy8wTETWRW67WYOYp7RZrOBG7U5db0UHKNJvCIlksvI3BVIZ
        ig8NbwRekuUbXhqWP+vecv0T4uZHiz8hw/HT6YrNviid+IVUnwhlzkCie4sYHhOaS8T2gX
        Sirya2tbJOVuIwNz4Klx5AtyXjTpuAY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-CW3XChxTMrG8RdZBGWD-xQ-1; Mon, 08 Feb 2021 13:59:34 -0500
X-MC-Unique: CW3XChxTMrG8RdZBGWD-xQ-1
Received: by mail-ed1-f72.google.com with SMTP id w14so14744179edv.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 10:59:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KtlCSpFAf3AXLa4Jj7JeGjW4QjI5cUdgdHDmCBZvUDM=;
        b=at/Eq6+fJGUAdoL8E6ncEXllIXGCvk93wiT1hXkWG8UjyEmTRibC7gCL669PMTlQ8o
         u/PZ0lA0UzaAmOoLDyZ8xAqQMaQzT8VvQ73EcFO/gf9ftHbGdBQx25ZL62/zufDxPSHI
         DrsdugN6lNU3eJVS9DlsMeAxzrYZ/aZGuWV2K84wGruxl0CofaF2c44np5LR6NSaNQ1e
         Gh75bKzXZ+hZBMUE1qDc+2XQWfk4pfxZHv6BoaOQRzpCd8taS7xCvyD0gEj5Vp8iJnrM
         YV61lJRYmRNv6pFRnXqVZaXmMJUbEvoEm11EOTk5UNgcLt0ktrN6cLJQy4ifVB8s9lXY
         Mlgw==
X-Gm-Message-State: AOAM533b8n9buNPzMHhy+ZA6e6yjJBaMdzLzITVIiycOU/CmyPESwNea
        ZhTCVsZVlo3JlP0nrafyebOtgyz9BgC0NprCkVXzwfNuwxqVK0CeMKdXSb+DuKG9sVsEiudcJ30
        8YjVlp9wVy5KyIiSVt2PqiOBJ
X-Received: by 2002:a17:906:dbd0:: with SMTP id yc16mr18540602ejb.524.1612810772723;
        Mon, 08 Feb 2021 10:59:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJ8Wa728GPxGlEACOd7XaETcpGxEjLfWspzRin8ImN+5/qOH+MzmJxdhhQsgHdy7zSr6kfTg==
X-Received: by 2002:a17:906:dbd0:: with SMTP id yc16mr18540580ejb.524.1612810772434;
        Mon, 08 Feb 2021 10:59:32 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id ga5sm1602034ejb.114.2021.02.08.10.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 10:59:31 -0800 (PST)
Subject: Re: [PATCH] platform/surface: Add Surface Hot-Plug driver
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <mgross@linux.intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20210205012657.1951753-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c878286c-a34e-fc4e-9d1f-c133d02b7398@redhat.com>
Date:   Mon, 8 Feb 2021 19:59:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210205012657.1951753-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/5/21 2:26 AM, Maximilian Luz wrote:
> Some Surface Book 2 and 3 models have a discrete GPU (dGPU) that is
> hot-pluggable. On those devices, the dGPU is contained in the base,
> which can be separated from the tablet part (containing CPU and
> touchscreen) while the device is running.
> 
> It (in general) is presented as/behaves like a standard PCIe hot-plug
> capable device, however, this device can also be put into D3cold. In
> D3cold, the device itself is turned off and can thus not submit any
> standard PCIe hot-plug events. To properly detect hot-(un)plugging while
> the dGPU is in D3cold, out-of-band signaling is required. Without this,
> the device state will only get updated during the next bus-check, eg.
> via a manually issued lspci call.
> 
> This commit adds a driver to handle out-of-band PCIe hot-(un)plug events
> on Microsoft Surface devices. On those devices, said events can be
> detected via GPIO interrupts, which are then forwarded to the
> corresponding ACPI DSM calls by this driver. The DSM then takes care of
> issuing the appropriate bus-/device-check, causing the PCI core to
> properly pick up the device change.
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
>  MAINTAINERS                                |   6 +
>  drivers/platform/surface/Kconfig           |  19 ++
>  drivers/platform/surface/Makefile          |   1 +
>  drivers/platform/surface/surface_hotplug.c | 282 +++++++++++++++++++++
>  4 files changed, 308 insertions(+)
>  create mode 100644 drivers/platform/surface/surface_hotplug.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 34bfa5c1aec5..4fcf3df517a8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11805,6 +11805,12 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
>  F:	drivers/platform/surface/
>  
> +MICROSOFT SURFACE HOT-PLUG DRIVER
> +M:	Maximilian Luz <luzmaximilian@gmail.com>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Maintained
> +F:	drivers/platform/surface/surface_hotplug.c
> +
>  MICROSOFT SURFACE PRO 3 BUTTON DRIVER
>  M:	Chen Yu <yu.c.chen@intel.com>
>  L:	platform-driver-x86@vger.kernel.org
> diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
> index 83b0a4c7b352..0847b2dc97bf 100644
> --- a/drivers/platform/surface/Kconfig
> +++ b/drivers/platform/surface/Kconfig
> @@ -86,6 +86,25 @@ config SURFACE_GPE
>  	  accordingly. It is required on those devices to allow wake-ups from
>  	  suspend by opening the lid.
>  
> +config SURFACE_HOTPLUG
> +	tristate "Surface Hot-Plug Driver"
> +	depends on GPIOLIB
> +	help
> +	  Driver for out-of-band hot-plug event signaling on Microsoft Surface
> +	  devices with hot-pluggable PCIe cards.
> +
> +	  This driver is used on Surface Book (2 and 3) devices with a
> +	  hot-pluggable discrete GPU (dGPU). When not in use, the dGPU on those
> +	  devices can enter D3cold, which prevents in-band (standard) PCIe
> +	  hot-plug signaling. Thus, without this driver, detaching the base
> +	  containing the dGPU will not correctly update the state of the
> +	  corresponding PCIe device if it is in D3cold. This driver adds support
> +	  for out-of-band hot-plug notifications, ensuring that the device state
> +	  is properly updated even when the device in question is in D3cold.
> +
> +	  Select M or Y here, if you want to (fully) support hot-plugging of
> +	  dGPU devices on the Surface Book 2 and/or 3 during D3cold.
> +
>  config SURFACE_PRO3_BUTTON
>  	tristate "Power/home/volume buttons driver for Microsoft Surface Pro 3/4 tablet"
>  	depends on INPUT
> diff --git a/drivers/platform/surface/Makefile b/drivers/platform/surface/Makefile
> index 3eb971006877..990424c5f0c9 100644
> --- a/drivers/platform/surface/Makefile
> +++ b/drivers/platform/surface/Makefile
> @@ -11,4 +11,5 @@ obj-$(CONFIG_SURFACE_ACPI_NOTIFY)	+= surface_acpi_notify.o
>  obj-$(CONFIG_SURFACE_AGGREGATOR)	+= aggregator/
>  obj-$(CONFIG_SURFACE_AGGREGATOR_CDEV)	+= surface_aggregator_cdev.o
>  obj-$(CONFIG_SURFACE_GPE)		+= surface_gpe.o
> +obj-$(CONFIG_SURFACE_HOTPLUG)		+= surface_hotplug.o
>  obj-$(CONFIG_SURFACE_PRO3_BUTTON)	+= surfacepro3_button.o
> diff --git a/drivers/platform/surface/surface_hotplug.c b/drivers/platform/surface/surface_hotplug.c
> new file mode 100644
> index 000000000000..cfcc15cfbacb
> --- /dev/null
> +++ b/drivers/platform/surface/surface_hotplug.c
> @@ -0,0 +1,282 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Surface Book (2 and later) hot-plug driver.
> + *
> + * Surface Book devices (can) have a hot-pluggable discrete GPU (dGPU). This
> + * driver is responsible for out-of-band hot-plug event signaling on these
> + * devices. It is specifically required when the hot-plug device is in D3cold
> + * and can thus not generate PCIe hot-plug events itself.
> + *
> + * Event signaling is handled via ACPI, which will generate the appropriate
> + * device-check notifications to be picked up by the PCIe hot-plug driver.
> + *
> + * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/gpio.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +
> +static const struct acpi_gpio_params shps_base_presence_int   = { 0, 0, false };
> +static const struct acpi_gpio_params shps_base_presence       = { 1, 0, false };
> +static const struct acpi_gpio_params shps_device_power_int    = { 2, 0, false };
> +static const struct acpi_gpio_params shps_device_power        = { 3, 0, false };
> +static const struct acpi_gpio_params shps_device_presence_int = { 4, 0, false };
> +static const struct acpi_gpio_params shps_device_presence     = { 5, 0, false };
> +
> +static const struct acpi_gpio_mapping shps_acpi_gpios[] = {
> +	{ "base_presence-int-gpio",   &shps_base_presence_int,   1 },
> +	{ "base_presence-gpio",       &shps_base_presence,       1 },
> +	{ "device_power-int-gpio",    &shps_device_power_int,    1 },
> +	{ "device_power-gpio",        &shps_device_power,        1 },
> +	{ "device_presence-int-gpio", &shps_device_presence_int, 1 },
> +	{ "device_presence-gpio",     &shps_device_presence,     1 },
> +	{ },
> +};
> +
> +/* 5515a847-ed55-4b27-8352-cd320e10360a */
> +static const guid_t shps_dsm_guid =
> +	GUID_INIT(0x5515a847, 0xed55, 0x4b27, 0x83, 0x52, 0xcd, 0x32, 0x0e, 0x10, 0x36, 0x0a);
> +
> +#define SHPS_DSM_REVISION		1
> +
> +enum shps_dsm_fn {
> +	SHPS_DSM_FN_PCI_NUM_ENTRIES	= 0x01,
> +	SHPS_DSM_FN_PCI_GET_ENTRIES	= 0x02,
> +	SHPS_DSM_FN_IRQ_BASE_PRESENCE	= 0x03,
> +	SHPS_DSM_FN_IRQ_DEVICE_POWER	= 0x04,
> +	SHPS_DSM_FN_IRQ_DEVICE_PRESENCE	= 0x05,
> +};
> +
> +enum shps_irq_type {
> +	/* NOTE: Must be in order of enum shps_dsm_fn above. */
> +	SHPS_IRQ_TYPE_BASE_PRESENCE	= 0,
> +	SHPS_IRQ_TYPE_DEVICE_POWER	= 1,
> +	SHPS_IRQ_TYPE_DEVICE_PRESENCE	= 2,
> +	SHPS_NUM_IRQS,
> +};
> +
> +static const char *const shps_gpio_names[] = {
> +	[SHPS_IRQ_TYPE_BASE_PRESENCE]	= "base_presence",
> +	[SHPS_IRQ_TYPE_DEVICE_POWER]	= "device_power",
> +	[SHPS_IRQ_TYPE_DEVICE_PRESENCE]	= "device_presence",
> +};
> +
> +struct shps_device {
> +	struct mutex lock[SHPS_NUM_IRQS];  /* Protects update in shps_dsm_notify_irq() */
> +	struct gpio_desc *gpio[SHPS_NUM_IRQS];
> +	unsigned int irq[SHPS_NUM_IRQS];
> +};
> +
> +#define SHPS_IRQ_NOT_PRESENT		((unsigned int)-1)
> +
> +static enum shps_dsm_fn shps_dsm_fn_for_irq(enum shps_irq_type type)
> +{
> +	return SHPS_DSM_FN_IRQ_BASE_PRESENCE + type;
> +}
> +
> +static void shps_dsm_notify_irq(struct platform_device *pdev, enum shps_irq_type type)
> +{
> +	struct shps_device *sdev = platform_get_drvdata(pdev);
> +	acpi_handle handle = ACPI_HANDLE(&pdev->dev);
> +	union acpi_object *result;
> +	union acpi_object param;
> +	int value;
> +
> +	mutex_lock(&sdev->lock[type]);
> +
> +	value = gpiod_get_value_cansleep(sdev->gpio[type]);
> +	if (value < 0) {
> +		mutex_unlock(&sdev->lock[type]);
> +		dev_err(&pdev->dev, "failed to get gpio: %d (irq=%d)\n", type, value);
> +		return;
> +	}
> +
> +	dev_dbg(&pdev->dev, "IRQ notification via DSM (irq=%d, value=%d)\n", type, value);
> +
> +	param.type = ACPI_TYPE_INTEGER;
> +	param.integer.value = value;
> +
> +	result = acpi_evaluate_dsm(handle, &shps_dsm_guid, SHPS_DSM_REVISION,
> +				   shps_dsm_fn_for_irq(type), &param);
> +
> +	if (!result) {
> +		dev_err(&pdev->dev, "IRQ notification via DSM failed (irq=%d, gpio=%d)\n",
> +			type, value);
> +
> +	} else if (result->type != ACPI_TYPE_BUFFER) {
> +		dev_err(&pdev->dev,
> +			"IRQ notification via DSM failed: unexpected result type (irq=%d, gpio=%d)\n",
> +			type, value);
> +
> +	} else if (result->buffer.length != 1 || result->buffer.pointer[0] != 0) {
> +		dev_err(&pdev->dev,
> +			"IRQ notification via DSM failed: unexpected result value (irq=%d, gpio=%d)\n",
> +			type, value);
> +	}
> +
> +	mutex_unlock(&sdev->lock[type]);
> +
> +	if (result)
> +		ACPI_FREE(result);
> +}
> +
> +static irqreturn_t shps_handle_irq(int irq, void *data)
> +{
> +	struct platform_device *pdev = data;
> +	struct shps_device *sdev = platform_get_drvdata(pdev);
> +	int type;
> +
> +	/* Figure out which IRQ we're handling. */
> +	for (type = 0; type < SHPS_NUM_IRQS; type++)
> +		if (irq == sdev->irq[type])
> +			break;
> +
> +	/* We should have found our interrupt, if not: this is a bug. */
> +	if (WARN(type >= SHPS_NUM_IRQS, "invalid IRQ number: %d\n", irq))
> +		return IRQ_HANDLED;
> +
> +	/* Forward interrupt to ACPI via DSM. */
> +	shps_dsm_notify_irq(pdev, type);
> +	return IRQ_HANDLED;
> +}
> +
> +static int shps_setup_irq(struct platform_device *pdev, enum shps_irq_type type)
> +{
> +	unsigned long flags = IRQF_ONESHOT | IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING;
> +	struct shps_device *sdev = platform_get_drvdata(pdev);
> +	struct gpio_desc *gpiod;
> +	acpi_handle handle = ACPI_HANDLE(&pdev->dev);
> +	const char *irq_name;
> +	const int dsm = shps_dsm_fn_for_irq(type);
> +	int status, irq;
> +
> +	/*
> +	 * Only set up interrupts that we actually need: The Surface Book 3
> +	 * does not have a DSM for base presence, so don't set up an interrupt
> +	 * for that.
> +	 */
> +	if (!acpi_check_dsm(handle, &shps_dsm_guid, SHPS_DSM_REVISION, BIT(dsm))) {
> +		dev_dbg(&pdev->dev, "IRQ notification via DSM not present (irq=%d)\n", type);
> +		return 0;
> +	}
> +
> +	gpiod = devm_gpiod_get(&pdev->dev, shps_gpio_names[type], GPIOD_ASIS);
> +	if (IS_ERR(gpiod))
> +		return PTR_ERR(gpiod);
> +
> +	irq = gpiod_to_irq(gpiod);
> +	if (irq < 0)
> +		return irq;
> +
> +	irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "shps-irq-%d", type);
> +	if (!irq_name)
> +		return -ENOMEM;
> +
> +	status = devm_request_threaded_irq(&pdev->dev, irq, NULL, shps_handle_irq,
> +					   flags, irq_name, pdev);
> +	if (status)
> +		return status;
> +
> +	dev_dbg(&pdev->dev, "set up irq %d as type %d\n", irq, type);
> +
> +	sdev->gpio[type] = gpiod;
> +	sdev->irq[type] = irq;
> +
> +	return 0;
> +}
> +
> +static int surface_hotplug_remove(struct platform_device *pdev)
> +{
> +	struct shps_device *sdev = platform_get_drvdata(pdev);
> +	int i;
> +
> +	/* Ensure that IRQs have been fully handled and won't trigger any more. */
> +	for (i = 0; i < SHPS_NUM_IRQS; i++) {
> +		if (sdev->irq[i] != SHPS_IRQ_NOT_PRESENT)
> +			disable_irq(sdev->irq[i]);
> +
> +		mutex_destroy(&sdev->lock[i]);
> +	}
> +
> +	return 0;
> +}
> +
> +static int surface_hotplug_probe(struct platform_device *pdev)
> +{
> +	struct shps_device *sdev;
> +	int status, i;
> +
> +	/*
> +	 * The MSHW0153 device is also present on the Surface Laptop 3,
> +	 * however that doesn't have a hot-pluggable PCIe device. It also
> +	 * doesn't have any GPIO interrupts/pins under the MSHW0153, so filter
> +	 * it out here.
> +	 */
> +	if (gpiod_count(&pdev->dev, NULL) < 0)
> +		return -ENODEV;
> +
> +	status = devm_acpi_dev_add_driver_gpios(&pdev->dev, shps_acpi_gpios);
> +	if (status)
> +		return status;
> +
> +	sdev = devm_kzalloc(&pdev->dev, sizeof(*sdev), GFP_KERNEL);
> +	if (!sdev)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, sdev);
> +
> +	/*
> +	 * Initialize IRQs so that we can safely call surface_hotplug_remove()
> +	 * on errors.
> +	 */
> +	for (i = 0; i < SHPS_NUM_IRQS; i++)
> +		sdev->irq[i] = SHPS_IRQ_NOT_PRESENT;
> +
> +	/* Set up IRQs. */
> +	for (i = 0; i < SHPS_NUM_IRQS; i++) {
> +		mutex_init(&sdev->lock[i]);
> +
> +		status = shps_setup_irq(pdev, i);
> +		if (status) {
> +			dev_err(&pdev->dev, "failed to set up IRQ %d: %d\n", i, status);
> +			goto err;
> +		}
> +	}
> +
> +	/* Ensure everything is up-to-date. */
> +	for (i = 0; i < SHPS_NUM_IRQS; i++)
> +		if (sdev->irq[i] != SHPS_IRQ_NOT_PRESENT)
> +			shps_dsm_notify_irq(pdev, i);
> +
> +	return 0;
> +
> +err:
> +	surface_hotplug_remove(pdev);
> +	return status;
> +}
> +
> +static const struct acpi_device_id surface_hotplug_acpi_match[] = {
> +	{ "MSHW0153", 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, surface_hotplug_acpi_match);
> +
> +static struct platform_driver surface_hotplug_driver = {
> +	.probe = surface_hotplug_probe,
> +	.remove = surface_hotplug_remove,
> +	.driver = {
> +		.name = "surface_hotplug",
> +		.acpi_match_table = surface_hotplug_acpi_match,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +};
> +module_platform_driver(surface_hotplug_driver);
> +
> +MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
> +MODULE_DESCRIPTION("Surface Hot-Plug Signaling Driver for Surface Book Devices");
> +MODULE_LICENSE("GPL");
> 

