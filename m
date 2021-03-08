Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7633312C7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 17:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhCHQCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 11:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhCHQCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 11:02:18 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB14C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 08:02:18 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id mj10so21403737ejb.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 08:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NxiEy8ngZSokddcTCYt4nwbLH8RmaBWtr4TL2Y05SAk=;
        b=saj2O1QdxK6slYJFU1OOFaCUnduRugIlRrckll+J7guPfb2NP8uN3xVMlAJuW8kE/1
         yOxLpDxeUqurKTGsL9bh9pHi9R3GYLFqJgW+GttJ9QaaepqCydx35O57yyeqv/WZ7A86
         G0k8y6bzsEm9SYx1NGh66aoWZAw/79OvaV7AOaGrLpifMFgHZciNwEDKGg17t2Pjmy87
         IX5p+k1sYcLPuRW2PC9eXIP2JRoVUn3lf8l/w/5rn5QJMXYofAuDp1f7QUhDMxX5e/hP
         Ne8Tply/7orVzVAgwypbC2CvEn35RLbdRZ5fNtw08EIjS0ka+n0+UG+livh+IApV52XN
         vssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NxiEy8ngZSokddcTCYt4nwbLH8RmaBWtr4TL2Y05SAk=;
        b=aAMDq8c7pZO1c31AQAkLFpCBQ2RletdLvO5KwMjkFFccBULvg8oE7KQ1CA/Zru9iW4
         HKdpRByqpM/D0BhiS177Lrzwi4yVrZ8PZlTUu6Zc+FVhCLV9YvKIIDu0T/Jses4lWuiA
         jO4GHrWYihLksoFfSCulekQaxiLCLZw/Jbu2zK5M2gqvxjVbbGiMcDdhrs/sWAuFwzcW
         PLzWddlFUCqkn8dzhwtoWpGW0IEKnplWokbtnNjZv24YWLHpEGvshirKR5YXSgBEUtLJ
         xZ83mNIYNxic5lMcP+jeU4RiCAUlGREYU2Luz8PACkdqphh5gL1Rvs//4/FA5d6UEt3k
         9F1w==
X-Gm-Message-State: AOAM532YyOIMKw07irVH0h/fMO1nwXgeplidfUwsgUrh6XNzBSMIF4Au
        ytVESfnVdGHCSz6OmMpaeqfOUHjAsZQ=
X-Google-Smtp-Source: ABdhPJzoosmQQQ8nnKONm6pw2PLv3fgLp3vcLEGAbZzVThIyf5j/WZmJdV+GJcGp3jhS6udqqMrg3g==
X-Received: by 2002:a17:906:fcb2:: with SMTP id qw18mr15075265ejb.434.1615219336770;
        Mon, 08 Mar 2021 08:02:16 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id l12sm7034644edb.39.2021.03.08.08.02.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 08:02:16 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id y124-20020a1c32820000b029010c93864955so4120353wmy.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 08:02:15 -0800 (PST)
X-Received: by 2002:a05:600c:198c:: with SMTP id t12mr22392924wmq.183.1615219334650;
 Mon, 08 Mar 2021 08:02:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1615199056.git.bnemeth@redhat.com> <8f2cb8f8614d86bba02df73c1a0665179583f1c3.1615199056.git.bnemeth@redhat.com>
In-Reply-To: <8f2cb8f8614d86bba02df73c1a0665179583f1c3.1615199056.git.bnemeth@redhat.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 8 Mar 2021 11:01:35 -0500
X-Gmail-Original-Message-ID: <CA+FuTSduKqeLB8wcLxiZXHgQF6y596F-nt+UwzUZngdTWwZ_rA@mail.gmail.com>
Message-ID: <CA+FuTSduKqeLB8wcLxiZXHgQF6y596F-nt+UwzUZngdTWwZ_rA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] net: check if protocol extracted by
 virtio_net_hdr_set_proto is correct
To:     Balazs Nemeth <bnemeth@redhat.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        David Miller <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 8, 2021 at 5:32 AM Balazs Nemeth <bnemeth@redhat.com> wrote:
>
> For gso packets, virtio_net_hdr_set_proto sets the protocol (if it isn't
> set) based on the type in the virtio net hdr, but the skb could contain
> anything since it could come from packet_snd through a raw socket. If
> there is a mismatch between what virtio_net_hdr_set_proto sets and
> the actual protocol, then the skb could be handled incorrectly later
> on.
>
> An example where this poses an issue is with the subsequent call to
> skb_flow_dissect_flow_keys_basic which relies on skb->protocol being set
> correctly. A specially crafted packet could fool
> skb_flow_dissect_flow_keys_basic preventing EINVAL to be returned.
>
> Avoid blindly trusting the information provided by the virtio net header
> by checking that the protocol in the packet actually matches the
> protocol set by virtio_net_hdr_set_proto. Note that since the protocol
> is only checked if skb->dev implements header_ops->parse_protocol,
> packets from devices without the implementation are not checked at this
> stage.
>
> Fixes: 9274124f023b ("net: stricter validation of untrusted gso packets")
> Signed-off-by: Balazs Nemeth <bnemeth@redhat.com>

Going forward, please mark your the patch as targeting the net tree
using [PATCH net]

> ---
>  include/linux/virtio_net.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index e8a924eeea3d..6c478eee0452 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -79,8 +79,14 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>                 if (gso_type && skb->network_header) {
>                         struct flow_keys_basic keys;
>
> -                       if (!skb->protocol)
> +                       if (!skb->protocol) {
> +                               const struct ethhdr *eth = skb_eth_hdr(skb);

eth is no longer used.

> +                               __be16 etype = dev_parse_header_protocol(skb);

nit: customary to call this protocol. etype, I guess short for
EtherType, makes sense, but is not commonly used in the kernel.

> +
>                                 virtio_net_hdr_set_proto(skb, hdr);
> +                               if (etype && etype != skb->protocol)
> +                                       return -EINVAL;
> +                       }
>  retry:
>                         if (!skb_flow_dissect_flow_keys_basic(NULL, skb, &keys,
>                                                               NULL, 0, 0, 0,
> --
> 2.29.2
>
