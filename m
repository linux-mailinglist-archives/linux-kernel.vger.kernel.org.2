Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9FD40BE1D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 05:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbhIODUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 23:20:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31229 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229957AbhIODTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 23:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631675900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G9OTi+I6mElAnVtqWJXABEPv/vr+kKCZOit8WTNNJF8=;
        b=V79Q6x4WGO4LpM9kZliPm7V6JVYl8rancZm7CdAzqfWWhepRQqXlSGXh837dDhnpjtTwt3
        SXhIiJhxg86cMoc3IiWHBH7TGldUrzTdbCMyHEimiEK5eByBw7Z57DDL/KKLQheVCHkUhr
        0v5ItkWJ+TLTOB6f9gVaMtQSRGjqSbU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-2mHuqm_VPs-g-nv49hynNw-1; Tue, 14 Sep 2021 23:18:19 -0400
X-MC-Unique: 2mHuqm_VPs-g-nv49hynNw-1
Received: by mail-lj1-f200.google.com with SMTP id h15-20020a2e530f000000b001efaf55b4ddso786907ljb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 20:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G9OTi+I6mElAnVtqWJXABEPv/vr+kKCZOit8WTNNJF8=;
        b=vWKf1NmSNBh/YzrZ+EUTl8+9a0nyeMb9eFszjfKSjCZTm9kBhORhNy/VH5MzyVlHld
         x/wNpKWnOiASDsMa+OImjCrEIvGdUduZuKhqY8bfWAl7qFajAt05S+sMQZjeGsqLGwpE
         5rzQyKV6UzNu7eozt0v4CzV0Zunzj3zuvYMPx0ZBkSV1ZbAuGpeJvq7vRqmhZ8ZkTHbW
         EtLaGNm/A+SWXqNYJqAwhfQBM3Ker/3Zrk22humDGdfHdJDgDO9GxmDuwNGaTx/44hZ9
         cUDterhxlad1GFbOBaKNSXjHlUYhNnO20t6FbVPmUniqBuIV9Td6Gpl5Pbn0GEq+BmFE
         6+VA==
X-Gm-Message-State: AOAM5334NCv15GO9WqfbN8UnbkV0oBruQNXJj+jvkGEgckAR4TSllJeZ
        mZhL5qwhhUHohvZDdPn7vuFwvSVuQepxuyDtttpSGYNdnW9hYhPgRxvkNLeFH4ceWXR4ev0+bZY
        M68q/P3c7PqD2E5k0rTuqJxzPVSgQa3tEtWxnc66O
X-Received: by 2002:a05:6512:110b:: with SMTP id l11mr15482564lfg.199.1631675897629;
        Tue, 14 Sep 2021 20:18:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxViT8vFiqnR4GYSzaBHxKHxPutxAUmMnRBJ8kFY85O+uo5Tk3lj53Fwai7Z6rjx0PWRSkkVW15fi6Tsfj9y44=
X-Received: by 2002:a05:6512:110b:: with SMTP id l11mr15482553lfg.199.1631675897429;
 Tue, 14 Sep 2021 20:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <cover.1631621507.git.wuzongyong@linux.alibaba.com> <834528d24c839080215b2e077f100e9ed5073edc.1631621507.git.wuzongyong@linux.alibaba.com>
 <20210914085711-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210914085711-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 15 Sep 2021 11:18:06 +0800
Message-ID: <CACGkMEu3RUGpe74Vh-FAZD3MwOC3gqU0OEf8A1ULvq7GSMm6Jg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] vdpa: add new vdpa attribute VDPA_ATTR_DEV_F_VERSION_1
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Wu Zongyong <wuzongyong@linux.alibaba.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        wei.yang1@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 8:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Sep 14, 2021 at 08:24:51PM +0800, Wu Zongyong wrote:
> > This new attribute advertises whether the vdpa device is legacy or not.
> > Users can pick right virtqueue size if the vdpa device is legacy which
> > doesn't support to change virtqueue size.
> >
> > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
>
> So if we are bothering with legacy,

I think we'd better not. I guess the following may work:

