Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D961931A5E1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 21:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhBLUPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 15:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhBLUOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 15:14:50 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1D7C061756
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 12:14:09 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id l23so329811otn.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 12:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZZ/qFAVDgY8Svc1qUsCFGH+l98jC0NuUQUyTSmwfjcA=;
        b=XsbP9ogSHJh96KKvAsaxsA9NffKY6/T9W6qIMaNmaaLKSUNM0rfSjgxhjytFuZZdq+
         X+Q6aFa4FE4ZDJPOD0RQtaZwFvO8wzRGl1Fer/SGFnPcJS+d4h3qajHZG3FMPInN9r9n
         OF0aw7rVK4QvtIpyjKbEdZXr+YroXghibdb81S6ec340BKpYespbUt994pe49iIRes2J
         xzWZggvr4YRrT5nUOmMQbpIuwTDf5U2ZYUKdMd9OlcyKMPZalZ0p84Yi6VYysIKY4lnH
         Ln4UYbkoW+KpzrBreDVRZWNNM5DBj2SYlz+YECnuWEOQ8Ku2/PAbs1dR1riBB0BWBoCS
         BMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ZZ/qFAVDgY8Svc1qUsCFGH+l98jC0NuUQUyTSmwfjcA=;
        b=htLtOvMDDhVWq3y/aiLfAm5b7eiQetw6g9r/yG5y7MtWSvhn5gFbOkBYVk9n1i4wsb
         YkZDGGQWaCCHC0669csPJjpJxjtBNwAhBN/9riXjE9Ad/+DVWkzvbZmaK2Hxoyih+Fye
         OSkn+l/moUAm1NViyBdfG3umZT2QDH6sWIram3N8lII69E0oOK8p5iQ5wK+vqF0vfieQ
         tHXrFi2PBCNhmVVLRsKQG2YlKGU3i2R6RamCQAYYsM6NV59VFsOUpRBUlVO6O83PlFZz
         cKIO557dg26H2M79eRFS/GtF9MFFE/z5+GQnYbxsaz8wRGOV0yvl8++IqOkD7nchgpZq
         lITg==
X-Gm-Message-State: AOAM530gF5e4A8k0mIxD5lDRaouVL9UXOk9vnYUslQ/rHRoh2DGHeBzW
        zD+5aqmQx7fkwJ76YpFnKjwBxNJkjms=
X-Google-Smtp-Source: ABdhPJzaYpvIhQYkSiHsOc8L12oKu9HQNecndskAKginHTwh0gUJf723NZVyCqyyWdxeaqQqX87grA==
X-Received: by 2002:a9d:74d7:: with SMTP id a23mr3185424otl.331.1613160848726;
        Fri, 12 Feb 2021 12:14:08 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h24sm1794922otl.50.2021.02.12.12.14.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Feb 2021 12:14:07 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 12 Feb 2021 12:14:05 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        lulu@redhat.com, sgarzare@redhat.com, rdunlap@infradead.org
Subject: Re: [PATCH V3 16/19] virtio-pci: introduce modern device module
Message-ID: <20210212201405.GA112742@roeck-us.net>
References: <20210104065503.199631-1-jasowang@redhat.com>
 <20210104065503.199631-17-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210104065503.199631-17-jasowang@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 02:55:00PM +0800, Jason Wang wrote:
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

I don't really see the point of having to enable VIRTIO_PCI_MODERN
because otherwise VIRTIO_PCI no longer works. If VIRTIO_PCI now
requires VIRTIO_PCI_MODERN, maybe it should select it instead of
depending on it ? Alternatively, you could just drop the new
configuration flag entirely and build virtio_pci_modern_dev.o with
VIRTIO_PCI. One doesn't work without the other anyway, after all.

Guenter

