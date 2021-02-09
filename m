Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050533144F6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 01:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhBIAbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 19:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbhBIAbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 19:31:43 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259F8C061788;
        Mon,  8 Feb 2021 16:31:03 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id t5so21376980eds.12;
        Mon, 08 Feb 2021 16:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G4cGN1gyJSUvq+1Jn7Yix1wlt2fbiFQ4x3XqhnPQ2i0=;
        b=r5zP2b3Qpn8qvHz50PE7WcTFRS60H5LZenb25Ihnw2JODRF654gum4Kxf6YDEvPz0g
         GUy/IrxPsZpcDd6WeiaHegu3xRlcsP8MXy9kX4HxSFIc0b3k8x8t9uKP7pNTYfLSKLA1
         CKmQmM2Z/j1vfacPBvshCJMwOaFoJSNTAJSbpX8ZnUgecp4K6GfPmkUHaxrY8L+Tceag
         Q++8uwKWZ357w1reiC35IRxm2aXN4hDmYX/GzTocOYGLILUtlg+STSxzvaqIshkLE99L
         ptD+S4UB0FKQdJBg0z13ZSaV7hsRlCVzcSr0QxDYJJAHt8PinTCYtOBsi/6EQShJFGCK
         naRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G4cGN1gyJSUvq+1Jn7Yix1wlt2fbiFQ4x3XqhnPQ2i0=;
        b=QEcNaYdQN5mfwg+c52UvWCncpa7/5e1/H/Z3bKKfHiwhAeAwYzQBq530BoADb2pJ40
         /69ZoYfrYWdToUjtFidvtccj+l/MYJ8b9LTQMudlWRPiKQqHKw1pNWIipRFThVb8wQmx
         svlrjCMNVZl0qHXswt/ML6Y9P/5VSkns0h+YEXaQ9MOpRWuVtTKkdwMPVg2sf3fyDM1x
         yiAt5muJ36Y76+3opvQ7w+9KHjjjy9YIg8aYnsWKI2BENurQj+K+Y/iKgVZZgUfy2wOF
         chG3KSyvfTupSpvR5rTJ3ob68zmR/QfnDLbZ8k0w0ZVqXzCfBtJC+hIHvd5/ssMmcvTy
         Hk6g==
X-Gm-Message-State: AOAM533ifU8aJ9TEYsvKCBT8b2hJXJDqkXLZdMiIXZtnqnP+pjlG1nWi
        YZg64VMRyoMKCd+h/qPudamUyVsrK3IEUg==
X-Google-Smtp-Source: ABdhPJy6Wso6e+MY+pSTjDi5T+339/2ynYxDJCSx5/soU/6cjGaunxJfJIpsi0WaCYOD/NJ9jlqPEQ==
X-Received: by 2002:a50:a6ce:: with SMTP id f14mr19766735edc.346.1612830661195;
        Mon, 08 Feb 2021 16:31:01 -0800 (PST)
Received: from [10.19.0.6] ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id b4sm4997112edh.40.2021.02.08.16.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 16:31:00 -0800 (PST)
Subject: Re: [PATCH 1/6] platform/surface: Set up Surface Aggregator device
 registry
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210208193508.3038055-1-luzmaximilian@gmail.com>
 <20210208193508.3038055-2-luzmaximilian@gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <2701b959-cb60-3ced-bb02-407f000f1d82@gmail.com>
