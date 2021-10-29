Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2010C43F991
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 11:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhJ2JRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 05:17:35 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:34688 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229986AbhJ2JRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 05:17:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Uu7wNNx_1635498896;
Received: from localhost.localdomain(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0Uu7wNNx_1635498896)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 29 Oct 2021 17:15:02 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        wuzongyong@linux.alibaba.com
Cc:     wei.yang1@linux.alibaba.com
Subject: [PATCH v7 0/9] vDPA driver for Alibaba ENI
Date:   Fri, 29 Oct 2021 17:14:41 +0800
Message-Id: <cover.1635493219.git.wuzongyong@linux.alibaba.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634870456.git.wuzongyong@linux.alibaba.com>
References: <cover.1634870456.git.wuzongyong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements the vDPA driver for Alibaba ENI (Elastic Network
Interface) which is built based on virtio-pci 0.9.5 specification.

Changes since V6:
- set default min vq size to 1 intead of 0
- enable eni vdpa driver only on X86 hosts
- fix some typos

Changes since V5:
- remove unused codes

Changes since V4:
- check return values of get_vq_num_{max,min} when probing devices
- disable the driver on BE host via Kconfig
- add missing commit message

Changes since V3:
- validate VIRTIO_NET_F_MRG_RXBUF when negotiate features
- present F_ORDER_PLATFORM in get_features
- remove endian check since ENI always use litter endian

Changes since V2:
- add new attribute VDPA_ATTR_DEV_MIN_VQ_SIZE instead
  VDPA_ATTR_DEV_F_VERSION_1 to guide users to choose correct virtqueue
  size as suggested by Jason Wang
- present ACCESS_PLATFORM in get_features callback as suggested by Jason
  Wang
- disable this driver on Big Endian host as suggested by Jason Wang
- fix a typo

Changes since V1:
- add new vdpa attribute VDPA_ATTR_DEV_F_VERSION_1 to indicate whether
  the vdpa device is legacy
- implement dedicated driver for Alibaba ENI instead a legacy virtio-pci
  driver as suggested by Jason Wang
- some bugs fixed

Wu Zongyong (9):
  virtio-pci: introduce legacy device module
  vdpa: fix typo
  vp_vdpa: add vq irq offloading support
  vdpa: add new callback get_vq_num_min in vdpa_config_ops
  vdpa: min vq num of vdpa device cannot be greater than max vq num
  virtio_vdpa: setup correct vq size with callbacks get_vq_num_{max,min}
  vdpa: add new attribute VDPA_ATTR_DEV_MIN_VQ_SIZE
  eni_vdpa: add vDPA driver for Alibaba ENI
  eni_vdpa: alibaba: fix Kconfig typo

 drivers/vdpa/Kconfig                   |   8 +
 drivers/vdpa/Makefile                  |   1 +
 drivers/vdpa/alibaba/Makefile          |   3 +
 drivers/vdpa/alibaba/eni_vdpa.c        | 553 +++++++++++++++++++++++++
 drivers/vdpa/vdpa.c                    |  13 +
 drivers/vdpa/virtio_pci/vp_vdpa.c      |  12 +
 drivers/virtio/Kconfig                 |  10 +
 drivers/virtio/Makefile                |   1 +
 drivers/virtio/virtio_pci_common.c     |  10 +-
 drivers/virtio/virtio_pci_common.h     |   9 +-
 drivers/virtio/virtio_pci_legacy.c     | 101 ++---
 drivers/virtio/virtio_pci_legacy_dev.c | 220 ++++++++++
 drivers/virtio/virtio_vdpa.c           |  16 +-
 include/linux/vdpa.h                   |   6 +-
 include/linux/virtio_pci_legacy.h      |  42 ++
 include/uapi/linux/vdpa.h              |   1 +
 16 files changed, 917 insertions(+), 89 deletions(-)
 create mode 100644 drivers/vdpa/alibaba/Makefile
 create mode 100644 drivers/vdpa/alibaba/eni_vdpa.c
 create mode 100644 drivers/virtio/virtio_pci_legacy_dev.c
 create mode 100644 include/linux/virtio_pci_legacy.h

-- 
2.31.1

