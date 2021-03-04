Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9FC32D4D2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 15:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbhCDOEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 09:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237018AbhCDOEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 09:04:15 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18776C06175F
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 06:03:35 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id w1so49641495ejf.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 06:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g1tdC4DAWUKpwHKmfGOMBVPLo5pkE31kY4A2V+ZSNK8=;
        b=j+QE9hFHwOn0jf2iY8vZIRkwwANg+cq6OkDtp7/5QGxaV2rEMZars6of5cZ056++Wl
         opV3ATU5jpM0hMBSf5WoUIwscIYDGb7UJbeXys9RZG2LCa5lGZnHqPClrDwMGYWahoHm
         rKUwZOtIwkPT2S+oc/kQQ2xnT2xDInRyQXdgcD+I76SOqmhgcTUGQLAJ/EXbphTjygZ5
         dKHpiWitNLtBzHTcQxpW1EiICT35xQz7LO+FatvVh34zvtjcLLHEQzv+LqTRx8CC7H+L
         21Jlkpo0Tdza6mjSn45SqfkEMmnCV7Zso4Qi30atHXHzf//0FntT9Y7vpC0RA5MIR2/L
         sDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g1tdC4DAWUKpwHKmfGOMBVPLo5pkE31kY4A2V+ZSNK8=;
        b=BqsDYedOq7qnJ0WlryjdARpohENtSNPFiUHHXDkeoL3WCYnECeiprA2vBas40n7cHw
         7/vw82pvady6aYlDjlyu9jjqCBKWL5fqrnZWaqcOU7U4IxYY7d2ajduoCaalQgKlhrOX
         iKmpVzVJAaPW8rM9KT7qdgqh93irvHvdiFynhROET8uLmQ08j/xHlo0NFW3SF2DmM5L+
         TXiWJlezsRWvhx4piKtjscA3zYCZt40NY6UOyQENgy7h5hm8L9fXW4wuR2+kjU+aGLij
         KhjUkVNO/DSV4LiibvdPQAqcrklLJJ7uIOber4tNieirymGZhCzILy/pZoJunidtoWpt
         0OZQ==
X-Gm-Message-State: AOAM5317yNCZz7Et73+eio7DbcGu1zBP0BN34iIb1xe5uho7ertbCbax
        IQ0x4d7V4wtTG3spTXC71LnNFvGC2aM=
X-Google-Smtp-Source: ABdhPJwN47Xnkv4nXtAjXMIXZuEcunKdAIppjuaPSI71k3gqXXs+tnUm4uFryovtLxJy9P/wQX7Dyw==
X-Received: by 2002:a17:906:9515:: with SMTP id u21mr4536225ejx.86.1614866613532;
        Thu, 04 Mar 2021 06:03:33 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id gb4sm5241513ejc.122.2021.03.04.06.03.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 06:03:32 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id n22so8147263wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 06:03:31 -0800 (PST)
X-Received: by 2002:a05:600c:198c:: with SMTP id t12mr4014740wmq.183.1614866611549;
 Thu, 04 Mar 2021 06:03:31 -0800 (PST)
MIME-Version: 1.0
References: <20210304064212.6513-1-hxseverything@gmail.com>
In-Reply-To: <20210304064212.6513-1-hxseverything@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 4 Mar 2021 09:02:53 -0500
X-Gmail-Original-Message-ID: <CA+FuTSfj2u5pEbKJR_m0qCiPfdhCVS_BZVPPO=dNjAyL7HG7FQ@mail.gmail.com>
Message-ID: <CA+FuTSfj2u5pEbKJR_m0qCiPfdhCVS_BZVPPO=dNjAyL7HG7FQ@mail.gmail.com>
Subject: Re: [PATCH] selftests_bpf: extend test_tc_tunnel test with vxlan
To:     Xuesen Huang <hxseverything@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, bpf <bpf@vger.kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Xuesen Huang <huangxuesen@kuaishou.com>,
        Li Wang <wangli09@kuaishou.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 4, 2021 at 1:42 AM Xuesen Huang <hxseverything@gmail.com> wrote:
>
> From: Xuesen Huang <huangxuesen@kuaishou.com>
>
> Add BPF_F_ADJ_ROOM_ENCAP_L2_ETH flag to the existing tests which
> encapsulates the ethernet as the inner l2 header.
>
> Update a vxlan encapsulation test case.
>
> Signed-off-by: Xuesen Huang <huangxuesen@kuaishou.com>
> Signed-off-by: Li Wang <wangli09@kuaishou.com>
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Please mark patch target: [PATCH bpf-next]

> ---
>  tools/testing/selftests/bpf/progs/test_tc_tunnel.c | 113 ++++++++++++++++++---
>  tools/testing/selftests/bpf/test_tc_tunnel.sh      |  15 ++-
>  2 files changed, 111 insertions(+), 17 deletions(-)


> -static __always_inline int encap_ipv4(struct __sk_buff *skb, __u8 encap_proto,
> -                                     __u16 l2_proto)
> +static __always_inline int __encap_ipv4(struct __sk_buff *skb, __u8 encap_proto,
> +                                       __u16 l2_proto, __u16 ext_proto)
>  {
>         __u16 udp_dst = UDP_PORT;
>         struct iphdr iph_inner;
>         struct v4hdr h_outer;
>         struct tcphdr tcph;
>         int olen, l2_len;
> +       __u8 *l2_hdr = NULL;
>         int tcp_off;
>         __u64 flags;
>
> @@ -141,7 +157,11 @@ static __always_inline int encap_ipv4(struct __sk_buff *skb, __u8 encap_proto,
>                 break;
>         case ETH_P_TEB:
>                 l2_len = ETH_HLEN;
> -               udp_dst = ETH_OVER_UDP_PORT;
> +               if (ext_proto & EXTPROTO_VXLAN) {
> +                       udp_dst = VXLAN_UDP_PORT;
> +                       l2_len += sizeof(struct vxlanhdr);
> +               } else
> +                       udp_dst = ETH_OVER_UDP_PORT;
>                 break;
>         }
>         flags |= BPF_F_ADJ_ROOM_ENCAP_L2(l2_len);
> @@ -171,14 +191,26 @@ static __always_inline int encap_ipv4(struct __sk_buff *skb, __u8 encap_proto,
>         }
>
>         /* add L2 encap (if specified) */
> +       l2_hdr = (__u8 *)&h_outer + olen;
>         switch (l2_proto) {
>         case ETH_P_MPLS_UC:
> -               *((__u32 *)((__u8 *)&h_outer + olen)) = mpls_label;
> +               *(__u32 *)l2_hdr = mpls_label;
>                 break;
>         case ETH_P_TEB:
> -               if (bpf_skb_load_bytes(skb, 0, (__u8 *)&h_outer + olen,
> -                                      ETH_HLEN))
> +               flags |= BPF_F_ADJ_ROOM_ENCAP_L2_ETH;
> +
> +               if (ext_proto & EXTPROTO_VXLAN) {
> +                       struct vxlanhdr *vxlan_hdr = (struct vxlanhdr *)l2_hdr;
> +
> +                       vxlan_hdr->vx_flags = VXLAN_FLAGS;
> +                       vxlan_hdr->vx_vni = bpf_htonl((VXLAN_VNI & VXLAN_VNI_MASK) << 8);
> +
> +                       l2_hdr += sizeof(struct vxlanhdr);

should this be l2_len? (here and ipv6 below)

> +SEC("encap_vxlan_eth")
> +int __encap_vxlan_eth(struct __sk_buff *skb)
> +{
> +       if (skb->protocol == __bpf_constant_htons(ETH_P_IP))
> +               return __encap_ipv4(skb, IPPROTO_UDP,
> +                               ETH_P_TEB,
> +                               EXTPROTO_VXLAN);

non-standard indentation: align with the opening parenthesis. (here
and ipv6 below)
