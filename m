Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DE235E1A5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343918AbhDMOes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:34:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21046 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344055AbhDMOeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618324427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=03mb4LEKGQSjGCDEyQg3KiQjDam/TziPkhfoQlj9YcM=;
        b=ZcYqa3RkRr8HfEe4RvDP8OMRFx4oc+9QNYMAra7ooocYFFSZx0Tkn4S8jOW+lBDsDJ5P0K
        2dmaPC5RDo8J7RDmg5aIWc33WM6tYSu6c+f11Tyc3jQvhsYAZlAh0FqXVgZZIcUEt3BdEJ
        tITHuA2xdRTVlh7P0ZEcqYviHT4n1OU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-EcdK6WKmMJyPYS7MA7YWfQ-1; Tue, 13 Apr 2021 10:33:42 -0400
X-MC-Unique: EcdK6WKmMJyPYS7MA7YWfQ-1
Received: by mail-wm1-f69.google.com with SMTP id f18-20020a05600c4e92b029010c82246f12so3099097wmq.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=03mb4LEKGQSjGCDEyQg3KiQjDam/TziPkhfoQlj9YcM=;
        b=Ffkhqr8RkXMGLIxfCFAgFEqcqfSn2JTJBMxil+IuUZ3dZXgImzffk0RrSoG0hMyoLh
         StKgKrQZc9kMR/WPeaT2OiwTGOPawxdmWp7oafnXhbS8ozXSr5O4pch2KAJTulDc/U13
         V/sFTFDbZGxn9gwkCn5ABPc/hMnYRwwEp+WCqNcGrNFZNFQQruMqF/heOFOB77/ijiNa
         OIFY0jI+FpgxlqLIrhJyzYUI78pL3+n3C7rpbTRZydKf7du+/lpgVzvE0wsOdQVmDO69
         pcCmSu6ObVIhTtaF2fXHYjhIuABv7xTmXpzorYkiJ29xQdwRMOZ4/dz/uAXbM9SXQv+d
         xRUg==
X-Gm-Message-State: AOAM533o75gEwqUN48o+oBMxu5JKgXj+T43vwcKXI/LdDUll2yZOCUH0
        3Bu3Layn4uEMImOPYExPAUEWZ56BX7CSTlXSl6jxdKv0KfCuNN9LncupIk5p44juk6E8u4u6gjz
        MiX/qgz574GcE3USzMqqSpdoo
X-Received: by 2002:a1c:f715:: with SMTP id v21mr282043wmh.187.1618324421410;
        Tue, 13 Apr 2021 07:33:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTe7rBlLKqCoWn++/O8Aw6yKwfkrflupGRE+nGP0iUf29tGd26k1V89INwAeu3NGikNplrxg==
X-Received: by 2002:a1c:f715:: with SMTP id v21mr282029wmh.187.1618324421247;
        Tue, 13 Apr 2021 07:33:41 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
        by smtp.gmail.com with ESMTPSA id c6sm19518494wri.32.2021.04.13.07.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:33:40 -0700 (PDT)
Date:   Tue, 13 Apr 2021 10:33:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Wei Wang <weiwan@google.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH RFC v2 2/4] virtio_net: disable cb aggressively
Message-ID: <20210413100314-mutt-send-email-mst@kernel.org>
References: <20210413054733.36363-1-mst@redhat.com>
 <20210413054733.36363-3-mst@redhat.com>
 <43db5c1e-9908-55bb-6d1a-c6c8d71e2315@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43db5c1e-9908-55bb-6d1a-c6c8d71e2315@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 04:53:32PM +0800, Jason Wang wrote:
> 
> 在 2021/4/13 下午1:47, Michael S. Tsirkin 写道:
> > There are currently two cases where we poll TX vq not in response to a
> > callback: start xmit and rx napi.  We currently do this with callbacks
> > enabled which can cause extra interrupts from the card.  Used not to be
> > a big issue as we run with interrupts disabled but that is no longer the
> > case, and in some cases the rate of spurious interrupts is so high
> > linux detects this and actually kills the interrupt.
> > 
> > Fix up by disabling the callbacks before polling the tx vq.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   drivers/net/virtio_net.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 82e520d2cb12..16d5abed582c 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1429,6 +1429,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
> >   		return;
> >   	if (__netif_tx_trylock(txq)) {
> > +		virtqueue_disable_cb(sq->vq);
> >   		free_old_xmit_skbs(sq, true);
> >   		__netif_tx_unlock(txq);
> 
> 
> Any reason that we don't need to enable the cb here?

Good point ... probably only if the vq isn't empty ...

> And as we discussed in the past, it's probably the time to have a single
> NAPI for both tx and rx?
> 
> Thanks


Donnu. I'd like to get a minimal bugfix in, refactoring on top ...

> 
> >   	}
> > @@ -1582,6 +1583,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> >   	bool use_napi = sq->napi.weight;
> >   	/* Free up any pending old buffers before queueing new ones. */
> > +	virtqueue_disable_cb(sq->vq);
> >   	free_old_xmit_skbs(sq, false);
> >   	if (use_napi && kick)

