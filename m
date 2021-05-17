Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F397386DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 01:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343569AbhEQXk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 19:40:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24095 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237188AbhEQXk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 19:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621294749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GHKgU9Q5A+PSIQuhrOTutaLyelYrLl2q/I1h4tUs/Q4=;
        b=PH8Vd19sxUNJNfMIKZzso46KLSbqeG0dAchD5ZOgIxKAeGmbwmL9nNwHPLwRdthg0yy18t
        yckNEhQX2k+8pG0iR/WbklK8CcTGgrsHKdPoY5g+aGacmtoGDkvDQATJL62hMd63NxsnLn
        ILBYdE+R3B2IShLmXA0lXMng/oBch7M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-1BvbtFiFPheOzU6-kNhAFQ-1; Mon, 17 May 2021 19:39:08 -0400
X-MC-Unique: 1BvbtFiFPheOzU6-kNhAFQ-1
Received: by mail-wr1-f70.google.com with SMTP id 2-20020adf94020000b0290110481f75ddso4588825wrq.21
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 16:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GHKgU9Q5A+PSIQuhrOTutaLyelYrLl2q/I1h4tUs/Q4=;
        b=mP9YqUhZx2avv2rLdTCFnGu6UsXBlttF3Pa3lpeAjlRiMx9W61X0Y5SPJWrlbfqZ4H
         pfxc+fpnuLvGEw8+kQcQId/da4v/sZwEVJM7/J7xrJPZbH3Ucje/FWhx+X6FDVhUQ87/
         YlPaTFjpabdTEDVd/B+AY/G9vxN3yPzWri0/WBy7xh/7eDFp97QJYdRPg6BASiNWNBVL
         JZoqqGb/eQKjrC1A1zldg2TT5/sdR3vIPVA94QOLoY6OeaTT+HV4mUtQQfgn+BBDvxCC
         2C3JvMedfHd5YEq/taEzB5Z3T1fYvsgeyGQwER0E3FFTmY2lXtrGjrr3nooLrSq59QBu
         ax+w==
X-Gm-Message-State: AOAM531Vct0Luef3M7kXNjI36644AxtnfB5LwMzY+Ei4QvI2EhSQndLc
        UqPSr+uWnnYr7WvzbwCvMGocStjxetose5DVNX9clz8G/0s8GFbI8uWFHUd4YcnVI9FvrQ35Wch
        NhuRH3FVC10NPu3QW7EfLEvI4
X-Received: by 2002:a05:600c:acc:: with SMTP id c12mr2121669wmr.30.1621294747068;
        Mon, 17 May 2021 16:39:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgDKs89vnThJz4S6eo3XqRnZkkbH1B+nt2G0KOsFeeW+b/QXmSD89/63LPN9wqFkr5x/upYQ==
X-Received: by 2002:a05:600c:acc:: with SMTP id c12mr2121648wmr.30.1621294746783;
        Mon, 17 May 2021 16:39:06 -0700 (PDT)
Received: from redhat.com ([2a10:800c:1fa6:0:3809:fe0c:bb87:250e])
        by smtp.gmail.com with ESMTPSA id v12sm17497490wru.73.2021.05.17.16.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 16:39:06 -0700 (PDT)
Date:   Mon, 17 May 2021 19:39:02 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     jasowang@redhat.com, stefanha@redhat.com, amit@kernel.org,
        arei.gonglei@huawei.com, airlied@linux.ie, kraxel@redhat.com,
        dan.j.williams@intel.com, johannes@sipsolutions.net,
        ohad@wizery.com, bjorn.andersson@linaro.org, david@redhat.com,
        vgoyal@redhat.com, miklos@szeredi.hu, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 17/17] virtio_ring: Add validation for used length
Message-ID: <20210517193641-mutt-send-email-mst@kernel.org>
References: <20210517090836.533-1-xieyongji@bytedance.com>
 <20210517090836.533-18-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517090836.533-18-xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 05:08:36PM +0800, Xie Yongji wrote:
> This adds validation for used length (might come
> from an untrusted device) when it will be used by
> virtio device driver.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/virtio/virtio_ring.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index d999a1d6d271..7d4845d06f21 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -68,11 +68,13 @@
>  struct vring_desc_state_split {
>  	void *data;			/* Data for callback. */
>  	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
> +	u32 in_len;			/* Total length of writable buffer */
>  };
>  
>  struct vring_desc_state_packed {
>  	void *data;			/* Data for callback. */
>  	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
> +	u32 in_len;			/* Total length of writable buffer */
>  	u16 num;			/* Descriptor list length. */
>  	u16 last;			/* The last desc state in a list. */
>  };


