Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0A637B720
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 09:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhELHzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 03:55:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32954 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230188AbhELHzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 03:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620806033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oLqmlEuhp9K1sh6b2eNpoKDd7Zyatg2EsHuk0cVSHtk=;
        b=TQXNadPuQiaQqLydyCdtbcZO4W5V53QmSAENag9M1GRvJ0dkFmHtSPzfgMp5HuzG27c5Ub
        4CAqTLxC3WHyEJ/ICYF/VvtzUURiLzr/Hjo4U7qxXIZvp4mFfwNVCOwgOfdrsvq9Xlql1x
        gZG+N92uDNYc7P264iiWtml4cTZBR/0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-wjZ85ylWM_q98wIPx5OMZw-1; Wed, 12 May 2021 03:53:51 -0400
X-MC-Unique: wjZ85ylWM_q98wIPx5OMZw-1
Received: by mail-wr1-f71.google.com with SMTP id 4-20020adf80040000b029010cab735fdeso9785144wrk.14
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 00:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oLqmlEuhp9K1sh6b2eNpoKDd7Zyatg2EsHuk0cVSHtk=;
        b=ZyWtOo1WSQHlLGZQFms3sC4OGeVDyjrdd0mrF5xP7U3lytkatebf6IM1CSLgm5DMt1
         dT8ceN7jcvltepml0fQDbNBFenTXko5xXO5xvm0ZH2FE2v01vMKuKosrFlVhc/fmsrHh
         JPtXgUb+54zRWHtxeqyHYgtauitOJJra2+RKB1kqmL0e2J9x3IUX0QbdLxbsnAu5F9bf
         hdquBO/mtb0rNjMYLfawe9IY8Y2JggL9CZ9cEOn//v7oGZcr+jDs2nuSLf9Q6VopCJmA
         gLola0I397EKQ1Llt/yi3yc6FO2wEBvMGlM6tp8k4tsw/BOaw+TZJb8r3N95CcY7GRPL
         xCkw==
X-Gm-Message-State: AOAM531OMsNAcCTFm7iiMzDfRY8Cxuq6dUKRoli9CRyylwWclmD3tQyt
        FJBx9qDRbRVyhATTAcvuZpx/4hXd6OCdJaORh0VeSWq1ra1tO/a3ypA2p6SyR7SPIvyj2+gIE+T
        UssVf1nLnTaKf19hD7IJsRgCy
X-Received: by 2002:a5d:6687:: with SMTP id l7mr44251687wru.235.1620806030327;
        Wed, 12 May 2021 00:53:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWcYC1ZJV5ndKMfy0hWhlyn1mCsM2dWyCgry1CQpLkZu4SNNu5gsMBIrowg+nFlYrSK1Mh7g==
X-Received: by 2002:a5d:6687:: with SMTP id l7mr44251663wru.235.1620806030104;
        Wed, 12 May 2021 00:53:50 -0700 (PDT)
Received: from redhat.com ([2a10:8004:640e:0:d1db:1802:5043:7b85])
        by smtp.gmail.com with ESMTPSA id r2sm31252563wrv.39.2021.05.12.00.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 00:53:49 -0700 (PDT)
Date:   Wed, 12 May 2021 03:53:46 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, parav@nvidia.com, elic@nvidia.com,
        Lingshan Zhu <lingshan.zhu@intel.com>, mapfelba@redhat.com
Subject: Re: [RFC PATCH] vdpa: mandate 1.0 device
Message-ID: <20210511061740-mutt-send-email-mst@kernel.org>
References: <20210408082648.20145-1-jasowang@redhat.com>
 <20210409115343-mutt-send-email-mst@kernel.org>
 <42891807-cb24-5352-f8cb-798e9d1a1854@redhat.com>
 <20210412050730-mutt-send-email-mst@kernel.org>
 <01918e14-7f7a-abf2-5864-292a32f0233c@redhat.com>
 <d5632a4d-4d0b-b08d-06f9-c56f16734607@redhat.com>
 <20210421035331-mutt-send-email-mst@kernel.org>
 <3d5754f3-c012-67ad-5f01-fc16ec53df4e@redhat.com>
 <529543956.24692551.1620722593826.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <529543956.24692551.1620722593826.JavaMail.zimbra@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 04:43:13AM -0400, Jason Wang wrote:
> 
> 
> ----- 原始邮件 -----
> > 
> > 在 2021/4/21 下午4:03, Michael S. Tsirkin 写道:
> > > On Wed, Apr 21, 2021 at 03:41:36PM +0800, Jason Wang wrote:
> > >> 在 2021/4/12 下午5:23, Jason Wang 写道:
> > >>> 在 2021/4/12 下午5:09, Michael S. Tsirkin 写道:
> > >>>> On Mon, Apr 12, 2021 at 02:35:07PM +0800, Jason Wang wrote:
> > >>>>> 在 2021/4/10 上午12:04, Michael S. Tsirkin 写道:
> > >>>>>> On Fri, Apr 09, 2021 at 12:47:55PM +0800, Jason Wang wrote:
> > >>>>>>> 在 2021/4/8 下午11:59, Michael S. Tsirkin 写道:
> > >>>>>>>> On Thu, Apr 08, 2021 at 04:26:48PM +0800, Jason Wang wrote:
> > >>>>>>>>> This patch mandates 1.0 for vDPA devices. The goal is to have the
> > >>>>>>>>> semantic of normative statement in the virtio
> > >>>>>>>>> spec and eliminate the
> > >>>>>>>>> burden of transitional device for both vDPA bus and vDPA parent.
> > >>>>>>>>>
> > >>>>>>>>> uAPI seems fine since all the vDPA parent mandates
> > >>>>>>>>> VIRTIO_F_ACCESS_PLATFORM which implies 1.0 devices.
> > >>>>>>>>>
> > >>>>>>>>> For legacy guests, it can still work since Qemu will mediate when
> > >>>>>>>>> necessary (e.g doing the endian conversion).
> > >>>>>>>>>
> > >>>>>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> > >>>>>>>> Hmm. If we do this, don't we still have a problem with
> > >>>>>>>> legacy drivers which don't ack 1.0?
> > >>>>>>> Yes, but it's not something that is introduced in this
> > >>>>>>> commit. The legacy
> > >>>>>>> driver never work ...
> > >>>>>> My point is this neither fixes or prevents this.
> > >>>>>>
> > >>>>>> So my suggestion is to finally add ioctls along the lines
> > >>>>>> of PROTOCOL_FEATURES of vhost-user.
> > >>>>>>
> > >>>>>> Then that one can have bits for legacy le, legacy be and modern.
> > >>>>>>
> > >>>>>> BTW I looked at vhost-user and it does not look like that
> > >>>>>> has a solution for this problem either, right?
> > >>>>> Right.
> > >>>>>
> > >>>>>
> > >>>>>>>> Note 1.0 affects ring endianness which is not mediated in QEMU
> > >>>>>>>> so QEMU can't pretend to device guest is 1.0.
> > >>>>>>> Right, I plan to send patches to do mediation in the
> > >>>>>>> Qemu to unbreak legacy
> > >>>>>>> drivers.
> > >>>>>>>
> > >>>>>>> Thanks
> > >>>>>> I frankly think we'll need PROTOCOL_FEATURES anyway, it's
> > >>>>>> too useful ...
> > >>>>>> so why not teach drivers about it and be done with it? You
> > >>>>>> can't emulate
> > >>>>>> legacy on modern in a cross endian situation because of vring
> > >>>>>> endian-ness ...
> > >>>>> So the problem still. This can only work when the hardware can support
> > >>>>> legacy vring endian-ness.
> > >>>>>
> > >>>>> Consider:
> > >>>>>
> > >>>>> 1) the leagcy driver support is non-normative in the spec
> > >>>>> 2) support a transitional device in the kenrel may requires the
> > >>>>> hardware
> > >>>>> support and a burden of kernel codes
> > >>>>>
> > >>>>> I'd rather simply drop the legacy driver support
> > >>>> My point is this patch does not drop legacy support. It merely mandates
> > >>>> modern support.
> > >>>
> > >>> I am not sure I get here. This patch fails the set_feature if VERSION_1
> > >>> is not negotiated. This means:
> > >>>
> > >>> 1) vDPA presents a modern device instead of transitonal device
> > >>> 2) legacy driver can't be probed
> > >>>
> > >>> What I'm missing?
> > >>
> > >> Hi Michael:
> > >>
> > >> Do you agree to find the way to present modern device? We need a
> > >> conclusion
> > >> to make the netlink API work to move forward.
> > >>
> > >> Thanks
> > > I think we need a way to support legacy with no data path overhead. qemu
> > > setting VERSION_1 for a legacy guest affects the ring format so it does
> > > not really work. This seems to rule out emulating config space entirely
> > > in userspace.
> > 
> > 
> > So I'd rather drop the legacy support in this case. It never work for
> > vDPA in the past and virtio-vDPA doesn't even need that. Note that
> > ACCESS_PLATFORM is mandated for all the vDPA parents right now which
> > implies modern device and LE. I wonder what's the value for supporting
> > legacy in this case or do we really encourage vendors to ship card with
> > legacy support (e.g endian support in the hardware)?
> 
> Hi Michael:
> 
> Any thoughts on this approach?
> 
> My understanding is that dropping legacy support will simplify a lot of stuffs.
> 
> Thanks

