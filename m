Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C334A42BC4A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 11:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239189AbhJMKBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 06:01:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29657 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236501AbhJMKBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 06:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634119176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZILX2K6Ig7z5Lkm8vivsYsagosMXGqm+9GQ3CucrqTA=;
        b=BgByQoz1J+arorI3URbisWBQKjX3b8sR4aPGBhFoIHLBGpM92BMpgDTM7uYjcFavSMfeCA
        6z3XebLLaXcn9gk/ZGqE4d2sgeVlZJIAwCNnHaAUBsY95zKC+iGlLIa+qQeREuZKlD7fIh
        QTYNWFcVpwWLo4aGwlLv/SaX5QyYDtE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-uw0jmP7lMeegyBQtJohn7g-1; Wed, 13 Oct 2021 05:59:35 -0400
X-MC-Unique: uw0jmP7lMeegyBQtJohn7g-1
Received: by mail-wr1-f72.google.com with SMTP id 10-20020a5d47aa000000b001610cbda93dso1507083wrb.23
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 02:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZILX2K6Ig7z5Lkm8vivsYsagosMXGqm+9GQ3CucrqTA=;
        b=pma39toE/l7RQU/pwd3dylFxExohyOooJa7prBt9pvxXacSEnCY3J+Be5DUp0FFJXw
         TiO0q/XexWMGI1L5YtAKWbjk5amk8VGpjPVZxoYeMTBKUWgh9Wuwpm6EaSbk3cdNSamB
         tiPZmuqGb6SSbFR3l6mK86PaMl5LHi1bJIpERB28mSOqjDmD1NmU/WDb+gtOs+OfrEP9
         9W+VDaPEfzssJ4NbER3VCz38v132/hJs8ruMm8QyO7X1x61T8jidB8+BwAJgAgXUz4+4
         SfwQ5AblvI57QnaybzAOPI4f9rq90TMEkmKaLbA4fp/YbBKRX7KdBGvvwTVj8VmI4zHT
         H2Ng==
X-Gm-Message-State: AOAM530SumFJkUtCuBfpFPYFNTMxnXPZ16sZYrIPbQOKjfXXR6sVGeLl
        SOAp0mNgBGibaROr8fKZd+3vuwQmCuhAmnGkvpnh9z+M89kQYxnEBxAS4zD3yOMd4sz8M3qXscv
        Z+Z5CDQHIL2Kcc2WJm7ODSSo4
X-Received: by 2002:adf:a387:: with SMTP id l7mr38376889wrb.214.1634119173904;
        Wed, 13 Oct 2021 02:59:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyR/XlO9j3meW5u3Aaj85dORENq1FbO1I0BvYIVMqM0ZAKhasV3gGLIOG/RytPnT2p+PeNNvA==
X-Received: by 2002:adf:a387:: with SMTP id l7mr38376876wrb.214.1634119173750;
        Wed, 13 Oct 2021 02:59:33 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
        by smtp.gmail.com with ESMTPSA id f127sm4637487wmf.16.2021.10.13.02.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 02:59:32 -0700 (PDT)
Date:   Wed, 13 Oct 2021 05:59:29 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH V2 06/12] virtio_pci: harden MSI-X interrupts
Message-ID: <20211013055752-mutt-send-email-mst@kernel.org>
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-7-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012065227.9953-7-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 02:52:21PM +0800, Jason Wang wrote:
> We used to synchronize pending MSI-X irq handlers via
> synchronize_irq(), this may not work for the untrusted device which
> may keep sending interrupts after reset which may lead unexpected
> results. Similarly, we should not enable MSI-X interrupt until the
> device is ready.

You mean until the driver is ready.

