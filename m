Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E462B40D116
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 03:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbhIPBMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 21:12:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44275 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231335AbhIPBMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 21:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631754693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=74EoAWXmDLcPB3Fwyw9DAw7gIYO7nWQCSI4r7V+M3G4=;
        b=bwVgtzzGhYIOfVt39zH7eNUsm9vc68P/Edyq/QUUiUEDLGxyFirqcWSKSrlT/rqLNWRdZ+
        g52jQ2Szr5gv2GOCihucFhTjpoi9PrFEwu7a+gZiCJDSc2HjK3A2WjaDgP1OaZJNjkP5/Z
        nmd9n17zKp1uCc9LcEy+krUBuemzNc0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-n56PSBDTM2mguvxBCs-crA-1; Wed, 15 Sep 2021 21:11:32 -0400
X-MC-Unique: n56PSBDTM2mguvxBCs-crA-1
Received: by mail-lf1-f70.google.com with SMTP id v19-20020a056512349300b003f72647edb4so2380525lfr.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 18:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=74EoAWXmDLcPB3Fwyw9DAw7gIYO7nWQCSI4r7V+M3G4=;
        b=WXTw5eJWJuopEnY1k5Lf83l+PYUzDmgj7alvWMtz24JGgROEFVhvHEBngmOOnCaGmw
         3Bxhf8uSISc8OYCkS8EMtBmIJtqjNSzoMCMRso+kq1CuhTT6aJ5TC5yEz3W7uZl5qTC5
         V1+sLhzymjPmj10rOZcB8yrRIGg2BGJ6DUEVD3Ov2PwdRENfzlo0pDWrzcD3Op9jyTOr
         EG+8cwzonlMQiWInYq5FzwN/067RMm2w6UAHvJGZsZdrvXKzy/kYw8Cfiy/qI0guGhUv
         q27ypFOXGSsX0SAVNV54S7SMY48vU8bRH6dWXFIfxxGCIfSXuba7vLrau40bU5q8wS1a
         UyAw==
X-Gm-Message-State: AOAM532cQQS9UhpblRsnMIpGZJavt+40ylMnj5c3oWDZffRODIf2jzXn
        6pc8ye/OssNX16JA+SZslPok/75QtiK/uhdkwekTfbcLoz0S4If0gdqyYQCDx/9/4Dh88Rz1QQV
        l/4Ivo97B6E6RB1MD/ZcLsqSSmdDrnQoDMe0342qF
X-Received: by 2002:a05:6512:32ca:: with SMTP id f10mr2106908lfg.498.1631754690412;
        Wed, 15 Sep 2021 18:11:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxP1/lkCjy0c5KBp7+YpaUFk/F4bQxl89FXrFCbmOGahKvr7nn8im10RqULlylwzHu2Ebfx6BUAmWntkN5RCR4=
X-Received: by 2002:a05:6512:32ca:: with SMTP id f10mr2106898lfg.498.1631754690171;
 Wed, 15 Sep 2021 18:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <cover.1631621507.git.wuzongyong@linux.alibaba.com> <834528d24c839080215b2e077f100e9ed5073edc.1631621507.git.wuzongyong@linux.alibaba.com>
 <20210914085711-mutt-send-email-mst@kernel.org> <CACGkMEu3RUGpe74Vh-FAZD3MwOC3gqU0OEf8A1ULvq7GSMm6Jg@mail.gmail.com>
 <20210915033756-mutt-send-email-mst@kernel.org> <CACGkMEtN0Z=rgMhaWNO=6h-KXGdosBuOdqoWoND-=Tf+afyUYw@mail.gmail.com>
 <20210915070805-mutt-send-email-mst@kernel.org> <20210915121234.GA19232@L-PF27918B-1352.localdomain>
