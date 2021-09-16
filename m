Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A8140D10F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 03:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbhIPBHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 21:07:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28220 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232389AbhIPBHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 21:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631754372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x63Yqn0DtCTzc9ERFDPUQ+PBwhc7qmVzV00IKh6bfhQ=;
        b=c/GApsqdARBmroNR4jjrWjgJ+udzzUrbBINKGM+j0JL6gPrduNQ5HkNtTeONrReir8HtpP
        rfGQJW3q+pg5K4XXv3nnX5n2bLBhsyeNOsHFhDmYWVrQR8tbYDW5IvxF7sLwenfQA5xQUr
        8aJjSPa71uaYv5ScWvyk9o3D7tsAmFM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-uaVtGEbiOcWU_gXrcFkHlw-1; Wed, 15 Sep 2021 21:06:11 -0400
X-MC-Unique: uaVtGEbiOcWU_gXrcFkHlw-1
Received: by mail-lf1-f72.google.com with SMTP id v19-20020a056512349300b003f72647edb4so2371176lfr.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 18:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x63Yqn0DtCTzc9ERFDPUQ+PBwhc7qmVzV00IKh6bfhQ=;
        b=JUFDugLlLy0ZoJgcFwQh979DKhHdiJa37GfNNDmaiBBEHCc/FUIfego7wUenX6V1vT
         4NAuCCl4mL/I4wOYcjEPbqVQCsBv2dlGTDt0P5sb2vLE5l9Y7BepKGC0VTePWhMuuJVT
         NHRAPdJMVSNV3oQQ0fmoqtS3YQGZMp2dmXch8g0h7NQ80Zo5tCsTsi73yFKjS0TzDIO9
         FWX6+KmNF1CCOtDXK/NfZgu58f90FuNSBRB6QNy86L+Jo/sjdHfxaNppBsGVz0G3oYmu
         AgdyTnJQm0RU2AhotlUOiiXeWLl2wuPw2EcJTb3Q2f4ZqsawqmX0aRyEMMF7IUuM0uof
         Knxw==
X-Gm-Message-State: AOAM532ea0jsrsyQ4AHrsfFKdPlFnv21+3qQltPt9l3b6pPypSDpszf3
        5jUpLSm/m/Z0j98521X8pIAyj5Vk4uJA2A/XD+Xjhe5gpQzQJ2yRdbQOm5CokEIo4UtMQPqLoEF
        hCZkQCn5LbvD3qu7wKlaHqERPpOTkMSRElMBMFHPc
X-Received: by 2002:ac2:5fb2:: with SMTP id s18mr2084340lfe.580.1631754369476;
        Wed, 15 Sep 2021 18:06:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLREPTBZ+yEpea8lnS1iCiKbHI40pQquw5U16RGNn37qtYRldzDq0hnokb3vg/CzcUr8urYy8bPv7gWMmHLFo=
X-Received: by 2002:ac2:5fb2:: with SMTP id s18mr2084329lfe.580.1631754369221;
 Wed, 15 Sep 2021 18:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <cover.1631621507.git.wuzongyong@linux.alibaba.com> <834528d24c839080215b2e077f100e9ed5073edc.1631621507.git.wuzongyong@linux.alibaba.com>
 <20210914085711-mutt-send-email-mst@kernel.org> <CACGkMEu3RUGpe74Vh-FAZD3MwOC3gqU0OEf8A1ULvq7GSMm6Jg@mail.gmail.com>
 <20210915033756-mutt-send-email-mst@kernel.org> <CACGkMEtN0Z=rgMhaWNO=6h-KXGdosBuOdqoWoND-=Tf+afyUYw@mail.gmail.com>
 <20210915070805-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210915070805-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 16 Sep 2021 09:05:58 +0800
Message-ID: <CACGkMEvqZqwRxjnBLpX+=MYbho0q8Hs7OZbsx4ATzhfwOkB73w@mail.gmail.com>
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

On Wed, Sep 15, 2021 at 7:09 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Sep 15, 2021 at 04:06:57PM +0800, Jason Wang wrote:
> > On Wed, Sep 15, 2021 at 3:38 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Wed, Sep 15, 2021 at 11:18:06AM +0800, Jason Wang wrote:
> > > > On Tue, Sep 14, 2021 at 8:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Tue, Sep 14, 2021 at 08:24:51PM +0800, Wu Zongyong wrote:
> > > > > > This new attribute advertises whether the vdpa device is legacy or not.
> > > > > > Users can pick right virtqueue size if the vdpa device is legacy which
> > > > > > doesn't support to change virtqueue size.
> > > > > >
> > > > > > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> > > > >
> > > > > So if we are bothering with legacy,
> > > >
> > > > I think we'd better not. I guess the following may work:
> > > >
> > > > 1) disable the driver on BE host
> > > > 2) present VERSION_1 with ACCESS_PLATFORM in get_features()
> > > > 3) extend the management to advertise max_queue_size and
> > > > min_queue_size, for ENI they are the same so management layer knows it
> > > > needs to set the queue_size correctly during launching qemu
> > > >
> > > > Thoughts?
> > > >
> > > > Thanks
> > >
> > > There are other subtle differences such as header size without
> > > mergeable buffers for net.
> >
> > This can be solved by mandating the feature of a mergeable buffer?
> >
> > Thanks
>
> PXE and some dpdk versions are only some of the guests that
> disable mergeable buffers feature.

