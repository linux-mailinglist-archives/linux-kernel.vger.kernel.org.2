Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799983ECDC8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 06:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhHPEve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 00:51:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44699 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbhHPEvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 00:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629089460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=rZs3mSB34nogWH2zmgxUCeVHfLL1OdFQlCndY96/B/0=;
        b=LUdJlzPTp7GpIpDcHcYdiVGG1vqrkDSyfmKonYW5Wjx5ygVgiaqEUGCY1Mdz7kpnrtjg5a
        9MlhlqvtYe1oDr5804k1S/TOrUdvupUhBFlPOXHwdsr8TMTSbEoqMiFTHiRiM8CttCc05B
        EOlzHQz48nDwabNx9UjhdngNcKrzjp4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-yr8DS-E7NKKbDOGsbTTZaw-1; Mon, 16 Aug 2021 00:50:59 -0400
X-MC-Unique: yr8DS-E7NKKbDOGsbTTZaw-1
Received: by mail-wm1-f72.google.com with SMTP id f19-20020a1c1f13000000b002e6bd83c344so2157363wmf.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 21:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=rZs3mSB34nogWH2zmgxUCeVHfLL1OdFQlCndY96/B/0=;
        b=DB2rM3jglZ5G0ldQeaFay0IChy60RPSw3r9Hdu8QthRqzxdFUJg8e5lSjkMm5O6qsG
         eZgvQ/WRHpz+lu7jhQddRs9/wT7VTI0zqjWan+nXPRqr8Yv18dC3D0gNdgnQT7zeXQzK
         eEu/KQ3HHLZ9SwxikBZqvm8u+QhpugUwnPX3m5k7X8kxkAldz+tvuc6kc8UlcCaUuM0I
         kk/GOtaQYFgQMyZXdK/RJaVgyuv+0pqDsSU/snnRlug2WBocVuDmic1QTfK3D8nzghnF
         b6qu7LEXw5pXzhsr7t8m9BjEVgTvyPkhDDOeB2/dy7Jzq43Q0keUWs8wQ9Mpj7+tKn8i
         CXjA==
X-Gm-Message-State: AOAM533maCssvLy/nlrwOpVZQXPA3Zk99uJz7IBXZarg9bItVFveh/8T
        5s79Pswx2biY/vTYvgLuAxop91N2hvfwO87x+7Lrsf1vGFzZjauH+d4PrjRWhT0MVga1l22VHJp
        F2rqmtVOV53N059s+WTgR3TWP
X-Received: by 2002:a5d:4602:: with SMTP id t2mr1228061wrq.378.1629089458120;
        Sun, 15 Aug 2021 21:50:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjBjilHWhHeVXJ212gHSVnkj7N49KZUrKpxQq7yztn932X8qS+NGWF0om+LCe2aMv5wZThUw==
X-Received: by 2002:a5d:4602:: with SMTP id t2mr1228046wrq.378.1629089457942;
        Sun, 15 Aug 2021 21:50:57 -0700 (PDT)
Received: from redhat.com ([2.55.8.239])
        by smtp.gmail.com with ESMTPSA id m10sm12398087wro.63.2021.08.15.21.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 21:50:57 -0700 (PDT)
Date:   Mon, 16 Aug 2021 00:50:54 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, elic@nvidia.com, jasowang@redhat.com,
        mst@redhat.com, neeraju@codeaurora.org, parav@nvidia.com,
        vincent.whitchurch@axis.com, xieyongji@bytedance.com
Subject: [GIT PULL] virtio,vhost,vdpa: bugfixes
Message-ID: <20210816005054-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 36a21d51725af2ce0700c6ebcb6b9594aac658a6:

  Linux 5.14-rc5 (2021-08-08 13:49:31 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 879753c816dbbdb2a9a395aa4448d29feee92d1a:

  vdpa/mlx5: Fix queue type selection logic (2021-08-11 06:44:43 -0400)

----------------------------------------------------------------
virtio,vhost,vdpa: bugfixes

Fixes in virtio,vhost,vdpa drivers.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Eli Cohen (2):
      vdpa/mlx5: Avoid destroying MR on empty iotlb
      vdpa/mlx5: Fix queue type selection logic

Michael S. Tsirkin (3):
      vringh: pull in spinlock header
      virtio_ring: pull in spinlock header
      tools/virtio: fix build

Neeraj Upadhyay (1):
      vringh: Use wiov->used to check for read/write desc order

Parav Pandit (4):
      virtio: Improve vq->broken access to avoid any compiler optimization
      virtio: Keep vring_del_virtqueue() mirror of VQ create
      virtio: Protect vqs list access
      virtio_pci: Support surprise removal of virtio pci device

Vincent Whitchurch (1):
      virtio_vdpa: reject invalid vq indices

Xie Yongji (7):
      vhost-vdpa: Fix integer overflow in vhost_vdpa_process_iotlb_update()
      vhost: Fix the calculation in vhost_overflow()
      vdpa_sim: Fix return value check for vdpa_alloc_device()
      vp_vdpa: Fix return value check for vdpa_alloc_device()
      vDPA/ifcvf: Fix return value check for vdpa_alloc_device()
      vdpa: Add documentation for vdpa_alloc_device() macro
      virtio-blk: Add validation for block size in config space

 drivers/block/virtio_blk.c         | 39 ++++++++++++++++++++++----
 drivers/vdpa/ifcvf/ifcvf_main.c    |  4 +--
 drivers/vdpa/mlx5/core/mr.c        |  9 ------
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 14 +++++++---
 drivers/vdpa/vdpa_sim/vdpa_sim.c   |  4 ++-
 drivers/vdpa/virtio_pci/vp_vdpa.c  |  4 +--
 drivers/vhost/vdpa.c               |  3 +-
 drivers/vhost/vhost.c              | 10 +++++--
 drivers/vhost/vringh.c             |  2 +-
 drivers/virtio/virtio.c            |  1 +
 drivers/virtio/virtio_pci_common.c |  7 +++++
 drivers/virtio/virtio_ring.c       | 18 ++++++++++--
 drivers/virtio/virtio_vdpa.c       |  3 ++
 include/linux/mlx5/mlx5_ifc_vdpa.h | 10 ++++---
 include/linux/vdpa.h               | 11 ++++++++
 include/linux/virtio.h             |  1 +
 include/linux/vringh.h             |  1 +
 tools/virtio/Makefile              |  3 +-
 tools/virtio/linux/spinlock.h      | 56 ++++++++++++++++++++++++++++++++++++++
 tools/virtio/linux/virtio.h        |  2 ++
 20 files changed, 166 insertions(+), 36 deletions(-)
 create mode 100644 tools/virtio/linux/spinlock.h

