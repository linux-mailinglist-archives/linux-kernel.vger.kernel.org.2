Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08314082B1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 03:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbhIMBpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 21:45:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23542 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231810AbhIMBpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 21:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631497434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2eMvAkKPRESIUFYrpmwrNvYdqqq5Ur7pmSNopNS7rtA=;
        b=jPdq7FgAecRS/nadQ+cju4GLuPcpfqS5wxPumiz+A677WiHxERgKd0x5ultATTsYThaxa/
        nKfn/N+LR8/QEgwWJZcWBP20ms5NDo5URQX8jUL2Gr2R2/YAfYhXzXhZSweM80hjNLMZv0
        yx86Q8Nqllcue1wql0eA22GqKijCOA4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-604-DHdgUPyLMPGVkiKn2K46Xg-1; Sun, 12 Sep 2021 21:43:53 -0400
X-MC-Unique: DHdgUPyLMPGVkiKn2K46Xg-1
Received: by mail-lf1-f71.google.com with SMTP id bp18-20020a056512159200b003eb84833c98so2695072lfb.14
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 18:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2eMvAkKPRESIUFYrpmwrNvYdqqq5Ur7pmSNopNS7rtA=;
        b=CT2QrlondgM6N9BbuPEql+VP4PDPwSONzQZYPwHxaFUCnazu573XT2KDU80Mj1oNlr
         /iK2Zlq6Ok2mwCpcMrl2qS2B896vF/Xo1ceOJQqN7cyCNuKKT+kCsHXq1Z/zFoXy9P6R
         FTdjWclM5QlISilq34P3LpbWcjsSITFM5sVlvcw1jcx1xMJ3wjauhES1YCMMMA1qgBw+
         nwKnlUtFlk6ITtq0zqfKB95jTMzNpnZvWgyw87Wd0LeSHUX/Xm1ndXu6ORpX3RGjP13t
         q1w5Fk8pQBBwD9BFnGLDYsK4S9LImRnMiEDWKd6yfKxoH6/MqCASUgOjwLEtpNl5/kbK
         OsPQ==
X-Gm-Message-State: AOAM531duRlgoyQta4COP0pWrAO52fE0NEgui4QgwxCIreqK+T6kzJXg
        hLf1+d93KYAPQX6gN4YXzI+TbIWS2Hk9mIzY5mo0LRmql9mIOknx2G2vMwJnQ0VDlteV1s4sTSa
        51LVxR0lAHBKYWauWTlBydH5fufG72ouHNDMTpNYP
X-Received: by 2002:a05:6512:32ca:: with SMTP id f10mr5159471lfg.498.1631497431274;
        Sun, 12 Sep 2021 18:43:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKao013jd4wQWQxJ9G/A6Ua2RQ/GDiD9jHbpVVqWB0qLnS0bMuARlA2vnr+vORhj9XgesMObY7E9AzODm/S6I=
X-Received: by 2002:a05:6512:32ca:: with SMTP id f10mr5159454lfg.498.1631497430885;
 Sun, 12 Sep 2021 18:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <ebd83066e3897aae63e4b02f8729a73dd09931c6.1631101392.git.wuzongyong@linux.alibaba.com>
 <CACGkMEtAZg+Nkx_1WJAP2=xQ6o6G9Vd=xYvFmR6YRp8vBg2Tqg@mail.gmail.com>
 <20210909080157.GA17383@L-PF27918B-1352.localdomain> <CACGkMEsnp7-axbZWuB_w7ZkSWKa0Y+Ej-Kq0QSfO2-DNN=ShVA@mail.gmail.com>
 <20210909095726.GA17469@L-PF27918B-1352.localdomain> <CACGkMEvy-DWjAD636+YshY5VUE_mDQo0JBxEw7uBp5rExMj2_w@mail.gmail.com>
 <20210910073231.GA17715@L-PF27918B-1352.localdomain> <CACLfguWeXwWJ9yd18vHbYicOk5=eMZJ0X=m86EKjmgHu35NdVA@mail.gmail.com>
 <20210910092013.GA17783@L-PF27918B-1352.localdomain> <CACLfguXFDra77Nqiv+ArUEOzTf9rzi0gLK4_r0ofCfJHSO056Q@mail.gmail.com>
