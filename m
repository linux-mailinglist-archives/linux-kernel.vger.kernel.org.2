Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7C232A50B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442281AbhCBLql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 06:46:41 -0500
Received: from foss.arm.com ([217.140.110.172]:49816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344596AbhCBLaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 06:30:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 663B01042;
        Tue,  2 Mar 2021 03:29:18 -0800 (PST)
Received: from [10.57.48.219] (unknown [10.57.48.219])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08EA73F73C;
        Tue,  2 Mar 2021 03:29:15 -0800 (PST)
Subject: Re: [RFC 02/13] driver core: Introduce MMIO configuration
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, robh+dt@kernel.org, ardb@kernel.org,
        hch@infradead.org, narmstrong@baylibre.com, dwmw2@infradead.org,
        linux@armlinux.org.uk, catalin.marinas@arm.com, arnd@arndb.de,
        will@kernel.org
References: <20210226140305.26356-1-nsaenzjulienne@suse.de>
 <20210226140305.26356-3-nsaenzjulienne@suse.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <644fd416-ab64-f1cc-ffb0-ea5649e3b600@arm.com>
Date:   Tue, 2 Mar 2021 11:29:10 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210226140305.26356-3-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-26 14:02, Nicolas Saenz Julienne wrote:
> Some devices might inadvertently sit on buses that don't support 64bit
> MMIO access, and need a mechanism to query these limitations without
> prejudice to other buses in the system (i.e. defaulting to 32bit access
> system wide isn't an option).
> 
> Introduce a new bus callback, 'mmio_configure(),' which will take care
> of populating the relevant device properties based on the bus'
> limitations.

Devil's advocate: there already exist workarounds for 8-bit and/or 
16-bit accesses not working in various places, does it make sense for a 
64-bit workaround to be so wildly different and disjoint?

> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>   arch/Kconfig               | 8 ++++++++
>   drivers/base/dd.c          | 6 ++++++
>   include/linux/device.h     | 3 +++
>   include/linux/device/bus.h | 3 +++
>   4 files changed, 20 insertions(+)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 2bb30673d8e6..ba7f246b6b9d 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1191,6 +1191,14 @@ config ARCH_SPLIT_ARG64
>   config ARCH_HAS_ELFCORE_COMPAT
>   	bool
>   
> +config ARCH_HAS_64BIT_MMIO_BROKEN
> +	bool
> +	depends on 64BIT

As mentioned previously, 32-bit systems may not need the overrides for 
kernel I/O accessors, but they could still need the same workarounds for 
the memory-mapping implications (if this is to be a proper generic 
mechanism).

> +	default n

Tip: it is always redundant to state that.

Robin.

> +	help
> +	   Arch might contain busses unable to perform 64bit mmio accessses on
> +	   an otherwise 64bit system.
> +
>   source "kernel/gcov/Kconfig"
>   
>   source "scripts/gcc-plugins/Kconfig"
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 9179825ff646..8086ce8f17a6 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -538,6 +538,12 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>   			goto probe_failed;
>   	}
>   
> +	if (dev->bus->mmio_configure) {
> +		ret = dev->bus->mmio_configure(dev);
> +		if (ret)
> +			goto probe_failed;
> +	}
> +
>   	if (driver_sysfs_add(dev)) {
>   		pr_err("%s: driver_sysfs_add(%s) failed\n",
>   		       __func__, dev_name(dev));
> diff --git a/include/linux/device.h b/include/linux/device.h
> index ba660731bd25..bd94aa0cbd72 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -553,6 +553,9 @@ struct device {
>   #ifdef CONFIG_DMA_OPS_BYPASS
>   	bool			dma_ops_bypass : 1;
>   #endif
> +#if defined(CONFIG_ARCH_HAS_64BIT_MMIO_BROKEN)
> +	bool			mmio_64bit_broken:1;
> +#endif
>   };
>   
>   /**
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index 1ea5e1d1545b..680dfc3b4744 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -59,6 +59,8 @@ struct fwnode_handle;
>    *		bus supports.
>    * @dma_configure:	Called to setup DMA configuration on a device on
>    *			this bus.
> + * @mmio_configure:	Called to setup MMIO configuration on a device on
> + *			this bus.
>    * @pm:		Power management operations of this bus, callback the specific
>    *		device driver's pm-ops.
>    * @iommu_ops:  IOMMU specific operations for this bus, used to attach IOMMU
> @@ -103,6 +105,7 @@ struct bus_type {
>   	int (*num_vf)(struct device *dev);
>   
>   	int (*dma_configure)(struct device *dev);
> +	int (*mmio_configure)(struct device *dev);
>   
>   	const struct dev_pm_ops *pm;
>   
> 
