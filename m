Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657804039A9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 14:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351719AbhIHMWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 08:22:23 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:50422 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351652AbhIHMWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:22:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UnhbUrf_1631103655;
Received: from localhost.localdomain(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0UnhbUrf_1631103655)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 Sep 2021 20:21:05 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     wuzongyong@linux.alibaba.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com
Cc:     wei.yang1@linux.alibaba.com
Subject: [PATCH 0/6] vDPA driver for legacy virtio-pci device
Date:   Wed,  8 Sep 2021 20:20:31 +0800
Message-Id: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements the vDPA driver for legacy virtio-pci device.
Currently we already have the vDPA driver for modern virtio-pci device
only, but there are some legacy virtio-pci devices conforming to the
virtio-pci specifications of 0.9.x or older versions. For example,
ENI(Elastic Network Interface) of Alibaba ECS baremetal instance is a
hardware virtio network device which follows the Virtio PCI Card 0.9.5
Draft specification. Such legacy virtio-pci devices have some
inconsistent behaviour with modern virtio-pci devices, so some common
codes are split out and modern device specific codes are moved to a
separated file.

For legacy devices, it is not supported to negotiate the virtqueue size
by the specification. So a new callback get_vq_num_unchangeable is
introduced to indicate user not to try change the virtqueue size of the
legacy vdpa device. For example, QEMU should not allocate memory for
virtqueue according to the properties tx_queue_size and rx_queue_size if
we use legacy virtio-pci device as the vhost-vdpa backend. Instead, QEMU
should use the new callback get_vq_num_unchangeable first to check if
the vdpa device support to change virtqueue size. If not, QEMU should
call the callback get_vq_num_max to get the static virtqueue size then
allocate the same size memory for the virtqueue.

This series have been tested with the ENI in Alibaba ECS baremetal
instance.

These patches may under consideration, welcome for comments.


Wu Zongyong (6):
  virtio-pci: introduce legacy device module
  vdpa: fix typo
  vp_vdpa: add vq irq offloading support
  vp_vdpa: split out reusable and device specific codes to separate file
  vdpa: add get_vq_num_unchangeable callback in vdpa_config_ops
  vp_vdpa: introduce legacy virtio pci driver

 drivers/vdpa/Kconfig                     |   7 +
 drivers/vdpa/virtio_pci/Makefile         |   3 +
 drivers/vdpa/virtio_pci/vp_vdpa.c        |   8 +
 drivers/vdpa/virtio_pci/vp_vdpa_common.c | 220 ++++++++++++++
 drivers/vdpa/virtio_pci/vp_vdpa_common.h |  67 +++++
 drivers/vdpa/virtio_pci/vp_vdpa_legacy.c | 346 +++++++++++++++++++++++
 drivers/vdpa/virtio_pci/vp_vdpa_modern.c | 327 +++++++++++++++++++++
 drivers/vhost/vdpa.c                     |  19 ++
 drivers/virtio/Kconfig                   |  10 +
 drivers/virtio/Makefile                  |   1 +
 drivers/virtio/virtio_pci_common.c       |  10 +-
 drivers/virtio/virtio_pci_common.h       |   9 +-
 drivers/virtio/virtio_pci_legacy.c       | 101 ++-----
 drivers/virtio/virtio_pci_legacy_dev.c   | 220 ++++++++++++++
 drivers/virtio/virtio_vdpa.c             |   5 +-
 include/linux/vdpa.h                     |   6 +-
 include/linux/virtio_pci_legacy.h        |  44 +++
 include/uapi/linux/vhost.h               |   2 +
 18 files changed, 1320 insertions(+), 85 deletions(-)
 create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa_common.c
 create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa_common.h
 create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa_legacy.c
 create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa_modern.c
 create mode 100644 drivers/virtio/virtio_pci_legacy_dev.c
 create mode 100644 include/linux/virtio_pci_legacy.h

-- 
2.31.1

