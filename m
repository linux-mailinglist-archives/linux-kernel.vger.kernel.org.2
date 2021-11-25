Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933F045D571
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 08:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbhKYHbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 02:31:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24037 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229971AbhKYH3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 02:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637825196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qcQBaxPrWoK+s8IJkbSpQ1TtEOZWtV7cWrhtg/atf2k=;
        b=WryuN92IzcFggkBFXdFroOHflbAd18p0CNN0uq4bIZS1QFrP+PvNmfZIph1kt+Ix+ke+wt
        hVM76/6HH9OEWZhXf05XCk2do5JdKSQxwYn7C3ck7RH5BBPt0ICRtdktgdoJErOIdd33ku
        LKvBsAMqSyzumHvi9jZ5kt38ll3gHQ8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-71-tiH_Nu0FPwyf2-lJV-Amxg-1; Thu, 25 Nov 2021 02:26:35 -0500
X-MC-Unique: tiH_Nu0FPwyf2-lJV-Amxg-1
Received: by mail-lj1-f199.google.com with SMTP id k24-20020a2e9a58000000b00218c7914524so1578237ljj.17
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 23:26:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qcQBaxPrWoK+s8IJkbSpQ1TtEOZWtV7cWrhtg/atf2k=;
        b=wmd5Hpt9a3ufEXS9/FWk/4/7Hd0i296LAQDXlqVHIDTAfX91c8BpW6TiGFu00D1FYU
         GSjAjxvx2HAhFNhPf2e2ToD+NE9zwjAC071bhFJ6cPGL0FDt36JomCXJqjJlvtKlfUAz
         BklyHszGNVOoE9YXw3z3nMf+axX6zLSxLiCEyU2PYN4iyp+HA+UvTdkVq1Xjjv9FGSf8
         ZJLrS3sj2egt98jJQPZd2tiirh9LrwnuhVzXdExD2GcSEc3MyhfF555jITIBzG+R1uKL
         VUnZR1fSO7RHyMMeZQhwTrx1NW8wQKQnealfgBiXqO6l+LcPqCDB/8FtbZdkU5fDX29D
         KfpQ==
X-Gm-Message-State: AOAM531IyB1egB79QS1zbRR5Si7UYUFHzWJ75UoPs6ZyinR/5nG0ovUl
        vAby2Qwpz5iPIv9zV6M4qtCZZukAa4ih/onkVB1xh5NqKBbBw5GUicFa1rnfvGITsE5d//gPyRW
        gfhmREkSD3ZgyqpIdlSJbrIvmFMvPOHTDer83Flyi
X-Received: by 2002:ac2:518b:: with SMTP id u11mr21748978lfi.498.1637825193840;
        Wed, 24 Nov 2021 23:26:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzNyYx1OYUVPgYpWOwMuorz+qrA1sL59W2uyRoPP3zmJkmu6y4BVf7Hf9NYZ/Zi5jWVVN818TqMHNpEnVm7VRk=
X-Received: by 2002:ac2:518b:: with SMTP id u11mr21748967lfi.498.1637825193649;
 Wed, 24 Nov 2021 23:26:33 -0800 (PST)
MIME-Version: 1.0
References: <20211125060547.11961-1-jasowang@redhat.com> <20211125070939.GC211101@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEsNsQ_XWTvdjaCEdo8sYaLew24zU1UUCJrokM-Koxj4fw@mail.gmail.com> <20211125072040.GA213301@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20211125072040.GA213301@mtl-vdi-166.wap.labs.mlnx>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 25 Nov 2021 15:26:22 +0800
Message-ID: <CACGkMEuYWoL4x5o_OO2a27X4Ah8Y2ggBjy0XFHe3Onmj4RhFFg@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: enable big mode correctly
To:     Eli Cohen <elic@nvidia.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 3:20 PM Eli Cohen <elic@nvidia.com> wrote:
>
> On Thu, Nov 25, 2021 at 03:15:33PM +0800, Jason Wang wrote:
> > On Thu, Nov 25, 2021 at 3:09 PM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > > On Thu, Nov 25, 2021 at 02:05:47PM +0800, Jason Wang wrote:
> > > > When VIRTIO_NET_F_MTU feature is not negotiated, we assume a very
> > > > large max_mtu. In this case, using small packet mode is not correct
> > > > since it may breaks the networking when MTU is grater than
> > > > ETH_DATA_LEN.
> > > >
> > > > To have a quick fix, simply enable the big packet mode when
> > > > VIRTIO_NET_F_MTU is not negotiated. We can do optimization on top.
> > > >
> > > > Reported-by: Eli Cohen <elic@nvidia.com>
> > > > Cc: Eli Cohen <elic@nvidia.com>
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > >  drivers/net/virtio_net.c | 7 ++++---
> > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 7c43bfc1ce44..83ae3ef5eb11 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -3200,11 +3200,12 @@ static int virtnet_probe(struct virtio_device *vdev)
> > > >               dev->mtu = mtu;
> > > >               dev->max_mtu = mtu;
> > > >
> > > > -             /* TODO: size buffers correctly in this case. */
> > > > -             if (dev->mtu > ETH_DATA_LEN)
> > > > -                     vi->big_packets = true;
> > > >       }
> > > >
> > > > +     /* TODO: size buffers correctly in this case. */
> > > > +     if (dev->max_mtu > ETH_DATA_LEN)
> > > > +             vi->big_packets = true;
> > > > +
> > >
> > > If VIRTIO_NET_F_MTU is provided, then dev->max_mtu is going to equal
> > > ETH_DATA_LEN (will be set in ether_setup()) so I don't think it will set
> > > big_packets to true.
> >
> > I may miss something, the dev->max_mtu is just assigned to the mtu
> > value read from the config space in the code block above  (inside the
> > feature check of VIRTIO_NET_F_MTU).
>
> Sorry, I meant "If VIRTIO_NET_F_MTU is ***NOT*** provided". In that case
> dev->max_mtu eauals ETH_DATA_LEN so you won't set vi->big_packets to
> true.

I see but in this case, the above assignment:

        /* MTU range: 68 - 65535 */
        dev->min_mtu = MIN_MTU;
        dev->max_mtu = MAX_MTU;

happens after alloc_etherdev_mq() which calls ether_setup(), so we are
probably fine here.

Thanks

>
> >
> > Thanks
> >
> > >
> > >
> > > >       if (vi->any_header_sg)
> > > >               dev->needed_headroom = vi->hdr_len;
> > > >
> > > > --
> > > > 2.25.1
> > > >
> > >
> >
>

