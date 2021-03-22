Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D14D343B84
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 09:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhCVIR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 04:17:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35121 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229973AbhCVIRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 04:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616401061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PsZodVPsWs6YP/fF4pvWwqUUa+rr5N0r5iTqRaFVfOc=;
        b=Iz3rC6FfvjiIVTLEKk8jaR2PSkdHE3DsDI2VjqdJGkyFpd2a7+UbYpKBUnAs3NUZWEwAcB
        gdcussZSt/hlMgQeLyD6b1dBiD2eW6FGe9kXQ5DEdMjCofKRT1mPwN0uSPIzzpH3/yTBBY
        V310EnI3Y7G/DXOzNbKTiIDN2om6Blk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-WUO73S-YNDy47Y8XXr5rKg-1; Mon, 22 Mar 2021 04:17:39 -0400
X-MC-Unique: WUO73S-YNDy47Y8XXr5rKg-1
Received: by mail-wr1-f72.google.com with SMTP id p15so25404241wre.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 01:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PsZodVPsWs6YP/fF4pvWwqUUa+rr5N0r5iTqRaFVfOc=;
        b=cfwgKpiLXIJ4f90QvyMPcZCe380LtPoK9WKV+xBi7YXU6S31Jx6wbxeXOhkBnBr9jG
         lt6VjTP1tbdZI+eZ9671jgjr19k/sQnUQjsJeorudSqs1MlGhgoZIxgNjGExodyjnMij
         8pnbCxC1bhtdt2cqM9EIxkee958bTpq5hYGn868WtKCY6ssIhUXUSyLTK3zx0l8M9WVx
         RGmBhHIUohqAbjfowo0U8vqIjP6P0yZ+/HTv2J3xd26A5vdrvCQ262p+nOXcCfEynla7
         wbJW8LhpmxMehiNBLFmmqZTGanlAFxVhHj2t1pbp0o03KqKw8r5g0zqDI3vjys4oC5p9
         61nw==
X-Gm-Message-State: AOAM533Hg0OcUDlkjOMeBh6oU0zOixFTNOxTNv6cIiigUSACupYrHc2i
        xP5SNGmVNKeXys0DsPwFLDMz05hXeRMlFfOrn3gB36KMJkCKOFRnhbwzshbtEZJzygbMlwzu7Hy
        yr0hIM4xY801MY7lEJO7k/8MX
X-Received: by 2002:a5d:4ecf:: with SMTP id s15mr17188155wrv.222.1616401057445;
        Mon, 22 Mar 2021 01:17:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylZqhTCHG8w045DowIsxunwGOileNP81Z98LrDX9nf428OhlNQeHBKBDDVXpT/YRj5Vf8BjA==
X-Received: by 2002:a5d:4ecf:: with SMTP id s15mr17188137wrv.222.1616401057261;
        Mon, 22 Mar 2021 01:17:37 -0700 (PDT)
Received: from redhat.com ([2a10:800e:f0d3:0:b69b:9fb8:3947:5636])
        by smtp.gmail.com with ESMTPSA id a14sm20018493wrg.84.2021.03.22.01.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 01:17:36 -0700 (PDT)
Date:   Mon, 22 Mar 2021 04:17:33 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Connor Kuehl <ckuehl@redhat.com>, virtio-fs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, stefanha@redhat.com,
        vgoyal@redhat.com, miklos@szeredi.hu
Subject: Re: [PATCH 1/3] virtio_ring: always warn when descriptor chain
 exceeds queue size
Message-ID: <20210322041414-mutt-send-email-mst@kernel.org>
References: <20210318135223.1342795-1-ckuehl@redhat.com>
 <20210318135223.1342795-2-ckuehl@redhat.com>
 <fa4988fa-a671-0abf-f922-6b362faf10d5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa4988fa-a671-0abf-f922-6b362faf10d5@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 11:22:15AM +0800, Jason Wang wrote:
> 
> 在 2021/3/18 下午9:52, Connor Kuehl 写道:
> >  From section 2.6.5.3.1 (Driver Requirements: Indirect Descriptors)
> > of the virtio spec:
> > 
> >    "A driver MUST NOT create a descriptor chain longer than the Queue
> >    Size of the device."
> > 
> > This text suggests that the warning should trigger even if
> > indirect descriptors are in use.
> 
> 
> So I think at least the commit log needs some tweak.
> 
> For split virtqueue. We had:
> 
> 2.6.5.2 Driver Requirements: The Virtqueue Descriptor Table
> 
> Drivers MUST NOT add a descriptor chain longer than 2^32 bytes in total;
> this implies that loops in the descriptor chain are forbidden!
> 
> 2.6.5.3.1 Driver Requirements: Indirect Descriptors
> 
> A driver MUST NOT create a descriptor chain longer than the Queue Size of
> the device.
> 
> If I understand the spec correctly, the check is only needed for a single
> indirect descriptor table?
> 
> For packed virtqueue. We had:
> 
> 2.7.17 Driver Requirements: Scatter-Gather Support
> 
> A driver MUST NOT create a descriptor list longer than allowed by the
> device.
> 
> A driver MUST NOT create a descriptor list longer than the Queue Size.
> 
> 2.7.19 Driver Requirements: Indirect Descriptors
> 
> A driver MUST NOT create a descriptor chain longer than allowed by the
> device.
> 
> So it looks to me the packed part is fine.
> 
> Note that if I understand the spec correctly 2.7.17 implies 2.7.19.
> 
> Thanks

It would be quite strange for packed and split to differ here:
so for packed would you say there's no limit on # of descriptors at all?

I am guessing I just forgot to move this part from
the format specific to the common part of the spec.

This needs discussion in the TC mailing list - want to start a thread
there?



> 
> > 
> > Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
> > ---
> >   drivers/virtio/virtio_ring.c | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 71e16b53e9c1..1bc290f9ba13 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -444,11 +444,12 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> >   	head = vq->free_head;
> > +	WARN_ON_ONCE(total_sg > vq->split.vring.num);
> > +
> >   	if (virtqueue_use_indirect(_vq, total_sg))
> >   		desc = alloc_indirect_split(_vq, total_sg, gfp);
> >   	else {
> >   		desc = NULL;
> > -		WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
> >   	}
> >   	if (desc) {
> > @@ -1118,6 +1119,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> >   	BUG_ON(total_sg == 0);
> > +	WARN_ON_ONCE(total_sg > vq->packed.vring.num);
> > +
> >   	if (virtqueue_use_indirect(_vq, total_sg))
> >   		return virtqueue_add_indirect_packed(vq, sgs, total_sg,
> >   				out_sgs, in_sgs, data, gfp);
> > @@ -1125,8 +1128,6 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> >   	head = vq->packed.next_avail_idx;
> >   	avail_used_flags = vq->packed.avail_used_flags;
> > -	WARN_ON_ONCE(total_sg > vq->packed.vring.num && !vq->indirect);
> > -
> >   	desc = vq->packed.vring.desc;
> >   	i = head;
> >   	descs_used = total_sg;

