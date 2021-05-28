Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88873948A7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 00:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhE1W13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 18:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhE1W11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 18:27:27 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4432DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 15:25:52 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r23so6518967edw.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 15:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yrBjQ7Lx1mhxXojaT5BK59jpSBAfuzBAQF2fCcC/VrM=;
        b=h6xXfopGioGNYSxEvqJZc9IzxUg0PKrW0f6NrQBM5LMuFgYxxz4Jxs2hkpZTJvK2q5
         Ynt+/OYJSjOVrL2N4DQhWECVc0Xoj8LAQJLlc6pe5B1mJG2b2GL9fCq6c6ygw5XKMp1Y
         a8UR3mnNy7W81PZwBAVR8R+sJ+HAMFW6RNZmyUZ3mILH8440RvZBDM5ZDTjdEuVMQSNM
         M9epeJBfwuJIDQnwG5JQ15RGyb1fbg8PEuG/1LkmTctny74e/OObX0xSdWAylYSFOWOb
         puVHbeMRYyWz+hrlaNrjCP6cqXEvWX6gJmeRiy2LOED5wLI9RXd4LxMQs4vWGPDHM/lu
         MEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yrBjQ7Lx1mhxXojaT5BK59jpSBAfuzBAQF2fCcC/VrM=;
        b=cFIQS7Tqte+sCyBx7GZanWK8JfsVDxH49xiqbJA88jUPAsuVa4oRn91BO7LFgrjrLu
         zK/N1PL+4yaMV2gTMhUt0P+ApdLu9WQ84OE0wYxiPrIGL16VYJ/iNdmY7S0v+l/AGd+9
         WV7S/rc4z+iHxuw+K1obZ12kUEYzZxjT350aDKOhiqAAfq+57sLpCVKig1v0RwabcLvI
         ybEOals/TLatIm+Oxv97ZWy3hm7zVw6fOD5yKbgA1TPc+ycCm9UIq3w7R1R1IqtPvG0N
         FfKgXuYRUq6iYgNomgYbuYd9wS4LOQzTVHVvASUH7b7ZHWfh6Px3kDgy4L42vhKRY+mj
         svlA==
X-Gm-Message-State: AOAM533864fpESBlpoIEpoX0Hg2ywpPAdZJ79yEwFAuMpSgUbWJwUJYf
        QlaXcZD6WSJRTjcHhlPiyyZLW1RgEcI=
X-Google-Smtp-Source: ABdhPJwtuRzdDGydnLe0XFqVO2tteAFYL2f4fHIM0U7SBhl9w/dENHafrg8PVQ/LukFgW+lqdf0odg==
X-Received: by 2002:aa7:d4ca:: with SMTP id t10mr12278113edr.42.1622240750478;
        Fri, 28 May 2021 15:25:50 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id k8sm2362071ejr.86.2021.05.28.15.25.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 15:25:49 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id f6-20020a1c1f060000b0290175ca89f698so5324945wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 15:25:48 -0700 (PDT)
X-Received: by 2002:a7b:c935:: with SMTP id h21mr2799976wml.183.1622240748511;
 Fri, 28 May 2021 15:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210526082423.47837-1-mst@redhat.com> <20210526082423.47837-2-mst@redhat.com>
 <476e9418-156d-dbc9-5105-11d2816b95f7@redhat.com>
In-Reply-To: <476e9418-156d-dbc9-5105-11d2816b95f7@redhat.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 28 May 2021 18:25:11 -0400
X-Gmail-Original-Message-ID: <CA+FuTSccMS4qEyexAuzjcuevS8KwaruJih5_0hgiOFz4BpDHzA@mail.gmail.com>
Message-ID: <CA+FuTSccMS4qEyexAuzjcuevS8KwaruJih5_0hgiOFz4BpDHzA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] virtio_net: move tx vq operation under tx queue lock
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, Wei Wang <weiwan@google.com>,
        David Miller <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 11:41 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> =E5=9C=A8 2021/5/26 =E4=B8=8B=E5=8D=884:24, Michael S. Tsirkin =E5=86=99=
=E9=81=93:
> > It's unsafe to operate a vq from multiple threads.
> > Unfortunately this is exactly what we do when invoking
> > clean tx poll from rx napi.
> > Same happens with napi-tx even without the
> > opportunistic cleaning from the receive interrupt: that races
> > with processing the vq in start_xmit.
> >
> > As a fix move everything that deals with the vq to under tx lock.

This patch also disables callbacks during free_old_xmit_skbs
processing on tx interrupt. Should that be a separate commit, with its
own explanation?
> >
> > Fixes: b92f1e6751a6 ("virtio-net: transmit napi")
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   drivers/net/virtio_net.c | 22 +++++++++++++++++++++-
> >   1 file changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index ac0c143f97b4..12512d1002ec 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1508,6 +1508,8 @@ static int virtnet_poll_tx(struct napi_struct *na=
pi, int budget)
> >       struct virtnet_info *vi =3D sq->vq->vdev->priv;
> >       unsigned int index =3D vq2txq(sq->vq);
> >       struct netdev_queue *txq;
> > +     int opaque;
> > +     bool done;
> >
> >       if (unlikely(is_xdp_raw_buffer_queue(vi, index))) {
> >               /* We don't need to enable cb for XDP */
> > @@ -1517,10 +1519,28 @@ static int virtnet_poll_tx(struct napi_struct *=
napi, int budget)
> >
> >       txq =3D netdev_get_tx_queue(vi->dev, index);
> >       __netif_tx_lock(txq, raw_smp_processor_id());
> > +     virtqueue_disable_cb(sq->vq);
> >       free_old_xmit_skbs(sq, true);
> > +
> > +     opaque =3D virtqueue_enable_cb_prepare(sq->vq);
> > +
> > +     done =3D napi_complete_done(napi, 0);
> > +
> > +     if (!done)
> > +             virtqueue_disable_cb(sq->vq);
> > +
> >       __netif_tx_unlock(txq);
> >
> > -     virtqueue_napi_complete(napi, sq->vq, 0);
> > +     if (done) {
> > +             if (unlikely(virtqueue_poll(sq->vq, opaque))) {

Should this also be inside the lock, as it operates on vq?

Is there anything that is not allowed to run with the lock held?

> > +                     if (napi_schedule_prep(napi)) {
> > +                             __netif_tx_lock(txq, raw_smp_processor_id=
());
> > +                             virtqueue_disable_cb(sq->vq);
> > +                             __netif_tx_unlock(txq);
> > +                             __napi_schedule(napi);
> > +                     }
> > +             }
> > +     }
>
>
> Interesting, this looks like somehwo a open-coded version of
> virtqueue_napi_complete(). I wonder if we can simply keep using
> virtqueue_napi_complete() by simply moving the __netif_tx_unlock() after
> that:
>
> netif_tx_lock(txq);
> free_old_xmit_skbs(sq, true);
> virtqueue_napi_complete(napi, sq->vq, 0);
> __netif_tx_unlock(txq);

Agreed. And subsequent block

       if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS)
               netif_tx_wake_queue(txq);

as well

>
> Thanks
>
>
> >
> >       if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS)
> >               netif_tx_wake_queue(txq);
>
