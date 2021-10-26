Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFF643AF54
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 11:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbhJZJqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 05:46:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48166 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234436AbhJZJqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 05:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635241440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zY+n168HvaQy+Jr4HQ6Xvqhb08iehNo+XRgzPGcl1Tg=;
        b=UgfHMrQHzjdf8QoJnaB6B6qQN9TDXp1P8Ou49VH7xzClD5uUsnJhw95nI7or/rF9MYUR6u
        N1GF49m8h0DWbnG5mXJDeDECrJAuOsMxtqOLJz0q8HFP2YQlhlPKIMLeFwA0wr4NKsPXoa
        v31ru9DtSNcwyzYmBniSeNVh2cD8mVs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-jxghiJWUOJyi-5tpCR9nPg-1; Tue, 26 Oct 2021 05:43:59 -0400
X-MC-Unique: jxghiJWUOJyi-5tpCR9nPg-1
Received: by mail-ed1-f71.google.com with SMTP id s12-20020a50dacc000000b003dbf7a78e88so12532879edj.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 02:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zY+n168HvaQy+Jr4HQ6Xvqhb08iehNo+XRgzPGcl1Tg=;
        b=lS44vlS7VirQkFDVRl8DDsEvQolqxEePw5qe25ip/14cHTIR4Ia3+D8DFI0yX4pQpG
         DmYhjfXZ/iIA4Vq1F2Pp2TzGoI8MtbYjd3W7HpC/MpVO0aWHeYUhiCdiZkr+eEMbro0Z
         KWls3gtS6doQ7SfIspadAoIe4txrOpbmucdSC5dJtcyCV7jBGT3TnSlKaR+H8+abwiHz
         r+wIvGeBUaOuUQcViILbuR1hZJdcjsEnupDufNQgAqFJ2wC0poHieIiuAfOvKnM7GOGm
         1K1ofBvvxeNoaoGDxSUZJ2ZyQU1tJmF+fNWyCQ7Rs2dMPJtAsDalPRSrUmi+v7Q3/8nj
         PEnw==
X-Gm-Message-State: AOAM530jOXVI5tn6Y9KBLZGOqnyD9KbroAJyWYF8zmAivlyetVh/GQf3
        612OAyWA/RRmSwQV23b4IESO4i8c+FULPn5SRtbumD5Q0yIF9Fc/DnkcIZCAjO0Ye96CDxSRVGn
        uGPwsHRnncEcBrHZs9/NXu5dl
X-Received: by 2002:a05:6402:5215:: with SMTP id s21mr34548643edd.113.1635241438074;
        Tue, 26 Oct 2021 02:43:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGZvAuL1tWK4LJJLhSJsh854psmRlW97J4dwyBjeAnXu/yOwm9Q5v9Sb3UeaqlNTnjh5A8Iw==
X-Received: by 2002:a05:6402:5215:: with SMTP id s21mr34548561edd.113.1635241437363;
        Tue, 26 Oct 2021 02:43:57 -0700 (PDT)
Received: from redhat.com ([2.55.19.80])
        by smtp.gmail.com with ESMTPSA id w18sm11564987edc.4.2021.10.26.02.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 02:43:56 -0700 (PDT)
Date:   Tue, 26 Oct 2021 05:43:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com
Subject: Re: [PATCH V4 1/4] virtio_ring: validate used buffer length
Message-ID: <20211026053741-mutt-send-email-mst@kernel.org>
References: <20211026072000.8699-1-jasowang@redhat.com>
 <20211026072000.8699-2-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026072000.8699-2-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 03:19:57PM +0800, Jason Wang wrote:
> This patch validate the used buffer length provided by the device
> before trying to use it. This is done by record the in buffer length
> in a new field in desc_state structure during virtqueue_add(), then we
> can fail the virtqueue_get_buf() when we find the device is trying to
> give us a used buffer length which is greater than the in buffer
> length.
> 
> Since some drivers have already done the validation by themselves,
> this patch tries to makes the core validation optional. For the driver
> that doesn't want the validation, it can set the validate_used to be
> true (which could be overridden by force_used_validation). To be more

This description is now out of date. it's suppress_used_validation.

