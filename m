Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C924046B1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 10:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhIIIER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 04:04:17 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:56389 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229609AbhIIIDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 04:03:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UnmQXzb_1631174516;
Received: from localhost(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0UnmQXzb_1631174516)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 09 Sep 2021 16:01:56 +0800
Date:   Thu, 9 Sep 2021 16:01:57 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mst <mst@redhat.com>, wei.yang1@linux.alibaba.com
Subject: Re: [PATCH 5/6] vdpa: add get_vq_num_unchangeable callback in
 vdpa_config_ops
Message-ID: <20210909080157.GA17383@L-PF27918B-1352.localdomain>
Reply-To: Wu Zongyong <wuzongyong@linux.alibaba.com>
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <ebd83066e3897aae63e4b02f8729a73dd09931c6.1631101392.git.wuzongyong@linux.alibaba.com>
 <CACGkMEtAZg+Nkx_1WJAP2=xQ6o6G9Vd=xYvFmR6YRp8vBg2Tqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEtAZg+Nkx_1WJAP2=xQ6o6G9Vd=xYvFmR6YRp8vBg2Tqg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 10:55:03AM +0800, Jason Wang wrote:
> On Wed, Sep 8, 2021 at 8:23 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
> >
> > This new callback is used to indicate whether the vring size can be
> > change or not. It is useful when we have a legacy virtio pci device as
> > the vdpa device for there is no way to negotiate the vring num by the
> > specification.
> 
> So I'm not sure it's worth bothering. E.g what if we just fail
> VHOST_SET_VRING_NUM it the value doesn't match what hardware has?
> 
> Thanks
> 
I think we should not call VHOST_SET_VRING_NUM in that case.

If the hardware reports that the virtqueue size cannot be changed, we
should call VHOST_GET_VRING_NUM to get the static virtqueue size
firstly, then allocate the same size memory for the virtqueues and write
the address to hardware finally.

For QEMU, we will ignore the properties rx/tx_queue_size and just get it
from the hardware if this new callback return true.

What do you think?
> >
> > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> > ---
> >  drivers/vhost/vdpa.c         | 19 +++++++++++++++++++
> >  drivers/virtio/virtio_vdpa.c |  5 ++++-
> >  include/linux/vdpa.h         |  4 ++++
> >  include/uapi/linux/vhost.h   |  2 ++
> >  4 files changed, 29 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index 9479f7f79217..2204d27d1e5d 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -350,6 +350,22 @@ static long vhost_vdpa_get_iova_range(struct vhost_vdpa *v, u32 __user *argp)
> >         return 0;
> >  }
> >
> > +static long vhost_vdpa_get_vring_num_unchangeable(struct vhost_vdpa *v,
> > +                                                 u32 __user *argp)
> > +{
> > +       struct vdpa_device *vdpa = v->vdpa;
> > +       const struct vdpa_config_ops *ops = vdpa->config;
> > +       bool unchangeable = false;
> > +
> > +       if (ops->get_vq_num_unchangeable)
> > +               unchangeable = ops->get_vq_num_unchangeable(vdpa);
> > +
> > +       if (copy_to_user(argp, &unchangeable, sizeof(unchangeable)))
> > +               return -EFAULT;
> > +
> > +       return 0;
> > +}
> > +
> >  static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
> >                                    void __user *argp)
> >  {
> > @@ -487,6 +503,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
> >         case VHOST_VDPA_GET_IOVA_RANGE:
> >                 r = vhost_vdpa_get_iova_range(v, argp);
> >                 break;
> > +       case VHOST_VDPA_GET_VRING_NUM_UNCHANGEABLE:
> > +               r = vhost_vdpa_get_vring_num_unchangeable(v, argp);
> > +               break;
> >         default:
> >                 r = vhost_dev_ioctl(&v->vdev, cmd, argp);
> >                 if (r == -ENOIOCTLCMD)
> > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > index 72eaef2caeb1..afb47465307a 100644
> > --- a/drivers/virtio/virtio_vdpa.c
> > +++ b/drivers/virtio/virtio_vdpa.c
> > @@ -146,6 +146,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> >         struct vdpa_vq_state state = {0};
> >         unsigned long flags;
> >         u32 align, num;
> > +       bool may_reduce_num = true;
> >         int err;
> >
> >         if (!name)
> > @@ -171,8 +172,10 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> >
> >         /* Create the vring */
> >         align = ops->get_vq_align(vdpa);
> > +       if (ops->get_vq_num_unchangeable)
> > +               may_reduce_num = !ops->get_vq_num_unchangeable(vdpa);
> >         vq = vring_create_virtqueue(index, num, align, vdev,
> > -                                   true, true, ctx,
> > +                                   true, may_reduce_num, ctx,
> >                                     virtio_vdpa_notify, callback, name);
> >         if (!vq) {
> >                 err = -ENOMEM;
> > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > index 35648c11e312..f809b7ada00d 100644
> > --- a/include/linux/vdpa.h
> > +++ b/include/linux/vdpa.h
> > @@ -195,6 +195,9 @@ struct vdpa_iova_range {
> >   *                             @vdev: vdpa device
> >   *                             Returns the iova range supported by
> >   *                             the device.
> > + * @get_vq_num_unchangeable    Check if size of virtqueue is unchangeable (optional)
> > + *                             @vdev: vdpa device
> > + *                             Returns boolean: unchangeable (true) or not (false)
> >   * @set_map:                   Set device memory mapping (optional)
> >   *                             Needed for device that using device
> >   *                             specific DMA translation (on-chip IOMMU)
> > @@ -262,6 +265,7 @@ struct vdpa_config_ops {
> >                            const void *buf, unsigned int len);
> >         u32 (*get_generation)(struct vdpa_device *vdev);
> >         struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev);
> > +       bool (*get_vq_num_unchangeable)(struct vdpa_device *vdev);
> >
> >         /* DMA ops */
> >         int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb *iotlb);
> > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > index c998860d7bbc..184f1f7f8498 100644
> > --- a/include/uapi/linux/vhost.h
> > +++ b/include/uapi/linux/vhost.h
> > @@ -150,4 +150,6 @@
> >  /* Get the valid iova range */
> >  #define VHOST_VDPA_GET_IOVA_RANGE      _IOR(VHOST_VIRTIO, 0x78, \
> >                                              struct vhost_vdpa_iova_range)
> > +/* Check if the vring size can be change */
> > +#define VHOST_VDPA_GET_VRING_NUM_UNCHANGEABLE _IOR(VHOST_VIRTIO, 0X79, bool)
> >  #endif
> > --
> > 2.31.1
> >
