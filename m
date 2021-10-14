Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1349C42D076
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 04:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhJNCex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 22:34:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43002 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229496AbhJNCew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 22:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634178768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KmFVg5ZuffecAFNIjkmXZt3j+Qt+4uHaiepr5Oi9Sik=;
        b=AEydylv1Tw+9I+Khn33ZCy6JyKDrKJSa6hRnW5Ze/KEK/76uUEBpzFecX/rLN9DUHnpF5Z
        vpXVKt2DUWHM0CRK+ZzZKpgTBADlSJftTp/GjQRpOQzYzoTHC68v5muDvFrYyeF5mZeMb2
        ssdvFe4u5tOMDTbp6rlZhyhWD1LxNQc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-7taGw-MfN7O1JvZO7VKNtg-1; Wed, 13 Oct 2021 22:32:46 -0400
X-MC-Unique: 7taGw-MfN7O1JvZO7VKNtg-1
Received: by mail-lf1-f72.google.com with SMTP id bu34-20020a05651216a200b003fd7bb9caa1so3378378lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 19:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KmFVg5ZuffecAFNIjkmXZt3j+Qt+4uHaiepr5Oi9Sik=;
        b=rQZ6Wtd2Aizjnwy1svvOwf+5UByX5Rx7T4ByfhNOEnCy12vYhS7DXKzjRJ/uPk1D3I
         zs5qpY47JrtOQYiWCOx7XIgqYUvNQHMgAKDRt3WVn0Nj4Us5AiEe4d+r2Qf4QGAUiljo
         UOTiSjj87aog/CrjRiC8C1XkYKdbG3GMjEvfHCrD3/oNWDIsXECxgrmz0Kewr6x0M+MY
         LSt8X3kbjr3K0iX6cBqVMQnbslUiTuzGGVUYVPlVKbX0mAJNjZ/X4+0ruAVbTDmVfeM1
         2vKc0GU1U5Ho4kwdwNogdHXwVcjc/VMTynOxh4xPjfPiMXLH/r8Gyu/2gnaMRuVNPbbo
         9tAA==
X-Gm-Message-State: AOAM531Dc4npWv4SSUKb2SSHKLQx/IF3t7ouuyh8j3yejCWz34f16cR7
        NoRc+1kR7Y8IeyapptvHf1YzqlpIHiVAvh1NQxrELRcRM4G+KLDyOdRB8bNJRbFhRIgNK9NIoRO
        /xVqjv4sdIzKlaFFxKkTe++VFY0H9zfGaR1Gm1d9g
X-Received: by 2002:ac2:5e78:: with SMTP id a24mr2710394lfr.348.1634178765362;
        Wed, 13 Oct 2021 19:32:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxC8NYVX6vWXIyoDwoDh8tCFftHbvBtZ2Xcw/ah6Y/GZ3hPJ6/10p88binEKXbKV+YxUbyy7xx7TVNeoWExRYE=
X-Received: by 2002:ac2:5e78:: with SMTP id a24mr2710381lfr.348.1634178765223;
 Wed, 13 Oct 2021 19:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211012065227.9953-1-jasowang@redhat.com> <20211012065227.9953-2-jasowang@redhat.com>
 <20211013060341-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211013060341-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 14 Oct 2021 10:32:32 +0800
Message-ID: <CACGkMEvJ76EBtx847HodDmoLDkz7QjFoJMBdgGTEeEoZ8W-9Sw@mail.gmail.com>
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

On Wed, Oct 13, 2021 at 6:04 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Oct 12, 2021 at 02:52:16PM +0800, Jason Wang wrote:
> > If an untrusted device neogitates BLK_F_MQ but advertises a zero
> > num_queues, the driver may end up trying to allocating zero size
> > buffers where ZERO_SIZE_PTR is returned which may pass the checking
> > against the NULL. This will lead unexpected results.
> >
> > Fixing this by using single queue if num_queues is zero.
> >
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > Cc: Stefano Garzarella <sgarzare@redhat.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> I'd rather fail probe so we don't need to support that.

I think we should be consistent among all virtio drivers.

E.g without this patch, we stick to 1 if virtio_create_feature() fail.
Do we need to fix that?

And we do something similar at least for the virtio-net and a lot of
other places.

        /* We need at least 2 queue's */
        if (err || max_queue_pairs < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
            max_queue_pairs > VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX ||
            !virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ))
                max_queue_pairs = 1;

Thanks

>
> > ---
> >  drivers/block/virtio_blk.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 9b3bd083b411..9deff01a38cb 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -495,7 +495,8 @@ static int init_vq(struct virtio_blk *vblk)
> >       err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
> >                                  struct virtio_blk_config, num_queues,
> >                                  &num_vqs);
> > -     if (err)
> > +     /* We need at least one virtqueue */
> > +     if (err || !num_vqs)
> >               num_vqs = 1;
> >
> >       num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
> > --
> > 2.25.1
>

