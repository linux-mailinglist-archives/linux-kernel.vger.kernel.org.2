Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C0D3EE841
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 10:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbhHQIRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 04:17:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38756 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235120AbhHQIRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 04:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629188200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e3ctewUOTsKGZENQJgUMk7UI3Zq20LDKQ2q7neygSyw=;
        b=Ai6LCCr5vJ9hVAmpGvU2a5frn1iZgjiSUAMoeIZ2XIiz+N6PUXzdW2K55o0pz/ONMy3trc
        S7o1sl+9WLgJawXZni2684UAfvJEeaNWxWulCQRBtPB0KHJ4rWf0Q69W5RiiM62l1aozLv
        3AJNEsdeo6ZIUJCl+tUdp40CMgDwBAk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-4vBWKEX_NQSpOZr67v9rlA-1; Tue, 17 Aug 2021 04:16:39 -0400
X-MC-Unique: 4vBWKEX_NQSpOZr67v9rlA-1
Received: by mail-lj1-f199.google.com with SMTP id e4-20020a05651c0904b029018bc821fd31so7035908ljq.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 01:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e3ctewUOTsKGZENQJgUMk7UI3Zq20LDKQ2q7neygSyw=;
        b=oDnZeD9LMpoDEGWWdtoqsCIRFg5tNre+kZSsWY+Eggw5UnUOK8iNZ188BoHnrNqCIO
         QSNiMJH1L6kB265YR3mD2F5n/XIPg+vJBtvvEsqfeEt+0HW7MC2/MK7QK72MJQXQOC2o
         Vj1Cc1aZWqWoWAuxmBdyrfkZCMXGOGqGfJVdV5Ntyj8cuU2ChEdpJlzMhxI36T21342a
         tYTWCF4L66/x2lMMiyYCEBm19qIRFird/mF6WOM/wGuuCMTwKe3gvRC2s0JAvijcWJNf
         6/j8CoNCeKcOyuaPjR0TBxx49c7ge0Fpi5fjY0QV5uOw2uP4LihERuTpFdTp+YdOys7f
         reJA==
X-Gm-Message-State: AOAM531VSYn/8wgIDXSCWMV3sfxiTPHHV9ck9NH6F7ubyvthe+itOrm6
        O4nvTIglQeA5hMHuTXA3e0l67f/NyUsWSPxY4lgSes28bR/2griXFhe/gXlFf6r8id5M2pu3a4i
        QQ3f+kWp+88ryN7ZwPOEw9mjK5TJ0+6QWvvGWXMaV
X-Received: by 2002:a19:e00b:: with SMTP id x11mr1599236lfg.436.1629188197684;
        Tue, 17 Aug 2021 01:16:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOoc1hi6Z/mta4euyFcXISlA832eI1bKIDzEItOgJ0WuAxvbQdlmufrdPWFKHfL9QeQ+mYV8bZ9lcjd41KHJA=
X-Received: by 2002:a19:e00b:: with SMTP id x11mr1599225lfg.436.1629188197483;
 Tue, 17 Aug 2021 01:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210817020338.6400-1-jasowang@redhat.com> <20210817023118-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210817023118-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 17 Aug 2021 16:16:26 +0800
Message-ID: <CACGkMEuYMMBqgmpo25zc1uT2qCB09pjThDWJoWKLCz9GehccFQ@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: use NETIF_F_GRO_HW instead of NETIF_F_LRO
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     davem <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ivan <ivan@prestigetransportation.com>,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 2:46 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Patch is good. Suggest some tweaks to the commit log.
>
> On Tue, Aug 17, 2021 at 10:03:38AM +0800, Jason Wang wrote:
> > Commit a02e8964eaf92 ("virtio-net: ethtool configurable LRO") tries to
> > advertise LRO on behalf of the guest offloading features and allow the
>
> tries to advertise -> advertises
>
> that part actually works.
>
> allow -> allows
>
> on behalf of features is really weird. maybe "maps"?
>
> > administrator to enable and disable those features via ethtool.
> >
> > This may lead several issues:
>
> may lead->lead to
>
> >
> > - For the device that doesn't support control guest offloads, the
> >   "LRO" can't be disabled so we will get a warn in the
>
> warn -> warning
>
> >   dev_disable_lro()
>
> .. when turning off LRO or when enabling forwarding bridging etc.
>
> > - For the device that have the control guest offloads, the guest
>
> have the -> supports
>
> >   offloads were disabled in the case of bridge etc
>
> etc -> forwarding etc
>
> > which may slow down
>
> were -> are
>
> may slow -> slows
>
> >   the traffic.
> >
> > Fixing this by using NETIF_F_GRO_HW instead. Though the spec does not
> > guaranteed to be re-segmented as original explicitly now, we can add
>
> guaranteed -> guarantee
>
> > that to the spec
>
> I would add:
>
> Further, we never advertised LRO historically before a02e8964eaf92
> ("virtio-net: ethtool configurable LRO") and so bridged/forwarded
> configs effectively relied on virtio receive offloads being GRO.
>
>
>
>
> > and then we can catch the bad configuration and
> > setup.
>
> Don't know what does this part mean. How would we catch it?
> With a new flag? Let's say so.
>
> >
> > Fixes: a02e8964eaf92 ("virtio-net: ethtool configurable LRO")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
>
>
> Proposed rewritten commit log:

Agree.

Post a new version.

Thanks

>
> ===
> [PATCH net] virtio-net: use NETIF_F_GRO_HW instead of NETIF_F_LRO
>
> Commit a02e8964eaf92 ("virtio-net: ethtool configurable LRO")
> maps LRO to virtio guest offloading features and allows the
> administrator to enable and disable those features via ethtool.
>
> This leads to several issues:
>
>
> - For a device that doesn't support control guest offloads, the "LRO"
>   can't be disabled triggering WARN in dev_disable_lro() when turning
>   off LRO or when enabling forwarding bridging etc.
>
> - For a device that supports control guest offloads, the guest
>   offloads are disabled in cases of bridging, forwarding etc
>   slowing down the traffic.
>
> Fix this by using NETIF_F_GRO_HW instead. Though the spec does not
> guarantee packets to be re-segmented as the original ones,
> we can add that to the spec, possibly with a flag for devices to
> differentiate between GRO and LRO.
>
> Further, we never advertised LRO historically before a02e8964eaf92
> ("virtio-net: ethtool configurable LRO") and so bridged/forwarded
> configs effectively always relied on virtio receive offloads behaving
> like GRO - thus even if this breaks any configs it is at least not
> a regression.
>
> Fixes: a02e8964eaf92 ("virtio-net: ethtool configurable LRO")
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Reported-by: Ivan <ivan@prestigetransportation.com>
> Tested-by: Ivan <ivan@prestigetransportation.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> ===
>
>
> > ---
> >  drivers/net/virtio_net.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 0416a7e00914..10c382b08bce 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -63,7 +63,7 @@ static const unsigned long guest_offloads[] = {
> >       VIRTIO_NET_F_GUEST_CSUM
> >  };
> >
> > -#define GUEST_OFFLOAD_LRO_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
> > +#define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
> >                               (1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
> >                               (1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
> >                               (1ULL << VIRTIO_NET_F_GUEST_UFO))
> > @@ -2481,7 +2481,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
> >               virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
> >               virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO) ||
> >               virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM))) {
> > -             NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing LRO/CSUM, disable LRO/CSUM first");
> > +             NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing GRO_HW/CSUM, disable GRO_HW/CSUM first");
> >               return -EOPNOTSUPP;
> >       }
> >
> > @@ -2612,15 +2612,15 @@ static int virtnet_set_features(struct net_device *dev,
> >       u64 offloads;
> >       int err;
> >
> > -     if ((dev->features ^ features) & NETIF_F_LRO) {
> > +     if ((dev->features ^ features) & NETIF_F_GRO_HW) {
> >               if (vi->xdp_enabled)
> >                       return -EBUSY;
> >
> > -             if (features & NETIF_F_LRO)
> > +             if (features & NETIF_F_GRO_HW)
> >                       offloads = vi->guest_offloads_capable;
> >               else
> >                       offloads = vi->guest_offloads_capable &
> > -                                ~GUEST_OFFLOAD_LRO_MASK;
> > +                                ~GUEST_OFFLOAD_GRO_HW_MASK;
> >
> >               err = virtnet_set_guest_offloads(vi, offloads);
> >               if (err)
> > @@ -3100,9 +3100,9 @@ static int virtnet_probe(struct virtio_device *vdev)
> >               dev->features |= NETIF_F_RXCSUM;
> >       if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> >           virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
> > -             dev->features |= NETIF_F_LRO;
> > +             dev->features |= NETIF_F_GRO_HW;
> >       if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> > -             dev->hw_features |= NETIF_F_LRO;
> > +             dev->hw_features |= NETIF_F_GRO_HW;
> >
> >       dev->vlan_features = dev->features;
> >
> > --
> > 2.25.1
>

