Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60D5441263
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 04:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhKADeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 23:34:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46012 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230222AbhKADeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 23:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635737489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4z+r8vmmaZ/XATkk552nndpk1JEP3wPG2o03Q4EEusg=;
        b=NvZLcYMg8sgcDdyNf6cVhtlMTYTa5x96IDO3rYpC9rj48MS6TUUVwCC6237Owjhl5FE5JK
        DVNUMXTI69WmSVXqlG2Hq1aREwZZxgmZHwvLK8AgO9WKifzGLj1j4YMZzi/iYvJgiYJoKF
        DH4G9cX6ti7fOAZ3TiSdVnFpl/HShSw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-64oEgOptP6Wmeam8S1mm8g-1; Sun, 31 Oct 2021 23:31:28 -0400
X-MC-Unique: 64oEgOptP6Wmeam8S1mm8g-1
Received: by mail-lj1-f198.google.com with SMTP id m11-20020a2e97cb000000b00212f89f3888so1898347ljj.21
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 20:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4z+r8vmmaZ/XATkk552nndpk1JEP3wPG2o03Q4EEusg=;
        b=OvvsIZLoDfp2NXv4keXxMWPk2Qb7vV2rkEKz+NU3PUjvLRE+dA/83J6KE6mTm0we0p
         HTBFf+YCWU1pKvdYyOfDhdkJw18WvMPDMRVKb6t3LBTr837bokQRPcqBpgWNqoY0sNog
         8GsdWGoIO+y17PNfQA8xtknPwyvYEPPACG53nhvuWotUEYhN8Gfl9HgwBfVZ3gMAPOdU
         //T3JuSALXyI5K1eVwwTOLJpyJeY/YeY0OT5P7qI1BfJXiDLY1Rv2ywMrkslPnZnMhsJ
         XS/Q/M+exX7BAiP2SRTTTTnTbvERWixFXL+KlFcZj/cG4QBphmRUk08Zzaa1jNlw7zVe
         AL2w==
X-Gm-Message-State: AOAM532D12Yw6wlqh9DkNlkygHsWMii0QEYqWYPH+AucAVLkiri4pptq
        hKcRLx0t3hYH3ERTz3mcXrtDreYIlgYTvNC/LjEO6d9Bmsx6AoBQUBxcH9axhOan84braUwqB6K
        333K1ZBSqRjXdH8yL374znywGtp/GDtKgNMuJqK+9
X-Received: by 2002:a05:6512:32c1:: with SMTP id f1mr26163875lfg.498.1635737486291;
        Sun, 31 Oct 2021 20:31:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZWlYpHrxQKnB/mRgYJvPm5oK6xilCclq1C6WxSTBWhrktLxqFq+3etE8VWgYQ6+O+qG2hnOnZIaIV2E/R9cI=
X-Received: by 2002:a05:6512:32c1:: with SMTP id f1mr26163867lfg.498.1635737486110;
 Sun, 31 Oct 2021 20:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634870456.git.wuzongyong@linux.alibaba.com> <cover.1635493219.git.wuzongyong@linux.alibaba.com>
In-Reply-To: <cover.1635493219.git.wuzongyong@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 1 Nov 2021 11:31:15 +0800
Message-ID: <CACGkMEv8+1YMhXfS31CoyFuwJ-toCLXd12ny7b=Ge+3fXWNYUw@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] vDPA driver for Alibaba ENI
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mst <mst@redhat.com>, wei.yang1@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 5:15 PM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> This series implements the vDPA driver for Alibaba ENI (Elastic Network
> Interface) which is built based on virtio-pci 0.9.5 specification.

It looks to me Michael has applied the patches, if this is the case,
we probably need to send patches on top.

Thanks

>
> Changes since V6:
> - set default min vq size to 1 intead of 0
> - enable eni vdpa driver only on X86 hosts
> - fix some typos
>
> Changes since V5:
> - remove unused codes
>
> Changes since V4:
> - check return values of get_vq_num_{max,min} when probing devices
> - disable the driver on BE host via Kconfig
> - add missing commit message
>
> Changes since V3:
> - validate VIRTIO_NET_F_MRG_RXBUF when negotiate features
> - present F_ORDER_PLATFORM in get_features
> - remove endian check since ENI always use litter endian
>
> Changes since V2:
> - add new attribute VDPA_ATTR_DEV_MIN_VQ_SIZE instead
>   VDPA_ATTR_DEV_F_VERSION_1 to guide users to choose correct virtqueue
>   size as suggested by Jason Wang
> - present ACCESS_PLATFORM in get_features callback as suggested by Jason
>   Wang
> - disable this driver on Big Endian host as suggested by Jason Wang
> - fix a typo
>
> Changes since V1:
> - add new vdpa attribute VDPA_ATTR_DEV_F_VERSION_1 to indicate whether
>   the vdpa device is legacy
> - implement dedicated driver for Alibaba ENI instead a legacy virtio-pci
>   driver as suggested by Jason Wang
> - some bugs fixed
>
> Wu Zongyong (9):
>   virtio-pci: introduce legacy device module
>   vdpa: fix typo
>   vp_vdpa: add vq irq offloading support
>   vdpa: add new callback get_vq_num_min in vdpa_config_ops
>   vdpa: min vq num of vdpa device cannot be greater than max vq num
>   virtio_vdpa: setup correct vq size with callbacks get_vq_num_{max,min}
>   vdpa: add new attribute VDPA_ATTR_DEV_MIN_VQ_SIZE
>   eni_vdpa: add vDPA driver for Alibaba ENI
>   eni_vdpa: alibaba: fix Kconfig typo
>
>  drivers/vdpa/Kconfig                   |   8 +
>  drivers/vdpa/Makefile                  |   1 +
>  drivers/vdpa/alibaba/Makefile          |   3 +
>  drivers/vdpa/alibaba/eni_vdpa.c        | 553 +++++++++++++++++++++++++
>  drivers/vdpa/vdpa.c                    |  13 +
>  drivers/vdpa/virtio_pci/vp_vdpa.c      |  12 +
>  drivers/virtio/Kconfig                 |  10 +
>  drivers/virtio/Makefile                |   1 +
>  drivers/virtio/virtio_pci_common.c     |  10 +-
>  drivers/virtio/virtio_pci_common.h     |   9 +-
>  drivers/virtio/virtio_pci_legacy.c     | 101 ++---
>  drivers/virtio/virtio_pci_legacy_dev.c | 220 ++++++++++
>  drivers/virtio/virtio_vdpa.c           |  16 +-
>  include/linux/vdpa.h                   |   6 +-
>  include/linux/virtio_pci_legacy.h      |  42 ++
>  include/uapi/linux/vdpa.h              |   1 +
>  16 files changed, 917 insertions(+), 89 deletions(-)
>  create mode 100644 drivers/vdpa/alibaba/Makefile
>  create mode 100644 drivers/vdpa/alibaba/eni_vdpa.c
>  create mode 100644 drivers/virtio/virtio_pci_legacy_dev.c
>  create mode 100644 include/linux/virtio_pci_legacy.h
>
> --
> 2.31.1
>

