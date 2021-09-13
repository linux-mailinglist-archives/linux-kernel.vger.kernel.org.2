Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5864084C8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 08:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237387AbhIMGhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 02:37:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26737 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232146AbhIMGhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 02:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631514981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uxbSEm+jnbY3ATMV8W8lKCp8/asiFQKlsS1M8LUh7F8=;
        b=N/I1nRE8nAatD247P22U0xsmatpTW5DNrbN65Etg+8PMdlJilm03dBEJR6dd/UYR5/wYwn
        CTKJOtsJDxBTq4MO8bw2Pqmh/f1y0mo6YvPfBn8UdiIMBJUG8+sgtwdvZx3I4FIae0eiy7
        8DJDzeV48GfzC+Xu+Kga0UOdKseGEw4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-D3wSNGUBPB-XXKpo91ceAQ-1; Mon, 13 Sep 2021 02:36:17 -0400
X-MC-Unique: D3wSNGUBPB-XXKpo91ceAQ-1
Received: by mail-ed1-f71.google.com with SMTP id y17-20020a50e611000000b003d051004603so3728101edm.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 23:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uxbSEm+jnbY3ATMV8W8lKCp8/asiFQKlsS1M8LUh7F8=;
        b=eD5d4soRmxzDAPceASQbRra6sL/eX7b0aJbP4AmATn4ntSKCeifiOf6f5x9+OhLtP2
         XHJoYopvkBIA69Bbsiec4KeAGq0gXN+5tw3XPISaHxenlrXvkNYI2CqBrnppATdBegG6
         OUf+I5xCrLv2bNkvnB6LvI8PLZk83kUc6JQALC5lVxXvDouITRDkWtUhO6oW0XrrcPCO
         UpAJ2Xzs+gc4qFirIDyS6dpIbWHIXg0H3xw97ze9Bbq3wVmiDZixJF+FiirEsF68MfjI
         SACNsbYgjUgXvdVVLAw5Gp6XWe5yf6QgE0l4c4bXtgU8wBnPTsncW7wGyYiHLDSG3xjq
         2gFg==
X-Gm-Message-State: AOAM5319ENo5LK+G/DqT/8ByW50wI5i0FmSWGmbMNN0EH6AMrdrMb01n
        +lbweUecl2e6bYpG1gtmRE0NMAHHkUw+SvrNbLdOawl5tr+EWn6CnAT7iaR5U19RmcPRnP2NPX+
        yYqP0IV22TpxKHXi4QhD36Dpm
X-Received: by 2002:a17:906:7848:: with SMTP id p8mr11096463ejm.212.1631514976740;
        Sun, 12 Sep 2021 23:36:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykxKexMV48t4flDiOiBz8OweE9Le6nVdW4dPwS+jLsJYOAtzwPKxAZttQtPsVXfJCUG4BX1w==
X-Received: by 2002:a17:906:7848:: with SMTP id p8mr11096455ejm.212.1631514976503;
        Sun, 12 Sep 2021 23:36:16 -0700 (PDT)
Received: from redhat.com ([2.55.27.174])
        by smtp.gmail.com with ESMTPSA id q18sm2960988ejc.84.2021.09.12.23.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 23:36:16 -0700 (PDT)
Date:   Mon, 13 Sep 2021 02:36:12 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 9/9] virtio_ring: validate used buffer length
Message-ID: <20210913023428-mutt-send-email-mst@kernel.org>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-10-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913055353.35219-10-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 01:53:53PM +0800, Jason Wang wrote:
> This patch validate the used buffer length provided by the device
> before trying to use it. This is done by record the in buffer length
> in a new field in desc_state structure during virtqueue_add(), then we
> can fail the virtqueue_get_buf() when we find the device is trying to
> give us a used buffer length which is greater than the in buffer
> length.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Hmm this was proposed in the past. The overhead here is
not negligeable, so I'd like to know more -
when is it a problem if the used len is too big?
Don't the affected drivers already track the length somewhere
and so can validated it without the extra cost in
virtio core?

