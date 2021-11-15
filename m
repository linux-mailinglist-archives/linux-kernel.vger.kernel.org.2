Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222CF4509C1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 17:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbhKOQiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 11:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhKOQh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 11:37:56 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24027C061714
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 08:34:56 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id a129so9464948vkb.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 08:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VZxSbYl5jQSt8wP2WiEBDzWy0O0u/xAxqhCPrf7Lr/o=;
        b=iCS17978TSzIQAa0BVPeYfWl+7UloyD5JoRTt4zIwhZyL0g4q+bymce0OmcdgeAXMV
         9kIvfKFWP/yGmqmUAwMpCL1AFf61uZj8A+jvP6wsbTn0vRYmF2VjYJTwZuDRxndPVsAP
         +nKR4RRTl13Sx9d1IrG571PkZQL/t2SbMzYzzX+5JvJjiS1CUMHBew5CV2sFXmL6nXNH
         0WLmM0LpUg/iD/brXqL1glozQ0dUoZMoCsWLx/dvUd+JbnmE6Fxipcz4Gzy8TOHMGcvJ
         4vh98FTvHaKNA9HQ998z9vyeMSXc3/JeyuoAC1UKYUKBmm6KJCJF+nUu0Ztpm4ta97T6
         UKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VZxSbYl5jQSt8wP2WiEBDzWy0O0u/xAxqhCPrf7Lr/o=;
        b=XV4zpckCujKc4g8TGsLjZwBlRpw8EqQdT7B5funyPaEcDWE4Kxk5P1cOH8EWOKf3KQ
         WuWbZ8T6ezcCkVeiXMe5wUoG+lxi2Ixmr9xoDV/QQTw4MjZ7yJYFOCcBa6s2aoqAqWOv
         UY0EyzFH1qXoJd9cXQ6tbiKvXlh050xHH723SqVmZOu5wBuLPzzYDqpMvq99CR/f12lp
         9D1RYOcrhVM2kp7pjoFFDtQR2UJXvKUrw5g6KXp4NXRcinV7mlwfBG04JME+y+imRSWR
         50Vxqp+1T9cE1PlesqJkCDeflYaG7EvPt4j8LqZdm0s7mF/+hRHKMkAC7pUDm8pQY54+
         twTQ==
X-Gm-Message-State: AOAM5308ujQBaw0hCoNQ4CiO2vgzblVU1KOyHcvKLuopMrjpor8OZ8Hy
        wLZRsi3aP7n/gy9hmMuuDrImbDJlFnlMGQ==
X-Google-Smtp-Source: ABdhPJwjeFEXN4W5F1l4YyOgFq1IEM9FdqDxq/qXcbu6TXpsp354oJqKSgujIZt/kjYpw8GloR1xLA==
X-Received: by 2002:a05:6122:20ab:: with SMTP id i43mr61041364vkd.19.1636994095211;
        Mon, 15 Nov 2021 08:34:55 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id g21sm10110572vkd.26.2021.11.15.08.34.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 08:34:54 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id p37so34472867uae.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 08:34:54 -0800 (PST)
X-Received: by 2002:a05:6102:38d4:: with SMTP id k20mr45378060vst.42.1636994094206;
 Mon, 15 Nov 2021 08:34:54 -0800 (PST)
MIME-Version: 1.0
References: <20211115151618.126875-1-jonathan.davies@nutanix.com>
In-Reply-To: <20211115151618.126875-1-jonathan.davies@nutanix.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 15 Nov 2021 17:34:17 +0100
X-Gmail-Original-Message-ID: <CA+FuTScqWToamoOqAWkf1VbzYnjoM-y+-rQe_wEkPmBsOZbsLA@mail.gmail.com>
Message-ID: <CA+FuTScqWToamoOqAWkf1VbzYnjoM-y+-rQe_wEkPmBsOZbsLA@mail.gmail.com>
Subject: Re: [PATCH net] net: virtio_net_hdr_to_skb: count transport header in UFO
To:     Jonathan Davies <jonathan.davies@nutanix.com>
Cc:     netdev@vger.kernel.org, Florian Schmidt <flosch@nutanix.com>,
        Thilak Raj Surendra Babu <thilakraj.sb@nutanix.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 4:16 PM Jonathan Davies
<jonathan.davies@nutanix.com> wrote:
>
> virtio_net_hdr_to_skb does not set the skb's gso_size and gso_type
> correctly for UFO packets received via virtio-net that are a little over
> the GSO size. This can lead to problems elsewhere in the networking
> stack, e.g. ovs_vport_send dropping over-sized packets if gso_size is
> not set.
>
> This is due to the comparison
>
>   if (skb->len - p_off > gso_size)
>
> not properly accounting for the transport layer header.
>
> p_off includes the size of the transport layer header (thlen), so
> skb->len - p_off is the size of the TCP/UDP payload.
>
> gso_size is read from the virtio-net header. For UFO, fragmentation
> happens at the IP level so does not need to include the UDP header.
>
> Hence the calculation could be comparing a TCP/UDP payload length with
> an IP payload length, causing legitimate virtio-net packets to have
> lack gso_type/gso_size information.
>
> Example: a UDP packet with payload size 1473 has IP payload size 1481.
> If the guest used UFO, it is not fragmented and the virtio-net header's
> flags indicate that it is a GSO frame (VIRTIO_NET_HDR_GSO_UDP), with
> gso_size = 1480 for an MTU of 1500.  skb->len will be 1515 and p_off
> will be 42, so skb->len - p_off = 1473.  Hence the comparison fails, and
> shinfo->gso_size and gso_type are not set as they should be.
>
> Instead, add the UDP header length before comparing to gso_size when
> using UFO. In this way, it is the size of the IP payload that is
> compared to gso_size.
>
> Fixes: 6dd912f8 ("net: check untrusted gso_size at kernel entry")
> Signed-off-by: Jonathan Davies <jonathan.davies@nutanix.com>

Thanks for the fix, and the detailed explanation of the bug.

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  include/linux/virtio_net.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index b465f8f..bea56af 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -122,8 +122,11 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>                 u16 gso_size = __virtio16_to_cpu(little_endian, hdr->gso_size);
>                 struct skb_shared_info *shinfo = skb_shinfo(skb);
>
> -               /* Too small packets are not really GSO ones. */
> -               if (skb->len - p_off > gso_size) {
> +               /* Too small packets are not really GSO ones.
> +                * UFO may not include transport header in gso_size.
> +                */
> +               if (gso_type & SKB_GSO_UDP && skb->len - p_off + thlen > gso_size ||
> +                   skb->len - p_off > gso_size) {

Perhaps for readability instead something like

  unsigned int nh_off = p_off;

  if (gso_type & SKB_GSO_UDP)
    nh_off -= thlen;




>                         shinfo->gso_size = gso_size;
>                         shinfo->gso_type = gso_type;
>
> --
> 2.9.3
>
