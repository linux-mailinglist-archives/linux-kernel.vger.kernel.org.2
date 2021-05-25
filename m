Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A1F38F78F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 03:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhEYBdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 21:33:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49890 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229480AbhEYBdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 21:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621906309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cDdaKbZRoEfpRx7jvBHZ30BNzMElKWImpQ5xMxNgdjo=;
        b=SfA3m2VzLmYhEUyZxxfZJgSqpCLwYbQlhtL0zK8s3VXYuT1hVgLsL4dPm6IC0VMvBa8v9+
        Y2j71aITQ2NALkbDArvlKzFXGpL7dSSm6xLwWEFUVkzj5dMs3OLKUkty7rY/GaqmDPHRQ4
        FlePnPmJMupH0dfmOuYehAjBnE8H1pg=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-W39gDJscN2SmUiR_jVIrlw-1; Mon, 24 May 2021 21:31:47 -0400
X-MC-Unique: W39gDJscN2SmUiR_jVIrlw-1
Received: by mail-pf1-f197.google.com with SMTP id s5-20020aa78d450000b02902ace63a7e93so19376782pfe.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 18:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cDdaKbZRoEfpRx7jvBHZ30BNzMElKWImpQ5xMxNgdjo=;
        b=mTbIiV8uKYa90ETMekqgq8wioqXm5xLydnjY/AohgWyKfRsE3eLmdaV+kNqN+1B09r
         PX7R2L6C6K+LGf/iyPCa74NUEufcJhXZOdT6yKh4NEaLUUSk2vgQdM/R7fwU7itzsvF7
         FkBI/2OTyTjw91/bEQec6PDmRDxS9S925GR0d0d9Lfq6qbAi+oH5BabdZ2NejA5WYo2h
         qDlyxRop9Ftf6eReiIYMPrTxOSiR6DCWoX54o+SNrMYB798C4XdikuXvhVZnQiqWv18W
         nREnz4zSOCencmQu5snAlEed9NL8byhY50uR+exC92yVXvuj+pwqIRKDmXppOUBP/Re7
         TJ/A==
X-Gm-Message-State: AOAM5329HLo04waSIhJWXqM1tsNtDZNt9+Fe9uiHuQRGKA6f5UN9UBwe
        QMCrro6+Jx5izV2ylf1MYLlIUiTtMu4fi4+aPWus1ZULXVRd99QMtlpgvh6uQIMfrgLGgyspTtE
        wOKHuuuoqNfSJpjgk5Ccqje4GFoMh1Z7ecPt7xgO4oqdyQ++zM77fuyMK0NRyIH4igSKPpwAA1Z
        BA
X-Received: by 2002:a17:90b:1b4c:: with SMTP id nv12mr27605024pjb.55.1621906305717;
        Mon, 24 May 2021 18:31:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaC2zarJrBIyP6vFqRiVxlMn0IGK6h9Za0XGOhe7G4c1aNDy85YgjxCOlh7xcd0n+tZ+3O1A==
X-Received: by 2002:a17:90b:1b4c:: with SMTP id nv12mr27604972pjb.55.1621906305157;
        Mon, 24 May 2021 18:31:45 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f80sm11774204pfa.160.2021.05.24.18.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 18:31:44 -0700 (PDT)
Subject: Re: [RFC PATCH 17/17] virtio_ring: Add validation for used length
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>
Cc:     stefanha@redhat.com, amit@kernel.org, arei.gonglei@huawei.com,
        airlied@linux.ie, kraxel@redhat.com, dan.j.williams@intel.com,
        johannes@sipsolutions.net, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210517090836.533-1-xieyongji@bytedance.com>
 <20210517090836.533-18-xieyongji@bytedance.com>
 <20210517193641-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <3cda643a-1363-65bf-be84-f6dea6714477@redhat.com>
Date:   Tue, 25 May 2021 09:31:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210517193641-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/5/18 ÉÏÎç7:39, Michael S. Tsirkin Ð´µÀ:
> On Mon, May 17, 2021 at 05:08:36PM +0800, Xie Yongji wrote:
>> This adds validation for used length (might come
>> from an untrusted device) when it will be used by
>> virtio device driver.
>>
>> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>> ---
>>   drivers/virtio/virtio_ring.c | 22 +++++++++++++++++++---
>>   1 file changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> index d999a1d6d271..7d4845d06f21 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -68,11 +68,13 @@
>>   struct vring_desc_state_split {
>>   	void *data;			/* Data for callback. */
>>   	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
>> +	u32 in_len;			/* Total length of writable buffer */
>>   };
>>   
>>   struct vring_desc_state_packed {
>>   	void *data;			/* Data for callback. */
>>   	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
>> +	u32 in_len;			/* Total length of writable buffer */
>>   	u16 num;			/* Descriptor list length. */
>>   	u16 last;			/* The last desc state in a list. */
>>   };
>
> Hmm for packed it's aligned to 64 bit anyway, so we are not making it
> any worse. But for split this pushes struct size up by 1/3 increasing
> cache pressure.