> ---
>  drivers/virtio/Kconfig                 |  10 +-
>  drivers/virtio/Makefile                |   1 +
>  drivers/virtio/virtio_pci_common.h     |  27 +-
>  drivers/virtio/virtio_pci_modern.c     | 617 -------------------------
>  drivers/virtio/virtio_pci_modern_dev.c | 599 ++++++++++++++++++++++++
>  include/linux/virtio_pci_modern.h      | 111 +++++
>  6 files changed, 721 insertions(+), 644 deletions(-)
>  create mode 100644 drivers/virtio/virtio_pci_modern_dev.c
>  create mode 100644 include/linux/virtio_pci_modern.h
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 7b41130d3f35..6b9b81f4b8c2 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -12,6 +12,14 @@ config ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
>  	  This option is selected if the architecture may need to enforce
>  	  VIRTIO_F_ACCESS_PLATFORM
>  
> +config VIRTIO_PCI_MODERN
> +	tristate "Modern Virtio PCI Device"
> +	depends on PCI
> +	help
> +	  Modern PCI device implementation. This module implements the
> +	  basic probe and control for devices which are based on modern
> +	  PCI device with possible vendor specific extensions.
> +
>  menuconfig VIRTIO_MENU
>  	bool "Virtio drivers"
>  	default y
> @@ -20,7 +28,7 @@ if VIRTIO_MENU
>  
>  config VIRTIO_PCI
>  	tristate "PCI driver for virtio devices"
> -	depends on PCI
> +	depends on VIRTIO_PCI_MODERN
>  	select VIRTIO
>  	help
>  	  This driver provides support for virtio based paravirtual device
> diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> index 591e6f72aa54..f097578aaa8f 100644
> --- a/drivers/virtio/Makefile
> +++ b/drivers/virtio/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o
> +obj-$(CONFIG_VIRTIO_PCI_MODERN) += virtio_pci_modern_dev.o
>  obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
>  obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
>  virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index f35ff5b6b467..beec047a8f8d 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -25,6 +25,7 @@
>  #include <linux/virtio_config.h>
>  #include <linux/virtio_ring.h>
>  #include <linux/virtio_pci.h>
> +#include <linux/virtio_pci_modern.h>
>  #include <linux/highmem.h>
>  #include <linux/spinlock.h>
>  
> @@ -39,32 +40,6 @@ struct virtio_pci_vq_info {
>  	unsigned msix_vector;
>  };
>  
> -struct virtio_pci_modern_device {
> -	struct pci_dev *pci_dev;
> -
> -	struct virtio_pci_common_cfg __iomem *common;
> -	/* Device-specific data (non-legacy mode)  */
> -	void __iomem *device;
> -	/* Base of vq notifications (non-legacy mode). */
> -	void __iomem *notify_base;
> -	/* Where to read and clear interrupt */
> -	u8 __iomem *isr;
> -
> -	/* So we can sanity-check accesses. */
> -	size_t notify_len;
> -	size_t device_len;
> -
> -	/* Capability for when we need to map notifications per-vq. */
> -	int notify_map_cap;
> -
> -	/* Multiply queue_notify_off by this value. (non-legacy mode). */
> -	u32 notify_offset_multiplier;
> -
> -	int modern_bars;
> -
> -	struct virtio_device_id id;
> -};
> -
>  /* Our device structure */
>  struct virtio_pci_device {
>  	struct virtio_device vdev;
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index a5e3a5e40323..fbd4ebc00eb6 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -19,158 +19,6 @@
>  #define VIRTIO_RING_NO_LEGACY
>  #include "virtio_pci_common.h"
>  
> -/*
> - * Type-safe wrappers for io accesses.
> - * Use these to enforce at compile time the following spec requirement:
> - *
> - * The driver MUST access each field using the “natural” access
> - * method, i.e. 32-bit accesses for 32-bit fields, 16-bit accesses
> - * for 16-bit fields and 8-bit accesses for 8-bit fields.
> - */
> -static inline u8 vp_ioread8(const u8 __iomem *addr)
> -{
> -	return ioread8(addr);
> -}
> -static inline u16 vp_ioread16 (const __le16 __iomem *addr)
> -{
> -	return ioread16(addr);
> -}
> -
> -static inline u32 vp_ioread32(const __le32 __iomem *addr)
> -{
> -	return ioread32(addr);
> -}
> -
> -static inline void vp_iowrite8(u8 value, u8 __iomem *addr)
> -{
> -	iowrite8(value, addr);
> -}
> -
> -static inline void vp_iowrite16(u16 value, __le16 __iomem *addr)
> -{
> -	iowrite16(value, addr);
> -}
> -
> -static inline void vp_iowrite32(u32 value, __le32 __iomem *addr)
> -{
> -	iowrite32(value, addr);
> -}
> -
> -static void vp_iowrite64_twopart(u64 val,
> -				 __le32 __iomem *lo, __le32 __iomem *hi)
> -{
> -	vp_iowrite32((u32)val, lo);
> -	vp_iowrite32(val >> 32, hi);
> -}
> -
> -/*
> - * vp_modern_map_capability - map a part of virtio pci capability
> - * @mdev: the modern virtio-pci device
> - * @off: offset of the capability
> - * @minlen: minimal length of the capability
> - * @align: align requirement
> - * @start: start from the capability
> - * @size: map size
> - * @len: the length that is actually mapped
> - *
> - * Returns the io address of for the part of the capability
> - */
> -void __iomem *vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
> -				       size_t minlen,
> -				       u32 align,
> -				       u32 start, u32 size,
> -				       size_t *len)
> -{
> -	struct pci_dev *dev = mdev->pci_dev;
> -	u8 bar;
> -	u32 offset, length;
> -	void __iomem *p;
> -
> -	pci_read_config_byte(dev, off + offsetof(struct virtio_pci_cap,
> -						 bar),
> -			     &bar);
> -	pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap, offset),
> -			     &offset);
> -	pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap, length),
> -			      &length);
> -
> -	if (length <= start) {
> -		dev_err(&dev->dev,
> -			"virtio_pci: bad capability len %u (>%u expected)\n",
> -			length, start);
> -		return NULL;
> -	}
> -
> -	if (length - start < minlen) {
> -		dev_err(&dev->dev,
> -			"virtio_pci: bad capability len %u (>=%zu expected)\n",
> -			length, minlen);
> -		return NULL;
> -	}
> -
> -	length -= start;
> -
> -	if (start + offset < offset) {
> -		dev_err(&dev->dev,
> -			"virtio_pci: map wrap-around %u+%u\n",
> -			start, offset);
> -		return NULL;
> -	}
> -
> -	offset += start;
> -
> -	if (offset & (align - 1)) {
> -		dev_err(&dev->dev,
> -			"virtio_pci: offset %u not aligned to %u\n",
> -			offset, align);
> -		return NULL;
> -	}
> -
> -	if (length > size)
> -		length = size;
> -
> -	if (len)
> -		*len = length;
> -
> -	if (minlen + offset < minlen ||
> -	    minlen + offset > pci_resource_len(dev, bar)) {
> -		dev_err(&dev->dev,
> -			"virtio_pci: map virtio %zu@%u "
> -			"out of range on bar %i length %lu\n",
> -			minlen, offset,
> -			bar, (unsigned long)pci_resource_len(dev, bar));
> -		return NULL;
> -	}
> -
> -	p = pci_iomap_range(dev, bar, offset, length);
> -	if (!p)
> -		dev_err(&dev->dev,
> -			"virtio_pci: unable to map virtio %u@%u on bar %i\n",
> -			length, offset, bar);
> -	return p;
> -}
> -
> -/*
> - * vp_modern_get_features - get features from device
> - * @mdev: the modern virtio-pci device
> - *
> - * Returns the features read from the device
> - */
> -static u64 vp_modern_get_features(struct virtio_pci_modern_device *mdev)
> -{
> -	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> -
> -	u64 features;
> -
> -	vp_iowrite32(0, &cfg->device_feature_select);
> -	features = vp_ioread32(&cfg->device_feature);
> -	vp_iowrite32(1, &cfg->device_feature_select);
> -	features |= ((u64)vp_ioread32(&cfg->device_feature) << 32);
> -
> -	return features;
> -}
> -
> -/* virtio config->get_features() implementation */
>  static u64 vp_get_features(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> @@ -188,149 +36,6 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
>  		__virtio_set_bit(vdev, VIRTIO_F_SR_IOV);
>  }
>  
> -/*
> - * vp_modern_set_features - set features to device
> - * @mdev: the modern virtio-pci device
> - * @features: the features set to device
> - */
> -static void vp_modern_set_features(struct virtio_pci_modern_device *mdev,
> -				   u64 features)
> -{
> -	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> -
> -	vp_iowrite32(0, &cfg->guest_feature_select);
> -	vp_iowrite32((u32)features, &cfg->guest_feature);
> -	vp_iowrite32(1, &cfg->guest_feature_select);
> -	vp_iowrite32(features >> 32, &cfg->guest_feature);
> -}
> -
> -/*
> - * vp_modern_queue_vector - set the MSIX vector for a specific virtqueue
> - * @mdev: the modern virtio-pci device
> - * @index: queue index
> - * @vector: the config vector
> - *
> - * Returns the config vector read from the device
> - */
> -static u16 vp_modern_queue_vector(struct virtio_pci_modern_device *mdev,
> -				  u16 index, u16 vector)
> -{
> -	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> -
> -	vp_iowrite16(index, &cfg->queue_select);
> -	vp_iowrite16(vector, &cfg->queue_msix_vector);
> -	/* Flush the write out to device */
> -	return vp_ioread16(&cfg->queue_msix_vector);
> -}
> -
> -/*
> - * vp_modern_queue_address - set the virtqueue address
> - * @mdev: the modern virtio-pci device
> - * @index: the queue index
> - * @desc_addr: address of the descriptor area
> - * @driver_addr: address of the driver area
> - * @device_addr: address of the device area
> - */
> -static void vp_modern_queue_address(struct virtio_pci_modern_device *mdev,
> -				    u16 index, u64 desc_addr, u64 driver_addr,
> -				    u64 device_addr)
> -{
> -	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> -
> -	vp_iowrite16(index, &cfg->queue_select);
> -
> -	vp_iowrite64_twopart(desc_addr, &cfg->queue_desc_lo,
> -			     &cfg->queue_desc_hi);
> -	vp_iowrite64_twopart(driver_addr, &cfg->queue_avail_lo,
> -			     &cfg->queue_avail_hi);
> -	vp_iowrite64_twopart(device_addr, &cfg->queue_used_lo,
> -			     &cfg->queue_used_hi);
> -}
> -
> -/*
> - * vp_modern_set_queue_enable - enable a virtqueue
> - * @mdev: the modern virtio-pci device
> - * @index: the queue index
> - * @enable: whether the virtqueue is enable or not
> - */
> -static void vp_modern_set_queue_enable(struct virtio_pci_modern_device *mdev,
> -				       u16 index, bool enable)
> -{
> -	vp_iowrite16(index, &mdev->common->queue_select);
> -	vp_iowrite16(enable, &mdev->common->queue_enable);
> -}
> -
> -/*
> - * vp_modern_get_queue_enable - enable a virtqueue
> - * @mdev: the modern virtio-pci device
> - * @index: the queue index
> - *
> - * Returns whether a virtqueue is enabled or not
> - */
> -static bool vp_modern_get_queue_enable(struct virtio_pci_modern_device *mdev,
> -				       u16 index)
> -{
> -	vp_iowrite16(index, &mdev->common->queue_select);
> -
> -	return vp_ioread16(&mdev->common->queue_enable);
> -}
> -
> -/*
> - * vp_modern_set_queue_size - set size for a virtqueue
> - * @mdev: the modern virtio-pci device
> - * @index: the queue index
> - * @size: the size of the virtqueue
> - */
> -static void vp_modern_set_queue_size(struct virtio_pci_modern_device *mdev,
> -				     u16 index, u16 size)
> -{
> -	vp_iowrite16(index, &mdev->common->queue_select);
> -	vp_iowrite16(size, &mdev->common->queue_size);
> -
> -}
> -
> -/*
> - * vp_modern_get_queue_size - get size for a virtqueue
> - * @mdev: the modern virtio-pci device
> - * @index: the queue index
> - *
> - * Returns the size of the virtqueue
> - */
> -static u16 vp_modern_get_queue_size(struct virtio_pci_modern_device *mdev,
> -				    u16 index)
> -{
> -	vp_iowrite16(index, &mdev->common->queue_select);
> -
> -	return vp_ioread16(&mdev->common->queue_size);
> -
> -}
> -
> -/*
> - * vp_modern_get_num_queues - get the number of virtqueues
> - * @mdev: the modern virtio-pci device
> - *
> - * Returns the number of virtqueues
> - */
> -static u16 vp_modern_get_num_queues(struct virtio_pci_modern_device *mdev)
> -{
> -	return vp_ioread16(&mdev->common->num_queues);
> -}
> -
> -/*
> - * vp_modern_get_queue_notify_off - get notification offset for a virtqueue
> - * @mdev: the modern virtio-pci device
> - * @index: the queue index
> - *
> - * Returns the notification offset for a virtqueue
> - */
> -static u16 vp_modern_get_queue_notify_off(struct virtio_pci_modern_device *mdev,
> -					  u16 index)
> -{
> -	vp_iowrite16(index, &mdev->common->queue_select);
> -
> -	return vp_ioread16(&mdev->common->queue_notify_off);
> -}
> -
>  /* virtio config->finalize_features() implementation */
>  static int vp_finalize_features(struct virtio_device *vdev)
>  {
> @@ -429,19 +134,6 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
>  	}
>  }
>  
> -/*
> - * vp_modern_generation - get the device genreation
> - * @mdev: the modern virtio-pci device
> - *
> - * Returns the genreation read from device
> - */
> -static u32 vp_modern_generation(struct virtio_pci_modern_device *mdev)
> -{
> -	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> -
> -	return vp_ioread8(&cfg->config_generation);
> -}
> -
>  static u32 vp_generation(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> @@ -449,19 +141,6 @@ static u32 vp_generation(struct virtio_device *vdev)
>  	return vp_modern_generation(&vp_dev->mdev);
>  }
>  
> -/*
> - * vp_modern_get_status - get the device status
> - * @mdev: the modern virtio-pci device
> - *
> - * Returns the status read from device
> - */
> -static u8 vp_modern_get_status(struct virtio_pci_modern_device *mdev)
> -{
> -	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> -
> -	return vp_ioread8(&cfg->device_status);
> -}
> -
>  /* config->{get,set}_status() implementations */
>  static u8 vp_get_status(struct virtio_device *vdev)
>  {
> @@ -470,19 +149,6 @@ static u8 vp_get_status(struct virtio_device *vdev)
>  	return vp_modern_get_status(&vp_dev->mdev);
>  }
>  
> -/*
> - * vp_modern_set_status - set status to device
> - * @mdev: the modern virtio-pci device
> - * @status: the status set to device
> - */
> -static void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
> -				 u8 status)
> -{
> -	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> -
> -	vp_iowrite8(status, &cfg->device_status);
> -}
> -
>  static void vp_set_status(struct virtio_device *vdev, u8 status)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> @@ -510,25 +176,6 @@ static void vp_reset(struct virtio_device *vdev)
>  	vp_synchronize_vectors(vdev);
>  }
>  
> -/*
> - * vp_modern_config_vector - set the vector for config interrupt
> - * @mdev: the modern virtio-pci device
> - * @vector: the config vector
> - *
> - * Returns the config vector read from the device
> - */
> -static u16 vp_modern_config_vector(struct virtio_pci_modern_device *mdev,
> -				   u16 vector)
> -{
> -	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> -
> -	/* Setup the vector used for configuration events */
> -	vp_iowrite16(vector, &cfg->msix_config);
> -	/* Verify we had enough resources to assign the vector */
> -	/* Will also flush the write out to device */
> -	return vp_ioread16(&cfg->msix_config);
> -}
> -
>  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
>  {
>  	return vp_modern_config_vector(&vp_dev->mdev, vector);
> @@ -789,253 +436,6 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
>  	.get_shm_region  = vp_get_shm_region,
>  };
>  
> -/**
> - * virtio_pci_find_capability - walk capabilities to find device info.
> - * @dev: the pci device
> - * @cfg_type: the VIRTIO_PCI_CAP_* value we seek
> - * @ioresource_types: IORESOURCE_MEM and/or IORESOURCE_IO.
> - * @bars: the bitmask of BARs
> - *
> - * Returns offset of the capability, or 0.
> - */
> -static inline int virtio_pci_find_capability(struct pci_dev *dev, u8 cfg_type,
> -					     u32 ioresource_types, int *bars)
> -{
> -	int pos;
> -
> -	for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
> -	     pos > 0;
> -	     pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
> -		u8 type, bar;
> -		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> -							 cfg_type),
> -				     &type);
> -		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> -							 bar),
> -				     &bar);
> -
> -		/* Ignore structures with reserved BAR values */
> -		if (bar > 0x5)
> -			continue;
> -
> -		if (type == cfg_type) {
> -			if (pci_resource_len(dev, bar) &&
> -			    pci_resource_flags(dev, bar) & ioresource_types) {
> -				*bars |= (1 << bar);
> -				return pos;
> -			}
> -		}
> -	}
> -	return 0;
> -}
> -
> -/* This is part of the ABI.  Don't screw with it. */
> -static inline void check_offsets(void)
> -{
> -	/* Note: disk space was harmed in compilation of this function. */
> -	BUILD_BUG_ON(VIRTIO_PCI_CAP_VNDR !=
> -		     offsetof(struct virtio_pci_cap, cap_vndr));
> -	BUILD_BUG_ON(VIRTIO_PCI_CAP_NEXT !=
> -		     offsetof(struct virtio_pci_cap, cap_next));
> -	BUILD_BUG_ON(VIRTIO_PCI_CAP_LEN !=
> -		     offsetof(struct virtio_pci_cap, cap_len));
> -	BUILD_BUG_ON(VIRTIO_PCI_CAP_CFG_TYPE !=
> -		     offsetof(struct virtio_pci_cap, cfg_type));
> -	BUILD_BUG_ON(VIRTIO_PCI_CAP_BAR !=
> -		     offsetof(struct virtio_pci_cap, bar));
> -	BUILD_BUG_ON(VIRTIO_PCI_CAP_OFFSET !=
> -		     offsetof(struct virtio_pci_cap, offset));
> -	BUILD_BUG_ON(VIRTIO_PCI_CAP_LENGTH !=
> -		     offsetof(struct virtio_pci_cap, length));
> -	BUILD_BUG_ON(VIRTIO_PCI_NOTIFY_CAP_MULT !=
> -		     offsetof(struct virtio_pci_notify_cap,
> -			      notify_off_multiplier));
> -	BUILD_BUG_ON(VIRTIO_PCI_COMMON_DFSELECT !=
> -		     offsetof(struct virtio_pci_common_cfg,
> -			      device_feature_select));
> -	BUILD_BUG_ON(VIRTIO_PCI_COMMON_DF !=
> -		     offsetof(struct virtio_pci_common_cfg, device_feature));
> -	BUILD_BUG_ON(VIRTIO_PCI_COMMON_GFSELECT !=
> -		     offsetof(struct virtio_pci_common_cfg,
> -			      guest_feature_select));
> -	BUILD_BUG_ON(VIRTIO_PCI_COMMON_GF !=
> -		     offsetof(struct virtio_pci_common_cfg, guest_feature));
> -	BUILD_BUG_ON(VIRTIO_PCI_COMMON_MSIX !=
> -		     offsetof(struct virtio_pci_common_cfg, msix_config));
> -	BUILD_BUG_ON(VIRTIO_PCI_COMMON_NUMQ !=
> -		     offsetof(struct virtio_pci_common_cfg, num_queues));
> -	BUILD_BUG_ON(VIRTIO_PCI_COMMON_STATUS !=
> -		     offsetof(struct virtio_pci_common_cfg, device_status));
> -	BUILD_BUG_ON(VIRTIO_PCI_COMMON_CFGGENERATION !=
> -		     offsetof(struct virtio_pci_common_cfg, config_generation));
> -	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_SELECT !=
> -		     offsetof(struct virtio_pci_common_cfg, queue_select));
> -	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_SIZE !=
> -		     offsetof(struct virtio_pci_common_cfg, queue_size));
> -	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_MSIX !=
> -		     offsetof(struct virtio_pci_common_cfg, queue_msix_vector));
> -	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_ENABLE !=
> -		     offsetof(struct virtio_pci_common_cfg, queue_enable));
> -	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_NOFF !=
> -		     offsetof(struct virtio_pci_common_cfg, queue_notify_off));
> -	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_DESCLO !=
> -		     offsetof(struct virtio_pci_common_cfg, queue_desc_lo));
> -	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_DESCHI !=
> -		     offsetof(struct virtio_pci_common_cfg, queue_desc_hi));
> -	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_AVAILLO !=
> -		     offsetof(struct virtio_pci_common_cfg, queue_avail_lo));
> -	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_AVAILHI !=
> -		     offsetof(struct virtio_pci_common_cfg, queue_avail_hi));
> -	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_USEDLO !=
> -		     offsetof(struct virtio_pci_common_cfg, queue_used_lo));
> -	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_USEDHI !=
> -		     offsetof(struct virtio_pci_common_cfg, queue_used_hi));
> -}
> -
> -/*
> - * vp_modern_probe: probe the modern virtio pci device, note that the
> - * caller is required to enable PCI device before calling this function.
> - * @mdev: the modern virtio-pci device
> - *
> - * Return 0 on succeed otherwise fail
> - */
> -static int vp_modern_probe(struct virtio_pci_modern_device *mdev)
> -{
> -	struct pci_dev *pci_dev = mdev->pci_dev;
> -	int err, common, isr, notify, device;
> -	u32 notify_length;
> -	u32 notify_offset;
> -
> -	check_offsets();
> -
> -	mdev->pci_dev = pci_dev;
> -
> -	/* We only own devices >= 0x1000 and <= 0x107f: leave the rest. */
> -	if (pci_dev->device < 0x1000 || pci_dev->device > 0x107f)
> -		return -ENODEV;
> -
> -	if (pci_dev->device < 0x1040) {
> -		/* Transitional devices: use the PCI subsystem device id as
> -		 * virtio device id, same as legacy driver always did.
> -		 */
> -		mdev->id.device = pci_dev->subsystem_device;
> -	} else {
> -		/* Modern devices: simply use PCI device id, but start from 0x1040. */
> -		mdev->id.device = pci_dev->device - 0x1040;
> -	}
> -	mdev->id.vendor = pci_dev->subsystem_vendor;
> -
> -	/* check for a common config: if not, use legacy mode (bar 0). */
> -	common = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_COMMON_CFG,
> -					    IORESOURCE_IO | IORESOURCE_MEM,
> -					    &mdev->modern_bars);
> -	if (!common) {
> -		dev_info(&pci_dev->dev,
> -			 "virtio_pci: leaving for legacy driver\n");
> -		return -ENODEV;
> -	}
> -
> -	/* If common is there, these should be too... */
> -	isr = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_ISR_CFG,
> -					 IORESOURCE_IO | IORESOURCE_MEM,
> -					 &mdev->modern_bars);
> -	notify = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_NOTIFY_CFG,
> -					    IORESOURCE_IO | IORESOURCE_MEM,
> -					    &mdev->modern_bars);
> -	if (!isr || !notify) {
> -		dev_err(&pci_dev->dev,
> -			"virtio_pci: missing capabilities %i/%i/%i\n",
> -			common, isr, notify);
> -		return -EINVAL;
> -	}
> -
> -	err = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(64));
> -	if (err)
> -		err = dma_set_mask_and_coherent(&pci_dev->dev,
> -						DMA_BIT_MASK(32));
> -	if (err)
> -		dev_warn(&pci_dev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
> -
> -	/* Device capability is only mandatory for devices that have
> -	 * device-specific configuration.
> -	 */
> -	device = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_DEVICE_CFG,
> -					    IORESOURCE_IO | IORESOURCE_MEM,
> -					    &mdev->modern_bars);
> -
> -	err = pci_request_selected_regions(pci_dev, mdev->modern_bars,
> -					   "virtio-pci-modern");
> -	if (err)
> -		return err;
> -
> -	err = -EINVAL;
> -	mdev->common = vp_modern_map_capability(mdev, common,
> -				      sizeof(struct virtio_pci_common_cfg), 4,
> -				      0, sizeof(struct virtio_pci_common_cfg),
> -				      NULL);
> -	if (!mdev->common)
> -		goto err_map_common;
> -	mdev->isr = vp_modern_map_capability(mdev, isr, sizeof(u8), 1,
> -					     0, 1,
> -					     NULL);
> -	if (!mdev->isr)
> -		goto err_map_isr;
> -
> -	/* Read notify_off_multiplier from config space. */
> -	pci_read_config_dword(pci_dev,
> -			      notify + offsetof(struct virtio_pci_notify_cap,
> -						notify_off_multiplier),
> -			      &mdev->notify_offset_multiplier);
> -	/* Read notify length and offset from config space. */
> -	pci_read_config_dword(pci_dev,
> -			      notify + offsetof(struct virtio_pci_notify_cap,
> -						cap.length),
> -			      &notify_length);
> -
> -	pci_read_config_dword(pci_dev,
> -			      notify + offsetof(struct virtio_pci_notify_cap,
> -						cap.offset),
> -			      &notify_offset);
> -
> -	/* We don't know how many VQs we'll map, ahead of the time.
> -	 * If notify length is small, map it all now.
> -	 * Otherwise, map each VQ individually later.
> -	 */
> -	if ((u64)notify_length + (notify_offset % PAGE_SIZE) <= PAGE_SIZE) {
> -		mdev->notify_base = vp_modern_map_capability(mdev, notify,
> -							     2, 2,
> -							     0, notify_length,
> -							     &mdev->notify_len);
> -		if (!mdev->notify_base)
> -			goto err_map_notify;
> -	} else {
> -		mdev->notify_map_cap = notify;
> -	}
> -
> -	/* Again, we don't know how much we should map, but PAGE_SIZE
> -	 * is more than enough for all existing devices.
> -	 */
> -	if (device) {
> -		mdev->device = vp_modern_map_capability(mdev, device, 0, 4,
> -							0, PAGE_SIZE,
> -							&mdev->device_len);
> -		if (!mdev->device)
> -			goto err_map_device;
> -	}
> -
> -	return 0;
> -
> -err_map_device:
> -	if (mdev->notify_base)
> -		pci_iounmap(pci_dev, mdev->notify_base);
> -err_map_notify:
> -	pci_iounmap(pci_dev, mdev->isr);
> -err_map_isr:
> -	pci_iounmap(pci_dev, mdev->common);
> -err_map_common:
> -	return err;
> -}
> -
>  /* the PCI probing function */
>  int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
>  {
> @@ -1063,23 +463,6 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
>  	return 0;
>  }
>  
> -/*
> - * vp_modern_probe: remove and cleanup the modern virtio pci device
> - * @mdev: the modern virtio-pci device
> - */
> -static void vp_modern_remove(struct virtio_pci_modern_device *mdev)
> -{
> -	struct pci_dev *pci_dev = mdev->pci_dev;
> -
> -	if (mdev->device)
> -		pci_iounmap(pci_dev, mdev->device);
> -	if (mdev->notify_base)
> -		pci_iounmap(pci_dev, mdev->notify_base);
> -	pci_iounmap(pci_dev, mdev->isr);
> -	pci_iounmap(pci_dev, mdev->common);
> -	pci_release_selected_regions(pci_dev, mdev->modern_bars);
> -}
> -
>  void virtio_pci_modern_remove(struct virtio_pci_device *vp_dev)
>  {
>  	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> new file mode 100644
> index 000000000000..cbd667496bb1
> --- /dev/null
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -0,0 +1,599 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/virtio_pci_modern.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +
> +/*
> + * vp_modern_map_capability - map a part of virtio pci capability
> + * @mdev: the modern virtio-pci device
> + * @off: offset of the capability
> + * @minlen: minimal length of the capability
> + * @align: align requirement
> + * @start: start from the capability
> + * @size: map size
> + * @len: the length that is actually mapped
> + *
> + * Returns the io address of for the part of the capability
> + */
> +void __iomem *vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
> +				       size_t minlen,
> +				       u32 align,
> +				       u32 start, u32 size,
> +				       size_t *len)
> +{
> +	struct pci_dev *dev = mdev->pci_dev;
> +	u8 bar;
> +	u32 offset, length;
> +	void __iomem *p;
> +
> +	pci_read_config_byte(dev, off + offsetof(struct virtio_pci_cap,
> +						 bar),
> +			     &bar);
> +	pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap, offset),
> +			     &offset);
> +	pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap, length),
> +			      &length);
> +
> +	if (length <= start) {
> +		dev_err(&dev->dev,
> +			"virtio_pci: bad capability len %u (>%u expected)\n",
> +			length, start);
> +		return NULL;
> +	}
> +
> +	if (length - start < minlen) {
> +		dev_err(&dev->dev,
> +			"virtio_pci: bad capability len %u (>=%zu expected)\n",
> +			length, minlen);
> +		return NULL;
> +	}
> +
> +	length -= start;
> +
> +	if (start + offset < offset) {
> +		dev_err(&dev->dev,
> +			"virtio_pci: map wrap-around %u+%u\n",
> +			start, offset);
> +		return NULL;
> +	}
> +
> +	offset += start;
> +
> +	if (offset & (align - 1)) {
> +		dev_err(&dev->dev,
> +			"virtio_pci: offset %u not aligned to %u\n",
> +			offset, align);
> +		return NULL;
> +	}
> +
> +	if (length > size)
> +		length = size;
> +
> +	if (len)
> +		*len = length;
> +
> +	if (minlen + offset < minlen ||
> +	    minlen + offset > pci_resource_len(dev, bar)) {
> +		dev_err(&dev->dev,
> +			"virtio_pci: map virtio %zu@%u "
> +			"out of range on bar %i length %lu\n",
> +			minlen, offset,
> +			bar, (unsigned long)pci_resource_len(dev, bar));
> +		return NULL;
> +	}
> +
> +	p = pci_iomap_range(dev, bar, offset, length);
> +	if (!p)
> +		dev_err(&dev->dev,
> +			"virtio_pci: unable to map virtio %u@%u on bar %i\n",
> +			length, offset, bar);
> +	return p;
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_map_capability);
> +
> +/**
> + * virtio_pci_find_capability - walk capabilities to find device info.
> + * @dev: the pci device
> + * @cfg_type: the VIRTIO_PCI_CAP_* value we seek
> + * @ioresource_types: IORESOURCE_MEM and/or IORESOURCE_IO.
> + * @bars: the bitmask of BARs
> + *
> + * Returns offset of the capability, or 0.
> + */
> +static inline int virtio_pci_find_capability(struct pci_dev *dev, u8 cfg_type,
> +					     u32 ioresource_types, int *bars)
> +{
> +	int pos;
> +
> +	for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
> +	     pos > 0;
> +	     pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
> +		u8 type, bar;
> +		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> +							 cfg_type),
> +				     &type);
> +		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> +							 bar),
> +				     &bar);
> +
> +		/* Ignore structures with reserved BAR values */
> +		if (bar > 0x5)
> +			continue;
> +
> +		if (type == cfg_type) {
> +			if (pci_resource_len(dev, bar) &&
> +			    pci_resource_flags(dev, bar) & ioresource_types) {
> +				*bars |= (1 << bar);
> +				return pos;
> +			}
> +		}
> +	}
> +	return 0;
> +}
> +
> +/* This is part of the ABI.  Don't screw with it. */
> +static inline void check_offsets(void)
> +{
> +	/* Note: disk space was harmed in compilation of this function. */
> +	BUILD_BUG_ON(VIRTIO_PCI_CAP_VNDR !=
> +		     offsetof(struct virtio_pci_cap, cap_vndr));
> +	BUILD_BUG_ON(VIRTIO_PCI_CAP_NEXT !=
> +		     offsetof(struct virtio_pci_cap, cap_next));
> +	BUILD_BUG_ON(VIRTIO_PCI_CAP_LEN !=
> +		     offsetof(struct virtio_pci_cap, cap_len));
> +	BUILD_BUG_ON(VIRTIO_PCI_CAP_CFG_TYPE !=
> +		     offsetof(struct virtio_pci_cap, cfg_type));
> +	BUILD_BUG_ON(VIRTIO_PCI_CAP_BAR !=
> +		     offsetof(struct virtio_pci_cap, bar));
> +	BUILD_BUG_ON(VIRTIO_PCI_CAP_OFFSET !=
> +		     offsetof(struct virtio_pci_cap, offset));
> +	BUILD_BUG_ON(VIRTIO_PCI_CAP_LENGTH !=
> +		     offsetof(struct virtio_pci_cap, length));
> +	BUILD_BUG_ON(VIRTIO_PCI_NOTIFY_CAP_MULT !=
> +		     offsetof(struct virtio_pci_notify_cap,
> +			      notify_off_multiplier));
> +	BUILD_BUG_ON(VIRTIO_PCI_COMMON_DFSELECT !=
> +		     offsetof(struct virtio_pci_common_cfg,
> +			      device_feature_select));
> +	BUILD_BUG_ON(VIRTIO_PCI_COMMON_DF !=
> +		     offsetof(struct virtio_pci_common_cfg, device_feature));
> +	BUILD_BUG_ON(VIRTIO_PCI_COMMON_GFSELECT !=
> +		     offsetof(struct virtio_pci_common_cfg,
> +			      guest_feature_select));
> +	BUILD_BUG_ON(VIRTIO_PCI_COMMON_GF !=
> +		     offsetof(struct virtio_pci_common_cfg, guest_feature));
> +	BUILD_BUG_ON(VIRTIO_PCI_COMMON_MSIX !=
> +		     offsetof(struct virtio_pci_common_cfg, msix_config));
> +	BUILD_BUG_ON(VIRTIO_PCI_COMMON_NUMQ !=
> +		     offsetof(struct virtio_pci_common_cfg, num_queues));
> +	BUILD_BUG_ON(VIRTIO_PCI_COMMON_STATUS !=
> +		     offsetof(struct virtio_pci_common_cfg, device_status));
> +	BUILD_BUG_ON(VIRTIO_PCI_COMMON_CFGGENERATION !=
> +		     offsetof(struct virtio_pci_common_cfg, config_generation));
> +	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_SELECT !=
> +		     offsetof(struct virtio_pci_common_cfg, queue_select));
> +	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_SIZE !=
> +		     offsetof(struct virtio_pci_common_cfg, queue_size));
> +	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_MSIX !=
> +		     offsetof(struct virtio_pci_common_cfg, queue_msix_vector));
> +	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_ENABLE !=
> +		     offsetof(struct virtio_pci_common_cfg, queue_enable));
> +	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_NOFF !=
> +		     offsetof(struct virtio_pci_common_cfg, queue_notify_off));
> +	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_DESCLO !=
> +		     offsetof(struct virtio_pci_common_cfg, queue_desc_lo));
> +	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_DESCHI !=
> +		     offsetof(struct virtio_pci_common_cfg, queue_desc_hi));
> +	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_AVAILLO !=
> +		     offsetof(struct virtio_pci_common_cfg, queue_avail_lo));
> +	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_AVAILHI !=
> +		     offsetof(struct virtio_pci_common_cfg, queue_avail_hi));
> +	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_USEDLO !=
> +		     offsetof(struct virtio_pci_common_cfg, queue_used_lo));
> +	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_USEDHI !=
> +		     offsetof(struct virtio_pci_common_cfg, queue_used_hi));
> +}
> +
> +/*
> + * vp_modern_probe: probe the modern virtio pci device, note that the
> + * caller is required to enable PCI device before calling this function.
> + * @mdev: the modern virtio-pci device
> + *
> + * Return 0 on succeed otherwise fail
> + */
> +int vp_modern_probe(struct virtio_pci_modern_device *mdev)
> +{
> +	struct pci_dev *pci_dev = mdev->pci_dev;
> +	int err, common, isr, notify, device;
> +	u32 notify_length;
> +	u32 notify_offset;
> +
> +	check_offsets();
> +
> +	mdev->pci_dev = pci_dev;
> +
> +	/* We only own devices >= 0x1000 and <= 0x107f: leave the rest. */
> +	if (pci_dev->device < 0x1000 || pci_dev->device > 0x107f)
> +		return -ENODEV;
> +
> +	if (pci_dev->device < 0x1040) {
> +		/* Transitional devices: use the PCI subsystem device id as
> +		 * virtio device id, same as legacy driver always did.
> +		 */
> +		mdev->id.device = pci_dev->subsystem_device;
> +	} else {
> +		/* Modern devices: simply use PCI device id, but start from 0x1040. */
> +		mdev->id.device = pci_dev->device - 0x1040;
> +	}
> +	mdev->id.vendor = pci_dev->subsystem_vendor;
> +
> +	/* check for a common config: if not, use legacy mode (bar 0). */
> +	common = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_COMMON_CFG,
> +					    IORESOURCE_IO | IORESOURCE_MEM,
> +					    &mdev->modern_bars);
> +	if (!common) {
> +		dev_info(&pci_dev->dev,
> +			 "virtio_pci: leaving for legacy driver\n");
> +		return -ENODEV;
> +	}
> +
> +	/* If common is there, these should be too... */
> +	isr = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_ISR_CFG,
> +					 IORESOURCE_IO | IORESOURCE_MEM,
> +					 &mdev->modern_bars);
> +	notify = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_NOTIFY_CFG,
> +					    IORESOURCE_IO | IORESOURCE_MEM,
> +					    &mdev->modern_bars);
> +	if (!isr || !notify) {
> +		dev_err(&pci_dev->dev,
> +			"virtio_pci: missing capabilities %i/%i/%i\n",
> +			common, isr, notify);
> +		return -EINVAL;
> +	}
> +
> +	err = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(64));
> +	if (err)
> +		err = dma_set_mask_and_coherent(&pci_dev->dev,
> +						DMA_BIT_MASK(32));
> +	if (err)
> +		dev_warn(&pci_dev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
> +
> +	/* Device capability is only mandatory for devices that have
> +	 * device-specific configuration.
> +	 */
> +	device = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_DEVICE_CFG,
> +					    IORESOURCE_IO | IORESOURCE_MEM,
> +					    &mdev->modern_bars);
> +
> +	err = pci_request_selected_regions(pci_dev, mdev->modern_bars,
> +					   "virtio-pci-modern");
> +	if (err)
> +		return err;
> +
> +	err = -EINVAL;
> +	mdev->common = vp_modern_map_capability(mdev, common,
> +				      sizeof(struct virtio_pci_common_cfg), 4,
> +				      0, sizeof(struct virtio_pci_common_cfg),
> +				      NULL);
> +	if (!mdev->common)
> +		goto err_map_common;
> +	mdev->isr = vp_modern_map_capability(mdev, isr, sizeof(u8), 1,
> +					     0, 1,
> +					     NULL);
> +	if (!mdev->isr)
> +		goto err_map_isr;
> +
> +	/* Read notify_off_multiplier from config space. */
> +	pci_read_config_dword(pci_dev,
> +			      notify + offsetof(struct virtio_pci_notify_cap,
> +						notify_off_multiplier),
> +			      &mdev->notify_offset_multiplier);
> +	/* Read notify length and offset from config space. */
> +	pci_read_config_dword(pci_dev,
> +			      notify + offsetof(struct virtio_pci_notify_cap,
> +						cap.length),
> +			      &notify_length);
> +
> +	pci_read_config_dword(pci_dev,
> +			      notify + offsetof(struct virtio_pci_notify_cap,
> +						cap.offset),
> +			      &notify_offset);
> +
> +	/* We don't know how many VQs we'll map, ahead of the time.
> +	 * If notify length is small, map it all now.
> +	 * Otherwise, map each VQ individually later.
> +	 */
> +	if ((u64)notify_length + (notify_offset % PAGE_SIZE) <= PAGE_SIZE) {
> +		mdev->notify_base = vp_modern_map_capability(mdev, notify,
> +							     2, 2,
> +							     0, notify_length,
> +							     &mdev->notify_len);
> +		if (!mdev->notify_base)
> +			goto err_map_notify;
> +	} else {
> +		mdev->notify_map_cap = notify;
> +	}
> +
> +	/* Again, we don't know how much we should map, but PAGE_SIZE
> +	 * is more than enough for all existing devices.
> +	 */
> +	if (device) {
> +		mdev->device = vp_modern_map_capability(mdev, device, 0, 4,
> +							0, PAGE_SIZE,
> +							&mdev->device_len);
> +		if (!mdev->device)
> +			goto err_map_device;
> +	}
> +
> +	return 0;
> +
> +err_map_device:
> +	if (mdev->notify_base)
> +		pci_iounmap(pci_dev, mdev->notify_base);
> +err_map_notify:
> +	pci_iounmap(pci_dev, mdev->isr);
> +err_map_isr:
> +	pci_iounmap(pci_dev, mdev->common);
> +err_map_common:
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_probe);
> +
> +/*
> + * vp_modern_probe: remove and cleanup the modern virtio pci device
> + * @mdev: the modern virtio-pci device
> + */
> +void vp_modern_remove(struct virtio_pci_modern_device *mdev)
> +{
> +	struct pci_dev *pci_dev = mdev->pci_dev;
> +
> +	if (mdev->device)
> +		pci_iounmap(pci_dev, mdev->device);
> +	if (mdev->notify_base)
> +		pci_iounmap(pci_dev, mdev->notify_base);
> +	pci_iounmap(pci_dev, mdev->isr);
> +	pci_iounmap(pci_dev, mdev->common);
> +	pci_release_selected_regions(pci_dev, mdev->modern_bars);
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_remove);
> +
> +/*
> + * vp_modern_get_features - get features from device
> + * @mdev: the modern virtio-pci device
> + *
> + * Returns the features read from the device
> + */
> +u64 vp_modern_get_features(struct virtio_pci_modern_device *mdev)
> +{
> +	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> +
> +	u64 features;
> +
> +	vp_iowrite32(0, &cfg->device_feature_select);
> +	features = vp_ioread32(&cfg->device_feature);
> +	vp_iowrite32(1, &cfg->device_feature_select);
> +	features |= ((u64)vp_ioread32(&cfg->device_feature) << 32);
> +
> +	return features;
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_get_features);
> +
> +/*
> + * vp_modern_set_features - set features to device
> + * @mdev: the modern virtio-pci device
> + * @features: the features set to device
> + */
> +void vp_modern_set_features(struct virtio_pci_modern_device *mdev,
> +			    u64 features)
> +{
> +	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> +
> +	vp_iowrite32(0, &cfg->guest_feature_select);
> +	vp_iowrite32((u32)features, &cfg->guest_feature);
> +	vp_iowrite32(1, &cfg->guest_feature_select);
> +	vp_iowrite32(features >> 32, &cfg->guest_feature);
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_set_features);
> +
> +/*
> + * vp_modern_generation - get the device genreation
> + * @mdev: the modern virtio-pci device
> + *
> + * Returns the genreation read from device
> + */
> +u32 vp_modern_generation(struct virtio_pci_modern_device *mdev)
> +{
> +	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> +
> +	return vp_ioread8(&cfg->config_generation);
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_generation);
> +
> +/*
> + * vp_modern_get_status - get the device status
> + * @mdev: the modern virtio-pci device
> + *
> + * Returns the status read from device
> + */
> +u8 vp_modern_get_status(struct virtio_pci_modern_device *mdev)
> +{
> +	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> +
> +	return vp_ioread8(&cfg->device_status);
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_get_status);
> +
> +/*
> + * vp_modern_set_status - set status to device
> + * @mdev: the modern virtio-pci device
> + * @status: the status set to device
> + */
> +void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
> +				 u8 status)
> +{
> +	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> +
> +	vp_iowrite8(status, &cfg->device_status);
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_set_status);
> +
> +/*
> + * vp_modern_queue_vector - set the MSIX vector for a specific virtqueue
> + * @mdev: the modern virtio-pci device
> + * @index: queue index
> + * @vector: the config vector
> + *
> + * Returns the config vector read from the device
> + */
> +u16 vp_modern_queue_vector(struct virtio_pci_modern_device *mdev,
> +			   u16 index, u16 vector)
> +{
> +	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> +
> +	vp_iowrite16(index, &cfg->queue_select);
> +	vp_iowrite16(vector, &cfg->queue_msix_vector);
> +	/* Flush the write out to device */
> +	return vp_ioread16(&cfg->queue_msix_vector);
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_queue_vector);
> +
> +/*
> + * vp_modern_config_vector - set the vector for config interrupt
> + * @mdev: the modern virtio-pci device
> + * @vector: the config vector
> + *
> + * Returns the config vector read from the device
> + */
> +u16 vp_modern_config_vector(struct virtio_pci_modern_device *mdev,
> +			    u16 vector)
> +{
> +	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> +
> +	/* Setup the vector used for configuration events */
> +	vp_iowrite16(vector, &cfg->msix_config);
> +	/* Verify we had enough resources to assign the vector */
> +	/* Will also flush the write out to device */
> +	return vp_ioread16(&cfg->msix_config);
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_config_vector);
> +
> +/*
> + * vp_modern_queue_address - set the virtqueue address
> + * @mdev: the modern virtio-pci device
> + * @index: the queue index
> + * @desc_addr: address of the descriptor area
> + * @driver_addr: address of the driver area
> + * @device_addr: address of the device area
> + */
> +void vp_modern_queue_address(struct virtio_pci_modern_device *mdev,
> +			     u16 index, u64 desc_addr, u64 driver_addr,
> +			     u64 device_addr)
> +{
> +	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> +
> +	vp_iowrite16(index, &cfg->queue_select);
> +
> +	vp_iowrite64_twopart(desc_addr, &cfg->queue_desc_lo,
> +			     &cfg->queue_desc_hi);
> +	vp_iowrite64_twopart(driver_addr, &cfg->queue_avail_lo,
> +			     &cfg->queue_avail_hi);
> +	vp_iowrite64_twopart(device_addr, &cfg->queue_used_lo,
> +			     &cfg->queue_used_hi);
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_queue_address);
> +
> +/*
> + * vp_modern_set_queue_enable - enable a virtqueue
> + * @mdev: the modern virtio-pci device
> + * @index: the queue index
> + * @enable: whether the virtqueue is enable or not
> + */
> +void vp_modern_set_queue_enable(struct virtio_pci_modern_device *mdev,
> +				u16 index, bool enable)
> +{
> +	vp_iowrite16(index, &mdev->common->queue_select);
> +	vp_iowrite16(enable, &mdev->common->queue_enable);
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_set_queue_enable);
> +
> +/*
> + * vp_modern_get_queue_enable - enable a virtqueue
> + * @mdev: the modern virtio-pci device
> + * @index: the queue index
> + *
> + * Returns whether a virtqueue is enabled or not
> + */
> +bool vp_modern_get_queue_enable(struct virtio_pci_modern_device *mdev,
> +				u16 index)
> +{
> +	vp_iowrite16(index, &mdev->common->queue_select);
> +
> +	return vp_ioread16(&mdev->common->queue_enable);
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_get_queue_enable);
> +
> +/*
> + * vp_modern_set_queue_size - set size for a virtqueue
> + * @mdev: the modern virtio-pci device
> + * @index: the queue index
> + * @size: the size of the virtqueue
> + */
> +void vp_modern_set_queue_size(struct virtio_pci_modern_device *mdev,
> +			      u16 index, u16 size)
> +{
> +	vp_iowrite16(index, &mdev->common->queue_select);
> +	vp_iowrite16(size, &mdev->common->queue_size);
> +
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_set_queue_size);
> +
> +/*
> + * vp_modern_get_queue_size - get size for a virtqueue
> + * @mdev: the modern virtio-pci device
> + * @index: the queue index
> + *
> + * Returns the size of the virtqueue
> + */
> +u16 vp_modern_get_queue_size(struct virtio_pci_modern_device *mdev,
> +			     u16 index)
> +{
> +	vp_iowrite16(index, &mdev->common->queue_select);
> +
> +	return vp_ioread16(&mdev->common->queue_size);
> +
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_get_queue_size);
> +
> +/*
> + * vp_modern_get_num_queues - get the number of virtqueues
> + * @mdev: the modern virtio-pci device
> + *
> + * Returns the number of virtqueues
> + */
> +u16 vp_modern_get_num_queues(struct virtio_pci_modern_device *mdev)
> +{
> +	return vp_ioread16(&mdev->common->num_queues);
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_get_num_queues);
> +
> +/*
> + * vp_modern_get_queue_notify_off - get notification offset for a virtqueue
> + * @mdev: the modern virtio-pci device
> + * @index: the queue index
> + *
> + * Returns the notification offset for a virtqueue
> + */
> +u16 vp_modern_get_queue_notify_off(struct virtio_pci_modern_device *mdev,
> +				   u16 index)
> +{
> +	vp_iowrite16(index, &mdev->common->queue_select);
> +
> +	return vp_ioread16(&mdev->common->queue_notify_off);
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_get_queue_notify_off);
> +
> +MODULE_VERSION("0.1");
> +MODULE_DESCRIPTION("Modern Virtio PCI Device");
> +MODULE_AUTHOR("Jason Wang <jasowang@redhat.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
> new file mode 100644
> index 000000000000..f26acbeec965
> --- /dev/null
> +++ b/include/linux/virtio_pci_modern.h
> @@ -0,0 +1,111 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_VIRTIO_PCI_MODERN_H
> +#define _LINUX_VIRTIO_PCI_MODERN_H
> +
> +#include <linux/pci.h>
> +#include <linux/virtio_pci.h>
> +
> +struct virtio_pci_modern_device {
> +	struct pci_dev *pci_dev;
> +
> +	struct virtio_pci_common_cfg __iomem *common;
> +	/* Device-specific data (non-legacy mode)  */
> +	void __iomem *device;
> +	/* Base of vq notifications (non-legacy mode). */
> +	void __iomem *notify_base;
> +	/* Where to read and clear interrupt */
> +	u8 __iomem *isr;
> +
> +	/* So we can sanity-check accesses. */
> +	size_t notify_len;
> +	size_t device_len;
> +
> +	/* Capability for when we need to map notifications per-vq. */
> +	int notify_map_cap;
> +
> +	/* Multiply queue_notify_off by this value. (non-legacy mode). */
> +	u32 notify_offset_multiplier;
> +
> +	int modern_bars;
> +
> +	struct virtio_device_id id;
> +};
> +
> +/*
> + * Type-safe wrappers for io accesses.
> + * Use these to enforce at compile time the following spec requirement:
> + *
> + * The driver MUST access each field using the “natural” access
> + * method, i.e. 32-bit accesses for 32-bit fields, 16-bit accesses
> + * for 16-bit fields and 8-bit accesses for 8-bit fields.
> + */
> +static inline u8 vp_ioread8(const u8 __iomem *addr)
> +{
> +	return ioread8(addr);
> +}
> +static inline u16 vp_ioread16 (const __le16 __iomem *addr)
> +{
> +	return ioread16(addr);
> +}
> +
> +static inline u32 vp_ioread32(const __le32 __iomem *addr)
> +{
> +	return ioread32(addr);
> +}
> +
> +static inline void vp_iowrite8(u8 value, u8 __iomem *addr)
> +{
> +	iowrite8(value, addr);
> +}
> +
> +static inline void vp_iowrite16(u16 value, __le16 __iomem *addr)
> +{
> +	iowrite16(value, addr);
> +}
> +
> +static inline void vp_iowrite32(u32 value, __le32 __iomem *addr)
> +{
> +	iowrite32(value, addr);
> +}
> +
> +static inline void vp_iowrite64_twopart(u64 val,
> +					__le32 __iomem *lo,
> +					__le32 __iomem *hi)
> +{
> +	vp_iowrite32((u32)val, lo);
> +	vp_iowrite32(val >> 32, hi);
> +}
> +
> +u64 vp_modern_get_features(struct virtio_pci_modern_device *mdev);
> +void vp_modern_set_features(struct virtio_pci_modern_device *mdev,
> +		     u64 features);
> +u32 vp_modern_generation(struct virtio_pci_modern_device *mdev);
> +u8 vp_modern_get_status(struct virtio_pci_modern_device *mdev);
> +void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
> +		   u8 status);
> +u16 vp_modern_queue_vector(struct virtio_pci_modern_device *mdev,
> +			   u16 idx, u16 vector);
> +u16 vp_modern_config_vector(struct virtio_pci_modern_device *mdev,
> +		     u16 vector);
> +void vp_modern_queue_address(struct virtio_pci_modern_device *mdev,
> +			     u16 index, u64 desc_addr, u64 driver_addr,
> +			     u64 device_addr);
> +void vp_modern_set_queue_enable(struct virtio_pci_modern_device *mdev,
> +				u16 idx, bool enable);
> +bool vp_modern_get_queue_enable(struct virtio_pci_modern_device *mdev,
> +				u16 idx);
> +void vp_modern_set_queue_size(struct virtio_pci_modern_device *mdev,
> +			      u16 idx, u16 size);
> +u16 vp_modern_get_queue_size(struct virtio_pci_modern_device *mdev,
> +			     u16 idx);
> +u16 vp_modern_get_num_queues(struct virtio_pci_modern_device *mdev);
> +u16 vp_modern_get_queue_notify_off(struct virtio_pci_modern_device *mdev,
> +				   u16 idx);
> +void __iomem *vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
> +				       size_t minlen,
> +				       u32 align,
> +				       u32 start, u32 size,
> +				       size_t *len);
> +int vp_modern_probe(struct virtio_pci_modern_device *mdev);
> +void vp_modern_remove(struct virtio_pci_modern_device *mdev);
> +#endif
