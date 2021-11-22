Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9E1458A2D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 08:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbhKVH6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 02:58:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46184 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238829AbhKVH6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 02:58:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637567731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IDqi4ob8fjcAGc/R0j78nG91DfoEGPvFlcWEXhm0JSo=;
        b=UwjASDsrkUE6q1LThA9oITFMU36ikBtsCT4BLwUiRTpyoJSGqCxtHGtCYDBAAE9dfOkmS4
        4o0rc5wihHvnabDMVFBYDJCmdiSGX1xNoSbz2PdbiXxpnBltjSSZSAtJou8+NoJNXU0zEo
        1YV5uYvidP6EHOIAT4UqDQkHqrh7UhA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-439-Wo5vQAB_O_Cb-P0I3vLcPg-1; Mon, 22 Nov 2021 02:55:28 -0500
X-MC-Unique: Wo5vQAB_O_Cb-P0I3vLcPg-1
Received: by mail-ed1-f71.google.com with SMTP id k7-20020aa7c387000000b003e7ed87fb31so14093092edq.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 23:55:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IDqi4ob8fjcAGc/R0j78nG91DfoEGPvFlcWEXhm0JSo=;
        b=HQaHCtCHjSeGozfKmfxWls+pZYWV9LyPPKHgf+TszcJkoSF7FuzvCcD4v8JrmQZ8q5
         7hX6o0aSa/yIXecmxdFRuBzxOILGTsKgnNCzkbKXHrlhvRMhWpeUmNK85xxPpR4AUlZL
         anjqO8A6H9PusIv49KsilkKo6BQZOVFOe4pInRfBOwaSQxgTn6hNUiciyMuePXwpVkEt
         L75RBiNZaoQQiRDjKPUwjmSW6897DmHY8Vm5PFh9CS4T6ErKHIGjRqhMDKx56F6Pyccb
         bSrHwZb5fL7Fi7XIAhZO3D6ufsRdePKRPITL8UXfcmlsz72TY0Wz8W+ZMoDTRgNVs6RJ
         0Uaw==
X-Gm-Message-State: AOAM532FW84P+4+1pSXCI0zZLFktAzkKfCL6xH6kOA3hZGJXbgIjufhS
        45sDoDHE3L1gxFozsMOa3WvYouLJRuvhUzmpbwSx8aMt7j/IoweuF7Q34eX5AGWTXJIZglGxZ/X
        4DpPEshQPi+2IPKLmwaEFraf9
X-Received: by 2002:a17:907:9056:: with SMTP id az22mr37649784ejc.107.1637567727774;
        Sun, 21 Nov 2021 23:55:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxr5Z88UCz2WxnZ+CArseBtRmXEXQUcg3EZRyJJMf+J3roKDaJq3Gzds3ZkXyqietpG3a1qHQ==
X-Received: by 2002:a17:907:9056:: with SMTP id az22mr37649761ejc.107.1637567727603;
        Sun, 21 Nov 2021 23:55:27 -0800 (PST)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it. [87.10.72.39])
        by smtp.gmail.com with ESMTPSA id hp20sm2688651ejc.81.2021.11.21.23.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 23:55:27 -0800 (PST)
Date:   Mon, 22 Nov 2021 08:55:24 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>, mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
Message-ID: <20211122075524.lzojug4hspzglzhl@steredhat>
References: <20211027022107.14357-1-jasowang@redhat.com>
 <20211027022107.14357-2-jasowang@redhat.com>
 <20211119160951.5f2294c8.pasic@linux.ibm.com>
 <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
 <20211122063518.37929c01.pasic@linux.ibm.com>
 <20211122064922.51b3678e.pasic@linux.ibm.com>
 <CACGkMEu+9FvMsghyi55Ee5BxetP-YK9wh2oaT8OgLiY5+tV0QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACGkMEu+9FvMsghyi55Ee5BxetP-YK9wh2oaT8OgLiY5+tV0QQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 02:25:26PM +0800, Jason Wang wrote:
>On Mon, Nov 22, 2021 at 1:49 PM Halil Pasic <pasic@linux.ibm.com> wrote:
>>
>> On Mon, 22 Nov 2021 06:35:18 +0100
>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>
>> > > I think it should be a common issue, looking at
>> > > vhost_vsock_handle_tx_kick(), it did:
>> > >
>> > > len += sizeof(pkt->hdr);
>> > > vhost_add_used(vq, head, len);
>> > >
>> > > which looks like a violation of the spec since it's TX.
>> >
>> > I'm not sure the lines above look like a violation of the spec. If you
>> > examine vhost_vsock_alloc_pkt() I believe that you will agree that:
>> > len == pkt->len == pkt->hdr.len
>> > which makes sense since according to the spec both tx and rx messages
>> > are hdr+payload. And I believe hdr.len is the size of the payload,
>> > although that does not seem to be properly documented by the spec.
>
>Sorry for being unclear, what I meant is that we probably should use
>zero here. TX doesn't use in buffer actually.
>
>According to the spec, 0 should be the used length:
>
>"and len the total of bytes written into the buffer."
>
>> >
>> > On the other hand tx messages are stated to be device read-only (in the
>> > spec) so if the device writes stuff, that is certainly wrong.
>> >
>
>Yes.
>
>> > If that is what happens.
>> >
>> > Looking at virtqueue_get_buf_ctx_split() I'm not sure that is what
>> > happens. My hypothesis is that we just a last descriptor is an 'in'
>> > type descriptor (i.e. a device writable one). For tx that assumption
>> > would be wrong.
>> >
>> > I will have another look at this today and send a fix patch if my
>> > suspicion is confirmed.
>>
>> If my suspicion is right something like:
>>
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> index 00f64f2f8b72..efb57898920b 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -764,6 +764,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>>         struct vring_virtqueue *vq = to_vvq(_vq);
>>         void *ret;
>>         unsigned int i;
>> +       bool has_in;
>>         u16 last_used;
>>
>>         START_USE(vq);
>> @@ -787,6 +788,9 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>>                         vq->split.vring.used->ring[last_used].id);
>>         *len = virtio32_to_cpu(_vq->vdev,
>>                         vq->split.vring.used->ring[last_used].len);
>> +       has_in = virtio16_to_cpu(_vq->vdev,
>> +                       vq->split.vring.used->ring[last_used].flags)
>> +                               & VRING_DESC_F_WRITE;
>
>Did you mean vring.desc actually? If yes, it's better not depend on
>the descriptor ring which can be modified by the device. We've stored
>the flags in desc_extra[].
>
>>
>>         if (unlikely(i >= vq->split.vring.num)) {
>>                 BAD_RING(vq, "id %u out of range\n", i);
>> @@ -796,7 +800,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>>                 BAD_RING(vq, "id %u is not a head!\n", i);
>>                 return NULL;
>>         }
>> -       if (vq->buflen && unlikely(*len > vq->buflen[i])) {
>> +       if (has_in && q->buflen && unlikely(*len > vq->buflen[i])) {
>>                 BAD_RING(vq, "used len %d is larger than in buflen %u\n",
>>                         *len, vq->buflen[i]);
>>                 return NULL;
>>
>> would fix the problem for split. I will try that out and let you know
>> later.
>
>I'm not sure I get this, in virtqueue_add_split, the buflen[i] only
>contains the in buffer length.
>
>I think the fixes are:
>
>1) fixing the vhost vsock

Yep, in vhost_vsock_handle_tx_kick() we should have vhost_add_used(vq, 
head, 0) since the device doesn't write anything.

>2) use suppress_used_validation=true to let vsock driver to validate
>the in buffer length
>3) probably a new feature so the driver can only enable the validation
>when the feature is enabled.

I fully agree with these steps.

Thanks,
Stefano

