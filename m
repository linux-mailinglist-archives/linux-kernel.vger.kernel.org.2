Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F0842FA3B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhJOR3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:29:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45981 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229648AbhJOR3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634318853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lgUgodXT3ew/1/poH4FFTkR+Gpon+z6sOsfUAcBcy7o=;
        b=Hu5gRAIIB49zlhfGSIeFpAYU1Dbf+gblh8lPQAJ8OPFhiodmHzEXDb9c+vembL6aC5s4dZ
        kzXLWjY6X7MK8LNXq9gyHMqdj0jCf3wIbw+hQU+wd4cNKgkCMbw8KCr0UqwFssx0mqDyw0
        MZCemlqCrHFLXYnCX9t6MKzACYLdBDA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-m8YV9WUoNfuLi7FNSwgEpQ-1; Fri, 15 Oct 2021 13:27:32 -0400
X-MC-Unique: m8YV9WUoNfuLi7FNSwgEpQ-1
Received: by mail-wr1-f69.google.com with SMTP id y12-20020a056000168c00b00160da4de2c7so6198489wrd.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lgUgodXT3ew/1/poH4FFTkR+Gpon+z6sOsfUAcBcy7o=;
        b=p/i8asXoLcMbbafHeY72akJ5ruJo1fZ0tRAC2Zncyrvh4ouwyyXbEhgoG/4gGur86i
         jamOs/WccxGjksrEySfexVKWPE3da2pGmgvUscKL4E4UbheQ/kn/AXNgiPJJtgc96hPt
         sWALcOxnhH4arPD7jIqjwnsqUgIWLV9q/ZwzLIsm+96A1cwzgmfBB8I8wN+ZwGEkQwqU
         nJGpAwW9W526w8CAJvAKR3S01p3O4swBC0OBsAC6Csu6BKiz6eMKwKM0udkz3NqGkZD/
         SUp/980Rfu8d4y8dBzMbycCSYmE5chwYxblPy7V/U52o2tkcGN8h5HGEjTo+0BQe9wN2
         F2ow==
X-Gm-Message-State: AOAM533xuL/nZPliDWvdZ0k2Yc4RmwezfLoWT+d1+h2i6IlJVciCQ2ZS
        8zx/ti+fdabFCWVMQKvi3xcTjoqBKf+DqobH3uWmmMvobE3f++D0iLCA2EVthZRfn9PCbDGJe86
        qyN9cKrzz3OTHnHcLihF5K02h
X-Received: by 2002:adf:aa92:: with SMTP id h18mr15545197wrc.372.1634318851303;
        Fri, 15 Oct 2021 10:27:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyniCpVVGwD3uQwJ+f6T7Gy66HM/GMv9wYj823SBDHQUwApD3oA7BmKODsodMZTORVH4fqonA==
X-Received: by 2002:adf:aa92:: with SMTP id h18mr15545165wrc.372.1634318851038;
        Fri, 15 Oct 2021 10:27:31 -0700 (PDT)
Received: from redhat.com ([2.55.147.75])
        by smtp.gmail.com with ESMTPSA id d9sm5430908wrm.96.2021.10.15.10.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 10:27:30 -0700 (PDT)
Date:   Fri, 15 Oct 2021 13:27:26 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, david.kaplan@amd.com,
        konrad.wilk@oracle.com, Peter Zijlstra <peterz@infradead.org>,
        f.hetzelt@tu-berlin.de, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V2 06/12] virtio_pci: harden MSI-X interrupts
Message-ID: <20211015132639-mutt-send-email-mst@kernel.org>
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-7-jasowang@redhat.com>
 <c6641b6a-6204-2b41-e775-ad329314711c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6641b6a-6204-2b41-e775-ad329314711c@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 05:09:38AM -0700, Dongli Zhang wrote:
> Hi Jason,
> 
> On 10/11/21 11:52 PM, Jason Wang wrote:
> > We used to synchronize pending MSI-X irq handlers via
> > synchronize_irq(), this may not work for the untrusted device which
> > may keep sending interrupts after reset which may lead unexpected
> > results. Similarly, we should not enable MSI-X interrupt until the
> 
> About "unexpected results", while you mentioned below in v1 ...
> 
> "My understanding is that e.g in the case of SEV/TDX we don't trust the
> hypervisor. So the hypervisor can keep sending interrupts even if the
> device is reset. The guest can only trust its own software interrupt
> management logic to avoid call virtio callback in this case."
> 
> .. and you also mentioned to avoid the panic (due to untrusted device) in as
> many scenarios as possible.
> 
> 
> Here is my understanding.
> 
> The reason we do not trust hypervisor is to protect (1) data/code privacy for
> most of times and sometimes (2) program execution integrity.
> 
> The bad thing is: the hypervisor is able to panic/destroy the VM in the worst case.
> 
> It is reasonable to re-configure/recover if we assume there is BUG at
> hypervisor/device side. That is, the hypervisor/device is buggy, but not malicious.
> 
> However, how about to just detect and report the hypervisor/device is malicious
> and shutdown/panic the VM immediately? If we have detected the malicious
> hypervisor, we should avoid running VMs on the malicious hypervisor further. At
> least how about to print error message to reminder users that the hypervisor is
> malicious?
> 
> 
> About "unexpected results", it should not be hang/panic. I suggest ...
> 
> Assuming SEV/TDX is involved, the hypervisor should never be able to derive the
> VM privacy (at least secure memory data) by providing malicious configuration,
> e.g., num_queues=0. If we detect hypervisor is malicious, the VM is
> panic/shutdown immediately. At least how about to print error message to
> reminder users.
> 
> 
> BTW, while I always do care about the loss of interrupt issue, the malicious
> device is able to hang a VM by dropping a single interrupt on purpose for
> virtio-scsi :)
> 
> 
> Thank you very much!


Can't say I understand what it's about. TDX does not protect against
hypervisor DoS attacks.

