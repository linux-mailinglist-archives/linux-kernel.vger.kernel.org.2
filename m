Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8586D3997F1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 04:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhFCCQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 22:16:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27392 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229541AbhFCCQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 22:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622686487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zx/2l7D1S2LOGyjev2ybB3t/XTR+uhZMQmrvp1dzXq8=;
        b=iY2n+FfHmUzdT2A43jWn9qiwkDTJFFKLRYxotSCmBkK3QmvjCyzErCMIRRCxuDE86j8HTN
        Ho1hImNRn7BwbHg34ZJOhxHYWpz3RKXmu9m/u55djlE90Lxf7OEoRM0/ovwiWu5DNgtlr9
        qgRjZla7/behVlRNk/IOkO9L15+s20c=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-hCYzFfylMEanKTZ_HHqNzg-1; Wed, 02 Jun 2021 22:14:46 -0400
X-MC-Unique: hCYzFfylMEanKTZ_HHqNzg-1
Received: by mail-pl1-f197.google.com with SMTP id k6-20020a1709027606b0290104f319bb01so1934703pll.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 19:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zx/2l7D1S2LOGyjev2ybB3t/XTR+uhZMQmrvp1dzXq8=;
        b=rpPz0vhyTrfYEMLZ+5vKOJPHgCCgKdKmsKiymqWsSgBLHyNW+ssnfKPZvnWgScK3fM
         yA02Wyx7Lwex8+AcX0FL0r84ku9B5eSgTh8kTQRDs2ItbmkW9aL6zeCrTFobq/nzZ4iO
         egJ3o+9pG1kqM9FdCsUtPqEsVv74jvDcFEpb0/y26Ls7cCTbOaQKR7qjFWd33JoKaJcu
         Nbya8rFOSZO38dp6v3Tjkw3yJd0SY0bLvbuOAqVlMudtLtIdc1ZwzAV01gGHGkAI3Yr+
         OkwQiR+IZ5yyMsYj5RxEm/TT53qBF3YdvMehUxrY18BNHitR1smN1oRO129zvlii3dE5
         /4Vg==
X-Gm-Message-State: AOAM533uuSuuIJHuKknAWoVkW7F+yZCkrRYqQKECoX36FQgoyU27c9fJ
        aMkOaF7eCo2Uudk5nKhReZqfAAWAcepEdK8EOX2RQkaSETLEV5g6ESszIGFNvCYN3Qlcu+PJQ32
        hIMu7zOya/ZjOynQNJVZXkEQeP8WjFdnW1co1FZoDD9vjef+8MutcBFV4r2WoFPB/wLU87u3hlS
        yO
X-Received: by 2002:a17:90a:dc04:: with SMTP id i4mr20603826pjv.75.1622686484916;
        Wed, 02 Jun 2021 19:14:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/nlLxc3rqkhZj4W7q+feSCqswQeiFEPfiB1UscaCkUiI3wRjQAIuNjtz/R8oNsSC9/V/iqw==
X-Received: by 2002:a17:90a:dc04:: with SMTP id i4mr20603782pjv.75.1622686484427;
        Wed, 02 Jun 2021 19:14:44 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k1sm701474pfa.30.2021.06.02.19.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 19:14:44 -0700 (PDT)
