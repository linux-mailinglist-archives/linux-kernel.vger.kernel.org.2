Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC68340BE0E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 05:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbhIODQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 23:16:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23665 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229834AbhIODQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 23:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631675697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=saYEYFs9XJzAm2sCZR4dKLr/4jB6xKiq9Si08uKpL9c=;
        b=EXyAawhtpAj4tlgUxJ8zgYgdFHqOVf9jbh5qgDXbcpSJBPybt4rxgGsRM98wrfJEe8MTaY
        SymqFgM2jQfVnqoiEfjnsVmp2bdZSYFu8kwBYswmgpmeR2b+Pmdbp0aQpbKFnH9wQrIkvr
        G4n8ygenK5EzTBvsrLtORxaZf3yzzds=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-GIq0CewCMXeXY6ckDTwAkA-1; Tue, 14 Sep 2021 23:14:56 -0400
X-MC-Unique: GIq0CewCMXeXY6ckDTwAkA-1
Received: by mail-lj1-f198.google.com with SMTP id p11-20020a2ea40b000000b001d68cffb055so781523ljn.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 20:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=saYEYFs9XJzAm2sCZR4dKLr/4jB6xKiq9Si08uKpL9c=;
        b=XsyBErofITPHI4FQAgNBNqvepOhiSSrLQ3MZ5PXTSKTIvEmz3d8qnjtlrL0QLtrcu6
         q7K8CbrV3vpqbToYAzYWQMIDyF1Q+LuS2FpV251RvDfE1AHuCmZYjhiIBcsmxoeE8k33
         jbYR5VTDSESXhTv3GbYz+6Qf5QvG3cJLsxfUwebnKGz0HSTIH0OF+s0TcOla982CGo8G
         7GltYhOq2YiB2uQcNXn15g25FtgzPoBq64ZYKvq/KBQyZwCAzE8/RhsrGxVuI1mSMnyI
         LuLA5prgT3gcLsj+jvSJd3GbYaa1hww5c9TUPSZoLCBm+JfREaUtASkmHT72S8HsjYrR
         O1mQ==
X-Gm-Message-State: AOAM533QBgFaUD8PlrC+WpyWnZf9nvYT/pCPLB/6j96VynaQ91atBLWF
        97qZXjLu3Qhu5ze4UwTRk7L6fL7cXtyJoSIs04O72Vj3LAGROSoDd9XV0P+QL6XUo9qoD4S8d57
        ONmdz0mbVQHw3spHEuo6XAvjOPdfEBh8CJ8IfZk5e
X-Received: by 2002:a05:6512:110b:: with SMTP id l11mr15474188lfg.199.1631675694364;
        Tue, 14 Sep 2021 20:14:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4wYtIUxNynVD/UG02ny+h9cAJAmrliLKjuRMlUTdS6MjLw3UdZp8X1zNASs8jCiKy3R4aGj3U+DYpUBhiIjA=
X-Received: by 2002:a05:6512:110b:: with SMTP id l11mr15474169lfg.199.1631675694118;
 Tue, 14 Sep 2021 20:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <cover.1631621507.git.wuzongyong@linux.alibaba.com> <ab98427764198053b4277a127eaea3f32cd40ed5.1631621507.git.wuzongyong@linux.alibaba.com>
