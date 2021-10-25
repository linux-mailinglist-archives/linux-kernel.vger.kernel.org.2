Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DE3438D78
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 04:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhJYCaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 22:30:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26513 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229706AbhJYCaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 22:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635128865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S8uyGOiIGZbLFaG8vZJP6/O6+Uxymzsqc0XA6VlvcyM=;
        b=INBDuo5kAaln+W1NJ39ZveeSFkLfWRaR2of+/iCPJ3pAObF89JLW2I0Ii1h20zDQV4Z+2D
        T4TFNDb4OrE29at2FmWwy4DH+VJ2lBolYoppmOChGt9BujfeRlN8FoS8FBF3yP/uTSfuyq
        zVXztAo0R/2gRDqSI43dCripiUvKp/w=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-KzrucL5ePmWJ2ZrXlqMRxA-1; Sun, 24 Oct 2021 22:27:44 -0400
X-MC-Unique: KzrucL5ePmWJ2ZrXlqMRxA-1
Received: by mail-lf1-f69.google.com with SMTP id j22-20020a05651231d600b003ffacdb8311so390334lfe.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 19:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S8uyGOiIGZbLFaG8vZJP6/O6+Uxymzsqc0XA6VlvcyM=;
        b=QcQP0PIXxdoICo5DvZ2nmUQoudZlx7rhcw57NVtQ3TWJJzBTGM80UMh+pQq4s9P4Qh
         m0iEpIgSKn3yFeqPnWCFx8GFD2s2Tt9ZDdP2d7Gvpb/vovbE+J6NOyCks6Gw8B5rHOh1
         LzU6Ax8r2vEuDIW0jAboBIKbp4F2pEJya/BBxB/ILXCOth/oG2eYYBL7JAcPtlNq2zMr
         itc5FmvMkW6WwUuS9Ok/pvikRuz16+sySMjzfmp1G7+cLaLLs6H9ZOexZB/YgO6Kp9zu
         ZRkxQivgygedNowNm0o91DPQXuv3cbfPrLi4QqAAKpPrkmGyVqRyvL0P145ZNOh/v4GS
         i7Yw==
X-Gm-Message-State: AOAM533/FxbI629b06P8aE20IoHXa4mCfQeHFBrzR713MTYOY6n8VvF4
        OpVyleykFmffQj9QxkQZcb8+RBYGE21np+m0+lhwsKT33I5T9ydqIb1TdjQ9m+xlvHzSIXjbnsU
        h3OfYlPITY6vabOS9n7fFznR8ZxrijqTalpq7512M
X-Received: by 2002:a05:6512:128a:: with SMTP id u10mr14648197lfs.84.1635128862923;
        Sun, 24 Oct 2021 19:27:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2gyBtC/WMAeyGq5kx7faKSbkeCJpKNkqxtJrv3rWm498mSd1NSPUJrekmZvNcnHRl7jEyBvrgp8ZfLoCVhdo=
X-Received: by 2002:a05:6512:128a:: with SMTP id u10mr14648182lfs.84.1635128862722;
 Sun, 24 Oct 2021 19:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <cover.1634870456.git.wuzongyong@linux.alibaba.com> <6496b76a64303a3e23ea19e3e279644608de36fb.1634870456.git.wuzongyong@linux.alibaba.com>