> Dongli Zhang
> 
> > device is ready. So this patch fixes those two issues by:
> > 
> > 1) switching to use disable_irq() to prevent the virtio interrupt
> >    handlers to be called after the device is reset.
> > 2) using IRQF_NO_AUTOEN and enable the MSI-X irq during .ready()
> > 
> > This can make sure the virtio interrupt handler won't be called before
> > virtio_device_ready() and after reset.
> > 
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_pci_common.c | 27 +++++++++++++++++++++------
> >  drivers/virtio/virtio_pci_common.h |  6 ++++--
> >  drivers/virtio/virtio_pci_legacy.c |  5 +++--
> >  drivers/virtio/virtio_pci_modern.c |  6 ++++--
> >  4 files changed, 32 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > index b35bb2d57f62..0b9523e6dd39 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -24,8 +24,8 @@ MODULE_PARM_DESC(force_legacy,
> >  		 "Force legacy mode for transitional virtio 1 devices");
> >  #endif
> >  
> > -/* wait for pending irq handlers */
> > -void vp_synchronize_vectors(struct virtio_device *vdev)
> > +/* disable irq handlers */
> > +void vp_disable_vectors(struct virtio_device *vdev)
> >  {
> >  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >  	int i;
> > @@ -34,7 +34,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
> >  		synchronize_irq(vp_dev->pci_dev->irq);
> >  
> >  	for (i = 0; i < vp_dev->msix_vectors; ++i)
> > -		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > +		disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > +}
> > +
> > +/* enable irq handlers */
> > +void vp_enable_vectors(struct virtio_device *vdev)
> > +{
> > +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > +	int i;
> > +
> > +	if (vp_dev->intx_enabled)
> > +		return;
> > +
> > +	for (i = 0; i < vp_dev->msix_vectors; ++i)
> > +		enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> >  }
> >  
> >  /* the notify function used when creating a virt queue */
> > @@ -141,7 +154,8 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
> >  	snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
> >  		 "%s-config", name);
> >  	err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
> > -			  vp_config_changed, 0, vp_dev->msix_names[v],
> > +			  vp_config_changed, IRQF_NO_AUTOEN,
> > +			  vp_dev->msix_names[v],
> >  			  vp_dev);
> >  	if (err)
> >  		goto error;
> > @@ -160,7 +174,8 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
> >  		snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
> >  			 "%s-virtqueues", name);
> >  		err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
> > -				  vp_vring_interrupt, 0, vp_dev->msix_names[v],
> > +				  vp_vring_interrupt, IRQF_NO_AUTOEN,
> > +				  vp_dev->msix_names[v],
> >  				  vp_dev);
> >  		if (err)
> >  			goto error;
> > @@ -337,7 +352,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
> >  			 "%s-%s",
> >  			 dev_name(&vp_dev->vdev.dev), names[i]);
> >  		err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
> > -				  vring_interrupt, 0,
> > +				  vring_interrupt, IRQF_NO_AUTOEN,
> >  				  vp_dev->msix_names[msix_vec],
> >  				  vqs[i]);
> >  		if (err)
> > diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> > index beec047a8f8d..a235ce9ff6a5 100644
> > --- a/drivers/virtio/virtio_pci_common.h
> > +++ b/drivers/virtio/virtio_pci_common.h
> > @@ -102,8 +102,10 @@ static struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
> >  	return container_of(vdev, struct virtio_pci_device, vdev);
> >  }
> >  
> > -/* wait for pending irq handlers */
> > -void vp_synchronize_vectors(struct virtio_device *vdev);
> > +/* disable irq handlers */
> > +void vp_disable_vectors(struct virtio_device *vdev);
> > +/* enable irq handlers */
> > +void vp_enable_vectors(struct virtio_device *vdev);
> >  /* the notify function used when creating a virt queue */
> >  bool vp_notify(struct virtqueue *vq);
> >  /* the config->del_vqs() implementation */
> > diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> > index d62e9835aeec..bdf6bc667ab5 100644
> > --- a/drivers/virtio/virtio_pci_legacy.c
> > +++ b/drivers/virtio/virtio_pci_legacy.c
> > @@ -97,8 +97,8 @@ static void vp_reset(struct virtio_device *vdev)
> >  	/* Flush out the status write, and flush in device writes,
> >  	 * including MSi-X interrupts, if any. */
> >  	ioread8(vp_dev->ioaddr + VIRTIO_PCI_STATUS);
> > -	/* Flush pending VQ/configuration callbacks. */
> > -	vp_synchronize_vectors(vdev);
> > +	/* Disable VQ/configuration callbacks. */
> > +	vp_disable_vectors(vdev);
> >  }
> >  
> >  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> > @@ -194,6 +194,7 @@ static void del_vq(struct virtio_pci_vq_info *info)
> >  }
> >  
> >  static const struct virtio_config_ops virtio_pci_config_ops = {
> > +	.ready		= vp_enable_vectors,
> >  	.get		= vp_get,
> >  	.set		= vp_set,
> >  	.get_status	= vp_get_status,
> > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > index 30654d3a0b41..acf0f6b6381d 100644
> > --- a/drivers/virtio/virtio_pci_modern.c
> > +++ b/drivers/virtio/virtio_pci_modern.c
> > @@ -172,8 +172,8 @@ static void vp_reset(struct virtio_device *vdev)
> >  	 */
> >  	while (vp_modern_get_status(mdev))
> >  		msleep(1);
> > -	/* Flush pending VQ/configuration callbacks. */
> > -	vp_synchronize_vectors(vdev);
> > +	/* Disable VQ/configuration callbacks. */
> > +	vp_disable_vectors(vdev);
> >  }
> >  
> >  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> > @@ -380,6 +380,7 @@ static bool vp_get_shm_region(struct virtio_device *vdev,
> >  }
> >  
> >  static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
> > +	.ready		= vp_enable_vectors,
> >  	.get		= NULL,
> >  	.set		= NULL,
> >  	.generation	= vp_generation,
> > @@ -397,6 +398,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
> >  };
> >  
> >  static const struct virtio_config_ops virtio_pci_config_ops = {
> > +	.ready		= vp_enable_vectors,
> >  	.get		= vp_get,
> >  	.set		= vp_set,
> >  	.generation	= vp_generation,
> > 