Hmm for packed it's aligned to 64 bit anyway, so we are not making it
any worse. But for split this pushes struct size up by 1/3 increasing
cache pressure.


> @@ -486,7 +488,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  	struct scatterlist *sg;
>  	struct vring_desc *desc;
> -	unsigned int i, n, avail, descs_used, prev, err_idx;
> +	unsigned int i, n, avail, descs_used, prev, err_idx, in_len = 0;
>  	int head;
>  	bool indirect;
>  
> @@ -570,6 +572,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  						     VRING_DESC_F_NEXT |
>  						     VRING_DESC_F_WRITE,
>  						     indirect);
> +			in_len += sg->length;
>  		}
>  	}
>  	/* Last one doesn't continue. */
> @@ -604,6 +607,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  
>  	/* Store token and indirect buffer state. */
>  	vq->split.desc_state[head].data = data;
> +	vq->split.desc_state[head].in_len = in_len;
>  	if (indirect)
>  		vq->split.desc_state[head].indir_desc = desc;
>  	else
> @@ -784,6 +788,10 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  		BAD_RING(vq, "id %u is not a head!\n", i);
>  		return NULL;
>  	}
> +	if (unlikely(len && vq->split.desc_state[i].in_len < *len)) {
> +		BAD_RING(vq, "id %u has invalid length: %u!\n", i, *len);
> +		return NULL;
> +	}
>  
>  	/* detach_buf_split clears data, so grab it now. */
>  	ret = vq->split.desc_state[i].data;
> @@ -1059,7 +1067,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  {
>  	struct vring_packed_desc *desc;
>  	struct scatterlist *sg;
> -	unsigned int i, n, err_idx;
> +	unsigned int i, n, err_idx, in_len = 0;
>  	u16 head, id;
>  	dma_addr_t addr;
>  
> @@ -1084,6 +1092,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  			if (vring_mapping_error(vq, addr))
>  				goto unmap_release;
>  
> +			in_len += (n < out_sgs) ? 0 : sg->length;
>  			desc[i].flags = cpu_to_le16(n < out_sgs ?
>  						0 : VRING_DESC_F_WRITE);
>  			desc[i].addr = cpu_to_le64(addr);
> @@ -1141,6 +1150,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	vq->packed.desc_state[id].data = data;
>  	vq->packed.desc_state[id].indir_desc = desc;
>  	vq->packed.desc_state[id].last = id;
> +	vq->packed.desc_state[id].in_len = in_len;
>  
>  	vq->num_added += 1;
>  
> @@ -1173,7 +1183,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  	struct vring_packed_desc *desc;
>  	struct scatterlist *sg;
> -	unsigned int i, n, c, descs_used, err_idx;
> +	unsigned int i, n, c, descs_used, err_idx, in_len = 0;
>  	__le16 head_flags, flags;
>  	u16 head, id, prev, curr, avail_used_flags;
>  
> @@ -1223,6 +1233,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  			if (vring_mapping_error(vq, addr))
>  				goto unmap_release;
>  
> +			in_len += (n < out_sgs) ? 0 : sg->length;
>  			flags = cpu_to_le16(vq->packed.avail_used_flags |
>  				    (++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
>  				    (n < out_sgs ? 0 : VRING_DESC_F_WRITE));
> @@ -1268,6 +1279,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  	vq->packed.desc_state[id].data = data;
>  	vq->packed.desc_state[id].indir_desc = ctx;
>  	vq->packed.desc_state[id].last = prev;
> +	vq->packed.desc_state[id].in_len = in_len;
>  
>  	/*
>  	 * A driver MUST NOT make the first descriptor in the list
> @@ -1456,6 +1468,10 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  		BAD_RING(vq, "id %u is not a head!\n", id);
>  		return NULL;
>  	}
> +	if (unlikely(len && vq->packed.desc_state[id].in_len < *len)) {
> +		BAD_RING(vq, "id %u has invalid length: %u!\n", id, *len);
> +		return NULL;
> +	}
>  
>  	/* detach_buf_packed clears data, so grab it now. */
>  	ret = vq->packed.desc_state[id].data;
> -- 
> 2.11.0