> efficient, a dedicate array is used for storing the validate used
> length, this helps to eliminate the cache stress if validation is done
> by the driver.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 60 ++++++++++++++++++++++++++++++++++++
>  include/linux/virtio.h       |  2 ++
>  2 files changed, 62 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 4c0ec82cef56..a6e5a3b94337 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -14,6 +14,9 @@
>  #include <linux/spinlock.h>
>  #include <xen/xen.h>
>  
> +static bool force_used_validation = false;
> +module_param(force_used_validation, bool, 0444);
> +
>  #ifdef DEBUG
>  /* For development, we want to crash whenever the ring is screwed. */
>  #define BAD_RING(_vq, fmt, args...)				\
> @@ -182,6 +185,9 @@ struct vring_virtqueue {
>  		} packed;
>  	};
>  
> +	/* Per-descriptor in buffer length */
> +	u32 *buflen;
> +
>  	/* How to notify other side. FIXME: commonalize hcalls! */
>  	bool (*notify)(struct virtqueue *vq);
>  
> @@ -490,6 +496,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	unsigned int i, n, avail, descs_used, prev, err_idx;
>  	int head;
>  	bool indirect;
> +	u32 buflen = 0;
>  
>  	START_USE(vq);
>  
> @@ -571,6 +578,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  						     VRING_DESC_F_NEXT |
>  						     VRING_DESC_F_WRITE,
>  						     indirect);
> +			buflen += sg->length;
>  		}
>  	}
>  	/* Last one doesn't continue. */
> @@ -610,6 +618,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	else
>  		vq->split.desc_state[head].indir_desc = ctx;
>  
> +	/* Store in buffer length if necessary */
> +	if (vq->buflen)
> +		vq->buflen[head] = buflen;
> +
>  	/* Put entry in available array (but don't update avail->idx until they
>  	 * do sync). */
>  	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> @@ -784,6 +796,11 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  		BAD_RING(vq, "id %u is not a head!\n", i);
>  		return NULL;
>  	}
> +	if (vq->buflen && unlikely(*len > vq->buflen[i])) {
> +		BAD_RING(vq, "used len %d is larger than in buflen %u\n",
> +			*len, vq->buflen[i]);
> +		return NULL;
> +	}
>  
>  	/* detach_buf_split clears data, so grab it now. */
>  	ret = vq->split.desc_state[i].data;
> @@ -1062,6 +1079,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	unsigned int i, n, err_idx;
>  	u16 head, id;
>  	dma_addr_t addr;
> +	u32 buflen = 0;
>  
>  	head = vq->packed.next_avail_idx;
>  	desc = alloc_indirect_packed(total_sg, gfp);
> @@ -1091,6 +1109,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  			desc[i].addr = cpu_to_le64(addr);
>  			desc[i].len = cpu_to_le32(sg->length);
>  			i++;
> +			if (n >= out_sgs)
> +				buflen += sg->length;
>  		}
>  	}
>  
> @@ -1144,6 +1164,10 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	vq->packed.desc_state[id].indir_desc = desc;
>  	vq->packed.desc_state[id].last = id;
>  
> +	/* Store in buffer length if necessary */
> +	if (vq->buflen)
> +		vq->buflen[id] = buflen;
> +
>  	vq->num_added += 1;
>  
>  	pr_debug("Added buffer head %i to %p\n", head, vq);
> @@ -1179,6 +1203,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  	__le16 head_flags, flags;
>  	u16 head, id, prev, curr, avail_used_flags;
>  	int err;
> +	u32 buflen = 0;
>  
>  	START_USE(vq);
>  
> @@ -1258,6 +1283,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  					1 << VRING_PACKED_DESC_F_AVAIL |
>  					1 << VRING_PACKED_DESC_F_USED;
>  			}
> +			if (n >= out_sgs)
> +				buflen += sg->length;
>  		}
>  	}
>  
> @@ -1277,6 +1304,10 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  	vq->packed.desc_state[id].indir_desc = ctx;
>  	vq->packed.desc_state[id].last = prev;
>  
> +	/* Store in buffer length if necessary */
> +	if (vq->buflen)
> +		vq->buflen[id] = buflen;
> +
>  	/*
>  	 * A driver MUST NOT make the first descriptor in the list
>  	 * available before all subsequent descriptors comprising
> @@ -1463,6 +1494,11 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  		BAD_RING(vq, "id %u is not a head!\n", id);
>  		return NULL;
>  	}
> +	if (vq->buflen && unlikely(*len > vq->buflen[id])) {
> +		BAD_RING(vq, "used len %d is larger than in buflen %u\n",
> +			*len, vq->buflen[id]);
> +		return NULL;
> +	}
>  
>  	/* detach_buf_packed clears data, so grab it now. */
>  	ret = vq->packed.desc_state[id].data;
> @@ -1668,6 +1704,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  	struct vring_virtqueue *vq;
>  	struct vring_packed_desc *ring;
>  	struct vring_packed_desc_event *driver, *device;
> +	struct virtio_driver *drv = drv_to_virtio(vdev->dev.driver);
>  	dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma_addr;
>  	size_t ring_size_in_bytes, event_size_in_bytes;
>  
> @@ -1757,6 +1794,15 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  	if (!vq->packed.desc_extra)
>  		goto err_desc_extra;
>  
> +	if (!drv->suppress_used_validation || force_used_validation) {
> +		vq->buflen = kmalloc_array(num, sizeof(*vq->buflen),
> +					   GFP_KERNEL);
> +		if (!vq->buflen)
> +			goto err_buflen;
> +	} else {
> +		vq->buflen = NULL;
> +	}
> +
>  	/* No callback?  Tell other side not to bother us. */
>  	if (!callback) {
>  		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
> @@ -1769,6 +1815,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  	spin_unlock(&vdev->vqs_list_lock);
>  	return &vq->vq;
>  
> +err_buflen:
> +	kfree(vq->packed.desc_extra);
>  err_desc_extra:
>  	kfree(vq->packed.desc_state);
>  err_desc_state:
> @@ -2176,6 +2224,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  					void (*callback)(struct virtqueue *),
>  					const char *name)
>  {
> +	struct virtio_driver *drv = drv_to_virtio(vdev->dev.driver);
>  	struct vring_virtqueue *vq;
>  
>  	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
> @@ -2235,6 +2284,15 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  	if (!vq->split.desc_extra)
>  		goto err_extra;
>  
> +	if (!drv->suppress_used_validation || force_used_validation) {
> +		vq->buflen = kmalloc_array(vring.num, sizeof(*vq->buflen),
> +					   GFP_KERNEL);
> +		if (!vq->buflen)
> +			goto err_buflen;
> +	} else {
> +		vq->buflen = NULL;
> +	}
> +
>  	/* Put everything in free lists. */
>  	vq->free_head = 0;
>  	memset(vq->split.desc_state, 0, vring.num *
> @@ -2245,6 +2303,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  	spin_unlock(&vdev->vqs_list_lock);
>  	return &vq->vq;
>  
> +err_buflen:
> +	kfree(vq->split.desc_extra);
>  err_extra:
>  	kfree(vq->split.desc_state);
>  err_state:
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 41edbc01ffa4..44d0e09da2d9 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -152,6 +152,7 @@ size_t virtio_max_dma_size(struct virtio_device *vdev);
>   * @feature_table_size: number of entries in the feature table array.
>   * @feature_table_legacy: same as feature_table but when working in legacy mode.
>   * @feature_table_size_legacy: number of entries in feature table legacy array.
> + * @suppress_used_validation: set to not have core validate used length
>   * @probe: the function to call when a device is found.  Returns 0 or -errno.
>   * @scan: optional function to call after successful probe; intended
>   *    for virtio-scsi to invoke a scan.
> @@ -168,6 +169,7 @@ struct virtio_driver {
>  	unsigned int feature_table_size;
>  	const unsigned int *feature_table_legacy;
>  	unsigned int feature_table_size_legacy;
> +	bool suppress_used_validation;
>  	int (*validate)(struct virtio_device *dev);
>  	int (*probe)(struct virtio_device *dev);
>  	void (*scan)(struct virtio_device *dev);
> -- 
> 2.25.1

