Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD9C3FD490
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 09:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242685AbhIAHlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 03:41:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33845 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242687AbhIAHld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 03:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630482036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0WbA7CP4xtTeLnvPq3VcqMOzaSiQi1f+ly7oxs5Az3g=;
        b=JargjN6WeUUhx5SWxlZhrXdmTWJHFX0Mw46O1jerL8nCy3+gVgkE5Sa7LKpmphGIwHiLdj
        fE7BO+5dzBWxUumSFpAqs96Y9vmXOyFkQ7mJczUwLn72f9AgTzUJjIdLDwuaCvWYr6Eu5h
        PIP0/sbEeCYNTjnQUI0v1IkusVo3RxE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-s3YSMuG7NviriUNWspK7XQ-1; Wed, 01 Sep 2021 03:40:35 -0400
X-MC-Unique: s3YSMuG7NviriUNWspK7XQ-1
Received: by mail-lj1-f199.google.com with SMTP id q9-20020a2e9689000000b001b964fa10b3so730504lji.18
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 00:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0WbA7CP4xtTeLnvPq3VcqMOzaSiQi1f+ly7oxs5Az3g=;
        b=UhS4H/dw+tNXI1ITU4omjmK6JfdY0I1CNMidIUvqFjuiX4OWr/Z+WmCRZtGEjBEX0X
         EiO36A3lwGv7HM9qYIDq0DBYd2aYBkMlwWJXj1hmnixeyI4lKFU7TADuAsTqKa6gWbRw
         sSjB8dpFKgyifMQra61K77NINC/J82DC7rIylEz9rOPBdQHwEvLHbOYVhsvqxSGx/qId
         KHfHqr93XKTfSgg0zL0DwSvzr857XFjDuMLgRZKNh2/LwQvRRfcq1YSUT1aIau+0ETj3
         CBDCU3BjZ4BeDqN8Hy99I0yVQq9NxwqkgegXwFjbehaxGA7mbhefkXOSR38NDBbwBmG+
         Ue/w==
X-Gm-Message-State: AOAM5331XgHpwHF7lm8w15vWcdM+QaEPSI2DPrxFYhEoBsE4Bj7c4P6P
        51eQ2mk2rGirf730zCdoS3OqqWh7Fo6MlOmheUdSNpyOt2MnkMq1YRQCt4phEfoXQOCAwBvRQzD
        k2XJUFuhFGP/Ahq0v2UByDVIv0EpumOyS4Ym2revr
X-Received: by 2002:a05:6512:31d2:: with SMTP id j18mr11009420lfe.436.1630482033359;
        Wed, 01 Sep 2021 00:40:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyahV0M9rKSrLz0mU1SWubpqt6FJo9F3vajGULKpIMtl+B/GMoT9WUyYL46OT/AWY+UK7B7y4hkiWepNYG0vfE=
X-Received: by 2002:a05:6512:31d2:: with SMTP id j18mr11009407lfe.436.1630482033131;
 Wed, 01 Sep 2021 00:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210818175440.128691-1-andrew@daynix.com> <20210818175440.128691-4-andrew@daynix.com>