Date:   Tue, 9 Feb 2021 01:30:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210208193508.3038055-2-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/8/21 8:35 PM, Maximilian Luz wrote:
> The Surface System Aggregator Module (SSAM) subsystem provides various
> functionalities, which are separated by spreading them across multiple
> devices and corresponding drivers. Parts of that functionality / some of
> those devices, however, can (as far as we currently know) not be
> auto-detected by conventional means. While older (specifically 5th- and
> 6th-)generation models do advertise most of their functionality via
> standard platform devices in ACPI, newer generations do not.
> 
> As we are currently also not aware of any feasible way to query said
> functionalities dynamically, this poses a problem. There is, however, a
> device in ACPI that seems to be used by Windows for identifying
> different Surface models: The Windows Surface Integration Device (WSID).
> This device seems to have a HID corresponding to the overall set of
> functionalities SSAM provides for the associated model.
> 
> This commit introduces a registry providing non-detectable device
> information via software nodes. In addition, a SSAM platform hub driver
> is introduced, which takes care of creating and managing the SSAM
> devices specified in this registry. This approach allows for a
> hierarchical setup akin to ACPI and is easily extendable, e.g. via
> firmware node properties.
> 
> Note that this commit only provides the basis for the platform hub and
> registry, and does not add any content to it. The registry will be
> expanded in subsequent commits.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---
>   MAINTAINERS                                   |   1 +
>   drivers/platform/surface/Kconfig              |  26 ++
>   drivers/platform/surface/Makefile             |   1 +
>   .../surface/surface_aggregator_registry.c     | 284 ++++++++++++++++++
>   4 files changed, 312 insertions(+)
>   create mode 100644 drivers/platform/surface/surface_aggregator_registry.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4fcf3df517a8..000a82f59c76 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11826,6 +11826,7 @@ F:	Documentation/driver-api/surface_aggregator/
>   F:	drivers/platform/surface/aggregator/
>   F:	drivers/platform/surface/surface_acpi_notify.c
>   F:	drivers/platform/surface/surface_aggregator_cdev.c
> +F:	drivers/platform/surface/surface_aggregator_registry.c
>   F:	include/linux/surface_acpi_notify.h
>   F:	include/linux/surface_aggregator/
>   F:	include/uapi/linux/surface_aggregator/
> diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
> index 0847b2dc97bf..1cd37c041710 100644
> --- a/drivers/platform/surface/Kconfig
> +++ b/drivers/platform/surface/Kconfig
> @@ -77,6 +77,32 @@ config SURFACE_AGGREGATOR_CDEV
>   	  The provided interface is intended for debugging and development only,
>   	  and should not be used otherwise.
>   
> +config SURFACE_AGGREGATOR_REGISTRY
> +	tristate "Surface System Aggregator Module Device Registry"
> +	depends on SURFACE_AGGREGATOR_BUS

Just noticed that there should also be a

     depends on SURFACE_AGGREGATOR

here as SURFACE_AGGREGATOR_BUS is a bool. Without that, one could set

     CONFIG_SURFACE_AGGREGATOR=m
     CONFIG_SURFACE_AGGREGATOR_BUS=y
     CONFIG_SURFACE_AGGREGATOR_REGISTRY=y

which will probably cause the compiler to complain that it can't find
the functions from the Aggregator module.

I'll leave it up as-is for a bit longer to maybe gather a couple more
comments before I send out a v2 with this fixed.