So basically the main condition is that strong memory barriers aren't
needed for virtio, smp barriers are enough.
Are there architectures besides x86 (where it's kind of true - as long as
one does not use non-temporals) where that is true?
If all these architectures are LE then we don't need to worry
about endian support in the hardware.

In other words I guess yes we could have qemu limit things to x86 and
then just pretend to the card that it's virtio 1.
So endian-ness we can address.

Problem is virtio 1 has effects beyond this. things like header size
with mergeable buffers off for virtio net.

So I am inclined to say let us not do the "pretend it's virtio 1" game
in qemu.  Let us be honest to the card about what happens.
But if you want to limit things to x86 either in kernel or in qemu,
that's ok by me.

> 
> > 
> > 
> > >
> > > So I think we should add an ioctl along the lines of
> > > protocol features. Then I think we can reserve feature bits
> > > for config space format: legacy LE, legacy BE, modern.
> > 
> > 
> > We had VHOST_SET_VRING_ENDIAN but this will complicates both the vDPA
> > parent and management. What's more important, legacy behaviour is not
> > restrictied by the spec.
> > 
> > 
> > >
> > > Querying the feature bits will provide us with info about
> > > what does the device support. Acking them will tell device
> > > what does guest need.
> > 
> > 
> > I think this can work, but I wonder how much we can gain from such
> > complexitiy.
> > 
> > Thanks
> > 
> > 
> > >
> > >
> > >
> > >
> > >
> > >>>
> > >>>>> to have a simple and easy
> > >>>>> abstarction in the kenrel. For legacy driver in the guest,
> > >>>>> hypervisor is in
> > >>>>> charge of the mediation:
> > >>>>>
> > >>>>> 1) config space access endian conversion
> > >>>>> 2) using shadow virtqueue to change the endian in the vring
> > >>>>>
> > >>>>> Thanks
> > >>>> I'd like to avoid shadow virtqueue hacks if at all possible.
> > >>>> Last I checked performance wasn't much better than just emulating
> > >>>> virtio in software.
> > >>>
> > >>> I think the legacy driver support is just a nice to have. Or do you see
> > >>> any value to that? I guess for mellanox and intel, only modern device is
> > >>> supported in the hardware.
> > >>>
> > >>> Thanks
> > >>>
> > >>>
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>>> ---
> > >>>>>>>>>      include/linux/vdpa.h | 6 ++++++
> > >>>>>>>>>      1 file changed, 6 insertions(+)
> > >>>>>>>>>
> > >>>>>>>>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > >>>>>>>>> index 0fefeb976877..cfde4ec999b4 100644
> > >>>>>>>>> --- a/include/linux/vdpa.h
> > >>>>>>>>> +++ b/include/linux/vdpa.h
> > >>>>>>>>> @@ -6,6 +6,7 @@
> > >>>>>>>>>      #include <linux/device.h>
> > >>>>>>>>>      #include <linux/interrupt.h>
> > >>>>>>>>>      #include <linux/vhost_iotlb.h>
> > >>>>>>>>> +#include <uapi/linux/virtio_config.h>
> > >>>>>>>>>      /**
> > >>>>>>>>>       * vDPA callback definition.
> > >>>>>>>>> @@ -317,6 +318,11 @@ static inline int
> > >>>>>>>>> vdpa_set_features(struct vdpa_device *vdev, u64
> > >>>>>>>>> features)
> > >>>>>>>>>      {
> > >>>>>>>>>              const struct vdpa_config_ops *ops = vdev->config;
> > >>>>>>>>> +        /* Mandating 1.0 to have semantics of
> > >>>>>>>>> normative statements in
> > >>>>>>>>> +         * the spec. */
> > >>>>>>>>> +        if (!(features & BIT_ULL(VIRTIO_F_VERSION_1)))
> > >>>>>>>>> +        return -EINVAL;
> > >>>>>>>>> +
> > >>>>>>>>>          vdev->features_valid = true;
> > >>>>>>>>>              return ops->set_features(vdev, features);
> > >>>>>>>>>      }
> > >>>>>>>>> --
> > >>>>>>>>> 2.25.1
> > 
> > 

