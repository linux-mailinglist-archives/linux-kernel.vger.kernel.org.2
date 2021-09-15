Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C25740C42F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 13:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237602AbhIOLLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 07:11:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237562AbhIOLLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 07:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631704216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JcHCmj3cvd+64VQr8BHNTf8c//397whjwhYgQBrI9QY=;
        b=VB708mDQc2+LFwDNDzS0aTUu2TTO2LHRiLoRDTlT9wavID8LvXMH9FTB7RoD1Qr4jQECg3
        uTftbw9nFd/sSaECGRH6GDbX6r3KqWSgC9B2C6gjY/Rfz1qgDJc26mjBfb5H+c1c5AjZU6
        TIpfVNo93f4lz5ZlHhEfM6vhdfTWIeg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-Mx8Z9paZMgOSjEPxpIFcMQ-1; Wed, 15 Sep 2021 07:10:15 -0400
X-MC-Unique: Mx8Z9paZMgOSjEPxpIFcMQ-1
Received: by mail-wm1-f71.google.com with SMTP id z18-20020a1c7e120000b02902e69f6fa2e0so1283125wmc.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 04:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JcHCmj3cvd+64VQr8BHNTf8c//397whjwhYgQBrI9QY=;
        b=nOqPMiUPkzZgLHOpdnbvf+yFrGGsWUZKUZ3WyXipj1LyYYu2M9bzYDCsP9QbLfs5P4
         6wNOG1IC433ajRcJuTNBO3R70UiVriHKuL5djQ9JRDTo+nbaR2zFpG2DE4m0SKp3cGDc
         SlAIQrWkuFmfQIt7t3kMEBHm3UeVFGI5McMSp60CygV2kOJOprh+l7UmH12CZz3VCR56
         HZ4bDfdlDEVaekIn8ayFA8oOcx+iZFTFbYBPe/tdyZdCxZCJWR2UclhKruIH8o3fueRb
         G4K2jR1/+Rm/xluk3ESlPRjGtVKhMugpA9qtEO2mpW/ctfFP97IWlhoeHpBX2UZnXH2Y
         DmFQ==
X-Gm-Message-State: AOAM531rqx03cPL/7CYdFXmAYs13zVuiioY9k7QwEK/Lw6OXxGMehcml
        v4FCuCXoQ5zSaItUPArentSEEtNnr2+kcV90tp5VVhnPsm88IohzaxWjTGESOn4sxrOIAnf2WBL
        oqdfHx63cwa40+xvJ2j8dk0by
X-Received: by 2002:a1c:28a:: with SMTP id 132mr3739540wmc.101.1631704214189;
        Wed, 15 Sep 2021 04:10:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwH6OAXSIvprwNUVtsxUUkCUdgcjFVIvgZKPIZ8ABVHRyPWzmIUjNkQsThbAHIbk8cVOjsSLA==
X-Received: by 2002:a1c:28a:: with SMTP id 132mr3739514wmc.101.1631704213929;
        Wed, 15 Sep 2021 04:10:13 -0700 (PDT)
Received: from redhat.com ([2.55.157.56])
        by smtp.gmail.com with ESMTPSA id n4sm13762379wra.37.2021.09.15.04.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 04:10:13 -0700 (PDT)
Date:   Wed, 15 Sep 2021 07:10:10 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Wu Zongyong <wuzongyong@linux.alibaba.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        wei.yang1@linux.alibaba.com
Subject: Re: [PATCH v2 4/5] vdpa: add new vdpa attribute
 VDPA_ATTR_DEV_F_VERSION_1
Message-ID: <20210915070909-mutt-send-email-mst@kernel.org>
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <cover.1631621507.git.wuzongyong@linux.alibaba.com>
 <834528d24c839080215b2e077f100e9ed5073edc.1631621507.git.wuzongyong@linux.alibaba.com>
 <20210914085711-mutt-send-email-mst@kernel.org>
 <20210915032453.GA18793@L-PF27918B-1352.localdomain>
 <20210915032732-mutt-send-email-mst@kernel.org>
 <CACGkMEumkCih51kENTiP9hpRbtKNkRJsR3MienZDtfBYVF73Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEumkCih51kENTiP9hpRbtKNkRJsR3MienZDtfBYVF73Zg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 04:05:49PM +0800, Jason Wang wrote:
> On Wed, Sep 15, 2021 at 3:31 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Sep 15, 2021 at 11:24:53AM +0800, Wu Zongyong wrote:
> > > On Tue, Sep 14, 2021 at 08:58:28AM -0400, Michael S. Tsirkin wrote:
> > > > On Tue, Sep 14, 2021 at 08:24:51PM +0800, Wu Zongyong wrote:
> > > > > This new attribute advertises whether the vdpa device is legacy or not.
> > > > > Users can pick right virtqueue size if the vdpa device is legacy which
> > > > > doesn't support to change virtqueue size.
> > > > >
> > > > > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> > > >
> > > > So if we are bothering with legacy, I think there are
> > > > several things to do when building the interface
> > > > - support transitional devices, that is allow userspace
> > > >   to tell device it's in legacy mode
> > > > - support reporting/setting supporting endian-ness
> > >
> > > It's true if we try to implement a general drvier for legacy.
> > > But this series is dedicated to implement a driver only for ENI. Is it
> > > necessary to implement what you said here in this series?
> >
> > To a certain degree, yes.
> >
> > I am thinking about the UAPI here. The new attribute is part of that.
> > E.g. userspace consuming this needs to be more or less hardware agnostic
> > and not depend on specifics of ENI.
> >
> > Otherwise if userspace assumes legacy==eni then it will break with
> > other hardware.
> >
> > One way to test how generic it all is would be adding legacy support in
> > the simulator.
> 
> I don't get why we need to support legacy devices e.g it doesn't have
> ACCESS_PLATFORM support. I think we should re-consider to mandate 1.0
> devices.
> 
> https://lore.kernel.org/lkml/20210408082648.20145-1-jasowang@redhat.com/
> 
> And it will complicate all of the different layers.
> 
> Thanks


