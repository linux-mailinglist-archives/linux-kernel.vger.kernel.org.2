Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56C23E9E6C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 08:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbhHLGbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 02:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhHLGbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 02:31:12 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47458C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 23:30:47 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id a7so8945534ljq.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 23:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prestigetransportation-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4RZ3ZB0Po5UeFheeWWooII8FlmcMrvNbRLiZGp2Ot1U=;
        b=0lKkAeTNoP3IkH+6os8ti4Qtw15GYkgcoTXY0oHuTrGyDQZf2PG2QrP+zvwhHf5Yg8
         iqXXLNw4MGtVEqGYC8XKifvRhR1K8kNOLhsCOGabUD1tL9AxUivOuthRwAhTS3NUQm97
         Y4CBDX5B34YnyDN92fnQOI3R/JgpZh4qafUduFthxd50v42HU5ZvOQou48MkzsJwmHg/
         ks4fmQWLQ7nQuFQ2kSJ/3QgdLBtQ9ekrF3eYSS1UO28fbz0DKTSz81cQRsvVij4jZOaj
         ROkzgqXwwlXp7wOdiUYJfsoHhVwkN2mgpbUnHnMkv94i8oAQvrpKejIozoIvoAWuMyXe
         bi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4RZ3ZB0Po5UeFheeWWooII8FlmcMrvNbRLiZGp2Ot1U=;
        b=LK6X6Z/OSILiFLSRl1iZEU9s+lmet7z5ddhFMDbFJZ5K/KZL2d4nKQlmSqtK0J1UVQ
         B13Ig/+vTqJknezkf6OfUBfi6JYDczEpQNONqdyDJ09GQ1Gt+sYbE2RFwakB/ur02GyW
         kshNTwBmjg55cim1751dEZ88zn45jB2fnWDyOP4EPq/blEXutujSZoKndgACqdcZ9MWd
         4CmenU1pvuGp5x3JjkxrdZVcJqniPe49ntnKSSXwdYfRc9nNmUx5vrSg9sR5CDg83eIB
         0Mka3+bsrgZif8LUZDrr7fYfPOYqsLz6ZXfi65e5WB4U9CPmB6bY5tJ6Su4seojumYzS
         Pv8A==
X-Gm-Message-State: AOAM5336LS/WjJaibQJ2DMTtogPdm7GDgyga4zTGLgRyuFQ/3MuPNJFi
        sIR/u9h9ej9O+/yMDl6nBYU6KqJjc6cFSlA+/DI+aA==
X-Google-Smtp-Source: ABdhPJzfmWz8ZkDfiBFB062U//8lQvpDAu9Z5dLuwfSL0DXVRA9TIgzX1qKokoiHcbWVMv7/3UaEQ8KhCp2PWXSpXvE=
X-Received: by 2002:a2e:9ad6:: with SMTP id p22mr1832585ljj.270.1628749845463;
 Wed, 11 Aug 2021 23:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210811081623.9832-1-jasowang@redhat.com> <CACFia2dOarWzZ-FfOgA-n3Puxhw4zacdEPtabzbbveyeuV3YBA@mail.gmail.com>
 <20210812005246-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210812005246-mutt-send-email-mst@kernel.org>
From:   ivan <ivan@prestigetransportation.com>
Date:   Thu, 12 Aug 2021 01:28:27 -0500
Message-ID: <CACFia2c3bVH3k_OLGJwsD1-gUW0=Te2s1DdJ_LQEm1Ns0aioRw@mail.gmail.com>
Subject: Re: [RFC PATCH] virtio-net: use NETIF_F_GRO_HW instead of NETIF_F_LRO
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Ivan <ivan@prestigetransportation.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 12:00 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Aug 11, 2021 at 08:20:03PM -0500, ivan wrote:
> > On Wed, Aug 11, 2021 at 3:16 AM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > Commit a02e8964eaf92 ("virtio-net: ethtool configurable LRO") tries to
> > > advertise LRO on behalf of the guest offloading features and allow the
> > > administrator to enable and disable those features via ethtool.
> > >
> > > This may lead several issues:
> > >
> > > - For the device that doesn't support control guest offloads, the
> > >   "LRO" can't be disabled so we will get a warn in the
> > >   dev_disable_lro()
> > > - For the device that have the control guest offloads, the guest
> > >   offloads were disabled in the case of bridge etc which may slow down
> > >   the traffic.
> > >
> > > Try to fix this by using NETIF_F_GRO_HW instead so we're not
> > > guaranteed to be re-segmented as original. Or we may want a new netdev
> > > feature like RX_GSO since the guest offloads for virtio-net is
> > > actually to receive GSO packet.
> > >
> > > Or we can try not advertise LRO is control guest offloads is not
> > > enabled. This solves the warning but will still slow down the traffic.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/net/virtio_net.c | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 0416a7e00914..10c382b08bce 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -63,7 +63,7 @@ static const unsigned long guest_offloads[] = {
> > >         VIRTIO_NET_F_GUEST_CSUM
> > >  };
> > >
> > > -#define GUEST_OFFLOAD_LRO_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
> > > +#define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
> > >                                 (1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
> > >                                 (1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
> > >                                 (1ULL << VIRTIO_NET_F_GUEST_UFO))
> > > @@ -2481,7 +2481,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
> > >                 virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
> > >                 virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO) ||
> > >                 virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM))) {
> > > -               NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing LRO/CSUM, disable LRO/CSUM first");
> > > +               NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing GRO_HW/CSUM, disable GRO_HW/CSUM first");
> > >                 return -EOPNOTSUPP;
> > >         }
> > >
> > > @@ -2612,15 +2612,15 @@ static int virtnet_set_features(struct net_device *dev,
> > >         u64 offloads;
> > >         int err;
> > >
> > > -       if ((dev->features ^ features) & NETIF_F_LRO) {
> > > +       if ((dev->features ^ features) & NETIF_F_GRO_HW) {
> > >                 if (vi->xdp_enabled)
> > >                         return -EBUSY;
> > >
> > > -               if (features & NETIF_F_LRO)
> > > +               if (features & NETIF_F_GRO_HW)
> > >                         offloads = vi->guest_offloads_capable;
> > >                 else
> > >                         offloads = vi->guest_offloads_capable &
> > > -                                  ~GUEST_OFFLOAD_LRO_MASK;
> > > +                                  ~GUEST_OFFLOAD_GRO_HW_MASK;
> > >
> > >                 err = virtnet_set_guest_offloads(vi, offloads);
> > >                 if (err)
> > > @@ -3100,9 +3100,9 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >                 dev->features |= NETIF_F_RXCSUM;
> > >         if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > >             virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
> > > -               dev->features |= NETIF_F_LRO;
> > > +               dev->features |= NETIF_F_GRO_HW;
> > >         if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> > > -               dev->hw_features |= NETIF_F_LRO;
> > > +               dev->hw_features |= NETIF_F_GRO_HW;
> > >
> > >         dev->vlan_features = dev->features;
> > >
> > > --
> >
> > I applied this patch, recompiled the kernel, and tested it.
> > The warning messages are gone. Network speed is normal.
> > I can now enable forwarding, and nothing bad happens.
> > So far, so good.
> >
> > Thank you.
>
> OK so that's
>
> Tested-by: ivan <ivan@prestigetransportation.com>
>
> It is still weird that without the patch networking dies.
>
> What happens if you apply the patch then try to disable GRO
> using ethtool?
Nothing bad.  Ethtool shows successful change to off.
Makes no differrece on the iperf tests.  Still good.
