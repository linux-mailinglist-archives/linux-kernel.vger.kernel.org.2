Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C973955EC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhEaHVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhEaHVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:21:18 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C81C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 00:19:38 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lz27so15149760ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 00:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cTcp9v8u4pMFG1SgPeYUwPp2woOjmcDKnMwfn2ea1TE=;
        b=E+CogGtmUBrMse+vR+hdRJEYcLZNYtX7rOHpETf7lwi/3ikt6SetSqfwE2EWA+JS57
         0ZPxGhM2gyVKOsIey9oR2rJOAOalp7+g+VNfhRdd98CVuPVAplaqNYp6vpaWhpRsMBdq
         61yUwOxR9lVTBRAIsxhmjCx3xnJwg3ckWPna7yRxDiO9wqtyp1jR4D6qs4f/ZqeOmXEN
         DyMlvfMxT1kqm3ATKvjnwInJRRzTXeKMCaKW8bt1i3FEz+U18XWweLM1FVv+2Dg9sBZI
         fCiGKaDDQMq9r2bHbT6he+tzhOJgjI+Q9SMISdX5d8FwZejnjCqnU+x9mXoYOKEcGLTE
         RzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cTcp9v8u4pMFG1SgPeYUwPp2woOjmcDKnMwfn2ea1TE=;
        b=cyKkAMWLOib+dk7HwOKnCIZEXSqeFEcQogObFza8Z0GXu0AzLcxMCkfF5SWmf9hxYd
         XR0L37z/KeA9CkRMigK3ZQMw+Bq4LKo3Ta1jQSVLda68qLgxtZZMIemd9DwtEfdlynmB
         Cn/bQaOjxcOgRA2dRD78eEJkMMyrGzXnp/VZgbuPzG4ESMC/PYI/vNV9KzDXmn+1Qmw1
         gw1UO5VNCj0etBJiIThhv/60xf2ko2yucNDrWwq0I6M8VvbWXjRnZNB+AgFZogqYNyip
         yd+ddfDqQASLJv3Fe0UJjt1rH94ePffXMjbVku0amFmD5v6q0HOYhJXfVUQCbGxJZ/nx
         37bA==
X-Gm-Message-State: AOAM533dLYdGIjX5Mln3zWJDfuuXobpivUgk193umCG6Ifprmc/WzxAx
        9luqqqFTHDedtbrsRhQcdK0R/O9WS1JAiKNfEsTY
X-Google-Smtp-Source: ABdhPJzxuVxYLZR8fmb00QX/IhpvMYe2uUVN01hloe1NQZYW+Z/O/3OA7EgTBkXyH5yIBWSRCxim1/RpUW5kLLC1GEY=
X-Received: by 2002:a17:906:3818:: with SMTP id v24mr13266181ejc.197.1622445577298;
 Mon, 31 May 2021 00:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210528121157.105-1-xieyongji@bytedance.com> <49ab3d41-c5d8-a49d-3ff4-28ebfdba0181@redhat.com>
In-Reply-To: <49ab3d41-c5d8-a49d-3ff4-28ebfdba0181@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 31 May 2021 15:19:26 +0800
Message-ID: <CACycT3uo-J3MYdEo0TscENewp3Xnjce8yFLtt6JkK8uZrvsMjg@mail.gmail.com>
Subject: Re: Re: [PATCH v3] virtio-net: Add validation for used length
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 2:49 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> =E5=9C=A8 2021/5/28 =E4=B8=8B=E5=8D=888:11, Xie Yongji =E5=86=99=E9=81=93=
:
> > This adds validation for used length (might come
> > from an untrusted device) to avoid data corruption
> > or loss.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >   drivers/net/virtio_net.c | 28 +++++++++++++++++++++-------
> >   1 file changed, 21 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 073fec4c0df1..01f15b65824c 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -732,6 +732,17 @@ static struct sk_buff *receive_small(struct net_de=
vice *dev,
> >
> >       rcu_read_lock();
> >       xdp_prog =3D rcu_dereference(rq->xdp_prog);
> > +     if (unlikely(len > GOOD_PACKET_LEN)) {
> > +             pr_debug("%s: rx error: len %u exceeds max size %d\n",
> > +                      dev->name, len, GOOD_PACKET_LEN);
> > +             dev->stats.rx_length_errors++;
> > +             if (xdp_prog)
> > +                     goto err_xdp;
> > +
> > +             rcu_read_unlock();
> > +             put_page(page);
> > +             return NULL;
> > +     }
> >       if (xdp_prog) {
> >               struct virtio_net_hdr_mrg_rxbuf *hdr =3D buf + header_off=
set;
> >               struct xdp_frame *xdpf;
> > @@ -888,6 +899,16 @@ static struct sk_buff *receive_mergeable(struct ne=
t_device *dev,
> >
> >       rcu_read_lock();
> >       xdp_prog =3D rcu_dereference(rq->xdp_prog);
> > +     if (unlikely(len > truesize)) {
> > +             pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
> > +                      dev->name, len, (unsigned long)ctx);
> > +             dev->stats.rx_length_errors++;
> > +             if (xdp_prog)
> > +                     goto err_xdp;
> > +
> > +             rcu_read_unlock();
> > +             goto err_skb;
> > +     }
>
>
> Patch looks correct but I'd rather not bother XDP here. It would be
> better if we just do the check before rcu_read_lock() and use err_skb
> directly() to avoid RCU/XDP stuffs.
>

If so, we will miss the statistics of xdp_drops. Is it OK?

Thanks,
Yongji