In-Reply-To: <ab98427764198053b4277a127eaea3f32cd40ed5.1631621507.git.wuzongyong@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 15 Sep 2021 11:14:43 +0800
Message-ID: <CACGkMEte6r0xNNrnrSc_mnZk2z49EL697c0UNqLuU08_pA2t5w@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] eni_vdpa: add vDPA driver for Alibaba ENI
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mst <mst@redhat.com>, wei.yang1@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 8:26 PM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> This patch adds a new vDPA driver for Alibaba ENI(Elastic Network
> Interface) which is build upon virtio 0.9.5 specification.
>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> ---
>  drivers/vdpa/Kconfig            |   8 +
>  drivers/vdpa/Makefile           |   1 +
>  drivers/vdpa/alibaba/Makefile   |   3 +
>  drivers/vdpa/alibaba/eni_vdpa.c | 537 ++++++++++++++++++++++++++++++++
>  4 files changed, 549 insertions(+)
>  create mode 100644 drivers/vdpa/alibaba/Makefile
>  create mode 100644 drivers/vdpa/alibaba/eni_vdpa.c
>
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 3d91982d8371..9587b9177b05 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -78,4 +78,12 @@ config VP_VDPA
>         help
>           This kernel module bridges virtio PCI device to vDPA bus.
>
> +config ALIBABA_ENI_VDPA
> +       tristate "vDPA driver for Alibaba ENI"
> +       select VIRTIO_PCI_LEGACY_LIB
> +       depends on PCI_MSI
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
> index 000000000000..38e85a5dd62e
> --- /dev/null
> +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> @@ -0,0 +1,537 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * vDPA bridge driver for Alibaba ENI(Elastic Network Interface)
> + *
> + * Copyright (c) 2021, Alibaba Inc. All rights reserved.
> + * Author: Wu Zongyong <wuzongyong@linux.alibaba.com>
> + *
> + */
> +
> +#include "asm-generic/errno-base.h"
> +#include "asm-generic/errno.h"
> +#include "linux/irqreturn.h"
> +#include "linux/kernel.h"
> +#include "linux/pci_ids.h"
> +#include "linux/virtio_config.h"
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
> +
> +       return vp_legacy_get_features(ldev);
> +}
> +
> +static int eni_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
> +{
> +       struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +
> +       vp_legacy_set_features(ldev, (u32)features);
> +
> +       return 0;
> +}

Interesting, I wonder how VIRTIO_F_ACCESS_PLATFORM can work in this case.

Without that, the virtio driver won't use DMA API which breaks the
setup with IOMMU.

Or is the VIRTIO_F_ACCESS_PLATFORM mandated by the device? If yes, we
need some meditation here:

e.g return VIRTIO_F_ACCESS_PLATFORM set in get_features().

