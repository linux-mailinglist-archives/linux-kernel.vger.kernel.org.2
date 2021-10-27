Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F0143C034
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 04:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238599AbhJ0Ct2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 22:49:28 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:44031 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238184AbhJ0Ct1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 22:49:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Utq7WXl_1635302820;
Received: from localhost(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0Utq7WXl_1635302820)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Oct 2021 10:47:00 +0800
Date:   Wed, 27 Oct 2021 10:47:00 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mst <mst@redhat.com>, wei.yang1@linux.alibaba.com
Subject: Re: [PATCH v6 8/8] eni_vdpa: add vDPA driver for Alibaba ENI
Message-ID: <20211027024700.GA23409@L-PF27918B-1352.localdomain>
Reply-To: Wu Zongyong <wuzongyong@linux.alibaba.com>
References: <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <cover.1634870456.git.wuzongyong@linux.alibaba.com>
 <6496b76a64303a3e23ea19e3e279644608de36fb.1634870456.git.wuzongyong@linux.alibaba.com>
 <CACGkMEvi7505ZOSLP6gMMvhC=Zfdt=nPK4WEYe7=VVbq3GmxCQ@mail.gmail.com>
 <20211025032146.GC3684@L-PF27918B-1352.localdomain>
 <51e9be5b-4bb2-b82b-a152-ffc37803410c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51e9be5b-4bb2-b82b-a152-ffc37803410c@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 12:40:41PM +0800, Jason Wang wrote:
> 
> 在 2021/10/25 上午11:21, Wu Zongyong 写道:
> > On Mon, Oct 25, 2021 at 10:27:31AM +0800, Jason Wang wrote:
> > > On Fri, Oct 22, 2021 at 10:44 AM Wu Zongyong
> > > <wuzongyong@linux.alibaba.com> wrote:
> > > > This patch adds a new vDPA driver for Alibaba ENI(Elastic Network
> > > > Interface) which is build upon virtio 0.9.5 specification.
> > > > And this driver doesn't support to run on BE host.
> > > > 
> > > > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> > > > ---
> > > >   drivers/vdpa/Kconfig            |   8 +
> > > >   drivers/vdpa/Makefile           |   1 +
> > > >   drivers/vdpa/alibaba/Makefile   |   3 +
> > > >   drivers/vdpa/alibaba/eni_vdpa.c | 553 ++++++++++++++++++++++++++++++++
> > > >   4 files changed, 565 insertions(+)
> > > >   create mode 100644 drivers/vdpa/alibaba/Makefile
> > > >   create mode 100644 drivers/vdpa/alibaba/eni_vdpa.c
> > > > 
> > > > diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> > > > index 3d91982d8371..c0232a2148a7 100644
> > > > --- a/drivers/vdpa/Kconfig
> > > > +++ b/drivers/vdpa/Kconfig
> > > > @@ -78,4 +78,12 @@ config VP_VDPA
> > > >          help
> > > >            This kernel module bridges virtio PCI device to vDPA bus.
> > > > 
> > > > +config ALIBABA_ENI_VDPA
> > > > +       tristate "vDPA driver for Alibaba ENI"
> > > > +       select VIRTIO_PCI_LEGACY_LIB
> > > > +       depends on PCI_MSI && !CPU_BIG_ENDIAN
> > > > +       help
> > > > +         VDPA driver for Alibaba ENI(Elastic Network Interface) which is build upon
> > > > +         virtio 0.9.5 specification.
> > > > +
> > > >   endif # VDPA
> > > > diff --git a/drivers/vdpa/Makefile b/drivers/vdpa/Makefile
> > > > index f02ebed33f19..15665563a7f4 100644
> > > > --- a/drivers/vdpa/Makefile
> > > > +++ b/drivers/vdpa/Makefile
> > > > @@ -5,3 +5,4 @@ obj-$(CONFIG_VDPA_USER) += vdpa_user/
> > > >   obj-$(CONFIG_IFCVF)    += ifcvf/
> > > >   obj-$(CONFIG_MLX5_VDPA) += mlx5/
> > > >   obj-$(CONFIG_VP_VDPA)    += virtio_pci/
> > > > +obj-$(CONFIG_ALIBABA_ENI_VDPA) += alibaba/
> > > > diff --git a/drivers/vdpa/alibaba/Makefile b/drivers/vdpa/alibaba/Makefile
> > > > new file mode 100644
> > > > index 000000000000..ef4aae69f87a
> > > > --- /dev/null
> > > > +++ b/drivers/vdpa/alibaba/Makefile
> > > > @@ -0,0 +1,3 @@
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +obj-$(CONFIG_ALIBABA_ENI_VDPA) += eni_vdpa.o
> > > > +
> > > > diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
> > > > new file mode 100644
> > > > index 000000000000..6a09f157d810
> > > > --- /dev/null
> > > > +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> > > > @@ -0,0 +1,553 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * vDPA bridge driver for Alibaba ENI(Elastic Network Interface)
> > > > + *
> > > > + * Copyright (c) 2021, Alibaba Inc. All rights reserved.
> > > > + * Author: Wu Zongyong <wuzongyong@linux.alibaba.com>
> > > > + *
> > > > + */
> > > > +
> > > > +#include "linux/bits.h"
> > > > +#include <linux/interrupt.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/pci.h>
> > > > +#include <linux/vdpa.h>
> > > > +#include <linux/virtio.h>
> > > > +#include <linux/virtio_config.h>
> > > > +#include <linux/virtio_ring.h>
> > > > +#include <linux/virtio_pci.h>
> > > > +#include <linux/virtio_pci_legacy.h>
> > > > +#include <uapi/linux/virtio_net.h>
> > > > +
> > > > +#define ENI_MSIX_NAME_SIZE 256
> > > > +
> > > > +#define ENI_ERR(pdev, fmt, ...)        \
> > > > +       dev_err(&pdev->dev, "%s"fmt, "eni_vdpa: ", ##__VA_ARGS__)
> > > > +#define ENI_DBG(pdev, fmt, ...)        \
> > > > +       dev_dbg(&pdev->dev, "%s"fmt, "eni_vdpa: ", ##__VA_ARGS__)
> > > > +#define ENI_INFO(pdev, fmt, ...) \
> > > > +       dev_info(&pdev->dev, "%s"fmt, "eni_vdpa: ", ##__VA_ARGS__)
> > > > +
> > > > +struct eni_vring {
> > > > +       void __iomem *notify;
> > > > +       char msix_name[ENI_MSIX_NAME_SIZE];
> > > > +       struct vdpa_callback cb;
> > > > +       int irq;
> > > > +};
> > > > +
> > > > +struct eni_vdpa {
> > > > +       struct vdpa_device vdpa;
> > > > +       struct virtio_pci_legacy_device ldev;
> > > > +       struct eni_vring *vring;
> > > > +       struct vdpa_callback config_cb;
> > > > +       char msix_name[ENI_MSIX_NAME_SIZE];
> > > > +       int config_irq;
> > > > +       int queues;
> > > > +       int vectors;
> > > > +};
> > > > +
> > > > +static struct eni_vdpa *vdpa_to_eni(struct vdpa_device *vdpa)
> > > > +{
> > > > +       return container_of(vdpa, struct eni_vdpa, vdpa);
> > > > +}
> > > > +
> > > > +static struct virtio_pci_legacy_device *vdpa_to_ldev(struct vdpa_device *vdpa)
> > > > +{
> > > > +       struct eni_vdpa *eni_vdpa = vdpa_to_eni(vdpa);
> > > > +
> > > > +       return &eni_vdpa->ldev;
> > > > +}
> > > > +
> > > > +static u64 eni_vdpa_get_features(struct vdpa_device *vdpa)
> > > > +{
> > > > +       struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> > > > +       u64 features = vp_legacy_get_features(ldev);
> > > > +
> > > > +       features |= BIT_ULL(VIRTIO_F_ACCESS_PLATFORM);
> > > > +       features |= BIT_ULL(VIRTIO_F_ORDER_PLATFORM);
> > > > +
> > > > +       return features;
> > > > +}
> > > > +
> > > > +static int eni_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
> > > > +{
> > > > +       struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> > > > +
> > > > +       if (!(features & BIT_ULL(VIRTIO_NET_F_MRG_RXBUF)) && features) {
> > > > +               ENI_ERR(ldev->pci_dev,
> > > > +                       "VIRTIO_NET_F_MRG_RXBUF is not negotiated\n");
> > > > +               return -EINVAL;
> > > > +       }
> > > > +
> > > > +       vp_legacy_set_features(ldev, (u32)features);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > So my comments have not been addressed since v4. Please address or
> > > answer the questions before posting a new version.
> > > 
> > > Thanks
> > Sorry, I forgot to reply the comments on this patch.
> > 
> > 
> > > > +static u64 eni_vdpa_get_features(struct vdpa_device *vdpa)
> > > > +{
> > > > +     struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> > > > +     u64 features = vp_legacy_get_features(ldev);
> > > > +
> > > > +     features |= BIT_ULL(VIRTIO_F_ACCESS_PLATFORM);
> > > > +     features |= BIT_ULL(VIRTIO_F_ORDER_PLATFORM);
> > > VERSION_1 is also needed?
> > > 
> > No, queue align of legacy devices should be 4096,
> 
> 
> Let's use VIRTIO_PCI_VRING_ALIGN instead of PAGE_SIZE in get_vq_align then
> since PAGE_SIZE is not necessarily 4096.

I will fix it.
> 
> 
> >   but queue align of
> > devices with VERSION_1 are SMP_CACHE_BYTES which may not equals to
> > 4096.
> > If we set the VERSION_1, ENI will not work due to the queue align.
> 
> 
> Interesting, so I think it can only be used with legacy virtio drivers in
> the guest.
Yes, ENI can only work well with legacy virtio drivers in the guest from
my test.

> 
> One major drawbacks is that guest can only see 32 feature bits which means
> we can't advertise VIRTIO_F_ACCESS_PLATFORM and VIRTIO_F_ORDER_PLATFORM to
> guest:
> 
> /* virtio config->get_features() implementation */
> static u64 vp_get_features(struct virtio_device *vdev)
> {
>         struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> 
>         /* When someone needs more than 32 feature bits, we'll need to
>          * steal a bit to indicate that the rest are somewhere else. */
>         return ioread32(vp_dev->ioaddr + VIRTIO_PCI_HOST_FEATURES);
> }
> 
> For VIRTIO_F_ACCESS_PLATFORM, it should be fine. But how about
> VIRTIO_F_ORDER_PLATFORM?
> 
Is it necessary to advertise these two bits?
ENI works well without these two bits regardless of baremetal or virtual
machine.
> 
> > 
> > > > +
> > > > +     return features;
> > > > +}
> > > > +
> > > > +static int eni_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
> > > > +{
> > > > +     struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> > > > +
> > > > +     if (!(features & BIT_ULL(VIRTIO_NET_F_MRG_RXBUF)) && features) {
> > > > +             ENI_ERR(ldev->pci_dev,
> > > > +                     "VIRTIO_NET_F_MRG_RXBUF is not negotiated\n");
> > > > +             return -EINVAL;
> > > Do we need to make sure FEATURE_OK is not set in this case or the ENI can do
> > > this for us?
> > Why we need to check this? I don't get what you worried about.
> 
> 
> I thought the plan is to advertise the VERSION_1, so failing when without
> mrg_rxbuf is a must. But looks like I was wrong, and there's no need to
> mandate mrg_rxbuf in future versions.

I think it is necessary to check F_MRG_RXBUF here, since ENI will not
work when use qemu with mrx_rxbuf=off.
> 
> Thanks
> 
> 
> > 
> > > Other looks good.
> > > 
> > > Thanks
