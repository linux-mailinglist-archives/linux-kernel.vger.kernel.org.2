Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583D543C102
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 05:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237869AbhJ0D5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 23:57:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48767 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232997AbhJ0D5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 23:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635306921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kVqNfdWDUHCQKXJrITofF7QQ4FEQHs0Fart2If3uDDI=;
        b=Oi12HFC+6qrSLJelku/fL2S91CLR/QXD7lOSzwrvje35I/PycZ1YxwrAfad9Lm6gpurjzJ
        SvqRdrDGcIPKha/DdxODGI0ndKB+Z40EbZFZ3/rn3IzggeEfVbcQXrqHs/Xc5ctBWlvfZC
        lV7bwFLSKJuDQYo6jdRKri//0AfxTgw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-cS-5eXNtNLK-bNZioy-Zkw-1; Tue, 26 Oct 2021 23:55:18 -0400
X-MC-Unique: cS-5eXNtNLK-bNZioy-Zkw-1
Received: by mail-lf1-f69.google.com with SMTP id g10-20020a05651222ca00b003fda3f05c17so741905lfu.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 20:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kVqNfdWDUHCQKXJrITofF7QQ4FEQHs0Fart2If3uDDI=;
        b=1U8ENvntppDbPHfxFtBjUq/ki9Xrghr8GsiO/HRrNDMtoxTJtUkXxAwRhd/V9woPIe
         eHDTUX3Zx03Jx3fvM/sqMgKjYRqk7K27Ty8/iNvwraUIcFGI9T7HfFbHICSPsaO2HdK6
         QHUCoeACHXEmof66WLumzqIKtDnuOCvWk+V9/BTJMv4ucC8mmYGO3gBY7DTFw61JVLjP
         KgsSKP2EdQHrKeoRJmvf8toCQmXPZmwgdYRjWhyX2MjX6RsR2CqqQKNPpgv4yWDxs+8Z
         q9VP6iIM/DODDAoyEQomGyKd0eh8KmTuvSyjltTNmitJWOT3mCObdELNp/yX79XKSJSx
         Gl5w==
X-Gm-Message-State: AOAM5304VRdU0PA4n0RpC5DlgxrZwr226JJn15bhsRuFcnFjJysoT/ac
        zJAxEi9X6NG7PxJhtuWKXO46ykgI+NwqxkIqap8o8VpB+IpmWutON6Gw2odER51rXQI6F42BPo1
        te/AZcUNy2bd4ans7K2yoHuGI7uGTZfKJjk2fpQl8
X-Received: by 2002:a2e:8605:: with SMTP id a5mr11872391lji.107.1635306917061;
        Tue, 26 Oct 2021 20:55:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwj/LtE8SHNat9Y5XU5aLzYeLFq1QPJw+Xm/GrvXudS+w+x3/YVie6X+EgXVkJEPLNG8pLdiZwnct90ts+pjA4=
X-Received: by 2002:a2e:8605:: with SMTP id a5mr11872357lji.107.1635306916714;
 Tue, 26 Oct 2021 20:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <cover.1634870456.git.wuzongyong@linux.alibaba.com> <6496b76a64303a3e23ea19e3e279644608de36fb.1634870456.git.wuzongyong@linux.alibaba.com>
 <CACGkMEvi7505ZOSLP6gMMvhC=Zfdt=nPK4WEYe7=VVbq3GmxCQ@mail.gmail.com>
 <20211025032146.GC3684@L-PF27918B-1352.localdomain> <51e9be5b-4bb2-b82b-a152-ffc37803410c@redhat.com>
 <20211027024700.GA23409@L-PF27918B-1352.localdomain>
