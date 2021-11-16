Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C90F453BCD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 22:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhKPVqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 16:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhKPVqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 16:46:20 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7AEC061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 13:43:22 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id r15so1322255uao.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 13:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=88TappYm4yL0O8HEW0TOShDM24Xx97b5DxNpcH/zWqQ=;
        b=XRDoMtUP6GzS9foDBRt9ZHRsri8/yfmInOx9aPd4oVUNaVqYqR8uh40QKti7EOgMdG
         nt+fQ1WiJi9RO6jO0t2xOLKnJwwxywCi10Mb4FSnJrB5tGfXo0V9LfpxdtPSB/5mIBnX
         Z9JWjAnaK5YdcKpPHR7J9Ucof7BNq/HXowou227czB+73v8lGk4rd7QSeJfd+cyxnq2a
         bfndFDDlOnjTlvlK+SP7M7SsB8SYukh5SYd5Rf9A7x8FOvuz7Sb5UGm4vQsvUTzEkmrJ
         0Mts00LYUtuCWXbBoz9HFyTApZowDvIj9i771xpszOeidCl920fShqy6vnUEpwWRU1zd
         u04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=88TappYm4yL0O8HEW0TOShDM24Xx97b5DxNpcH/zWqQ=;
        b=GR6dtaJVBniTGb6/xMXlGCX2A7GW4OLgv/x7WbzKRdiWu/6bwFnHeMH42IiE+U8Ny3
         1NjXcAzBrfViYg/K+wP3VuxME5maDtgBMkhImUDLw+kp2MxEPf/t4aobrU1jd7gmTfWJ
         u2HTiUZNjZ9Ibz8dPN28ietnbxcowpjhz2M7rp8ag9UlDxvirITa18RVVGnwGWupYuFm
         anSPnVH7xjysrYTPrtg3J3HzC5jnztcaeL9OUChItE9mOTXlpa2eLcgfPvePz7Y7HBvE
         pfPL7B+Vu49uGnpkHyhwyw9kYAjeqL0mZKVTX/vDVuvw2Jwj1dXX/hVHf/Xe4eMauwPz
         FBYA==
X-Gm-Message-State: AOAM531iHY8VKZBUXXTMS5Ok4f8gaVt6Frx8du0654cWqxasuG8+mbos
        nwXaKAUho2+NtEQ/c675esTgVtQajfhhNQ==
X-Google-Smtp-Source: ABdhPJyP4xSJ+R1Nsnkl1Adxcm3HAULf3g3S97bZeQ/MIAtTJWXaxNsEQx3TznJhe2l0MT5tqCG/Jg==
X-Received: by 2002:ab0:45a8:: with SMTP id u37mr16238832uau.24.1637099001905;
        Tue, 16 Nov 2021 13:43:21 -0800 (PST)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id v17sm2531026uar.15.2021.11.16.13.43.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 13:43:21 -0800 (PST)
Received: by mail-vk1-f173.google.com with SMTP id t127so354242vke.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 13:43:21 -0800 (PST)
X-Received: by 2002:a1f:e287:: with SMTP id z129mr78866040vkg.17.1637099001001;
 Tue, 16 Nov 2021 13:43:21 -0800 (PST)
MIME-Version: 1.0
References: <20211116174242.32681-1-jonathan.davies@nutanix.com>
In-Reply-To: <20211116174242.32681-1-jonathan.davies@nutanix.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 16 Nov 2021 22:42:45 +0100
X-Gmail-Original-Message-ID: <CA+FuTSfXfDXJpU7N2ba4D9wQy0A8acUq2k-RmVDJjT_bmtH_mw@mail.gmail.com>
Message-ID: <CA+FuTSfXfDXJpU7N2ba4D9wQy0A8acUq2k-RmVDJjT_bmtH_mw@mail.gmail.com>
Subject: Re: [PATCH v2 net] net: virtio_net_hdr_to_skb: count transport header
 in UFO
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

On Tue, Nov 16, 2021 at 6:43 PM Jonathan Davies
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

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
> Changes in v2:
>  - refactor to use variable for readability
> ---
>  include/linux/virtio_net.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index b465f8f..04e87f4b 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -120,10 +120,15 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>
>         if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
>                 u16 gso_size = __virtio16_to_cpu(little_endian, hdr->gso_size);
> +               unsigned int nh_off = p_off;
>                 struct skb_shared_info *shinfo = skb_shinfo(skb);
>
> +               /* UFO may not include transport header in gso_size. */
> +               if (gso_type & SKB_GSO_UDP)
> +                       nh_off -= thlen;

Subtracting from an unsigned int always has the chance of negative overflow.

This case is safe, as all three paths that lead here have a p_off >= thlen.

I just noticed a more obscure fourth path:

        if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
                switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {

We do not explicitly check against hdr->gso_type ==
VIRTIO_NET_HDR_GSO_ECN. An obviously bogus value. That leaves p_off 0.
But it also leaves th_len 0, so it is safe.

Negative overflow is also safe in this case.
