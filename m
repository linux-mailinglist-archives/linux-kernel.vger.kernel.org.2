Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02361406961
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 11:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbhIJJ6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 05:58:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43398 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232094AbhIJJ6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 05:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631267842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+RW3L0saaCo99BrYe7kEmZaFBJyzHk5Vcs287sFcUTQ=;
        b=QOJG8KVZavlCwKiklPlyrDW7BaoWGoYZ2SdtsLc/ze9eFmfjyh4JTRapHFtSr8y1w/fnEn
        BxHmqprWcoGBu5MgnrQFBxk2o2Zs+BYup5JARkNiFpSrYxm7D+SaKUsbCXyA7hmNL9G6T4
        cTKImixbXTG2wPLkcPSZPtpzwUzIys4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-tpwGxLUwMgCUsTYjJR4JJQ-1; Fri, 10 Sep 2021 05:57:21 -0400
X-MC-Unique: tpwGxLUwMgCUsTYjJR4JJQ-1
Received: by mail-ed1-f69.google.com with SMTP id s15-20020a056402520f00b003cad788f1f6so615676edd.22
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 02:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+RW3L0saaCo99BrYe7kEmZaFBJyzHk5Vcs287sFcUTQ=;
        b=ucGK5JeuX5IC5YQGYUJleyMOiBlQUxZtZtCAz3iHOVDmzGMYKoIBLBrD5oOQ7UG4/C
         fLprTu1Gz+ydDrl1FY6cmCZ+mUV8IF6lbJ3WAIgA1b+6o+OIkTQ5/C9WdNNPmKfXTfGV
         Wqb798z2Vt0VA/EM4b4+SqX4MHTYuyWqOnr/gobZFRp78ccgK46v6rEJk+Pqmd1QHJEh
         nRlL1aa70P5/1BwyaL5WoYOqpWkafy81QmyFRFW0wFLSgKg/V4DJ4u7eOueEdJNpJgXs
         W+wUXv2Hbx/xNkPYVsc+p7CANz5io90ZyImlXHXnSuSN27awDLAPWqoGe4kCF3mmd8Ok
         k46w==
X-Gm-Message-State: AOAM530SL43Ly/2vZ2EcC/2qWyzvrb10zwBA+NVlfhLFWbsSkB4sUYfU
        y7A9U2BPvxzpWXKOWcgG2DeQJ10ntACReUug0HeWZHDM+4FD1a5XwU9CMf8FrLa9JodHdlLJYXI
        HI/E18/c9G/2TZGYdvp1/3swT
X-Received: by 2002:a17:906:c1d0:: with SMTP id bw16mr8568711ejb.146.1631267839990;
        Fri, 10 Sep 2021 02:57:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmdEwBgP1ot1/5szNtIE8nGf6caoMqUA3Y4Ncc4rXSj0IUNz2jH3f9uQqKHYVFkM9ujPXW9Q==
X-Received: by 2002:a17:906:c1d0:: with SMTP id bw16mr8568686ejb.146.1631267839713;
        Fri, 10 Sep 2021 02:57:19 -0700 (PDT)
Received: from redhat.com ([2.55.145.189])
        by smtp.gmail.com with ESMTPSA id w3sm2369267edc.42.2021.09.10.02.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 02:57:19 -0700 (PDT)
Date:   Fri, 10 Sep 2021 05:57:15 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, wei.yang1@linux.alibaba.com
Subject: Re: [PATCH 6/6] vp_vdpa: introduce legacy virtio pci driver
Message-ID: <20210910055510-mutt-send-email-mst@kernel.org>
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <8b084e5beb1111ad98bb64177ebd0e9845c178fa.1631101392.git.wuzongyong@linux.alibaba.com>
 <20210909095725-mutt-send-email-mst@kernel.org>
 <20210910022818.GB17535@L-PF27918B-1352.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910022818.GB17535@L-PF27918B-1352.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 10:28:18AM +0800, Wu Zongyong wrote:
> On Thu, Sep 09, 2021 at 09:57:50AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Sep 08, 2021 at 08:20:37PM +0800, Wu Zongyong wrote:
> > > This patch implements a vdpa driver for legacy virtio-pci device. And
> > > this has been tested with the ENI(Elastic Network Interface) which is a
> > > hardware virtio network device in Alibaba ECS baremetal instance.
> > > 
> > > Note that legacy device doesn't support to change the virtqueue size, so
> > > users should use get_vq_num_unchangeable callback to check if the
> > > virqueue size can be changed.
> > 
> > Hmm isn't this implicit in this being a legacy device?
> > 
> Yes, but there is no way to report the backend device is legacy for
> users. So I add a new callback get_vq_num_unchangeable to indicate it.

Legacy is actually easy. It does not have VIRTIO_F_VERSION_1.
Transitional devices with two interfaces are trickier.

These really need an ioctl so userspace can tell vdpa
whether it's being used through a legacy or modern interface.


> > > If not, users should get the virqueue size
> > > first by the get_vq_num_max callback first then allocate same size
> > > memory for the virtqueue otherwise the device won't work correctly.
> > > 
> > > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> > > ---
> > >  drivers/vdpa/Kconfig                     |   7 +
> > >  drivers/vdpa/virtio_pci/Makefile         |   1 +
> > >  drivers/vdpa/virtio_pci/vp_vdpa_common.c |   5 +
> > >  drivers/vdpa/virtio_pci/vp_vdpa_common.h |  11 +
> > >  drivers/vdpa/virtio_pci/vp_vdpa_legacy.c | 346 +++++++++++++++++++++++
> > >  5 files changed, 370 insertions(+)
> > >  create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa_legacy.c
> > > 
> > > diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> > > index a503c1b2bfd9..ccb4fdb11f0f 100644
> > > --- a/drivers/vdpa/Kconfig
> > > +++ b/drivers/vdpa/Kconfig
> > > @@ -67,4 +67,11 @@ config VP_VDPA
> > >  	help
> > >  	  This kernel module bridges virtio PCI device to vDPA bus.
> > >  
> > > +config VP_VDPA_LEGACY
> > > +	bool "Support legacy virtio pci device"
> > > +	depends on VP_VDPA
> > > +	select VIRTIO_PCI_LIB_LEGACY
> > > +	help
> > > +	  This option enables bridges legacy virito PCI device to vDPA bus.
> > > +
> > >  endif # VDPA
> > > diff --git a/drivers/vdpa/virtio_pci/Makefile b/drivers/vdpa/virtio_pci/Makefile
> > > index a772d86952b1..77c52dfb8b56 100644
> > > --- a/drivers/vdpa/virtio_pci/Makefile
> > > +++ b/drivers/vdpa/virtio_pci/Makefile
> > > @@ -1,4 +1,5 @@
> > >  # SPDX-License-Identifier: GPL-2.0
> > >  
> > >  vp_vdpa-y += vp_vdpa_common.o vp_vdpa_modern.o
> > > +vp_vdpa-$(CONFIG_VP_VDPA_LEGACY) += vp_vdpa_legacy.o
> > >  obj-$(CONFIG_VP_VDPA) += vp_vdpa.o
> > > diff --git a/drivers/vdpa/virtio_pci/vp_vdpa_common.c b/drivers/vdpa/virtio_pci/vp_vdpa_common.c
> > > index 3ff24c9ad6e4..fa91dc153244 100644
> > > --- a/drivers/vdpa/virtio_pci/vp_vdpa_common.c
> > > +++ b/drivers/vdpa/virtio_pci/vp_vdpa_common.c
> > > @@ -8,6 +8,7 @@
> > >   * Based on virtio_pci_modern.c.
> > >   */
> > >  
> > > +#include "linux/err.h"
> > >  #include <linux/irqreturn.h>
> > >  #include <linux/interrupt.h>
> > >  #include "vp_vdpa_common.h"
> > > @@ -172,6 +173,10 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  		return ret;
> > >  
> > >  	vp_vdpa = vp_vdpa_modern_probe(pdev);
> > > +	if (PTR_ERR(vp_vdpa) == -ENODEV) {
> > > +		dev_info(&pdev->dev, "Tring legacy driver");
> > > +		vp_vdpa = vp_vdpa_legacy_probe(pdev);
> > > +	}
> > >  	if (IS_ERR(vp_vdpa))
> > >  		return PTR_ERR(vp_vdpa);
> > >  
> > > diff --git a/drivers/vdpa/virtio_pci/vp_vdpa_common.h b/drivers/vdpa/virtio_pci/vp_vdpa_common.h
> > > index 57886b55a2e9..39f241d8321b 100644
> > > --- a/drivers/vdpa/virtio_pci/vp_vdpa_common.h
> > > +++ b/drivers/vdpa/virtio_pci/vp_vdpa_common.h
> > > @@ -10,6 +10,7 @@
> > >  #include <linux/virtio_ring.h>
> > >  #include <linux/virtio_pci.h>
> > >  #include <linux/virtio_pci_modern.h>
> > > +#include <linux/virtio_pci_legacy.h>
> > >  
> > >  #define VP_VDPA_DRIVER_NAME "vp_vdpa"
> > >  #define VP_VDPA_NAME_SIZE 256
> > > @@ -26,6 +27,7 @@ struct vp_vdpa {
> > >  	struct vdpa_device vdpa;
> > >  	struct pci_dev *pci_dev;
> > >  	struct virtio_pci_modern_device mdev;
> > > +	struct virtio_pci_legacy_device ldev;
> > >  	struct vp_vring *vring;
> > >  	struct vdpa_callback config_cb;
> > >  	char msix_name[VP_VDPA_NAME_SIZE];
> > > @@ -53,4 +55,13 @@ void vp_vdpa_free_irq_vectors(void *data);
> > >  
> > >  struct vp_vdpa *vp_vdpa_modern_probe(struct pci_dev *pdev);
> > >  
> > > +#if IS_ENABLED(CONFIG_VP_VDPA_LEGACY)
> > > +struct vp_vdpa *vp_vdpa_legacy_probe(struct pci_dev *pdev);
> > > +#else
> > > +static inline struct vp_vdpa *vp_vdpa_legacy_probe(struct pci_dev *pdev)
> > > +{
> > > +	return ERR_PTR(-ENODEV);
> > > +}
> > > +#endif
> > > +
> > >  #endif
> > > diff --git a/drivers/vdpa/virtio_pci/vp_vdpa_legacy.c b/drivers/vdpa/virtio_pci/vp_vdpa_legacy.c
> > > new file mode 100644
> > > index 000000000000..75a6879a27ca
> > > --- /dev/null
> > > +++ b/drivers/vdpa/virtio_pci/vp_vdpa_legacy.c
> > > @@ -0,0 +1,346 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * vDPA bridge driver for legacy virtio-pci device
> > > + *
> > > + * Copyright (c) 2021, Alibaba Inc. All rights reserved.
> > > + * Author: Wu Zongyong <wuzongyong@linux.alibaba.com>
> > > + */
> > > +
> > > +#include "linux/pci.h"
> > > +#include "linux/virtio_byteorder.h"
> > > +#include "linux/virtio_pci_legacy.h"
> > > +#include <uapi/linux/virtio_net.h>
> > > +#include <uapi/linux/virtio_blk.h>
> > > +#include <linux/virtio_ids.h>
> > > +#include <linux/virtio_pci.h>
> > > +#include "vp_vdpa_common.h"
> > > +
> > > +static struct virtio_pci_legacy_device *vdpa_to_ldev(struct vdpa_device *vdpa)
> > > +{
> > > +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> > > +
> > > +	return &vp_vdpa->ldev;
> > > +}
> > > +
> > > +static u64 vp_vdpa_get_features(struct vdpa_device *vdpa)
> > > +{
> > > +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> > > +
> > > +	return vp_legacy_get_features(ldev);
> > > +}
> > > +
> > > +static int vp_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
> > > +{
> > > +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> > > +
> > > +	vp_legacy_set_features(ldev, features);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static u8 vp_vdpa_get_status(struct vdpa_device *vdpa)
> > > +{
> > > +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> > > +
> > > +	return vp_legacy_get_status(ldev);
> > > +}
> > > +
> > > +static int vp_vdpa_set_vq_state_split(struct vdpa_device *vdpa,
> > > +				      const struct vdpa_vq_state *state)
> > > +{
> > > +	const struct vdpa_vq_state_split *split = &state->split;
> > > +
> > > +	if (split->avail_index == 0)
> > > +		return 0;
> > > +
> > > +	return -EOPNOTSUPP;
> > > +}
> > > +
> > > +static int vp_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 qid,
> > > +				const struct vdpa_vq_state *state)
> > > +{
> > > +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> > > +
> > > +	/* Note that this is not supported by virtio specification.
> > > +	 * But if the state is by chance equal to the device initial
> > > +	 * state, we can let it go.
> > > +	 */
> > > +	if (!vp_legacy_get_queue_enable(ldev, qid))
> > > +		return vp_vdpa_set_vq_state_split(vdpa,	state);
> > > +
> > > +	return -EOPNOTSUPP;
> > > +}
> > > +
> > > +static void vp_vdpa_set_vq_ready(struct vdpa_device *vdpa,
> > > +				 u16 qid, bool ready)
> > > +{
> > > +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> > > +
> > > +	/* Legacy devices can only be activated by setting vq address,
> > > +	 * and queue_enable is not supported by specification. So for
> > > +	 * legacy devices, we use @vp_vdpa_set_vq_address to set vq
> > > +	 * ready instead.
> > > +	 */
> > > +	if (!ready)
> > > +		vp_legacy_set_queue_address(ldev, qid, 0);
> > > +}
> > > +
> > > +static bool vp_vdpa_get_vq_ready(struct vdpa_device *vdpa, u16 qid)
> > > +{
> > > +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> > > +
> > > +	return vp_legacy_get_queue_enable(ldev, qid);
> > > +}
> > > +
> > > +/* Legacy devices don't support set vq num by specification,
> > > + * just report an error if someone try to set it.
> > > + */
> > > +static void vp_vdpa_set_vq_num(struct vdpa_device *vdpa, u16 qid,
> > > +			       u32 num)
> > > +{
> > > +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> > > +
> > > +	dev_err(&ldev->pci_dev->dev, "legacy device don't support set vq num\n");
> > > +}
> > > +
> > > +static u16 vp_vdpa_get_vq_num_max(struct vdpa_device *vdpa)
> > > +{
> > > +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> > > +
> > > +	/* assume all virtqueues have the same size */
> > > +	return vp_legacy_get_queue_size(ldev, 0);
> > > +}
> > > +
> > > +static int vp_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 qid,
> > > +				  u64 desc_area, u64 driver_area,
> > > +				  u64 device_area)
> > > +{
> > > +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> > > +
> > > +	vp_legacy_set_queue_address(ldev, qid, desc_area >> VIRTIO_PCI_QUEUE_ADDR_SHIFT);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static u32 vp_vdpa_get_device_id(struct vdpa_device *vdpa)
> > > +{
> > > +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> > > +
> > > +	return ldev->id.device;
> > > +}
> > > +
> > > +static u32 vp_vdpa_get_vendor_id(struct vdpa_device *vdpa)
> > > +{
> > > +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> > > +
> > > +	return ldev->id.vendor;
> > > +}
> > > +
> > > +static size_t vp_vdpa_get_config_size(struct vdpa_device *vdpa)
> > > +{
> > > +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> > > +	size_t size;
> > > +
> > > +	switch (ldev->id.device) {
> > > +	case VIRTIO_ID_NET:
> > > +		size = sizeof(struct virtio_net_config);
> > > +		break;
> > > +	case VIRTIO_ID_BLOCK:
> > > +		size = sizeof(struct virtio_blk_config);
> > > +		break;
> > > +	default:
> > > +		size = 0;
> > > +		dev_err(&ldev->pci_dev->dev, "VIRTIO ID %u not support\n", ldev->id.device);
> > > +	}
> > > +
> > > +	return size;
> > > +}
> > > +
> > > +static void vp_vdpa_get_config(struct vdpa_device *vdpa,
> > > +			       unsigned int offset,
> > > +			       void *buf, unsigned int len)
> > > +{
> > > +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> > > +	struct virtio_pci_legacy_device *ldev = &vp_vdpa->ldev;
> > > +	void __iomem *ioaddr = ldev->ioaddr +
> > > +		VIRTIO_PCI_CONFIG_OFF(vp_vdpa->vectors) +
> > > +		offset;
> > > +	u8 *p = buf;
> > > +	int i;
> > > +
> > > +	/* legacy devices don't have a configuration generation field,
> > > +	 * so we just read it once.
> > > +	 */
> > > +	for (i = 0; i < len; i++)
> > > +		*p++ = ioread8(ioaddr + i);
> > > +}
> > > +
> > > +static void vp_vdpa_set_config(struct vdpa_device *vdpa,
> > > +			       unsigned int offset, const void *buf,
> > > +			       unsigned int len)
> > > +{
> > > +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> > > +	struct virtio_pci_legacy_device *ldev = &vp_vdpa->ldev;
> > > +	void __iomem *ioaddr = ldev->ioaddr +
> > > +		VIRTIO_PCI_CONFIG_OFF(vp_vdpa->vectors) +
> > > +		offset;
> > > +	const u8 *p = buf;
> > > +	int i;
> > > +
> > > +	for (i = 0; i < len; i++)
> > > +		iowrite8(*p++, ioaddr + i);
> > > +}
> > > +
> > > +static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
> > > +{
> > > +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> > > +	struct virtio_pci_legacy_device *ldev = &vp_vdpa->ldev;
> > > +	u8 s = vp_vdpa_get_status(vdpa);
> > > +
> > > +	if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
> > > +	    !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > > +		vp_vdpa_request_irq(vp_vdpa);
> > > +	}
> > > +
> > > +	vp_legacy_set_status(ldev, status);
> > > +
> > > +	if (!(status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> > > +	    (s & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > > +		vp_vdpa_free_irq(vp_vdpa);
> > > +	}
> > > +}
> > > +
> > > +static bool vp_vdpa_get_vq_num_unchangeable(struct vdpa_device *vdpa)
> > > +{
> > > +	return true;
> > > +}
> > > +
> > > +static const struct vdpa_config_ops vp_vdpa_ops = {
> > > +	.get_features	= vp_vdpa_get_features,
> > > +	.set_features	= vp_vdpa_set_features,
> > > +	.get_status	= vp_vdpa_get_status,
> > > +	.set_status	= vp_vdpa_set_status,
> > > +	.get_vq_num_max	= vp_vdpa_get_vq_num_max,
> > > +	.get_vq_state	= vp_vdpa_get_vq_state,
> > > +	.set_vq_state	= vp_vdpa_set_vq_state,
> > > +	.set_vq_cb	= vp_vdpa_set_vq_cb,
> > > +	.set_vq_ready	= vp_vdpa_set_vq_ready,
> > > +	.get_vq_ready	= vp_vdpa_get_vq_ready,
> > > +	.set_vq_num	= vp_vdpa_set_vq_num,
> > > +	.set_vq_address	= vp_vdpa_set_vq_address,
> > > +	.kick_vq	= vp_vdpa_kick_vq,
> > > +	.get_device_id	= vp_vdpa_get_device_id,
> > > +	.get_vendor_id	= vp_vdpa_get_vendor_id,
> > > +	.get_vq_align	= vp_vdpa_get_vq_align,
> > > +	.get_config_size = vp_vdpa_get_config_size,
> > > +	.get_config	= vp_vdpa_get_config,
> > > +	.set_config	= vp_vdpa_set_config,
> > > +	.set_config_cb  = vp_vdpa_set_config_cb,
> > > +	.get_vq_irq	= vp_vdpa_get_vq_irq,
> > > +	.get_vq_num_unchangeable = vp_vdpa_get_vq_num_unchangeable,
> > > +};
> > > +
> > > +static u16 vp_vdpa_get_num_queues(struct vp_vdpa *vp_vdpa)
> > > +{
> > > +	struct virtio_pci_legacy_device *ldev = &vp_vdpa->ldev;
> > > +	u32 features = vp_legacy_get_features(ldev);
> > > +	u16 num;
> > > +
> > > +	switch (ldev->id.device) {
> > > +	case VIRTIO_ID_NET:
> > > +		num = 2;
> > > +		if (features & VIRTIO_NET_F_MQ) {
> > > +			__virtio16 max_virtqueue_pairs;
> > > +
> > > +			vp_vdpa_get_config(&vp_vdpa->vdpa,
> > > +				offsetof(struct virtio_net_config, max_virtqueue_pairs),
> > > +				&max_virtqueue_pairs,
> > > +				sizeof(max_virtqueue_pairs));
> > > +			num = 2 * __virtio16_to_cpu(virtio_legacy_is_little_endian(),
> > > +						max_virtqueue_pairs);
> > > +		}
> > > +
> > > +		if (features & VIRTIO_NET_F_CTRL_VQ)
> > > +			num += 1;
> > > +		break;
> > > +	case VIRTIO_ID_BLOCK:
> > > +		num = 1;
> > > +		break;
> > > +	default:
> > > +		num = 0;
> > > +		dev_err(&ldev->pci_dev->dev, "VIRTIO ID %u not support\n", ldev->id.device);
> > > +	}
> > > +
> > > +	return num;
> > > +}
> > > +
> > > +static u16 vp_vdpa_queue_vector(struct vp_vdpa *vp_vdpa, u16 idx, u16 vector)
> > > +{
> > > +	return vp_legacy_queue_vector(&vp_vdpa->ldev, idx, vector);
> > > +}
> > > +
> > > +static u16 vp_vdpa_config_vector(struct vp_vdpa *vp_vdpa, u16 vector)
> > > +{
> > > +	return vp_legacy_config_vector(&vp_vdpa->ldev, vector);
> > > +}
> > > +
> > > +struct vp_vdpa *vp_vdpa_legacy_probe(struct pci_dev *pdev)
> > > +{
> > > +	struct device *dev = &pdev->dev;
> > > +	struct vp_vdpa *vp_vdpa;
> > > +	struct virtio_pci_legacy_device *ldev;
> > > +	int ret, i;
> > > +
> > > +	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa, dev, &vp_vdpa_ops, NULL);
> > > +	if (vp_vdpa == NULL) {
> > > +		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
> > > +		return ERR_PTR(-ENOMEM);
> > > +	}
> > > +
> > > +	ldev = &vp_vdpa->ldev;
> > > +	ldev->pci_dev = pdev;
> > > +
> > > +	ret = vp_legacy_probe(ldev);
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to probe legacy PCI device\n");
> > > +		goto err;
> > > +	}
> > > +
> > > +	pci_set_master(pdev);
> > > +	pci_set_drvdata(pdev, vp_vdpa);
> > > +
> > > +	vp_vdpa->vdpa.dma_dev = &pdev->dev;
> > > +	vp_vdpa->queues = vp_vdpa_get_num_queues(vp_vdpa);
> > > +
> > > +	ret = devm_add_action_or_reset(dev, vp_vdpa_free_irq_vectors, pdev);
> > > +	if (ret) {
> > > +		dev_err(dev,
> > > +			"Failed for adding devres for freeing irq vectors\n");
> > > +		goto err;
> > > +	}
> > > +
> > > +	vp_vdpa->vring = devm_kcalloc(dev, vp_vdpa->queues,
> > > +				      sizeof(*vp_vdpa->vring),
> > > +				      GFP_KERNEL);
> > > +	if (!vp_vdpa->vring) {
> > > +		ret = -ENOMEM;
> > > +		dev_err(dev, "Fail to allocate virtqueues\n");
> > > +		goto err;
> > > +	}
> > > +
> > > +	for (i = 0; i < vp_vdpa->queues; i++) {
> > > +		vp_vdpa->vring[i].irq = VIRTIO_MSI_NO_VECTOR;
> > > +		vp_vdpa->vring[i].notify = ldev->ioaddr + VIRTIO_PCI_QUEUE_NOTIFY;
> > > +		vp_vdpa->vring[i].notify_pa = pci_resource_start(pdev, 0) + VIRTIO_PCI_QUEUE_NOTIFY;
> > > +	}
> > > +	vp_vdpa->config_irq = VIRTIO_MSI_NO_VECTOR;
> > > +
> > > +	vp_vdpa->queue_vector = vp_vdpa_queue_vector;
> > > +	vp_vdpa->config_vector = vp_vdpa_config_vector;
> > > +
> > > +	return vp_vdpa;
> > > +
> > > +err:
> > > +	put_device(&vp_vdpa->vdpa.dev);
> > > +	return ERR_PTR(ret);
> > > +}
> > > -- 
> > > 2.31.1

