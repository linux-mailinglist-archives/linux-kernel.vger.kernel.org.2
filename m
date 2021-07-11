Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC993C3A24
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 06:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhGKE1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 00:27:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26005 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229485AbhGKE1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 00:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625977493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aZYL5aYn0xhNCuQJ4VSpLl42cD0uGgHWKGK+S3b+4Xw=;
        b=cngJLw/A1N13PH08P/KAR/BG3PazcuyO0ZUJSWxZtuldlFt/oEmE2CAaG+y74BL973dOxg
        owTpDpj5E3pdZraDh2Sqgr/GCtPsh7AMqustpkdjQjBZMilbUGE+X+eTf/PSrHWoRXpbKT
        6RF+ARTbFmXtI78w7I2CqkH3RYV9X4Q=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-luUJNlzBPY2c9NeuFaIv2g-1; Sun, 11 Jul 2021 00:24:51 -0400
X-MC-Unique: luUJNlzBPY2c9NeuFaIv2g-1
Received: by mail-ed1-f71.google.com with SMTP id p13-20020a05640210cdb029039560ff6f46so7787335edu.17
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 21:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aZYL5aYn0xhNCuQJ4VSpLl42cD0uGgHWKGK+S3b+4Xw=;
        b=tQhNeZQmu/FtbHQONvKFJr//BHIIXx828opcEP45k9KoJlYAzJVw2vb1YaK2W4DvxC
         eHqZnRTQ2ijJBC8jN62AGEUOC0ajCtRTpx7YSkm2nQ3MPLfW+GyNea27bAwYK1u5KCCT
         FLEP8dHPPIryyRIyed24nXU0vPju0vyyRB82U+I3Fjvsuv4ZgrghaRBg8vWrRqUwbAAa
         d722MmS4PXdYTL4Tej4ol6YCLSWv8IpW2mYQkaEP2phcm+of1t+iy8uilUGSp0M6SJGG
         e/zGZvtbQcDZumcqZXgwhau5TfwKBmkbdaNG4mhx38rQO/RdxLWlizxqJ9C/nUE4hEej
         CjYA==
X-Gm-Message-State: AOAM5326y9Rzwd8JEpe3i9Gjae4epbjYLM9HU+OXmw90Gf0MBHtO6bNx
        nZ3FenUJgwbkuJ1dsBUFOc4hY0iSqQc7+8kvZ2skVesdJK1gJBMZQnureJf3+cImEunm38ilh5r
        uw1pyK/FoN9T+xppAZpDA//3w
X-Received: by 2002:a17:907:3f21:: with SMTP id hq33mr46593693ejc.101.1625977490636;
        Sat, 10 Jul 2021 21:24:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2631mvc12XNn+pwQYGuAoTleaNH4+BbnJXIlHyuX714kOlbFAfCmFuHzVyxmLUCkbND1PJQ==
X-Received: by 2002:a17:907:3f21:: with SMTP id hq33mr46593678ejc.101.1625977490452;
        Sat, 10 Jul 2021 21:24:50 -0700 (PDT)
Received: from redhat.com ([2.55.136.76])
        by smtp.gmail.com with ESMTPSA id c2sm4560282ejz.73.2021.07.10.21.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 21:24:49 -0700 (PDT)
Date:   Sun, 11 Jul 2021 00:24:47 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH AUTOSEL 5.4 28/28] virtio: fix up virtio_disable_cb
Message-ID: <20210711002423-mutt-send-email-mst@kernel.org>
References: <20210710235107.3221840-1-sashal@kernel.org>
 <20210710235107.3221840-28-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210710235107.3221840-28-sashal@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2021 at 07:51:07PM -0400, Sasha Levin wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> 
> [ Upstream commit 8d622d21d24803408b256d96463eac4574dcf067 ]
> 
> virtio_disable_cb is currently a nop for split ring with event index.
> This is because it used to be always called from a callback when we know
> device won't trigger more events until we update the index.  However,
> now that we run with interrupts enabled a lot we also poll without a
> callback so that is different: disabling callbacks will help reduce the
> number of spurious interrupts.
> Further, if using event index with a packed ring, and if being called
> from a callback, we actually do disable interrupts which is unnecessary.
> 
> Fix both issues by tracking whenever we get a callback. If that is
> the case disabling interrupts with event index can be a nop.
> If not the case disable interrupts. Note: with a split ring
> there's no explicit "no interrupts" value. For now we write
> a fixed value so our chance of triggering an interupt
> is 1/ring size. It's probably better to write something
> related to the last used index there to reduce the chance
> even further. For now I'm keeping it simple.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

I don't think we should have it in stable just yet.
Let's make sure it fixes the issue first.

> ---
>  drivers/virtio/virtio_ring.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 97e8a195e18f..b6e1e0598529 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -113,6 +113,9 @@ struct vring_virtqueue {
>  	/* Last used index we've seen. */
>  	u16 last_used_idx;
>  
> +	/* Hint for event idx: already triggered no need to disable. */
> +	bool event_triggered;
> +
>  	union {
>  		/* Available for split ring */
>  		struct {
> @@ -739,7 +742,10 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
>  
>  	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
>  		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
> -		if (!vq->event)
> +		if (vq->event)
> +			/* TODO: this is a hack. Figure out a cleaner value to write. */
> +			vring_used_event(&vq->split.vring) = 0x0;
> +		else
>  			vq->split.vring.avail->flags =
>  				cpu_to_virtio16(_vq->vdev,
>  						vq->split.avail_flags_shadow);
> @@ -1605,6 +1611,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  	vq->weak_barriers = weak_barriers;
>  	vq->broken = false;
>  	vq->last_used_idx = 0;
> +	vq->event_triggered = false;
>  	vq->num_added = 0;
>  	vq->packed_ring = true;
>  	vq->use_dma_api = vring_use_dma_api(vdev);
> @@ -1919,6 +1926,12 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> +	/* If device triggered an event already it won't trigger one again:
> +	 * no need to disable.
> +	 */
> +	if (vq->event_triggered)
> +		return;
> +
>  	if (vq->packed_ring)
>  		virtqueue_disable_cb_packed(_vq);
>  	else
> @@ -1942,6 +1955,9 @@ unsigned virtqueue_enable_cb_prepare(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> +	if (vq->event_triggered)
> +		vq->event_triggered = false;
> +
>  	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(_vq) :
>  				 virtqueue_enable_cb_prepare_split(_vq);
>  }
> @@ -2005,6 +2021,9 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> +	if (vq->event_triggered)
> +		vq->event_triggered = false;
> +
>  	return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(_vq) :
>  				 virtqueue_enable_cb_delayed_split(_vq);
>  }
> @@ -2044,6 +2063,10 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
>  	if (unlikely(vq->broken))
>  		return IRQ_HANDLED;
>  
> +	/* Just a hint for performance: so it's ok that this can be racy! */
> +	if (vq->event)
> +		vq->event_triggered = true;
> +
>  	pr_debug("virtqueue callback for %p (%p)\n", vq, vq->vq.callback);
>  	if (vq->vq.callback)
>  		vq->vq.callback(&vq->vq);
> @@ -2083,6 +2106,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  	vq->weak_barriers = weak_barriers;
>  	vq->broken = false;
>  	vq->last_used_idx = 0;
> +	vq->event_triggered = false;
>  	vq->num_added = 0;
>  	vq->use_dma_api = vring_use_dma_api(vdev);
>  #ifdef DEBUG
> -- 
> 2.30.2

