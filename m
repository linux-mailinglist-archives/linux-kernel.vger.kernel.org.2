Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A146A399809
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 04:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhFCCbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 22:31:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21008 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229617AbhFCCbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 22:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622687360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z8pfT0MZqL2Z8bkqcby4E+RJ01PN1727vqn0BLJ23M4=;
        b=YrsblBJxGFPGmWEp9uk++ymjnAe+NFQdCH6ZGidXLDczA9Ynferz1MIOXG0FXcoSsKyozG
        mFX008wBHU5+3cnMKrDBGTGsM1N69tz9JVTFAnb5+tb75VMt/4gcDkrQmnkYlIK8hc0hxF
        1JbHlRNrxueVa7Db4DjUlzug1zvWGg4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-JhIIHIRvNh2bAmmkMmAurQ-1; Wed, 02 Jun 2021 22:29:19 -0400
X-MC-Unique: JhIIHIRvNh2bAmmkMmAurQ-1
Received: by mail-pf1-f197.google.com with SMTP id e20-20020a62ee140000b02902ea0a23d589so2648782pfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 19:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Z8pfT0MZqL2Z8bkqcby4E+RJ01PN1727vqn0BLJ23M4=;
        b=nHcmAxrdYlnSUKhd/Kx4kTybQhkPISr5FyeneW7wOkDi6YrSJOzS/HoU85K3F3TD54
         U+MF+f0ZtPeELjzTf8dhsoSazs653a/QnxowT3aXkiWVrsbQwmNmBtF9yOVZms5uzgie
         uvLVNgjik9dxQK/y0Wv4kB4A/0pYBDbaeDFsedTxnut/MS3oqTF03Z76xXXwj+c5xGiF
         DQZmmpmONBv2SRBUIo77cd8D1fC87AEFdATb6DhouC2g0Tn5CuqNTtt6St8fO4YeNMl7
         O95ZcjhrkuhY9xsGwMBqTcgtjn1geusNb7/DJICvIoA2UgjT988G61WkV/Gj+UgJ9oJV
         phHQ==
X-Gm-Message-State: AOAM532wXMUyvwetNPYzJPXQhJN4Q441cZW0wgkKdC6brfu+WDryFPAH
        cN//MfM/PZu4oZVnz+C/vuSzmaZSQNTB60R+GmkzZwqeDPOygAn+o3de/dkUDYSO/z0EzX38Vwj
        2PK1+olmSZZEXt9/fZUN4wrvX3OXrweJZKm7mKRYpWk/4P6KId/OUoH8/U7EzZSPUFcgPYepZ3E
        46
X-Received: by 2002:a17:90a:af8b:: with SMTP id w11mr33995001pjq.228.1622687357850;
        Wed, 02 Jun 2021 19:29:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcAOh1B5HwVx/1uLe5ueMMD2TZKV165kULJvA56z6ifNMCkU6WkR/FyKpm6p4cpf8KJgEpBw==
X-Received: by 2002:a17:90a:af8b:: with SMTP id w11mr33994974pjq.228.1622687357476;
        Wed, 02 Jun 2021 19:29:17 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f2sm895145pgl.67.2021.06.02.19.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 19:29:17 -0700 (PDT)
Subject: Re: [PATCH v1 3/8] virtio: Harden split buffer detachment
To:     Andi Kleen <ak@linux.intel.com>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-4-ak@linux.intel.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <284ca65d-d8b4-a671-4dba-df478a3610f1@redhat.com>
Date:   Thu, 3 Jun 2021 10:29:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603004133.4079390-4-ak@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/3 上午8:41, Andi Kleen 写道:
> Harden the split buffer detachment path by adding boundary checking. Note
> that when this fails we may fail to unmap some swiotlb mapping, which could
> result in a leak and a DOS. But that's acceptable because an malicious host
> can DOS us anyways.
>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>   drivers/virtio/virtio_ring.c | 25 +++++++++++++++++++++----
>   1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index d37ff5a0ff58..1e9aa1e95e1b 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -651,12 +651,19 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
>   	return needs_kick;
>   }
>   
> -static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> -			     void **ctx)
> +static int detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> +			    void **ctx)
>   {
>   	unsigned int i, j;
>   	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
>   
> +	/* We'll leak DMA mappings when this happens, but nothing
> +	 * can be done about that. In the worst case the host
> +	 * could DOS us, but it can of course do that anyways.
> +	 */
> +	if (!inside_split_ring(vq, head))
> +		return -EIO;


I think the caller have already did this for us with even more check on 
the token (virtqueue_get_buf_ctx_split()):

         if (unlikely(i >= vq->split.vring.num)) {
                 BAD_RING(vq, "id %u out of range\n", i);
                 return NULL;
         }
         if (unlikely(!vq->split.desc_state[i].data)) {
                 BAD_RING(vq, "id %u is not a head!\n", i);
                 return NULL;
         }


> +
>   	/* Clear data ptr. */
>   	vq->split.desc_state[head].data = NULL;
>   
> @@ -666,6 +673,8 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>   	while (vq->split.vring.desc[i].flags & nextflag) {
>   		vring_unmap_one_split(vq, &vq->split.vring.desc[i]);
>   		i = virtio16_to_cpu(vq->vq.vdev, vq->split.vring.desc[i].next);
> +		if (!inside_split_ring(vq, i))
> +			return -EIO;


Similarly, if we don't depend on the metadata stored in the descriptor, 
we don't need this check.


>   		vq->vq.num_free++;
>   	}
>   
> @@ -684,7 +693,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>   
>   		/* Free the indirect table, if any, now that it's unmapped. */
>   		if (!indir_desc)
> -			return;
> +			return 0;
>   
>   		len = virtio32_to_cpu(vq->vq.vdev,
>   				vq->split.vring.desc[head].len);
> @@ -701,6 +710,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>   	} else if (ctx) {
>   		*ctx = vq->split.desc_state[head].indir_desc;
>   	}
> +	return 0;
>   }
>   
>   static inline bool more_used_split(const struct vring_virtqueue *vq)
> @@ -717,6 +727,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>   	void *ret;
>   	unsigned int i;
>   	u16 last_used;
> +	int err;
>   
>   	START_USE(vq);
>   
> @@ -751,7 +762,12 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>   
>   	/* detach_buf_split clears data, so grab it now. */
>   	ret = vq->split.desc_state[i].data;
> -	detach_buf_split(vq, i, ctx);
> +	err = detach_buf_split(vq, i, ctx);
> +	if (err) {
> +		END_USE(vq);


This reminds me that we don't use END_USE() after BAD_RING() which 
should be fixed.

Thanks


> +		return NULL;
> +	}
> +
>   	vq->last_used_idx++;
>   	/* If we expect an interrupt for the next entry, tell host
>   	 * by writing event index and flush out the write before
> @@ -863,6 +879,7 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
>   		/* detach_buf_split clears data, so grab it now. */
>   		buf = vq->split.desc_state[i].data;
>   		detach_buf_split(vq, i, NULL);
> +		/* Don't need to check for error because nothing is returned */
>   		vq->split.avail_idx_shadow--;
>   		vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>   				vq->split.avail_idx_shadow);