1) disable the driver on BE host
2) present VERSION_1 with ACCESS_PLATFORM in get_features()
3) extend the management to advertise max_queue_size and
min_queue_size, for ENI they are the same so management layer knows it
needs to set the queue_size correctly during launching qemu

Thoughts?

Thanks

> I think there are
> several things to do when building the interface
> - support transitional devices, that is allow userspace
>   to tell device it's in legacy mode
> - support reporting/setting supporting endian-ness
>
> > ---
> >  drivers/vdpa/vdpa.c          | 6 ++++++
> >  drivers/virtio/virtio_vdpa.c | 7 ++++++-
> >  include/uapi/linux/vdpa.h    | 1 +
> >  3 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > index 1dc121a07a93..533d7f589eee 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/vdpa.h>
> >  #include <uapi/linux/vdpa.h>
> > +#include <uapi/linux/virtio_config.h>
> >  #include <net/genetlink.h>
> >  #include <linux/mod_devicetable.h>
> >
> > @@ -494,6 +495,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> >       u16 max_vq_size;
> >       u32 device_id;
> >       u32 vendor_id;
> > +     u64 features;
> >       void *hdr;
> >       int err;
> >
> > @@ -508,6 +510,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> >       device_id = vdev->config->get_device_id(vdev);
> >       vendor_id = vdev->config->get_vendor_id(vdev);
> >       max_vq_size = vdev->config->get_vq_num_max(vdev);
> > +     features = vdev->config->get_features(vdev);
> >
> >       err = -EMSGSIZE;
> >       if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev)))
> > @@ -520,6 +523,9 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> >               goto msg_err;
> >       if (nla_put_u16(msg, VDPA_ATTR_DEV_MAX_VQ_SIZE, max_vq_size))
> >               goto msg_err;
> > +     if (features & BIT_ULL(VIRTIO_F_VERSION_1) &&
> > +         nla_put_flag(msg, VDPA_ATTR_DEV_VERSION_1))
> > +             goto msg_err;
> >
> >       genlmsg_end(msg, hdr);
> >       return 0;
> > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > index 72eaef2caeb1..1cba957c4cdc 100644
> > --- a/drivers/virtio/virtio_vdpa.c
> > +++ b/drivers/virtio/virtio_vdpa.c
> > @@ -7,6 +7,7 @@
> >   *
> >   */
> >
> > +#include "linux/virtio_config.h"
> >  #include <linux/init.h>
> >  #include <linux/module.h>
> >  #include <linux/device.h>
> > @@ -145,6 +146,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> >       /* Assume split virtqueue, switch to packed if necessary */
> >       struct vdpa_vq_state state = {0};
> >       unsigned long flags;
> > +     bool may_reduce_num = false;
> >       u32 align, num;
> >       int err;
> >
> > @@ -169,10 +171,13 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> >               goto error_new_virtqueue;
> >       }
> >
> > +     if (ops->get_features(vdpa) & BIT_ULL(VIRTIO_F_VERSION_1))
> > +             may_reduce_num = true;
> > +
> >       /* Create the vring */
> >       align = ops->get_vq_align(vdpa);
> >       vq = vring_create_virtqueue(index, num, align, vdev,
> > -                                 true, true, ctx,
> > +                                 true, may_reduce_num, ctx,
> >                                   virtio_vdpa_notify, callback, name);
> >       if (!vq) {
> >               err = -ENOMEM;
> > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > index 66a41e4ec163..ce0b74276a5b 100644
> > --- a/include/uapi/linux/vdpa.h
> > +++ b/include/uapi/linux/vdpa.h
> > @@ -32,6 +32,7 @@ enum vdpa_attr {
> >       VDPA_ATTR_DEV_VENDOR_ID,                /* u32 */
> >       VDPA_ATTR_DEV_MAX_VQS,                  /* u32 */
> >       VDPA_ATTR_DEV_MAX_VQ_SIZE,              /* u16 */
> > +     VDPA_ATTR_DEV_VERSION_1,                /* flag */
> >
> >       /* new attributes must be added above here */
> >       VDPA_ATTR_MAX,
> > --
> > 2.31.1
>

