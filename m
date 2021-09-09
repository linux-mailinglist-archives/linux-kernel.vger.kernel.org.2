Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969714043E6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 05:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348030AbhIIDVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 23:21:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53402 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231310AbhIIDVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 23:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631157632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yQzc286DxauIBI+q8ayiXXtP3+iTz1b0WX+FNU4A+rg=;
        b=iKXdJjowDsKVK4JqiBR9/Jkts5+9Ey2PnwV+G8EEnUJkeOHqQ4T7kCpQMrgedf2arQ5H6Q
        BZinaHlaZcuTWszke774pg9knKYPWC7LFpjE89g6g8cgPC2uyPpoc6yYcHNna0/XSp6qlR
        nZtuAOfxuCS/Pgbzlwz69RtII0AxipQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-Sqqeioq4OIKRYQ_JKxrKuQ-1; Wed, 08 Sep 2021 23:20:29 -0400
X-MC-Unique: Sqqeioq4OIKRYQ_JKxrKuQ-1
Received: by mail-lf1-f69.google.com with SMTP id x33-20020a0565121321b02903ac51262781so188859lfu.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 20:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQzc286DxauIBI+q8ayiXXtP3+iTz1b0WX+FNU4A+rg=;
        b=1rM4Hbs3QsdsBMyLO8gAblSyKDMkcsGdUcxIHo50ZFZFBDwCQHt5UZ9y8c1vOZUEJs
         QrLI4jj9l9nA2H9L8Gw8H/SdLV+MYrudeCKyn5TKYRiYtj1c9HvWEU1Q+qibIlPVP9cf
         APrwXz/JfOgVZWrijM0tni8oLGPUDFXH/5OtZYqu8QkJTkI2jKLa+g1YrxsSxCKKPOoa
         ftvrT6d0BvzTbXv3Sn/NMFlFjAwAyomnI2FnbzEUiIjwGYlGRJZxhXxZzggv49eHjAh8
         VpFNk5ylCBu1OoDPeSOI5AZBfyVMtnxqQAUVOXvHLSCcylM5CN9zXJ2kVfRtFlWAQwlS
         ldbg==
X-Gm-Message-State: AOAM531iZXgyl9YVp0WywL0kTW+4mtgFdeI2Vda2REf6uMp6liXsES5H
        /kjlFwHWSua0G+VKbgaF2lnYL2DUUauUTYr0P5GcEAcVrMutt2Zlu3aRA5HsmkIMUiGv8IYbyOh
        maxk8RQTnykj+2AULoAkinHs7dHmXRPrPcpE7oKEH
X-Received: by 2002:a05:651c:b09:: with SMTP id b9mr483918ljr.307.1631157627814;
        Wed, 08 Sep 2021 20:20:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrNNWBdfzRqpd0hHATug0rEkH0raRP+nKE3GsytWyK5qBVHKXgHbZ9SQyyQbtj/iuGUtg5YkIJCmFlJ+e1q9w=
X-Received: by 2002:a05:651c:b09:: with SMTP id b9mr483910ljr.307.1631157627568;
 Wed, 08 Sep 2021 20:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com> <CACGkMEuEwbDQUtYHz=0O4pQcb6ibY0MAT7hLDjN=Okw8c9CZGA@mail.gmail.com>
