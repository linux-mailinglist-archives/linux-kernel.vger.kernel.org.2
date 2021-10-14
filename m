Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDB942D200
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 07:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhJNFrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 01:47:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57582 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229519AbhJNFrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 01:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634190308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=95mUAaVAy4SDw5WDEVKHbawoK+B6f/qisstbgq6pucQ=;
        b=KiHC4vsUJboBOXUHql/TBeRMOHjOYaN8CV3FwN5ClFY/I0Edmk2g9V+EusCwwi0ICgCG6x
        xS1FSEFITz5c4e216D+MJugesOYR9YP/ljuc/uij9E5R9FeO7zw6jlNS+bhB4KZNI7KxUr
        HrXS0OWT8oczVvN/4tY6yNi5+w9nBUE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-j8g0zr1LMoOXbW0keH4Y0A-1; Thu, 14 Oct 2021 01:45:07 -0400
X-MC-Unique: j8g0zr1LMoOXbW0keH4Y0A-1
Received: by mail-wr1-f72.google.com with SMTP id d13-20020adf9b8d000000b00160a94c235aso3698274wrc.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 22:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=95mUAaVAy4SDw5WDEVKHbawoK+B6f/qisstbgq6pucQ=;
        b=4sSY2qkpCao8Let8Kd/o9uM2NLQp1LZXLYEj+gsD/CO30zIPPXIlPUMeRKEpJs9o5e
         jx3+vwq637MUilHWOJfystssG6944yNbEi90qZLxVeZfkSUQokkLf5hDMRJeAhWPakQ3
         OC1KzWzO1PhnFagR8aW45hFLzU7ZfKgoBiqxK7GSkJD5v2f8t024TCgdgfMvZVG8HaPB
         UKmPhr7AceVDp/8wQtvDT7yqdHAtoeZZBpvTwO9W6AF5BDIvrcn2ft+ftjxqe5Cd/zrj
         SdxWRlT1p8lMD9MZjNMhYy9L+Lg5dCSgrV7QHaqFCzXyrB+OyKQTz3kXm6m8CgF3FqAE
         bn8Q==
X-Gm-Message-State: AOAM5324mbIzxNCsX1Gi2HG5TkqFXMaainDnck3vKdY6bybOS/uvQVd+
        PU1kO08dADWgXjP7y+V5v9wltZk3OuhWrnqnbWM5jl9Ge1TnrP6BlUYd1TlhGz3GkmtZ68dsxTo
        xKrJpwMbiCDS670D2A/By0SEW
X-Received: by 2002:adf:fa8b:: with SMTP id h11mr4437432wrr.74.1634190305887;
        Wed, 13 Oct 2021 22:45:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlqBA7dxAcsi2M6NyYDFy65R1jTgZxOyb7b9adWL5LIoEn0+/hh2W82aFZr55WpHCWHZTlOQ==
X-Received: by 2002:adf:fa8b:: with SMTP id h11mr4437406wrr.74.1634190305701;
        Wed, 13 Oct 2021 22:45:05 -0700 (PDT)
Received: from redhat.com ([2.55.16.227])
        by smtp.gmail.com with ESMTPSA id m4sm7074703wml.28.2021.10.13.22.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 22:45:05 -0700 (PDT)
Date:   Thu, 14 Oct 2021 01:45:01 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH V2 01/12] virtio-blk: validate num_queues during probe
Message-ID: <20211014014210-mutt-send-email-mst@kernel.org>
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-2-jasowang@redhat.com>
 <20211013060341-mutt-send-email-mst@kernel.org>
 <CACGkMEvJ76EBtx847HodDmoLDkz7QjFoJMBdgGTEeEoZ8W-9Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEvJ76EBtx847HodDmoLDkz7QjFoJMBdgGTEeEoZ8W-9Sw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 10:32:32AM +0800, Jason Wang wrote:
> On Wed, Oct 13, 2021 at 6:04 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Oct 12, 2021 at 02:52:16PM +0800, Jason Wang wrote:
> > > If an untrusted device neogitates BLK_F_MQ but advertises a zero
> > > num_queues, the driver may end up trying to allocating zero size
> > > buffers where ZERO_SIZE_PTR is returned which may pass the checking
> > > against the NULL. This will lead unexpected results.
> > >
> > > Fixing this by using single queue if num_queues is zero.
> > >
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > > Cc: Stefano Garzarella <sgarzare@redhat.com>
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> > I'd rather fail probe so we don't need to support that.
> 
> I think we should be consistent among all virtio drivers.

Well we started being permissive. We can't change that
since that might break on some hosts. But given focus on
security being restrictive sounds better now.

> E.g without this patch, we stick to 1 if virtio_create_feature() fail.
> Do we need to fix that?

We can't easily, some hosts might be broken.

> And we do something similar at least for the virtio-net and a lot of
> other places.
> 
>         /* We need at least 2 queue's */
>         if (err || max_queue_pairs < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
>             max_queue_pairs > VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX ||
>             !virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ))
>                 max_queue_pairs = 1;
> 
> Thanks
> 
> >
> > > ---
> > >  drivers/block/virtio_blk.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index 9b3bd083b411..9deff01a38cb 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -495,7 +495,8 @@ static int init_vq(struct virtio_blk *vblk)
> > >       err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
> > >                                  struct virtio_blk_config, num_queues,
> > >                                  &num_vqs);
> > > -     if (err)
> > > +     /* We need at least one virtqueue */
> > > +     if (err || !num_vqs)
> > >               num_vqs = 1;
> > >
> > >       num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
> > > --
> > > 2.25.1
> >

