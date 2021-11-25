Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EF945D579
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 08:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbhKYHd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 02:33:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41112 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235352AbhKYHb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 02:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637825326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KAYyix8FJ3fNIZWmvJGEU4BGlkJhgJqUuDlAboJ19Kw=;
        b=cjGAQ7X3lJTjnQMAMPPC0uMAVZk9Oeh0Lw3QfRNXywxgyLksNtXIrNz+Y4NQ/Nvhp5zbMg
        /yED+1ea/d8oS6aJE04vAHITpK/0iyFivmHd2RXRWJ5CP7jcmV1PH4RRlkAnAPHDv3BpH/
        kVdEil/4JkG6ETnqCm6gRUPpakwtsds=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-w-U1ysq3PhSncByxcmVWMw-1; Thu, 25 Nov 2021 02:28:44 -0500
X-MC-Unique: w-U1ysq3PhSncByxcmVWMw-1
Received: by mail-lf1-f71.google.com with SMTP id h40-20020a0565123ca800b00402514d959fso2791088lfv.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 23:28:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KAYyix8FJ3fNIZWmvJGEU4BGlkJhgJqUuDlAboJ19Kw=;
        b=EZktB2X1UbmJUsL6zx84h+PvgiO5EX5aunlbSFFCRjA8qwvC6s5tPwQj2b+6XWGn5q
         9/YwueU6Fptqc194Eib+NlGvK0jwyl6VJQNloZ9UK6w2pU/X+WUbignn5o1b31BV1TP/
         BXPA9REIUEoR8wmkLXQIVbtwDoDVZ7RMHk+GzPpyEQb9C6NtkwFQJCaShur2gZ51lmnv
         yJLlQZuwn2KfPby8bDPPtjwtBAPSr/Q4bK4OPRjgCGBnhOS4rGYdGtxRqiwY/Oeom7Ju
         qCjLAi6NYTlDLbgJ4sBjq/Ym4U3WMjhZ7JhtfpSpeYqrlQmgd8uA5Z/6fj600EXBcsxC
         mHzQ==
X-Gm-Message-State: AOAM533WvTWgR8KChLsRUIhQ2aQsiaZLKKlhWJ3aBz9cMafXqmC8mER/
        12F7+HauICl6IzPGPwoGFlnX75nSCGymREOVgQosXH3eX5jLcbjNjhU2L+97K7jQpG9C8nezx+K
        05H9Cs1hW+jedC+SwM1aI86Hm1qS0JgU4gaNpA3w/
X-Received: by 2002:ac2:5310:: with SMTP id c16mr22375077lfh.580.1637825323077;
        Wed, 24 Nov 2021 23:28:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwR0Oj+HYVWJiKnMqDcsVDTqq/srl4I6uPRZ9iNPuv2p0Bkt1dEPXaslgNkp/hh9kpZ3ybmiGxzpKXdjayduxU=
X-Received: by 2002:ac2:5310:: with SMTP id c16mr22375068lfh.580.1637825322885;
 Wed, 24 Nov 2021 23:28:42 -0800 (PST)
MIME-Version: 1.0
References: <20211125060547.11961-1-jasowang@redhat.com> <20211125015532-mutt-send-email-mst@kernel.org>
 <CACGkMEv+hehZazXRG9mavv=KZ76XfCrkeNqB8CPOnkwRF9cdHA@mail.gmail.com>
 <20211125021308-mutt-send-email-mst@kernel.org> <CACGkMEscBZw+PjX2fP5yN03SDVYc12tsQLXL=woAXdYWnC2q9w@mail.gmail.com>
 <20211125022442-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211125022442-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 25 Nov 2021 15:28:31 +0800
Message-ID: <CACGkMEuos9tVSvrwXxTmh1v5WDYy9mpCagr+mrubY3bSCTBS2A@mail.gmail.com>
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

On Thu, Nov 25, 2021 at 3:26 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Nov 25, 2021 at 03:20:07PM +0800, Jason Wang wrote:
> > On Thu, Nov 25, 2021 at 3:15 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Thu, Nov 25, 2021 at 03:11:58PM +0800, Jason Wang wrote:
> > > > On Thu, Nov 25, 2021 at 3:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Thu, Nov 25, 2021 at 02:05:47PM +0800, Jason Wang wrote:
> > > > > > When VIRTIO_NET_F_MTU feature is not negotiated, we assume a very
> > > > > > large max_mtu. In this case, using small packet mode is not correct
> > > > > > since it may breaks the networking when MTU is grater than
> > > > > > ETH_DATA_LEN.
> > > > > >
> > > > > > To have a quick fix, simply enable the big packet mode when
> > > > > > VIRTIO_NET_F_MTU is not negotiated.
> > > > >
> > > > > This will slow down dpdk hosts which disable mergeable buffers
> > > > > and send standard MTU sized packets.
> > > > >
> > > > > > We can do optimization on top.
> > > > >
> > > > > I don't think it works like this, increasing mtu
> > > > > from guest >4k never worked,
> > > >
> > > > Looking at add_recvbuf_small() it's actually GOOD_PACKET_LEN if I was not wrong.
> > >
> > > OK, even more so then.
> > >
> > > > > we can't regress everyone's
> > > > > performance with a promise to maybe sometime bring it back.
> > > >
> > > > So consider it never work before I wonder if we can assume a 1500 as
> > > > max_mtu value instead of simply using MAX_MTU?
> > > >
> > > > Thanks
> > >
> > > You want to block guests from setting MTU to a value >GOOD_PACKET_LEN?
> >
> > Yes, or fix the issue to let large packets on RX work (e.g as the TODO
> > said, size the buffer: for <=4K mtu continue to work as
> > add_recvbuf_small(), for >= 4K switch to use big).
>
> Right. The difficulty is with changing modes, current code isn't
> designed for it.

I think it might work if we reset the device during the mode change.

Thanks

>
> > > Maybe ... it will prevent sending large packets which did work ...
> >
> > Yes, but it's strange to allow TX but not RX
> >
> > > I'd tread carefully here, and I don't think this kind of thing is net
> > > material.
> >
> > I agree consider it can't be fixed easily.
> >
> > Thanks
> >
> > >
> > > > >
> > > > > > Reported-by: Eli Cohen <elic@nvidia.com>
> > > > > > Cc: Eli Cohen <elic@nvidia.com>
> > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > >
> > > > > > ---
> > > > > >  drivers/net/virtio_net.c | 7 ++++---
> > > > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > index 7c43bfc1ce44..83ae3ef5eb11 100644
> > > > > > --- a/drivers/net/virtio_net.c
> > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > @@ -3200,11 +3200,12 @@ static int virtnet_probe(struct virtio_device *vdev)
> > > > > >               dev->mtu = mtu;
> > > > > >               dev->max_mtu = mtu;
> > > > > >
> > > > > > -             /* TODO: size buffers correctly in this case. */
> > > > > > -             if (dev->mtu > ETH_DATA_LEN)
> > > > > > -                     vi->big_packets = true;
> > > > > >       }
> > > > > >
> > > > > > +     /* TODO: size buffers correctly in this case. */
> > > > > > +     if (dev->max_mtu > ETH_DATA_LEN)
> > > > > > +             vi->big_packets = true;
> > > > > > +
> > > > > >       if (vi->any_header_sg)
> > > > > >               dev->needed_headroom = vi->hdr_len;
> > > > > >
> > > > > > --
> > > > > > 2.25.1
> > > > >
> > >
>