In-Reply-To: <CACLfguXFDra77Nqiv+ArUEOzTf9rzi0gLK4_r0ofCfJHSO056Q@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 13 Sep 2021 09:43:40 +0800
Message-ID: <CACGkMEte0iEpDh4dT6Bgd6Be2O3BwpOsehP14A8kLeqTdqBQ9A@mail.gmail.com>
Subject: Re: [PATCH 5/6] vdpa: add get_vq_num_unchangeable callback in vdpa_config_ops
To:     Cindy Lu <lulu@redhat.com>
Cc:     Wu Zongyong <wuzongyong@linux.alibaba.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mst <mst@redhat.com>, wei.yang1@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 11:11 PM Cindy Lu <lulu@redhat.com> wrote:
>
> On Fri, Sep 10, 2021 at 5:20 PM Wu Zongyong
> <wuzongyong@linux.alibaba.com> wrote:
> >
> > On Fri, Sep 10, 2021 at 04:25:18PM +0800, Cindy Lu wrote:
> > > ,
> > >
> > > On Fri, Sep 10, 2021 at 3:33 PM Wu Zongyong
> > > <wuzongyong@linux.alibaba.com> wrote:
> > > >
> > > > On Fri, Sep 10, 2021 at 09:45:53AM +0800, Jason Wang wrote:
> > > > > On Thu, Sep 9, 2021 at 5:57 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
> > > > > >
> > > > > > On Thu, Sep 09, 2021 at 05:28:26PM +0800, Jason Wang wrote:
> > > > > > > On Thu, Sep 9, 2021 at 4:02 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Sep 09, 2021 at 10:55:03AM +0800, Jason Wang wrote:
> > > > > > > > > On Wed, Sep 8, 2021 at 8:23 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
> > > > > > > > > >
> > > > > > > > > > This new callback is used to indicate whether the vring size can be
> > > > > > > > > > change or not. It is useful when we have a legacy virtio pci device as
> > > > > > > > > > the vdpa device for there is no way to negotiate the vring num by the
> > > > > > > > > > specification.
> > > > > > > > >
> > > > > > > > > So I'm not sure it's worth bothering. E.g what if we just fail
> > > > > > > > > VHOST_SET_VRING_NUM it the value doesn't match what hardware has?
> > > > > > > > >
> > > > > > > > > Thanks
> > > > > > > > >
> > > > > > > > I think we should not call VHOST_SET_VRING_NUM in that case.
> > > > > > > >
> > > > > > > > If the hardware reports that the virtqueue size cannot be changed, we
> > > > > > > > should call VHOST_GET_VRING_NUM to get the static virtqueue size
> > > > > > > > firstly, then allocate the same size memory for the virtqueues and write
> > > > > > > > the address to hardware finally.
> > > > > > > >
> > > > > > > > For QEMU, we will ignore the properties rx/tx_queue_size and just get it
> > > > > > > > from the hardware if this new callback return true.
> > > > > > >
> > > > > > > This will break live migration. My understanding is that we can
> > > > > > > advertise those capability/limitation via the netlink management
> > > > > > > protocol then management layer can choose to use the correct queue
> > > > > > > size.
> > > > > > >
> > > > > > > Thanks
> > > > > > I agree, it is a good idea.
> > > > > > BTW, can we also advertise mac address of network device? I found the
> > > > > > mac address generated by libvirt or qemu will break the network datapath
> > > > > > down if I don't specify the right mac explicitly in the XML or qemu
> > > > > > commandline.
> > > > >
> > > > > We never saw this before, AFAIK when vhost-vdpa is used, currently
> > > > > qemu will probably ignore the mac address set via command line since
> > > > > the config space is read from the device instead of qemu itself?
> > > > >
> > > >
> > > > I saw the code below in qemu:
> > > >
> > > > static void virtio_net_device_realize(DeviceState *dev, Error **errp)
> > > > {
> > > >     ...
> > > >     if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> > > >         struct virtio_net_config netcfg = {};
> > > >         memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
> > > >         vhost_net_set_config(get_vhost_net(nc->peer),
> > > >             (uint8_t *)&netcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TYPE_MASTER);
> > > >     }
> > > >     ...
> > > > }
> > > >
> > > > This write the mac address set via cmdline into vdpa device config, and
> > > > then guest will read it back.
> > > > If I remove these codes, it behaves like you said.
> > > >
> > > >
> > > Hi Zongyong
> > > I think this code only works while qemu get an all 0 mac address from
> > > hardware , you can get more information from the function
> > > virtio_net_get_config.
> >
> > It depends how vdpa_config_ops->set_config implements.
> > For mlx5, callback set_config do nothing. But for virtio-pci, callback
> > set_config will write the config register of the vdpa device, so qemu
> > will write the mac set via cmdline to hardware and the mac guest read
> > it back is the value writted by qemu just now.
> >
> So here comes a question, which MAC address has higher priority ?
> the MAC address in hardware or the MAC address from the cmdline?
> If both of these two MAC addresses exist, which should we use?
> I have checked the spec, not sure if the bit VIRTIO_NET_F_MAC is the right one?

