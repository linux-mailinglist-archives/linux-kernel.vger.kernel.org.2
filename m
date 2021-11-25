Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748F145D606
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 09:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348481AbhKYIS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 03:18:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32746 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236936AbhKYIQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 03:16:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637828027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WZ+thzQkg6Cdn1OMX5Cx+TOEBd23whOs+wYTt44V+WM=;
        b=Rw2/7UVlYmLdhkryVC+dT3IFcE1dLkl5KW7+vj0iV01PpohHshknven4fJpbygGo472UHE
        48RQ9PYyl4KBmcT5I5F39dn0oQGFGFukqs9oB4JSd3GrNLxOPXPPKx5vEhwle1cdnOrr6T
        W8Sq1gIu6qZNvZ4JeEqY8YNh1Pbiwos=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244-sV3HQd7dMv-e6kS_pCK2IQ-1; Thu, 25 Nov 2021 03:13:44 -0500
X-MC-Unique: sV3HQd7dMv-e6kS_pCK2IQ-1
Received: by mail-ed1-f72.google.com with SMTP id a3-20020a05640213c300b003e7d12bb925so4806533edx.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 00:13:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WZ+thzQkg6Cdn1OMX5Cx+TOEBd23whOs+wYTt44V+WM=;
        b=MSFvCegOqqiHfaS2cH+u168ROhuc8OTgONNdWmBPuAMa++n2RoiQTz/1ZuxzIvQCwL
         oLBswcRPK8NuARVZ80sTH/T8EOEyBR3zpGzGoDaSr9abP2d8V7vuzqwS5cjKd+CRS35P
         0Qba2/VmU/mtHobHnsLipHzhEVAXV92B3i1Kz1rzPYfNmDFNcSvbaAI/qZrlndcqrm0C
         k2TbD6/OGPknUKNmo/PMtkX0vfKqS4cimEd/27G3ebffaM6Y98kOR/LshGIxStJkNcUj
         H/8ymI1ISQfzc0QhBnQCKQ8NsWFX3Z0VILFnhP9boLdHI1+4zxEVl5GD21V8I/Jap/5a
         zWYA==
X-Gm-Message-State: AOAM533zBRiW5H9RYsupAUqda8iLy1BMVDNFta57VJxkuaBs5sLLTM2L
        drN+zmZcZ/bh5y5OkbVBrkh/PNWQK6EySLjt7ngrgvgGkZgwykj7/r51et0mHPq2KWs9tXIzTnR
        MQ2ejoddkVs+vsKpPvV2P6Qkt
X-Received: by 2002:a17:906:168e:: with SMTP id s14mr28081282ejd.340.1637828022810;
        Thu, 25 Nov 2021 00:13:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYOQD+i+ueXJv8wQ2hIv3rDAUa4Ml4YdNJcnxE4uaDuCfWulSeHACHF8gzhftP0CtxspQTmg==
X-Received: by 2002:a17:906:168e:: with SMTP id s14mr28081261ejd.340.1637828022601;
        Thu, 25 Nov 2021 00:13:42 -0800 (PST)
Received: from redhat.com ([45.15.18.67])
        by smtp.gmail.com with ESMTPSA id d18sm1372141edj.23.2021.11.25.00.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 00:13:41 -0800 (PST)
Date:   Thu, 25 Nov 2021 03:13:35 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH net] virtio-net: enable big mode correctly
Message-ID: <20211125031107-mutt-send-email-mst@kernel.org>
References: <20211125060547.11961-1-jasowang@redhat.com>
 <20211125015532-mutt-send-email-mst@kernel.org>
 <CACGkMEv+hehZazXRG9mavv=KZ76XfCrkeNqB8CPOnkwRF9cdHA@mail.gmail.com>
 <20211125021308-mutt-send-email-mst@kernel.org>
 <CACGkMEscBZw+PjX2fP5yN03SDVYc12tsQLXL=woAXdYWnC2q9w@mail.gmail.com>
 <20211125022442-mutt-send-email-mst@kernel.org>
 <CACGkMEuos9tVSvrwXxTmh1v5WDYy9mpCagr+mrubY3bSCTBS2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEuos9tVSvrwXxTmh1v5WDYy9mpCagr+mrubY3bSCTBS2A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 03:28:31PM +0800, Jason Wang wrote:
> On Thu, Nov 25, 2021 at 3:26 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Nov 25, 2021 at 03:20:07PM +0800, Jason Wang wrote:
> > > On Thu, Nov 25, 2021 at 3:15 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Thu, Nov 25, 2021 at 03:11:58PM +0800, Jason Wang wrote:
> > > > > On Thu, Nov 25, 2021 at 3:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Nov 25, 2021 at 02:05:47PM +0800, Jason Wang wrote:
> > > > > > > When VIRTIO_NET_F_MTU feature is not negotiated, we assume a very
> > > > > > > large max_mtu. In this case, using small packet mode is not correct
> > > > > > > since it may breaks the networking when MTU is grater than
> > > > > > > ETH_DATA_LEN.
> > > > > > >
> > > > > > > To have a quick fix, simply enable the big packet mode when
> > > > > > > VIRTIO_NET_F_MTU is not negotiated.
> > > > > >
> > > > > > This will slow down dpdk hosts which disable mergeable buffers
> > > > > > and send standard MTU sized packets.
> > > > > >
> > > > > > > We can do optimization on top.
> > > > > >
> > > > > > I don't think it works like this, increasing mtu
> > > > > > from guest >4k never worked,
> > > > >
> > > > > Looking at add_recvbuf_small() it's actually GOOD_PACKET_LEN if I was not wrong.
> > > >
> > > > OK, even more so then.
> > > >
> > > > > > we can't regress everyone's
> > > > > > performance with a promise to maybe sometime bring it back.
> > > > >
> > > > > So consider it never work before I wonder if we can assume a 1500 as
> > > > > max_mtu value instead of simply using MAX_MTU?
> > > > >
> > > > > Thanks
> > > >
> > > > You want to block guests from setting MTU to a value >GOOD_PACKET_LEN?
> > >
> > > Yes, or fix the issue to let large packets on RX work (e.g as the TODO
> > > said, size the buffer: for <=4K mtu continue to work as
> > > add_recvbuf_small(), for >= 4K switch to use big).
> >
> > Right. The difficulty is with changing modes, current code isn't
> > designed for it.
> 
> I think it might work if we reset the device during the mode change.
> 
> Thanks

For sure. It's hard to do without races though, and we need to
carefully restore all the programming done so far.
Maybe it will be easier if we do something like disable_irq
to reliably suppress interrupts from hardware.

> >
> > > > Maybe ... it will prevent sending large packets which did work ...
> > >
> > > Yes, but it's strange to allow TX but not RX
> > >
> > > > I'd tread carefully here, and I don't think this kind of thing is net
> > > > material.
> > >
> > > I agree consider it can't be fixed easily.
> > >
> > > Thanks
> > >
> > > >
> > > > > >
> > > > > > > Reported-by: Eli Cohen <elic@nvidia.com>
> > > > > > > Cc: Eli Cohen <elic@nvidia.com>
> > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > >
> > > > > > > ---
> > > > > > >  drivers/net/virtio_net.c | 7 ++++---
> > > > > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > > index 7c43bfc1ce44..83ae3ef5eb11 100644
> > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > @@ -3200,11 +3200,12 @@ static int virtnet_probe(struct virtio_device *vdev)
> > > > > > >               dev->mtu = mtu;
> > > > > > >               dev->max_mtu = mtu;
> > > > > > >
> > > > > > > -             /* TODO: size buffers correctly in this case. */
> > > > > > > -             if (dev->mtu > ETH_DATA_LEN)
> > > > > > > -                     vi->big_packets = true;
> > > > > > >       }
> > > > > > >
> > > > > > > +     /* TODO: size buffers correctly in this case. */
> > > > > > > +     if (dev->max_mtu > ETH_DATA_LEN)
> > > > > > > +             vi->big_packets = true;
> > > > > > > +
> > > > > > >       if (vi->any_header_sg)
> > > > > > >               dev->needed_headroom = vi->hdr_len;
> > > > > > >
> > > > > > > --
> > > > > > > 2.25.1
> > > > > >
> > > >
> >