In-Reply-To: <20210818175440.128691-4-andrew@daynix.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 1 Sep 2021 15:40:21 +0800
Message-ID: <CACGkMEtphOre1QPwOqYk5uLM=2Xy_QEXUJehY3-YTop5h=2Rag@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] drivers/net/virtio_net: Added RSS hash report.
To:     Andrew Melnychenko <andrew@daynix.com>
Cc:     mst <mst@redhat.com>, davem <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 1:55 AM Andrew Melnychenko <andrew@daynix.com> wrote:
>
> Added set_hash for skb.
> Also added hashflow set/get callbacks.
> Virtio RSS "IPv6 extensions" hashes disabled.
> Also, disabling RXH_IP_SRC/DST for TCP would disable them for UDP.
> TCP and UDP supports only:
> ethtool -U eth0 rx-flow-hash tcp4 sd
>     RXH_IP_SRC + RXH_IP_DST
> ethtool -U eth0 rx-flow-hash tcp4 sdfn
>     RXH_IP_SRC + RXH_IP_DST + RXH_L4_B_0_1 + RXH_L4_B_2_3
>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>  drivers/net/virtio_net.c | 177 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 177 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d87bde246305..6a52eeaf9292 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1151,6 +1151,8 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>         struct net_device *dev = vi->dev;
>         struct sk_buff *skb;
>         struct virtio_net_hdr_mrg_rxbuf *hdr;
> +       struct virtio_net_hdr_v1_hash *hdr_hash;
> +       enum pkt_hash_types rss_hash_type;
>
>         if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
>                 pr_debug("%s: short packet %i\n", dev->name, len);
> @@ -1177,6 +1179,29 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>                 return;
>
>         hdr = skb_vnet_hdr(skb);
> +       if (vi->has_rss_hash_report && (dev->features & NETIF_F_RXHASH)) {
> +               hdr_hash = (struct virtio_net_hdr_v1_hash *)(hdr);
> +
> +               switch (hdr_hash->hash_report) {
> +               case VIRTIO_NET_HASH_REPORT_TCPv4:
> +               case VIRTIO_NET_HASH_REPORT_UDPv4:
> +               case VIRTIO_NET_HASH_REPORT_TCPv6:
> +               case VIRTIO_NET_HASH_REPORT_UDPv6:
> +               case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
> +               case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
> +                       rss_hash_type = PKT_HASH_TYPE_L4;
> +                       break;
> +               case VIRTIO_NET_HASH_REPORT_IPv4:
> +               case VIRTIO_NET_HASH_REPORT_IPv6:
> +               case VIRTIO_NET_HASH_REPORT_IPv6_EX:
> +                       rss_hash_type = PKT_HASH_TYPE_L3;
> +                       break;
> +               case VIRTIO_NET_HASH_REPORT_NONE:
> +               default:
> +                       rss_hash_type = PKT_HASH_TYPE_NONE;
> +               }
> +               skb_set_hash(skb, hdr_hash->hash_value, rss_hash_type);
> +       }
>
>         if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
>                 skb->ip_summed = CHECKSUM_UNNECESSARY;
> @@ -2250,6 +2275,132 @@ static void virtnet_init_default_rss(struct virtnet_info *vi)
>         netdev_rss_key_fill(vi->ctrl->rss.key, vi->rss_key_size);
>  }
>
> +void virtnet_get_hashflow(const struct virtnet_info *vi, struct ethtool_rxnfc *info)
> +{
> +       info->data = 0;
> +       switch (info->flow_type) {
> +       case TCP_V4_FLOW:
> +               if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_TCPv4) {
> +                       info->data = RXH_IP_SRC | RXH_IP_DST |
> +                                                RXH_L4_B_0_1 | RXH_L4_B_2_3;
> +               } else if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_IPv4) {
> +                       info->data = RXH_IP_SRC | RXH_IP_DST;
> +               }
> +               break;
> +       case TCP_V6_FLOW:
> +               if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_TCPv6) {
> +                       info->data = RXH_IP_SRC | RXH_IP_DST |
> +                                                RXH_L4_B_0_1 | RXH_L4_B_2_3;
> +               } else if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_IPv6) {
> +                       info->data = RXH_IP_SRC | RXH_IP_DST;
> +               }
> +               break;
> +       case UDP_V4_FLOW:
> +               if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_UDPv4) {
> +                       info->data = RXH_IP_SRC | RXH_IP_DST |
> +                                                RXH_L4_B_0_1 | RXH_L4_B_2_3;
> +               } else if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_IPv4) {
> +                       info->data = RXH_IP_SRC | RXH_IP_DST;
> +               }
> +               break;
> +       case UDP_V6_FLOW:
> +               if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_UDPv6) {
> +                       info->data = RXH_IP_SRC | RXH_IP_DST |
> +                                                RXH_L4_B_0_1 | RXH_L4_B_2_3;
> +               } else if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_IPv6) {
> +                       info->data = RXH_IP_SRC | RXH_IP_DST;
> +               }
> +               break;
> +       case IPV4_FLOW:
> +               if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_IPv4)
> +                       info->data = RXH_IP_SRC | RXH_IP_DST;
> +
> +               break;
> +       case IPV6_FLOW:
> +               if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_IPv4)
> +                       info->data = RXH_IP_SRC | RXH_IP_DST;
> +
> +               break;
> +       default:
> +               info->data = 0;
> +               break;
> +       }
> +}
> +
> +bool virtnet_set_hashflow(struct virtnet_info *vi, struct ethtool_rxnfc *info)
> +{
> +       u64 is_iphash = info->data & (RXH_IP_SRC | RXH_IP_DST);
> +       u64 is_porthash = info->data & (RXH_L4_B_0_1 | RXH_L4_B_2_3);
> +       u32 new_hashtypes = vi->rss_hash_types_saved;
> +
> +       if ((is_iphash && (is_iphash != (RXH_IP_SRC | RXH_IP_DST))) ||
> +           (is_porthash && (is_porthash != (RXH_L4_B_0_1 | RXH_L4_B_2_3)))) {
> +               return false;
> +       }
> +
> +       if (!is_iphash && is_porthash)
> +               return false;
> +
> +       switch (info->flow_type) {
> +       case TCP_V4_FLOW:
> +       case UDP_V4_FLOW:
> +       case IPV4_FLOW:
> +               new_hashtypes &= ~VIRTIO_NET_RSS_HASH_TYPE_IPv4;
> +               if (is_iphash)
> +                       new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_IPv4;
> +
> +               break;
> +       case TCP_V6_FLOW:
> +       case UDP_V6_FLOW:
> +       case IPV6_FLOW:
> +               new_hashtypes &= ~VIRTIO_NET_RSS_HASH_TYPE_IPv6;
> +               if (is_iphash)
> +                       new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_IPv6;
> +
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       switch (info->flow_type) {
> +       case TCP_V4_FLOW:
> +               new_hashtypes &= ~VIRTIO_NET_RSS_HASH_TYPE_TCPv4;
> +               if (is_porthash)
> +                       new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_TCPv4;
> +
> +               break;
> +       case UDP_V4_FLOW:
> +               new_hashtypes &= ~VIRTIO_NET_RSS_HASH_TYPE_UDPv4;
> +               if (is_porthash)
> +                       new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_UDPv4;
> +
> +               break;
> +       case TCP_V6_FLOW:
> +               new_hashtypes &= ~VIRTIO_NET_RSS_HASH_TYPE_TCPv6;
> +               if (is_porthash)
> +                       new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_TCPv6;
> +
> +               break;
> +       case UDP_V6_FLOW:
> +               new_hashtypes &= ~VIRTIO_NET_RSS_HASH_TYPE_UDPv6;
> +               if (is_porthash)
> +                       new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_UDPv6;
> +
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       if (new_hashtypes != vi->rss_hash_types_saved) {
> +               vi->rss_hash_types_saved = new_hashtypes;
> +               vi->ctrl->rss.table_info.hash_types = vi->rss_hash_types_saved;
> +               if (vi->dev->features & NETIF_F_RXHASH)
> +                       return virtnet_commit_rss_command(vi);
> +       }
> +
> +       return true;
> +}
> +
>  static void virtnet_get_drvinfo(struct net_device *dev,
>                                 struct ethtool_drvinfo *info)
>  {
> @@ -2530,8 +2681,28 @@ int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info, u32 *r
>         switch (info->cmd) {
>         case ETHTOOL_GRXRINGS:
>                 info->data = vi->curr_queue_pairs;
> +               break;
> +       case ETHTOOL_GRXFH:
> +               virtnet_get_hashflow(vi, info);
> +               break;
> +       default:
>                 rc = -EOPNOTSUPP;
>         }
> +
> +       return rc;
> +}
> +
> +static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
> +{
> +       struct virtnet_info *vi = netdev_priv(dev);
> +       int rc = 0;
> +
> +       switch (info->cmd) {
> +       case ETHTOOL_SRXFH:
> +               if (!virtnet_set_hashflow(vi, info))
> +                       rc = -EINVAL;
> +
> +               break;
>         default:
>                 rc = -EOPNOTSUPP;
>         }
> @@ -2559,6 +2730,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
>         .get_rxfh = virtnet_get_rxfh,
>         .set_rxfh = virtnet_set_rxfh,
>         .get_rxnfc = virtnet_get_rxnfc,
> +       .set_rxnfc = virtnet_set_rxnfc,
>  };
>
>  static void virtnet_freeze_down(struct virtio_device *vdev)
> @@ -3351,8 +3523,13 @@ static int virtnet_probe(struct virtio_device *vdev)
>         if (vi->has_rss || vi->has_rss_hash_report) {
>                 vi->rss_hash_types_supported =
>                     virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
> +               vi->rss_hash_types_supported &=
> +                               ~(VIRTIO_NET_RSS_HASH_TYPE_IP_EX |
> +                                 VIRTIO_NET_RSS_HASH_TYPE_TCP_EX |
> +                                 VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
>
>                 dev->hw_features |= NETIF_F_RXHASH;
> +               dev->features |= NETIF_F_NTUPLE;

I think we don't support ntuple filters but hash filters?

Thanks

>         }
>
>         if (vi->has_cvq && vi->has_rss_hash_report)
> --
> 2.31.1
>

