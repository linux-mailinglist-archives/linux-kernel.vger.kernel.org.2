Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5605F40C134
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 10:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236921AbhIOIIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 04:08:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29889 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236686AbhIOII3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 04:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631693231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=REa2ii1CgATX4qofCdJXzydjNOc3NGDdxA/mk8tbeG0=;
        b=LJcV7uOzTS9b9CNzXIY4W+CUvKhAii3pV3/SE3J0088OR3LQhZCmOEPsu/xZjuAh2+nV3j
        Ay2LlAH5ycRXol0sJkCUMeUhWsBI8juVlgUFBSl2ankI4Gfm7gzv5xgFlXgz50qKL2u2zm
        PVRkdn8kII1tsbAhBSwhg0tG6JIQJhQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-dJXxOvrfMYS8zqU2CoXpJw-1; Wed, 15 Sep 2021 04:07:10 -0400
X-MC-Unique: dJXxOvrfMYS8zqU2CoXpJw-1
Received: by mail-lj1-f198.google.com with SMTP id v16-20020a2e7a10000000b001ba9e312de6so1085229ljc.21
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 01:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=REa2ii1CgATX4qofCdJXzydjNOc3NGDdxA/mk8tbeG0=;
        b=Zw4VKC4C1niENS33rbdoN6Wop1L8JDsu2ksfwLVQxcr5YkaZqzUfjM3l+Q+VVQkoMK
         TJ9GBXtykzUqRpuORbIP7WaeijnQNa7CGNtikjevozzkNVmRH5yqd10rXYGJoALrMHcy
         9ZBGXm8E8eHNFl/igVWxoN0rT3VLNm9kUcway7lAR1ZUBj8a/Mpi6ld/l5/uwjN1c2Dc
         L6n4BUgti3CMy8vUsurWOaOk3sNZMwMxOtHDPziT+CgXh6J91qqDutJqnkWsMzSFhm7y
         5WzrFa6xd+VUEtZG0HfZRK9eLg1MtUg/uqUnWOqvqbrOQQaj7Hkr9IM+Eg9sQMLP8axR
         ibmA==
X-Gm-Message-State: AOAM531M+qYzDa4zu1pBAZ0vhX2OHNfg5Qn77TI9dgtPIQYNzRfXJElt
        2VkbaHj5XAvC2MZq/2OXzRn+7ChVGn6b2zjOhc1bv9LyN37Pg6qGwKiMatM9p9DBLlnvfUuSNtt
        H8d+yh+gh4Ia0pMKiUMc2fVlVZe7UEn9yp1v7GKdd
X-Received: by 2002:a2e:99d9:: with SMTP id l25mr19055207ljj.217.1631693228411;
        Wed, 15 Sep 2021 01:07:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/OTUaDJF8XN2oUz89CKGTmQEFX5ibNZhI74uDJYWh5xAbHguepl0KsOPKIoIoMojm7CM61bhf8Sgnfbc3LTc=
X-Received: by 2002:a2e:99d9:: with SMTP id l25mr19055189ljj.217.1631693228204;
 Wed, 15 Sep 2021 01:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <cover.1631621507.git.wuzongyong@linux.alibaba.com> <834528d24c839080215b2e077f100e9ed5073edc.1631621507.git.wuzongyong@linux.alibaba.com>
 <20210914085711-mutt-send-email-mst@kernel.org> <CACGkMEu3RUGpe74Vh-FAZD3MwOC3gqU0OEf8A1ULvq7GSMm6Jg@mail.gmail.com>
 <20210915033756-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210915033756-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 15 Sep 2021 16:06:57 +0800
Message-ID: <CACGkMEtN0Z=rgMhaWNO=6h-KXGdosBuOdqoWoND-=Tf+afyUYw@mail.gmail.com>
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

On Wed, Sep 15, 2021 at 3:38 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Sep 15, 2021 at 11:18:06AM +0800, Jason Wang wrote:
> > On Tue, Sep 14, 2021 at 8:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Sep 14, 2021 at 08:24:51PM +0800, Wu Zongyong wrote:
> > > > This new attribute advertises whether the vdpa device is legacy or not.
> > > > Users can pick right virtqueue size if the vdpa device is legacy which
> > > > doesn't support to change virtqueue size.
> > > >
> > > > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> > >
> > > So if we are bothering with legacy,
> >
> > I think we'd better not. I guess the following may work:
> >
> > 1) disable the driver on BE host
> > 2) present VERSION_1 with ACCESS_PLATFORM in get_features()
> > 3) extend the management to advertise max_queue_size and
> > min_queue_size, for ENI they are the same so management layer knows it
> > needs to set the queue_size correctly during launching qemu
> >
> > Thoughts?
> >
> > Thanks
>
> There are other subtle differences such as header size without
> mergeable buffers for net.