In-Reply-To: <CACGkMEuEwbDQUtYHz=0O4pQcb6ibY0MAT7hLDjN=Okw8c9CZGA@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 9 Sep 2021 11:20:16 +0800
Message-ID: <CACGkMEthdFC2oVOC1AmY13mjZs4B0JxEJc5Pk3jN44waNePH2A@mail.gmail.com>
Subject: Re: [PATCH 0/6] vDPA driver for legacy virtio-pci device
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mst <mst@redhat.com>, wei.yang1@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 11:05 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Wed, Sep 8, 2021 at 8:22 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
> >
> > This series implements the vDPA driver for legacy virtio-pci device.
> > Currently we already have the vDPA driver for modern virtio-pci device
> > only, but there are some legacy virtio-pci devices conforming to the
> > virtio-pci specifications of 0.9.x or older versions. For example,
> > ENI(Elastic Network Interface) of Alibaba ECS baremetal instance is a
> > hardware virtio network device which follows the Virtio PCI Card 0.9.5
> > Draft specification. Such legacy virtio-pci devices have some
> > inconsistent behaviour with modern virtio-pci devices, so some common
> > codes are split out and modern device specific codes are moved to a
> > separated file.
>
> What worries me a little bit are:
>
> 1) vDPA requires IOMMU_PLATFORM to be supported by the device to work,
> if I understand ENI correctly, it's a legacy device so it can't
> support ACCESS_PLATFORM. Or is it a legacy device that supports
> ACCESS_PLATFORM implicitly.
> 2) vDPA tries to present a 1.0 device, in this case the behavior could
> be ruled by the spec. If we tries to present an 1.0 device on top of
> legacy device we may suffer a lot of issues:
>
> - endian issue: 1.0 use le but legacy may use native endian
> - queue_enable semantic which is missed in the legacy
> - virtqueue size, as you mentioned below
>
> I guess what the device(ENI) supports are:
>
> 1) semantic of ACCESS_PLATFORM without a feature
> 2) little endian
> 3) but a legacy device
>
> So I think it might be better:
>
> 1) introduce the library for legacy as you did in this patch
> 2) having a dedicated ENI vDPA driver
>
> 3) live migration support, though it was not supported by the spec
> yet, but we are working on the support, and we know legacy device can

I meant "can't" actually.

Thanks

> support this.
>
> Thanks
>
> >
> > For legacy devices, it is not supported to negotiate the virtqueue size
> > by the specification. So a new callback get_vq_num_unchangeable is
> > introduced to indicate user not to try change the virtqueue size of the
> > legacy vdpa device. For example, QEMU should not allocate memory for
> > virtqueue according to the properties tx_queue_size and rx_queue_size if
> > we use legacy virtio-pci device as the vhost-vdpa backend. Instead, QEMU
> > should use the new callback get_vq_num_unchangeable first to check if
> > the vdpa device support to change virtqueue size. If not, QEMU should
> > call the callback get_vq_num_max to get the static virtqueue size then
> > allocate the same size memory for the virtqueue.
> >
> > This series have been tested with the ENI in Alibaba ECS baremetal
> > instance.
> >
> > These patches may under consideration, welcome for comments.
> >
> >
> > Wu Zongyong (6):
> >   virtio-pci: introduce legacy device module
> >   vdpa: fix typo
> >   vp_vdpa: add vq irq offloading support
> >   vp_vdpa: split out reusable and device specific codes to separate file
> >   vdpa: add get_vq_num_unchangeable callback in vdpa_config_ops
> >   vp_vdpa: introduce legacy virtio pci driver
> >
> >  drivers/vdpa/Kconfig                     |   7 +
> >  drivers/vdpa/virtio_pci/Makefile         |   3 +
> >  drivers/vdpa/virtio_pci/vp_vdpa.c        |   8 +
> >  drivers/vdpa/virtio_pci/vp_vdpa_common.c | 220 ++++++++++++++
> >  drivers/vdpa/virtio_pci/vp_vdpa_common.h |  67 +++++
> >  drivers/vdpa/virtio_pci/vp_vdpa_legacy.c | 346 +++++++++++++++++++++++
> >  drivers/vdpa/virtio_pci/vp_vdpa_modern.c | 327 +++++++++++++++++++++
> >  drivers/vhost/vdpa.c                     |  19 ++
> >  drivers/virtio/Kconfig                   |  10 +
> >  drivers/virtio/Makefile                  |   1 +
> >  drivers/virtio/virtio_pci_common.c       |  10 +-
> >  drivers/virtio/virtio_pci_common.h       |   9 +-
> >  drivers/virtio/virtio_pci_legacy.c       | 101 ++-----
> >  drivers/virtio/virtio_pci_legacy_dev.c   | 220 ++++++++++++++
> >  drivers/virtio/virtio_vdpa.c             |   5 +-
> >  include/linux/vdpa.h                     |   6 +-
> >  include/linux/virtio_pci_legacy.h        |  44 +++
> >  include/uapi/linux/vhost.h               |   2 +
> >  18 files changed, 1320 insertions(+), 85 deletions(-)
> >  create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa_common.c
> >  create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa_common.h
> >  create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa_legacy.c
> >  create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa_modern.c
> >  create mode 100644 drivers/virtio/virtio_pci_legacy_dev.c
> >  create mode 100644 include/linux/virtio_pci_legacy.h
> >
> > --
> > 2.31.1
> >

