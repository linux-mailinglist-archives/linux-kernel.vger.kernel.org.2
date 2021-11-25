Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745E645D53C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 08:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351260AbhKYHRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 02:17:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353354AbhKYHPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 02:15:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637824332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nC8TAYilw4eO6qk6TmC4Zgxkm1cFgxZk3ttBumo2rHs=;
        b=S3MGCFb6U4mxvisdvaGyiI9kFg2FK9OSMERFeCbmEwAxR3HdsQ3XLjoeCI8nkwsjyQCWFD
        ZeQIovvyYygUlI0y32fnQLgJTlVYuwXF4HPVz2bsq1F5JCf1o3vmvacpASqfFrkbMl4ids
        yfsKnUhbS0GZyKhQH+uOEFw6qo11r8g=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-JYa33bVhOBiSYLOxBt0d1A-1; Thu, 25 Nov 2021 02:12:10 -0500
X-MC-Unique: JYa33bVhOBiSYLOxBt0d1A-1
Received: by mail-lj1-f198.google.com with SMTP id u28-20020a2ea17c000000b0021126b5cca2so1557961ljl.19
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 23:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nC8TAYilw4eO6qk6TmC4Zgxkm1cFgxZk3ttBumo2rHs=;
        b=AN0/p5AYedskPpWvNtJCqdS0xFZ3sS8JDh8BNjkUk+athtUc4y7hK4H/CSwNw1T25z
         sKHDfvbEh9ZVRQFKwnltpU2+KMfeBOjz7qZRRqE3qQ/mpefumF7Mg01e+n29ghO2xHFY
         1C98OH5Wei4MHNBF4sErKvhA+6DNcaz5EXfIw0OKjUDHMNrQPvViYvBDqvqwx+sz7ybf
         Nb5P6chU6ff5JutYhi4IeG7IThaWtjsueCpiDQ4f0sq7YFycF8/f2c+QaUZM1jfHJFar
         pWKMwMqf0FW/eKLS753v8RQEYKWsfrUoomwVAp2t7fWymCvWPi2Ctt5gnMxDgzPN7dW7
         H/Pw==
X-Gm-Message-State: AOAM531QrkIaRUUAoGSIEzmcsA+3zJafzi5UmyaaA8wmj6m14kx5FZPq
        ke1it+y1LxGYc5kGTDiW/1GgeESOhq6XjH/meFZt1nAlYcSoq6Hpq7CtFUKnK9KJloR8r3bsRZJ
        RylHCH0NF37gbyQhS9V5P71WEot1s5+6nhD5fx92p
X-Received: by 2002:a2e:915a:: with SMTP id q26mr22426552ljg.277.1637824329433;
        Wed, 24 Nov 2021 23:12:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxeFz9HHABX6i5h6gRcn7nboD1zkLDLVn4pgHX8pSwTiW54CFKdWcSQ/ukSK+/hSpgPW0KT1r7HGC5agHABEKc=
X-Received: by 2002:a2e:915a:: with SMTP id q26mr22426527ljg.277.1637824329157;
 Wed, 24 Nov 2021 23:12:09 -0800 (PST)
MIME-Version: 1.0
References: <20211125060547.11961-1-jasowang@redhat.com> <20211125015532-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211125015532-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 25 Nov 2021 15:11:58 +0800
Message-ID: <CACGkMEv+hehZazXRG9mavv=KZ76XfCrkeNqB8CPOnkwRF9cdHA@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: enable big mode correctly
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eli Cohen <elic@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 3:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Nov 25, 2021 at 02:05:47PM +0800, Jason Wang wrote:
> > When VIRTIO_NET_F_MTU feature is not negotiated, we assume a very
> > large max_mtu. In this case, using small packet mode is not correct
> > since it may breaks the networking when MTU is grater than
> > ETH_DATA_LEN.
> >
> > To have a quick fix, simply enable the big packet mode when
> > VIRTIO_NET_F_MTU is not negotiated.
>
> This will slow down dpdk hosts which disable mergeable buffers
> and send standard MTU sized packets.
>
> > We can do optimization on top.
>
> I don't think it works like this, increasing mtu
> from guest >4k never worked,

Looking at add_recvbuf_small() it's actually GOOD_PACKET_LEN if I was not wrong.

> we can't regress everyone's
> performance with a promise to maybe sometime bring it back.

So consider it never work before I wonder if we can assume a 1500 as
max_mtu value instead of simply using MAX_MTU?

Thanks

>
> > Reported-by: Eli Cohen <elic@nvidia.com>
> > Cc: Eli Cohen <elic@nvidia.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> > ---
> >  drivers/net/virtio_net.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 7c43bfc1ce44..83ae3ef5eb11 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3200,11 +3200,12 @@ static int virtnet_probe(struct virtio_device *vdev)
> >               dev->mtu = mtu;
> >               dev->max_mtu = mtu;
> >
> > -             /* TODO: size buffers correctly in this case. */
> > -             if (dev->mtu > ETH_DATA_LEN)
> > -                     vi->big_packets = true;
> >       }
> >
> > +     /* TODO: size buffers correctly in this case. */
> > +     if (dev->max_mtu > ETH_DATA_LEN)
> > +             vi->big_packets = true;
> > +
> >       if (vi->any_header_sg)
> >               dev->needed_headroom = vi->hdr_len;
> >
> > --
> > 2.25.1
>

