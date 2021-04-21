Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2ED43666AC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 10:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbhDUIEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 04:04:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35096 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232140AbhDUIEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618992211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mPKgP7klNWLubS6sd3edyUmumJ6vttCicSRo4mXzd7s=;
        b=cioiDVHbDACrkXz1s1hr3z2EBLkbWAWuEfeNF0DIgUgpvCkNoFVNOdRTpb4vhUCZud66+0
        O+I1zKmJm1J+xLfn61Lqvn98b9HtpUB1jdTVRF0A9aeny9Hi2pWSo9mMGtLkTq/TTViLAN
        JZbP9sgENEc4/muMyeQS+WMYGAru7Rs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-yRKTKtY_PV2KnUmwC1zgKA-1; Wed, 21 Apr 2021 04:03:30 -0400
X-MC-Unique: yRKTKtY_PV2KnUmwC1zgKA-1
Received: by mail-wm1-f72.google.com with SMTP id k15-20020a05600c0b4fb029013886a4b6a5so530636wmr.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 01:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mPKgP7klNWLubS6sd3edyUmumJ6vttCicSRo4mXzd7s=;
        b=WrWRFkvtfYk6EZgw4c1CMdo5KTyZEAy9EPNojQYV2NkyBN/Fg8Qdp8NbK1rshuuJ2t
         Y8TNH5m1nrp5LGCc5sxzFAM2UMjW0TxZw1BYb2WCmuMqul18nLJ9NxVnaLdBn+unt48a
         b85RLtlH9E4Qr5EIDAblkIc7EzvrZxzE0eODs2e+l9p2ouafWKuuzgfgTry9KTt3FeZ6
         SQWbrrfccfBK8mAMYbGJW6iKR+Hu4gm4BRInienhw3LsWxGPFJ5ID15lEVEE3RSbe0k+
         u2VjrCdSA+s1fZz5YhowjmORPxiboiXG0Ud9RAcKC2wnyrsKNyz1KrecPrdhidOn1j+l
         TebA==
X-Gm-Message-State: AOAM5321QobIzv1fiEhuDEwxIPdzTFnZzch7pbSJ2CerHBJ7fh9LAi7C
        swCCIr4dXpggBlP+zMqpWBJPOzaoqZn7T4MEES+QPB985XFaisdaeEHHmR6/ZIts9EVhVKT4qxm
        quUPQHNZKaxN9T89H58Sd4SbT
X-Received: by 2002:a1c:a9d5:: with SMTP id s204mr8617792wme.24.1618992208786;
        Wed, 21 Apr 2021 01:03:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPhLH1AFcxrJDYFlw8cZzL5sqgwpmbbTELoYTAUZjcc9YuFlY4dLf0fFPHK5u383kwpxaQ0w==
X-Received: by 2002:a1c:a9d5:: with SMTP id s204mr8617775wme.24.1618992208600;
        Wed, 21 Apr 2021 01:03:28 -0700 (PDT)
Received: from redhat.com ([2a10:800a:cdef:0:114d:2085:61e4:7b41])
        by smtp.gmail.com with ESMTPSA id x189sm1442422wmg.17.2021.04.21.01.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 01:03:27 -0700 (PDT)
Date:   Wed, 21 Apr 2021 04:03:24 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, parav@nvidia.com, elic@nvidia.com,
        "Zhu, Lingshan" <lingshan.zhu@intel.com>
Subject: Re: [RFC PATCH] vdpa: mandate 1.0 device
Message-ID: <20210421035331-mutt-send-email-mst@kernel.org>
References: <20210408082648.20145-1-jasowang@redhat.com>
 <20210408115834-mutt-send-email-mst@kernel.org>
 <a6a4ab68-c958-7266-c67c-142960222b67@redhat.com>
 <20210409115343-mutt-send-email-mst@kernel.org>
 <42891807-cb24-5352-f8cb-798e9d1a1854@redhat.com>
 <20210412050730-mutt-send-email-mst@kernel.org>
 <01918e14-7f7a-abf2-5864-292a32f0233c@redhat.com>
 <d5632a4d-4d0b-b08d-06f9-c56f16734607@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5632a4d-4d0b-b08d-06f9-c56f16734607@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:41:36PM +0800, Jason Wang wrote:
