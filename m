Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2196D40C4F9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhIOMNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:13:55 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:51413 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231500AbhIOMNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:13:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UoUUC9h_1631707954;
Received: from localhost(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0UoUUC9h_1631707954)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 15 Sep 2021 20:12:34 +0800
Date:   Wed, 15 Sep 2021 20:12:34 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        wei.yang1@linux.alibaba.com
Subject: Re: [PATCH v2 4/5] vdpa: add new vdpa attribute
 VDPA_ATTR_DEV_F_VERSION_1
Message-ID: <20210915121234.GA19232@L-PF27918B-1352.localdomain>
Reply-To: Wu Zongyong <wuzongyong@linux.alibaba.com>
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <cover.1631621507.git.wuzongyong@linux.alibaba.com>
 <834528d24c839080215b2e077f100e9ed5073edc.1631621507.git.wuzongyong@linux.alibaba.com>
 <20210914085711-mutt-send-email-mst@kernel.org>
 <CACGkMEu3RUGpe74Vh-FAZD3MwOC3gqU0OEf8A1ULvq7GSMm6Jg@mail.gmail.com>
 <20210915033756-mutt-send-email-mst@kernel.org>
 <CACGkMEtN0Z=rgMhaWNO=6h-KXGdosBuOdqoWoND-=Tf+afyUYw@mail.gmail.com>
 <20210915070805-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915070805-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 07:08:51AM -0400, Michael S. Tsirkin wrote:
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
> 
So what about this:

1) disable the driver on BE host
   AFAIK, there are no use cases for ENI to be used in a BE machine. So
   just disable the driver on BE machine, it will make things simper.
2) present ACCESS_PLATFORM but not VERSION_1 in get_features()
3) extend the management to advertise min_queue_size
   min_queue_size is the same as with max_queue_size for ENI.

 Another choice for 3):
   extend the management to advertise the flag F_VERSION_1 just like
   this patch
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