It's not that we have to, it's just that imho, if we do
it's easier to just do it all in the kernel rather than spreading
parts of code around.

> >
> > > >
> > > > > ---
> > > > >  drivers/vdpa/vdpa.c          | 6 ++++++
> > > > >  drivers/virtio/virtio_vdpa.c | 7 ++++++-
> > > > >  include/uapi/linux/vdpa.h    | 1 +
> > > > >  3 files changed, 13 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > > > index 1dc121a07a93..533d7f589eee 100644
> > > > > --- a/drivers/vdpa/vdpa.c
> > > > > +++ b/drivers/vdpa/vdpa.c
> > > > > @@ -12,6 +12,7 @@
> > > > >  #include <linux/slab.h>
> > > > >  #include <linux/vdpa.h>
> > > > >  #include <uapi/linux/vdpa.h>
> > > > > +#include <uapi/linux/virtio_config.h>
> > > > >  #include <net/genetlink.h>
> > > > >  #include <linux/mod_devicetable.h>
> > > > >
> > > > > @@ -494,6 +495,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > > > >   u16 max_vq_size;
> > > > >   u32 device_id;
> > > > >   u32 vendor_id;
> > > > > + u64 features;
> > > > >   void *hdr;
> > > > >   int err;
> > > > >
> > > > > @@ -508,6 +510,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > > > >   device_id = vdev->config->get_device_id(vdev);
> > > > >   vendor_id = vdev->config->get_vendor_id(vdev);
> > > > >   max_vq_size = vdev->config->get_vq_num_max(vdev);
> > > > > + features = vdev->config->get_features(vdev);
> > > > >
> > > > >   err = -EMSGSIZE;
> > > > >   if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev)))
> > > > > @@ -520,6 +523,9 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > > > >           goto msg_err;
> > > > >   if (nla_put_u16(msg, VDPA_ATTR_DEV_MAX_VQ_SIZE, max_vq_size))
> > > > >           goto msg_err;
> > > > > + if (features & BIT_ULL(VIRTIO_F_VERSION_1) &&
> > > > > +     nla_put_flag(msg, VDPA_ATTR_DEV_VERSION_1))
> > > > > +         goto msg_err;
> > > > >
> > > > >   genlmsg_end(msg, hdr);
> > > > >   return 0;
> > > > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > > > > index 72eaef2caeb1..1cba957c4cdc 100644
> > > > > --- a/drivers/virtio/virtio_vdpa.c
> > > > > +++ b/drivers/virtio/virtio_vdpa.c
> > > > > @@ -7,6 +7,7 @@
> > > > >   *
> > > > >   */
> > > > >
> > > > > +#include "linux/virtio_config.h"
> > > > >  #include <linux/init.h>
> > > > >  #include <linux/module.h>
> > > > >  #include <linux/device.h>
> > > > > @@ -145,6 +146,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > > > >   /* Assume split virtqueue, switch to packed if necessary */
> > > > >   struct vdpa_vq_state state = {0};
> > > > >   unsigned long flags;
> > > > > + bool may_reduce_num = false;
> > > > >   u32 align, num;
> > > > >   int err;
> > > > >
> > > > > @@ -169,10 +171,13 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > > > >           goto error_new_virtqueue;
> > > > >   }
> > > > >
> > > > > + if (ops->get_features(vdpa) & BIT_ULL(VIRTIO_F_VERSION_1))
> > > > > +         may_reduce_num = true;
> > > > > +
> > > > >   /* Create the vring */
> > > > >   align = ops->get_vq_align(vdpa);
> > > > >   vq = vring_create_virtqueue(index, num, align, vdev,
> > > > > -                             true, true, ctx,
> > > > > +                             true, may_reduce_num, ctx,
> > > > >                               virtio_vdpa_notify, callback, name);
> > > > >   if (!vq) {
> > > > >           err = -ENOMEM;
> > > > > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > > > > index 66a41e4ec163..ce0b74276a5b 100644
> > > > > --- a/include/uapi/linux/vdpa.h
> > > > > +++ b/include/uapi/linux/vdpa.h
> > > > > @@ -32,6 +32,7 @@ enum vdpa_attr {
> > > > >   VDPA_ATTR_DEV_VENDOR_ID,                /* u32 */
> > > > >   VDPA_ATTR_DEV_MAX_VQS,                  /* u32 */
> > > > >   VDPA_ATTR_DEV_MAX_VQ_SIZE,              /* u16 */
> > > > > + VDPA_ATTR_DEV_VERSION_1,                /* flag */
> > > > >
> > > > >   /* new attributes must be added above here */
> > > > >   VDPA_ATTR_MAX,
> > > > > --
> > > > > 2.31.1
> >