In-Reply-To: <20210915121234.GA19232@L-PF27918B-1352.localdomain>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 16 Sep 2021 09:11:19 +0800
Message-ID: <CACGkMEuJ_OpprwUDBtK0_QgNNp=xaKFEVhEmrCStBhM67WiQvg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] vdpa: add new vdpa attribute VDPA_ATTR_DEV_F_VERSION_1
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        wei.yang1@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 8:12 PM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> On Wed, Sep 15, 2021 at 07:08:51AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Sep 15, 2021 at 04:06:57PM +0800, Jason Wang wrote:
> > > On Wed, Sep 15, 2021 at 3:38 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Wed, Sep 15, 2021 at 11:18:06AM +0800, Jason Wang wrote:
> > > > > On Tue, Sep 14, 2021 at 8:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Sep 14, 2021 at 08:24:51PM +0800, Wu Zongyong wrote:
> > > > > > > This new attribute advertises whether the vdpa device is legacy or not.
> > > > > > > Users can pick right virtqueue size if the vdpa device is legacy which
> > > > > > > doesn't support to change virtqueue size.
> > > > > > >
> > > > > > > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> > > > > >
> > > > > > So if we are bothering with legacy,
> > > > >
> > > > > I think we'd better not. I guess the following may work:
> > > > >
> > > > > 1) disable the driver on BE host
> > > > > 2) present VERSION_1 with ACCESS_PLATFORM in get_features()
> > > > > 3) extend the management to advertise max_queue_size and
> > > > > min_queue_size, for ENI they are the same so management layer knows it
> > > > > needs to set the queue_size correctly during launching qemu
> > > > >
> > > > > Thoughts?
> > > > >
> > > > > Thanks
> > > >
> > > > There are other subtle differences such as header size without
> > > > mergeable buffers for net.
> > >
> > > This can be solved by mandating the feature of a mergeable buffer?
> > >
> > > Thanks
> >
> > PXE and some dpdk versions are only some of the guests that
> > disable mergeable buffers feature.
> >
> So what about this:
>
> 1) disable the driver on BE host
>    AFAIK, there are no use cases for ENI to be used in a BE machine. So
>    just disable the driver on BE machine, it will make things simper.
> 2) present ACCESS_PLATFORM but not VERSION_1 in get_features()

This sounds like a violation of the virtio spec. ACCESS_PLATFORM
depends on VERSION_1.

> 3) extend the management to advertise min_queue_size
>    min_queue_size is the same as with max_queue_size for ENI.
>
>  Another choice for 3):
>    extend the management to advertise the flag F_VERSION_1 just like
>    this patch

This will bring a lot of trouble, notice that the legacy/transitional
device doesn't work in several layers (both vdpa kernel and qemu).

If we can afford mandating mergeable rx buffers in the driver, it's
the most simple way.

I guess you should have the plan for the next generation ENI which
should support VERSION_1 and RING_PACKED.

Thanks