> +	help
> +	  Device-registry and device-hubs for Surface System Aggregator Module
> +	  (SSAM) devices.
> +
> +	  Provides a module and driver which act as a device-registry for SSAM
> +	  client devices that cannot be detected automatically, e.g. via ACPI.
> +	  Such devices are instead provided via this registry and attached via
> +	  device hubs, also provided in this module.
> +
> +	  Devices provided via this registry are:
> +	  - Platform profile (performance-/cooling-mode) device (5th- and later
> +	    generations).
> +	  - Battery/AC devices (7th-generation).
> +	  - HID input devices (7th-generation).
> +
> +	  Select M (recommended) or Y here if you want support for the above
> +	  mentioned devices on the corresponding Surface models. Without this
> +	  module, the respective devices will not be instantiated and thus any
> +	  functionality provided by them will be missing, even when drivers for
> +	  these devices are present. In other words, this module only provides
> +	  the respective client devices. Drivers for these devices still need to
> +	  be selected via the other options.
> +
>   config SURFACE_GPE
>   	tristate "Surface GPE/Lid Support Driver"
>   	depends on DMI
> diff --git a/drivers/platform/surface/Makefile b/drivers/platform/surface/Makefile
> index 990424c5f0c9..80035ee540bf 100644
> --- a/drivers/platform/surface/Makefile
> +++ b/drivers/platform/surface/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_SURFACE_3_POWER_OPREGION)	+= surface3_power.o
>   obj-$(CONFIG_SURFACE_ACPI_NOTIFY)	+= surface_acpi_notify.o
>   obj-$(CONFIG_SURFACE_AGGREGATOR)	+= aggregator/
>   obj-$(CONFIG_SURFACE_AGGREGATOR_CDEV)	+= surface_aggregator_cdev.o
> +obj-$(CONFIG_SURFACE_AGGREGATOR_REGISTRY) += surface_aggregator_registry.o
>   obj-$(CONFIG_SURFACE_GPE)		+= surface_gpe.o
>   obj-$(CONFIG_SURFACE_HOTPLUG)		+= surface_hotplug.o
>   obj-$(CONFIG_SURFACE_PRO3_BUTTON)	+= surfacepro3_button.o
> diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
> new file mode 100644
> index 000000000000..a051d941ad96
> --- /dev/null
> +++ b/drivers/platform/surface/surface_aggregator_registry.c
> @@ -0,0 +1,284 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Surface System Aggregator Module (SSAM) client device registry.
> + *
> + * Registry for non-platform/non-ACPI SSAM client devices, i.e. devices that
> + * cannot be auto-detected. Provides device-hubs and performs instantiation
> + * for these devices.
> + *
> + * Copyright (C) 2020-2021 Maximilian Luz <luzmaximilian@gmail.com>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +
> +#include <linux/surface_aggregator/controller.h>
> +#include <linux/surface_aggregator/device.h>
> +
> +
> +/* -- Device registry. ------------------------------------------------------ */
> +
> +/*
> + * SSAM device names follow the SSAM module alias, meaning they are prefixed
> + * with 'ssam:', followed by domain, category, target ID, instance ID, and
> + * function, each encoded as two-digit hexadecimal, separated by ':'. In other
> + * words, it follows the scheme
> + *
> + *      ssam:dd:cc:tt:ii:ff
> + *
> + * Where, 'dd', 'cc', 'tt', 'ii', and 'ff' are the two-digit hexadecimal
> + * values mentioned above, respectively.
> + */
> +
> +/* Root node. */
> +static const struct software_node ssam_node_root = {
> +	.name = "ssam_platform_hub",
> +};
> +
> +/* Devices for Surface Book 2. */
> +static const struct software_node *ssam_node_group_sb2[] = {
> +	&ssam_node_root,
> +	NULL,
> +};
> +
> +/* Devices for Surface Book 3. */
> +static const struct software_node *ssam_node_group_sb3[] = {
> +	&ssam_node_root,
> +	NULL,
> +};
> +
> +/* Devices for Surface Laptop 1. */
> +static const struct software_node *ssam_node_group_sl1[] = {
> +	&ssam_node_root,
> +	NULL,
> +};
> +
> +/* Devices for Surface Laptop 2. */
> +static const struct software_node *ssam_node_group_sl2[] = {
> +	&ssam_node_root,
> +	NULL,
> +};
> +
> +/* Devices for Surface Laptop 3. */
> +static const struct software_node *ssam_node_group_sl3[] = {
> +	&ssam_node_root,
> +	NULL,
> +};
> +
> +/* Devices for Surface Laptop Go. */
> +static const struct software_node *ssam_node_group_slg1[] = {
> +	&ssam_node_root,
> +	NULL,
> +};
> +
> +/* Devices for Surface Pro 5. */
> +static const struct software_node *ssam_node_group_sp5[] = {
> +	&ssam_node_root,
> +	NULL,
> +};
> +
> +/* Devices for Surface Pro 6. */
> +static const struct software_node *ssam_node_group_sp6[] = {
> +	&ssam_node_root,
> +	NULL,
> +};
> +
> +/* Devices for Surface Pro 7. */
> +static const struct software_node *ssam_node_group_sp7[] = {
> +	&ssam_node_root,
> +	NULL,
> +};
> +
> +
> +/* -- Device registry helper functions. ------------------------------------- */
> +
> +static int ssam_uid_from_string(const char *str, struct ssam_device_uid *uid)
> +{
> +	u8 d, tc, tid, iid, fn;
> +	int n;
> +
> +	n = sscanf(str, "ssam:%hhx:%hhx:%hhx:%hhx:%hhx", &d, &tc, &tid, &iid, &fn);
> +	if (n != 5)
> +		return -EINVAL;
> +
> +	uid->domain = d;
> +	uid->category = tc;
> +	uid->target = tid;
> +	uid->instance = iid;
> +	uid->function = fn;
> +
> +	return 0;
> +}
> +
> +static int ssam_hub_remove_devices_fn(struct device *dev, void *data)
> +{
> +	if (!is_ssam_device(dev))
> +		return 0;
> +
> +	ssam_device_remove(to_ssam_device(dev));
> +	return 0;
> +}
> +
> +static void ssam_hub_remove_devices(struct device *parent)
> +{
> +	device_for_each_child_reverse(parent, NULL, ssam_hub_remove_devices_fn);
> +}
> +
> +static int ssam_hub_add_device(struct device *parent, struct ssam_controller *ctrl,
> +			       struct fwnode_handle *node)
> +{
> +	struct ssam_device_uid uid;
> +	struct ssam_device *sdev;
> +	int status;
> +
> +	status = ssam_uid_from_string(fwnode_get_name(node), &uid);
> +	if (status)
> +		return status;
> +
> +	sdev = ssam_device_alloc(ctrl, uid);
> +	if (!sdev)
> +		return -ENOMEM;
> +
> +	sdev->dev.parent = parent;
> +	sdev->dev.fwnode = node;
> +
> +	status = ssam_device_add(sdev);
> +	if (status)
> +		ssam_device_put(sdev);
> +
> +	return status;
> +}
> +
> +static int ssam_hub_add_devices(struct device *parent, struct ssam_controller *ctrl,
> +				struct fwnode_handle *node)
> +{
> +	struct fwnode_handle *child;
> +	int status;
> +
> +	fwnode_for_each_child_node(node, child) {
> +		/*
> +		 * Try to add the device specified in the firmware node. If
> +		 * this fails with -EINVAL, the node does not specify any SSAM
> +		 * device, so ignore it and continue with the next one.
> +		 */
> +
> +		status = ssam_hub_add_device(parent, ctrl, child);
> +		if (status && status != -EINVAL)
> +			goto err;
> +	}
> +
> +	return 0;
> +err:
> +	ssam_hub_remove_devices(parent);
> +	return status;
> +}
> +
> +
> +/* -- SSAM platform/meta-hub driver. ---------------------------------------- */
> +
> +static const struct acpi_device_id ssam_platform_hub_match[] = {
> +	/* Surface Pro 4, 5, and 6 (OMBR < 0x10) */
> +	{ "MSHW0081", (unsigned long)ssam_node_group_sp5 },
> +
> +	/* Surface Pro 6 (OMBR >= 0x10) */
> +	{ "MSHW0111", (unsigned long)ssam_node_group_sp6 },
> +
> +	/* Surface Pro 7 */
> +	{ "MSHW0116", (unsigned long)ssam_node_group_sp7 },
> +
> +	/* Surface Book 2 */
> +	{ "MSHW0107", (unsigned long)ssam_node_group_sb2 },
> +
> +	/* Surface Book 3 */
> +	{ "MSHW0117", (unsigned long)ssam_node_group_sb3 },
> +
> +	/* Surface Laptop 1 */
> +	{ "MSHW0086", (unsigned long)ssam_node_group_sl1 },
> +
> +	/* Surface Laptop 2 */
> +	{ "MSHW0112", (unsigned long)ssam_node_group_sl2 },
> +
> +	/* Surface Laptop 3 (13", Intel) */
> +	{ "MSHW0114", (unsigned long)ssam_node_group_sl3 },
> +
> +	/* Surface Laptop 3 (15", AMD) */
> +	{ "MSHW0110", (unsigned long)ssam_node_group_sl3 },
> +
> +	/* Surface Laptop Go 1 */
> +	{ "MSHW0118", (unsigned long)ssam_node_group_slg1 },
> +
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, ssam_platform_hub_match);
> +
> +static int ssam_platform_hub_probe(struct platform_device *pdev)
> +{
> +	const struct software_node **nodes;
> +	struct ssam_controller *ctrl;
> +	struct fwnode_handle *root;
> +	int status;
> +
> +	nodes = (const struct software_node **)acpi_device_get_match_data(&pdev->dev);
> +	if (!nodes)
> +		return -ENODEV;
> +
> +	/*
> +	 * As we're adding the SSAM client devices as children under this device
> +	 * and not the SSAM controller, we need to add a device link to the
> +	 * controller to ensure that we remove all of our devices before the
> +	 * controller is removed. This also guarantees proper ordering for
> +	 * suspend/resume of the devices on this hub.
> +	 */
> +	ctrl = ssam_client_bind(&pdev->dev);
> +	if (IS_ERR(ctrl))
> +		return PTR_ERR(ctrl) == -ENODEV ? -EPROBE_DEFER : PTR_ERR(ctrl);
> +
> +	status = software_node_register_node_group(nodes);
> +	if (status)
> +		return status;
> +
> +	root = software_node_fwnode(&ssam_node_root);
> +	if (!root) {
> +		software_node_unregister_node_group(nodes);
> +		return -ENOENT;
> +	}
> +
> +	set_secondary_fwnode(&pdev->dev, root);
> +
> +	status = ssam_hub_add_devices(&pdev->dev, ctrl, root);
> +	if (status) {
> +		set_secondary_fwnode(&pdev->dev, NULL);
> +		software_node_unregister_node_group(nodes);
> +	}
> +
> +	platform_set_drvdata(pdev, nodes);
> +	return status;
> +}
> +
> +static int ssam_platform_hub_remove(struct platform_device *pdev)
> +{
> +	const struct software_node **nodes = platform_get_drvdata(pdev);
> +
> +	ssam_hub_remove_devices(&pdev->dev);
> +	set_secondary_fwnode(&pdev->dev, NULL);
> +	software_node_unregister_node_group(nodes);
> +	return 0;
> +}
> +
> +static struct platform_driver ssam_platform_hub_driver = {
> +	.probe = ssam_platform_hub_probe,
> +	.remove = ssam_platform_hub_remove,
> +	.driver = {
> +		.name = "surface_aggregator_platform_hub",
> +		.acpi_match_table = ssam_platform_hub_match,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +};
> +module_platform_driver(ssam_platform_hub_driver);
> +
> +MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
> +MODULE_DESCRIPTION("Device-registry for Surface System Aggregator Module");
> +MODULE_LICENSE("GPL");
> 
