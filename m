Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81354043D4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 05:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348758AbhIIDGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 23:06:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49538 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232039AbhIIDG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 23:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631156720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NU5ka/ttka6vOdhYaa9ciTz54egntIe+PWYBKnyBETs=;
        b=EQaNIMKiks7oKOTgJiYAdH6xAvLMyM3p4N7pvuqdx80GtntA12Ti46dig09VJkkpJI6836
        m4Ty9qElLfAAKDmt2JOdIzl4lc0zqHf+uUCj6ED4EBFgZWP4BmWb0ZTIk12zuT4Z6MRwIt
        zj4ddHujBff88FlED/N5vQhBqkaYuOI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-OSsp8-c6NLiPy4W2zSQZ5g-1; Wed, 08 Sep 2021 23:05:19 -0400
X-MC-Unique: OSsp8-c6NLiPy4W2zSQZ5g-1
Received: by mail-lj1-f198.google.com with SMTP id m9-20020a2e5809000000b001dccccc2bf6so153872ljb.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 20:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NU5ka/ttka6vOdhYaa9ciTz54egntIe+PWYBKnyBETs=;
        b=WseM0TfnFkUFfTv8jv3sV2qt/i/rFPdWcW6sm9m5vmvKmdIFYir3SYGUtutijg6eYM
         VrKPXokswf8UN94DKypEDK9VaSoIp3MNf5xygi3GV0l7aAMXacCHibI/Jn/yEI35qCfq
         Ne9u0Aq7NzkGMXwcAegV6Nbl3PjxcqILfEfmHt3QwWNohFp+s5X6Mm4HseTaX6YLWCLp
         7bQ7BcntgPPxcJN2hiA1b+UpVWQ/hhJtA7z/34LWClNnPneTvcZV+tTmwy8G2OjYDogq
         J0U8eKLNYbLYB9ZRVTaA1gtgS8WsVhe6fzsL6yWEftLUd8VrbIxmgGGBVR23Yjxue7Fx
         l81w==
X-Gm-Message-State: AOAM533QNBChPHp0btzoP8njtZl4XVaztKWCbhSb+hxH89ByR2g/s8Iy
        jAd1nrdjCicY0nJvra2mJDhGMdSE0L2q+2Puq6luJoW6dkQozmVRNEp8y/V203zu8kqQUtNMBwq
        7uM2k5ykPhZssFtHRIV1AgWehYdKP150nhwm8wdfl
X-Received: by 2002:a19:6b18:: with SMTP id d24mr694444lfa.84.1631156717372;
        Wed, 08 Sep 2021 20:05:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyf6WWUf+K61c6ZqyObAjKFSDb7DNWOBkoEfX4dffRDBnQyUToBmG4FMDi64K+hRcszK0E9x5ctIJcVAhJHWQ=
X-Received: by 2002:a19:6b18:: with SMTP id d24mr694425lfa.84.1631156717143;
 Wed, 08 Sep 2021 20:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
In-Reply-To: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 9 Sep 2021 11:05:06 +0800
Message-ID: <CACGkMEuEwbDQUtYHz=0O4pQcb6ibY0MAT7hLDjN=Okw8c9CZGA@mail.gmail.com>
Subject: Re: [PATCH 0/6] vDPA driver for legacy virtio-pci device
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mst <mst@redhat.com>, wei.yang1@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 8, 2021 at 8:22 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
>
> This series implements the vDPA driver for legacy virtio-pci device.
> Currently we already have the vDPA driver for modern virtio-pci device
> only, but there are some legacy virtio-pci devices conforming to the
> virtio-pci specifications of 0.9.x or older versions. For example,
> ENI(Elastic Network Interface) of Alibaba ECS baremetal instance is a
> hardware virtio network device which follows the Virtio PCI Card 0.9.5
> Draft specification. Such legacy virtio-pci devices have some
> inconsistent behaviour with modern virtio-pci devices, so some common
> codes are split out and modern device specific codes are moved to a
> separated file.