True, but consider

1) the legacy stuffs requires changes in several software layers
2) it is how virtio 1.0 works e.g device can fail the feature negotiation
3) it is not supported since day 0
4) management API can be extended to advertise the mandated features

It looks affordable.

Thanks

>
> > >
> > >
> > > > > I think there are
> > > > > several things to do when building the interface
> > > > > - support transitional devices, that is allow userspace
> > > > >   to tell device it's in legacy mode
> > > > > - support reporting/setting supporting endian-ness
> > > > >
> > > > > > ---
> > > > > >  drivers/vdpa/vdpa.c          | 6 ++++++
> > > > > >  drivers/virtio/virtio_vdpa.c | 7 ++++++-
> > > > > >  include/uapi/linux/vdpa.h    | 1 +
> > > > > >  3 files changed, 13 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > > > > index 1dc121a07a93..533d7f589eee 100644
> > > > > > --- a/drivers/vdpa/vdpa.c
> > > > > > +++ b/drivers/vdpa/vdpa.c
> > > > > > @@ -12,6 +12,7 @@
> > > > > >  #include <linux/slab.h>
> > > > > >  #include <linux/vdpa.h>
> > > > > >  #include <uapi/linux/vdpa.h>
> > > > > > +#include <uapi/linux/virtio_config.h>
> > > > > >  #include <net/genetlink.h>
> > > > > >  #include <linux/mod_devicetable.h>
> > > > > >
> > > > > > @@ -494,6 +495,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > > > > >       u16 max_vq_size;
> > > > > >       u32 device_id;
> > > > > >       u32 vendor_id;
> > > > > > +     u64 features;
> > > > > >       void *hdr;
> > > > > >       int err;
> > > > > >
> > > > > > @@ -508,6 +510,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > > > > >       device_id = vdev->config->get_device_id(vdev);
> > > > > >       vendor_id = vdev->config->get_vendor_id(vdev);
> > > > > >       max_vq_size = vdev->config->get_vq_num_max(vdev);
> > > > > > +     features = vdev->config->get_features(vdev);
> > > > > >
> > > > > >       err = -EMSGSIZE;
> > > > > >       if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev)))
> > > > > > @@ -520,6 +523,9 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > > > > >               goto msg_err;
> > > > > >       if (nla_put_u16(msg, VDPA_ATTR_DEV_MAX_VQ_SIZE, max_vq_size))
> > > > > >               goto msg_err;
> > > > > > +     if (features & BIT_ULL(VIRTIO_F_VERSION_1) &&
> > > > > > +         nla_put_flag(msg, VDPA_ATTR_DEV_VERSION_1))
> > > > > > +             goto msg_err;
> > > > > >
> > > > > >       genlmsg_end(msg, hdr);
> > > > > >       return 0;
> > > > > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > > > > > index 72eaef2caeb1..1cba957c4cdc 100644
> > > > > > --- a/drivers/virtio/virtio_vdpa.c
> > > > > > +++ b/drivers/virtio/virtio_vdpa.c
> > > > > > @@ -7,6 +7,7 @@
> > > > > >   *
> > > > > >   */
> > > > > >
> > > > > > +#include "linux/virtio_config.h"
> > > > > >  #include <linux/init.h>
> > > > > >  #include <linux/module.h>
> > > > > >  #include <linux/device.h>
> > > > > > @@ -145,6 +146,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > > > > >       /* Assume split virtqueue, switch to packed if necessary */
> > > > > >       struct vdpa_vq_state state = {0};
> > > > > >       unsigned long flags;
> > > > > > +     bool may_reduce_num = false;
> > > > > >       u32 align, num;
> > > > > >       int err;
> > > > > >
> > > > > > @@ -169,10 +171,13 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > > > > >               goto error_new_virtqueue;
> > > > > >       }
> > > > > >
> > > > > > +     if (ops->get_features(vdpa) & BIT_ULL(VIRTIO_F_VERSION_1))
> > > > > > +             may_reduce_num = true;
> > > > > > +
> > > > > >       /* Create the vring */
> > > > > >       align = ops->get_vq_align(vdpa);
> > > > > >       vq = vring_create_virtqueue(index, num, align, vdev,
> > > > > > -                                 true, true, ctx,
> > > > > > +                                 true, may_reduce_num, ctx,
> > > > > >                                   virtio_vdpa_notify, callback, name);
> > > > > >       if (!vq) {
> > > > > >               err = -ENOMEM;
> > > > > > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > > > > > index 66a41e4ec163..ce0b74276a5b 100644
> > > > > > --- a/include/uapi/linux/vdpa.h
> > > > > > +++ b/include/uapi/linux/vdpa.h
> > > > > > @@ -32,6 +32,7 @@ enum vdpa_attr {
> > > > > >       VDPA_ATTR_DEV_VENDOR_ID,                /* u32 */
> > > > > >       VDPA_ATTR_DEV_MAX_VQS,                  /* u32 */
> > > > > >       VDPA_ATTR_DEV_MAX_VQ_SIZE,              /* u16 */
> > > > > > +     VDPA_ATTR_DEV_VERSION_1,                /* flag */
> > > > > >
> > > > > >       /* new attributes must be added above here */
> > > > > >       VDPA_ATTR_MAX,
> > > > > > --
> > > > > > 2.31.1
> > > > >
> > >
>

