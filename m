Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC34438E74
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 06:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhJYEnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 00:43:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48062 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229752AbhJYEnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 00:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635136849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qjVkI2n3SJI7/K1hvcMeCrmtPAeZ25MHOyouz4fZPTU=;
        b=AnQBh1rHiPyYXO3G0UJMW9+lCwnHase4CcX6U/q1CjMw1mgwmtMNOCsMmZOk/459MgTA6H
        MvQDBMpiYmBU8M8HSRXEfcyjWTes9XYS76SXS2qb9xhu4825ssG85sia37mc8931dDEpJ8
        M+T5a65VS6LL045epvE+Vcgya2odxrQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-3vI8e9MpM4CyCYuagMFLvg-1; Mon, 25 Oct 2021 00:40:47 -0400
X-MC-Unique: 3vI8e9MpM4CyCYuagMFLvg-1
Received: by mail-pj1-f72.google.com with SMTP id cx18-20020a17090afd9200b001a25cf96dcfso91442pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 21:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qjVkI2n3SJI7/K1hvcMeCrmtPAeZ25MHOyouz4fZPTU=;
        b=iJFlai3Jy/O2jGhpJ+MGKA+lwbAP4ET48HJaBC8DzOVZvL1O0pDUIPXxaEoFTOJj4i
         AcCgF0KipL+0xpSDBg7u3W2l6zTUnpx8b8O5XDG9CWfU3QeFiSY+4k5A1uhb4xvqNd4k
         fJm8Kj6elvbD+V5ikyErxC/2j/P+lzGMuPpux4T2vh3aLtXznjW64SBjjXsTK/13ykSO
         Z8WzLcPkGeeRtjKceY8O2kVeX6nExPLdAi8tHyY7CIGtVqncJXq6ASumqVT1dPpJxkYD
         r1wo2+8X2cw02AhFMQP2MxB9p9KQzGb3gZwmytxgC0XuybQ4lyAHzTXJ9XplaDPw7hgd
         pBSQ==
X-Gm-Message-State: AOAM530TALy7kXMEb91xj2M/F2ZBQVvbhvWxLdV36ZjZH7lMVrvEMd98
        nDoacGM+TrnDmpJpt52TmerzsQx5IfGJgmTNynJ1yqe4BjrLtYEEl27f/g7tTQhrqTEd3Kp4erN
        09sW0oY+z8yPtCzfDuR9JHQRT
X-Received: by 2002:a63:2cd8:: with SMTP id s207mr11892031pgs.312.1635136846587;
        Sun, 24 Oct 2021 21:40:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZeEFK9SQBPkqktqdkxLVnXjd/GU7BwVf+RIB0w3wF8hhCTJhCmVTYt8kaWufvLG9n5sDgxQ==
X-Received: by 2002:a63:2cd8:: with SMTP id s207mr11892007pgs.312.1635136846244;
        Sun, 24 Oct 2021 21:40:46 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 11sm16756319pfl.41.2021.10.24.21.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Oct 2021 21:40:45 -0700 (PDT)
