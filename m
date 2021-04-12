Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A5535C246
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 11:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243439AbhDLJmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:42:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35162 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240457AbhDLJKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618218601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kyicAu7oSAEk0C9a5jN90ftzS5kBZ/R9XW19N/Po9Jw=;
        b=AeVf2AcQ9ULKZfXryTBvsztQH33PEz45199eRWTkgQIq6IlO73RkuWBj2tGzLlAlaFDhsD
        y4nOv07I+/ywoLi32QNjOQbfvk/VBxMxeZtUYGLX5oNeqWjB8EwCV3PaZILsYBIagJTk8Z
        lahA33OzX6GYa5FdI4wf+EGhKfMvYbY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-uDIRms9WO_iCrN3nMR3-Bw-1; Mon, 12 Apr 2021 05:09:59 -0400
X-MC-Unique: uDIRms9WO_iCrN3nMR3-Bw-1
Received: by mail-wr1-f69.google.com with SMTP id f3so5737000wrt.14
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kyicAu7oSAEk0C9a5jN90ftzS5kBZ/R9XW19N/Po9Jw=;
        b=Gv71WRuJgFpmDwLYqSvjkyO6yqFvibvgszhNaEAjmUy6uZQGJ+pYeOIcOtbzBw80ZJ
         VNd6ySOGBDsCasSS6uz6Oi8W7M4wFKYYltWiS2SAgu6zRn6tgOlgGbsrlOG0qS/NDb9M
         sf6Y021afoPipaqtPuZqYvuworBA4mrBy36qmrwI2pXgtnkaNO8vC0aydcb+OLKz20kP
         FPpINPQSJzqMmZn59IDwGAGuJe9uJcQ3TXvCx4Km229fEp1ER/1uYM92VCa86l834tIt
         kBvNWxsgE4jzGyzhlCcNYPG8zXrijar2KrHDUxHDRDc5Gvj+0GfYXlOT3fG8Bk0FlmAA
         v17Q==
X-Gm-Message-State: AOAM533TOIIiU1ivICeGY3XqPZn2gm8GuC6604hA6CkXLOE0Qivs6qBx
        oUxfetE8d7kwXW6cyD2xXWfKCP7zFoi1j5aIQqh6qq1LKaKOimfjaSAfIJa9yqVfLLqWlatvCH7
        ZBs3F9RT6P1kPzmNtCByxlgAH
X-Received: by 2002:a5d:6242:: with SMTP id m2mr30112999wrv.384.1618218598395;
        Mon, 12 Apr 2021 02:09:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZzSRbut/AX4w/Z5NhgIRjmTIwNxBhovmSFPqcLv7H3F7+4A+7w4uyjzxQf5ifybjKSZNlgg==
X-Received: by 2002:a5d:6242:: with SMTP id m2mr30112985wrv.384.1618218598234;
        Mon, 12 Apr 2021 02:09:58 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
        by smtp.gmail.com with ESMTPSA id u2sm17041666wmm.5.2021.04.12.02.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 02:09:57 -0700 (PDT)
Date:   Mon, 12 Apr 2021 05:09:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, parav@nvidia.com, elic@nvidia.com
Subject: Re: [RFC PATCH] vdpa: mandate 1.0 device
Message-ID: <20210412050730-mutt-send-email-mst@kernel.org>
References: <20210408082648.20145-1-jasowang@redhat.com>
 <20210408115834-mutt-send-email-mst@kernel.org>
 <a6a4ab68-c958-7266-c67c-142960222b67@redhat.com>
 <20210409115343-mutt-send-email-mst@kernel.org>
 <42891807-cb24-5352-f8cb-798e9d1a1854@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42891807-cb24-5352-f8cb-798e9d1a1854@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 02:35:07PM +0800, Jason Wang wrote:
> 
> 在 2021/4/10 上午12:04, Michael S. Tsirkin 写道:
> > On Fri, Apr 09, 2021 at 12:47:55PM +0800, Jason Wang wrote:
> > > 在 2021/4/8 下午11:59, Michael S. Tsirkin 写道:
> > > > On Thu, Apr 08, 2021 at 04:26:48PM +0800, Jason Wang wrote:
> > > > > This patch mandates 1.0 for vDPA devices. The goal is to have the
> > > > > semantic of normative statement in the virtio spec and eliminate the
> > > > > burden of transitional device for both vDPA bus and vDPA parent.
> > > > > 
> > > > > uAPI seems fine since all the vDPA parent mandates
> > > > > VIRTIO_F_ACCESS_PLATFORM which implies 1.0 devices.
> > > > > 
> > > > > For legacy guests, it can still work since Qemu will mediate when
> > > > > necessary (e.g doing the endian conversion).
> > > > > 
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > Hmm. If we do this, don't we still have a problem with
> > > > legacy drivers which don't ack 1.0?
> > > 
> > > Yes, but it's not something that is introduced in this commit. The legacy
> > > driver never work ...
> > My point is this neither fixes or prevents this.
> > 
> > So my suggestion is to finally add ioctls along the lines
> > of PROTOCOL_FEATURES of vhost-user.
> > 
> > Then that one can have bits for legacy le, legacy be and modern.
> > 
> > BTW I looked at vhost-user and it does not look like that
> > has a solution for this problem either, right?
> 
> 
> Right.
> 
> 
> > 
> > 
> > > > Note 1.0 affects ring endianness which is not mediated in QEMU
> > > > so QEMU can't pretend to device guest is 1.0.
> > > 
> > > Right, I plan to send patches to do mediation in the Qemu to unbreak legacy
> > > drivers.
> > > 
> > > Thanks
> > I frankly think we'll need PROTOCOL_FEATURES anyway, it's too useful ...
> > so why not teach drivers about it and be done with it? You can't emulate
> > legacy on modern in a cross endian situation because of vring
> > endian-ness ...
> 
> 
> So the problem still. This can only work when the hardware can support
> legacy vring endian-ness.
> 
> Consider:
> 
> 1) the leagcy driver support is non-normative in the spec
> 2) support a transitional device in the kenrel may requires the hardware
> support and a burden of kernel codes
> 
> I'd rather simply drop the legacy driver support


My point is this patch does not drop legacy support. It merely mandates
modern support.

> to have a simple and easy
> abstarction in the kenrel. For legacy driver in the guest, hypervisor is in
> charge of the mediation:
> 
> 1) config space access endian conversion
> 2) using shadow virtqueue to change the endian in the vring
> 
> Thanks

I'd like to avoid shadow virtqueue hacks if at all possible.
Last I checked performance wasn't much better than just emulating
virtio in software.

> 
> > 
> > 
> > > > 
> > > > 
> > > > 
> > > > 
> > > > > ---
> > > > >    include/linux/vdpa.h | 6 ++++++
> > > > >    1 file changed, 6 insertions(+)
> > > > > 
> > > > > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > > > > index 0fefeb976877..cfde4ec999b4 100644
> > > > > --- a/include/linux/vdpa.h
> > > > > +++ b/include/linux/vdpa.h
> > > > > @@ -6,6 +6,7 @@
> > > > >    #include <linux/device.h>
> > > > >    #include <linux/interrupt.h>
> > > > >    #include <linux/vhost_iotlb.h>
> > > > > +#include <uapi/linux/virtio_config.h>
> > > > >    /**
> > > > >     * vDPA callback definition.
> > > > > @@ -317,6 +318,11 @@ static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
> > > > >    {
> > > > >            const struct vdpa_config_ops *ops = vdev->config;
> > > > > +        /* Mandating 1.0 to have semantics of normative statements in
> > > > > +         * the spec. */
> > > > > +        if (!(features & BIT_ULL(VIRTIO_F_VERSION_1)))
> > > > > +		return -EINVAL;
> > > > > +
> > > > >    	vdev->features_valid = true;
> > > > >            return ops->set_features(vdev, features);
> > > > >    }
> > > > > -- 
> > > > > 2.25.1