Subject: Re: [PATCH v1 2/8] virtio: Add boundary checks to virtio ring
To:     Andi Kleen <ak@linux.intel.com>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-3-ak@linux.intel.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <4be00b3a-a15f-7fee-317b-ddabed3c1347@redhat.com>
Date:   Thu, 3 Jun 2021 10:14:38 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603004133.4079390-3-ak@linux.intel.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/6/3 ÉÏÎç8:41, Andi Kleen Ð´µÀ:
> In protected guest mode we don't trust the host.
>
> This means we need to make sure the host cannot subvert us through
> virtio communication. In general it can corrupt our virtio data
> and cause a DOS, but it should not be able to access any data
> that is not explicitely under IO.
>
> Also boundary checking so that the free list (which is accessible
> to the host) cannot point outside the virtio ring. Note it could
> still contain loops or similar, but these should only cause an DOS,
> not a memory corruption or leak.
>
> When we detect any out of bounds descriptor trigger an IO error.
> We also use a WARN() (in case it was a software bug instead of
> an attack). This implies that a malicious host can flood
> the guest kernel log, but that's only a DOS and acceptable
> in the threat model.
>
> This patch only hardens the initial consumption of the free list,
> the freeing comes later.
>
> Any of these errors can cause DMA memory leaks, but there is nothing
> we can do about that and that would be just a DOS.
>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>   drivers/virtio/virtio_ring.c | 46 ++++++++++++++++++++++++++++++++----
>   1 file changed, 42 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index f35629fa47b1..d37ff5a0ff58 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -413,6 +413,15 @@ static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
>   	return desc;
>   }
>   
> +/* assumes no indirect mode */
> +static inline bool inside_split_ring(struct vring_virtqueue *vq,
> +				     unsigned index)
> +{
> +	return !WARN(index >= vq->split.vring.num,
> +		    "desc index %u out of bounds (%u)\n",
> +		    index, vq->split.vring.num);


It's better to use BAD_RING to stop virtqueue in this case.


> +}
> +
>   static inline int virtqueue_add_split(struct virtqueue *_vq,
>   				      struct scatterlist *sgs[],
>   				      unsigned int total_sg,
> @@ -428,6 +437,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>   	unsigned int i, n, avail, descs_used, prev, err_idx;
>   	int head;
>   	bool indirect;
> +	int io_err;
>   
>   	START_USE(vq);
>   
> @@ -481,7 +491,13 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>   
>   	for (n = 0; n < out_sgs; n++) {
>   		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
> -			dma_addr_t addr = vring_map_one_sg(vq, sg, DMA_TO_DEVICE);
> +			dma_addr_t addr;
> +
> +			io_err = -EIO;
> +			if (!inside_split_ring(vq, i))
> +				goto unmap_release;
> +			io_err = -ENOMEM;
> +			addr = vring_map_one_sg(vq, sg, DMA_TO_DEVICE);
>   			if (vring_mapping_error(vq, addr))
>   				goto unmap_release;
>   
> @@ -494,7 +510,13 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>   	}
>   	for (; n < (out_sgs + in_sgs); n++) {
>   		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
> -			dma_addr_t addr = vring_map_one_sg(vq, sg, DMA_FROM_DEVICE);
> +			dma_addr_t addr;
> +
> +			io_err = -EIO;
> +			if (!inside_split_ring(vq, i))
> +				goto unmap_release;
> +			io_err = -ENOMEM;
> +			addr = vring_map_one_sg(vq, sg, DMA_FROM_DEVICE);
>   			if (vring_mapping_error(vq, addr))
>   				goto unmap_release;


It looks to me all the evils came from the fact that we depends on the 
descriptor ring.

So the checks in this patch could is unnecessary if we don't even read 
from the descriptor ring which could be manipulated by the device.

This is what my series tries to achieve:

https://www.spinics.net/lists/kvm/msg241825.html

Thanks



>   
> @@ -513,6 +535,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>   		dma_addr_t addr = vring_map_single(
>   			vq, desc, total_sg * sizeof(struct vring_desc),
>   			DMA_TO_DEVICE);
> +		io_err = -ENOMEM;
>   		if (vring_mapping_error(vq, addr))
>   			goto unmap_release;
>   
> @@ -528,6 +551,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>   	/* We're using some buffers from the free list. */
>   	vq->vq.num_free -= descs_used;
>   
> +	io_err = -EIO;
> +	if (!inside_split_ring(vq, head))
> +		goto unmap_release;
> +
>   	/* Update free pointer */
>   	if (indirect)
>   		vq->free_head = virtio16_to_cpu(_vq->vdev,
> @@ -545,6 +572,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>   	/* Put entry in available array (but don't update avail->idx until they
>   	 * do sync). */
>   	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> +
> +	if (avail >= vq->split.vring.num)
> +		goto unmap_release;
> +
>   	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
>   
>   	/* Descriptors and available array need to be set before we expose the
> @@ -576,6 +607,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>   	for (n = 0; n < total_sg; n++) {
>   		if (i == err_idx)
>   			break;
> +		if (!inside_split_ring(vq, i))
> +			break;
>   		vring_unmap_one_split(vq, &desc[i]);
>   		i = virtio16_to_cpu(_vq->vdev, desc[i].next);
>   	}
> @@ -584,7 +617,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>   		kfree(desc);
>   
>   	END_USE(vq);
> -	return -ENOMEM;
> +	return io_err;
>   }
>   
>   static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
> @@ -1146,7 +1179,12 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>   	c = 0;
>   	for (n = 0; n < out_sgs + in_sgs; n++) {
>   		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
> -			dma_addr_t addr = vring_map_one_sg(vq, sg, n < out_sgs ?
> +			dma_addr_t addr;
> +
> +			if (curr >= vq->packed.vring.num)
> +				goto unmap_release;
> +
> +			addr = vring_map_one_sg(vq, sg, n < out_sgs ?
>   					DMA_TO_DEVICE : DMA_FROM_DEVICE);
>   			if (vring_mapping_error(vq, addr))
>   				goto unmap_release;

