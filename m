Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FB440849F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 08:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237282AbhIMGYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 02:24:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39220 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230003AbhIMGYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 02:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631514173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fS8xhJMYvlV2ijzqwleKOfm2QTQqhocUrALWibBzxTY=;
        b=LE+bs2MT7HgN9Zf8Ippvvuw2Ay9N/72vYycwYhUClm6nch9ZIttw1UT43ZMmtNOaG17GXF
        Cw6ostbWL5DrfIRfEtTRriP0glaflz8H4DYUMChrTsOjNt7V+PpanNtYFJkIpujLJBD8eV
        R2AUgvcwnDSMmdYHA8grQKsDfTbecO4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-4Nbe1AmzPpW6J3RzfX6qJA-1; Mon, 13 Sep 2021 02:22:51 -0400
X-MC-Unique: 4Nbe1AmzPpW6J3RzfX6qJA-1
Received: by mail-ej1-f72.google.com with SMTP id bx10-20020a170906a1ca00b005c341820edeso3177851ejb.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 23:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fS8xhJMYvlV2ijzqwleKOfm2QTQqhocUrALWibBzxTY=;
        b=OYvT+T9trh6g1cAvt4W7sRpgUcHHMHhVHrptnhz2d0CgXBGC4cWDmXT8D7F2PGZUg5
         Qr8BqDnJT4XNB9DkLe1AaF6I/Z26SA+W4lunnSuLkLEcVcEEpvzYsrnV9gZ3EOAcRlcn
         4K2dQiznAXE1FTsM2LxWJFj9YX/0Lv8+rLuV4QOXFLlOpCFU4/iIHUgX/iOUgmT0/Vwz
         GbmskPxAlk7bnq3pcok4irIzEqu45ldWX+y+PfD7RKKskflLPbuxnhAg2is2GORZJ+FZ
         44olUT7z5mwmU6cPQ5B2CqgMw/79e6BLawvDgyJECoaRttcjniccOwFkC7B/yw1U9XYT
         fqBQ==
X-Gm-Message-State: AOAM533+JV4HTsJlFMEjrMnFhOD/SW3oXbRaitlm1/aAU3XXBkLlM2EC
        FAshs5MbMxiSS7wmZNa+lEjZ8/hLKdXokjJFt16kCyLOieHTi5CKUSHC2zTYqH9qBy8klUmCIP/
        8rX5WS6Xk45ff2Gh+TPNSbsHDvZz6vq1Ba7oSTJ5D
X-Received: by 2002:a17:907:244a:: with SMTP id yw10mr10735589ejb.571.1631514169842;
        Sun, 12 Sep 2021 23:22:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbRh+mfAnoRsxKb2tlt9XYwtw0Qagrp1WvZTc5pTxu+V8ttpPbrOx6wHChiFy/16f/Y1Z2qxxht+RkBGAqyG0=
X-Received: by 2002:a17:907:244a:: with SMTP id yw10mr10735573ejb.571.1631514169591;
 Sun, 12 Sep 2021 23:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEtAZg+Nkx_1WJAP2=xQ6o6G9Vd=xYvFmR6YRp8vBg2Tqg@mail.gmail.com>
 <20210909080157.GA17383@L-PF27918B-1352.localdomain> <CACGkMEsnp7-axbZWuB_w7ZkSWKa0Y+Ej-Kq0QSfO2-DNN=ShVA@mail.gmail.com>
 <20210909095726.GA17469@L-PF27918B-1352.localdomain> <CACGkMEvy-DWjAD636+YshY5VUE_mDQo0JBxEw7uBp5rExMj2_w@mail.gmail.com>
 <20210910073231.GA17715@L-PF27918B-1352.localdomain> <CACLfguWeXwWJ9yd18vHbYicOk5=eMZJ0X=m86EKjmgHu35NdVA@mail.gmail.com>
 <20210910092013.GA17783@L-PF27918B-1352.localdomain> <CACLfguXFDra77Nqiv+ArUEOzTf9rzi0gLK4_r0ofCfJHSO056Q@mail.gmail.com>
 <CACGkMEte0iEpDh4dT6Bgd6Be2O3BwpOsehP14A8kLeqTdqBQ9A@mail.gmail.com>
 <20210913025920.GB17820@L-PF27918B-1352.localdomain> <CACGkMEuDg8cOVT75gaMS5ZV7h2+U3ivrcO6Y-nDjZXFGi8o-Qw@mail.gmail.com>