We can eliminate this by validating through virtio device driver instead 
of virtio core.

E.g for virtio-net we know the rx buffer size so there's no need to 
store in twice in the core.

Thanks


>
>
>> @@ -486,7 +488,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>>   	struct vring_virtqueue *vq = to_vvq(_vq);
>>   	struct scatterlist *sg;
>>   	struct vring_desc *desc;
>> -	unsigned int i, n, avail, descs_used, prev, err_idx;
>> +	unsigned int i, n, avail, descs_used, prev, err_idx, in_len = 0;
>>   	int head;
>>   	bool indirect;
>>   
>> @@ -570,6 +572,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>>   						     VRING_DESC_F_NEXT |
>>   						     VRING_DESC_F_WRITE,
>>   						     indirect);
>> +			in_len += sg->length;
>>   		}
>>   	}
>>   	/* Last one doesn't continue. */
>> @@ -604,6 +607,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>>   
>>   	/* Store token and indirect buffer state. */
>>   	vq->split.desc_state[head].data = data;
>> +	vq->split.desc_state[head].in_len = in_len;
>>   	if (indirect)
>>   		vq->split.desc_state[head].indir_desc = desc;
>>   	else
>> @@ -784,6 +788,10 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>>   		BAD_RING(vq, "id %u is not a head!\n", i);
>>   		return NULL;
>>   	}
>> +	if (unlikely(len && vq->split.desc_state[i].in_len < *len)) {
>> +		BAD_RING(vq, "id %u has invalid length: %u!\n", i, *len);
>> +		return NULL;
>> +	}
>>   
>>   	/* detach_buf_split clears data, so grab it now. */
>>   	ret = vq->split.desc_state[i].data;
>> @@ -1059,7 +1067,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>>   {
>>   	struct vring_packed_desc *desc;
>>   	struct scatterlist *sg;
>> -	unsigned int i, n, err_idx;
>> +	unsigned int i, n, err_idx, in_len = 0;
>>   	u16 head, id;
>>   	dma_addr_t addr;
>>   
>> @@ -1084,6 +1092,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>>   			if (vring_mapping_error(vq, addr))
>>   				goto unmap_release;
>>   
>> +			in_len += (n < out_sgs) ? 0 : sg->length;
>>   			desc[i].flags = cpu_to_le16(n < out_sgs ?
>>   						0 : VRING_DESC_F_WRITE);
>>   			desc[i].addr = cpu_to_le64(addr);
>> @@ -1141,6 +1150,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>>   	vq->packed.desc_state[id].data = data;
>>   	vq->packed.desc_state[id].indir_desc = desc;
>>   	vq->packed.desc_state[id].last = id;
>> +	vq->packed.desc_state[id].in_len = in_len;
>>   
>>   	vq->num_added += 1;
>>   
>> @@ -1173,7 +1183,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>>   	struct vring_virtqueue *vq = to_vvq(_vq);
>>   	struct vring_packed_desc *desc;
>>   	struct scatterlist *sg;
>> -	unsigned int i, n, c, descs_used, err_idx;
>> +	unsigned int i, n, c, descs_used, err_idx, in_len = 0;
>>   	__le16 head_flags, flags;
>>   	u16 head, id, prev, curr, avail_used_flags;
>>   
>> @@ -1223,6 +1233,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>>   			if (vring_mapping_error(vq, addr))
>>   				goto unmap_release;
>>   
>> +			in_len += (n < out_sgs) ? 0 : sg->length;
>>   			flags = cpu_to_le16(vq->packed.avail_used_flags |
>>   				    (++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
>>   				    (n < out_sgs ? 0 : VRING_DESC_F_WRITE));
>> @@ -1268,6 +1279,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>>   	vq->packed.desc_state[id].data = data;
>>   	vq->packed.desc_state[id].indir_desc = ctx;
>>   	vq->packed.desc_state[id].last = prev;
>> +	vq->packed.desc_state[id].in_len = in_len;
>>   
>>   	/*
>>   	 * A driver MUST NOT make the first descriptor in the list
>> @@ -1456,6 +1468,10 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>>   		BAD_RING(vq, "id %u is not a head!\n", id);
>>   		return NULL;
>>   	}
>> +	if (unlikely(len && vq->packed.desc_state[id].in_len < *len)) {
>> +		BAD_RING(vq, "id %u has invalid length: %u!\n", id, *len);
>> +		return NULL;
>> +	}
>>   
>>   	/* detach_buf_packed clears data, so grab it now. */
>>   	ret = vq->packed.desc_state[id].data;
>> -- 
>> 2.11.0

