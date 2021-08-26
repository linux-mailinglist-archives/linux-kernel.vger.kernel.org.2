Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BC63F812C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 05:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238002AbhHZDbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 23:31:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29505 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236891AbhHZDbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 23:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629948621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eEAbeV6QhPu84KG5CC307zTKXbX2UdBwPkKc0p1KhSE=;
        b=HxJmqVOjgeg6fTdDatI5+EB/mbUCZr+7KAmKPrx9yIG9M0/FjSB9WRBqYdQDOAORgdu+uc
        BM0qRSSsql0xs49RL84Ps7RNfxZwzSDbMWgN0pO10UP31wbYm2NDhlMU6lZj5VGnunPRXC
        42JDVcH69COhjNo9qzjkgCqjbv0C/+0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-W0MUXD44P0aecKz-uO_oxA-1; Wed, 25 Aug 2021 23:30:19 -0400
X-MC-Unique: W0MUXD44P0aecKz-uO_oxA-1
Received: by mail-lf1-f71.google.com with SMTP id p3-20020a0565121383b0290384997a48fcso463462lfa.21
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 20:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eEAbeV6QhPu84KG5CC307zTKXbX2UdBwPkKc0p1KhSE=;
        b=XszBJydApqt/i8zrqIg/vj/ds+e+32sCJqh5rh+ZbBTsd68RrtruPKBU5vUyiqIajI
         MHxc/EzYyemATMNBkKzx/58rNjSe4/XMBefTKz7kbUtIfgJhP9M8l8TaXpakWOJ1GfL1
         4jGtk8Xs48wHWAg3qHYlOYnFHLoywBYLwmjHfwCfE6z8zlkc+Fxk24UFFYLUS3Y7DkS2
         NxMMGDG2DDR/h/Jt+0EjLvdnLvv2qe9TlMezu3/juDpmhf0u7N/UiZ9EhCF8H4Qu4cy7
         UtWFEnDPLZouAgUwqMjpQW0tAgOGlgFYX3lKXXDUPXqppjZIL2xt8z6mPsUgcNfyki9j
         E4Kg==
X-Gm-Message-State: AOAM532N6r+TUQ0R6qWRowpkOpXNpOdFyjlfu3nLEMWLvX0iN1EmPJ/V
        5WLnLDSPPp3g33Ur3pQamr5LdimGTQCKjNUVxHaqzp3JEgfKuspeLomMKshiQ3a/X8jel8nK6vx
        ouRDCgU37vFOxIFrf7dJJZfG2HX5mlBucJJCvZAZB
X-Received: by 2002:a05:651c:10a3:: with SMTP id k3mr1143746ljn.471.1629948617804;
        Wed, 25 Aug 2021 20:30:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyovJ4/uCaZXr4m33mK988gFYVkr+C8ARZKldn+ftKy6xj/3lgAQDoaX2wc7igzKNKlWI3wDnMsLWgS4jENFjA=
X-Received: by 2002:a05:651c:10a3:: with SMTP id k3mr1143728ljn.471.1629948617641;
 Wed, 25 Aug 2021 20:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <1629946187-60536-1-git-send-email-linyunsheng@huawei.com>
In-Reply-To: <1629946187-60536-1-git-send-email-linyunsheng@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 26 Aug 2021 11:30:06 +0800
Message-ID: <CACGkMEsphZkkRv5AnXUE_86FUKHMgTXpyVVgDUb+tNdATKQsWA@mail.gmail.com>
Subject: Re: [PATCH net-next] sock: remove one redundant SKB_FRAG_PAGE_ORDER macro
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     davem <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        linuxarm@openeuler.org, mst <mst@redhat.com>,
        Eric Dumazet <edumazet@google.com>, pabeni@redhat.com,
        fw@strlen.de, aahringo@redhat.com,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>, yangbo.lu@nxp.com,
        kvm <kvm@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 10:51 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> Both SKB_FRAG_PAGE_ORDER are defined to the same value in
> net/core/sock.c and drivers/vhost/net.c.
>
> Move the SKB_FRAG_PAGE_ORDER definition to net/core/sock.h,
> as both net/core/sock.c and drivers/vhost/net.c include it,
> and it seems a reasonable file to put the macro.
>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

>  drivers/vhost/net.c | 2 --
>  include/net/sock.h  | 1 +
>  net/core/sock.c     | 1 -
>  3 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 6414bd5..3a249ee 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -643,8 +643,6 @@ static bool tx_can_batch(struct vhost_virtqueue *vq, size_t total_len)
>                !vhost_vq_avail_empty(vq->dev, vq);
>  }
>
> -#define SKB_FRAG_PAGE_ORDER     get_order(32768)
> -
>  static bool vhost_net_page_frag_refill(struct vhost_net *net, unsigned int sz,
>                                        struct page_frag *pfrag, gfp_t gfp)
>  {
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 95b2577..66a9a90 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2717,6 +2717,7 @@ extern int sysctl_optmem_max;
>  extern __u32 sysctl_wmem_default;
>  extern __u32 sysctl_rmem_default;
>
> +#define SKB_FRAG_PAGE_ORDER    get_order(32768)
>  DECLARE_STATIC_KEY_FALSE(net_high_order_alloc_disable_key);
>
>  static inline int sk_get_wmem0(const struct sock *sk, const struct proto *proto)
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 950f1e7..62627e8 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2574,7 +2574,6 @@ static void sk_leave_memory_pressure(struct sock *sk)
>         }
>  }
>
> -#define SKB_FRAG_PAGE_ORDER    get_order(32768)
>  DEFINE_STATIC_KEY_FALSE(net_high_order_alloc_disable_key);
>
>  /**
> --
> 2.7.4
>