In-Reply-To: <6496b76a64303a3e23ea19e3e279644608de36fb.1634870456.git.wuzongyong@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 25 Oct 2021 10:27:31 +0800
Message-ID: <CACGkMEvi7505ZOSLP6gMMvhC=Zfdt=nPK4WEYe7=VVbq3GmxCQ@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] eni_vdpa: add vDPA driver for Alibaba ENI
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mst <mst@redhat.com>, wei.yang1@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 10:44 AM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> This patch adds a new vDPA driver for Alibaba ENI(Elastic Network
> Interface) which is build upon virtio 0.9.5 specification.
> And this driver doesn't support to run on BE host.
>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> ---
>  drivers/vdpa/Kconfig            |   8 +
>  drivers/vdpa/Makefile           |   1 +
>  drivers/vdpa/alibaba/Makefile   |   3 +
>  drivers/vdpa/alibaba/eni_vdpa.c | 553 ++++++++++++++++++++++++++++++++
>  4 files changed, 565 insertions(+)
>  create mode 100644 drivers/vdpa/alibaba/Makefile
>  create mode 100644 drivers/vdpa/alibaba/eni_vdpa.c
>
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 3d91982d8371..c0232a2148a7 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -78,4 +78,12 @@ config VP_VDPA
>         help
>           This kernel module bridges virtio PCI device to vDPA bus.
>
> +config ALIBABA_ENI_VDPA
> +       tristate "vDPA driver for Alibaba ENI"
> +       select VIRTIO_PCI_LEGACY_LIB
> +       depends on PCI_MSI && !CPU_BIG_ENDIAN
> +       help
> +         VDPA driver for Alibaba ENI(Elastic Network Interface) which is build upon
> +         virtio 0.9.5 specification.
> +
>  endif # VDPA
> diff --git a/drivers/vdpa/Makefile b/drivers/vdpa/Makefile
> index f02ebed33f19..15665563a7f4 100644
> --- a/drivers/vdpa/Makefile
> +++ b/drivers/vdpa/Makefile
> @@ -5,3 +5,4 @@ obj-$(CONFIG_VDPA_USER) += vdpa_user/
>  obj-$(CONFIG_IFCVF)    += ifcvf/
>  obj-$(CONFIG_MLX5_VDPA) += mlx5/
>  obj-$(CONFIG_VP_VDPA)    += virtio_pci/
> +obj-$(CONFIG_ALIBABA_ENI_VDPA) += alibaba/
> diff --git a/drivers/vdpa/alibaba/Makefile b/drivers/vdpa/alibaba/Makefile
> new file mode 100644
> index 000000000000..ef4aae69f87a
> --- /dev/null
> +++ b/drivers/vdpa/alibaba/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_ALIBABA_ENI_VDPA) += eni_vdpa.o
> +
> diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
> new file mode 100644
> index 000000000000..6a09f157d810
> --- /dev/null
> +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> @@ -0,0 +1,553 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * vDPA bridge driver for Alibaba ENI(Elastic Network Interface)
> + *
> + * Copyright (c) 2021, Alibaba Inc. All rights reserved.
> + * Author: Wu Zongyong <wuzongyong@linux.alibaba.com>
> + *
> + */
> +
> +#include "linux/bits.h"
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/vdpa.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_config.h>
> +#include <linux/virtio_ring.h>
> +#include <linux/virtio_pci.h>
> +#include <linux/virtio_pci_legacy.h>
> +#include <uapi/linux/virtio_net.h>
> +
> +#define ENI_MSIX_NAME_SIZE 256
> +
> +#define ENI_ERR(pdev, fmt, ...)        \
> +       dev_err(&pdev->dev, "%s"fmt, "eni_vdpa: ", ##__VA_ARGS__)
> +#define ENI_DBG(pdev, fmt, ...)        \
> +       dev_dbg(&pdev->dev, "%s"fmt, "eni_vdpa: ", ##__VA_ARGS__)
> +#define ENI_INFO(pdev, fmt, ...) \
> +       dev_info(&pdev->dev, "%s"fmt, "eni_vdpa: ", ##__VA_ARGS__)
> +
> +struct eni_vring {
> +       void __iomem *notify;
> +       char msix_name[ENI_MSIX_NAME_SIZE];
> +       struct vdpa_callback cb;
> +       int irq;
> +};
> +
> +struct eni_vdpa {
> +       struct vdpa_device vdpa;
> +       struct virtio_pci_legacy_device ldev;
> +       struct eni_vring *vring;
> +       struct vdpa_callback config_cb;
> +       char msix_name[ENI_MSIX_NAME_SIZE];
> +       int config_irq;
> +       int queues;
> +       int vectors;
> +};
> +
> +static struct eni_vdpa *vdpa_to_eni(struct vdpa_device *vdpa)
> +{
> +       return container_of(vdpa, struct eni_vdpa, vdpa);
> +}
> +
> +static struct virtio_pci_legacy_device *vdpa_to_ldev(struct vdpa_device *vdpa)
> +{
> +       struct eni_vdpa *eni_vdpa = vdpa_to_eni(vdpa);
> +
> +       return &eni_vdpa->ldev;
> +}
> +
> +static u64 eni_vdpa_get_features(struct vdpa_device *vdpa)
> +{
> +       struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +       u64 features = vp_legacy_get_features(ldev);
> +
> +       features |= BIT_ULL(VIRTIO_F_ACCESS_PLATFORM);
> +       features |= BIT_ULL(VIRTIO_F_ORDER_PLATFORM);
> +
> +       return features;
> +}
> +
> +static int eni_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
> +{
> +       struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +
> +       if (!(features & BIT_ULL(VIRTIO_NET_F_MRG_RXBUF)) && features) {
> +               ENI_ERR(ldev->pci_dev,
> +                       "VIRTIO_NET_F_MRG_RXBUF is not negotiated\n");
> +               return -EINVAL;
> +       }
> +
> +       vp_legacy_set_features(ldev, (u32)features);
> +
> +       return 0;
> +}
> +

So my comments have not been addressed since v4. Please address or
answer the questions before posting a new version.

Thanks

> +static u64 eni_vdpa_get_features(struct vdpa_device *vdpa)
> +{
> +     struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +     u64 features = vp_legacy_get_features(ldev);
> +
> +     features |= BIT_ULL(VIRTIO_F_ACCESS_PLATFORM);
> +     features |= BIT_ULL(VIRTIO_F_ORDER_PLATFORM);

VERSION_1 is also needed?


> +
> +     return features;
> +}
> +
> +static int eni_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
> +{
> +     struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +
> +     if (!(features & BIT_ULL(VIRTIO_NET_F_MRG_RXBUF)) && features) {
> +             ENI_ERR(ldev->pci_dev,
> +                     "VIRTIO_NET_F_MRG_RXBUF is not negotiated\n");
> +             return -EINVAL;

Do we need to make sure FEATURE_OK is not set in this case or the ENI can do
this for us?

Other looks good.

Thanks

