Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6231742D24E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 08:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhJNGZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 02:25:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22285 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229584AbhJNGZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 02:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634192623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UV+KyYBQ2ewOSIHkPZsoUzWC0RAsR1CC6z1Zb8ZXfds=;
        b=eCPqGUSDV+lAJnpYAWiakgmnNoSc6b0GM09Z3hNJ2nBvTTZaheptRwvianBpAkoqwZA6bz
        yRVBJt4ubIWjouAPNE+YQpH39npurXDKUvEokVHkZBICBpTGSiHLHaEzF5e4kBp7f+JW2X
        9M1oxq6NiFbP8mYEgKrTxZfzjW+Zz0U=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-601-5Jl-MyUaNEujv0F764Z45g-1; Thu, 14 Oct 2021 02:23:42 -0400
X-MC-Unique: 5Jl-MyUaNEujv0F764Z45g-1
Received: by mail-lf1-f70.google.com with SMTP id x33-20020a0565123fa100b003fcfd99073dso3664640lfa.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 23:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UV+KyYBQ2ewOSIHkPZsoUzWC0RAsR1CC6z1Zb8ZXfds=;
        b=MEkVeQeGx7wqirKvkGArgJ4wPUoXPGw9OxVMWMQf8prC+DIH7OQeEIqhPgkvX3j7me
         ElHQekJorAFWu7s+PqO8vGE0thsxGo2HTrqrjJCg96L0LedZtDukBhV5hq39D+LP4eED
         MKXeesPTuu/f/+zLz+0YIwOf+fuftalceLfdmIiOJGx0N94QYvr5dQWqEAKyj11kAYzD
         YlsYUhFU+OyzUQQlTKKiBwAtBfabRdgvpxGAHgY4yzcarmfkFnzoe8T//YAdWYRzq+yN
         f99iFfSvaHjMKvO2AT0oojzymrF7+/TW0WSf4SUVp5TaTXl1ajQOGzi2njpy2wtjPrUU
         vOdg==
X-Gm-Message-State: AOAM533ewn+7RE3NM6B6DrCLiOaj5x5ndLuROU7IMUxsPEVtmfqw2S8w
        7ib7lsFhzAcGp6C0FrkdHZGDT2VP5Nm4vqm/PgUxuELp5ZgmELKqeJTedV7xfPGj5GeVyWXR1po
        rFYIUrpItumJ04Wv2l2Ft3gYuxmuuwxBIEe+zZCUA
X-Received: by 2002:ac2:494d:: with SMTP id o13mr3402123lfi.580.1634192621086;
        Wed, 13 Oct 2021 23:23:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWIM3Iv66lzJKw/G3DWaRsoMAi8OdERHh0dsbal3MyO64tkpkHleB2uRCvFcE4uX5ZjTm4FBPDbinC59dDFlw=
X-Received: by 2002:ac2:494d:: with SMTP id o13mr3402108lfi.580.1634192620889;
 Wed, 13 Oct 2021 23:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211012065227.9953-1-jasowang@redhat.com> <20211012065227.9953-2-jasowang@redhat.com>
 <20211013060341-mutt-send-email-mst@kernel.org> <CACGkMEvJ76EBtx847HodDmoLDkz7QjFoJMBdgGTEeEoZ8W-9Sw@mail.gmail.com>
 <20211014014210-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211014014210-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 14 Oct 2021 14:23:29 +0800
Message-ID: <CACGkMEspr-TXYb4ZuC6Dm1-nJcN5D69vFdFzjPvxZv9hupVo5g@mail.gmail.com>
Subject: Re: [PATCH V2 01/12] virtio-blk: validate num_queues during probe
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 1:45 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Oct 14, 2021 at 10:32:32AM +0800, Jason Wang wrote:
> > On Wed, Oct 13, 2021 at 6:04 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Oct 12, 2021 at 02:52:16PM +0800, Jason Wang wrote:
> > > > If an untrusted device neogitates BLK_F_MQ but advertises a zero
> > > > num_queues, the driver may end up trying to allocating zero size
> > > > buffers where ZERO_SIZE_PTR is returned which may pass the checking
> > > > against the NULL. This will lead unexpected results.
> > > >
> > > > Fixing this by using single queue if num_queues is zero.
> > > >
> > > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > > > Cc: Stefano Garzarella <sgarzare@redhat.com>
> > > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > >
> > > I'd rather fail probe so we don't need to support that.
> >
> > I think we should be consistent among all virtio drivers.
>
> Well we started being permissive. We can't change that
> since that might break on some hosts. But given focus on
> security being restrictive sounds better now.

Right.

>
> > E.g without this patch, we stick to 1 if virtio_create_feature() fail.
> > Do we need to fix that?
>
> We can't easily, some hosts might be broken.

Ok.

Thanks

>
> > And we do something similar at least for the virtio-net and a lot of
> > other places.
> >
> >         /* We need at least 2 queue's */
> >         if (err || max_queue_pairs < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
> >             max_queue_pairs > VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX ||
> >             !virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ))
> >                 max_queue_pairs = 1;
> >
> > Thanks
> >
> > >
> > > > ---
> > > >  drivers/block/virtio_blk.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > index 9b3bd083b411..9deff01a38cb 100644
> > > > --- a/drivers/block/virtio_blk.c
> > > > +++ b/drivers/block/virtio_blk.c
> > > > @@ -495,7 +495,8 @@ static int init_vq(struct virtio_blk *vblk)
> > > >       err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
> > > >                                  struct virtio_blk_config, num_queues,
> > > >                                  &num_vqs);
> > > > -     if (err)
> > > > +     /* We need at least one virtqueue */
> > > > +     if (err || !num_vqs)
> > > >               num_vqs = 1;
> > > >
> > > >       num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
> > > > --
> > > > 2.25.1
> > >
>