In-Reply-To: <20211027024700.GA23409@L-PF27918B-1352.localdomain>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 27 Oct 2021 11:55:05 +0800
Message-ID: <CACGkMEt=ywKYQPhyUYjucEmW7hszNWWrRDYgRB_eyqci4uMO=w@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] eni_vdpa: add vDPA driver for Alibaba ENI
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mst <mst@redhat.com>, wei.yang1@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 10:47 AM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> On Mon, Oct 25, 2021 at 12:40:41PM +0800, Jason Wang wrote:
> >
> > =E5=9C=A8 2021/10/25 =E4=B8=8A=E5=8D=8811:21, Wu Zongyong =E5=86=99=E9=
=81=93:
> > > On Mon, Oct 25, 2021 at 10:27:31AM +0800, Jason Wang wrote:
> > > > On Fri, Oct 22, 2021 at 10:44 AM Wu Zongyong
> > > > <wuzongyong@linux.alibaba.com> wrote:
> > > > > This patch adds a new vDPA driver for Alibaba ENI(Elastic Network
> > > > > Interface) which is build upon virtio 0.9.5 specification.
> > > > > And this driver doesn't support to run on BE host.
> > > > >
> > > > > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> > > > > ---
> > > > >   drivers/vdpa/Kconfig            |   8 +
> > > > >   drivers/vdpa/Makefile           |   1 +
> > > > >   drivers/vdpa/alibaba/Makefile   |   3 +
> > > > >   drivers/vdpa/alibaba/eni_vdpa.c | 553 +++++++++++++++++++++++++=
+++++++
> > > > >   4 files changed, 565 insertions(+)
> > > > >   create mode 100644 drivers/vdpa/alibaba/Makefile
> > > > >   create mode 100644 drivers/vdpa/alibaba/eni_vdpa.c
> > > > >
> > > > > diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> > > > > index 3d91982d8371..c0232a2148a7 100644
> > > > > --- a/drivers/vdpa/Kconfig
> > > > > +++ b/drivers/vdpa/Kconfig
> > > > > @@ -78,4 +78,12 @@ config VP_VDPA
> > > > >          help
> > > > >            This kernel module bridges virtio PCI device to vDPA b=
us.
> > > > >
> > > > > +config ALIBABA_ENI_VDPA
> > > > > +       tristate "vDPA driver for Alibaba ENI"
> > > > > +       select VIRTIO_PCI_LEGACY_LIB
> > > > > +       depends on PCI_MSI && !CPU_BIG_ENDIAN
> > > > > +       help
> > > > > +         VDPA driver for Alibaba ENI(Elastic Network Interface) =
which is build upon
> > > > > +         virtio 0.9.5 specification.
> > > > > +
> > > > >   endif # VDPA
> > > > > diff --git a/drivers/vdpa/Makefile b/drivers/vdpa/Makefile
> > > > > index f02ebed33f19..15665563a7f4 100644
> > > > > --- a/drivers/vdpa/Makefile
> > > > > +++ b/drivers/vdpa/Makefile
> > > > > @@ -5,3 +5,4 @@ obj-$(CONFIG_VDPA_USER) +=3D vdpa_user/
> > > > >   obj-$(CONFIG_IFCVF)    +=3D ifcvf/
> > > > >   obj-$(CONFIG_MLX5_VDPA) +=3D mlx5/
> > > > >   obj-$(CONFIG_VP_VDPA)    +=3D virtio_pci/
> > > > > +obj-$(CONFIG_ALIBABA_ENI_VDPA) +=3D alibaba/
> > > > > diff --git a/drivers/vdpa/alibaba/Makefile b/drivers/vdpa/alibaba=
/Makefile
> > > > > new file mode 100644
> > > > > index 000000000000..ef4aae69f87a
> > > > > --- /dev/null
> > > > > +++ b/drivers/vdpa/alibaba/Makefile
> > > > > @@ -0,0 +1,3 @@
> > > > > +# SPDX-License-Identifier: GPL-2.0
> > > > > +obj-$(CONFIG_ALIBABA_ENI_VDPA) +=3D eni_vdpa.o
> > > > > +
> > > > > diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/aliba=
ba/eni_vdpa.c
> > > > > new file mode 100644
> > > > > index 000000000000..6a09f157d810
> > > > > --- /dev/null
> > > > > +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> > > > > @@ -0,0 +1,553 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > +/*
> > > > > + * vDPA bridge driver for Alibaba ENI(Elastic Network Interface)
> > > > > + *
> > > > > + * Copyright (c) 2021, Alibaba Inc. All rights reserved.
> > > > > + * Author: Wu Zongyong <wuzongyong@linux.alibaba.com>
> > > > > + *
> > > > > + */
> > > > > +
> > > > > +#include "linux/bits.h"
> > > > > +#include <linux/interrupt.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/pci.h>
> > > > > +#include <linux/vdpa.h>
> > > > > +#include <linux/virtio.h>
> > > > > +#include <linux/virtio_config.h>
> > > > > +#include <linux/virtio_ring.h>
> > > > > +#include <linux/virtio_pci.h>
> > > > > +#include <linux/virtio_pci_legacy.h>
> > > > > +#include <uapi/linux/virtio_net.h>
> > > > > +
> > > > > +#define ENI_MSIX_NAME_SIZE 256
> > > > > +
> > > > > +#define ENI_ERR(pdev, fmt, ...)        \
> > > > > +       dev_err(&pdev->dev, "%s"fmt, "eni_vdpa: ", ##__VA_ARGS__)
> > > > > +#define ENI_DBG(pdev, fmt, ...)        \
> > > > > +       dev_dbg(&pdev->dev, "%s"fmt, "eni_vdpa: ", ##__VA_ARGS__)
> > > > > +#define ENI_INFO(pdev, fmt, ...) \
> > > > > +       dev_info(&pdev->dev, "%s"fmt, "eni_vdpa: ", ##__VA_ARGS__=
)
> > > > > +
> > > > > +struct eni_vring {
> > > > > +       void __iomem *notify;
> > > > > +       char msix_name[ENI_MSIX_NAME_SIZE];
> > > > > +       struct vdpa_callback cb;
> > > > > +       int irq;
> > > > > +};
> > > > > +
> > > > > +struct eni_vdpa {
> > > > > +       struct vdpa_device vdpa;
> > > > > +       struct virtio_pci_legacy_device ldev;
> > > > > +       struct eni_vring *vring;
> > > > > +       struct vdpa_callback config_cb;
> > > > > +       char msix_name[ENI_MSIX_NAME_SIZE];
> > > > > +       int config_irq;
> > > > > +       int queues;
> > > > > +       int vectors;
> > > > > +};
> > > > > +
> > > > > +static struct eni_vdpa *vdpa_to_eni(struct vdpa_device *vdpa)
> > > > > +{
> > > > > +       return container_of(vdpa, struct eni_vdpa, vdpa);
> > > > > +}
> > > > > +
> > > > > +static struct virtio_pci_legacy_device *vdpa_to_ldev(struct vdpa=
_device *vdpa)
> > > > > +{
> > > > > +       struct eni_vdpa *eni_vdpa =3D vdpa_to_eni(vdpa);
> > > > > +
> > > > > +       return &eni_vdpa->ldev;
> > > > > +}
> > > > > +
> > > > > +static u64 eni_vdpa_get_features(struct vdpa_device *vdpa)
> > > > > +{
> > > > > +       struct virtio_pci_legacy_device *ldev =3D vdpa_to_ldev(vd=
pa);
> > > > > +       u64 features =3D vp_legacy_get_features(ldev);
> > > > > +
> > > > > +       features |=3D BIT_ULL(VIRTIO_F_ACCESS_PLATFORM);
> > > > > +       features |=3D BIT_ULL(VIRTIO_F_ORDER_PLATFORM);
> > > > > +
> > > > > +       return features;
> > > > > +}
> > > > > +
> > > > > +static int eni_vdpa_set_features(struct vdpa_device *vdpa, u64 f=
eatures)
> > > > > +{
> > > > > +       struct virtio_pci_legacy_device *ldev =3D vdpa_to_ldev(vd=
pa);
> > > > > +
> > > > > +       if (!(features & BIT_ULL(VIRTIO_NET_F_MRG_RXBUF)) && feat=
ures) {
> > > > > +               ENI_ERR(ldev->pci_dev,
> > > > > +                       "VIRTIO_NET_F_MRG_RXBUF is not negotiated=
\n");
> > > > > +               return -EINVAL;
> > > > > +       }
> > > > > +
> > > > > +       vp_legacy_set_features(ldev, (u32)features);
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > So my comments have not been addressed since v4. Please address or
> > > > answer the questions before posting a new version.
> > > >
> > > > Thanks
> > > Sorry, I forgot to reply the comments on this patch.
> > >
> > >
> > > > > +static u64 eni_vdpa_get_features(struct vdpa_device *vdpa)
> > > > > +{
> > > > > +     struct virtio_pci_legacy_device *ldev =3D vdpa_to_ldev(vdpa=
);
> > > > > +     u64 features =3D vp_legacy_get_features(ldev);
> > > > > +
> > > > > +     features |=3D BIT_ULL(VIRTIO_F_ACCESS_PLATFORM);
> > > > > +     features |=3D BIT_ULL(VIRTIO_F_ORDER_PLATFORM);
> > > > VERSION_1 is also needed?
> > > >
> > > No, queue align of legacy devices should be 4096,
> >
> >
> > Let's use VIRTIO_PCI_VRING_ALIGN instead of PAGE_SIZE in get_vq_align t=
hen
> > since PAGE_SIZE is not necessarily 4096.
>
> I will fix it.
> >
> >
> > >   but queue align of
> > > devices with VERSION_1 are SMP_CACHE_BYTES which may not equals to
> > > 4096.
> > > If we set the VERSION_1, ENI will not work due to the queue align.
> >
> >
> > Interesting, so I think it can only be used with legacy virtio drivers =
in
> > the guest.
> Yes, ENI can only work well with legacy virtio drivers in the guest from
> my test.
>
> >
> > One major drawbacks is that guest can only see 32 feature bits which me=
ans
> > we can't advertise VIRTIO_F_ACCESS_PLATFORM and VIRTIO_F_ORDER_PLATFORM=
 to
> > guest:
> >
> > /* virtio config->get_features() implementation */
> > static u64 vp_get_features(struct virtio_device *vdev)
> > {
> >         struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
> >
> >         /* When someone needs more than 32 feature bits, we'll need to
> >          * steal a bit to indicate that the rest are somewhere else. */
> >         return ioread32(vp_dev->ioaddr + VIRTIO_PCI_HOST_FEATURES);
> > }
> >
> > For VIRTIO_F_ACCESS_PLATFORM, it should be fine. But how about
> > VIRTIO_F_ORDER_PLATFORM?
> >
> Is it necessary to advertise these two bits?
> ENI works well without these two bits regardless of bare metal or virtual
> machine.

For VIRTIO_F_ACCESS_PLATFORM. When using with virtio-vDPA it should be
fine since it will be negotiated. When using with vhost-vDPA, it can't
be advertised to the guest, so vIOMMU will be bypassed.

For VITIO_F_ORDER_PLATFORM, it's basically a question that whether
platform specific barrier (DMA barrier) is needed, see virtio_rmb():

static inline void virtio_rmb(bool weak_barriers)
{
        if (weak_barriers)
                virt_rmb();
        else
                dma_rmb();
}

So it looks to me x86 should be fine, but for others platform it might
not. Maybe we can enable this driver for x86 first.

Thanks

> >
> > >
> > > > > +
> > > > > +     return features;
> > > > > +}
> > > > > +
> > > > > +static int eni_vdpa_set_features(struct vdpa_device *vdpa, u64 f=
eatures)
> > > > > +{
> > > > > +     struct virtio_pci_legacy_device *ldev =3D vdpa_to_ldev(vdpa=
);
> > > > > +
> > > > > +     if (!(features & BIT_ULL(VIRTIO_NET_F_MRG_RXBUF)) && featur=
es) {
> > > > > +             ENI_ERR(ldev->pci_dev,
> > > > > +                     "VIRTIO_NET_F_MRG_RXBUF is not negotiated\n=
");
> > > > > +             return -EINVAL;
> > > > Do we need to make sure FEATURE_OK is not set in this case or the E=
NI can do
> > > > this for us?
> > > Why we need to check this? I don't get what you worried about.
> >
> >
> > I thought the plan is to advertise the VERSION_1, so failing when witho=
ut
> > mrg_rxbuf is a must. But looks like I was wrong, and there's no need to
> > mandate mrg_rxbuf in future versions.
>
> I think it is necessary to check F_MRG_RXBUF here, since ENI will not
> work when use qemu with mrx_rxbuf=3Doff.
> >
> > Thanks
> >
> >
> > >
> > > > Other looks good.
> > > >
> > > > Thanks
>