> +
> +static u8 eni_vdpa_get_status(struct vdpa_device *vdpa)
> +{
> +       struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +
> +       return vp_legacy_get_status(ldev);
> +}
> +
> +static int eni_vdpa_get_vq_irq(struct vdpa_device *vdpa, u16 idx)
> +{
> +       struct eni_vdpa *eni_vdpa = vdpa_to_eni(vdpa);
> +       int irq = eni_vdpa->vring[idx].irq;
> +
> +       if (irq == VIRTIO_MSI_NO_VECTOR)
> +               return -EINVAL;
> +
> +       return irq;
> +}
> +
> +static void eni_vdpa_free_irq(struct eni_vdpa *eni_vdpa)
> +{
> +       struct virtio_pci_legacy_device *ldev = &eni_vdpa->ldev;
> +       struct pci_dev *pdev = ldev->pci_dev;
> +       int i;
> +
> +       for (i = 0; i < eni_vdpa->queues; i++) {
> +               if (eni_vdpa->vring[i].irq != VIRTIO_MSI_NO_VECTOR) {
> +                       vp_legacy_queue_vector(ldev, i, VIRTIO_MSI_NO_VECTOR);
> +                       devm_free_irq(&pdev->dev, eni_vdpa->vring[i].irq,
> +                                     &eni_vdpa->vring[i]);
> +                       eni_vdpa->vring[i].irq = VIRTIO_MSI_NO_VECTOR;
> +               }
> +       }
> +
> +       if (eni_vdpa->config_irq != VIRTIO_MSI_NO_VECTOR) {
> +               vp_legacy_config_vector(ldev, VIRTIO_MSI_NO_VECTOR);
> +               devm_free_irq(&pdev->dev, eni_vdpa->config_irq, eni_vdpa);
> +               eni_vdpa->config_irq = VIRTIO_MSI_NO_VECTOR;
> +       }
> +
> +       if (eni_vdpa->vectors) {
> +               pci_free_irq_vectors(pdev);
> +               eni_vdpa->vectors = 0;
> +       }
> +}
> +
> +static irqreturn_t eni_vdpa_vq_handler(int irq, void *arg)
> +{
> +       struct eni_vring *vring = arg;
> +
> +       if (vring->cb.callback)
> +               return vring->cb.callback(vring->cb.private);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t eni_vdpa_config_handler(int irq, void *arg)
> +{
> +       struct eni_vdpa *eni_vdpa = arg;
> +
> +       if (eni_vdpa->config_cb.callback)
> +               return eni_vdpa->config_cb.callback(eni_vdpa->config_cb.private);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int eni_vdpa_request_irq(struct eni_vdpa *eni_vdpa)
> +{
> +       struct virtio_pci_legacy_device *ldev = &eni_vdpa->ldev;
> +       struct pci_dev *pdev = ldev->pci_dev;
> +       int i, ret, irq;
> +       int queues = eni_vdpa->queues;
> +       int vectors = queues + 1;
> +
> +       ret = pci_alloc_irq_vectors(pdev, vectors, vectors, PCI_IRQ_MSIX);
> +       if (ret != vectors) {
> +               ENI_ERR(pdev,
> +                       "failed to allocate irq vectors want %d but %d\n",
> +                       vectors, ret);
> +               return ret;
> +       }
> +
> +       eni_vdpa->vectors = vectors;
> +
> +       for (i = 0; i < queues; i++) {
> +               snprintf(eni_vdpa->vring[i].msix_name, ENI_MSIX_NAME_SIZE,
> +                        "eni-vdpa[%s]-%d\n", pci_name(pdev), i);
> +               irq = pci_irq_vector(pdev, i);
> +               ret = devm_request_irq(&pdev->dev, irq,
> +                                      eni_vdpa_vq_handler,
> +                                      0, eni_vdpa->vring[i].msix_name,
> +                                      &eni_vdpa->vring[i]);
> +               if (ret) {
> +                       ENI_ERR(pdev, "failed to request irq for vq %d\n", i);
> +                       goto err;
> +               }
> +               vp_legacy_queue_vector(ldev, i, i);
> +               eni_vdpa->vring[i].irq = irq;
> +       }
> +
> +       snprintf(eni_vdpa->msix_name, ENI_MSIX_NAME_SIZE, "eni-vdpa[%s]-config\n",
> +                pci_name(pdev));
> +       irq = pci_irq_vector(pdev, queues);
> +       ret = devm_request_irq(&pdev->dev, irq, eni_vdpa_config_handler, 0,
> +                              eni_vdpa->msix_name, eni_vdpa);
> +       if (ret) {
> +               ENI_ERR(pdev, "failed to request irq for config vq %d\n", i);
> +               goto err;
> +       }
> +       vp_legacy_config_vector(ldev, queues);
> +       eni_vdpa->config_irq = irq;
> +
> +       return 0;
> +err:
> +       eni_vdpa_free_irq(eni_vdpa);
> +       return ret;
> +}
> +
> +static void eni_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
> +{
> +       struct eni_vdpa *eni_vdpa = vdpa_to_eni(vdpa);
> +       struct virtio_pci_legacy_device *ldev = &eni_vdpa->ldev;
> +       u8 s = eni_vdpa_get_status(vdpa);
> +
> +       if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
> +           !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
> +               eni_vdpa_request_irq(eni_vdpa);
> +       }
> +
> +       vp_legacy_set_status(ldev, status);
> +
> +       if (!(status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> +           (s & VIRTIO_CONFIG_S_DRIVER_OK))
> +               eni_vdpa_free_irq(eni_vdpa);
> +}
> +
> +static int eni_vdpa_reset(struct vdpa_device *vdpa)
> +{
> +       struct eni_vdpa *eni_vdpa = vdpa_to_eni(vdpa);
> +       struct virtio_pci_legacy_device *ldev = &eni_vdpa->ldev;
> +       u8 s = eni_vdpa_get_status(vdpa);
> +
> +       vp_legacy_set_status(ldev, 0);
> +
> +       if (s & VIRTIO_CONFIG_S_DRIVER_OK)
> +               eni_vdpa_free_irq(eni_vdpa);
> +
> +       return 0;
> +}
> +
> +static u16 eni_vdpa_get_vq_num_max(struct vdpa_device *vdpa)
> +{
> +       struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +
> +       return vp_legacy_get_queue_size(ldev, 0);
> +}
> +
> +static int eni_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 qid,
> +                               struct vdpa_vq_state *state)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static int eni_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 qid,
> +                                const struct vdpa_vq_state *state)
> +{
> +       struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +       const struct vdpa_vq_state_split *split = &state->split;
> +
> +       /* ENI is build upon virtio-pci specfication which not support
> +        * to set state of virtqueue. But if the state is equal to the
> +        * device initial state by chance, we can let it go.
> +        */
> +       if (!vp_legacy_get_queue_enable(ldev, qid)
> +           && split->avail_index == 0)
> +               return 0;
> +
> +       return -EOPNOTSUPP;
> +}
> +
> +
> +static void eni_vdpa_set_vq_cb(struct vdpa_device *vdpa, u16 qid,
> +                              struct vdpa_callback *cb)
> +{
> +       struct eni_vdpa *eni_vdpa = vdpa_to_eni(vdpa);
> +
> +       eni_vdpa->vring[qid].cb = *cb;
> +}
> +
> +static void eni_vdpa_set_vq_ready(struct vdpa_device *vdpa, u16 qid,
> +                                 bool ready)
> +{
> +       struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +
> +       /* ENI is a legacy virtio-pci device. This is not supported
> +        * by specification. But we can disable virtqueue by setting
> +        * address to 0.
> +        */
> +       if (!ready)
> +               vp_legacy_set_queue_address(ldev, qid, 0);
> +}
> +
> +static bool eni_vdpa_get_vq_ready(struct vdpa_device *vdpa, u16 qid)
> +{
> +       struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +
> +       return vp_legacy_get_queue_enable(ldev, qid);
> +}
> +
> +static void eni_vdpa_set_vq_num(struct vdpa_device *vdpa, u16 qid,
> +                              u32 num)
> +{
> +       struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +       struct pci_dev *pdev = ldev->pci_dev;
> +       u16 n = vp_legacy_get_queue_size(ldev, qid);
> +
> +       /* ENI is a legacy virtio-pci device which not allow to change
> +        * virtqueue size. Just report a error if someone tries to
> +        * change it.
> +        */
> +       if (num != n)
> +               ENI_ERR(pdev,
> +                       "not support to set vq %u fixed num %u to %u\n",
> +                       qid, n, num);
> +}
> +
> +static int eni_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 qid,
> +                                  u64 desc_area, u64 driver_area,
> +                                  u64 device_area)
> +{
> +       struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +       u32 pfn = desc_area >> VIRTIO_PCI_QUEUE_ADDR_SHIFT;
> +
> +       vp_legacy_set_queue_address(ldev, qid, pfn);
> +
> +       return 0;
> +}
> +
> +static void eni_vdpa_kick_vq(struct vdpa_device *vdpa, u16 qid)
> +{
> +       struct eni_vdpa *eni_vdpa = vdpa_to_eni(vdpa);
> +
> +       iowrite16(qid, eni_vdpa->vring[qid].notify);
> +}
> +
> +static u32 eni_vdpa_get_device_id(struct vdpa_device *vdpa)
> +{
> +       struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +
> +       return ldev->id.device;
> +}
> +
> +static u32 eni_vdpa_get_vendor_id(struct vdpa_device *vdpa)
> +{
> +       struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +
> +       return ldev->id.vendor;
> +}
> +
> +static u32 eni_vdpa_get_vq_align(struct vdpa_device *vdpa)
> +{
> +       return PAGE_SIZE;
> +}
> +
> +static size_t eni_vdpa_get_config_size(struct vdpa_device *vdpa)
> +{
> +       return sizeof(struct virtio_net_config);
> +}
> +
> +
> +static void eni_vdpa_get_config(struct vdpa_device *vdpa,
> +                               unsigned int offset,
> +                               void *buf, unsigned int len)
> +{
> +       struct eni_vdpa *eni_vdpa = vdpa_to_eni(vdpa);
> +       struct virtio_pci_legacy_device *ldev = &eni_vdpa->ldev;
> +       void __iomem *ioaddr = ldev->ioaddr +
> +               VIRTIO_PCI_CONFIG_OFF(eni_vdpa->vectors) +
> +               offset;
> +       u8 *p = buf;
> +       int i;
> +
> +       for (i = 0; i < len; i++)
> +               *p++ = ioread8(ioaddr + i);
> +}
> +
> +static void eni_vdpa_set_config(struct vdpa_device *vdpa,
> +                               unsigned int offset, const void *buf,
> +                               unsigned int len)
> +{
> +       struct eni_vdpa *eni_vdpa = vdpa_to_eni(vdpa);
> +       struct virtio_pci_legacy_device *ldev = &eni_vdpa->ldev;
> +       void __iomem *ioaddr = ldev->ioaddr +
> +               VIRTIO_PCI_CONFIG_OFF(eni_vdpa->vectors) +
> +               offset;
> +       const u8 *p = buf;
> +       int i;
> +
> +       for (i = 0; i < len; i++)
> +               iowrite8(*p++, ioaddr + i);
> +}
> +
> +static void eni_vdpa_set_config_cb(struct vdpa_device *vdpa,
> +                                  struct vdpa_callback *cb)
> +{
> +       struct eni_vdpa *eni_vdpa = vdpa_to_eni(vdpa);
> +
> +       eni_vdpa->config_cb = *cb;
> +}
> +
> +static const struct vdpa_config_ops eni_vdpa_ops = {
> +       .get_features   = eni_vdpa_get_features,
> +       .set_features   = eni_vdpa_set_features,
> +       .get_status     = eni_vdpa_get_status,
> +       .set_status     = eni_vdpa_set_status,
> +       .reset          = eni_vdpa_reset,
> +       .get_vq_num_max = eni_vdpa_get_vq_num_max,
> +       .get_vq_state   = eni_vdpa_get_vq_state,
> +       .set_vq_state   = eni_vdpa_set_vq_state,
> +       .set_vq_cb      = eni_vdpa_set_vq_cb,
> +       .set_vq_ready   = eni_vdpa_set_vq_ready,
> +       .get_vq_ready   = eni_vdpa_get_vq_ready,
> +       .set_vq_num     = eni_vdpa_set_vq_num,
> +       .set_vq_address = eni_vdpa_set_vq_address,
> +       .kick_vq        = eni_vdpa_kick_vq,
> +       .get_device_id  = eni_vdpa_get_device_id,
> +       .get_vendor_id  = eni_vdpa_get_vendor_id,
> +       .get_vq_align   = eni_vdpa_get_vq_align,
> +       .get_config_size = eni_vdpa_get_config_size,
> +       .get_config     = eni_vdpa_get_config,
> +       .set_config     = eni_vdpa_set_config,
> +       .set_config_cb  = eni_vdpa_set_config_cb,
> +       .get_vq_irq     = eni_vdpa_get_vq_irq,
> +};
> +
> +
> +static u16 eni_vdpa_get_num_queues(struct eni_vdpa *eni_vdpa)
> +{
> +       struct virtio_pci_legacy_device *ldev = &eni_vdpa->ldev;
> +       u32 features = vp_legacy_get_features(ldev);
> +       u16 num = 2;
> +
> +       if (features & BIT_ULL(VIRTIO_NET_F_MQ)) {
> +               __virtio16 max_virtqueue_pairs;
> +
> +               eni_vdpa_get_config(&eni_vdpa->vdpa,
> +                       offsetof(struct virtio_net_config, max_virtqueue_pairs),
> +                       &max_virtqueue_pairs,
> +                       sizeof(max_virtqueue_pairs));
> +               num = 2 * __virtio16_to_cpu(virtio_legacy_is_little_endian(),
> +                               max_virtqueue_pairs);
> +       }
> +
> +       if (features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ))
> +               num += 1;
> +
> +       return num;
> +}
> +
> +static void eni_vdpa_free_irq_vectors(void *data)
> +{
> +       pci_free_irq_vectors(data);
> +}
> +
> +static int eni_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct eni_vdpa *eni_vdpa;
> +       struct virtio_pci_legacy_device *ldev;
> +       int ret, i;
> +
> +       ret = pcim_enable_device(pdev);
> +       if (ret)
> +               return ret;
> +
> +       eni_vdpa = vdpa_alloc_device(struct eni_vdpa, vdpa,
> +                                    dev, &eni_vdpa_ops, NULL, false);
> +       if (IS_ERR(eni_vdpa)) {
> +               ENI_ERR(pdev, "failed to allocate vDPA structure\n");
> +               return PTR_ERR(eni_vdpa);
> +       }
> +
> +       ldev = &eni_vdpa->ldev;
> +       ldev->pci_dev = pdev;
> +
> +       ret = vp_legacy_probe(ldev);
> +       if (ret) {
> +               ENI_ERR(pdev, "failed to probe legacy PCI device\n");
> +               goto err;
> +       }
> +
> +       pci_set_master(pdev);
> +       pci_set_drvdata(pdev, eni_vdpa);
> +
> +       eni_vdpa->vdpa.dma_dev = &pdev->dev;
> +       eni_vdpa->queues = eni_vdpa_get_num_queues(eni_vdpa);
> +
> +       ret = devm_add_action_or_reset(dev, eni_vdpa_free_irq_vectors, pdev);
> +       if (ret) {
> +               ENI_ERR(pdev,
> +                       "failed for adding devres for freeing irq vectors\n");
> +               goto err;
> +       }
> +
> +       eni_vdpa->vring = devm_kcalloc(&pdev->dev, eni_vdpa->queues,
> +                                     sizeof(*eni_vdpa->vring),
> +                                     GFP_KERNEL);
> +       if (!eni_vdpa->vring) {
> +               ret = -ENOMEM;
> +               ENI_ERR(pdev, "fail to allocate virtqueues\n");
> +               goto err;
> +       }
> +
> +       for (i = 0; i < eni_vdpa->queues; i++) {
> +               eni_vdpa->vring[i].irq = VIRTIO_MSI_NO_VECTOR;
> +               eni_vdpa->vring[i].notify = ldev->ioaddr + VIRTIO_PCI_QUEUE_NOTIFY;
> +       }
> +       eni_vdpa->config_irq = VIRTIO_MSI_NO_VECTOR;
> +
> +       ret = vdpa_register_device(&eni_vdpa->vdpa, eni_vdpa->queues);
> +       if (ret) {
> +               ENI_ERR(pdev, "failed to register to vdpa bus\n");
> +               goto err;
> +       }
> +
> +       return 0;
> +
> +err:
> +       put_device(&eni_vdpa->vdpa.dev);
> +       return ret;
> +}
> +
> +static void eni_vdpa_remove(struct pci_dev *pdev)
> +{
> +       struct eni_vdpa *eni_vdpa = pci_get_drvdata(pdev);
> +
> +       vdpa_unregister_device(&eni_vdpa->vdpa);
> +       vp_legacy_remove(&eni_vdpa->ldev);
> +}
> +
> +static struct pci_device_id eni_pci_ids[] = {
> +       { PCI_VENDOR_ID_REDHAT_QUMRANET, VIRTIO_TRANS_ID_NET },

This will cause some confusion for driver binding. I think it's better
to add subvendor matching here.

Thanks

> +       { 0 },
> +};
> +
> +static struct pci_driver eni_vdpa_driver = {
> +       .name           = "alibaba-eni-vdpa",
> +       .id_table       = eni_pci_ids,
> +       .probe          = eni_vdpa_probe,
> +       .remove         = eni_vdpa_remove,
> +};
> +
> +module_pci_driver(eni_vdpa_driver);
> +
> +MODULE_AUTHOR("Wu Zongyong <wuzongyong@linux.alibaba.com>");
> +MODULE_DESCRIPTION("Alibaba ENI vDPA driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.31.1
>