> > > >
> > > >
> > > > > > I think there are
> > > > > > several things to do when building the interface
> > > > > > - support transitional devices, that is allow userspace
> > > > > >   to tell device it's in legacy mode
> > > > > > - support reporting/setting supporting endian-ness
> > > > > >
> > > > > > > ---
> > > > > > >  drivers/vdpa/vdpa.c          | 6 ++++++
> > > > > > >  drivers/virtio/virtio_vdpa.c | 7 ++++++-
> > > > > > >  include/uapi/linux/vdpa.h    | 1 +
> > > > > > >  3 files changed, 13 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > > > > > index 1dc121a07a93..533d7f589eee 100644
> > > > > > > --- a/drivers/vdpa/vdpa.c
> > > > > > > +++ b/drivers/vdpa/vdpa.c
> > > > > > > @@ -12,6 +12,7 @@
> > > > > > >  #include <linux/slab.h>
> > > > > > >  #include <linux/vdpa.h>
> > > > > > >  #include <uapi/linux/vdpa.h>
> > > > > > > +#include <uapi/linux/virtio_config.h>
> > > > > > >  #include <net/genetlink.h>
> > > > > > >  #include <linux/mod_devicetable.h>
> > > > > > >
> > > > > > > @@ -494,6 +495,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > > > > > >       u16 max_vq_size;
> > > > > > >       u32 device_id;
> > > > > > >       u32 vendor_id;
> > > > > > > +     u64 features;
> > > > > > >       void *hdr;
> > > > > > >       int err;
> > > > > > >
> > > > > > > @@ -508,6 +510,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > > > > > >       device_id = vdev->config->get_device_id(vdev);
> > > > > > >       vendor_id = vdev->config->get_vendor_id(vdev);
> > > > > > >       max_vq_size = vdev->config->get_vq_num_max(vdev);
> > > > > > > +     features = vdev->config->get_features(vdev);
> > > > > > >
> > > > > > >       err = -EMSGSIZE;
> > > > > > >       if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev)))
> > > > > > > @@ -520,6 +523,9 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > > > > > >               goto msg_err;
> > > > > > >       if (nla_put_u16(msg, VDPA_ATTR_DEV_MAX_VQ_SIZE, max_vq_size))
> > > > > > >               goto msg_err;
> > > > > > > +     if (features & BIT_ULL(VIRTIO_F_VERSION_1) &&
> > > > > > > +         nla_put_flag(msg, VDPA_ATTR_DEV_VERSION_1))
> > > > > > > +             goto msg_err;
> > > > > > >
> > > > > > >       genlmsg_end(msg, hdr);
> > > > > > >       return 0;
> > > > > > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > > > > > > index 72eaef2caeb1..1cba957c4cdc 100644
> > > > > > > --- a/drivers/virtio/virtio_vdpa.c
> > > > > > > +++ b/drivers/virtio/virtio_vdpa.c
> > > > > > > @@ -7,6 +7,7 @@
> > > > > > >   *
> > > > > > >   */
> > > > > > >
> > > > > > > +#include "linux/virtio_config.h"
> > > > > > >  #include <linux/init.h>
> > > > > > >  #include <linux/module.h>
> > > > > > >  #include <linux/device.h>
> > > > > > > @@ -145,6 +146,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > > > > > >       /* Assume split virtqueue, switch to packed if necessary */
> > > > > > >       struct vdpa_vq_state state = {0};
> > > > > > >       unsigned long flags;
> > > > > > > +     bool may_reduce_num = false;
> > > > > > >       u32 align, num;
> > > > > > >       int err;
> > > > > > >
> > > > > > > @@ -169,10 +171,13 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > > > > > >               goto error_new_virtqueue;
> > > > > > >       }
> > > > > > >
> > > > > > > +     if (ops->get_features(vdpa) & BIT_ULL(VIRTIO_F_VERSION_1))
> > > > > > > +             may_reduce_num = true;
> > > > > > > +
> > > > > > >       /* Create the vring */
> > > > > > >       align = ops->get_vq_align(vdpa);
> > > > > > >       vq = vring_create_virtqueue(index, num, align, vdev,
> > > > > > > -                                 true, true, ctx,
> > > > > > > +                                 true, may_reduce_num, ctx,
> > > > > > >                                   virtio_vdpa_notify, callback, name);
> > > > > > >       if (!vq) {
> > > > > > >               err = -ENOMEM;
> > > > > > > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > > > > > > index 66a41e4ec163..ce0b74276a5b 100644
> > > > > > > --- a/include/uapi/linux/vdpa.h
> > > > > > > +++ b/include/uapi/linux/vdpa.h
> > > > > > > @@ -32,6 +32,7 @@ enum vdpa_attr {
> > > > > > >       VDPA_ATTR_DEV_VENDOR_ID,                /* u32 */
> > > > > > >       VDPA_ATTR_DEV_MAX_VQS,                  /* u32 */
> > > > > > >       VDPA_ATTR_DEV_MAX_VQ_SIZE,              /* u16 */
> > > > > > > +     VDPA_ATTR_DEV_VERSION_1,                /* flag */
> > > > > > >
> > > > > > >       /* new attributes must be added above here */
> > > > > > >       VDPA_ATTR_MAX,
> > > > > > > --
> > > > > > > 2.31.1
> > > > > >
> > > >
>