Subject: Re: [PATCH v6 8/8] eni_vdpa: add vDPA driver for Alibaba ENI
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
References: <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <cover.1634870456.git.wuzongyong@linux.alibaba.com>
 <6496b76a64303a3e23ea19e3e279644608de36fb.1634870456.git.wuzongyong@linux.alibaba.com>
 <CACGkMEvi7505ZOSLP6gMMvhC=Zfdt=nPK4WEYe7=VVbq3GmxCQ@mail.gmail.com>
 <20211025032146.GC3684@L-PF27918B-1352.localdomain>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mst <mst@redhat.com>, wei.yang1@linux.alibaba.com
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <51e9be5b-4bb2-b82b-a152-ffc37803410c@redhat.com>
Date:   Mon, 25 Oct 2021 12:40:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211025032146.GC3684@L-PF27918B-1352.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/10/25 上午11:21, Wu Zongyong 写道:
> On Mon, Oct 25, 2021 at 10:27:31AM +0800, Jason Wang wrote:
>> On Fri, Oct 22, 2021 at 10:44 AM Wu Zongyong
>> <wuzongyong@linux.alibaba.com> wrote:
>>> This patch adds a new vDPA driver for Alibaba ENI(Elastic Network
>>> Interface) which is build upon virtio 0.9.5 specification.
>>> And this driver doesn't support to run on BE host.
>>>
>>> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
>>> ---
>>>   drivers/vdpa/Kconfig            |   8 +
>>>   drivers/vdpa/Makefile           |   1 +
>>>   drivers/vdpa/alibaba/Makefile   |   3 +
>>>   drivers/vdpa/alibaba/eni_vdpa.c | 553 ++++++++++++++++++++++++++++++++
>>>   4 files changed, 565 insertions(+)
>>>   create mode 100644 drivers/vdpa/alibaba/Makefile
>>>   create mode 100644 drivers/vdpa/alibaba/eni_vdpa.c
>>>
>>> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
>>> index 3d91982d8371..c0232a2148a7 100644
>>> --- a/drivers/vdpa/Kconfig
>>> +++ b/drivers/vdpa/Kconfig
>>> @@ -78,4 +78,12 @@ config VP_VDPA
>>>          help
>>>            This kernel module bridges virtio PCI device to vDPA bus.
>>>
>>> +config ALIBABA_ENI_VDPA
>>> +       tristate "vDPA driver for Alibaba ENI"
>>> +       select VIRTIO_PCI_LEGACY_LIB
>>> +       depends on PCI_MSI && !CPU_BIG_ENDIAN
>>> +       help
>>> +         VDPA driver for Alibaba ENI(Elastic Network Interface) which is build upon
>>> +         virtio 0.9.5 specification.
>>> +
>>>   endif # VDPA
>>> diff --git a/drivers/vdpa/Makefile b/drivers/vdpa/Makefile
>>> index f02ebed33f19..15665563a7f4 100644
>>> --- a/drivers/vdpa/Makefile
>>> +++ b/drivers/vdpa/Makefile
>>> @@ -5,3 +5,4 @@ obj-$(CONFIG_VDPA_USER) += vdpa_user/
>>>   obj-$(CONFIG_IFCVF)    += ifcvf/
>>>   obj-$(CONFIG_MLX5_VDPA) += mlx5/
>>>   obj-$(CONFIG_VP_VDPA)    += virtio_pci/
>>> +obj-$(CONFIG_ALIBABA_ENI_VDPA) += alibaba/
>>> diff --git a/drivers/vdpa/alibaba/Makefile b/drivers/vdpa/alibaba/Makefile
>>> new file mode 100644
>>> index 000000000000..ef4aae69f87a
>>> --- /dev/null
>>> +++ b/drivers/vdpa/alibaba/Makefile
>>> @@ -0,0 +1,3 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +obj-$(CONFIG_ALIBABA_ENI_VDPA) += eni_vdpa.o
>>> +
>>> diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
>>> new file mode 100644
>>> index 000000000000..6a09f157d810
>>> --- /dev/null
>>> +++ b/drivers/vdpa/alibaba/eni_vdpa.c
>>> @@ -0,0 +1,553 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * vDPA bridge driver for Alibaba ENI(Elastic Network Interface)
>>> + *
>>> + * Copyright (c) 2021, Alibaba Inc. All rights reserved.
>>> + * Author: Wu Zongyong <wuzongyong@linux.alibaba.com>
>>> + *
>>> + */
>>> +
>>> +#include "linux/bits.h"
>>> +#include <linux/interrupt.h>
>>> +#include <linux/module.h>
>>> +#include <linux/pci.h>
>>> +#include <linux/vdpa.h>
>>> +#include <linux/virtio.h>
>>> +#include <linux/virtio_config.h>
>>> +#include <linux/virtio_ring.h>
>>> +#include <linux/virtio_pci.h>
>>> +#include <linux/virtio_pci_legacy.h>
>>> +#include <uapi/linux/virtio_net.h>
>>> +
>>> +#define ENI_MSIX_NAME_SIZE 256
>>> +
>>> +#define ENI_ERR(pdev, fmt, ...)        \
>>> +       dev_err(&pdev->dev, "%s"fmt, "eni_vdpa: ", ##__VA_ARGS__)
>>> +#define ENI_DBG(pdev, fmt, ...)        \
>>> +       dev_dbg(&pdev->dev, "%s"fmt, "eni_vdpa: ", ##__VA_ARGS__)
>>> +#define ENI_INFO(pdev, fmt, ...) \
>>> +       dev_info(&pdev->dev, "%s"fmt, "eni_vdpa: ", ##__VA_ARGS__)
>>> +
>>> +struct eni_vring {
>>> +       void __iomem *notify;
>>> +       char msix_name[ENI_MSIX_NAME_SIZE];
>>> +       struct vdpa_callback cb;
>>> +       int irq;
>>> +};
>>> +
>>> +struct eni_vdpa {
>>> +       struct vdpa_device vdpa;
>>> +       struct virtio_pci_legacy_device ldev;
>>> +       struct eni_vring *vring;
>>> +       struct vdpa_callback config_cb;
>>> +       char msix_name[ENI_MSIX_NAME_SIZE];
>>> +       int config_irq;
>>> +       int queues;
>>> +       int vectors;
>>> +};
>>> +
>>> +static struct eni_vdpa *vdpa_to_eni(struct vdpa_device *vdpa)
>>> +{
>>> +       return container_of(vdpa, struct eni_vdpa, vdpa);
>>> +}
>>> +
>>> +static struct virtio_pci_legacy_device *vdpa_to_ldev(struct vdpa_device *vdpa)
>>> +{
>>> +       struct eni_vdpa *eni_vdpa = vdpa_to_eni(vdpa);
>>> +
>>> +       return &eni_vdpa->ldev;
>>> +}
>>> +
>>> +static u64 eni_vdpa_get_features(struct vdpa_device *vdpa)
>>> +{
>>> +       struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
>>> +       u64 features = vp_legacy_get_features(ldev);
>>> +
>>> +       features |= BIT_ULL(VIRTIO_F_ACCESS_PLATFORM);
>>> +       features |= BIT_ULL(VIRTIO_F_ORDER_PLATFORM);
>>> +
>>> +       return features;
>>> +}
>>> +
>>> +static int eni_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
>>> +{
>>> +       struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
>>> +
>>> +       if (!(features & BIT_ULL(VIRTIO_NET_F_MRG_RXBUF)) && features) {
>>> +               ENI_ERR(ldev->pci_dev,
>>> +                       "VIRTIO_NET_F_MRG_RXBUF is not negotiated\n");
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       vp_legacy_set_features(ldev, (u32)features);
>>> +
>>> +       return 0;
>>> +}
>>> +
>> So my comments have not been addressed since v4. Please address or
>> answer the questions before posting a new version.
>>
>> Thanks
> Sorry, I forgot to reply the comments on this patch.
>
>
>>> +static u64 eni_vdpa_get_features(struct vdpa_device *vdpa)
>>> +{
>>> +     struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
>>> +     u64 features = vp_legacy_get_features(ldev);
>>> +
>>> +     features |= BIT_ULL(VIRTIO_F_ACCESS_PLATFORM);
>>> +     features |= BIT_ULL(VIRTIO_F_ORDER_PLATFORM);
>> VERSION_1 is also needed?
>>
> No, queue align of legacy devices should be 4096,


Let's use VIRTIO_PCI_VRING_ALIGN instead of PAGE_SIZE in get_vq_align 
then since PAGE_SIZE is not necessarily 4096.


>   but queue align of
> devices with VERSION_1 are SMP_CACHE_BYTES which may not equals to
> 4096.
> If we set the VERSION_1, ENI will not work due to the queue align.


Interesting, so I think it can only be used with legacy virtio drivers 
in the guest.

One major drawbacks is that guest can only see 32 feature bits which 
means we can't advertise VIRTIO_F_ACCESS_PLATFORM and 
VIRTIO_F_ORDER_PLATFORM to guest:

/* virtio config->get_features() implementation */
static u64 vp_get_features(struct virtio_device *vdev)
{
         struct virtio_pci_device *vp_dev = to_vp_device(vdev);

         /* When someone needs more than 32 feature bits, we'll need to
          * steal a bit to indicate that the rest are somewhere else. */
         return ioread32(vp_dev->ioaddr + VIRTIO_PCI_HOST_FEATURES);
}

For VIRTIO_F_ACCESS_PLATFORM, it should be fine. But how about 
VIRTIO_F_ORDER_PLATFORM?


>
>>> +
>>> +     return features;
>>> +}
>>> +
>>> +static int eni_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
>>> +{
>>> +     struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
>>> +
>>> +     if (!(features & BIT_ULL(VIRTIO_NET_F_MRG_RXBUF)) && features) {
>>> +             ENI_ERR(ldev->pci_dev,
>>> +                     "VIRTIO_NET_F_MRG_RXBUF is not negotiated\n");
>>> +             return -EINVAL;
>> Do we need to make sure FEATURE_OK is not set in this case or the ENI can do
>> this for us?
> Why we need to check this? I don't get what you worried about.


I thought the plan is to advertise the VERSION_1, so failing when 
without mrg_rxbuf is a must. But looks like I was wrong, and there's no 
need to mandate mrg_rxbuf in future versions.

Thanks


>
>> Other looks good.
>>
>> Thanks

