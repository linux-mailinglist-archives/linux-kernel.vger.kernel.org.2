Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2962230B619
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 04:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhBBDyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 22:54:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49316 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231158AbhBBDys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 22:54:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612238001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cafQreaiV+gjtqgE/Nu7o5K5at0fIjvGIgZ0VeRpg0M=;
        b=U8zR6gm6POxy8C4bRL/jgSUE+sUVemezMEsIVo0nwp/I452YEl8bJMHmEfiNF4XCd9pOpv
        MKbOmEY/o2f2lxCIw4nlvf0aA7fXH9JYiWejPPNEECJzDtpkh8fIhZDhlfP5KycBRQKUsY
        mlofHfkMiyCeYe5ETD5D8k7gCaxr/w4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-dlb4eWRFMS-DZiIYryNZwA-1; Mon, 01 Feb 2021 22:53:16 -0500
X-MC-Unique: dlb4eWRFMS-DZiIYryNZwA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 433711800D50;
        Tue,  2 Feb 2021 03:53:12 +0000 (UTC)
Received: from [10.72.13.250] (ovpn-13-250.pek2.redhat.com [10.72.13.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3723627C24;
        Tue,  2 Feb 2021 03:53:06 +0000 (UTC)
Subject: Re: [PATCH V3 00/19] vDPA driver for virtio-pci device
To:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com, lulu@redhat.com, sgarzare@redhat.com,
        rdunlap@infradead.org
References: <20210104065503.199631-1-jasowang@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <21d3cd67-0e5d-a202-2dc1-bf7f4907f180@redhat.com>
Date:   Tue, 2 Feb 2021 11:53:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210104065503.199631-1-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/1/4 下午2:54, Jason Wang wrote:
> Hi all:
>
> This series tries to implement a vDPA driver for virtio-pci device
> which will bridge between vDPA bus and virtio-pci device.
>
> This could be used for future feature prototyping and testing.
>
> Please review
>
> Changes since V2:
>
> - tweak config prompt
> - switch from 'cb' to 'config_cb' for vp_vdpa config interrupt
> - use a macro for vp_vdpa msix name length


Hi Michael:

Any comments on this series?

Thanks


>
> Changes since V1:
>
> - don't try to use devres for virtio-pci core
> - tweak the commit log
> - split the patches furtherly to ease the reviewing
>
> Changes since RFC:
>
> - Split common codes from virito-pci and share it with vDPA driver
> - Use dynamic id in order to be less confusing with virtio-pci driver
> - No feature whitelist, supporting any features (mq, config etc)
>
> Thanks
>
> Jason Wang (19):
>    virtio-pci: do not access iomem via struct virtio_pci_device directly
>    virtio-pci: split out modern device
>    virtio-pci-modern: factor out modern device initialization logic
>    virtio-pci-modern: introduce vp_modern_remove()
>    virtio-pci-modern: introduce helper to set config vector
>    virtio-pci-modern: introduce helpers for setting and getting status
>    virtio-pci-modern: introduce helpers for setting and getting features
>    virtio-pci-modern: introduce vp_modern_generation()
>    virtio-pci-modern: introduce vp_modern_set_queue_vector()
>    virtio-pci-modern: introduce vp_modern_queue_address()
>    virtio-pci-modern: introduce helper to set/get queue_enable
>    virtio-pci-modern: introduce helper for setting/geting queue size
>    virtio-pci-modern: introduce helper for getting queue nums
>    virtio-pci-modern: introduce helper to get notification offset
>    virito-pci-modern: rename map_capability() to
>      vp_modern_map_capability()
>    virtio-pci: introduce modern device module
>    vdpa: set the virtqueue num during register
>    virtio_vdpa: don't warn when fail to disable vq
>    vdpa: introduce virtio pci driver
>
>   drivers/vdpa/Kconfig                   |   6 +
>   drivers/vdpa/Makefile                  |   1 +
>   drivers/vdpa/ifcvf/ifcvf_main.c        |   5 +-
>   drivers/vdpa/mlx5/net/mlx5_vnet.c      |   5 +-
>   drivers/vdpa/vdpa.c                    |   8 +-
>   drivers/vdpa/vdpa_sim/vdpa_sim.c       |   4 +-
>   drivers/vdpa/virtio_pci/Makefile       |   2 +
>   drivers/vdpa/virtio_pci/vp_vdpa.c      | 456 +++++++++++++++++++
>   drivers/virtio/Kconfig                 |  10 +-
>   drivers/virtio/Makefile                |   1 +
>   drivers/virtio/virtio_pci_common.h     |  22 +-
>   drivers/virtio/virtio_pci_modern.c     | 506 +++------------------
>   drivers/virtio/virtio_pci_modern_dev.c | 599 +++++++++++++++++++++++++
>   drivers/virtio/virtio_vdpa.c           |   3 +-
>   include/linux/vdpa.h                   |   7 +-
>   include/linux/virtio_pci_modern.h      | 111 +++++
>   16 files changed, 1274 insertions(+), 472 deletions(-)
>   create mode 100644 drivers/vdpa/virtio_pci/Makefile
>   create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa.c
>   create mode 100644 drivers/virtio/virtio_pci_modern_dev.c
>   create mode 100644 include/linux/virtio_pci_modern.h
>

