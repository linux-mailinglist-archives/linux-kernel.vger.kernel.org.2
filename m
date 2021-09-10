Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F51340655D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 03:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhIJBrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 21:47:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38280 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229445AbhIJBrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 21:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631238367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h4d3ZouMs1oCIWyT6NORWIEkWnwsqSrS0lV7Sg6z5y8=;
        b=F80oKNOylvpB4KYq9iVGKi+ix/wBREX+FaYWGrokA+JUEOkA/X8xYITPLdDL0/AUP5h1xo
        mSPdUI9+TYQo8btJ26Ogm0Mst1OxdLHsXe7wdn4hb31JXV01BxRZ6IL7w82TbAqjl/wgsw
        5VALXQIPpX9ZClvH3eBbiZtsRf0tG4M=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-i0R9YjsPPGaFcGM8bxBXZQ-1; Thu, 09 Sep 2021 21:46:06 -0400
X-MC-Unique: i0R9YjsPPGaFcGM8bxBXZQ-1
Received: by mail-lj1-f200.google.com with SMTP id p11-20020a2ea40b000000b001d68cffb055so164990ljn.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 18:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h4d3ZouMs1oCIWyT6NORWIEkWnwsqSrS0lV7Sg6z5y8=;
        b=ypDsTbWVBzeaiMk9Vz9sEMg/Z3rY/iXzGZ410B74iee6SVbd4lDO8p3NLBt7h1BLwD
         iqtnToGDXUsWgPpE1RLPytfyvt1dDkKn5XPOY6alOkIiIDTVoHVP54DiAhIPUZmF3m1G
         Tr2KtclmSluVDHFcTQkRAd5v3YkXsmQKj4Nyh5K87JcT3JvIsaykuh+eGRbydUOG6EsP
         pokqIwH864MU7BQDSFn1LdqMpcF0doW72WLQ50tXlxrkLTv7KB+RhktXHBQpOE47dY94
         OzIM1r9Gi3ft/yDtNY/UKRFuurw95cMqF+12sFJVH6EFYOBb4KNePTAwkjNIyoP6oy9T
         /LlA==
X-Gm-Message-State: AOAM533knLjXHRl0zEoj+HG9YgMnVhO8wDKy25fcSEDji8q7XYYvxCCw
        ucSTjH0tUN2AOzEZZyPPWAA7gpEs0LU/+EeKQt8dOOunhbsTJjnHImMY6HhUFw0cHqR3OTwsznk
        mltZ8KRwasf8HgGVw9WNyCUQqvzXXhbr4jsPrn9d8
X-Received: by 2002:ac2:5fc5:: with SMTP id q5mr1952932lfg.629.1631238364937;
        Thu, 09 Sep 2021 18:46:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4cIfLofZ3nm4xRXUKLs6yQbiHoLXi9ORlmp4EB1F4qHNvnhR1opsbdvCu/fHrxeLpNXupxYWojAGgZl+bbqE=
X-Received: by 2002:ac2:5fc5:: with SMTP id q5mr1952924lfg.629.1631238364721;
 Thu, 09 Sep 2021 18:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <ebd83066e3897aae63e4b02f8729a73dd09931c6.1631101392.git.wuzongyong@linux.alibaba.com>
 <CACGkMEtAZg+Nkx_1WJAP2=xQ6o6G9Vd=xYvFmR6YRp8vBg2Tqg@mail.gmail.com>
 <20210909080157.GA17383@L-PF27918B-1352.localdomain> <CACGkMEsnp7-axbZWuB_w7ZkSWKa0Y+Ej-Kq0QSfO2-DNN=ShVA@mail.gmail.com>
 <20210909095726.GA17469@L-PF27918B-1352.localdomain>
In-Reply-To: <20210909095726.GA17469@L-PF27918B-1352.localdomain>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 10 Sep 2021 09:45:53 +0800
Message-ID: <CACGkMEvy-DWjAD636+YshY5VUE_mDQo0JBxEw7uBp5rExMj2_w@mail.gmail.com>
Subject: Re: [PATCH 5/6] vdpa: add get_vq_num_unchangeable callback in vdpa_config_ops
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mst <mst@redhat.com>, wei.yang1@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 5:57 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
>
> On Thu, Sep 09, 2021 at 05:28:26PM +0800, Jason Wang wrote:
> > On Thu, Sep 9, 2021 at 4:02 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
> > >
> > > On Thu, Sep 09, 2021 at 10:55:03AM +0800, Jason Wang wrote:
> > > > On Wed, Sep 8, 2021 at 8:23 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
> > > > >
> > > > > This new callback is used to indicate whether the vring size can be
> > > > > change or not. It is useful when we have a legacy virtio pci device as
> > > > > the vdpa device for there is no way to negotiate the vring num by the
> > > > > specification.
> > > >
> > > > So I'm not sure it's worth bothering. E.g what if we just fail
> > > > VHOST_SET_VRING_NUM it the value doesn't match what hardware has?
> > > >
> > > > Thanks
> > > >
> > > I think we should not call VHOST_SET_VRING_NUM in that case.
> > >
> > > If the hardware reports that the virtqueue size cannot be changed, we
> > > should call VHOST_GET_VRING_NUM to get the static virtqueue size
> > > firstly, then allocate the same size memory for the virtqueues and write
> > > the address to hardware finally.
> > >
> > > For QEMU, we will ignore the properties rx/tx_queue_size and just get it
> > > from the hardware if this new callback return true.
> >
> > This will break live migration. My understanding is that we can
> > advertise those capability/limitation via the netlink management
> > protocol then management layer can choose to use the correct queue
> > size.
> >
> > Thanks
> I agree, it is a good idea.
> BTW, can we also advertise mac address of network device? I found the
> mac address generated by libvirt or qemu will break the network datapath
> down if I don't specify the right mac explicitly in the XML or qemu
> commandline.

