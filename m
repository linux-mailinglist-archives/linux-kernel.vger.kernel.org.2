Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916613312E3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 17:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhCHQIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 11:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhCHQHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 11:07:53 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A565C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 08:07:53 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id p7so10023323eju.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 08:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9fWdVn7nLt3E3L4QID9g8tlOiKwr5cryDbVteVsjhto=;
        b=hby+9gRwE9g9hGAihLCdCtBZ+y4eU1Zfe61MagbI6fqe4FrPk/dLp7WrdubLG93OD4
         xs6lPQ1gHQheNmcoCu6iCEgcfHG9g7FxaBOxs8BB5gxPKEvR1YTBtFilN6gcbe1qPGol
         D1kArFIP6UYLue+0sZkge50+rXKAFp+ylwJ0rVzlyX/UmyDc0tzOPaL6pGW42eG2hSZ5
         dXvgTuHFS/YR8OBxpnDOBvgzZXiuIp//VjqV9BVEjoAlxoX8AodWem+MR0qvm79GGDEu
         DrJvlQdq/Oo/XWQVkj5+PHPoz+34btM4p7tCUKmuKJ7GvdUaDMYsSCQeLQr2jw/AtUJi
         b1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9fWdVn7nLt3E3L4QID9g8tlOiKwr5cryDbVteVsjhto=;
        b=RcELJxoJQMqKMX6qg4ZAFV0mmQx6S2o9jHR6NuphHyfFqQht+Bv4UpQfAnmqEgepkj
         1WXXgmiKG/yN9xo4lziVkigmt9IW+gqSTvZBa7QLXwzOR3M1ip4xYAhHp6daSoOP4W/q
         elzasjLN4waDaxJ4Cvj05sAjFKq5tCGKQY7ugq7wHp81QHB3VwRxKy9Ou0PHY8f2+oj8
         OTHJiiWXNs+UdTskIlL+sxU/RIDFek2fgxGCcyb4CzP2EOXgtuQliIivKKm72u/njBMb
         YeFrISnC2M6QmAh/mbt1ZCDf7inlWRuOaiR0axaEr4pEwz86dETGcQ9fC8e4+Idl1q4H
         /KLQ==
X-Gm-Message-State: AOAM533YOoGcNpAwCIKYuHmxcTkHXx08rpnidjMeC60mzC1owWwOXRlV
        ml39VCRd1+Szxo3HoXjbOjh8Iy2ZlV8=
X-Google-Smtp-Source: ABdhPJycbBSDpkmdrb2kLCsvo02PFs6XEmTzn+ndq7sfw7VHTOtbVHHZx3mdrWUJ93tyzr3KsArS0Q==
X-Received: by 2002:a17:906:53d7:: with SMTP id p23mr15860850ejo.140.1615219671238;
        Mon, 08 Mar 2021 08:07:51 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id a12sm7439506edx.91.2021.03.08.08.07.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 08:07:50 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so4139421wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 08:07:50 -0800 (PST)
X-Received: by 2002:a05:600c:4150:: with SMTP id h16mr21312488wmm.120.1615219669904;
 Mon, 08 Mar 2021 08:07:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1615199056.git.bnemeth@redhat.com> <85e04e1e6367f19c8f538d145b32f5bb93788d8a.1615199056.git.bnemeth@redhat.com>
In-Reply-To: <85e04e1e6367f19c8f538d145b32f5bb93788d8a.1615199056.git.bnemeth@redhat.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 8 Mar 2021 11:07:10 -0500
X-Gmail-Original-Message-ID: <CA+FuTSdWSCzkB7sDn+_0Oxy8JqmqL=nsQXP_3bnb4Xdd=0A=KQ@mail.gmail.com>
Message-ID: <CA+FuTSdWSCzkB7sDn+_0Oxy8JqmqL=nsQXP_3bnb4Xdd=0A=KQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] net: avoid infinite loop in mpls_gso_segment when
 mpls_hlen == 0
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
> A packet with skb_inner_network_header(skb) == skb_network_header(skb)
> and ETH_P_MPLS_UC will prevent mpls_gso_segment from pulling any headers
> from the packet. Subsequently, the call to skb_mac_gso_segment will
> again call mpls_gso_segment with the same packet leading to an infinite
> loop.
>
> Signed-off-by: Balazs Nemeth <bnemeth@redhat.com>
> ---
>  net/mpls/mpls_gso.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mpls/mpls_gso.c b/net/mpls/mpls_gso.c
> index b1690149b6fa..cc1b6457fc93 100644
> --- a/net/mpls/mpls_gso.c
> +++ b/net/mpls/mpls_gso.c
> @@ -27,7 +27,7 @@ static struct sk_buff *mpls_gso_segment(struct sk_buff *skb,
>
>         skb_reset_network_header(skb);
>         mpls_hlen = skb_inner_network_header(skb) - skb_network_header(skb);
> -       if (unlikely(!pskb_may_pull(skb, mpls_hlen)))
> +       if (unlikely(!mpls_hlen || !pskb_may_pull(skb, mpls_hlen)))
>                 goto out;

Good cathc. Besides length zero, this can be more strict: a label is
4B, so mpls_hlen needs to be >= 4B.

Perhaps even aligned to 4B, too, but not if there may be other encap on top.

Unfortunately there is no struct or type definition that we can use a
sizeof instead of open coding the raw constant.
