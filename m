Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82DF845D55A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 08:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbhKYHZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 02:25:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28975 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229894AbhKYHXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 02:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637824823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0288K9+4rtmWXrgpEnbVI8eRZ9+61SJ6uREF4cND0rE=;
        b=QXRksKMM2q9AxV5yeR8ZtsIe4bWKKGDFcqu2CiodyWOUi2JuUDoH72zQhSVTA8GM2+Qbp/
        JzeVFbLR+xhVxi8bgTIqqosfj97DMZ+5FP9LKuzsWXOofsrVI3wB5n3sv1ytdu06Ed00AP
        3UC31SQLOGCXfJITkNnO9Mr0tZuC0zI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-334-iGV4EIwxPw6eaNx60P56jA-1; Thu, 25 Nov 2021 02:20:20 -0500
X-MC-Unique: iGV4EIwxPw6eaNx60P56jA-1
Received: by mail-lf1-f69.google.com with SMTP id bi30-20020a0565120e9e00b00415d0e471e0so2745396lfb.19
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 23:20:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0288K9+4rtmWXrgpEnbVI8eRZ9+61SJ6uREF4cND0rE=;
        b=wzn0/Hqrj8yxAEVH2WJi2c680kQBH/3QBOZgWxnFbK6RNumFnFxxRtzzK0MrnhDXCU
         k0qGZLOUr83eEi5gaNlfo3SutXA/JomHcc59vn9EVWtoJz9x89D+S54j2YJ0is2xyR9X
         b/hM7ZSTeXBOjbLZUVI+HsIqS1qDP/i5zeUurp9IJUyfJU+EEm4GmagSbV9hgh1GQIf8
         cysifFfraqj5aD2soumpaKazbr9LiAuB3SQdd0XXTJbV2qD5aYaG/C/7Cz6pIABxt/g+
         XrlzL2r/Y1qeOxWmgmZxVF1L/FzFyflewy7VF0S/wLcSLAqfD+zGPXlp9fF5V7gYoBep
         Gy6g==
X-Gm-Message-State: AOAM531phb0DTqYsIGujrowM5qsLQ9YCfc0UDmf5DF+tpcYSk1bqfpGX
        Tg0lFEQ+DB1GMkWsX4/6uzOkukB9NZQWcR8hrO08Z41RfNNU6zfIBGG7/tQ0MyyrS71bBCXALYZ
        tVWarPlrait3NiQoG9OXie02wIWC9y755ftykPxJk
X-Received: by 2002:a2e:915a:: with SMTP id q26mr22460228ljg.277.1637824818462;
        Wed, 24 Nov 2021 23:20:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzAc9aUOa9FeX5ZE296oiarTKJZL/BX1S6IHbR96hL/NWmFeWIrJHNjgfGJIWjO7GYJFqI2Mgg4l7eT+hT8wmY=
X-Received: by 2002:a2e:915a:: with SMTP id q26mr22460215ljg.277.1637824818275;
 Wed, 24 Nov 2021 23:20:18 -0800 (PST)
MIME-Version: 1.0
References: <20211125060547.11961-1-jasowang@redhat.com> <20211125015532-mutt-send-email-mst@kernel.org>
 <CACGkMEv+hehZazXRG9mavv=KZ76XfCrkeNqB8CPOnkwRF9cdHA@mail.gmail.com> <20211125021308-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211125021308-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 25 Nov 2021 15:20:07 +0800
Message-ID: <CACGkMEscBZw+PjX2fP5yN03SDVYc12tsQLXL=woAXdYWnC2q9w@mail.gmail.com>
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

On Thu, Nov 25, 2021 at 3:15 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Nov 25, 2021 at 03:11:58PM +0800, Jason Wang wrote:
> > On Thu, Nov 25, 2021 at 3:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Thu, Nov 25, 2021 at 02:05:47PM +0800, Jason Wang wrote:
> > > > When VIRTIO_NET_F_MTU feature is not negotiated, we assume a very
> > > > large max_mtu. In this case, using small packet mode is not correct
> > > > since it may breaks the networking when MTU is grater than
> > > > ETH_DATA_LEN.
> > > >
> > > > To have a quick fix, simply enable the big packet mode when
> > > > VIRTIO_NET_F_MTU is not negotiated.
> > >
> > > This will slow down dpdk hosts which disable mergeable buffers
> > > and send standard MTU sized packets.
> > >
> > > > We can do optimization on top.
> > >
> > > I don't think it works like this, increasing mtu
> > > from guest >4k never worked,
> >
> > Looking at add_recvbuf_small() it's actually GOOD_PACKET_LEN if I was not wrong.
>
> OK, even more so then.
>
> > > we can't regress everyone's
> > > performance with a promise to maybe sometime bring it back.
> >
> > So consider it never work before I wonder if we can assume a 1500 as
> > max_mtu value instead of simply using MAX_MTU?
> >
> > Thanks
>
> You want to block guests from setting MTU to a value >GOOD_PACKET_LEN?

Yes, or fix the issue to let large packets on RX work (e.g as the TODO
said, size the buffer: for <=4K mtu continue to work as
add_recvbuf_small(), for >= 4K switch to use big).

> Maybe ... it will prevent sending large packets which did work ...

Yes, but it's strange to allow TX but not RX

> I'd tread carefully here, and I don't think this kind of thing is net
> material.

I agree consider it can't be fixed easily.

Thanks

>
> > >
> > > > Reported-by: Eli Cohen <elic@nvidia.com>
> > > > Cc: Eli Cohen <elic@nvidia.com>
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > >
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
> > > >       if (vi->any_header_sg)
> > > >               dev->needed_headroom = vi->hdr_len;
> > > >
> > > > --
> > > > 2.25.1
> > >
>

