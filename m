Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB3C32A507
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442259AbhCBLq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 06:46:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32745 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380390AbhCBL0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 06:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614684266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1BhNztqEgWGMx7kPW5f0CLvD2WsnR/6LZwBjGCJ0xrE=;
        b=NycymublH60UmomibTi6scOyUppov+crws1Oj4ttlQ20VjRQsP+ihx0OfocMmWhDCZ76c8
        r2W7ULKKq3PGAGAqfrsto6WLGR9yu+zwIR47tBtVHqbXUUF+SvA2NKF7QN8zD7DjDUb/60
        yWNo4mXy/FM13OsDIT7QJskDIxZnfeA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-gDNo3j1ONI-hmi5Rei7c-w-1; Tue, 02 Mar 2021 06:24:24 -0500
X-MC-Unique: gDNo3j1ONI-hmi5Rei7c-w-1
Received: by mail-ej1-f71.google.com with SMTP id b15so8316333ejv.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 03:24:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1BhNztqEgWGMx7kPW5f0CLvD2WsnR/6LZwBjGCJ0xrE=;
        b=qD4+W8eOQ2KoNwK8mTt/ArQmpph6C6uxOpzelbJpK3jz2373L4Ix1HAF2dLI9t3riV
         2iF+q4Yq+3Oz3aO2lzBTFtAh312nO+5xX7rk494xzYP5TIhgQoHHqxhwNlcZMGZTwBpy
         2UpOOfZbZLnCpZmP15fmJI7EqUcy2vX3JEbDY/TBPuvfZfhPwspm+S5P9C4EGjNL/ZcF
         Bze4oUsd8H9EyfGtKe4iVNHz2bJLSYwoqfGZzykiu0XI/hyn0t+997dq7jYExE9yqZyk
         r5reP6rfGGvbM8CXpygj0a4ydjpIcmvU44gmy3TH0fjDh24oKa66anIfUoA8Gb5E6Cle
         dv2Q==
X-Gm-Message-State: AOAM5328wsLKQMjtKU3pX3mOphqov2vQwjEXh7IqMSb/3wpfEXQuNzCn
        qCMMR/uzFGLFOyWBoPXtI7FZnH9SqgBoTX5pXPlrkl3ZzqHb/iJGGSGseJb02jOIkOsEw8k3vEU
        i4BVmm5E2HwgDW4qzww8i5x07
X-Received: by 2002:a17:906:f296:: with SMTP id gu22mr19228817ejb.20.1614684263044;
        Tue, 02 Mar 2021 03:24:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzGGNSokqgK/5RqqfSY3ERKl9lVWR62FSA4uJr14s6tOqkDbPKgW29y+nDnUA6mto+6bIvZew==
X-Received: by 2002:a17:906:f296:: with SMTP id gu22mr19228806ejb.20.1614684262901;
        Tue, 02 Mar 2021 03:24:22 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id h2sm15994879ejk.32.2021.03.02.03.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 03:24:22 -0800 (PST)
Date:   Tue, 2 Mar 2021 06:24:19 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH] vdpa/mlx5: Fix wrong use of bit numbers
Message-ID: <20210302062405-mutt-send-email-mst@kernel.org>
References: <20210301062817.39331-1-elic@nvidia.com>
 <959916f2-5fc9-bdb4-31ca-632fe0d98979@redhat.com>
 <20210301103214-mutt-send-email-mst@kernel.org>
 <20210302052306.GA227464@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210302052306.GA227464@mtl-vdi-166.wap.labs.mlnx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 07:23:06AM +0200, Eli Cohen wrote:
> On Mon, Mar 01, 2021 at 10:33:14AM -0500, Michael S. Tsirkin wrote:
> > On Mon, Mar 01, 2021 at 03:52:45PM +0800, Jason Wang wrote:
> > > 
> > > On 2021/3/1 2:28 下午, Eli Cohen wrote:
> > > > VIRTIO_F_VERSION_1 is a bit number. Use BIT_ULL() with mask
> > > > conditionals.
> > > > 
> > > > Also, in mlx5_vdpa_is_little_endian() use BIT_ULL for consistency with
> > > > the rest of the code.
> > > > 
> > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > 
> > > 
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> > 
> > And CC stable I guess?
> 
> Is this a question or a request? :-)

A question. net patches are cc'd by net maintainer.

> > 
> > > 
> > > > ---
> > > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
> > > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > index dc7031132fff..7d21b857a94a 100644
> > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > @@ -821,7 +821,7 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
> > > >   	MLX5_SET(virtio_q, vq_ctx, event_qpn_or_msix, mvq->fwqp.mqp.qpn);
> > > >   	MLX5_SET(virtio_q, vq_ctx, queue_size, mvq->num_ent);
> > > >   	MLX5_SET(virtio_q, vq_ctx, virtio_version_1_0,
> > > > -		 !!(ndev->mvdev.actual_features & VIRTIO_F_VERSION_1));
> > > > +		 !!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_F_VERSION_1)));
> > > >   	MLX5_SET64(virtio_q, vq_ctx, desc_addr, mvq->desc_addr);
> > > >   	MLX5_SET64(virtio_q, vq_ctx, used_addr, mvq->device_addr);
> > > >   	MLX5_SET64(virtio_q, vq_ctx, available_addr, mvq->driver_addr);
> > > > @@ -1578,7 +1578,7 @@ static void teardown_virtqueues(struct mlx5_vdpa_net *ndev)
> > > >   static inline bool mlx5_vdpa_is_little_endian(struct mlx5_vdpa_dev *mvdev)
> > > >   {
> > > >   	return virtio_legacy_is_little_endian() ||
> > > > -		(mvdev->actual_features & (1ULL << VIRTIO_F_VERSION_1));
> > > > +		(mvdev->actual_features & BIT_ULL(VIRTIO_F_VERSION_1));
> > > >   }
> > > >   static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
> > 

