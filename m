Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB943132F0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 14:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhBHNIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 08:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhBHNIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 08:08:19 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB7FC061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 05:07:39 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id c8so4618132uae.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 05:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q9Lnou6eX+Zd+gwTwesC/efPmGOGWWLzMGlqwzv2rt0=;
        b=oePKnSNfeI0UK4muyPGY/ru0jUlhoYs+j5TVlGjCaYRXsVX+kVQyxqjnC/dwx+VtIG
         QGx3zO/4twrhLUQSzhQ5Em1+sCforUN8PxIJ9UXTIP/JxSH0FsMvmqEDuohqjPxMWLS1
         sWFro9vkIq3Ur3ReeY5F4U6sdA4+ex8ydYWli+DdHx0EzMIKmOBSDsYMBCXrOW+oJZQk
         K0aF0H06loyA1bhgHPAENrCptWQDxnen4qEjbTcrghHsYojYHFlphwoL48XM1vQvr6Ws
         SoWLm8rizbQpFfKSWT3f1dIr3xOzH+5eye0bqf27FJBMNJtoz68oQzyYVHtLe3FQhXpJ
         gJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q9Lnou6eX+Zd+gwTwesC/efPmGOGWWLzMGlqwzv2rt0=;
        b=b8g+g5d4C2wjG1DlX/BhskyOwVThy3TtszQmi/D5R1V8sNlHW09QtpLaeR3kuAM0r2
         oFbVjJPgWjILYXc4mAcwVX3ywR7QQb8yVyIqmJaxyKaRcsTqm3/oep4q7ECo7QnkbegF
         v9PYFFUBRnQU1X3oUQi9ZJ9hqPpJMYB9Wr75e9QikRIGWmCsUj67QFu3Y8NztMAlZIAx
         8FquNUqlsgBokO1On0buQZJbZijEh7XBLaqWCLsgWyL8GxlP7/wacTpJvJf9oWX3m5AP
         qvx68APmTcSSA8C7qqht2VAHjrheAnUcAxlMzbpW6NK3WjOc7UtTnIjXZFMOyvTcOvZB
         h9Jg==
X-Gm-Message-State: AOAM531SFUsAALlc9Junge6f2l+uYivjLoPlJk0SxCBPnF318vqQBBW1
        PoSBJpP5PrYBafVbwezQF5FX/U0qsl8=
X-Google-Smtp-Source: ABdhPJwVfZLxfjUgX4IDlFbOSMJ0N3eUyzSHdY95+2nqbpHEe26jrbeufKjWiesxgU0KBzGkxMTG+g==
X-Received: by 2002:a9f:2985:: with SMTP id s5mr9952672uas.13.1612789658267;
        Mon, 08 Feb 2021 05:07:38 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id h62sm2094570uad.15.2021.02.08.05.07.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 05:07:37 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id x13so495144vsl.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 05:07:36 -0800 (PST)
X-Received: by 2002:a67:581:: with SMTP id 123mr10048669vsf.14.1612789656311;
 Mon, 08 Feb 2021 05:07:36 -0800 (PST)
MIME-Version: 1.0
References: <20210208113810.11118-1-hxseverything@gmail.com>
In-Reply-To: <20210208113810.11118-1-hxseverything@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 8 Feb 2021 08:06:59 -0500
X-Gmail-Original-Message-ID: <CA+FuTScScC2o6uDjua0T3Eucbjt8-YPf65h3xgxMpTtWvgjWmg@mail.gmail.com>
Message-ID: <CA+FuTScScC2o6uDjua0T3Eucbjt8-YPf65h3xgxMpTtWvgjWmg@mail.gmail.com>
Subject: Re: [PATCH] bpf: in bpf_skb_adjust_room correct inner protocol for vxlan
To:     huangxuesen <hxseverything@gmail.com>
Cc:     David Miller <davem@davemloft.net>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        huangxuesen <huangxuesen@kuaishou.com>,
        chengzhiyong <chengzhiyong@kuaishou.com>,
        wangli <wangli09@kuaishou.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 7:16 AM huangxuesen <hxseverything@gmail.com> wrote:
>
> From: huangxuesen <huangxuesen@kuaishou.com>
>
> When pushing vxlan tunnel header, set inner protocol as ETH_P_TEB in skb
> to avoid HW device disabling udp tunnel segmentation offload, just like
> vxlan_build_skb does.
>
> Drivers for NIC may invoke vxlan_features_check to check the
> inner_protocol in skb for vxlan packets to decide whether to disable
> NETIF_F_GSO_MASK. Currently it sets inner_protocol as the original
> skb->protocol, that will make mlx5_core disable TSO and lead to huge
> performance degradation.
>
> Signed-off-by: huangxuesen <huangxuesen@kuaishou.com>
> Signed-off-by: chengzhiyong <chengzhiyong@kuaishou.com>
> Signed-off-by: wangli <wangli09@kuaishou.com>
> ---
>  net/core/filter.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 255aeee72402..f8d3ba3fe10f 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3466,7 +3466,12 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>                 skb->inner_mac_header = inner_net - inner_mac_len;
>                 skb->inner_network_header = inner_net;
>                 skb->inner_transport_header = inner_trans;
> -               skb_set_inner_protocol(skb, skb->protocol);
> +
> +               if (flags & BPF_F_ADJ_ROOM_ENCAP_L4_UDP &&
> +                   inner_mac_len == ETH_HLEN)
> +                       skb_set_inner_protocol(skb, htons(ETH_P_TEB));

This may be used by vxlan, but it does not imply it.

Adding ETH_HLEN bytes likely means pushing an Ethernet header, but same point.

Conversely, pushing an Ethernet header is not limited to UDP encap.

This probably needs a new explicit BPF_F_ADJ_ROOM_.. flag, rather than
trying to infer from imprecise heuristics.
