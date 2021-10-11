Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C46942856A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 05:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbhJKDFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 23:05:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38751 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231966AbhJKDFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 23:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633921381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ep/IQjZzEUDaeX9b8N3ewSbHxeYltfMqeGu5JVcLuBA=;
        b=C4lLadh6UqRp8Nz2PHAd9UkVgvYA322gl8MqG0/0BiKSTbT/miKTbem97KymEwmr+esyJ8
        01vgy51ICfiIxvvZYMHPdu5Hk4UMMU/IlC61PcBhmi1/O0y9b6GoZjuhgpZRV24+fvfBTx
        s1Fa7RoRKCWFHTwgqldYWeSLGTgJGa4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-MYxhO66YNfGVx8GF6HzQpA-1; Sun, 10 Oct 2021 23:02:59 -0400
X-MC-Unique: MYxhO66YNfGVx8GF6HzQpA-1
Received: by mail-pl1-f199.google.com with SMTP id p2-20020a170902bd0200b0013da15f4ab0so7222613pls.7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 20:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ep/IQjZzEUDaeX9b8N3ewSbHxeYltfMqeGu5JVcLuBA=;
        b=SB0bT2AfM0erebw8VxFuGGwSGVi3iimNE9m60fmgTNF6mCCemBp8X3KC/ewNYQbvT4
         1uB2qna4DbfaC3LFu2eBv8MYVtCF/ipU1wYfchTdBxIV/Y+o1dxChiaC4ar1rBjSAnnM
         paXf4Sy8lubxFMKjgS7QiU4u6cDlRz/eWhjs1i4oGhSCS+DB7qUjAy1NEbtv5cusC/hP
         Gix82FZu+WWZLdJBTsk4sU4ojAAiRASdUk8f5ZdY4FlQCL55YP6n1KJUC0MlAu5Fh7mg
         vaSVThCKsJFljqSJr6rdhX95nORuuNoTViRmDQdtvvf9+7iWiYi+aVCdMSNC9flEpzKd
         AbLg==
X-Gm-Message-State: AOAM530wEkcGX095I0OBgPeE24CN7vLefMTXlYN/PxoaVo8NYPAxAgnN
        ub4LDpOrviDwrtGILmo2Ya7lYYVzfgaIbsu/BgjLonMfUE0nrDJ0wblvket/W+YjyeLr6Ml0+BQ
        ybA5D5gN1jganYxm9uw8n6Z6I
X-Received: by 2002:a17:902:e74a:b0:13f:3538:fca0 with SMTP id p10-20020a170902e74a00b0013f3538fca0mr4438673plf.22.1633921378051;
        Sun, 10 Oct 2021 20:02:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEsTVqtzKcpaLFRb/oOyLSfXXLORN55ZqgosVL8WudT2ITjI/dGae2/7vv9OSaC1LsR2BaSA==
X-Received: by 2002:a17:902:e74a:b0:13f:3538:fca0 with SMTP id p10-20020a170902e74a00b0013f3538fca0mr4438639plf.22.1633921377610;
        Sun, 10 Oct 2021 20:02:57 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o15sm5959453pfg.14.2021.10.10.20.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 20:02:57 -0700 (PDT)
Subject: Re: [PATCH v4 1/7] virtio-pci: introduce legacy device module
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com
Cc:     wei.yang1@linux.alibaba.com
References: <cover.1632313398.git.wuzongyong@linux.alibaba.com>
 <cover.1632882380.git.wuzongyong@linux.alibaba.com>
 <a068c730a0707d35afbbf72a5e0eb29f427f6045.1632882380.git.wuzongyong@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <faf8dfb5-43be-9939-85c7-7cc851740117@redhat.com>