I think so, if VIRTIO_NET_F_MAC is set, qemu can override the mac otherwise not.

Thanks

> if yes, I will post a patch in qemu and add check for this bit before
> we set the mac to hardware
> https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-csprd01.html
>
> Thanks
> cindy
> > > > > Thanks
> > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > What do you think?
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> > > > > > > > > > ---
> > > > > > > > > >  drivers/vhost/vdpa.c         | 19 +++++++++++++++++++
> > > > > > > > > >  drivers/virtio/virtio_vdpa.c |  5 ++++-
> > > > > > > > > >  include/linux/vdpa.h         |  4 ++++
> > > > > > > > > >  include/uapi/linux/vhost.h   |  2 ++
> > > > > > > > > >  4 files changed, 29 insertions(+), 1 deletion(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > > > > > > > > index 9479f7f79217..2204d27d1e5d 100644
> > > > > > > > > > --- a/drivers/vhost/vdpa.c
> > > > > > > > > > +++ b/drivers/vhost/vdpa.c
> > > > > > > > > > @@ -350,6 +350,22 @@ static long vhost_vdpa_get_iova_range(struct vhost_vdpa *v, u32 __user *argp)
> > > > > > > > > >         return 0;
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > +static long vhost_vdpa_get_vring_num_unchangeable(struct vhost_vdpa *v,
> > > > > > > > > > +                                                 u32 __user *argp)
> > > > > > > > > > +{
> > > > > > > > > > +       struct vdpa_device *vdpa = v->vdpa;
> > > > > > > > > > +       const struct vdpa_config_ops *ops = vdpa->config;
> > > > > > > > > > +       bool unchangeable = false;
> > > > > > > > > > +
> > > > > > > > > > +       if (ops->get_vq_num_unchangeable)
> > > > > > > > > > +               unchangeable = ops->get_vq_num_unchangeable(vdpa);
> > > > > > > > > > +
> > > > > > > > > > +       if (copy_to_user(argp, &unchangeable, sizeof(unchangeable)))
> > > > > > > > > > +               return -EFAULT;
> > > > > > > > > > +
> > > > > > > > > > +       return 0;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > >  static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
> > > > > > > > > >                                    void __user *argp)
> > > > > > > > > >  {
> > > > > > > > > > @@ -487,6 +503,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
> > > > > > > > > >         case VHOST_VDPA_GET_IOVA_RANGE:
> > > > > > > > > >                 r = vhost_vdpa_get_iova_range(v, argp);
> > > > > > > > > >                 break;
> > > > > > > > > > +       case VHOST_VDPA_GET_VRING_NUM_UNCHANGEABLE:
> > > > > > > > > > +               r = vhost_vdpa_get_vring_num_unchangeable(v, argp);
> > > > > > > > > > +               break;
> > > > > > > > > >         default:
> > > > > > > > > >                 r = vhost_dev_ioctl(&v->vdev, cmd, argp);
> > > > > > > > > >                 if (r == -ENOIOCTLCMD)
> > > > > > > > > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > > > > > > > > > index 72eaef2caeb1..afb47465307a 100644
> > > > > > > > > > --- a/drivers/virtio/virtio_vdpa.c
> > > > > > > > > > +++ b/drivers/virtio/virtio_vdpa.c
> > > > > > > > > > @@ -146,6 +146,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > > > > > > > > >         struct vdpa_vq_state state = {0};
> > > > > > > > > >         unsigned long flags;
> > > > > > > > > >         u32 align, num;
> > > > > > > > > > +       bool may_reduce_num = true;
> > > > > > > > > >         int err;
> > > > > > > > > >
> > > > > > > > > >         if (!name)
> > > > > > > > > > @@ -171,8 +172,10 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > > > > > > > > >
> > > > > > > > > >         /* Create the vring */
> > > > > > > > > >         align = ops->get_vq_align(vdpa);
> > > > > > > > > > +       if (ops->get_vq_num_unchangeable)
> > > > > > > > > > +               may_reduce_num = !ops->get_vq_num_unchangeable(vdpa);
> > > > > > > > > >         vq = vring_create_virtqueue(index, num, align, vdev,
> > > > > > > > > > -                                   true, true, ctx,
> > > > > > > > > > +                                   true, may_reduce_num, ctx,
> > > > > > > > > >                                     virtio_vdpa_notify, callback, name);
> > > > > > > > > >         if (!vq) {
> > > > > > > > > >                 err = -ENOMEM;
> > > > > > > > > > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > > > > > > > > > index 35648c11e312..f809b7ada00d 100644
> > > > > > > > > > --- a/include/linux/vdpa.h
> > > > > > > > > > +++ b/include/linux/vdpa.h
> > > > > > > > > > @@ -195,6 +195,9 @@ struct vdpa_iova_range {
> > > > > > > > > >   *                             @vdev: vdpa device
> > > > > > > > > >   *                             Returns the iova range supported by
> > > > > > > > > >   *                             the device.
> > > > > > > > > > + * @get_vq_num_unchangeable    Check if size of virtqueue is unchangeable (optional)
> > > > > > > > > > + *                             @vdev: vdpa device
> > > > > > > > > > + *                             Returns boolean: unchangeable (true) or not (false)
> > > > > > > > > >   * @set_map:                   Set device memory mapping (optional)
> > > > > > > > > >   *                             Needed for device that using device
> > > > > > > > > >   *                             specific DMA translation (on-chip IOMMU)
> > > > > > > > > > @@ -262,6 +265,7 @@ struct vdpa_config_ops {
> > > > > > > > > >                            const void *buf, unsigned int len);
> > > > > > > > > >         u32 (*get_generation)(struct vdpa_device *vdev);
> > > > > > > > > >         struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev);
> > > > > > > > > > +       bool (*get_vq_num_unchangeable)(struct vdpa_device *vdev);
> > > > > > > > > >
> > > > > > > > > >         /* DMA ops */
> > > > > > > > > >         int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb *iotlb);
> > > > > > > > > > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > > > > > > > > > index c998860d7bbc..184f1f7f8498 100644
> > > > > > > > > > --- a/include/uapi/linux/vhost.h
> > > > > > > > > > +++ b/include/uapi/linux/vhost.h
> > > > > > > > > > @@ -150,4 +150,6 @@
> > > > > > > > > >  /* Get the valid iova range */
> > > > > > > > > >  #define VHOST_VDPA_GET_IOVA_RANGE      _IOR(VHOST_VIRTIO, 0x78, \
> > > > > > > > > >                                              struct vhost_vdpa_iova_range)
> > > > > > > > > > +/* Check if the vring size can be change */
> > > > > > > > > > +#define VHOST_VDPA_GET_VRING_NUM_UNCHANGEABLE _IOR(VHOST_VIRTIO, 0X79, bool)
> > > > > > > > > >  #endif
> > > > > > > > > > --
> > > > > > > > > > 2.31.1
> > > > > > > > > >
> > > > > > > >
> > > > > >
> > > >
> >
>