> 
> 在 2021/4/12 下午5:23, Jason Wang 写道:
> > 
> > 在 2021/4/12 下午5:09, Michael S. Tsirkin 写道:
> > > On Mon, Apr 12, 2021 at 02:35:07PM +0800, Jason Wang wrote:
> > > > 在 2021/4/10 上午12:04, Michael S. Tsirkin 写道:
> > > > > On Fri, Apr 09, 2021 at 12:47:55PM +0800, Jason Wang wrote:
> > > > > > 在 2021/4/8 下午11:59, Michael S. Tsirkin 写道:
> > > > > > > On Thu, Apr 08, 2021 at 04:26:48PM +0800, Jason Wang wrote:
> > > > > > > > This patch mandates 1.0 for vDPA devices. The goal is to have the
> > > > > > > > semantic of normative statement in the virtio
> > > > > > > > spec and eliminate the
> > > > > > > > burden of transitional device for both vDPA bus and vDPA parent.
> > > > > > > > 
> > > > > > > > uAPI seems fine since all the vDPA parent mandates
> > > > > > > > VIRTIO_F_ACCESS_PLATFORM which implies 1.0 devices.
> > > > > > > > 
> > > > > > > > For legacy guests, it can still work since Qemu will mediate when
> > > > > > > > necessary (e.g doing the endian conversion).
> > > > > > > > 
> > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > Hmm. If we do this, don't we still have a problem with
> > > > > > > legacy drivers which don't ack 1.0?
> > > > > > Yes, but it's not something that is introduced in this
> > > > > > commit. The legacy
> > > > > > driver never work ...
> > > > > My point is this neither fixes or prevents this.
> > > > > 
> > > > > So my suggestion is to finally add ioctls along the lines
> > > > > of PROTOCOL_FEATURES of vhost-user.
> > > > > 
> > > > > Then that one can have bits for legacy le, legacy be and modern.
> > > > > 
> > > > > BTW I looked at vhost-user and it does not look like that
> > > > > has a solution for this problem either, right?
> > > > 
> > > > Right.
> > > > 
> > > > 
> > > > > 
> > > > > > > Note 1.0 affects ring endianness which is not mediated in QEMU
> > > > > > > so QEMU can't pretend to device guest is 1.0.
> > > > > > Right, I plan to send patches to do mediation in the
> > > > > > Qemu to unbreak legacy
> > > > > > drivers.
> > > > > > 
> > > > > > Thanks
> > > > > I frankly think we'll need PROTOCOL_FEATURES anyway, it's
> > > > > too useful ...
> > > > > so why not teach drivers about it and be done with it? You
> > > > > can't emulate
> > > > > legacy on modern in a cross endian situation because of vring
> > > > > endian-ness ...
> > > > 
> > > > So the problem still. This can only work when the hardware can support
> > > > legacy vring endian-ness.
> > > > 
> > > > Consider:
> > > > 
> > > > 1) the leagcy driver support is non-normative in the spec
> > > > 2) support a transitional device in the kenrel may requires the
> > > > hardware
> > > > support and a burden of kernel codes
> > > > 
> > > > I'd rather simply drop the legacy driver support
> > > 
> > > My point is this patch does not drop legacy support. It merely mandates
> > > modern support.
> > 
> > 
> > I am not sure I get here. This patch fails the set_feature if VERSION_1
> > is not negotiated. This means:
> > 
> > 1) vDPA presents a modern device instead of transitonal device
> > 2) legacy driver can't be probed
> > 
> > What I'm missing?
> 
> 
> Hi Michael:
> 
> Do you agree to find the way to present modern device? We need a conclusion
> to make the netlink API work to move forward.
> 
> Thanks

I think we need a way to support legacy with no data path overhead. qemu
setting VERSION_1 for a legacy guest affects the ring format so it does
not really work. This seems to rule out emulating config space entirely
in userspace.

So I think we should add an ioctl along the lines of
protocol features. Then I think we can reserve feature bits
for config space format: legacy LE, legacy BE, modern.

Querying the feature bits will provide us with info about
what does the device support. Acking them will tell device
what does guest need.





> 
> > 
> > 
> > > 
> > > > to have a simple and easy
> > > > abstarction in the kenrel. For legacy driver in the guest,
> > > > hypervisor is in
> > > > charge of the mediation:
> > > > 
> > > > 1) config space access endian conversion
> > > > 2) using shadow virtqueue to change the endian in the vring
> > > > 
> > > > Thanks
> > > I'd like to avoid shadow virtqueue hacks if at all possible.
> > > Last I checked performance wasn't much better than just emulating
> > > virtio in software.
> > 
> > 
> > I think the legacy driver support is just a nice to have. Or do you see
> > any value to that? I guess for mellanox and intel, only modern device is
> > supported in the hardware.
> > 
> > Thanks
> > 
> > 
> > > 
> > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > > ---
> > > > > > > >     include/linux/vdpa.h | 6 ++++++
> > > > > > > >     1 file changed, 6 insertions(+)
> > > > > > > > 
> > > > > > > > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > > > > > > > index 0fefeb976877..cfde4ec999b4 100644
> > > > > > > > --- a/include/linux/vdpa.h
> > > > > > > > +++ b/include/linux/vdpa.h
> > > > > > > > @@ -6,6 +6,7 @@
> > > > > > > >     #include <linux/device.h>
> > > > > > > >     #include <linux/interrupt.h>
> > > > > > > >     #include <linux/vhost_iotlb.h>
> > > > > > > > +#include <uapi/linux/virtio_config.h>
> > > > > > > >     /**
> > > > > > > >      * vDPA callback definition.
> > > > > > > > @@ -317,6 +318,11 @@ static inline int
> > > > > > > > vdpa_set_features(struct vdpa_device *vdev, u64
> > > > > > > > features)
> > > > > > > >     {
> > > > > > > >             const struct vdpa_config_ops *ops = vdev->config;
> > > > > > > > +        /* Mandating 1.0 to have semantics of
> > > > > > > > normative statements in
> > > > > > > > +         * the spec. */
> > > > > > > > +        if (!(features & BIT_ULL(VIRTIO_F_VERSION_1)))
> > > > > > > > +        return -EINVAL;
> > > > > > > > +
> > > > > > > >         vdev->features_valid = true;
> > > > > > > >             return ops->set_features(vdev, features);
> > > > > > > >     }
> > > > > > > > -- 
> > > > > > > > 2.25.1
> > 