Date:   Mon, 11 Oct 2021 11:02:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <a068c730a0707d35afbbf72a5e0eb29f427f6045.1632882380.git.wuzongyong@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/9/29 ÏÂÎç2:11, Wu Zongyong Ð´µÀ:
> Split common codes from virtio-pci-legacy so vDPA driver can reuse it
> later.
>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> ---
>   drivers/virtio/Kconfig                 |  10 ++
>   drivers/virtio/Makefile                |   1 +
>   drivers/virtio/virtio_pci_common.c     |  10 +-
>   drivers/virtio/virtio_pci_common.h     |   9 +-
>   drivers/virtio/virtio_pci_legacy.c     | 101 +++---------
>   drivers/virtio/virtio_pci_legacy_dev.c | 220 +++++++++++++++++++++++++
>   include/linux/virtio_pci_legacy.h      |  44 +++++
>   7 files changed, 312 insertions(+), 83 deletions(-)
>   create mode 100644 drivers/virtio/virtio_pci_legacy_dev.c
>   create mode 100644 include/linux/virtio_pci_legacy.h
>
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index ce1b3f6ec325..8fcf94cd2c96 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -20,6 +20,15 @@ config VIRTIO_PCI_LIB
>   	  PCI device with possible vendor specific extensions. Any
>   	  module that selects this module must depend on PCI.
>   
> +config VIRTIO_PCI_LIB_LEGACY
> +	tristate
> +	help
> +	  Legacy PCI device (Virtio PCI Card 0.9.x Draft and older device)
> +	  implementation.
> +	  This module implements the basic probe and control for devices
> +	  which are based on legacy PCI device. Any module that selects this
> +	  module must depend on PCI.
> +
>   menuconfig VIRTIO_MENU
>   	bool "Virtio drivers"
>   	default y
> @@ -43,6 +52,7 @@ config VIRTIO_PCI_LEGACY
>   	bool "Support for legacy virtio draft 0.9.X and older devices"
>   	default y
>   	depends on VIRTIO_PCI
> +	select VIRTIO_PCI_LIB_LEGACY
>   	help
>             Virtio PCI Card 0.9.X Draft (circa 2014) and older device support.
>   
> diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> index 699bbea0465f..0a82d0873248 100644
> --- a/drivers/virtio/Makefile
> +++ b/drivers/virtio/Makefile
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o
>   obj-$(CONFIG_VIRTIO_PCI_LIB) += virtio_pci_modern_dev.o
> +obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o
>   obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
>   obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
>   virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index b35bb2d57f62..d724f676608b 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -549,6 +549,8 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
>   
>   	pci_set_master(pci_dev);
>   
> +	vp_dev->is_legacy = vp_dev->ldev.ioaddr ? true : false;
> +
>   	rc = register_virtio_device(&vp_dev->vdev);
>   	reg_dev = vp_dev;
>   	if (rc)
> @@ -557,10 +559,10 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
>   	return 0;
>   
>   err_register:
> -	if (vp_dev->ioaddr)
> -	     virtio_pci_legacy_remove(vp_dev);
> +	if (vp_dev->is_legacy)
> +		virtio_pci_legacy_remove(vp_dev);
>   	else
> -	     virtio_pci_modern_remove(vp_dev);
> +		virtio_pci_modern_remove(vp_dev);
>   err_probe:
>   	pci_disable_device(pci_dev);
>   err_enable_device:
> @@ -587,7 +589,7 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
>   
>   	unregister_virtio_device(&vp_dev->vdev);
>   
> -	if (vp_dev->ioaddr)
> +	if (vp_dev->is_legacy)
>   		virtio_pci_legacy_remove(vp_dev);
>   	else
>   		virtio_pci_modern_remove(vp_dev);
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index beec047a8f8d..eb17a29fc7ef 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -25,6 +25,7 @@
>   #include <linux/virtio_config.h>
>   #include <linux/virtio_ring.h>
>   #include <linux/virtio_pci.h>
> +#include <linux/virtio_pci_legacy.h>
>   #include <linux/virtio_pci_modern.h>
>   #include <linux/highmem.h>
>   #include <linux/spinlock.h>
> @@ -44,16 +45,14 @@ struct virtio_pci_vq_info {
>   struct virtio_pci_device {
>   	struct virtio_device vdev;
>   	struct pci_dev *pci_dev;
> +	struct virtio_pci_legacy_device ldev;
>   	struct virtio_pci_modern_device mdev;
>   
> -	/* In legacy mode, these two point to within ->legacy. */
> +	bool is_legacy;
> +
>   	/* Where to read and clear interrupt */
>   	u8 __iomem *isr;
>   
> -	/* Legacy only field */
> -	/* the IO mapping for the PCI config space */
> -	void __iomem *ioaddr;
> -
>   	/* a list of queues so we can dispatch IRQs */
>   	spinlock_t lock;
>   	struct list_head virtqueues;
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index d62e9835aeec..82eb437ad920 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -14,6 +14,7 @@
>    *  Michael S. Tsirkin <mst@redhat.com>
>    */
>   
> +#include "linux/virtio_pci_legacy.h"
>   #include "virtio_pci_common.h"
>   
>   /* virtio config->get_features() implementation */
> @@ -23,7 +24,7 @@ static u64 vp_get_features(struct virtio_device *vdev)
>   
>   	/* When someone needs more than 32 feature bits, we'll need to
>   	 * steal a bit to indicate that the rest are somewhere else. */
> -	return ioread32(vp_dev->ioaddr + VIRTIO_PCI_HOST_FEATURES);
> +	return vp_legacy_get_features(&vp_dev->ldev);
>   }
>   
>   /* virtio config->finalize_features() implementation */
> @@ -38,7 +39,7 @@ static int vp_finalize_features(struct virtio_device *vdev)
>   	BUG_ON((u32)vdev->features != vdev->features);
>   
>   	/* We only support 32 feature bits. */
> -	iowrite32(vdev->features, vp_dev->ioaddr + VIRTIO_PCI_GUEST_FEATURES);
> +	vp_legacy_set_features(&vp_dev->ldev, vdev->features);
>   
>   	return 0;
>   }
> @@ -48,7 +49,7 @@ static void vp_get(struct virtio_device *vdev, unsigned offset,
>   		   void *buf, unsigned len)
>   {
>   	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> -	void __iomem *ioaddr = vp_dev->ioaddr +
> +	void __iomem *ioaddr = vp_dev->ldev.ioaddr +
>   			VIRTIO_PCI_CONFIG_OFF(vp_dev->msix_enabled) +
>   			offset;
>   	u8 *ptr = buf;
> @@ -64,7 +65,7 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
>   		   const void *buf, unsigned len)
>   {
>   	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> -	void __iomem *ioaddr = vp_dev->ioaddr +
> +	void __iomem *ioaddr = vp_dev->ldev.ioaddr +
>   			VIRTIO_PCI_CONFIG_OFF(vp_dev->msix_enabled) +
>   			offset;
>   	const u8 *ptr = buf;
> @@ -78,7 +79,7 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
>   static u8 vp_get_status(struct virtio_device *vdev)
>   {
>   	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> -	return ioread8(vp_dev->ioaddr + VIRTIO_PCI_STATUS);
> +	return vp_legacy_get_status(&vp_dev->ldev);
>   }
>   
>   static void vp_set_status(struct virtio_device *vdev, u8 status)
> @@ -86,28 +87,24 @@ static void vp_set_status(struct virtio_device *vdev, u8 status)
>   	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>   	/* We should never be setting status to 0. */
>   	BUG_ON(status == 0);
> -	iowrite8(status, vp_dev->ioaddr + VIRTIO_PCI_STATUS);
> +	vp_legacy_set_status(&vp_dev->ldev, status);
>   }
>   
>   static void vp_reset(struct virtio_device *vdev)
>   {
>   	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>   	/* 0 status means a reset. */
> -	iowrite8(0, vp_dev->ioaddr + VIRTIO_PCI_STATUS);
> +	vp_legacy_set_status(&vp_dev->ldev, 0);
>   	/* Flush out the status write, and flush in device writes,
>   	 * including MSi-X interrupts, if any. */
> -	ioread8(vp_dev->ioaddr + VIRTIO_PCI_STATUS);
> +	vp_legacy_get_status(&vp_dev->ldev);
>   	/* Flush pending VQ/configuration callbacks. */
>   	vp_synchronize_vectors(vdev);
>   }
>   
>   static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
>   {
> -	/* Setup the vector used for configuration events */
> -	iowrite16(vector, vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
> -	/* Verify we had enough resources to assign the vector */
> -	/* Will also flush the write out to device */
> -	return ioread16(vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
> +	return vp_legacy_config_vector(&vp_dev->ldev, vector);
>   }
>   
>   static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
> @@ -123,12 +120,9 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>   	int err;
>   	u64 q_pfn;
>   
> -	/* Select the queue we're interested in */
> -	iowrite16(index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
> -
>   	/* Check if queue is either not available or already active. */
> -	num = ioread16(vp_dev->ioaddr + VIRTIO_PCI_QUEUE_NUM);
> -	if (!num || ioread32(vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN))
> +	num = vp_legacy_get_queue_size(&vp_dev->ldev, index);
> +	if (!num || vp_legacy_get_queue_enable(&vp_dev->ldev, index))
>   		return ERR_PTR(-ENOENT);
>   
>   	info->msix_vector = msix_vec;
> @@ -151,13 +145,12 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>   	}
>   
>   	/* activate the queue */
> -	iowrite32(q_pfn, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
> +	vp_legacy_set_queue_address(&vp_dev->ldev, index, q_pfn);
>   
> -	vq->priv = (void __force *)vp_dev->ioaddr + VIRTIO_PCI_QUEUE_NOTIFY;
> +	vq->priv = (void __force *)vp_dev->ldev.ioaddr + VIRTIO_PCI_QUEUE_NOTIFY;
>   
>   	if (msix_vec != VIRTIO_MSI_NO_VECTOR) {
> -		iowrite16(msix_vec, vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
> -		msix_vec = ioread16(vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
> +		msix_vec = vp_legacy_queue_vector(&vp_dev->ldev, index, msix_vec);
>   		if (msix_vec == VIRTIO_MSI_NO_VECTOR) {
>   			err = -EBUSY;
>   			goto out_deactivate;
> @@ -167,7 +160,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>   	return vq;
>   
>   out_deactivate:
> -	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
> +	vp_legacy_set_queue_address(&vp_dev->ldev, index, 0);
>   out_del_vq:
>   	vring_del_virtqueue(vq);
>   	return ERR_PTR(err);
> @@ -178,17 +171,15 @@ static void del_vq(struct virtio_pci_vq_info *info)
>   	struct virtqueue *vq = info->vq;
>   	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
>   
> -	iowrite16(vq->index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
> -
>   	if (vp_dev->msix_enabled) {
> -		iowrite16(VIRTIO_MSI_NO_VECTOR,
> -			  vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
> +		vp_legacy_queue_vector(&vp_dev->ldev, vq->index,
> +				VIRTIO_MSI_NO_VECTOR);
>   		/* Flush the write out to device */
> -		ioread8(vp_dev->ioaddr + VIRTIO_PCI_ISR);
> +		ioread8(vp_dev->ldev.ioaddr + VIRTIO_PCI_ISR);
>   	}
>   
>   	/* Select and deactivate the queue */
> -	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
> +	vp_legacy_set_queue_address(&vp_dev->ldev, vq->index, 0);
>   
>   	vring_del_virtqueue(vq);
>   }
> @@ -211,51 +202,18 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
>   /* the PCI probing function */
>   int virtio_pci_legacy_probe(struct virtio_pci_device *vp_dev)
>   {
> +	struct virtio_pci_legacy_device *ldev = &vp_dev->ldev;
>   	struct pci_dev *pci_dev = vp_dev->pci_dev;
>   	int rc;
>   
> -	/* We only own devices >= 0x1000 and <= 0x103f: leave the rest. */
> -	if (pci_dev->device < 0x1000 || pci_dev->device > 0x103f)
> -		return -ENODEV;
> -
> -	if (pci_dev->revision != VIRTIO_PCI_ABI_VERSION) {
> -		printk(KERN_ERR "virtio_pci: expected ABI version %d, got %d\n",
> -		       VIRTIO_PCI_ABI_VERSION, pci_dev->revision);
> -		return -ENODEV;
> -	}
> -
> -	rc = dma_set_mask(&pci_dev->dev, DMA_BIT_MASK(64));
> -	if (rc) {
> -		rc = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(32));
> -	} else {
> -		/*
> -		 * The virtio ring base address is expressed as a 32-bit PFN,
> -		 * with a page size of 1 << VIRTIO_PCI_QUEUE_ADDR_SHIFT.
> -		 */
> -		dma_set_coherent_mask(&pci_dev->dev,
> -				DMA_BIT_MASK(32 + VIRTIO_PCI_QUEUE_ADDR_SHIFT));
> -	}
> -
> -	if (rc)
> -		dev_warn(&pci_dev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
> +	ldev->pci_dev = pci_dev;
>   
> -	rc = pci_request_region(pci_dev, 0, "virtio-pci-legacy");
> +	rc = vp_legacy_probe(ldev);
>   	if (rc)
>   		return rc;
>   
> -	rc = -ENOMEM;
> -	vp_dev->ioaddr = pci_iomap(pci_dev, 0, 0);
> -	if (!vp_dev->ioaddr)
> -		goto err_iomap;
> -
> -	vp_dev->isr = vp_dev->ioaddr + VIRTIO_PCI_ISR;
> -
> -	/* we use the subsystem vendor/device id as the virtio vendor/device
> -	 * id.  this allows us to use the same PCI vendor/device id for all
> -	 * virtio devices and to identify the particular virtio driver by
> -	 * the subsystem ids */
> -	vp_dev->vdev.id.vendor = pci_dev->subsystem_vendor;
> -	vp_dev->vdev.id.device = pci_dev->subsystem_device;
> +	vp_dev->isr = ldev->isr;
> +	vp_dev->vdev.id = ldev->id;
>   
>   	vp_dev->vdev.config = &virtio_pci_config_ops;
>   
> @@ -264,16 +222,11 @@ int virtio_pci_legacy_probe(struct virtio_pci_device *vp_dev)
>   	vp_dev->del_vq = del_vq;
>   
>   	return 0;
> -
> -err_iomap:
> -	pci_release_region(pci_dev, 0);
> -	return rc;
>   }
>   
>   void virtio_pci_legacy_remove(struct virtio_pci_device *vp_dev)
>   {
> -	struct pci_dev *pci_dev = vp_dev->pci_dev;
> +	struct virtio_pci_legacy_device *ldev = &vp_dev->ldev;
>   
> -	pci_iounmap(pci_dev, vp_dev->ioaddr);
> -	pci_release_region(pci_dev, 0);
> +	vp_legacy_remove(ldev);
>   }
> diff --git a/drivers/virtio/virtio_pci_legacy_dev.c b/drivers/virtio/virtio_pci_legacy_dev.c
> new file mode 100644
> index 000000000000..9b97680dd02b
> --- /dev/null
> +++ b/drivers/virtio/virtio_pci_legacy_dev.c
> @@ -0,0 +1,220 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include "linux/virtio_pci.h"
> +#include <linux/virtio_pci_legacy.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +
> +
> +/*
> + * vp_legacy_probe: probe the legacy virtio pci device, note that the
> + * caller is required to enable PCI device before calling this function.
> + * @ldev: the legacy virtio-pci device
> + *
> + * Return 0 on succeed otherwise fail
> + */
> +int vp_legacy_probe(struct virtio_pci_legacy_device *ldev)
> +{
> +	struct pci_dev *pci_dev = ldev->pci_dev;
> +	int rc;
> +
> +	/* We only own devices >= 0x1000 and <= 0x103f: leave the rest. */
> +	if (pci_dev->device < 0x1000 || pci_dev->device > 0x103f)
> +		return -ENODEV;
> +
> +	if (pci_dev->revision != VIRTIO_PCI_ABI_VERSION)
> +		return -ENODEV;
> +
> +	rc = dma_set_mask(&pci_dev->dev, DMA_BIT_MASK(64));
> +	if (rc) {
> +		rc = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(32));
> +	} else {
> +		/*
> +		 * The virtio ring base address is expressed as a 32-bit PFN,
> +		 * with a page size of 1 << VIRTIO_PCI_QUEUE_ADDR_SHIFT.
> +		 */
> +		dma_set_coherent_mask(&pci_dev->dev,
> +				DMA_BIT_MASK(32 + VIRTIO_PCI_QUEUE_ADDR_SHIFT));
> +	}
> +
> +	if (rc)
> +		dev_warn(&pci_dev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
> +
> +	rc = pci_request_region(pci_dev, 0, "virtio-pci-legacy");
> +	if (rc)
> +		return rc;
> +
> +	ldev->ioaddr = pci_iomap(pci_dev, 0, 0);
> +	if (!ldev->ioaddr)
> +		goto err_iomap;
> +
> +	ldev->isr = ldev->ioaddr + VIRTIO_PCI_ISR;
> +
> +	ldev->id.vendor = pci_dev->subsystem_vendor;
> +	ldev->id.device = pci_dev->subsystem_device;
> +
> +	return 0;
> +err_iomap:
> +	pci_release_region(pci_dev, 0);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(vp_legacy_probe);
> +
> +/*
> + * vp_legacy_probe: remove and cleanup the legacy virtio pci device
> + * @ldev: the legacy virtio-pci device
> + */
> +void vp_legacy_remove(struct virtio_pci_legacy_device *ldev)
> +{
> +	struct pci_dev *pci_dev = ldev->pci_dev;
> +
> +	pci_iounmap(pci_dev, ldev->ioaddr);
> +	pci_release_region(pci_dev, 0);
> +}
> +EXPORT_SYMBOL_GPL(vp_legacy_remove);
> +
> +/*
> + * vp_legacy_get_features - get features from device
> + * @ldev: the legacy virtio-pci device
> + *
> + * Returns the features read from the device
> + */
> +u64 vp_legacy_get_features(struct virtio_pci_legacy_device *ldev)
> +{
> +
> +	return ioread32(ldev->ioaddr + VIRTIO_PCI_HOST_FEATURES);
> +}
> +EXPORT_SYMBOL_GPL(vp_legacy_get_features);
> +
> +/*
> + * vp_legacy_get_driver_features - get driver features from device
> + * @ldev: the legacy virtio-pci device
> + *
> + * Returns the driver features read from the device
> + */
> +u64 vp_legacy_get_driver_features(struct virtio_pci_legacy_device *ldev)
> +{
> +	return ioread32(ldev->ioaddr + VIRTIO_PCI_GUEST_FEATURES);
> +}
> +EXPORT_SYMBOL_GPL(vp_legacy_get_driver_features);
> +
> +/*
> + * vp_legacy_set_features - set features to device
> + * @ldev: the legacy virtio-pci device
> + * @features: the features set to device
> + */
> +void vp_legacy_set_features(struct virtio_pci_legacy_device *ldev,
> +			    u32 features)
> +{
> +	iowrite32(features, ldev->ioaddr + VIRTIO_PCI_GUEST_FEATURES);
> +}
> +EXPORT_SYMBOL_GPL(vp_legacy_set_features);
> +
> +/*
> + * vp_legacy_get_status - get the device status
> + * @ldev: the legacy virtio-pci device
> + *
> + * Returns the status read from device
> + */
> +u8 vp_legacy_get_status(struct virtio_pci_legacy_device *ldev)
> +{
> +	return ioread8(ldev->ioaddr + VIRTIO_PCI_STATUS);
> +}
> +EXPORT_SYMBOL_GPL(vp_legacy_get_status);
> +
> +/*
> + * vp_legacy_set_status - set status to device
> + * @ldev: the legacy virtio-pci device
> + * @status: the status set to device
> + */
> +void vp_legacy_set_status(struct virtio_pci_legacy_device *ldev,
> +				 u8 status)
> +{
> +	iowrite8(status, ldev->ioaddr + VIRTIO_PCI_STATUS);
> +}
> +EXPORT_SYMBOL_GPL(vp_legacy_set_status);
> +
> +/*
> + * vp_legacy_queue_vector - set the MSIX vector for a specific virtqueue
> + * @ldev: the legacy virtio-pci device
> + * @index: queue index
> + * @vector: the config vector
> + *
> + * Returns the config vector read from the device
> + */
> +u16 vp_legacy_queue_vector(struct virtio_pci_legacy_device *ldev,
> +			   u16 index, u16 vector)
> +{
> +	iowrite16(index, ldev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
> +	iowrite16(vector, ldev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
> +	/* Flush the write out to device */
> +	return ioread16(ldev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
> +}
> +EXPORT_SYMBOL_GPL(vp_legacy_queue_vector);
> +
> +/*
> + * vp_legacy_config_vector - set the vector for config interrupt
> + * @ldev: the legacy virtio-pci device
> + * @vector: the config vector
> + *
> + * Returns the config vector read from the device
> + */
> +u16 vp_legacy_config_vector(struct virtio_pci_legacy_device *ldev,
> +			    u16 vector)
> +{
> +	/* Setup the vector used for configuration events */
> +	iowrite16(vector, ldev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
> +	/* Verify we had enough resources to assign the vector */
> +	/* Will also flush the write out to device */
> +	return ioread16(ldev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
> +}
> +EXPORT_SYMBOL_GPL(vp_legacy_config_vector);
> +
> +/*
> + * vp_legacy_set_queue_address - set the virtqueue address
> + * @ldev: the legacy virtio-pci device
> + * @index: the queue index
> + * @queue_pfn: pfn of the virtqueue
> + */
> +void vp_legacy_set_queue_address(struct virtio_pci_legacy_device *ldev,
> +			     u16 index, u32 queue_pfn)
> +{
> +	iowrite16(index, ldev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
> +	iowrite32(queue_pfn, ldev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
> +}
> +EXPORT_SYMBOL_GPL(vp_legacy_set_queue_address);
> +
> +/*
> + * vp_legacy_get_queue_enable - enable a virtqueue
> + * @ldev: the legacy virtio-pci device
> + * @index: the queue index
> + *
> + * Returns whether a virtqueue is enabled or not
> + */
> +bool vp_legacy_get_queue_enable(struct virtio_pci_legacy_device *ldev,
> +				u16 index)
> +{
> +	iowrite16(index, ldev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
> +	return ioread32(ldev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
> +}
> +EXPORT_SYMBOL_GPL(vp_legacy_get_queue_enable);
> +
> +/*
> + * vp_legacy_get_queue_size - get size for a virtqueue
> + * @ldev: the legacy virtio-pci device
> + * @index: the queue index
> + *
> + * Returns the size of the virtqueue
> + */
> +u16 vp_legacy_get_queue_size(struct virtio_pci_legacy_device *ldev,
> +			     u16 index)
> +{
> +	iowrite16(index, ldev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
> +	return ioread16(ldev->ioaddr + VIRTIO_PCI_QUEUE_NUM);
> +}
> +EXPORT_SYMBOL_GPL(vp_legacy_get_queue_size);
> +
> +MODULE_VERSION("0.1");
> +MODULE_DESCRIPTION("Legacy Virtio PCI Device");
> +MODULE_AUTHOR("Wu Zongyong <wuzongyong@linux.alibaba.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/virtio_pci_legacy.h b/include/linux/virtio_pci_legacy.h
> new file mode 100644
> index 000000000000..ee2c6157215f
> --- /dev/null
> +++ b/include/linux/virtio_pci_legacy.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_VIRTIO_PCI_LEGACY_H
> +#define _LINUX_VIRTIO_PCI_LEGACY_H
> +
> +#include "linux/mod_devicetable.h"
> +#include <linux/pci.h>
> +#include <linux/virtio_pci.h>
> +
> +struct virtio_pci_legacy_device {
> +	struct pci_dev *pci_dev;
> +
> +	/* Where to read and clear interrupt */
> +	u8 __iomem *isr;
> +	/* The IO mapping for the PCI config space (legacy mode only) */
> +	void __iomem *ioaddr;
> +
> +	struct virtio_device_id id;
> +};
> +
> +u64 vp_legacy_get_features(struct virtio_pci_legacy_device *ldev);
> +u64 vp_legacy_get_driver_features(struct virtio_pci_legacy_device *ldev);
> +void vp_legacy_set_features(struct virtio_pci_legacy_device *ldev,
> +			u32 features);
> +u8 vp_legacy_get_status(struct virtio_pci_legacy_device *ldev);
> +void vp_legacy_set_status(struct virtio_pci_legacy_device *ldev,
> +			u8 status);
> +u16 vp_legacy_queue_vector(struct virtio_pci_legacy_device *ldev,
> +			   u16 idx, u16 vector);
> +u16 vp_legacy_config_vector(struct virtio_pci_legacy_device *ldev,
> +		     u16 vector);
> +void vp_legacy_set_queue_address(struct virtio_pci_legacy_device *ldev,
> +			     u16 index, u32 queue_pfn);
> +void vp_legacy_set_queue_enable(struct virtio_pci_legacy_device *ldev,
> +				u16 idx, bool enable);


Just spot this. This is never defined in this patch?

Thanks


> +bool vp_legacy_get_queue_enable(struct virtio_pci_legacy_device *ldev,
> +				u16 idx);
> +void vp_legacy_set_queue_size(struct virtio_pci_legacy_device *ldev,
> +			      u16 idx, u16 size);
> +u16 vp_legacy_get_queue_size(struct virtio_pci_legacy_device *ldev,
> +			     u16 idx);
> +int vp_legacy_probe(struct virtio_pci_legacy_device *ldev);
> +void vp_legacy_remove(struct virtio_pci_legacy_device *ldev);
> +
> +#endif

