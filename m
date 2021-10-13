Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B72242BBD1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 11:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239195AbhJMJoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 05:44:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46774 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239166AbhJMJoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 05:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634118128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U68OI4OeCzb+i7/ugVEhD/bkOqefRrn7yZ62rOLQMr0=;
        b=Sp8eo/iqGbg/r0btsoRnelbObI6MwLYFAKqUU6nY0b0ta46oeu/qhfXVZHgw2pA0UpvbTm
        L8IPUWketd+kvUxwzhkcyrOqDQGMNHxFsovm/lzA4DAE+NDBCSQsWKzZDfwkg3jGiNzU/a
        Wz+V9ipU9tEyAZXEnmjJJBzau07zTyU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-CSZqfB_YPTCXwMeWPxRNKg-1; Wed, 13 Oct 2021 05:42:07 -0400
X-MC-Unique: CSZqfB_YPTCXwMeWPxRNKg-1
Received: by mail-wr1-f72.google.com with SMTP id c2-20020adfa302000000b0015e4260febdso1475311wrb.20
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 02:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U68OI4OeCzb+i7/ugVEhD/bkOqefRrn7yZ62rOLQMr0=;
        b=4/XsQ8alTDGaRCCQaVKD4EWcv9W9eYXu3u/eWk6RYA2NZP1ZDMxHgruw6Z697NF+LG
         l2ek7VZVtNKNH8bbvItv2DtN+fxf9O6i9NG7hfjAuuEfkrZjK4i+RmHGLK88kTsrM5ze
         jjqwvGgjVmJyIPQ8PovzziVhwYp55MA/a/dHtriO4R8NuqXNepWNW8gEIbUVKWmzp28Q
         5mpSjjaB0NDbahwcYNDSUgYJNhqLrNHujegpr5NUue52lTvzWJ6AEsI9YZIeQGEY+3+O
         6z9wMlyYcPt45ewCcxHtzmOQ7q6rTpEQT2ZOM0LKXhFR4vQFeLc3LSMgAwCl/5zMxxq+
         FMDw==
X-Gm-Message-State: AOAM5313/W+rq+939mfGCwRE4ILgmtcvQ5f7cUiZO/eeDWCsy4+FBKuL
        QQfE3iUb18ZQ4f19COQw0JVkkWTwmqYfK5n/Z1EqaIUEhjyeguo7bMJ7/b4Wh7MgSv8Exht8kJ6
        9ZuHYyTFM+Fe5FBkSnwu9l6VT
X-Received: by 2002:a05:600c:154f:: with SMTP id f15mr11963037wmg.195.1634118125839;
        Wed, 13 Oct 2021 02:42:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwn/WvcYSD7wMef0lNnYuPUlX4EALP+Md0v/JLHsPep5rirJoC9RpK1Qa6aqmeDkrkWjH1gbw==
X-Received: by 2002:a05:600c:154f:: with SMTP id f15mr11963020wmg.195.1634118125653;
        Wed, 13 Oct 2021 02:42:05 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
        by smtp.gmail.com with ESMTPSA id u2sm12504081wrr.35.2021.10.13.02.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 02:42:05 -0700 (PDT)
Date:   Wed, 13 Oct 2021 05:42:01 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH V2 07/12] virtio-pci: harden INTX interrupts
Message-ID: <20211013053627-mutt-send-email-mst@kernel.org>
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-8-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012065227.9953-8-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 02:52:22PM +0800, Jason Wang wrote:
> This patch tries to make sure the virtio interrupt handler for INTX
> won't be called after a reset and before virtio_device_ready(). We
> can't use IRQF_NO_AUTOEN since we're using shared interrupt
> (IRQF_SHARED). So this patch tracks the INTX enabling status in a new
> intx_soft_enabled variable and toggle it during in
> vp_disable/enable_vectors(). The INTX interrupt handler will check
> intx_soft_enabled before processing the actual interrupt.
> 
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_pci_common.c | 24 ++++++++++++++++++++++--
>  drivers/virtio/virtio_pci_common.h |  1 +
>  2 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 0b9523e6dd39..5ae6a2a4eb77 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -30,8 +30,16 @@ void vp_disable_vectors(struct virtio_device *vdev)
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	int i;
>  
> -	if (vp_dev->intx_enabled)
> +	if (vp_dev->intx_enabled) {
> +		/*
> +		 * The below synchronize() guarantees that any
> +		 * interrupt for this line arriving after
> +		 * synchronize_irq() has completed is guaranteed to see
> +		 * intx_soft_enabled == false.
> +		 */
> +		WRITE_ONCE(vp_dev->intx_soft_enabled, false);
>  		synchronize_irq(vp_dev->pci_dev->irq);
> +	}
>  
>  	for (i = 0; i < vp_dev->msix_vectors; ++i)
>  		disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> @@ -43,8 +51,16 @@ void vp_enable_vectors(struct virtio_device *vdev)
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	int i;
>  
> -	if (vp_dev->intx_enabled)
> +	if (vp_dev->intx_enabled) {
> +		disable_irq(vp_dev->pci_dev->irq);
> +		/*
> +		 * The above disable_irq() provides TSO ordering and
> +		 * as such promotes the below store to store-release.
> +		 */
> +		WRITE_ONCE(vp_dev->intx_soft_enabled, true);
> +		enable_irq(vp_dev->pci_dev->irq);
>  		return;
> +	}
>  
>  	for (i = 0; i < vp_dev->msix_vectors; ++i)
>  		enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> @@ -97,6 +113,10 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
>  	struct virtio_pci_device *vp_dev = opaque;
>  	u8 isr;
>  
> +	/* read intx_soft_enabled before read others */
> +	if (!smp_load_acquire(&vp_dev->intx_soft_enabled))
> +		return IRQ_NONE;
> +
>  	/* reading the ISR has the effect of also clearing it so it's very
>  	 * important to save off the value. */
>  	isr = ioread8(vp_dev->isr);

I don't see why we need this ordering guarantee here.

synchronize_irq above makes sure no interrupt handler
is in progress. the handler itself thus does not need
any specific order, it is ok if intx_soft_enabled is read
after, not before the rest of it.

Just READ_ONCE should be enough, and we can drop the comment.


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

