Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F0640C08D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 09:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbhIOHcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 03:32:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39897 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236629AbhIOHcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631691059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4dMk9wxP4LSS25hldhTRTpJ4KcbEdyYpOY9saZoZqIM=;
        b=dGaxzRC4I3Kb6IMyz/47UZ6LbXWxWympe7+hFllFfVt81FBSX/cBj0tv7TvU/2XVRLi07f
        5u83E6ZM0Ogy4eoG+GqY3gfxHlcALmPvgaaNifE8Li/9OXVSiVzSkkuPaVYyUXsTnhhWwe
        BTKCI7umZzgFEat3WV8esUc+BsigZ4A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-sw246GmNPbST-NWG3d9VGQ-1; Wed, 15 Sep 2021 03:30:58 -0400
X-MC-Unique: sw246GmNPbST-NWG3d9VGQ-1
Received: by mail-wm1-f70.google.com with SMTP id c2-20020a7bc8420000b0290238db573ab7so1327534wml.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 00:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4dMk9wxP4LSS25hldhTRTpJ4KcbEdyYpOY9saZoZqIM=;
        b=rSUwsOLlNAXJM6CV8UHKYSq05s8RB+RLyxQnmgo8cbLVaywn130Au37g8EjrHftSQw
         iF+XWwc8O978zNwpKOSXOcYK5dCnaGCMpHXPZN/27f76/qPL8jcT5YwwOigyfZ2CZ3S4
         Mhak+DplhpJrmqGyBQLdIYQR2MwBkdUIDw3MjUAlUa/bcb+dWwuyQrVjFHcnDQglm96l
         JYPlLGle07ip3vfxizqQuU9BEr5hlirrMHyKJndO4cQwhTLb4t5xLSp7CV/MSXlBBUSU
         4z6GH9u76kxUVZN/1RdnUKWf6thgyEnY688gw/yGBmsVG/VGAAjzfnMDyoTQ16EAvSPS
         3n5Q==
X-Gm-Message-State: AOAM533JNyCl0+QfB+TrPKbJiq2gZ/nh7xvKNR03RTrC6IlwbGwELu4H
        PyWwWrSdZH+Pe169Z3JZ8sdXllkovxLJfBfAvJGY011rYaCHl7ROP0RzXyi52OhVuNDNwTrs7s+
        1v++jH1t/ljTB/+jClZRXw9zh
X-Received: by 2002:a1c:2943:: with SMTP id p64mr2814304wmp.107.1631691056974;
        Wed, 15 Sep 2021 00:30:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwt2KS/5aHHjDGt/M+aZkwudzcEkWJiH2BomEbPzf5AqZHoWsyfwjVM1n13zUYT6ynNacJZgw==
X-Received: by 2002:a1c:2943:: with SMTP id p64mr2814281wmp.107.1631691056682;
        Wed, 15 Sep 2021 00:30:56 -0700 (PDT)
Received: from redhat.com ([2.55.157.56])
        by smtp.gmail.com with ESMTPSA id q7sm9307148wrr.10.2021.09.15.00.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 00:30:55 -0700 (PDT)
Date:   Wed, 15 Sep 2021 03:30:53 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, wei.yang1@linux.alibaba.com
Subject: Re: [PATCH v2 4/5] vdpa: add new vdpa attribute
 VDPA_ATTR_DEV_F_VERSION_1
Message-ID: <20210915032732-mutt-send-email-mst@kernel.org>
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <cover.1631621507.git.wuzongyong@linux.alibaba.com>
 <834528d24c839080215b2e077f100e9ed5073edc.1631621507.git.wuzongyong@linux.alibaba.com>
 <20210914085711-mutt-send-email-mst@kernel.org>
 <20210915032453.GA18793@L-PF27918B-1352.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915032453.GA18793@L-PF27918B-1352.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 11:24:53AM +0800, Wu Zongyong wrote:
> On Tue, Sep 14, 2021 at 08:58:28AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Sep 14, 2021 at 08:24:51PM +0800, Wu Zongyong wrote:
> > > This new attribute advertises whether the vdpa device is legacy or not.
> > > Users can pick right virtqueue size if the vdpa device is legacy which
> > > doesn't support to change virtqueue size.
> > > 
> > > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> > 
> > So if we are bothering with legacy, I think there are
> > several things to do when building the interface
> > - support transitional devices, that is allow userspace
> >   to tell device it's in legacy mode
> > - support reporting/setting supporting endian-ness
> 
> It's true if we try to implement a general drvier for legacy.
> But this series is dedicated to implement a driver only for ENI. Is it
> necessary to implement what you said here in this series?

