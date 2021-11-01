Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5745944153A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 09:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhKAIWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 04:22:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28854 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231223AbhKAIV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 04:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635754764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kBVOOyaoa1InLL/+ffGw+8bT8fwSPIwAJAyuABlhWqc=;
        b=VyNampVpFffACNdl3qJA6fxrxwSmDlE25/FOqqZLLtaUYipWaf4bnjcPE9LYCCJNwIVQD7
        RJfo921K47oSSip1sfG0g3EpYsU4oD5zwI3MTpOgzLYhncPtnSduIBFnCuOvDx7A0yxiQV
        4BM7FsHORyUIxSICd76/JNI2Q0F3Vvo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-qC-_8UUIMCCjvNpA9zZ-NQ-1; Mon, 01 Nov 2021 04:19:23 -0400
X-MC-Unique: qC-_8UUIMCCjvNpA9zZ-NQ-1
Received: by mail-ed1-f71.google.com with SMTP id t18-20020a056402021200b003db9e6b0e57so14854437edv.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 01:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kBVOOyaoa1InLL/+ffGw+8bT8fwSPIwAJAyuABlhWqc=;
        b=hjHnJIU1zeAPPhSFUyvWDh6lh86/8Es3fOpZGAwPp5STO3G8FWf9O3ZlYzn772Hvpr
         Dg5wtXtMjcVk7chTLa1D3iJu1nIy6q8NUm5WAD6J9+CcoMdqsXO7Fiw1/wQVUf0sDMQu
         JPVzGJ73w0xamuhGnrTrzoUZXmQHkC6olGE1H64e209YjOVRHvDGo22Hiqr4tak/RHVM
         t/+PpvJtnrLwWXxox73b9CFTEdKrvuYmYtRwj6ftZunkuf6IMblj8fyaWmCaMT9VAQXL
         Dz1J7fTTrLQhugWC64hsSEZtyXK/J8tMia5CCdwR/lOnwROZAWnjrTHUaZGDnTq7PgiF
         dOgw==
X-Gm-Message-State: AOAM530RwSdFKnn7c6nKofEZuuBQVnk1t1VUFg5r/BW3118rTVSj9bqx
        YWmE44Dxsyi5GIKedQ1P6sJp/QJHvvCVwYVPfspI5YzZFwRx/WAVqEbDg1E8SfFR3NzpXpCCY70
        et9GiVwMtGe138zqY2kBt6/gI
X-Received: by 2002:a17:906:9501:: with SMTP id u1mr33785982ejx.496.1635754761877;
        Mon, 01 Nov 2021 01:19:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzonKX2m+XR50OstF9piRdvpS0ryGxmcZfSehSgi21On/RYiZJT85J1FRh0pPRnji5Gx1AJ+A==
X-Received: by 2002:a17:906:9501:: with SMTP id u1mr33785961ejx.496.1635754761739;
        Mon, 01 Nov 2021 01:19:21 -0700 (PDT)
Received: from redhat.com ([176.12.204.186])
        by smtp.gmail.com with ESMTPSA id v10sm8329296edt.24.2021.11.01.01.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 01:19:20 -0700 (PDT)
Date:   Mon, 1 Nov 2021 04:19:16 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, wei.yang1@linux.alibaba.com
Subject: Re: [PATCH v7 0/9] vDPA driver for Alibaba ENI
Message-ID: <20211101041846-mutt-send-email-mst@kernel.org>
References: <cover.1634870456.git.wuzongyong@linux.alibaba.com>
 <cover.1635493219.git.wuzongyong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1635493219.git.wuzongyong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 05:14:41PM +0800, Wu Zongyong wrote:
> This series implements the vDPA driver for Alibaba ENI (Elastic Network
> Interface) which is built based on virtio-pci 0.9.5 specification.

In the future pls do not send v7 as a reply to v6.
Start a new thread with each version.

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

