Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FEC35A29D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbhDIQFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:05:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22199 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231946AbhDIQFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617984305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4pXIEp6QTLcUhBgPHNk8mFiyRY9cbts1+UUx37kdPtE=;
        b=K4jdEyiwfR3F/ERPd0jMb9wVWRkgT9HFibIwdip6OKZoGqlbELmBKRFZ5G9P8byVgV5Ld4
        oSGWLoh9bJ4pH7ZxJ2xqd5HFzrxaRFjnyH0WDJKiadD/tHJ9P++qc3GauTqm4x6oXriEN8
        nBaPX3OCMI/9Umk4qo1asiNk8Fy1X5s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-jtaW-l6DMRmGO2jKYzw2sQ-1; Fri, 09 Apr 2021 12:05:04 -0400
X-MC-Unique: jtaW-l6DMRmGO2jKYzw2sQ-1
Received: by mail-wr1-f69.google.com with SMTP id r12so1668498wrw.18
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 09:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4pXIEp6QTLcUhBgPHNk8mFiyRY9cbts1+UUx37kdPtE=;
        b=D+gXE9tf2goJRFAd7o0Ii0i/XpTmJxIGJn1s9goFkqQ8WI1106A1Bwk3x4GjoVaroe
         KEmO3my1qPhb/qsCpOx7SaU0wzPxptS708K2cfmSxGcvZdTq8Eksq0PfoLCg3KcULq/m
         hY52urO1yV9cWrXvtqSMSMfPf61ln229ah1KHMg6RW2Vu35loDgMRJF5MOP3kQ6RU3rp
         qWAm4+fC7xX9d24s76Y1Sz6pT13DhX3cZtEvqbX6QUbtTptzHfANu5U/ny8ThRPTnmm7
         +e5zYOtqhpen3MNRnTPWaH6v3GViDsVP3VcR/TbzonjZkLVDuMxSAPY4+xLMGwE8GJcz
         tFzA==
X-Gm-Message-State: AOAM530AaBrPjPYmFT+OSSGwt69lz8kuXyUmY5oCOJ+8KXZKWhfIDYLu
        jG1YeRxHi6vS6CO/KnpT2xYmBQFoGDoIWa5fN5ssPoAuImw4r2P+/Q3lv+eo/AOe37ABzZQlglI
        G5BfpVq3LPzwCZjxm04NKW1HQ
X-Received: by 2002:adf:f687:: with SMTP id v7mr18058255wrp.272.1617984302810;
        Fri, 09 Apr 2021 09:05:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFnEQujInujNsmq1ttaJLy8i5/5gCEX4rK7k88zoLDZoku4V60sy9jkn30tLwp4cy2O6152g==
X-Received: by 2002:adf:f687:: with SMTP id v7mr18058237wrp.272.1617984302656;
        Fri, 09 Apr 2021 09:05:02 -0700 (PDT)
Received: from redhat.com ([2a10:800e:f0d3:0:b69b:9fb8:3947:5636])
        by smtp.gmail.com with ESMTPSA id q18sm2916754wrs.25.2021.04.09.09.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 09:05:01 -0700 (PDT)
Date:   Fri, 9 Apr 2021 12:04:58 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, parav@nvidia.com, elic@nvidia.com
Subject: Re: [RFC PATCH] vdpa: mandate 1.0 device
Message-ID: <20210409115343-mutt-send-email-mst@kernel.org>
References: <20210408082648.20145-1-jasowang@redhat.com>
 <20210408115834-mutt-send-email-mst@kernel.org>
 <a6a4ab68-c958-7266-c67c-142960222b67@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6a4ab68-c958-7266-c67c-142960222b67@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 12:47:55PM +0800, Jason Wang wrote:
> 
> 在 2021/4/8 下午11:59, Michael S. Tsirkin 写道:
> > On Thu, Apr 08, 2021 at 04:26:48PM +0800, Jason Wang wrote:
> > > This patch mandates 1.0 for vDPA devices. The goal is to have the
> > > semantic of normative statement in the virtio spec and eliminate the
> > > burden of transitional device for both vDPA bus and vDPA parent.
> > > 
> > > uAPI seems fine since all the vDPA parent mandates
> > > VIRTIO_F_ACCESS_PLATFORM which implies 1.0 devices.
> > > 
> > > For legacy guests, it can still work since Qemu will mediate when
> > > necessary (e.g doing the endian conversion).
> > > 
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > Hmm. If we do this, don't we still have a problem with
> > legacy drivers which don't ack 1.0?
> 
> 
> Yes, but it's not something that is introduced in this commit. The legacy
> driver never work ...

My point is this neither fixes or prevents this.

So my suggestion is to finally add ioctls along the lines
of PROTOCOL_FEATURES of vhost-user.

Then that one can have bits for legacy le, legacy be and modern.

BTW I looked at vhost-user and it does not look like that
has a solution for this problem either, right?


> 
> > Note 1.0 affects ring endianness which is not mediated in QEMU
> > so QEMU can't pretend to device guest is 1.0.
> 
> 
> Right, I plan to send patches to do mediation in the Qemu to unbreak legacy
> drivers.
> 
> Thanks

I frankly think we'll need PROTOCOL_FEATURES anyway, it's too useful ...
so why not teach drivers about it and be done with it? You can't emulate
legacy on modern in a cross endian situation because of vring
endian-ness ...


> 
> > 
> > 
> > 
> > 
> > 
> > > ---
> > >   include/linux/vdpa.h | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > > index 0fefeb976877..cfde4ec999b4 100644
> > > --- a/include/linux/vdpa.h
> > > +++ b/include/linux/vdpa.h
> > > @@ -6,6 +6,7 @@
> > >   #include <linux/device.h>
> > >   #include <linux/interrupt.h>
> > >   #include <linux/vhost_iotlb.h>
> > > +#include <uapi/linux/virtio_config.h>
> > >   /**
> > >    * vDPA callback definition.
> > > @@ -317,6 +318,11 @@ static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
> > >   {
> > >           const struct vdpa_config_ops *ops = vdev->config;
> > > +        /* Mandating 1.0 to have semantics of normative statements in
> > > +         * the spec. */
> > > +        if (!(features & BIT_ULL(VIRTIO_F_VERSION_1)))
> > > +		return -EINVAL;
> > > +
> > >   	vdev->features_valid = true;
> > >           return ops->set_features(vdev, features);
> > >   }
> > > -- 
> > > 2.25.1