> So this patch fixes those two issues by:
> 
> 1) switching to use disable_irq() to prevent the virtio interrupt
>    handlers to be called after the device is reset.
> 2) using IRQF_NO_AUTOEN and enable the MSI-X irq during .ready()
> 
> This can make sure the virtio interrupt handler won't be called before
> virtio_device_ready() and after reset.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_pci_common.c | 27 +++++++++++++++++++++------
>  drivers/virtio/virtio_pci_common.h |  6 ++++--
>  drivers/virtio/virtio_pci_legacy.c |  5 +++--
>  drivers/virtio/virtio_pci_modern.c |  6 ++++--
>  4 files changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index b35bb2d57f62..0b9523e6dd39 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -24,8 +24,8 @@ MODULE_PARM_DESC(force_legacy,
>  		 "Force legacy mode for transitional virtio 1 devices");
>  #endif
>  
> -/* wait for pending irq handlers */
> -void vp_synchronize_vectors(struct virtio_device *vdev)
> +/* disable irq handlers */
> +void vp_disable_vectors(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	int i;
> @@ -34,7 +34,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
>  		synchronize_irq(vp_dev->pci_dev->irq);
>  
>  	for (i = 0; i < vp_dev->msix_vectors; ++i)
> -		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> +		disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> +}
> +
> +/* enable irq handlers */
> +void vp_enable_vectors(struct virtio_device *vdev)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	int i;
> +
> +	if (vp_dev->intx_enabled)
> +		return;
> +
> +	for (i = 0; i < vp_dev->msix_vectors; ++i)
> +		enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
>  }
>  
>  /* the notify function used when creating a virt queue */
> @@ -141,7 +154,8 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
>  	snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
>  		 "%s-config", name);
>  	err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
> -			  vp_config_changed, 0, vp_dev->msix_names[v],
> +			  vp_config_changed, IRQF_NO_AUTOEN,
> +			  vp_dev->msix_names[v],
>  			  vp_dev);
>  	if (err)
>  		goto error;
> @@ -160,7 +174,8 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
>  		snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
>  			 "%s-virtqueues", name);
>  		err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
> -				  vp_vring_interrupt, 0, vp_dev->msix_names[v],
> +				  vp_vring_interrupt, IRQF_NO_AUTOEN,
> +				  vp_dev->msix_names[v],
>  				  vp_dev);
>  		if (err)
>  			goto error;
> @@ -337,7 +352,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
>  			 "%s-%s",
>  			 dev_name(&vp_dev->vdev.dev), names[i]);
>  		err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
> -				  vring_interrupt, 0,
> +				  vring_interrupt, IRQF_NO_AUTOEN,
>  				  vp_dev->msix_names[msix_vec],
>  				  vqs[i]);
>  		if (err)
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index beec047a8f8d..a235ce9ff6a5 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -102,8 +102,10 @@ static struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
>  	return container_of(vdev, struct virtio_pci_device, vdev);
>  }
>  
> -/* wait for pending irq handlers */
> -void vp_synchronize_vectors(struct virtio_device *vdev);
> +/* disable irq handlers */
> +void vp_disable_vectors(struct virtio_device *vdev);
> +/* enable irq handlers */
> +void vp_enable_vectors(struct virtio_device *vdev);
>  /* the notify function used when creating a virt queue */
>  bool vp_notify(struct virtqueue *vq);
>  /* the config->del_vqs() implementation */
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index d62e9835aeec..bdf6bc667ab5 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -97,8 +97,8 @@ static void vp_reset(struct virtio_device *vdev)
>  	/* Flush out the status write, and flush in device writes,
>  	 * including MSi-X interrupts, if any. */
>  	ioread8(vp_dev->ioaddr + VIRTIO_PCI_STATUS);
> -	/* Flush pending VQ/configuration callbacks. */
> -	vp_synchronize_vectors(vdev);
> +	/* Disable VQ/configuration callbacks. */
> +	vp_disable_vectors(vdev);
>  }
>  
>  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> @@ -194,6 +194,7 @@ static void del_vq(struct virtio_pci_vq_info *info)
>  }
>  
>  static const struct virtio_config_ops virtio_pci_config_ops = {
> +	.ready		= vp_enable_vectors,
>  	.get		= vp_get,
>  	.set		= vp_set,
>  	.get_status	= vp_get_status,
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 30654d3a0b41..acf0f6b6381d 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -172,8 +172,8 @@ static void vp_reset(struct virtio_device *vdev)
>  	 */
>  	while (vp_modern_get_status(mdev))
>  		msleep(1);
> -	/* Flush pending VQ/configuration callbacks. */
> -	vp_synchronize_vectors(vdev);
> +	/* Disable VQ/configuration callbacks. */
> +	vp_disable_vectors(vdev);
>  }
>  
>  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> @@ -380,6 +380,7 @@ static bool vp_get_shm_region(struct virtio_device *vdev,
>  }
>  
>  static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
> +	.ready		= vp_enable_vectors,
>  	.get		= NULL,
>  	.set		= NULL,
>  	.generation	= vp_generation,
> @@ -397,6 +398,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>  };
>  
>  static const struct virtio_config_ops virtio_pci_config_ops = {
> +	.ready		= vp_enable_vectors,
>  	.get		= vp_get,
>  	.set		= vp_set,
>  	.generation	= vp_generation,
> -- 
> 2.25.1

