Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CFF405508
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 15:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358557AbhIINHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 09:07:40 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:33245 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356333AbhIIMys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 08:54:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UnoEUsl_1631192017;
Received: from localhost(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0UnoEUsl_1631192017)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 09 Sep 2021 20:53:38 +0800
Date:   Thu, 9 Sep 2021 20:53:38 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mst <mst@redhat.com>, wei.yang1@linux.alibaba.com
Subject: Re: [PATCH 0/6] vDPA driver for legacy virtio-pci device
Message-ID: <20210909125338.GA17535@L-PF27918B-1352.localdomain>
Reply-To: Wu Zongyong <wuzongyong@linux.alibaba.com>
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <CACGkMEuEwbDQUtYHz=0O4pQcb6ibY0MAT7hLDjN=Okw8c9CZGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEuEwbDQUtYHz=0O4pQcb6ibY0MAT7hLDjN=Okw8c9CZGA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 11:05:06AM +0800, Jason Wang wrote:
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

Would you mind I place the ENI vDPA driver inside virtio_pci folder? Or
should I create a new folder for it?

> 
> 3) live migration support, though it was not supported by the spec
> yet, but we are working on the support, and we know legacy device can
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
