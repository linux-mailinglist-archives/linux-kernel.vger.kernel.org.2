Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4560E408465
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 08:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237224AbhIMGFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 02:05:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29087 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234655AbhIMGFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 02:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631513043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MsctpVGQyV6/v25aTDpvQ7QvrlAiAoDMHUqgBQtcFic=;
        b=evhdwaaPt8MSZDlkuOCfJgqJY2Jv78XUFdY/qR4Nbh2nlMe0UMJf+uCfBunYdya2f9Gnr/
        wAy1OoSACtVKz+bUc5AbTTrLtQiyfhrsMtd5NgIiwk2r7s174CsvU3NoXj3H83QHXVXplP
        h3XYpIN5CFFcsPS6x6Xhzrm0+NiWUcI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-Ruo852mKOLe0zeJqNd1QOg-1; Mon, 13 Sep 2021 02:04:02 -0400
X-MC-Unique: Ruo852mKOLe0zeJqNd1QOg-1
Received: by mail-ed1-f72.google.com with SMTP id g17-20020a056402425100b003cd5ba2852fso4384834edb.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 23:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MsctpVGQyV6/v25aTDpvQ7QvrlAiAoDMHUqgBQtcFic=;
        b=CUlHFAyiNTBlI8P8+IYbul1dwQwHQ2toK+agLKNdnFqEvUn7RpcIDzGZFssECX6m7H
         M0Ia0w44zypKYuIKgu/TILalgJElJFtPqK9bXP/hpgBT7TMsyrTSgxzitC079du3Phhd
         gbILq2tYlkct4bpGxAjU3pVKmtNuvwdL9Kqh81cWpJmuF8Q8wbedGw9y1hSzE0UKexCj
         7OMkW1VSsLCQclK8aUUO5UBYqiG5FRYfTwxuR6X1+SPMAjZ4cXHdlS+CewIq+TFAALNT
         O3l2fC3Qzf2Pl1Y1PpdpIP4iikZcNfeK0q8iwOAo7/7RHUczfnzIS9W1gFnS4ULK9ABL
         skvQ==
X-Gm-Message-State: AOAM532tLCQ95qIPy+lNwEuRSZHghxz4zlz8qZX4/sQPjoNz+XmyufOw
        nLjarBiPp/W4VuxE2G+1ZISkVXAIvtC2l/OggrfWqQVycn0bn9Po80278CaDCkebQ8bR35lqV9Y
        99xS1IOnEgQxa4FPlS7+xZA+9
X-Received: by 2002:a17:906:5d6:: with SMTP id t22mr10909826ejt.98.1631513040934;
        Sun, 12 Sep 2021 23:04:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzm1Vcn6NiQyB4mKJJv2BPvNXfCEw4nbTwxBVWrIIE5IykDgNkBqc1gcdkp/JIonsUfnn89vg==
X-Received: by 2002:a17:906:5d6:: with SMTP id t22mr10909795ejt.98.1631513040747;
        Sun, 12 Sep 2021 23:04:00 -0700 (PDT)
Received: from redhat.com ([2.55.27.174])
        by smtp.gmail.com with ESMTPSA id t16sm2881663ejj.54.2021.09.12.23.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 23:03:59 -0700 (PDT)
Date:   Mon, 13 Sep 2021 02:03:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com, pbonzini@redhat.com,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        James E J Bottomley <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        X86 ML <x86@kernel.org>
Subject: Re: [PATCH 6/9] virtio_pci: harden MSI-X interrupts
Message-ID: <20210913015711-mutt-send-email-mst@kernel.org>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-7-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913055353.35219-7-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 01:53:50PM +0800, Jason Wang wrote:
> We used to synchronize pending MSI-X irq handlers via
> synchronize_irq(), this may not work for the untrusted device which
> may keep sending interrupts after reset which may lead unexpected
> results. Similarly, we should not enable MSI-X interrupt until the
> device is ready. So this patch fixes those two issues by:
> 
> 1) switching to use disable_irq() to prevent the virtio interrupt
>    handlers to be called after the device is reset.
> 2) using IRQF_NO_AUTOEN and enable the MSI-X irq during .ready()
> 
> This can make sure the virtio interrupt handler won't be called before
> virtio_device_ready() and after reset.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

I don't get the threat model here. Isn't disabling irqs done by the 
hypervisor anyway? Is there a reason to trust disable_irq but not
device reset?

Cc a bunch more people ...


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

