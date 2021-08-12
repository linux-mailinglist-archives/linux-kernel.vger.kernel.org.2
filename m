Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345E33E9BE7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 03:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhHLBWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 21:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhHLBWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 21:22:47 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D2AC0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 18:22:22 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id e11so2403472ljq.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 18:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prestigetransportation-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YgmCb/M36G7y/F9n7pqOEX0jUkjwsODoD9HmSF/j27M=;
        b=Z8wLcIgju1YXAogPl4GXFufU95L35sHnKOrG6YRyJonvs80+KjOVokDMr1y/Y4yWPq
         76lkI74Wk6/frOe9Qqv+RyXfSiA6UvlzeUXm87zF30RPpey9fc/KWmE07Gb6IgLN5N9V
         GAXp+4g7+ISAPVmdIVOri98PGfmJOn9/rhpZqZSV/89QGSpoZoFLBNreI7nuiCqr5lsv
         CNexvlefGKhwqvfnpDjtJ+k700kaJzkmNkzmQEDln3HaS5nAG9KbSspj/XddIG/fqVRi
         Xi81qUxaLNGdCXKHuX1+YcEALa7lWIr/uQ2c/8Cd6Az/oNvvEWDAaxOMcnk7X1PCccMB
         qIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YgmCb/M36G7y/F9n7pqOEX0jUkjwsODoD9HmSF/j27M=;
        b=HJLA0/2bI8V0jUcDCub80AHnB2xp+acOb+epCNpZVlrqCRK8FIJSJ14NjIrhXglG6L
         rGqUadW+NLc04g80mcVx9JJvH6ox0/uMlsl8IDQ1VpO8e7fJQEB9exvVrrtVqSGfMARV
         mV+3NIx8ms19kEcNQqhNh8fJ42UeNh2qvaJD9biU4eF2chlUbCqwi69KFF/vPh08FPUL
         KUU67NXhRcVSZlSUBTs1n1UVraYMSS17syFLWRfkbOngnwdfQjMyheppRuVmwDOiR5kX
         RAJMnEZJrDVGu4xMytGY7UOItMSbehMzyaNN5O5jML4afqWks4HiLsmPIiedhw+3M9qo
         2iyQ==
X-Gm-Message-State: AOAM5322j9NM09828wYJqtSoBLfI0eKOyG9kMGmJhU5GK6n/pmVHqgsu
        xy9YumEKFFbx2qvu+C/wO5S5M/WcczR1VLl2KxGt3g==
X-Google-Smtp-Source: ABdhPJyk5iqyFP+Bcouz1m9nylkSZB5oddh7QHUWidMhBkm9ZyQVFp9l5u3C17ylQCvqvO7UAcKs8nN4ZkPemdMLQfU=
X-Received: by 2002:a2e:7a0e:: with SMTP id v14mr693188ljc.324.1628731341207;
 Wed, 11 Aug 2021 18:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210811081623.9832-1-jasowang@redhat.com>
In-Reply-To: <20210811081623.9832-1-jasowang@redhat.com>
From:   ivan <ivan@prestigetransportation.com>
Date:   Wed, 11 Aug 2021 20:20:03 -0500
Message-ID: <CACFia2dOarWzZ-FfOgA-n3Puxhw4zacdEPtabzbbveyeuV3YBA@mail.gmail.com>
Subject: Re: [RFC PATCH] virtio-net: use NETIF_F_GRO_HW instead of NETIF_F_LRO
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
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

On Wed, Aug 11, 2021 at 3:16 AM Jason Wang <jasowang@redhat.com> wrote:
>
> Commit a02e8964eaf92 ("virtio-net: ethtool configurable LRO") tries to
> advertise LRO on behalf of the guest offloading features and allow the
> administrator to enable and disable those features via ethtool.
>
> This may lead several issues:
>
> - For the device that doesn't support control guest offloads, the
>   "LRO" can't be disabled so we will get a warn in the
>   dev_disable_lro()
> - For the device that have the control guest offloads, the guest
>   offloads were disabled in the case of bridge etc which may slow down
>   the traffic.
>
> Try to fix this by using NETIF_F_GRO_HW instead so we're not
> guaranteed to be re-segmented as original. Or we may want a new netdev
> feature like RX_GSO since the guest offloads for virtio-net is
> actually to receive GSO packet.
>
> Or we can try not advertise LRO is control guest offloads is not
> enabled. This solves the warning but will still slow down the traffic.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/net/virtio_net.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0416a7e00914..10c382b08bce 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -63,7 +63,7 @@ static const unsigned long guest_offloads[] = {
>         VIRTIO_NET_F_GUEST_CSUM
>  };
>
> -#define GUEST_OFFLOAD_LRO_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
> +#define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
>                                 (1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
>                                 (1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
>                                 (1ULL << VIRTIO_NET_F_GUEST_UFO))
> @@ -2481,7 +2481,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>                 virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
>                 virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO) ||
>                 virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM))) {
> -               NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing LRO/CSUM, disable LRO/CSUM first");
> +               NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing GRO_HW/CSUM, disable GRO_HW/CSUM first");
>                 return -EOPNOTSUPP;
>         }
>
> @@ -2612,15 +2612,15 @@ static int virtnet_set_features(struct net_device *dev,
>         u64 offloads;
>         int err;
>
> -       if ((dev->features ^ features) & NETIF_F_LRO) {
> +       if ((dev->features ^ features) & NETIF_F_GRO_HW) {
>                 if (vi->xdp_enabled)
>                         return -EBUSY;
>
> -               if (features & NETIF_F_LRO)
> +               if (features & NETIF_F_GRO_HW)
>                         offloads = vi->guest_offloads_capable;
>                 else
>                         offloads = vi->guest_offloads_capable &
> -                                  ~GUEST_OFFLOAD_LRO_MASK;
> +                                  ~GUEST_OFFLOAD_GRO_HW_MASK;
>
>                 err = virtnet_set_guest_offloads(vi, offloads);
>                 if (err)
> @@ -3100,9 +3100,9 @@ static int virtnet_probe(struct virtio_device *vdev)
>                 dev->features |= NETIF_F_RXCSUM;
>         if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
>             virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
> -               dev->features |= NETIF_F_LRO;
> +               dev->features |= NETIF_F_GRO_HW;
>         if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> -               dev->hw_features |= NETIF_F_LRO;
> +               dev->hw_features |= NETIF_F_GRO_HW;
>
>         dev->vlan_features = dev->features;
>
> --

I applied this patch, recompiled the kernel, and tested it.
The warning messages are gone. Network speed is normal.
I can now enable forwarding, and nothing bad happens.
So far, so good.

Thank you.
