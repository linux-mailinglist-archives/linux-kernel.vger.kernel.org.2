Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB5B37B5A7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 08:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhELGLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 02:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhELGK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 02:10:57 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8BDC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 23:09:48 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id d21so21282162oic.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 23:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NPvm8NafxYzbmgPT1/KnpbyytRpdTESXUP6H+J3SyAo=;
        b=ggF7RmO/OPDJ7AQgIQ0iAERaZHJ5C488AblpYNQs+6RcXH8iQfaDsO9WAjqnEaNu3B
         vyg1bJF5Dd+pO6xB6zaGtHpjIxqB59k77WjABh4PU9nrp0kIwPHpeWegKXpB+6IUtixB
         kDmOjvtzodcTA+FiAE9bTJ6XPyGiZiwQRttA/ssbvAZQCu2t8r9O10j7y/V7kItmstEa
         BF1of08PkuFFYGp0Z4JEzekK26g65DCBOBDmsek68B00SsXAy6isjmx/FxnAp2BoSMz2
         w5KdGBqWSWJ+RjIJ+OinIUCBsjjHwkvspW/xdGmKKO9dPL7//7vDRtvZdx0niDy2vHc8
         sJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NPvm8NafxYzbmgPT1/KnpbyytRpdTESXUP6H+J3SyAo=;
        b=KRppN19KvxAtqUO0M4w//hFxohdb5eT/0g/NTPLj6/ehC9cg8eOLz5aupfVfz1giJO
         fT2eoDAAn46UQI23aQPyGDio5RUcLB0L2pk81sVTilASJlXZzDg6Q5gCYgo8J9Nd+4Rt
         Yz8tLjfyWFjq/PkjH1f9lrsIbZ9nBHLWMA8WnIZeR3uFZiZa6dc0Gxq/KZrm0NZS51Yh
         CaA335uLBe8hXFH/n7tWybfZ02xWAPWy+3/im+oR/TjyXqlWG5kI/tAP/zaPq6/ZWc5W
         XuL3yATk2PkVk4hTSGiKOSACBeVLOBYA8/8XADaVL4xtKhsrBaz6zzknCVNe7Tu0yHTb
         YUOg==
X-Gm-Message-State: AOAM530D1ikILE5Qix3ENR8CQmDHdgpFufl+R6Vbc1zaB8XZ0CXZ3t0f
        LIJSZoyFWtwGG83/5iwgwWVWyYNysj+hX1151apfHQ==
X-Google-Smtp-Source: ABdhPJy9KOo+CF+jCVW3yBOXeKSl4RA9geS2kvTEhrUha9vxQ2cd7c36nf442Z3jotBZ/m00l78Ai/Z/tD82YEPUGHc=
X-Received: by 2002:aca:ad06:: with SMTP id w6mr6422169oie.54.1620799788219;
 Tue, 11 May 2021 23:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
 <20210511044253.469034-3-yuri.benditovich@daynix.com> <CA+FuTSdfA6sT68AJNpa=VPBdwRFHvEY+=C-B_mS=y=WMpTyc=Q@mail.gmail.com>
In-Reply-To: <CA+FuTSdfA6sT68AJNpa=VPBdwRFHvEY+=C-B_mS=y=WMpTyc=Q@mail.gmail.com>
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
Date:   Wed, 12 May 2021 09:09:36 +0300
Message-ID: <CAOEp5OcV-YmPFoewuCHg=ADFQ4BmVL5ioMgh3qVjUGk9mauejg@mail.gmail.com>
Subject: Re: [PATCH 2/4] virtio-net: add support of UDP segmentation (USO) on
 the host
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Yan Vugenfirer <yan@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 8:48 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Tue, May 11, 2021 at 12:43 AM Yuri Benditovich
> <yuri.benditovich@daynix.com> wrote:
> >
> > Large UDP packet provided by the guest with GSO type set to
> > VIRTIO_NET_HDR_GSO_UDP_L4 will be divided to several UDP
> > packets according to the gso_size field.
> >
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > ---
> >  include/linux/virtio_net.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index b465f8f3e554..4ecf9a1ca912 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -51,6 +51,11 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
> >                         ip_proto = IPPROTO_UDP;
> >                         thlen = sizeof(struct udphdr);
> >                         break;
> > +               case VIRTIO_NET_HDR_GSO_UDP_L4:
> > +                       gso_type = SKB_GSO_UDP_L4;
> > +                       ip_proto = IPPROTO_UDP;
> > +                       thlen = sizeof(struct udphdr);
> > +                       break;
>
> If adding a new VIRTIO_NET_HDR type I suggest adding separate IPv4 and
> IPv6 variants, analogous to VIRTIO_NET_HDR_GSO_TCPV[46]. To avoid
> having to infer protocol again, as for UDP fragmentation offload (the
> retry case below this code).

Thank you for denoting this important point of distinguishing between v4 and v6.
Let's try to take a deeper look to see what is the correct thing to do
and please correct me if I'm wrong:
1. For USO we do not need to guess the protocol as it is used with
VIRTIO_NET_HDR_F_NEEDS_CSUM (unlike UFO) and the USO packets
transmitted by the guest are under the same clause as both
VIRTIO_NET_HDR_GSO_TCP, i.e. under if (hdr->flags &
VIRTIO_NET_HDR_F_NEEDS_CSUM) {
2. If we even define VIRTIO_NET_HDR_GSO_UDPv4_L4 and
VIRTIO_NET_HDR_GSO_UDPv6_L4 - both will be translated to
SKB_GSO_UDP_L4, so this information is immediately lost (the code will
look like:
case VIRTIO_NET_HDR_GSO_UDP4_L4: case VIRTIO_NET_HDR_GSO_UDP6_L4
    gso_type = SKB_GSO_UDP;

3. When we will define the respective guest features (like
VIRTIO_NET_F_HOST_USO4 VIRTIO_NET_F_HOST_USO6) we will need to
recreate the virtio_net header from the skb when both v4 and v6 have
the same SKB_GSO_UDP_L4, (see virtio_net_hdr_from_skb) and I'm not
sure whether somebody needs the exact v4 or v6 information on guest RX
path.
4. What is completely correct is that when we will start working with
the guest RX path we will need to define something like NETIF_F_USO4
and NETIF_F_USO6 and configure them according to exact guest offload
capabilities.
Do you agree?
