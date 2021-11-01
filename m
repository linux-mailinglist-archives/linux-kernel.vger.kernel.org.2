Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFDE441A82
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 12:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhKALPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 07:15:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21057 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232136AbhKALPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 07:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635765146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6ZFhVEO+We6qm43UDAioY1QSBCdYaZIxbYcL8uvY64Y=;
        b=TSSXdCMgx8ouWeYKEMRiwsYC4zZCgXeqWiAY2kLLh9OYgNc2lVNtxG2OLTL6w6lwphzLbt
        An845XCbiCFRtdKSRGLkXGGOAzHIUG4B3bDJYGTmmmhnxGeryHkL+60TdJvGl1yY+hNM5G
        NpP5EvFC7p90xQVzDANvAEWuBlBdyiU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-EQMgtpmZOJ6W0x2UbeEv3w-1; Mon, 01 Nov 2021 07:12:24 -0400
X-MC-Unique: EQMgtpmZOJ6W0x2UbeEv3w-1
Received: by mail-wm1-f69.google.com with SMTP id a186-20020a1c7fc3000000b00332f1a308e7so1044700wmd.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 04:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6ZFhVEO+We6qm43UDAioY1QSBCdYaZIxbYcL8uvY64Y=;
        b=PODsmBSW+jrV3lEHr5i8IKAe+oSQo5EESiRkEVO56cGHLlliUV741s1AWsHfyV1WgT
         lEdAHfXU89t5bTNLTR0ERDFwHxy7vykabgHp7rNu3LFS496Ty5hYL3+FJDNmHV4yITxR
         JTd/EBPAKplMGIAl40OuRW7TzHIWFvw1AiiN3LZBL1gjCKoiYsXfjQK7M2bQqV9ze25A
         tvOO+HGUh91Fj0NCtyyY95JO4ew+bGzG5sLQiwAWe6IT4QmHXCEVN7DC09m39r9JiFvj
         0krFW2cMNMORoJdAosklmOH9ZmgpL0uIgav66uQQ1w0ZeSviLzAgI4AlhjRVh97tSm5O
         xCRA==
X-Gm-Message-State: AOAM533FUgzU/3fWFzNCriJleocqnIex573R2xJDrk7+TBL3pD4FZQ70
        CP3z19aXGO8r2wDvmrtuSxubdtZyVdnnIeffbQebygyTZYRGXsIYNuARyhP0t/RRgqCvGWC2Yh1
        n8I6nTRQ51f1DtVMjhD7+rbJ8
X-Received: by 2002:a1c:8090:: with SMTP id b138mr16426507wmd.25.1635765143636;
        Mon, 01 Nov 2021 04:12:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwisKVtWLf4fD5NwZ4Am8fKpj39xISIcWYMZ4VZQyVX9L141g3kzyjbm8B0Xz0WdH5R58pfqw==
X-Received: by 2002:a1c:8090:: with SMTP id b138mr16426488wmd.25.1635765143448;
        Mon, 01 Nov 2021 04:12:23 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:107f:7087:907d:ff12:1534:78b7])
        by smtp.gmail.com with ESMTPSA id v3sm14122663wrg.23.2021.11.01.04.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 04:12:22 -0700 (PDT)
Date:   Mon, 1 Nov 2021 07:12:17 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        wei.yang1@linux.alibaba.com
Subject: Re: [PATCH v7 0/9] vDPA driver for Alibaba ENI
Message-ID: <20211101071140-mutt-send-email-mst@kernel.org>
References: <cover.1634870456.git.wuzongyong@linux.alibaba.com>
 <cover.1635493219.git.wuzongyong@linux.alibaba.com>
 <CACGkMEv8+1YMhXfS31CoyFuwJ-toCLXd12ny7b=Ge+3fXWNYUw@mail.gmail.com>
 <20211101062250.GA29814@L-PF27918B-1352.localdomain>
 <CACGkMEvZkdEgAFpSo1Oen5JWthSowZ7NHqnp_X5AhNt+jxuiZg@mail.gmail.com>
 <20211101081159.GA4341@L-PF27918B-1352.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101081159.GA4341@L-PF27918B-1352.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 04:11:59PM +0800, Wu Zongyong wrote:
> On Mon, Nov 01, 2021 at 03:02:52PM +0800, Jason Wang wrote:
> > On Mon, Nov 1, 2021 at 2:23 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
> > >
> > > On Mon, Nov 01, 2021 at 11:31:15AM +0800, Jason Wang wrote:
> > > > On Fri, Oct 29, 2021 at 5:15 PM Wu Zongyong
> > > > <wuzongyong@linux.alibaba.com> wrote:
> > > > >
> > > > > This series implements the vDPA driver for Alibaba ENI (Elastic Network
> > > > > Interface) which is built based on virtio-pci 0.9.5 specification.
> > > >
> > > > It looks to me Michael has applied the patches, if this is the case,
> > > > we probably need to send patches on top.
> > >
> > > What do you mean by saying "send patches on top"?
> > > Sorry, I'm a newbie to contribute for kernel, could you please explain
> > > it in detail?
> > 
> > I meant you probably need to send incremental patch on top of:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next.
> 
> Get it.
> 
> Thanks

