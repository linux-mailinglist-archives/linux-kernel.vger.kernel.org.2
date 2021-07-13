Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A573C7A12
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 01:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbhGMX0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 19:26:34 -0400
Received: from foss.arm.com ([217.140.110.172]:53274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236702AbhGMX0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 19:26:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E28276D;
        Tue, 13 Jul 2021 16:23:40 -0700 (PDT)
Received: from [10.57.36.240] (unknown [10.57.36.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 240623F774;
        Tue, 13 Jul 2021 16:23:38 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] iommu: dart: Add DART iommu driver
To:     Sven Peter <sven@svenpeter.dev>, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        iommu@lists.linux-foundation.org, Alexander Graf <graf@amazon.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, r.czerwinski@pengutronix.de
References: <20210627143405.77298-1-sven@svenpeter.dev>
 <20210627143405.77298-4-sven@svenpeter.dev>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f3574c75-db2d-47fc-bda5-0f0f627fb524@arm.com>
Date:   Wed, 14 Jul 2021 00:23:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210627143405.77298-4-sven@svenpeter.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

^^ Nit: the subsystem style for the subject format should be 
"iommu/dart: Add..." - similarly on patch #1, which I just realised I 
missed (sorry!)

On 2021-06-27 15:34, Sven Peter wrote:
> Apple's new SoCs use iommus for almost all peripherals. These Device
> Address Resolution Tables must be setup before these peripherals can
> act as DMA masters.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>   MAINTAINERS                      |    1 +
>   drivers/iommu/Kconfig            |   15 +
>   drivers/iommu/Makefile           |    1 +
>   drivers/iommu/apple-dart-iommu.c | 1058 ++++++++++++++++++++++++++++++

I'd be inclined to drop "-iommu" from the filename, unless there's some 
other "apple-dart" functionality that might lead to a module name clash 
in future?

>   4 files changed, 1075 insertions(+)
>   create mode 100644 drivers/iommu/apple-dart-iommu.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 29e5541c8f21..c1ffaa56b5f9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1245,6 +1245,7 @@ M:	Sven Peter <sven@svenpeter.dev>
>   L:	iommu@lists.linux-foundation.org
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml
> +F:	drivers/iommu/apple-dart-iommu.c
>   
>   APPLE SMC DRIVER
>   M:	Henrik Rydberg <rydberg@bitmath.org>
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 1f111b399bca..87882c628b46 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -249,6 +249,21 @@ config SPAPR_TCE_IOMMU
>   	  Enables bits of IOMMU API required by VFIO. The iommu_ops
>   	  is not implemented as it is not necessary for VFIO.
>   
> +config IOMMU_APPLE_DART
> +	tristate "Apple DART IOMMU Support"
> +	depends on ARM64 || (COMPILE_TEST && !GENERIC_ATOMIC64)
> +	select IOMMU_API
> +	select IOMMU_IO_PGTABLE

This is redundant - the individual formats already select it.

> +	select IOMMU_IO_PGTABLE_LPAE
> +	default ARCH_APPLE
> +	help
> +	  Support for Apple DART (Device Address Resolution Table) IOMMUs
> +	  found in Apple ARM SoCs like the M1.
> +	  This IOMMU is required for most peripherals using DMA to access
> +	  the main memory.
> +
> +	  Say Y here if you are using an Apple SoC with a DART IOMMU.
> +
>   # ARM IOMMU support
>   config ARM_SMMU
>   	tristate "ARM Ltd. System MMU (SMMU) Support"
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index c0fb0ba88143..8c813f0ebc54 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -29,3 +29,4 @@ obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
>   obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
>   obj-$(CONFIG_IOMMU_SVA_LIB) += iommu-sva-lib.o io-pgfault.o
>   obj-$(CONFIG_SPRD_IOMMU) += sprd-iommu.o
> +obj-$(CONFIG_IOMMU_APPLE_DART) += apple-dart-iommu.o
> diff --git a/drivers/iommu/apple-dart-iommu.c b/drivers/iommu/apple-dart-iommu.c
> new file mode 100644
> index 000000000000..637ba6e7cef9
> --- /dev/null
> +++ b/drivers/iommu/apple-dart-iommu.c
> @@ -0,0 +1,1058 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Apple DART (Device Address Resolution Table) IOMMU driver
> + *
> + * Copyright (C) 2021 The Asahi Linux Contributors
> + *
> + * Based on arm/arm-smmu/arm-ssmu.c and arm/arm-smmu-v3/arm-smmu-v3.c
> + *  Copyright (C) 2013 ARM Limited
> + *  Copyright (C) 2015 ARM Limited
> + * and on exynos-iommu.c
> + *  Copyright (c) 2011,2016 Samsung Electronics Co., Ltd.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/dma-direct.h>

Oh, right, bus_dma_region. Fair enough :)

> +#include <linux/dma-iommu.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io-pgtable.h>
> +#include <linux/iopoll.h>
> +#include <linux/list.h>
> +#include <linux/lockdep.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_iommu.h>
> +#include <linux/of_platform.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/ratelimit.h>
> +#include <linux/slab.h>
> +#include <linux/pci.h>

Redundant duplicate

> +#define DART_MAX_STREAMS 16
> +#define DART_MAX_TTBR 4
> +
> +#define DART_STREAM_ALL 0xffff
> +
> +#define DART_PARAMS1 0x00
> +#define DART_PARAMS_PAGE_SHIFT GENMASK(27, 24)
> +
> +#define DART_PARAMS2 0x04
> +#define DART_PARAMS_BYPASS_SUPPORT BIT(0)
> +
> +#define DART_STREAM_COMMAND 0x20
> +#define DART_STREAM_COMMAND_BUSY BIT(2)
> +#define DART_STREAM_COMMAND_INVALIDATE BIT(20)
> +
> +#define DART_STREAM_SELECT 0x34
> +
> +#define DART_ERROR 0x40
> +#define DART_ERROR_STREAM GENMASK(27, 24)
> +#define DART_ERROR_CODE GENMASK(23, 0)
> +#define DART_ERROR_FLAG BIT(31)
> +#define DART_ERROR_READ_FAULT BIT(4)
> +#define DART_ERROR_WRITE_FAULT BIT(3)
> +#define DART_ERROR_NO_PTE BIT(2)
> +#define DART_ERROR_NO_PMD BIT(1)
> +#define DART_ERROR_NO_TTBR BIT(0)
> +
> +#define DART_CONFIG 0x60
> +#define DART_CONFIG_LOCK BIT(15)
> +
> +#define DART_STREAM_COMMAND_BUSY_TIMEOUT 100
> +
> +#define DART_STREAM_REMAP 0x80
> +
> +#define DART_ERROR_ADDR_HI 0x54
> +#define DART_ERROR_ADDR_LO 0x50
> +
> +#define DART_TCR(sid) (0x100 + 4 * (sid))
> +#define DART_TCR_TRANSLATE_ENABLE BIT(7)
> +#define DART_TCR_BYPASS0_ENABLE BIT(8)
> +#define DART_TCR_BYPASS1_ENABLE BIT(12)
> +
> +#define DART_TTBR(sid, idx) (0x200 + 16 * (sid) + 4 * (idx))
> +#define DART_TTBR_VALID BIT(31)
> +#define DART_TTBR_SHIFT 12
> +
> +/*
> + * Private structure associated with each DART device.
> + *
> + * @dev: device struct
> + * @regs: mapped MMIO region
> + * @irq: interrupt number, can be shared with other DARTs
> + * @clks: clocks associated with this DART
> + * @num_clks: number of @clks
> + * @lock: lock for @used_sids and hardware operations involving this dart
> + * @used_sids: bitmap of streams attached to a domain
> + * @pgsize: pagesize supported by this DART
> + * @supports_bypass: indicates if this DART supports bypass mode
> + * @force_bypass: force bypass mode due to pagesize mismatch?
> + * @sw_bypass_cpu_start: offset into cpu address space in software bypass mode
> + * @sw_bypass_dma_start: offset into dma address space in software bypass mode
> + * @sw_bypass_len: length of iova space in software bypass mode
> + * @iommu: iommu core device
> + */
> +struct apple_dart {
> +	struct device *dev;
> +
> +	void __iomem *regs;
> +
> +	int irq;
> +	struct clk_bulk_data *clks;
> +	int num_clks;
> +
> +	spinlock_t lock;
> +
> +	u32 used_sids;
> +	u32 pgsize;
> +
> +	u32 supports_bypass : 1;
> +	u32 force_bypass : 1;
> +
> +	u64 sw_bypass_cpu_start;
> +	u64 sw_bypass_dma_start;
> +	u64 sw_bypass_len;
> +
> +	struct iommu_device iommu;
> +};
> +
> +/*
> + * This structure is used to identify a single stream attached to a domain.
> + * It's used as a list inside that domain to be able to attach multiple
> + * streams to a single domain. Since multiple devices can use a single stream
> + * it additionally keeps track of how many devices are represented by this
> + * stream. Once that number reaches zero it is detached from the IOMMU domain
> + * and all translations from this stream are disabled.

That sounds a lot like something you should be doing properly with groups.

> + * @dart: DART instance to which this stream belongs
> + * @sid: stream id within the DART instance
> + * @num_devices: count of devices attached to this stream
> + * @stream_head: list head for the next stream
> + */
> +struct apple_dart_stream {
> +	struct apple_dart *dart;
> +	u32 sid;

What are the actual SID values like? If they're large and sparse then 
maybe a list makes sense, but if they're small and dense then an array 
hanging off the apple_dart structure itself might be more efficient. 
Given DART_MAX_STREAMS, I'm thinking the latter, and considerably so.

The impression I'm getting so far is that this seems conceptually a bit 
like arm-smmu with stream indexing.

> +	u32 num_devices;
> +
> +	struct list_head stream_head;
> +};
> +
> +/*
> + * This structure is attached to each iommu domain handled by a DART.
> + * A single domain is used to represent a single virtual address space.
> + * It is always allocated together with a page table.
> + *
> + * Streams are the smallest units the DART hardware can differentiate.
> + * These are pointed to the page table of a domain whenever a device is
> + * attached to it. A single stream can only be assigned to a single domain.
> + *
> + * Devices are assigned to at least a single and sometimes multiple individual
> + * streams (using the iommus property in the device tree). Multiple devices
> + * can theoretically be represented by the same stream, though this is usually
> + * not the case.
> + *
> + * We only keep track of streams here and just count how many devices are
> + * represented by each stream. When the last device is removed the whole stream
> + * is removed from the domain.
> + *
> + * @dart: pointer to the DART instance
> + * @pgtbl_ops: pagetable ops allocated by io-pgtable
> + * @type: domain type IOMMU_DOMAIN_IDENTITY_{IDENTITY,DMA,UNMANAGED,BLOCKED}
> + * @sw_bypass_cpu_start: offset into cpu address space in software bypass mode
> + * @sw_bypass_dma_start: offset into dma address space in software bypass mode
> + * @sw_bypass_len: length of iova space in software bypass mode
> + * @streams: list of streams attached to this domain
> + * @lock: spinlock for operations involving the list of streams
> + * @domain: core iommu domain pointer
> + */
> +struct apple_dart_domain {
> +	struct apple_dart *dart;
> +	struct io_pgtable_ops *pgtbl_ops;
> +
> +	unsigned int type;

Given that this is assigned from domain->type it appears to be redundant.

> +	u64 sw_bypass_cpu_start;
> +	u64 sw_bypass_dma_start;
> +	u64 sw_bypass_len;
> +
> +	struct list_head streams;

I'm staring to think this could just be a bitmap, in a u16 even.

> +
> +	spinlock_t lock;
> +
> +	struct iommu_domain domain;
> +};
> +
> +/*
> + * This structure is attached to devices with dev_iommu_priv_set() on of_xlate
> + * and contains a list of streams bound to this device as defined in the
> + * device tree. Multiple DART instances can be attached to a single device
> + * and each stream is identified by its stream id.
> + * It's usually reference by a pointer called *cfg.
> + *
> + * A dynamic array instead of a linked list is used here since in almost
> + * all cases a device will just be attached to a single stream and streams
> + * are never removed after they have been added.
> + *
> + * @num_streams: number of streams attached
> + * @streams: array of structs to identify attached streams and the device link
> + *           to the iommu
> + */
> +struct apple_dart_master_cfg {
> +	int num_streams;
> +	struct {
> +		struct apple_dart *dart;
> +		u32 sid;

Can't you use the fwspec for this?

> +		struct device_link *link;

Is it necessary to use stateless links, or could you use 
DL_FLAG_AUTOREMOVE_SUPPLIER and not have to keep track of them manually?

> +	} streams[];
> +};
> +
> +static struct platform_driver apple_dart_driver;
> +static const struct iommu_ops apple_dart_iommu_ops;
> +static const struct iommu_flush_ops apple_dart_tlb_ops;
> +
> +static struct apple_dart_domain *to_dart_domain(struct iommu_domain *dom)
> +{
> +	return container_of(dom, struct apple_dart_domain, domain);
> +}
> +
> +static void apple_dart_hw_enable_translation(struct apple_dart *dart, u16 sid)
> +{
> +	writel(DART_TCR_TRANSLATE_ENABLE, dart->regs + DART_TCR(sid));
> +}
> +
> +static void apple_dart_hw_disable_dma(struct apple_dart *dart, u16 sid)
> +{
> +	writel(0, dart->regs + DART_TCR(sid));
> +}
> +
> +static void apple_dart_hw_enable_bypass(struct apple_dart *dart, u16 sid)
> +{
> +	WARN_ON(!dart->supports_bypass);
> +	writel(DART_TCR_BYPASS0_ENABLE | DART_TCR_BYPASS1_ENABLE,
> +	       dart->regs + DART_TCR(sid));
> +}
> +
> +static void apple_dart_hw_set_ttbr(struct apple_dart *dart, u16 sid, u16 idx,
> +				   phys_addr_t paddr)
> +{
> +	writel(DART_TTBR_VALID | (paddr >> DART_TTBR_SHIFT),
> +	       dart->regs + DART_TTBR(sid, idx));
> +}
> +
> +static void apple_dart_hw_clear_ttbr(struct apple_dart *dart, u16 sid, u16 idx)
> +{
> +	writel(0, dart->regs + DART_TTBR(sid, idx));
> +}
> +
> +static void apple_dart_hw_clear_all_ttbrs(struct apple_dart *dart, u16 sid)
> +{
> +	int i;
> +
> +	for (i = 0; i < 4; ++i)
> +		apple_dart_hw_clear_ttbr(dart, sid, i);
> +}
> +
> +static int apple_dart_hw_stream_command(struct apple_dart *dart, u16 sid_bitmap,
> +					u32 command)
> +{
> +	unsigned long flags;
> +	int ret;
> +	u32 command_reg;
> +
> +	spin_lock_irqsave(&dart->lock, flags);
> +
> +	writel(sid_bitmap, dart->regs + DART_STREAM_SELECT);
> +	writel(command, dart->regs + DART_STREAM_COMMAND);
> +
> +	ret = readl_poll_timeout_atomic(
> +		dart->regs + DART_STREAM_COMMAND, command_reg,
> +		!(command_reg & DART_STREAM_COMMAND_BUSY), 1,
> +		DART_STREAM_COMMAND_BUSY_TIMEOUT);
> +
> +	spin_unlock_irqrestore(&dart->lock, flags);
> +
> +	if (ret) {
> +		dev_err(dart->dev,
> +			"busy bit did not clear after command %x for streams %x\n",
> +			command, sid_bitmap);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int apple_dart_hw_invalidate_tlb_global(struct apple_dart *dart)
> +{
> +	return apple_dart_hw_stream_command(dart, DART_STREAM_ALL,
> +					    DART_STREAM_COMMAND_INVALIDATE);
> +}
> +
> +static int apple_dart_hw_invalidate_tlb_stream(struct apple_dart *dart, u16 sid)
> +{
> +	return apple_dart_hw_stream_command(dart, 1 << sid,
> +					    DART_STREAM_COMMAND_INVALIDATE);
> +}
> +
> +static int apple_dart_hw_reset(struct apple_dart *dart)
> +{
> +	int sid;
> +	u32 config;
> +
> +	config = readl(dart->regs + DART_CONFIG);
> +	if (config & DART_CONFIG_LOCK) {
> +		dev_err(dart->dev, "DART is locked down until reboot: %08x\n",
> +			config);
> +		return -EINVAL;
> +	}
> +
> +	for (sid = 0; sid < DART_MAX_STREAMS; ++sid) {
> +		apple_dart_hw_disable_dma(dart, sid);
> +		apple_dart_hw_clear_all_ttbrs(dart, sid);
> +	}
> +
> +	/* restore stream identity map */
> +	writel(0x03020100, dart->regs + DART_STREAM_REMAP);
> +	writel(0x07060504, dart->regs + DART_STREAM_REMAP + 4);
> +	writel(0x0b0a0908, dart->regs + DART_STREAM_REMAP + 8);
> +	writel(0x0f0e0d0c, dart->regs + DART_STREAM_REMAP + 12);

Any hint of what the magic numbers mean?

> +	/* clear any pending errors before the interrupt is unmasked */
> +	writel(readl(dart->regs + DART_ERROR), dart->regs + DART_ERROR);
> +
> +	return apple_dart_hw_invalidate_tlb_global(dart);
> +}
> +
> +static void apple_dart_domain_flush_tlb(struct apple_dart_domain *domain)
> +{
> +	unsigned long flags;
> +	struct apple_dart_stream *stream;
> +	struct apple_dart *dart = domain->dart;
> +
> +	if (!dart)
> +		return;

Can that happen? Feels like it's probably a bug elsewhere if it could :/

> +	spin_lock_irqsave(&domain->lock, flags);
> +	list_for_each_entry(stream, &domain->streams, stream_head) {
> +		apple_dart_hw_invalidate_tlb_stream(stream->dart, stream->sid);
> +	}
> +	spin_unlock_irqrestore(&domain->lock, flags);
> +}
> +
> +static void apple_dart_flush_iotlb_all(struct iommu_domain *domain)
> +{
> +	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
> +
> +	apple_dart_domain_flush_tlb(dart_domain);
> +}
> +
> +static void apple_dart_iotlb_sync(struct iommu_domain *domain,
> +				  struct iommu_iotlb_gather *gather)
> +{
> +	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
> +
> +	apple_dart_domain_flush_tlb(dart_domain);
> +}
> +
> +static void apple_dart_iotlb_sync_map(struct iommu_domain *domain,
> +				      unsigned long iova, size_t size)
> +{
> +	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
> +
> +	apple_dart_domain_flush_tlb(dart_domain);
> +}
> +
> +static void apple_dart_tlb_flush_all(void *cookie)
> +{
> +	struct apple_dart_domain *domain = cookie;
> +
> +	apple_dart_domain_flush_tlb(domain);
> +}
> +
> +static void apple_dart_tlb_flush_walk(unsigned long iova, size_t size,
> +				      size_t granule, void *cookie)
> +{
> +	struct apple_dart_domain *domain = cookie;
> +
> +	apple_dart_domain_flush_tlb(domain);
> +}
> +
> +static const struct iommu_flush_ops apple_dart_tlb_ops = {
> +	.tlb_flush_all = apple_dart_tlb_flush_all,
> +	.tlb_flush_walk = apple_dart_tlb_flush_walk,
> +	.tlb_add_page = NULL,
> +};
> +
> +static phys_addr_t apple_dart_iova_to_phys(struct iommu_domain *domain,
> +					   dma_addr_t iova)
> +{
> +	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
> +	struct io_pgtable_ops *ops = dart_domain->pgtbl_ops;
> +
> +	if (domain->type == IOMMU_DOMAIN_IDENTITY &&
> +	    dart_domain->dart->supports_bypass)

That second check seems redundant - if you don't support bypass surely 
you shouldn't have allowed attaching an identity domain in the first 
place? And even if you fake one with a pagetable you shouldn't need to 
walk it, for obvious reasons ;)

TBH, dealing with identity domains in iova_to_phys at all irks me - it's 
largely due to dubious hacks in networking drivers which hopefully you 
should never have to deal with on M1 anyway, and either way it's not 
like they can't check the domain type themselves and save a pointless 
indirect call altogether :(

> +		return iova;
> +	if (!ops)
> +		return -ENODEV;
> +
> +	return ops->iova_to_phys(ops, iova);
> +}
> +
> +static int apple_dart_map(struct iommu_domain *domain, unsigned long iova,
> +			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
> +{
> +	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
> +	struct io_pgtable_ops *ops = dart_domain->pgtbl_ops;
> +
> +	if (!ops)
> +		return -ENODEV;
> +	if (prot & IOMMU_MMIO)
> +		return -EINVAL;
> +	if (prot & IOMMU_NOEXEC)
> +		return -EINVAL;

Hmm, I guess the usual expectation is just to ignore any prot flags you 
can't enforce - after all, some IOMMUs don't even have a notion of read 
or write permissions.

> +	return ops->map(ops, iova, paddr, size, prot, gfp);
> +}
> +
> +static size_t apple_dart_unmap(struct iommu_domain *domain, unsigned long iova,
> +			       size_t size, struct iommu_iotlb_gather *gather)
> +{
> +	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
> +	struct io_pgtable_ops *ops = dart_domain->pgtbl_ops;
> +
> +	if (!ops)
> +		return 0;

That should never legitimately happen, since no previous mapping could 
have succeeded either.

> +	return ops->unmap(ops, iova, size, gather);
> +}
> +
> +static int apple_dart_prepare_sw_bypass(struct apple_dart *dart,
> +					struct apple_dart_domain *dart_domain,
> +					struct device *dev)
> +{
> +	lockdep_assert_held(&dart_domain->lock);
> +
> +	if (dart->supports_bypass)
> +		return 0;
> +	if (dart_domain->type != IOMMU_DOMAIN_IDENTITY)
> +		return 0;
> +
> +	// use the bus region from the first attached dev for the bypass range
> +	if (!dart->sw_bypass_len) {
> +		const struct bus_dma_region *dma_rgn = dev->dma_range_map;
> +
> +		if (!dma_rgn)
> +			return -EINVAL;
> +
> +		dart->sw_bypass_len = dma_rgn->size;
> +		dart->sw_bypass_cpu_start = dma_rgn->cpu_start;
> +		dart->sw_bypass_dma_start = dma_rgn->dma_start;
> +	}
> +
> +	// ensure that we don't mix different bypass setups
> +	if (dart_domain->sw_bypass_len) {
> +		if (dart->sw_bypass_len != dart_domain->sw_bypass_len)
> +			return -EINVAL;
> +		if (dart->sw_bypass_cpu_start !=
> +		    dart_domain->sw_bypass_cpu_start)
> +			return -EINVAL;
> +		if (dart->sw_bypass_dma_start !=
> +		    dart_domain->sw_bypass_dma_start)
> +			return -EINVAL;
> +	} else {
> +		dart_domain->sw_bypass_len = dart->sw_bypass_len;
> +		dart_domain->sw_bypass_cpu_start = dart->sw_bypass_cpu_start;
> +		dart_domain->sw_bypass_dma_start = dart->sw_bypass_dma_start;
> +	}
> +
> +	return 0;
> +}
> +
> +static int apple_dart_domain_needs_pgtbl_ops(struct apple_dart *dart,
> +					     struct iommu_domain *domain)
> +{
> +	if (domain->type == IOMMU_DOMAIN_DMA)
> +		return 1;
> +	if (domain->type == IOMMU_DOMAIN_UNMANAGED)
> +		return 1;
> +	if (!dart->supports_bypass && domain->type == IOMMU_DOMAIN_IDENTITY)
> +		return 1;
> +	return 0;
> +}
> +
> +static int apple_dart_finalize_domain(struct iommu_domain *domain)
> +{
> +	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
> +	struct apple_dart *dart = dart_domain->dart;
> +	struct io_pgtable_cfg pgtbl_cfg;
> +
> +	lockdep_assert_held(&dart_domain->lock);
> +
> +	if (dart_domain->pgtbl_ops)
> +		return 0;
> +	if (!apple_dart_domain_needs_pgtbl_ops(dart, domain))
> +		return 0;
> +
> +	pgtbl_cfg = (struct io_pgtable_cfg){
> +		.pgsize_bitmap = dart->pgsize,
> +		.ias = 32,
> +		.oas = 36,
> +		.coherent_walk = 1,
> +		.tlb = &apple_dart_tlb_ops,
> +		.iommu_dev = dart->dev,
> +	};
> +
> +	dart_domain->pgtbl_ops =
> +		alloc_io_pgtable_ops(ARM_APPLE_DART, &pgtbl_cfg, domain);
> +	if (!dart_domain->pgtbl_ops)
> +		return -ENOMEM;
> +
> +	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
> +	domain->geometry.aperture_start = 0;
> +	domain->geometry.aperture_end = DMA_BIT_MASK(32);
> +	domain->geometry.force_aperture = true;
> +
> +	/*
> +	 * Some DARTs come without hardware bypass support but we may still
> +	 * be forced to use bypass mode (to e.g. allow kernels with 4K pages to
> +	 * boot). If we reach this point with an identity domain we have to setup
> +	 * bypass mode in software. This is done by creating a static pagetable
> +	 * for a linear map specified by dma-ranges in the device tree.
> +	 */
> +	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
> +		u64 offset;
> +		int ret;
> +
> +		for (offset = 0; offset < dart_domain->sw_bypass_len;
> +		     offset += dart->pgsize) {
> +			ret = dart_domain->pgtbl_ops->map(
> +				dart_domain->pgtbl_ops,
> +				dart_domain->sw_bypass_dma_start + offset,
> +				dart_domain->sw_bypass_cpu_start + offset,
> +				dart->pgsize, IOMMU_READ | IOMMU_WRITE,
> +				GFP_ATOMIC);
> +			if (ret < 0) {
> +				free_io_pgtable_ops(dart_domain->pgtbl_ops);
> +				dart_domain->pgtbl_ops = NULL;
> +				return -EINVAL;
> +			}
> +		}

Could you set up a single per-DART pagetable in prepare_sw_bypass (or 
even better at probe time if you think you're likely to need it) and 
just share that between all fake identity domains? That could be a 
follow-up optimisation, though.

> +	}
> +
> +	return 0;
> +}
> +
> +static void
> +apple_dart_stream_setup_translation(struct apple_dart_domain *domain,
> +				    struct apple_dart *dart, u32 sid)
> +{
> +	int i;
> +	struct io_pgtable_cfg *pgtbl_cfg =
> +		&io_pgtable_ops_to_pgtable(domain->pgtbl_ops)->cfg;
> +
> +	for (i = 0; i < pgtbl_cfg->apple_dart_cfg.n_ttbrs; ++i)
> +		apple_dart_hw_set_ttbr(dart, sid, i,
> +				       pgtbl_cfg->apple_dart_cfg.ttbr[i]);
> +	for (; i < DART_MAX_TTBR; ++i)
> +		apple_dart_hw_clear_ttbr(dart, sid, i);
> +
> +	apple_dart_hw_enable_translation(dart, sid);
> +	apple_dart_hw_invalidate_tlb_stream(dart, sid);
> +}
> +
> +static int apple_dart_attach_stream(struct apple_dart_domain *domain,
> +				    struct apple_dart *dart, u32 sid)
> +{
> +	unsigned long flags;
> +	struct apple_dart_stream *stream;
> +	int ret;
> +
> +	lockdep_assert_held(&domain->lock);
> +
> +	if (WARN_ON(dart->force_bypass &&
> +		    domain->type != IOMMU_DOMAIN_IDENTITY))
> +		return -EINVAL;

Ideally you shouldn't allow that to happen, but I guess if you have 
mixed capabilities afross different instances then in principle an 
unmanaged domain could still slip through. But then again a user of an 
unmanaged domain might be OK with using larger pages anyway. Either way 
I'm not sure it's worthy of a WARN (similarly below) since it doesn't 
represent a "this should never happen" condition if the user has got 
their hands on a VFIO driver and is mucking about, it's just a normal 
failure because you can't support the attachment.

> +	/*
> +	 * we can't mix and match DARTs that support bypass mode with those who don't
> +	 * because the iova space in fake bypass mode generally has an offset
> +	 */

Erm, something doesn't sound right there... IOMMU_DOMAIN_IDENTITY should 
be exactly what it says, regardless of how it's implemented. If you 
can't provide a true identity mapping then you're probably better off 
not pretending to support them in the first place.

> +	if (WARN_ON(domain->type == IOMMU_DOMAIN_IDENTITY &&
> +		    (domain->dart->supports_bypass != dart->supports_bypass)))
> +		return -EINVAL;
> +
> +	list_for_each_entry(stream, &domain->streams, stream_head) {
> +		if (stream->dart == dart && stream->sid == sid) {
> +			stream->num_devices++;
> +			return 0;
> +		}
> +	}
> +
> +	spin_lock_irqsave(&dart->lock, flags);
> +
> +	if (WARN_ON(dart->used_sids & BIT(sid))) {
> +		ret = -EINVAL;
> +		goto error;
> +	}
> +
> +	stream = kzalloc(sizeof(*stream), GFP_ATOMIC);
> +	if (!stream) {
> +		ret = -ENOMEM;
> +		goto error;
> +	}

Couldn't you do this outside the lock? (If, calling back to other 
comments, it can't get refactored out of existence anyway)

> +	stream->dart = dart;
> +	stream->sid = sid;
> +	stream->num_devices = 1;
> +	list_add(&stream->stream_head, &domain->streams);
> +
> +	dart->used_sids |= BIT(sid);
> +	spin_unlock_irqrestore(&dart->lock, flags);
> +
> +	apple_dart_hw_clear_all_ttbrs(stream->dart, stream->sid);
> +
> +	switch (domain->type) {
> +	case IOMMU_DOMAIN_IDENTITY:
> +		if (stream->dart->supports_bypass)
> +			apple_dart_hw_enable_bypass(stream->dart, stream->sid);
> +		else
> +			apple_dart_stream_setup_translation(
> +				domain, stream->dart, stream->sid);
> +		break;
> +	case IOMMU_DOMAIN_BLOCKED:
> +		apple_dart_hw_disable_dma(stream->dart, stream->sid);
> +		break;
> +	case IOMMU_DOMAIN_UNMANAGED:
> +	case IOMMU_DOMAIN_DMA:
> +		apple_dart_stream_setup_translation(domain, stream->dart,
> +						    stream->sid);
> +		break;
> +	}
> +
> +	return 0;
> +
> +error:
> +	spin_unlock_irqrestore(&dart->lock, flags);
> +	return ret;
> +}
> +
> +static void apple_dart_disable_stream(struct apple_dart *dart, u32 sid)
> +{
> +	unsigned long flags;
> +
> +	apple_dart_hw_disable_dma(dart, sid);
> +	apple_dart_hw_clear_all_ttbrs(dart, sid);
> +	apple_dart_hw_invalidate_tlb_stream(dart, sid);
> +
> +	spin_lock_irqsave(&dart->lock, flags);
> +	dart->used_sids &= ~BIT(sid);
> +	spin_unlock_irqrestore(&dart->lock, flags);
> +}
> +
> +static void apple_dart_detach_stream(struct apple_dart_domain *domain,
> +				     struct apple_dart *dart, u32 sid)
> +{
> +	struct apple_dart_stream *stream;
> +
> +	lockdep_assert_held(&domain->lock);
> +
> +	list_for_each_entry(stream, &domain->streams, stream_head) {
> +		if (stream->dart == dart && stream->sid == sid) {
> +			stream->num_devices--;
> +
> +			if (stream->num_devices == 0) {
> +				apple_dart_disable_stream(dart, sid);
> +				list_del(&stream->stream_head);
> +				kfree(stream);
> +			}
> +			return;
> +		}
> +	}
> +}
> +
> +static int apple_dart_attach_dev(struct iommu_domain *domain,
> +				 struct device *dev)
> +{
> +	int ret;
> +	int i, j;
> +	unsigned long flags;
> +	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
> +	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
> +	struct apple_dart *dart = cfg->streams[0].dart;
> +
> +	if (WARN_ON(dart->force_bypass &&
> +		    dart_domain->type != IOMMU_DOMAIN_IDENTITY)) {
> +		dev_warn(
> +			dev,
> +			"IOMMU must be in bypass mode but trying to attach to translated domain.\n");
> +		return -EINVAL;
> +	}

Again, a bit excessive with the warnings. In fact, transpose my comment 
from apple_dart_attach_stream() to here, because this means the 
equivalent warning there is literally unreachable :/

> +	spin_lock_irqsave(&dart_domain->lock, flags);
> +
> +	ret = apple_dart_prepare_sw_bypass(dart, dart_domain, dev);
> +	if (ret)
> +		goto out;
> +
> +	if (!dart_domain->dart)
> +		dart_domain->dart = dart;
> +
> +	ret = apple_dart_finalize_domain(domain);
> +	if (ret)
> +		goto out;
> +
> +	for (i = 0; i < cfg->num_streams; ++i) {
> +		ret = apple_dart_attach_stream(
> +			dart_domain, cfg->streams[i].dart, cfg->streams[i].sid);
> +		if (ret) {
> +			/* try to undo what we did before returning */
> +			for (j = 0; j < i; ++j)
> +				apple_dart_detach_stream(dart_domain,
> +							 cfg->streams[j].dart,
> +							 cfg->streams[j].sid);
> +
> +			goto out;
> +		}
> +	}
> +
> +	ret = 0;
> +
> +out:
> +	spin_unlock_irqrestore(&dart_domain->lock, flags);
> +	return ret;
> +}
> +
> +static void apple_dart_detach_dev(struct iommu_domain *domain,
> +				  struct device *dev)
> +{
> +	int i;
> +	unsigned long flags;
> +	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
> +	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
> +
> +	spin_lock_irqsave(&dart_domain->lock, flags);
> +
> +	for (i = 0; i < cfg->num_streams; ++i)
> +		apple_dart_detach_stream(dart_domain, cfg->streams[i].dart,
> +					 cfg->streams[i].sid);
> +
> +	spin_unlock_irqrestore(&dart_domain->lock, flags);
> +}
> +
> +static struct iommu_device *apple_dart_probe_device(struct device *dev)
> +{
> +	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
> +	int i;
> +
> +	if (!cfg)
> +		return ERR_PTR(-ENODEV);
> +
> +	for (i = 0; i < cfg->num_streams; ++i) {
> +		cfg->streams[i].link =
> +			device_link_add(dev, cfg->streams[i].dart->dev,
> +					DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
> +	}
> +
> +	return &cfg->streams[0].dart->iommu;
> +}
> +
> +static void apple_dart_release_device(struct device *dev)
> +{
> +	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
> +	int i;
> +
> +	if (!cfg)
> +		return;

Shouldn't happen - if it's disappeared since probe_device succeeded 
you've got bigger problems anyway.

> +
> +	for (i = 0; i < cfg->num_streams; ++i)
> +		device_link_del(cfg->streams[i].link);
> +
> +	dev_iommu_priv_set(dev, NULL);
> +	kfree(cfg);
> +}
> +
> +static struct iommu_domain *apple_dart_domain_alloc(unsigned int type)
> +{
> +	struct apple_dart_domain *dart_domain;
> +
> +	if (type != IOMMU_DOMAIN_DMA && type != IOMMU_DOMAIN_UNMANAGED &&
> +	    type != IOMMU_DOMAIN_IDENTITY && type != IOMMU_DOMAIN_BLOCKED)
> +		return NULL;

I want to say there's not much point in that, but then I realise I've 
spent the last couple of days writing patches to add a new domain type :)

> +	dart_domain = kzalloc(sizeof(*dart_domain), GFP_KERNEL);
> +	if (!dart_domain)
> +		return NULL;
> +
> +	INIT_LIST_HEAD(&dart_domain->streams);
> +	spin_lock_init(&dart_domain->lock);
> +	iommu_get_dma_cookie(&dart_domain->domain);
> +	dart_domain->type = type;

Yeah, this is "useful" for a handful of CPU cycles until we return and 
iommu_domain_alloc() sets dart_domain->domain->type to the same thing, 
all before *its* caller even knows the domain exists.

> +	return &dart_domain->domain;
> +}
> +
> +static void apple_dart_domain_free(struct iommu_domain *domain)
> +{
> +	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
> +
> +	WARN_ON(!list_empty(&dart_domain->streams));

Why? This code is perfectly legal API usage:

	d = iommu_domain_alloc(bus)
	if (d)
		iommu_domain_free(d);

Sure it looks pointless, but it's the kind of thing that can 
legitimately happen (with a lot more going on in between) if an 
unmanaged domain user tears itself down before it gets round to 
attaching, due to probe deferral or some other error condition.

> +	kfree(dart_domain);
> +}
> +
> +static int apple_dart_of_xlate(struct device *dev, struct of_phandle_args *args)
> +{
> +	struct platform_device *iommu_pdev = of_find_device_by_node(args->np);
> +	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
> +	unsigned int num_streams = cfg ? cfg->num_streams : 0;
> +	struct apple_dart_master_cfg *cfg_new;
> +	struct apple_dart *dart = platform_get_drvdata(iommu_pdev);
> +
> +	if (args->args_count != 1)
> +		return -EINVAL;
> +
> +	cfg_new = krealloc(cfg, struct_size(cfg, streams, num_streams + 1),
> +			   GFP_KERNEL);
> +	if (!cfg_new)
> +		return -ENOMEM;
> +
> +	cfg = cfg_new;
> +	dev_iommu_priv_set(dev, cfg);
> +
> +	cfg->num_streams = num_streams;
> +	cfg->streams[cfg->num_streams].dart = dart;
> +	cfg->streams[cfg->num_streams].sid = args->args[0];
> +	cfg->num_streams++;

Yeah, this is way too reminiscent of the fwspec code for comfort. Even 
if you can't use autoremove links for some reason, an array of 16 
device_link pointers hung off apple_dart still wins over these little 
pointer-heavy structures if you need more than a few of them.

> +	return 0;
> +}
> +
> +static struct iommu_group *apple_dart_device_group(struct device *dev)
> +{
> +#ifdef CONFIG_PCI
> +	struct iommu_group *group;
> +
> +	if (dev_is_pci(dev))
> +		group = pci_device_group(dev);
> +	else
> +		group = generic_device_group(dev);

...and this is where it gets bad :(

If you can have multiple devices behind the same stream such that the 
IOMMU can't tell them apart, you *have* to ensure they get put in the 
same group, so that the IOMMU core knows the topology (and reflects it 
correctly to userspace) and doesn't try to do things that then 
unexpectedly fail. This is the point where you need to check if a stream 
is already known, and return the existing group if so, and then you 
won't need to check and refcount all the time in attach/detach because 
the IOMMU core will do the right thing for you.

Many drivers only run on systems where devices don't alias at the IOMMU 
level (aliasing at the PCI level is already taken care of), or use a 
single group because effectively everything aliases, so it's not the 
most common scenario, but as I mentioned before arm-smmu is one that 
does - take a look at the flow though that in the "!smmu->smrs" cases 
for the closest example.

> +
> +	return group;
> +#else
> +	return generic_device_group(dev);
> +#endif
> +}
> +
> +static int apple_dart_def_domain_type(struct device *dev)
> +{
> +	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
> +	struct apple_dart *dart = cfg->streams[0].dart;
> +
> +	if (dart->force_bypass)
> +		return IOMMU_DOMAIN_IDENTITY;
> +	if (!dart->supports_bypass)
> +		return IOMMU_DOMAIN_DMA;
> +
> +	return 0;
> +}
> +
> +static const struct iommu_ops apple_dart_iommu_ops = {
> +	.domain_alloc = apple_dart_domain_alloc,
> +	.domain_free = apple_dart_domain_free,
> +	.attach_dev = apple_dart_attach_dev,
> +	.detach_dev = apple_dart_detach_dev,
> +	.map = apple_dart_map,
> +	.unmap = apple_dart_unmap,
> +	.flush_iotlb_all = apple_dart_flush_iotlb_all,
> +	.iotlb_sync = apple_dart_iotlb_sync,
> +	.iotlb_sync_map = apple_dart_iotlb_sync_map,
> +	.iova_to_phys = apple_dart_iova_to_phys,
> +	.probe_device = apple_dart_probe_device,
> +	.release_device = apple_dart_release_device,
> +	.device_group = apple_dart_device_group,
> +	.of_xlate = apple_dart_of_xlate,
> +	.def_domain_type = apple_dart_def_domain_type,
> +	.pgsize_bitmap = -1UL, /* Restricted during dart probe */
> +};
> +
> +static irqreturn_t apple_dart_irq(int irq, void *dev)
> +{
> +	struct apple_dart *dart = dev;
> +	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
> +				      DEFAULT_RATELIMIT_BURST);
> +	const char *fault_name = NULL;
> +	u32 error = readl(dart->regs + DART_ERROR);
> +	u32 error_code = FIELD_GET(DART_ERROR_CODE, error);
> +	u32 addr_lo = readl(dart->regs + DART_ERROR_ADDR_LO);
> +	u32 addr_hi = readl(dart->regs + DART_ERROR_ADDR_HI);
> +	u64 addr = addr_lo | (((u64)addr_hi) << 32);
> +	u8 stream_idx = FIELD_GET(DART_ERROR_STREAM, error);
> +
> +	if (!(error & DART_ERROR_FLAG))
> +		return IRQ_NONE;
> +
> +	if (error_code & DART_ERROR_READ_FAULT)
> +		fault_name = "READ FAULT";
> +	else if (error_code & DART_ERROR_WRITE_FAULT)
> +		fault_name = "WRITE FAULT";
> +	else if (error_code & DART_ERROR_NO_PTE)
> +		fault_name = "NO PTE FOR IOVA";
> +	else if (error_code & DART_ERROR_NO_PMD)
> +		fault_name = "NO PMD FOR IOVA";
> +	else if (error_code & DART_ERROR_NO_TTBR)
> +		fault_name = "NO TTBR FOR IOVA";

Can multiple bits be set at once or is there a strict precedence?

> +	if (WARN_ON(fault_name == NULL))

You're already logging a clear and attributable message below; I can 
guarantee that a big noisy backtrace showing that you got here from 
el0_irq() or el1_irq() is not useful over and above that.

> +		fault_name = "unknown";
> +
> +	if (__ratelimit(&rs)) {

Just use dev_err_ratelimited() to hide the guts if you're not doing 
anything tricky.

> +		dev_err(dart->dev,
> +			"translation fault: status:0x%x stream:%d code:0x%x (%s) at 0x%llx",
> +			error, stream_idx, error_code, fault_name, addr);
> +	}
> +
> +	writel(error, dart->regs + DART_ERROR);
> +	return IRQ_HANDLED;
> +}
> +
> +static int apple_dart_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	u32 dart_params[2];
> +	struct resource *res;
> +	struct apple_dart *dart;
> +	struct device *dev = &pdev->dev;
> +
> +	dart = devm_kzalloc(dev, sizeof(*dart), GFP_KERNEL);
> +	if (!dart)
> +		return -ENOMEM;
> +
> +	dart->dev = dev;
> +	spin_lock_init(&dart->lock);
> +
> +	if (pdev->num_resources < 1)
> +		return -ENODEV;

But you have 2 resources (one MEM and one IRQ)? And anyway their 
respective absences would hardly go unnoticed below.

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (resource_size(res) < 0x4000) {
> +		dev_err(dev, "MMIO region too small (%pr)\n", res);
> +		return -EINVAL;
> +	}
> +
> +	dart->regs = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(dart->regs))
> +		return PTR_ERR(dart->regs);
> +
> +	ret = devm_clk_bulk_get_all(dev, &dart->clks);
> +	if (ret < 0)
> +		return ret;
> +	dart->num_clks = ret;
> +
> +	ret = clk_bulk_prepare_enable(dart->num_clks, dart->clks);
> +	if (ret)
> +		return ret;
> +
> +	ret = apple_dart_hw_reset(dart);
> +	if (ret)
> +		goto err_clk_disable;
> +
> +	dart_params[0] = readl(dart->regs + DART_PARAMS1);
> +	dart_params[1] = readl(dart->regs + DART_PARAMS2);
> +	dart->pgsize = 1 << FIELD_GET(DART_PARAMS_PAGE_SHIFT, dart_params[0]);
> +	dart->supports_bypass = dart_params[1] & DART_PARAMS_BYPASS_SUPPORT;
> +	dart->force_bypass = dart->pgsize > PAGE_SIZE;
> +
> +	dart->irq = platform_get_irq(pdev, 0);
> +	if (dart->irq < 0) {
> +		ret = -ENODEV;
> +		goto err_clk_disable;
> +	}

FWIW I'd get the IRQ earlier when there's still nothing to clean up on 
failure - it's only the request which needs to wait until you've 
actually set up enough to be able to handle it if it does fire.

> +	ret = devm_request_irq(dart->dev, dart->irq, apple_dart_irq,
> +			       IRQF_SHARED, "apple-dart fault handler", dart);

Be verfy careful with this pattern of mixing devrers-managed IRQs with 
explicitly-managed clocks, especially when IRQF_SHARED is in play. In 
the failure path here, and in remove, you have a period where the clocks 
have been disabled but the IRQ is still live - try CONFIG_DEBUG_SHIRQ 
and don't be surprised if you deadlock trying to read an unclocked register.

If you can't also offload the clock management to devres to guarantee 
ordering relative to the IRQ (I think I saw some patches recently), it's 
probably safest to manually manage the latter.

> +	if (ret)
> +		goto err_clk_disable;
> +
> +	platform_set_drvdata(pdev, dart);
> +
> +	ret = iommu_device_sysfs_add(&dart->iommu, dev, NULL, "apple-dart.%s",
> +				     dev_name(&pdev->dev));
> +	if (ret)
> +		goto err_clk_disable;
> +
> +	ret = iommu_device_register(&dart->iommu, &apple_dart_iommu_ops, dev);
> +	if (ret)
> +		goto err_clk_disable;
> +
> +	if (dev->bus->iommu_ops != &apple_dart_iommu_ops) {
> +		ret = bus_set_iommu(dev->bus, &apple_dart_iommu_ops);
> +		if (ret)
> +			goto err_clk_disable;
> +	}
> +#ifdef CONFIG_PCI
> +	if (dev->bus->iommu_ops != pci_bus_type.iommu_ops) {

But it's still a platform device, not a PCI device?

> +		ret = bus_set_iommu(&pci_bus_type, &apple_dart_iommu_ops);
> +		if (ret)
> +			goto err_clk_disable;

And the platform bus ops?

> +	}
> +#endif
> +
> +	dev_info(
> +		&pdev->dev,
> +		"DART [pagesize %x, bypass support: %d, bypass forced: %d] initialized\n",
> +		dart->pgsize, dart->supports_bypass, dart->force_bypass);
> +	return 0;
> +
> +err_clk_disable:
> +	clk_bulk_disable(dart->num_clks, dart->clks);
> +	clk_bulk_unprepare(dart->num_clks, dart->clks);

No need to open-code clk_bulk_disable_unprepare() ;)

> +	return ret;
> +}
> +
> +static int apple_dart_remove(struct platform_device *pdev)
> +{
> +	struct apple_dart *dart = platform_get_drvdata(pdev);
> +
> +	devm_free_irq(dart->dev, dart->irq, dart);
> +
> +	iommu_device_unregister(&dart->iommu);
> +	iommu_device_sysfs_remove(&dart->iommu);
> +
> +	clk_bulk_disable(dart->num_clks, dart->clks);
> +	clk_bulk_unprepare(dart->num_clks, dart->clks);

Ditto.

And again the bus ops are still installed - that'll get really fun if 
this is a module unload...

> +	return 0;
> +}
> +
> +static void apple_dart_shutdown(struct platform_device *pdev)
> +{
> +	apple_dart_remove(pdev);

The main reason for doing somthing on shutdown is in the case of kexec, 
to put the hardware back into a disable or otherwise sane state so as 
not to trip up whatever the subsequent payload is. If you're not doing 
that (which may be legitimate if the expectation is that software must 
always fully reset and initialise a DART before I/O can work) then 
there's not much point in doing anything, really. Stuff like tidying up 
sysfs is a complete waste of time when the world's about to end ;)

Robin.

> +}
> +
> +static const struct of_device_id apple_dart_of_match[] = {
> +	{ .compatible = "apple,t8103-dart", .data = NULL },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, apple_dart_of_match);
> +
> +static struct platform_driver apple_dart_driver = {
> +	.driver	= {
> +		.name			= "apple-dart",
> +		.of_match_table		= apple_dart_of_match,
> +	},
> +	.probe	= apple_dart_probe,
> +	.remove	= apple_dart_remove,
> +	.shutdown = apple_dart_shutdown,
> +};
> +module_platform_driver(apple_dart_driver);
> +
> +MODULE_DESCRIPTION("IOMMU API for Apple's DART");
> +MODULE_AUTHOR("Sven Peter <sven@svenpeter.dev>");
> +MODULE_LICENSE("GPL v2");
> 
