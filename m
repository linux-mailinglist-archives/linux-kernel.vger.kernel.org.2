Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31054047C5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 11:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhIIJbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 05:31:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22747 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229927AbhIIJbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 05:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631179811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z4/21SiMFWF3Zx5Us2Sk9TowrO3r4kSIRTbLTVgZ8c8=;
        b=Y9WF9i5inVAP1lf8H2BvkNHah0AXHJBeJlC/gY4kAasgm9xNqsVO8mgJIOld9lgzb8X2Dv
        PwtLAurhSmijOXJyQzk4xBjy3PjR3YEcEy0g0berNObn9AlTNcjQ0nA8UgyLJHMVYirwfU
        zSv0Ls3MWkHL5XLZVN3Qp879yol4dPI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-zb9BtJANOVKeNGymxaFWsg-1; Thu, 09 Sep 2021 05:30:10 -0400
X-MC-Unique: zb9BtJANOVKeNGymxaFWsg-1
Received: by mail-lj1-f199.google.com with SMTP id w11-20020a2e998b000000b001c071349c96so491938lji.15
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 02:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z4/21SiMFWF3Zx5Us2Sk9TowrO3r4kSIRTbLTVgZ8c8=;
        b=iPLT3kaQ4U4E30VW3Wt6Y99ZbfNuhl7UVWlrQehQexAWSpFid3vNNvz+DQ/GztvdJ6
         T3rf4TF9xmVA3PZrbn3q4XdfDqvQV5zNzhgpm+6S5P/iL01SERWO48YmyvR2sHfagl5u
         RjsySIjCc3pEonq6wNSjLH/Eo71fdVErMqEuhn6bMt08ppZjofp0n3jk9/3cGMhy9j79
         CW5wjhE//JLG35/LO2EVenUIOOJlWcxTxCU4Q430jb6YsHmw7jWfpsJotDrJ7ajpKz8V
         Y8Hh/1v5mipJkCHSUi3a1qjhDkqScBQHNqnrR1YEwrkxtWYQZ4bg/Pk9M+z/P9SRPK8C
         MMwg==
X-Gm-Message-State: AOAM531N7O/sorvYIgZyyNk1EQ86ArSJ6gljfYn5m1OPrRiiJTAthbmV
        hEI3/ci2Ydo6ogEzvxN5o3ZzJQFGkjafpr033BkbHU4+n7g/oeh6fJvVVc0SUNWDHyh/KnWxNdS
        3bvgSIXBG+cAUduUChlyliD6HpW0X/2lgGMJZpoOm
X-Received: by 2002:a05:6512:110b:: with SMTP id l11mr1606251lfg.199.1631179808341;
        Thu, 09 Sep 2021 02:30:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0uGMhA7ok8YWHyDIN7092TFifFK8Vgrl2zu9Xcd9KUI/rmLOFHrq0Mo4JUEWciB8wJAcOVDKVvooR8raNTpg=
X-Received: by 2002:a05:6512:110b:: with SMTP id l11mr1606239lfg.199.1631179808125;
 Thu, 09 Sep 2021 02:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <CACGkMEuEwbDQUtYHz=0O4pQcb6ibY0MAT7hLDjN=Okw8c9CZGA@mail.gmail.com> <20210909081211.GB17383@L-PF27918B-1352.localdomain>
In-Reply-To: <20210909081211.GB17383@L-PF27918B-1352.localdomain>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 9 Sep 2021 17:29:57 +0800
Message-ID: <CACGkMEt9GByyZf7ArPiKFA-mr1qA89x5nKU_VniM+w4TfuQN=Q@mail.gmail.com>
Subject: Re: [PATCH 0/6] vDPA driver for legacy virtio-pci device
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mst <mst@redhat.com>, wei.yang1@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 4:12 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
>
> On Thu, Sep 09, 2021 at 11:05:06AM +0800, Jason Wang wrote:
> > On Wed, Sep 8, 2021 at 8:22 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
> > >
> > > This series implements the vDPA driver for legacy virtio-pci device.
> > > Currently we already have the vDPA driver for modern virtio-pci device
> > > only, but there are some legacy virtio-pci devices conforming to the
> > > virtio-pci specifications of 0.9.x or older versions. For example,
> > > ENI(Elastic Network Interface) of Alibaba ECS baremetal instance is a
> > > hardware virtio network device which follows the Virtio PCI Card 0.9.5
> > > Draft specification. Such legacy virtio-pci devices have some
> > > inconsistent behaviour with modern virtio-pci devices, so some common
> > > codes are split out and modern device specific codes are moved to a
> > > separated file.
> >
> > What worries me a little bit are:
> >
> > 1) vDPA requires IOMMU_PLATFORM to be supported by the device to work,
> > if I understand ENI correctly, it's a legacy device so it can't
> > support ACCESS_PLATFORM. Or is it a legacy device that supports
> > ACCESS_PLATFORM implicitly.
> > 2) vDPA tries to present a 1.0 device, in this case the behavior could
> > be ruled by the spec. If we tries to present an 1.0 device on top of
> > legacy device we may suffer a lot of issues:
> >
> > - endian issue: 1.0 use le but legacy may use native endian
> > - queue_enable semantic which is missed in the legacy
>
> Writting the queue_address is regarded as enable queue in the legacy.
> Right?