What worries me a little bit are:

1) vDPA requires IOMMU_PLATFORM to be supported by the device to work,
if I understand ENI correctly, it's a legacy device so it can't
support ACCESS_PLATFORM. Or is it a legacy device that supports
ACCESS_PLATFORM implicitly.
2) vDPA tries to present a 1.0 device, in this case the behavior could
be ruled by the spec. If we tries to present an 1.0 device on top of
legacy device we may suffer a lot of issues:

- endian issue: 1.0 use le but legacy may use native endian
- queue_enable semantic which is missed in the legacy
- virtqueue size, as you mentioned below

I guess what the device(ENI) supports are:

1) semantic of ACCESS_PLATFORM without a feature
2) little endian
3) but a legacy device

So I think it might be better:

1) introduce the library for legacy as you did in this patch
2) having a dedicated ENI vDPA driver

3) live migration support, though it was not supported by the spec
yet, but we are working on the support, and we know legacy device can
support this.

Thanks

>
> For legacy devices, it is not supported to negotiate the virtqueue size
> by the specification. So a new callback get_vq_num_unchangeable is
> introduced to indicate user not to try change the virtqueue size of the
> legacy vdpa device. For example, QEMU should not allocate memory for
> virtqueue according to the properties tx_queue_size and rx_queue_size if
> we use legacy virtio-pci device as the vhost-vdpa backend. Instead, QEMU
> should use the new callback get_vq_num_unchangeable first to check if
> the vdpa device support to change virtqueue size. If not, QEMU should
> call the callback get_vq_num_max to get the static virtqueue size then
> allocate the same size memory for the virtqueue.
>
> This series have been tested with the ENI in Alibaba ECS baremetal
> instance.
>
> These patches may under consideration, welcome for comments.
>
>
> Wu Zongyong (6):
>   virtio-pci: introduce legacy device module
>   vdpa: fix typo
>   vp_vdpa: add vq irq offloading support
>   vp_vdpa: split out reusable and device specific codes to separate file
>   vdpa: add get_vq_num_unchangeable callback in vdpa_config_ops
>   vp_vdpa: introduce legacy virtio pci driver
>
>  drivers/vdpa/Kconfig                     |   7 +
>  drivers/vdpa/virtio_pci/Makefile         |   3 +
>  drivers/vdpa/virtio_pci/vp_vdpa.c        |   8 +
>  drivers/vdpa/virtio_pci/vp_vdpa_common.c | 220 ++++++++++++++
>  drivers/vdpa/virtio_pci/vp_vdpa_common.h |  67 +++++
>  drivers/vdpa/virtio_pci/vp_vdpa_legacy.c | 346 +++++++++++++++++++++++
>  drivers/vdpa/virtio_pci/vp_vdpa_modern.c | 327 +++++++++++++++++++++
>  drivers/vhost/vdpa.c                     |  19 ++
>  drivers/virtio/Kconfig                   |  10 +
>  drivers/virtio/Makefile                  |   1 +
>  drivers/virtio/virtio_pci_common.c       |  10 +-
>  drivers/virtio/virtio_pci_common.h       |   9 +-
>  drivers/virtio/virtio_pci_legacy.c       | 101 ++-----
>  drivers/virtio/virtio_pci_legacy_dev.c   | 220 ++++++++++++++
>  drivers/virtio/virtio_vdpa.c             |   5 +-
>  include/linux/vdpa.h                     |   6 +-
>  include/linux/virtio_pci_legacy.h        |  44 +++
>  include/uapi/linux/vhost.h               |   2 +
>  18 files changed, 1320 insertions(+), 85 deletions(-)
>  create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa_common.c
>  create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa_common.h
>  create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa_legacy.c
>  create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa_modern.c
>  create mode 100644 drivers/virtio/virtio_pci_legacy_dev.c
>  create mode 100644 include/linux/virtio_pci_legacy.h
>
> --
> 2.31.1
>