We never saw this before, AFAIK when vhost-vdpa is used, currently
qemu will probably ignore the mac address set via command line since
the config space is read from the device instead of qemu itself?

Thanks

> >
> > >
> > > What do you think?
> > > > >
> > > > > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> > > > > ---
> > > > >  drivers/vhost/vdpa.c         | 19 +++++++++++++++++++
> > > > >  drivers/virtio/virtio_vdpa.c |  5 ++++-
> > > > >  include/linux/vdpa.h         |  4 ++++
> > > > >  include/uapi/linux/vhost.h   |  2 ++
> > > > >  4 files changed, 29 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > > > index 9479f7f79217..2204d27d1e5d 100644
> > > > > --- a/drivers/vhost/vdpa.c
> > > > > +++ b/drivers/vhost/vdpa.c
> > > > > @@ -350,6 +350,22 @@ static long vhost_vdpa_get_iova_range(struct vhost_vdpa *v, u32 __user *argp)
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > +static long vhost_vdpa_get_vring_num_unchangeable(struct vhost_vdpa *v,
> > > > > +                                                 u32 __user *argp)
> > > > > +{
> > > > > +       struct vdpa_device *vdpa = v->vdpa;
> > > > > +       const struct vdpa_config_ops *ops = vdpa->config;
> > > > > +       bool unchangeable = false;
> > > > > +
> > > > > +       if (ops->get_vq_num_unchangeable)
> > > > > +               unchangeable = ops->get_vq_num_unchangeable(vdpa);
> > > > > +
> > > > > +       if (copy_to_user(argp, &unchangeable, sizeof(unchangeable)))
> > > > > +               return -EFAULT;
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > >  static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
> > > > >                                    void __user *argp)
> > > > >  {
> > > > > @@ -487,6 +503,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
> > > > >         case VHOST_VDPA_GET_IOVA_RANGE:
> > > > >                 r = vhost_vdpa_get_iova_range(v, argp);
> > > > >                 break;
> > > > > +       case VHOST_VDPA_GET_VRING_NUM_UNCHANGEABLE:
> > > > > +               r = vhost_vdpa_get_vring_num_unchangeable(v, argp);
> > > > > +               break;
> > > > >         default:
> > > > >                 r = vhost_dev_ioctl(&v->vdev, cmd, argp);
> > > > >                 if (r == -ENOIOCTLCMD)
> > > > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > > > > index 72eaef2caeb1..afb47465307a 100644
> > > > > --- a/drivers/virtio/virtio_vdpa.c
> > > > > +++ b/drivers/virtio/virtio_vdpa.c
> > > > > @@ -146,6 +146,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > > > >         struct vdpa_vq_state state = {0};
> > > > >         unsigned long flags;
> > > > >         u32 align, num;
> > > > > +       bool may_reduce_num = true;
> > > > >         int err;
> > > > >
> > > > >         if (!name)
> > > > > @@ -171,8 +172,10 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > > > >
> > > > >         /* Create the vring */
> > > > >         align = ops->get_vq_align(vdpa);
> > > > > +       if (ops->get_vq_num_unchangeable)
> > > > > +               may_reduce_num = !ops->get_vq_num_unchangeable(vdpa);
> > > > >         vq = vring_create_virtqueue(index, num, align, vdev,
> > > > > -                                   true, true, ctx,
> > > > > +                                   true, may_reduce_num, ctx,
> > > > >                                     virtio_vdpa_notify, callback, name);
> > > > >         if (!vq) {
> > > > >                 err = -ENOMEM;
> > > > > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > > > > index 35648c11e312..f809b7ada00d 100644
> > > > > --- a/include/linux/vdpa.h
> > > > > +++ b/include/linux/vdpa.h
> > > > > @@ -195,6 +195,9 @@ struct vdpa_iova_range {
> > > > >   *                             @vdev: vdpa device
> > > > >   *                             Returns the iova range supported by
> > > > >   *                             the device.
> > > > > + * @get_vq_num_unchangeable    Check if size of virtqueue is unchangeable (optional)
> > > > > + *                             @vdev: vdpa device
> > > > > + *                             Returns boolean: unchangeable (true) or not (false)
> > > > >   * @set_map:                   Set device memory mapping (optional)
> > > > >   *                             Needed for device that using device
> > > > >   *                             specific DMA translation (on-chip IOMMU)
> > > > > @@ -262,6 +265,7 @@ struct vdpa_config_ops {
> > > > >                            const void *buf, unsigned int len);
> > > > >         u32 (*get_generation)(struct vdpa_device *vdev);
> > > > >         struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev);
> > > > > +       bool (*get_vq_num_unchangeable)(struct vdpa_device *vdev);
> > > > >
> > > > >         /* DMA ops */
> > > > >         int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb *iotlb);
> > > > > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > > > > index c998860d7bbc..184f1f7f8498 100644
> > > > > --- a/include/uapi/linux/vhost.h
> > > > > +++ b/include/uapi/linux/vhost.h
> > > > > @@ -150,4 +150,6 @@
> > > > >  /* Get the valid iova range */
> > > > >  #define VHOST_VDPA_GET_IOVA_RANGE      _IOR(VHOST_VIRTIO, 0x78, \
> > > > >                                              struct vhost_vdpa_iova_range)
> > > > > +/* Check if the vring size can be change */
> > > > > +#define VHOST_VDPA_GET_VRING_NUM_UNCHANGEABLE _IOR(VHOST_VIRTIO, 0X79, bool)
> > > > >  #endif
> > > > > --
> > > > > 2.31.1
> > > > >
> > >
>