It's implementation specific details that virtio spec can't mandate.

E.g if your ENI behaves like this, you can delay the queue_address
write to hardware until set_vq_ready() in the ENI vDPA driver.

Thanks

>
> > - virtqueue size, as you mentioned below
> >
> > I guess what the device(ENI) supports are:
> >
> > 1) semantic of ACCESS_PLATFORM without a feature
> > 2) little endian
> > 3) but a legacy device
> >
> > So I think it might be better:
> >
> > 1) introduce the library for legacy as you did in this patch
> > 2) having a dedicated ENI vDPA driver
> >
> > 3) live migration support, though it was not supported by the spec
> > yet, but we are working on the support, and we know legacy device can
> > support this.
> >
> > Thanks
> >
>
> I agree.
> It's better to implement a dedicated vDPA driver for ENI only. ENI is
> not a standard legacy virtio-pci device.
>
> > >
> > > For legacy devices, it is not supported to negotiate the virtqueue size
> > > by the specification. So a new callback get_vq_num_unchangeable is
> > > introduced to indicate user not to try change the virtqueue size of the
> > > legacy vdpa device. For example, QEMU should not allocate memory for
> > > virtqueue according to the properties tx_queue_size and rx_queue_size if
> > > we use legacy virtio-pci device as the vhost-vdpa backend. Instead, QEMU
> > > should use the new callback get_vq_num_unchangeable first to check if
> > > the vdpa device support to change virtqueue size. If not, QEMU should
> > > call the callback get_vq_num_max to get the static virtqueue size then
> > > allocate the same size memory for the virtqueue.
> > >
> > > This series have been tested with the ENI in Alibaba ECS baremetal
> > > instance.
> > >
> > > These patches may under consideration, welcome for comments.
> > >
> > >
> > > Wu Zongyong (6):
> > >   virtio-pci: introduce legacy device module
> > >   vdpa: fix typo
> > >   vp_vdpa: add vq irq offloading support
> > >   vp_vdpa: split out reusable and device specific codes to separate file
> > >   vdpa: add get_vq_num_unchangeable callback in vdpa_config_ops
> > >   vp_vdpa: introduce legacy virtio pci driver
> > >
> > >  drivers/vdpa/Kconfig                     |   7 +
> > >  drivers/vdpa/virtio_pci/Makefile         |   3 +
> > >  drivers/vdpa/virtio_pci/vp_vdpa.c        |   8 +
> > >  drivers/vdpa/virtio_pci/vp_vdpa_common.c | 220 ++++++++++++++
> > >  drivers/vdpa/virtio_pci/vp_vdpa_common.h |  67 +++++
> > >  drivers/vdpa/virtio_pci/vp_vdpa_legacy.c | 346 +++++++++++++++++++++++
> > >  drivers/vdpa/virtio_pci/vp_vdpa_modern.c | 327 +++++++++++++++++++++
> > >  drivers/vhost/vdpa.c                     |  19 ++
> > >  drivers/virtio/Kconfig                   |  10 +
> > >  drivers/virtio/Makefile                  |   1 +
> > >  drivers/virtio/virtio_pci_common.c       |  10 +-
> > >  drivers/virtio/virtio_pci_common.h       |   9 +-
> > >  drivers/virtio/virtio_pci_legacy.c       | 101 ++-----
> > >  drivers/virtio/virtio_pci_legacy_dev.c   | 220 ++++++++++++++
> > >  drivers/virtio/virtio_vdpa.c             |   5 +-
> > >  include/linux/vdpa.h                     |   6 +-
> > >  include/linux/virtio_pci_legacy.h        |  44 +++
> > >  include/uapi/linux/vhost.h               |   2 +
> > >  18 files changed, 1320 insertions(+), 85 deletions(-)
> > >  create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa_common.c
> > >  create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa_common.h
> > >  create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa_legacy.c
> > >  create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa_modern.c
> > >  create mode 100644 drivers/virtio/virtio_pci_legacy_dev.c
> > >  create mode 100644 include/linux/virtio_pci_legacy.h
> > >
> > > --
> > > 2.31.1
> > >
>

