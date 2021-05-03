Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E23B37125E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 10:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbhECIS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 04:18:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29664 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232960AbhECISW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 04:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620029848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sfawQKRvown06amibYWUjSz6pHPc1TD9YuoP34dEXPs=;
        b=eAvL4bWTGN/LxMst5RSjve+VFmqD3V3izl2IHNQuu1OwnijmB6tMHgRUWiwZOLhBcTMsm9
        DG/XLVby4TvOY//S5dq9uIzQX8l0rFmbQktazJJqN5X0zdOJzPJ3+QwN9D8neW18Yq4L/Q
        vUGMOBfiuL4omSphkhdtspbe0/ljsoA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-rb6GoiwrPmKCZpIaMFESxQ-1; Mon, 03 May 2021 04:17:27 -0400
X-MC-Unique: rb6GoiwrPmKCZpIaMFESxQ-1
Received: by mail-wr1-f69.google.com with SMTP id 67-20020adf81490000b029010756d109e6so3449474wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 01:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sfawQKRvown06amibYWUjSz6pHPc1TD9YuoP34dEXPs=;
        b=PLMDv2WXMssI+aX3cjv0nlEY11I2G+uyekVAJzaqJhDIoF88fmTZUK0rjEfBqbuDLd
         dvwwO/QYpI6EKDeOtbHocdC8hUliNmY4TsfL0wrrv45p0fFx7rIXadjZW4MZP7mOzEEq
         6ZiWcySS6HZaXF1FFvzdoXNpUPfPFnd11vUCyXPnJcwLzoRv8WC5yVt0gYbR42b1BXKK
         WqliHlErWw4omEsv+07XA8aruzSu9TBGyHPdL+XnaA+bPtXj12nF7ZWBAtGcQVEsgE4L
         D0oolNFvLZjRNieukAXC4JmwDuIPtAi1HPgSJPq5VNb/xylWzXlcV8CeTY/b56+K2Std
         9+xQ==
X-Gm-Message-State: AOAM530qB3jMHbBsgaUHlMlTGLkOPg28ISC/L8hSnbWbKq+9X58UOOQg
        3r6OgtGA73qPEzWFAQBwrb3vcRGdzA7SmKkBpeaAcE3XeB6FWsmEUXOA/i0Vi6Vhid7Zfhk5DPf
        tpo2a5n+bsUVk6PDxj+uZnqT3
X-Received: by 2002:adf:e8ce:: with SMTP id k14mr5318717wrn.362.1620029845875;
        Mon, 03 May 2021 01:17:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2jIadbtWNDtdJWbgmNINTRv6VVe2MQ37HEigOuGnTWAK1m/4RJyWkDCR4ie4nJHk26lNs4A==
X-Received: by 2002:adf:e8ce:: with SMTP id k14mr5318707wrn.362.1620029845686;
        Mon, 03 May 2021 01:17:25 -0700 (PDT)
Received: from redhat.com (bzq-79-178-133-9.red.bezeqint.net. [79.178.133.9])
        by smtp.gmail.com with ESMTPSA id p10sm11997977wre.84.2021.05.03.01.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 01:17:25 -0700 (PDT)
Date:   Mon, 3 May 2021 04:17:23 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_ring: boolean values to a bool variable
Message-ID: <20210503041706-mutt-send-email-mst@kernel.org>
References: <1610704825-17724-1-git-send-email-abaci-bugfix@linux.alibaba.com>
 <1d311c25-9051-ddcd-e7e1-5adbb8a913f9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d311c25-9051-ddcd-e7e1-5adbb8a913f9@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 10:57:03AM +0800, Jason Wang wrote:
> 
> On 2021/1/15 下午6:00, Jiapeng Zhong wrote:
> > Fix the following coccicheck warnings:
> > 
> > ./drivers/virtio/virtio_ring.c:1637:1-29: WARNING: Assignment of
> > 0/1 to bool variable.
> > 
> > ./drivers/virtio/virtio_ring.c:1636:1-30: WARNING: Assignment of
> > 0/1 to bool variable.
> > 
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
> 
> 
> It looks to me it's not the only places:
> 
> git grep avail_wrap_counter
> drivers/virtio/virtio_ring.c:                   bool avail_wrap_counter;
> drivers/virtio/virtio_ring.c: vq->packed.avail_wrap_counter ^= 1;
> drivers/virtio/virtio_ring.c: vq->packed.avail_wrap_counter ^= 1;
> drivers/virtio/virtio_ring.c:   if (wrap_counter !=
> vq->packed.avail_wrap_counter)
> drivers/virtio/virtio_ring.c:   vq->packed.avail_wrap_counter = 1;
> 
> Thanks


Agreed if we are doing this let's change them all.

> 
> > ---
> >   drivers/virtio/virtio_ring.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 71e16b5..5adb361 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -1633,8 +1633,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
> >   	vq->packed.vring.device = device;
> >   	vq->packed.next_avail_idx = 0;
> > -	vq->packed.avail_wrap_counter = 1;
> > -	vq->packed.used_wrap_counter = 1;
> > +	vq->packed.avail_wrap_counter = true;
> > +	vq->packed.used_wrap_counter = true;
> >   	vq->packed.event_flags_shadow = 0;
> >   	vq->packed.avail_used_flags = 1 << VRING_PACKED_DESC_F_AVAIL;

