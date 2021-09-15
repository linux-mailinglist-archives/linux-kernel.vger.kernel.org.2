Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A4440C421
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 13:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237405AbhIOLKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 07:10:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33345 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236794AbhIOLKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 07:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631704139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rwSpJeWdLlolu7RUvGtpN/hx6a8rehzJJNctDV0zt04=;
        b=NQXhTGhAT6DXbyQLW4VuO6eiPqMcg+ZZ9YR+LeYYUHShICnqjFgT/pyZ7xJyN1xuFvqm1O
        TPwTa3NI+C897CIa/ThKIdo6vx/htfy7/BvK6ykhIyHQ+uSOiBRaMZswgesrtSLNftMLRe
        SEW2FAJvJj+je8uJb+Yxex5cL5WDztY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-n3yYNyytOnmDxY9Jp66zTQ-1; Wed, 15 Sep 2021 07:08:56 -0400
X-MC-Unique: n3yYNyytOnmDxY9Jp66zTQ-1
Received: by mail-wm1-f72.google.com with SMTP id y12-20020a1c7d0c000000b003077f64d75fso1283173wmc.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 04:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rwSpJeWdLlolu7RUvGtpN/hx6a8rehzJJNctDV0zt04=;
        b=EegdnByz7xdi9JeCNYxnJG0weC8CTNeA9uw+/gi2ldQtGpRMe+qBcwNNKHKgH5mbkr
         t2id5363mwE0Hjjs7IMTFndv6lmiSWeA/MQ/LpWH96tGmkuRugNs2avh5n5ODApk58DZ
         weLrlI2BxzAW+VIL1IkLfCiy+ksXvQ7TDV1WOP7lCxQ1B7L4XGSPYnLC8OwpF2G2Fevh
         qtcMlpEA7A33WzGwYl+Hr4+zG1cYkvJmrqwDRAL4G+9MOnHR8Lvm/2/6EXF55b6rWisL
         tN382UOQY1/N04cCT6Qcodqebe+/mNd3VAF1M+pi8xZUpA+Ns2FHdmT9hS47fzAps3U8
         Aqzw==
X-Gm-Message-State: AOAM531WbDVl1daN72j7pm8DsnfNtZZYU7zXwzQWAcHlPdjKDJwyAnfJ
        BL2Y7WK6LC21vZ7EENGIPxmHxX4U7Ehhzi+/8/GvcPHXuQc7MB0cfXm6myko67rt651SY0yagr5
        IkypHjzcVg/p5bSdPdlhWeI4V
X-Received: by 2002:adf:fd92:: with SMTP id d18mr4445685wrr.28.1631704135002;
        Wed, 15 Sep 2021 04:08:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw19IYcrbCuItCWOZsHEigBfMYOr25YPfjpVI8g6T2GKT80qXcm0/6LEn+7XmdHr1maZdhUYA==
X-Received: by 2002:adf:fd92:: with SMTP id d18mr4445667wrr.28.1631704134818;
        Wed, 15 Sep 2021 04:08:54 -0700 (PDT)
Received: from redhat.com ([2.55.157.56])
        by smtp.gmail.com with ESMTPSA id y8sm6207663wrh.44.2021.09.15.04.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 04:08:54 -0700 (PDT)
Date:   Wed, 15 Sep 2021 07:08:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Wu Zongyong <wuzongyong@linux.alibaba.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        wei.yang1@linux.alibaba.com
Subject: Re: [PATCH v2 4/5] vdpa: add new vdpa attribute
 VDPA_ATTR_DEV_F_VERSION_1
Message-ID: <20210915070805-mutt-send-email-mst@kernel.org>
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <cover.1631621507.git.wuzongyong@linux.alibaba.com>
 <834528d24c839080215b2e077f100e9ed5073edc.1631621507.git.wuzongyong@linux.alibaba.com>
 <20210914085711-mutt-send-email-mst@kernel.org>
 <CACGkMEu3RUGpe74Vh-FAZD3MwOC3gqU0OEf8A1ULvq7GSMm6Jg@mail.gmail.com>
 <20210915033756-mutt-send-email-mst@kernel.org>
 <CACGkMEtN0Z=rgMhaWNO=6h-KXGdosBuOdqoWoND-=Tf+afyUYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEtN0Z=rgMhaWNO=6h-KXGdosBuOdqoWoND-=Tf+afyUYw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 04:06:57PM +0800, Jason Wang wrote:
> On Wed, Sep 15, 2021 at 3:38 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Sep 15, 2021 at 11:18:06AM +0800, Jason Wang wrote:
> > > On Tue, Sep 14, 2021 at 8:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Sep 14, 2021 at 08:24:51PM +0800, Wu Zongyong wrote:
> > > > > This new attribute advertises whether the vdpa device is legacy or not.
> > > > > Users can pick right virtqueue size if the vdpa device is legacy which
> > > > > doesn't support to change virtqueue size.
> > > > >
> > > > > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> > > >
> > > > So if we are bothering with legacy,
> > >
> > > I think we'd better not. I guess the following may work:
> > >
> > > 1) disable the driver on BE host
> > > 2) present VERSION_1 with ACCESS_PLATFORM in get_features()
> > > 3) extend the management to advertise max_queue_size and
> > > min_queue_size, for ENI they are the same so management layer knows it
> > > needs to set the queue_size correctly during launching qemu
> > >
> > > Thoughts?
> > >
> > > Thanks
> >
> > There are other subtle differences such as header size without
> > mergeable buffers for net.
> 
> This can be solved by mandating the feature of a mergeable buffer?
> 
> Thanks

PXE and some dpdk versions are only some of the guests that
disable mergeable buffers feature.

> >
> >
> > > > I think there are
> > > > several things to do when building the interface
> > > > - support transitional devices, that is allow userspace
> > > >   to tell device it's in legacy mode
> > > > - support reporting/setting supporting endian-ness
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
> > > > >       u16 max_vq_size;
> > > > >       u32 device_id;
> > > > >       u32 vendor_id;
> > > > > +     u64 features;
> > > > >       void *hdr;
> > > > >       int err;
> > > > >
> > > > > @@ -508,6 +510,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > > > >       device_id = vdev->config->get_device_id(vdev);
> > > > >       vendor_id = vdev->config->get_vendor_id(vdev);
> > > > >       max_vq_size = vdev->config->get_vq_num_max(vdev);
> > > > > +     features = vdev->config->get_features(vdev);
> > > > >
> > > > >       err = -EMSGSIZE;
> > > > >       if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev)))
> > > > > @@ -520,6 +523,9 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > > > >               goto msg_err;
> > > > >       if (nla_put_u16(msg, VDPA_ATTR_DEV_MAX_VQ_SIZE, max_vq_size))
> > > > >               goto msg_err;
> > > > > +     if (features & BIT_ULL(VIRTIO_F_VERSION_1) &&
> > > > > +         nla_put_flag(msg, VDPA_ATTR_DEV_VERSION_1))
> > > > > +             goto msg_err;
> > > > >
> > > > >       genlmsg_end(msg, hdr);
> > > > >       return 0;
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
> > > > >       /* Assume split virtqueue, switch to packed if necessary */
> > > > >       struct vdpa_vq_state state = {0};
> > > > >       unsigned long flags;
> > > > > +     bool may_reduce_num = false;
> > > > >       u32 align, num;
> > > > >       int err;
> > > > >
> > > > > @@ -169,10 +171,13 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > > > >               goto error_new_virtqueue;
> > > > >       }
> > > > >
> > > > > +     if (ops->get_features(vdpa) & BIT_ULL(VIRTIO_F_VERSION_1))
> > > > > +             may_reduce_num = true;
> > > > > +
> > > > >       /* Create the vring */
> > > > >       align = ops->get_vq_align(vdpa);
> > > > >       vq = vring_create_virtqueue(index, num, align, vdev,
> > > > > -                                 true, true, ctx,
> > > > > +                                 true, may_reduce_num, ctx,
> > > > >                                   virtio_vdpa_notify, callback, name);
> > > > >       if (!vq) {
> > > > >               err = -ENOMEM;
> > > > > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > > > > index 66a41e4ec163..ce0b74276a5b 100644
> > > > > --- a/include/uapi/linux/vdpa.h
> > > > > +++ b/include/uapi/linux/vdpa.h
> > > > > @@ -32,6 +32,7 @@ enum vdpa_attr {
> > > > >       VDPA_ATTR_DEV_VENDOR_ID,                /* u32 */
> > > > >       VDPA_ATTR_DEV_MAX_VQS,                  /* u32 */
> > > > >       VDPA_ATTR_DEV_MAX_VQ_SIZE,              /* u16 */
> > > > > +     VDPA_ATTR_DEV_VERSION_1,                /* flag */
> > > > >
> > > > >       /* new attributes must be added above here */
> > > > >       VDPA_ATTR_MAX,
> > > > > --
> > > > > 2.31.1
> > > >
> >