To a certain degree, yes.

I am thinking about the UAPI here. The new attribute is part of that.
E.g. userspace consuming this needs to be more or less hardware agnostic
and not depend on specifics of ENI.

Otherwise if userspace assumes legacy==eni then it will break with
other hardware.
 
One way to test how generic it all is would be adding legacy support in
the simulator.

> > 
> > > ---
> > >  drivers/vdpa/vdpa.c          | 6 ++++++
> > >  drivers/virtio/virtio_vdpa.c | 7 ++++++-
> > >  include/uapi/linux/vdpa.h    | 1 +
> > >  3 files changed, 13 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > index 1dc121a07a93..533d7f589eee 100644
> > > --- a/drivers/vdpa/vdpa.c
> > > +++ b/drivers/vdpa/vdpa.c
> > > @@ -12,6 +12,7 @@
> > >  #include <linux/slab.h>
> > >  #include <linux/vdpa.h>
> > >  #include <uapi/linux/vdpa.h>
> > > +#include <uapi/linux/virtio_config.h>
> > >  #include <net/genetlink.h>
> > >  #include <linux/mod_devicetable.h>
> > >  
> > > @@ -494,6 +495,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > >  	u16 max_vq_size;
> > >  	u32 device_id;
> > >  	u32 vendor_id;
> > > +	u64 features;
> > >  	void *hdr;
> > >  	int err;
> > >  
> > > @@ -508,6 +510,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > >  	device_id = vdev->config->get_device_id(vdev);
> > >  	vendor_id = vdev->config->get_vendor_id(vdev);
> > >  	max_vq_size = vdev->config->get_vq_num_max(vdev);
> > > +	features = vdev->config->get_features(vdev);
> > >  
> > >  	err = -EMSGSIZE;
> > >  	if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev)))
> > > @@ -520,6 +523,9 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > >  		goto msg_err;
> > >  	if (nla_put_u16(msg, VDPA_ATTR_DEV_MAX_VQ_SIZE, max_vq_size))
> > >  		goto msg_err;
> > > +	if (features & BIT_ULL(VIRTIO_F_VERSION_1) &&
> > > +	    nla_put_flag(msg, VDPA_ATTR_DEV_VERSION_1))
> > > +		goto msg_err;
> > >  
> > >  	genlmsg_end(msg, hdr);
> > >  	return 0;
> > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > > index 72eaef2caeb1..1cba957c4cdc 100644
> > > --- a/drivers/virtio/virtio_vdpa.c
> > > +++ b/drivers/virtio/virtio_vdpa.c
> > > @@ -7,6 +7,7 @@
> > >   *
> > >   */
> > >  
> > > +#include "linux/virtio_config.h"
> > >  #include <linux/init.h>
> > >  #include <linux/module.h>
> > >  #include <linux/device.h>
> > > @@ -145,6 +146,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > >  	/* Assume split virtqueue, switch to packed if necessary */
> > >  	struct vdpa_vq_state state = {0};
> > >  	unsigned long flags;
> > > +	bool may_reduce_num = false;
> > >  	u32 align, num;
> > >  	int err;
> > >  
> > > @@ -169,10 +171,13 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > >  		goto error_new_virtqueue;
> > >  	}
> > >  
> > > +	if (ops->get_features(vdpa) & BIT_ULL(VIRTIO_F_VERSION_1))
> > > +		may_reduce_num = true;
> > > +
> > >  	/* Create the vring */
> > >  	align = ops->get_vq_align(vdpa);
> > >  	vq = vring_create_virtqueue(index, num, align, vdev,
> > > -				    true, true, ctx,
> > > +				    true, may_reduce_num, ctx,
> > >  				    virtio_vdpa_notify, callback, name);
> > >  	if (!vq) {
> > >  		err = -ENOMEM;
> > > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > > index 66a41e4ec163..ce0b74276a5b 100644
> > > --- a/include/uapi/linux/vdpa.h
> > > +++ b/include/uapi/linux/vdpa.h
> > > @@ -32,6 +32,7 @@ enum vdpa_attr {
> > >  	VDPA_ATTR_DEV_VENDOR_ID,		/* u32 */
> > >  	VDPA_ATTR_DEV_MAX_VQS,			/* u32 */
> > >  	VDPA_ATTR_DEV_MAX_VQ_SIZE,		/* u16 */
> > > +	VDPA_ATTR_DEV_VERSION_1,		/* flag */
> > >  
> > >  	/* new attributes must be added above here */
> > >  	VDPA_ATTR_MAX,
> > > -- 
> > > 2.31.1

