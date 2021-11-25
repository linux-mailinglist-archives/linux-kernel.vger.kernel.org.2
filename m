Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4954545D54B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 08:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238800AbhKYHUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 02:20:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23451 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349234AbhKYHSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 02:18:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637824511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DrdfoJuoyuNHgO43HGDwB7KWOWfQOVP7BNUczbuAPp8=;
        b=Csn6QAYanCT42bmVAwdUJmnnmPcCqfb4/x+R8tiF+ct0GfPqtVLv0XtuDxoYxp8rUj21pU
        poP3aW5oOuPnuuwye9Ozd9ng6z2IeeJQSx35kBfD2gCUf235rYuPzBsC1T0jr6nVdK9dfQ
        qs2eRx6Wpl95dhyOJcLtQJpf8M98nlU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-7cCigxkkP8mv1C3F3C2_TQ-1; Thu, 25 Nov 2021 02:15:10 -0500
X-MC-Unique: 7cCigxkkP8mv1C3F3C2_TQ-1
Received: by mail-ed1-f72.google.com with SMTP id v22-20020a50a456000000b003e7cbfe3dfeso4632478edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 23:15:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DrdfoJuoyuNHgO43HGDwB7KWOWfQOVP7BNUczbuAPp8=;
        b=fiBi2/ISfuHIUuY6AnTmzkemDl7xbMk/Za2moGwsDOfPJJU6MDyvyq7SpILqA4Jur/
         wAHfS4UIJ/jFPSeQNWlE3WpRBBcb3Qy17ulAJ7ZPo2nDH5a+KlQSrhtg56oquuosSOfC
         5hYIHx3lLQkVaryQotkJTpJl9JeLNq90Hjj+nAs/NQetxEwrL2S1YWbYo2SG9Pwtm9Vn
         S0uv7uQJ/ir0IEMc8Es/jKXkF197YbfR6X7XJs87k8sX9lMy28q6PPvOylmqPL6IiOTa
         3kDnavlGaMGhjCKF7Cmu4JlV6Lak5G3LcO1q4GMTo7U3Y2ku5q0Lb1Jf38aH1LsgpkI8
         o03g==
X-Gm-Message-State: AOAM531ySlZfQTDFCcQsr21EkAxNQU6I5vdykjNc1IZ5IJEsXp4foorq
        5DZBNpUR+x3AKu7jGNYlaFR1TcIeo8+AIzGsi1t8wnBi5ZAR+uvZGgZJCMcW8roFZHDznZ/m8W+
        aN0qdku1PK0z4ZS6y//qFIY4r
X-Received: by 2002:a05:6402:3496:: with SMTP id v22mr34843222edc.177.1637824508931;
        Wed, 24 Nov 2021 23:15:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzT4Ux6nJrzHTTYycQkkUo3yCguo+1d6EF1/y5nPdIGUEaoov9qqpPkw+eeVpNdKNDvLUtBeA==
X-Received: by 2002:a05:6402:3496:: with SMTP id v22mr34843190edc.177.1637824508772;
        Wed, 24 Nov 2021 23:15:08 -0800 (PST)
Received: from redhat.com ([45.15.18.67])
        by smtp.gmail.com with ESMTPSA id m15sm1281606edl.22.2021.11.24.23.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 23:14:55 -0800 (PST)
Date:   Thu, 25 Nov 2021 02:14:48 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH net] virtio-net: enable big mode correctly
Message-ID: <20211125021308-mutt-send-email-mst@kernel.org>
References: <20211125060547.11961-1-jasowang@redhat.com>
 <20211125015532-mutt-send-email-mst@kernel.org>
 <CACGkMEv+hehZazXRG9mavv=KZ76XfCrkeNqB8CPOnkwRF9cdHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEv+hehZazXRG9mavv=KZ76XfCrkeNqB8CPOnkwRF9cdHA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 03:11:58PM +0800, Jason Wang wrote:
> On Thu, Nov 25, 2021 at 3:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Nov 25, 2021 at 02:05:47PM +0800, Jason Wang wrote:
> > > When VIRTIO_NET_F_MTU feature is not negotiated, we assume a very
> > > large max_mtu. In this case, using small packet mode is not correct
> > > since it may breaks the networking when MTU is grater than
> > > ETH_DATA_LEN.
> > >
> > > To have a quick fix, simply enable the big packet mode when
> > > VIRTIO_NET_F_MTU is not negotiated.
> >
> > This will slow down dpdk hosts which disable mergeable buffers
> > and send standard MTU sized packets.
> >
> > > We can do optimization on top.
> >
> > I don't think it works like this, increasing mtu
> > from guest >4k never worked,
> 
> Looking at add_recvbuf_small() it's actually GOOD_PACKET_LEN if I was not wrong.

OK, even more so then.

> > we can't regress everyone's
> > performance with a promise to maybe sometime bring it back.
> 
> So consider it never work before I wonder if we can assume a 1500 as
> max_mtu value instead of simply using MAX_MTU?
> 
> Thanks

You want to block guests from setting MTU to a value >GOOD_PACKET_LEN?
Maybe ... it will prevent sending large packets which did work ...
I'd tread carefully here, and I don't think this kind of thing is net
material.

> >
> > > Reported-by: Eli Cohen <elic@nvidia.com>
> > > Cc: Eli Cohen <elic@nvidia.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > >
> > > ---
> > >  drivers/net/virtio_net.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 7c43bfc1ce44..83ae3ef5eb11 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -3200,11 +3200,12 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >               dev->mtu = mtu;
> > >               dev->max_mtu = mtu;
> > >
> > > -             /* TODO: size buffers correctly in this case. */
> > > -             if (dev->mtu > ETH_DATA_LEN)
> > > -                     vi->big_packets = true;
> > >       }
> > >
> > > +     /* TODO: size buffers correctly in this case. */
> > > +     if (dev->max_mtu > ETH_DATA_LEN)
> > > +             vi->big_packets = true;
> > > +
> > >       if (vi->any_header_sg)
> > >               dev->needed_headroom = vi->hdr_len;
> > >
> > > --
> > > 2.25.1
> >