> ---
>  drivers/virtio/virtio_ring.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index d2ca0a7365f8..b8374a6144f3 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -69,6 +69,7 @@
>  struct vring_desc_state_split {
>  	void *data;			/* Data for callback. */
>  	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
> +	u64 buflen;			/* In buffer length */
>  };
>  
>  struct vring_desc_state_packed {
> @@ -76,6 +77,7 @@ struct vring_desc_state_packed {
>  	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
>  	u16 num;			/* Descriptor list length. */
>  	u16 last;			/* The last desc state in a list. */
> +	u64 buflen;			/* In buffer length */
>  };
>  
>  struct vring_desc_extra {
> @@ -490,6 +492,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	unsigned int i, n, avail, descs_used, prev, err_idx;
>  	int head;
>  	bool indirect;
> +	u64 buflen = 0;
>  
>  	START_USE(vq);
>  
> @@ -571,6 +574,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  						     VRING_DESC_F_NEXT |
>  						     VRING_DESC_F_WRITE,
>  						     indirect);
> +			buflen += sg->length;
>  		}
>  	}
>  	/* Last one doesn't continue. */
> @@ -605,6 +609,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  
>  	/* Store token and indirect buffer state. */
>  	vq->split.desc_state[head].data = data;
> +	vq->split.desc_state[head].buflen = buflen;
>  	if (indirect)
>  		vq->split.desc_state[head].indir_desc = desc;
>  	else
> @@ -784,6 +789,11 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  		BAD_RING(vq, "id %u is not a head!\n", i);
>  		return NULL;
>  	}
> +	if (unlikely(*len > vq->split.desc_state[i].buflen)) {
> +		BAD_RING(vq, "used len %d is larger than in buflen %lld\n",
> +			*len, vq->split.desc_state[i].buflen);
> +		return NULL;
> +	}
>  
>  	/* detach_buf_split clears data, so grab it now. */
>  	ret = vq->split.desc_state[i].data;
> @@ -1062,6 +1072,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	unsigned int i, n, err_idx;
>  	u16 head, id;
>  	dma_addr_t addr;
> +	u64 buflen = 0;
>  
>  	head = vq->packed.next_avail_idx;
>  	desc = alloc_indirect_packed(total_sg, gfp);
> @@ -1089,6 +1100,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  			desc[i].addr = cpu_to_le64(addr);
>  			desc[i].len = cpu_to_le32(sg->length);
>  			i++;
> +			if (n >= out_sgs)
> +				buflen += sg->length;
>  		}
>  	}
>  
> @@ -1141,6 +1154,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	vq->packed.desc_state[id].data = data;
>  	vq->packed.desc_state[id].indir_desc = desc;
>  	vq->packed.desc_state[id].last = id;
> +	vq->packed.desc_state[id].buflen = buflen;
>  
>  	vq->num_added += 1;
>  
> @@ -1176,6 +1190,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  	unsigned int i, n, c, descs_used, err_idx;
>  	__le16 head_flags, flags;
>  	u16 head, id, prev, curr, avail_used_flags;
> +	u64 buflen = 0;
>  
>  	START_USE(vq);
>  
> @@ -1250,6 +1265,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  					1 << VRING_PACKED_DESC_F_AVAIL |
>  					1 << VRING_PACKED_DESC_F_USED;
>  			}
> +			if (n >= out_sgs)
> +				buflen += sg->length;
>  		}
>  	}
>  
> @@ -1268,6 +1285,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  	vq->packed.desc_state[id].data = data;
>  	vq->packed.desc_state[id].indir_desc = ctx;
>  	vq->packed.desc_state[id].last = prev;
> +	vq->packed.desc_state[id].buflen = buflen;
>  
>  	/*
>  	 * A driver MUST NOT make the first descriptor in the list
> @@ -1455,6 +1473,11 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  		BAD_RING(vq, "id %u is not a head!\n", id);
>  		return NULL;
>  	}
> +	if (unlikely(*len > vq->packed.desc_state[id].buflen)) {
> +		BAD_RING(vq, "used len %d is larger than in buflen %lld\n",
> +			*len, vq->packed.desc_state[id].buflen);
> +		return NULL;
> +	}
>  
>  	/* detach_buf_packed clears data, so grab it now. */
>  	ret = vq->packed.desc_state[id].data;
> -- 
> 2.25.1