In-Reply-To: <CACGkMEuDg8cOVT75gaMS5ZV7h2+U3ivrcO6Y-nDjZXFGi8o-Qw@mail.gmail.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Mon, 13 Sep 2021 14:22:12 +0800
Message-ID: <CACLfguVbi3o3xgsb+K-3Kn99x7k6ETdpZJ8kqyYcNhWZHkZqUg@mail.gmail.com>
Subject: Re: [PATCH 5/6] vdpa: add get_vq_num_unchangeable callback in vdpa_config_ops
To:     Jason Wang <jasowang@redhat.com>
Cc:     Wu Zongyong <wuzongyong@linux.alibaba.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mst <mst@redhat.com>, wei.yang1@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 11:13 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Sep 13, 2021 at 10:59 AM Wu Zongyong
> <wuzongyong@linux.alibaba.com> wrote:
> >
> > On Mon, Sep 13, 2021 at 09:43:40AM +0800, Jason Wang wrote:
> > > On Fri, Sep 10, 2021 at 11:11 PM Cindy Lu <lulu@redhat.com> wrote:
> > > >
> > > > On Fri, Sep 10, 2021 at 5:20 PM Wu Zongyong
> > > > <wuzongyong@linux.alibaba.com> wrote:
> > > > >
> > > > > On Fri, Sep 10, 2021 at 04:25:18PM +0800, Cindy Lu wrote:
> > > > > > ,
> > > > > >
> > > > > > On Fri, Sep 10, 2021 at 3:33 PM Wu Zongyong
> > > > > > <wuzongyong@linux.alibaba.com> wrote:
> > > > > > >
> > > > > > > On Fri, Sep 10, 2021 at 09:45:53AM +0800, Jason Wang wrote:
> > > > > > > > On Thu, Sep 9, 2021 at 5:57 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Sep 09, 2021 at 05:28:26PM +0800, Jason Wang wrote:
> > > > > > > > > > On Thu, Sep 9, 2021 at 4:02 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Thu, Sep 09, 2021 at 10:55:03AM +0800, Jason Wang wrote:
> > > > > > > > > > > > On Wed, Sep 8, 2021 at 8:23 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > This new callback is used to indicate whether the vring size can be
> > > > > > > > > > > > > change or not. It is useful when we have a legacy virtio pci device as
> > > > > > > > > > > > > the vdpa device for there is no way to negotiate the vring num by the
> > > > > > > > > > > > > specification.
> > > > > > > > > > > >
> > > > > > > > > > > > So I'm not sure it's worth bothering. E.g what if we just fail
> > > > > > > > > > > > VHOST_SET_VRING_NUM it the value doesn't match what hardware has?
> > > > > > > > > > > >
> > > > > > > > > > > > Thanks
> > > > > > > > > > > >
> > > > > > > > > > > I think we should not call VHOST_SET_VRING_NUM in that case.
> > > > > > > > > > >
> > > > > > > > > > > If the hardware reports that the virtqueue size cannot be changed, we
> > > > > > > > > > > should call VHOST_GET_VRING_NUM to get the static virtqueue size
> > > > > > > > > > > firstly, then allocate the same size memory for the virtqueues and write
> > > > > > > > > > > the address to hardware finally.
> > > > > > > > > > >
> > > > > > > > > > > For QEMU, we will ignore the properties rx/tx_queue_size and just get it
> > > > > > > > > > > from the hardware if this new callback return true.
> > > > > > > > > >
> > > > > > > > > > This will break live migration. My understanding is that we can
> > > > > > > > > > advertise those capability/limitation via the netlink management
> > > > > > > > > > protocol then management layer can choose to use the correct queue
> > > > > > > > > > size.
> > > > > > > > > >
> > > > > > > > > > Thanks
> > > > > > > > > I agree, it is a good idea.
> > > > > > > > > BTW, can we also advertise mac address of network device? I found the
> > > > > > > > > mac address generated by libvirt or qemu will break the network datapath
> > > > > > > > > down if I don't specify the right mac explicitly in the XML or qemu
> > > > > > > > > commandline.
> > > > > > > >
> > > > > > > > We never saw this before, AFAIK when vhost-vdpa is used, currently
> > > > > > > > qemu will probably ignore the mac address set via command line since
> > > > > > > > the config space is read from the device instead of qemu itself?
> > > > > > > >
> > > > > > >
> > > > > > > I saw the code below in qemu:
> > > > > > >
> > > > > > > static void virtio_net_device_realize(DeviceState *dev, Error **errp)
> > > > > > > {
> > > > > > >     ...
> > > > > > >     if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> > > > > > >         struct virtio_net_config netcfg = {};
> > > > > > >         memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
> > > > > > >         vhost_net_set_config(get_vhost_net(nc->peer),
> > > > > > >             (uint8_t *)&netcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TYPE_MASTER);
> > > > > > >     }
> > > > > > >     ...
> > > > > > > }
> > > > > > >
> > > > > > > This write the mac address set via cmdline into vdpa device config, and
> > > > > > > then guest will read it back.
> > > > > > > If I remove these codes, it behaves like you said.
> > > > > > >
> > > > > > >
> > > > > > Hi Zongyong
> > > > > > I think this code only works while qemu get an all 0 mac address from
> > > > > > hardware , you can get more information from the function
> > > > > > virtio_net_get_config.
> > > > >
> > > > > It depends how vdpa_config_ops->set_config implements.
> > > > > For mlx5, callback set_config do nothing. But for virtio-pci, callback
> > > > > set_config will write the config register of the vdpa device, so qemu
> > > > > will write the mac set via cmdline to hardware and the mac guest read
> > > > > it back is the value writted by qemu just now.
> > > > >
> > > > So here comes a question, which MAC address has higher priority ?
> > > > the MAC address in hardware or the MAC address from the cmdline?
> > > > If both of these two MAC addresses exist, which should we use?
> > > > I have checked the spec, not sure if the bit VIRTIO_NET_F_MAC is the right one?
> > >
> > > I think so, if VIRTIO_NET_F_MAC is set, qemu can override the mac otherwise not.
> > >
> > The spec says:
> > "driver SHOULD negotiate VIRTIO_NET_F_MAC if the device offers it. If the driver
> > negotiates the VIRTIO_NET_F_MAC feature, the driver MUST set the physical address
> > of the NIC to mac. Otherwise, it SHOULD use a locally-administered MAC address."
> >
> > To my understanding, I guess you mean qemu CANNOT override the mac
> > device provides actually?
>
> Seems not, if VIRTIO_NET_F_MAC is not negotiated, mac is not valid in
> the config space:
>
> "The mac address field always exists (though is only valid if
> VIRTIO_NET_F_MAC is set)"
>
> So I think the right approach:
>
> - if mac is not specified in the cli, Qemu doesn't need to override the mac
> - if mac is specified in the cli and VIRTIO_NET_F_MAC is supported,
> Qemu can override the mac
> - if mac is specified in the cli and VIRTIO_NET_F_MAC is not
> supported, we need fail the launching
>
> Note that we're working on extending the netlink management API to set
> mac address during vDPA instance provisioning. Management layer can
> then get the correct mac address and set it via cli. AFAIK, Cindy's
> patch is a workaround when netlink doesn't support mac address.
>
> Thanks
>
sure, I will post a patch based on that
> > > Thanks
> > >
> > > > if yes, I will post a patch in qemu and add check for this bit before
> > > > we set the mac to hardware
> > > > https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-csprd01.html
> > > >
> > > > Thanks
> > > > cindy
> > > > > > > > Thanks
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > What do you think?
> > > > > > > > > > > > >
> > > > > > > > > > > > > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > >  drivers/vhost/vdpa.c         | 19 +++++++++++++++++++
> > > > > > > > > > > > >  drivers/virtio/virtio_vdpa.c |  5 ++++-
> > > > > > > > > > > > >  include/linux/vdpa.h         |  4 ++++
> > > > > > > > > > > > >  include/uapi/linux/vhost.h   |  2 ++
> > > > > > > > > > > > >  4 files changed, 29 insertions(+), 1 deletion(-)
> > > > > > > > > > > > >
> > > > > > > > > > > > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > > > > > > > > > > > index 9479f7f79217..2204d27d1e5d 100644
> > > > > > > > > > > > > --- a/drivers/vhost/vdpa.c
> > > > > > > > > > > > > +++ b/drivers/vhost/vdpa.c
> > > > > > > > > > > > > @@ -350,6 +350,22 @@ static long vhost_vdpa_get_iova_range(struct vhost_vdpa *v, u32 __user *argp)
> > > > > > > > > > > > >         return 0;
> > > > > > > > > > > > >  }
> > > > > > > > > > > > >
> > > > > > > > > > > > > +static long vhost_vdpa_get_vring_num_unchangeable(struct vhost_vdpa *v,
> > > > > > > > > > > > > +                                                 u32 __user *argp)
> > > > > > > > > > > > > +{
> > > > > > > > > > > > > +       struct vdpa_device *vdpa = v->vdpa;
> > > > > > > > > > > > > +       const struct vdpa_config_ops *ops = vdpa->config;
> > > > > > > > > > > > > +       bool unchangeable = false;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +       if (ops->get_vq_num_unchangeable)
> > > > > > > > > > > > > +               unchangeable = ops->get_vq_num_unchangeable(vdpa);
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +       if (copy_to_user(argp, &unchangeable, sizeof(unchangeable)))
> > > > > > > > > > > > > +               return -EFAULT;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +       return 0;
> > > > > > > > > > > > > +}
> > > > > > > > > > > > > +
> > > > > > > > > > > > >  static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
> > > > > > > > > > > > >                                    void __user *argp)
> > > > > > > > > > > > >  {
> > > > > > > > > > > > > @@ -487,6 +503,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
> > > > > > > > > > > > >         case VHOST_VDPA_GET_IOVA_RANGE:
> > > > > > > > > > > > >                 r = vhost_vdpa_get_iova_range(v, argp);
> > > > > > > > > > > > >                 break;
> > > > > > > > > > > > > +       case VHOST_VDPA_GET_VRING_NUM_UNCHANGEABLE:
> > > > > > > > > > > > > +               r = vhost_vdpa_get_vring_num_unchangeable(v, argp);
> > > > > > > > > > > > > +               break;
> > > > > > > > > > > > >         default:
> > > > > > > > > > > > >                 r = vhost_dev_ioctl(&v->vdev, cmd, argp);
> > > > > > > > > > > > >                 if (r == -ENOIOCTLCMD)
> > > > > > > > > > > > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > > > > > > > > > > > > index 72eaef2caeb1..afb47465307a 100644
> > > > > > > > > > > > > --- a/drivers/virtio/virtio_vdpa.c
> > > > > > > > > > > > > +++ b/drivers/virtio/virtio_vdpa.c
> > > > > > > > > > > > > @@ -146,6 +146,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > > > > > > > > > > > >         struct vdpa_vq_state state = {0};
> > > > > > > > > > > > >         unsigned long flags;
> > > > > > > > > > > > >         u32 align, num;
> > > > > > > > > > > > > +       bool may_reduce_num = true;
> > > > > > > > > > > > >         int err;
> > > > > > > > > > > > >
> > > > > > > > > > > > >         if (!name)
> > > > > > > > > > > > > @@ -171,8 +172,10 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > > > > > > > > > > > >
> > > > > > > > > > > > >         /* Create the vring */
> > > > > > > > > > > > >         align = ops->get_vq_align(vdpa);
> > > > > > > > > > > > > +       if (ops->get_vq_num_unchangeable)
> > > > > > > > > > > > > +               may_reduce_num = !ops->get_vq_num_unchangeable(vdpa);
> > > > > > > > > > > > >         vq = vring_create_virtqueue(index, num, align, vdev,
> > > > > > > > > > > > > -                                   true, true, ctx,
> > > > > > > > > > > > > +                                   true, may_reduce_num, ctx,
> > > > > > > > > > > > >                                     virtio_vdpa_notify, callback, name);
> > > > > > > > > > > > >         if (!vq) {
> > > > > > > > > > > > >                 err = -ENOMEM;
> > > > > > > > > > > > > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > > > > > > > > > > > > index 35648c11e312..f809b7ada00d 100644
> > > > > > > > > > > > > --- a/include/linux/vdpa.h
> > > > > > > > > > > > > +++ b/include/linux/vdpa.h
> > > > > > > > > > > > > @@ -195,6 +195,9 @@ struct vdpa_iova_range {
> > > > > > > > > > > > >   *                             @vdev: vdpa device
> > > > > > > > > > > > >   *                             Returns the iova range supported by
> > > > > > > > > > > > >   *                             the device.
> > > > > > > > > > > > > + * @get_vq_num_unchangeable    Check if size of virtqueue is unchangeable (optional)
> > > > > > > > > > > > > + *                             @vdev: vdpa device
> > > > > > > > > > > > > + *                             Returns boolean: unchangeable (true) or not (false)
> > > > > > > > > > > > >   * @set_map:                   Set device memory mapping (optional)
> > > > > > > > > > > > >   *                             Needed for device that using device
> > > > > > > > > > > > >   *                             specific DMA translation (on-chip IOMMU)
> > > > > > > > > > > > > @@ -262,6 +265,7 @@ struct vdpa_config_ops {
> > > > > > > > > > > > >                            const void *buf, unsigned int len);
> > > > > > > > > > > > >         u32 (*get_generation)(struct vdpa_device *vdev);
> > > > > > > > > > > > >         struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev);
> > > > > > > > > > > > > +       bool (*get_vq_num_unchangeable)(struct vdpa_device *vdev);
> > > > > > > > > > > > >
> > > > > > > > > > > > >         /* DMA ops */
> > > > > > > > > > > > >         int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb *iotlb);
> > > > > > > > > > > > > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > > > > > > > > > > > > index c998860d7bbc..184f1f7f8498 100644
> > > > > > > > > > > > > --- a/include/uapi/linux/vhost.h
> > > > > > > > > > > > > +++ b/include/uapi/linux/vhost.h
> > > > > > > > > > > > > @@ -150,4 +150,6 @@
> > > > > > > > > > > > >  /* Get the valid iova range */
> > > > > > > > > > > > >  #define VHOST_VDPA_GET_IOVA_RANGE      _IOR(VHOST_VIRTIO, 0x78, \
> > > > > > > > > > > > >                                              struct vhost_vdpa_iova_range)
> > > > > > > > > > > > > +/* Check if the vring size can be change */
> > > > > > > > > > > > > +#define VHOST_VDPA_GET_VRING_NUM_UNCHANGEABLE _IOR(VHOST_VIRTIO, 0X79, bool)
> > > > > > > > > > > > >  #endif
> > > > > > > > > > > > > --
> > > > > > > > > > > > > 2.31.1
> > > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > >
> > > > > > >
> > > > >
> > > >
> >
>