No need, I rebased.

> > 
> > Thanks
> > 
> > 
> > >
> > > Thanks
> > > > Thanks
> > > >
> > > > >
> > > > > Changes since V6:
> > > > > - set default min vq size to 1 intead of 0
> > > > > - enable eni vdpa driver only on X86 hosts
> > > > > - fix some typos
> > > > >
> > > > > Changes since V5:
> > > > > - remove unused codes
> > > > >
> > > > > Changes since V4:
> > > > > - check return values of get_vq_num_{max,min} when probing devices
> > > > > - disable the driver on BE host via Kconfig
> > > > > - add missing commit message
> > > > >
> > > > > Changes since V3:
> > > > > - validate VIRTIO_NET_F_MRG_RXBUF when negotiate features
> > > > > - present F_ORDER_PLATFORM in get_features
> > > > > - remove endian check since ENI always use litter endian
> > > > >
> > > > > Changes since V2:
> > > > > - add new attribute VDPA_ATTR_DEV_MIN_VQ_SIZE instead
> > > > >   VDPA_ATTR_DEV_F_VERSION_1 to guide users to choose correct virtqueue
> > > > >   size as suggested by Jason Wang
> > > > > - present ACCESS_PLATFORM in get_features callback as suggested by Jason
> > > > >   Wang
> > > > > - disable this driver on Big Endian host as suggested by Jason Wang
> > > > > - fix a typo
> > > > >
> > > > > Changes since V1:
> > > > > - add new vdpa attribute VDPA_ATTR_DEV_F_VERSION_1 to indicate whether
> > > > >   the vdpa device is legacy
> > > > > - implement dedicated driver for Alibaba ENI instead a legacy virtio-pci
> > > > >   driver as suggested by Jason Wang
> > > > > - some bugs fixed
> > > > >
> > > > > Wu Zongyong (9):
> > > > >   virtio-pci: introduce legacy device module
> > > > >   vdpa: fix typo
> > > > >   vp_vdpa: add vq irq offloading support
> > > > >   vdpa: add new callback get_vq_num_min in vdpa_config_ops
> > > > >   vdpa: min vq num of vdpa device cannot be greater than max vq num
> > > > >   virtio_vdpa: setup correct vq size with callbacks get_vq_num_{max,min}
> > > > >   vdpa: add new attribute VDPA_ATTR_DEV_MIN_VQ_SIZE
> > > > >   eni_vdpa: add vDPA driver for Alibaba ENI
> > > > >   eni_vdpa: alibaba: fix Kconfig typo
> > > > >
> > > > >  drivers/vdpa/Kconfig                   |   8 +
> > > > >  drivers/vdpa/Makefile                  |   1 +
> > > > >  drivers/vdpa/alibaba/Makefile          |   3 +
> > > > >  drivers/vdpa/alibaba/eni_vdpa.c        | 553 +++++++++++++++++++++++++
> > > > >  drivers/vdpa/vdpa.c                    |  13 +
> > > > >  drivers/vdpa/virtio_pci/vp_vdpa.c      |  12 +
> > > > >  drivers/virtio/Kconfig                 |  10 +
> > > > >  drivers/virtio/Makefile                |   1 +
> > > > >  drivers/virtio/virtio_pci_common.c     |  10 +-
> > > > >  drivers/virtio/virtio_pci_common.h     |   9 +-
> > > > >  drivers/virtio/virtio_pci_legacy.c     | 101 ++---
> > > > >  drivers/virtio/virtio_pci_legacy_dev.c | 220 ++++++++++
> > > > >  drivers/virtio/virtio_vdpa.c           |  16 +-
> > > > >  include/linux/vdpa.h                   |   6 +-
> > > > >  include/linux/virtio_pci_legacy.h      |  42 ++
> > > > >  include/uapi/linux/vdpa.h              |   1 +
> > > > >  16 files changed, 917 insertions(+), 89 deletions(-)
> > > > >  create mode 100644 drivers/vdpa/alibaba/Makefile
> > > > >  create mode 100644 drivers/vdpa/alibaba/eni_vdpa.c
> > > > >  create mode 100644 drivers/virtio/virtio_pci_legacy_dev.c
> > > > >  create mode 100644 include/linux/virtio_pci_legacy.h
> > > > >
> > > > > --
> > > > > 2.31.1
> > > > >
> > >