This can be solved by mandating the feature of a mergeable buffer?

Thanks

>
>
> > > I think there are
> > > several things to do when building the interface
> > > - support transitional devices, that is allow userspace
> > >   to tell device it's in legacy mode
> > > - support reporting/setting supporting endian-ness
> > >
> > > > ---
> > > >  drivers/vdpa/vdpa.c          | 6 ++++++
> > > >  drivers/virtio/virtio_vdpa.c | 7 ++++++-
> > > >  include/uapi/linux/vdpa.h    | 1 +
> > > >  3 files changed, 13 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > > index 1dc121a07a93..533d7f589eee 100644
> > > > --- a/drivers/vdpa/vdpa.c
> > > > +++ b/drivers/vdpa/vdpa.c
> > > > @@ -12,6 +12,7 @@
> > > >  #include <linux/slab.h>
> > > >  #include <linux/vdpa.h>
> > > >  #include <uapi/linux/vdpa.h>
> > > > +#include <uapi/linux/virtio_config.h>
> > > >  #include <net/genetlink.h>
> > > >  #include <linux/mod_devicetable.h>
> > > >
> > > > @@ -494,6 +495,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > > >       u16 max_vq_size;
> > > >       u32 device_id;
> > > >       u32 vendor_id;
> > > > +     u64 features;
> > > >       void *hdr;
> > > >       int err;
> > > >
> > > > @@ -508,6 +510,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > > >       device_id = vdev->config->get_device_id(vdev);
> > > >       vendor_id = vdev->config->get_vendor_id(vdev);
> > > >       max_vq_size = vdev->config->get_vq_num_max(vdev);
> > > > +     features = vdev->config->get_features(vdev);
> > > >
> > > >       err = -EMSGSIZE;
> > > >       if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev)))
> > > > @@ -520,6 +523,9 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > > >               goto msg_err;
> > > >       if (nla_put_u16(msg, VDPA_ATTR_DEV_MAX_VQ_SIZE, max_vq_size))
> > > >               goto msg_err;
> > > > +     if (features & BIT_ULL(VIRTIO_F_VERSION_1) &&
> > > > +         nla_put_flag(msg, VDPA_ATTR_DEV_VERSION_1))
> > > > +             goto msg_err;
> > > >
> > > >       genlmsg_end(msg, hdr);
> > > >       return 0;
> > > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > > > index 72eaef2caeb1..1cba957c4cdc 100644
> > > > --- a/drivers/virtio/virtio_vdpa.c
> > > > +++ b/drivers/virtio/virtio_vdpa.c
> > > > @@ -7,6 +7,7 @@
> > > >   *
> > > >   */
> > > >
> > > > +#include "linux/virtio_config.h"
> > > >  #include <linux/init.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/device.h>
> > > > @@ -145,6 +146,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > > >       /* Assume split virtqueue, switch to packed if necessary */
> > > >       struct vdpa_vq_state state = {0};
> > > >       unsigned long flags;
> > > > +     bool may_reduce_num = false;
> > > >       u32 align, num;
> > > >       int err;
> > > >
> > > > @@ -169,10 +171,13 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > > >               goto error_new_virtqueue;
> > > >       }
> > > >
> > > > +     if (ops->get_features(vdpa) & BIT_ULL(VIRTIO_F_VERSION_1))
> > > > +             may_reduce_num = true;
> > > > +
> > > >       /* Create the vring */
> > > >       align = ops->get_vq_align(vdpa);
> > > >       vq = vring_create_virtqueue(index, num, align, vdev,
> > > > -                                 true, true, ctx,
> > > > +                                 true, may_reduce_num, ctx,
> > > >                                   virtio_vdpa_notify, callback, name);
> > > >       if (!vq) {
> > > >               err = -ENOMEM;
> > > > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > > > index 66a41e4ec163..ce0b74276a5b 100644
> > > > --- a/include/uapi/linux/vdpa.h
> > > > +++ b/include/uapi/linux/vdpa.h
> > > > @@ -32,6 +32,7 @@ enum vdpa_attr {
> > > >       VDPA_ATTR_DEV_VENDOR_ID,                /* u32 */
> > > >       VDPA_ATTR_DEV_MAX_VQS,                  /* u32 */
> > > >       VDPA_ATTR_DEV_MAX_VQ_SIZE,              /* u16 */
> > > > +     VDPA_ATTR_DEV_VERSION_1,                /* flag */
> > > >
> > > >       /* new attributes must be added above here */
> > > >       VDPA_ATTR_MAX,
> > > > --
> > > > 2.31.1
> > >
>

