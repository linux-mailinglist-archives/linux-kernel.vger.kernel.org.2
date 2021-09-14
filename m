Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F9640AD83
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 14:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbhINM0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 08:26:45 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:49553 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232341AbhINM0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 08:26:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UoNt7PD_1631622314;
Received: from localhost.localdomain(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0UoNt7PD_1631622314)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 Sep 2021 20:25:24 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     wuzongyong@linux.alibaba.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com
Cc:     wei.yang1@linux.alibaba.com
Subject: [PATCH v2 0/5] vDPA driver for Alibaba ENI
Date:   Tue, 14 Sep 2021 20:24:47 +0800
Message-Id: <cover.1631621507.git.wuzongyong@linux.alibaba.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements the vDPA driver for Alibaba ENI(Elastic Network
Interface) which is build based on virtio-pci 0.9.5 specification.

A new vdpa attribute VDPA_ATTR_DEV_F_VERSION_1 is introduced to guide
users to choose right virtqueue size if the vdpa device is legacy.

Change From V1:
- add new vdpa attribute VDPA_ATTR_DEV_F_VERSION_1 to indicate whether
  the vdpa device is legacy
- implement dedicated driver for Alibaba ENI instead a legacy virtio-pci
  driver as suggested by Jason Wang
- some bugs fixed

Wu Zongyong (5):
  virtio-pci: introduce legacy device module
  vdpa: fix typo
  vp_vdpa: add vq irq offloading support
  vdpa: add new vdpa attribute VDPA_ATTR_DEV_F_VERSION_1
  eni_vdpa: add vDPA driver for Alibaba ENI

 drivers/vdpa/Kconfig                   |   8 +
 drivers/vdpa/Makefile                  |   1 +
 drivers/vdpa/alibaba/Makefile          |   3 +
 drivers/vdpa/alibaba/eni_vdpa.c        | 537 +++++++++++++++++++++++++
 drivers/vdpa/vdpa.c                    |   6 +
 drivers/vdpa/virtio_pci/vp_vdpa.c      |  12 +
 drivers/virtio/Kconfig                 |  10 +
 drivers/virtio/Makefile                |   1 +
 drivers/virtio/virtio_pci_common.c     |  10 +-
 drivers/virtio/virtio_pci_common.h     |   9 +-
 drivers/virtio/virtio_pci_legacy.c     | 101 ++---
 drivers/virtio/virtio_pci_legacy_dev.c | 220 ++++++++++
 drivers/virtio/virtio_vdpa.c           |   7 +-
 include/linux/vdpa.h                   |   2 +-
 include/linux/virtio_pci_legacy.h      |  44 ++
 include/uapi/linux/vdpa.h              |   1 +
 16 files changed, 887 insertions(+), 85 deletions(-)
 create mode 100644 drivers/vdpa/alibaba/Makefile
 create mode 100644 drivers/vdpa/alibaba/eni_vdpa.c
 create mode 100644 drivers/virtio/virtio_pci_legacy_dev.c
 create mode 100644 include/linux/virtio_pci_legacy.h

-- 
2.31.1

