Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF26C4084BE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 08:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237360AbhIMGes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 02:34:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33314 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232146AbhIMGer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 02:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631514811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PhHmbd+vGEUJyrV5DLTBHy+hH4Q8g3MAN2ba0j9CKCQ=;
        b=MANHO9U4oiKwN99RdF8lY6ILjjTR+NtrlY3VwrCCkYRwlOFHCEviuVhv7cD4L5jkuqPB0J
        eLPgRSdk8SnoxZc7C97X/gjuCF6crkIzsX2n1CebrKUDbQn/ei5SlN8Tzh9cOsS6uufF8p
        zO7vB1/Pra9JLCdvoQUo2PKTnEY2Lro=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-xAsg16jcNDOMj9ROA6qmog-1; Mon, 13 Sep 2021 02:33:30 -0400
X-MC-Unique: xAsg16jcNDOMj9ROA6qmog-1
Received: by mail-ed1-f72.google.com with SMTP id y10-20020a056402270a00b003c8adc4d40cso4388371edd.15
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 23:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PhHmbd+vGEUJyrV5DLTBHy+hH4Q8g3MAN2ba0j9CKCQ=;
        b=3FHsG3+BPSSvL5OmqdLi7RktnaBbxxTTfzVbwuqj1SSk8midEH17LgzpJCSTv13UI0
         EvgRQzsaAUz4iXfl7S5Bd+DKmxlIRt7HiEovepl2HjgBpwVmzKM9UA7y4hQ2QKCTbDAd
         DB03rhWgGsRTKS9L22NdXBI2W4fMkf4A75dV0BbuDoHkejsQkpjyTeoJMkwb9XYM1DdX
         eZAmZ7DPVxx5qD8DDDeOiSgZW3MDIHEPgD8ALfIHe8GlWhf33fupHxCmm1IT0tMAkPI2
         LHSzWpdr13D/YkqxIxC0jGaGRaJpYKNKIPIcS/OJXwNLncMxP2L0mFvaUzbc5SamAGBT
         S24A==
X-Gm-Message-State: AOAM532uZ10FQoF+QOCQwk/IhQ8uk2IqL8DKnlVAJGFFEK7pJLBYhHLR
        Nc3VpEtDqNCc0KrsFm06pGOlmbIlykGCBaKnqctBwjNyIBDC0Ml9y5F28Vr8fkBFitf7q7VfLdX
        9qtoRnutVGuIl2tftTYRXcYZ7
X-Received: by 2002:a17:906:919:: with SMTP id i25mr10772247ejd.171.1631514809694;
        Sun, 12 Sep 2021 23:33:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIZT1R9ojuyk23OwxUJ6uHrkH/wVwqrhLF7z3AcQL8TGKDrdQpFBuRq64gNqFYnqY5oSsbIA==
X-Received: by 2002:a17:906:919:: with SMTP id i25mr10772233ejd.171.1631514809559;
        Sun, 12 Sep 2021 23:33:29 -0700 (PDT)
Received: from redhat.com ([2.55.27.174])
        by smtp.gmail.com with ESMTPSA id o15sm2917942ejj.10.2021.09.12.23.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 23:33:28 -0700 (PDT)
Date:   Mon, 13 Sep 2021 02:33:25 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 7/9] virtio-pci: harden INTX interrupts
Message-ID: <20210913022824-mutt-send-email-mst@kernel.org>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-8-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913055353.35219-8-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 01:53:51PM +0800, Jason Wang wrote:
> This patch tries to make sure the virtio interrupt handler for INTX
> won't be called after a reset and before virtio_device_ready(). We
> can't use IRQF_NO_AUTOEN since we're using shared interrupt
> (IRQF_SHARED). So this patch tracks the INTX enabling status in a new
> intx_soft_enabled variable and toggle it during in
> vp_disable/enable_vectors(). The INTX interrupt handler will check
> intx_soft_enabled before processing the actual interrupt.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>


Not all that excited about all the memory barriers for something
that should be an extremely rare event (for most kernels -
literally once per boot). Can't we do better?

> ---
>  drivers/virtio/virtio_pci_common.c | 18 ++++++++++++++++--
>  drivers/virtio/virtio_pci_common.h |  1 +
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 0b9523e6dd39..835197151dc1 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -30,8 +30,12 @@ void vp_disable_vectors(struct virtio_device *vdev)
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	int i;
>  
> -	if (vp_dev->intx_enabled)
> +	if (vp_dev->intx_enabled) {
> +		vp_dev->intx_soft_enabled = false;
> +		/* ensure the vp_interrupt see this intx_soft_enabled value */
> +		smp_wmb();
>  		synchronize_irq(vp_dev->pci_dev->irq);
> +	}
>  
>  	for (i = 0; i < vp_dev->msix_vectors; ++i)
>  		disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> @@ -43,8 +47,12 @@ void vp_enable_vectors(struct virtio_device *vdev)
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	int i;
>  
> -	if (vp_dev->intx_enabled)
> +	if (vp_dev->intx_enabled) {
> +		vp_dev->intx_soft_enabled = true;
> +		/* ensure the vp_interrupt see this intx_soft_enabled value */
> +		smp_wmb();
>  		return;
> +	}
>  
>  	for (i = 0; i < vp_dev->msix_vectors; ++i)
>  		enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> @@ -97,6 +105,12 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
>  	struct virtio_pci_device *vp_dev = opaque;
>  	u8 isr;
>  
> +	if (!vp_dev->intx_soft_enabled)
> +		return IRQ_NONE;
> +
> +	/* read intx_soft_enabled before read others */
> +	smp_rmb();
> +
>  	/* reading the ISR has the effect of also clearing it so it's very
>  	 * important to save off the value. */
>  	isr = ioread8(vp_dev->isr);
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index a235ce9ff6a5..3c06e0f92ee4 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -64,6 +64,7 @@ struct virtio_pci_device {
>  	/* MSI-X support */
>  	int msix_enabled;
>  	int intx_enabled;
> +	bool intx_soft_enabled;
>  	cpumask_var_t *msix_affinity_masks;
>  	/* Name strings for interrupts. This size should be enough,
>  	 * and I'm too lazy to allocate each name separately. */
> -- 
> 2.25.1

