Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225273FE2C5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 21:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346129AbhIATKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 15:10:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51341 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344585AbhIATJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 15:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630523304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PXaMY1BIToeB6M9mMoUesG2shI0UqdheUpIVd2ug/yA=;
        b=PP4O3bGU/hdTHNxYOH3j+NGt5HZ92ybEfDcbdFc3gmQTRJ+lidaljGkS5e2V7pASWJmNWG
        VJ5Lqjj3WeYaME5x0zBlKXaQXIny9GMLwZj17ckw1mEslDtRt3zlJqFNEwFe/J2nIK2agF
        xLnZjz3V6sbkvecrjQC0+ed79T6zN2o=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-yc15BXAJPDOeCngjf73jsA-1; Wed, 01 Sep 2021 15:08:24 -0400
X-MC-Unique: yc15BXAJPDOeCngjf73jsA-1
Received: by mail-oi1-f198.google.com with SMTP id r25-20020a056808211900b00268b48af6baso228632oiw.23
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 12:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=PXaMY1BIToeB6M9mMoUesG2shI0UqdheUpIVd2ug/yA=;
        b=Ty1dHjCMMw6JdnL+HyaMacrSE7r501H4Ac/2OQ4QL4qAxMd6f19HyOEc7sxgL8qUis
         W2h0kY2f2IGiok/h+hYb7pQ2Yq18rzCeSMit0cTa2oBZS3WQh0fhjKbkYdnCatDIB8Ay
         ZzvC4uYHfrn/HLOPr4uSxSiE0LhcqQKhxVshrb6ju4cnQEeepCyVaRzowab+IcuzVzPi
         N06fq+WPyRMTFsCEucLcdrnGQiI0NJM7wwVYnNuYVE/aWJcdkbypgNwG9WzP1xjPP8lC
         nojPAgFEKyO36pe5DCnR04yUXRSYndXnXwczxQneuS0A4lPdjwbwfBgCi3Ro4+9e3j8C
         9R/g==
X-Gm-Message-State: AOAM532beZ+lH6eZzUGVJW/oLWK9EtEpQUOfjw9xPuUge84IHQqzijY3
        Ai99yTMJvD33PHJl4auNjssq/eyyjN8bMYJFhd365RhbkoCpKUz/gZY4rIYpm/XTsX8BdMmoT6T
        CBLHG3HLu3qSpi5GgFebg4EWs
X-Received: by 2002:a9d:60c6:: with SMTP id b6mr848926otk.2.1630523303092;
        Wed, 01 Sep 2021 12:08:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz76t98luQNVDliUDl8PwEH4Izeu5b6kp1nlRZx+Gwr7e3XpnRmUBkAIbF3ehk8NSXWzRHq7w==
X-Received: by 2002:a9d:60c6:: with SMTP id b6mr848899otk.2.1630523302856;
        Wed, 01 Sep 2021 12:08:22 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id bj27sm73079oib.58.2021.09.01.12.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 12:08:22 -0700 (PDT)
Date:   Wed, 1 Sep 2021 13:08:21 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Dave Airlie <airlied@linux.ie>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] VFIO update for v5.15-rc1
Message-ID: <20210901130821.6c81da7e.alex.williamson@redhat.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

There's a conflict here with the drm tree, where I see Dave's pull
request is already in flight.  Stephen provided the correct resolution
here[1], applying the vfio_pci.c changes from the drm tree to the new
vfio_pci_core.c file.  Thanks!

[1]https://lore.kernel.org/all/20210827165540.30567055@canb.auug.org.au/

The following changes since commit c500bee1c5b2f1d59b1081ac879d73268ab0ff17:

  Linux 5.14-rc4 (2021-08-01 17:04:17 -0700)

are available in the Git repository at:

  git://github.com/awilliam/linux-vfio.git tags/vfio-v5.15-rc1

for you to fetch changes up to ea870730d83fc13a5fa2bd0e175176d7ac8a400a:

  Merge branches 'v5.15/vfio/spdx-license-cleanups', 'v5.15/vfio/dma-valid-waited-v3', 'v5.15/vfio/vfio-pci-core-v5' and 'v5.15/vfio/vfio-ap' into v5.15/vfio/next (2021-08-26 11:08:50 -0600)

----------------------------------------------------------------
VFIO update for v5.15-rc1

 - Fix dma-valid return WAITED implementation (Anthony Yznaga)

 - SPDX license cleanups (Cai Huoqing)

 - Split vfio-pci-core from vfio-pci and enhance PCI driver matching
   to support future vendor provided vfio-pci variants (Yishai Hadas,
   Max Gurtovoy, Jason Gunthorpe)

 - Replace duplicated reflck with core support for managing first
   open, last close, and device sets (Jason Gunthorpe, Max Gurtovoy,
   Yishai Hadas)

 - Fix non-modular mdev support and don't nag about request callback
   support (Christoph Hellwig)

 - Add semaphore to protect instruction intercept handler and replace
   open-coded locks in vfio-ap driver (Tony Krowiak)

 - Convert vfio-ap to vfio_register_group_dev() API (Jason Gunthorpe)

----------------------------------------------------------------
Alex Williamson (1):
      Merge branches 'v5.15/vfio/spdx-license-cleanups', 'v5.15/vfio/dma-valid-waited-v3', 'v5.15/vfio/vfio-pci-core-v5' and 'v5.15/vfio/vfio-ap' into v5.15/vfio/next

Anthony Yznaga (1):
      vfio/type1: Fix vfio_find_dma_valid return

Cai Huoqing (2):
      vfio: platform: reset: Convert to SPDX identifier
      vfio-pci/zdev: Remove repeated verbose license text

Christoph Hellwig (2):
      vfio/mdev: turn mdev_init into a subsys_initcall
      vfio/mdev: don't warn if ->request is not set

Jason Gunthorpe (16):
      vfio: Use config not menuconfig for VFIO_NOIOMMU
      vfio/samples: Remove module get/put
      vfio/mbochs: Fix missing error unwind of mbochs_used_mbytes
      vfio: Provide better generic support for open/release vfio_device_ops
      vfio/samples: Delete useless open/close
      vfio/fsl: Move to the device set infrastructure
      vfio/platform: Use open_device() instead of open coding a refcnt scheme
      vfio/pci: Change vfio_pci_try_bus_reset() to use the dev_set
      vfio/pci: Reorganize VFIO_DEVICE_PCI_HOT_RESET to use the device set
      vfio/mbochs: Fix close when multiple device FDs are open
      vfio/ap,ccw: Fix open/close when multiple device FDs are open
      vfio/gvt: Fix open/close when multiple device FDs are open
      vfio: Remove struct vfio_device_ops open/release
      vfio/ap_ops: Convert to use vfio_register_group_dev()
      vfio: Use select for eventfd
      vfio: Use kconfig if XX/endif blocks instead of repeating 'depends on'

Max Gurtovoy (11):
      vfio: Introduce a vfio_uninit_group_dev() API call
      vfio/pci: Rename vfio_pci.c to vfio_pci_core.c
      vfio/pci: Rename vfio_pci_private.h to vfio_pci_core.h
      vfio/pci: Rename vfio_pci_device to vfio_pci_core_device
      vfio/pci: Rename ops functions to fit core namings
      vfio/pci: Include vfio header in vfio_pci_core.h
      vfio/pci: Split the pci_driver code out of vfio_pci_core.c
      vfio/pci: Move igd initialization to vfio_pci.c
      PCI: Add 'override_only' field to struct pci_device_id
      PCI / VFIO: Add 'override_only' support for VFIO PCI sub system
      vfio/pci: Introduce vfio_pci_core.ko

Tony Krowiak (2):
      s390/vfio-ap: r/w lock for PQAP interception handler function pointer
      s390/vfio-ap: replace open coded locks for VFIO_GROUP_NOTIFY_SET_KVM notification

Yishai Hadas (3):
      vfio/pci: Make vfio_pci_regops->rw() return ssize_t
      vfio/pci: Move to the device set infrastructure
      vfio/pci: Move module parameters to vfio_pci.c

 Documentation/PCI/pci.rst                          |    1 +
 Documentation/driver-api/vfio.rst                  |    4 +-
 MAINTAINERS                                        |    1 +
 arch/s390/include/asm/kvm_host.h                   |    8 +-
 arch/s390/kvm/kvm-s390.c                           |   32 +-
 arch/s390/kvm/priv.c                               |   15 +-
 drivers/gpu/drm/i915/gvt/kvmgt.c                   |    8 +-
 drivers/pci/pci-driver.c                           |   28 +-
 drivers/s390/cio/vfio_ccw_ops.c                    |    8 +-
 drivers/s390/crypto/vfio_ap_ops.c                  |  282 ++-
 drivers/s390/crypto/vfio_ap_private.h              |    6 +-
 drivers/vfio/Kconfig                               |   31 +-
 drivers/vfio/fsl-mc/Kconfig                        |    3 +-
 drivers/vfio/fsl-mc/vfio_fsl_mc.c                  |  159 +-
 drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c             |    6 +-
 drivers/vfio/fsl-mc/vfio_fsl_mc_private.h          |    7 -
 drivers/vfio/mdev/Kconfig                          |    1 -
 drivers/vfio/mdev/mdev_core.c                      |    6 +-
 drivers/vfio/mdev/vfio_mdev.c                      |   33 +-
 drivers/vfio/pci/Kconfig                           |   40 +-
 drivers/vfio/pci/Makefile                          |    8 +-
 drivers/vfio/pci/vfio_pci.c                        | 2397 +-------------------
 drivers/vfio/pci/vfio_pci_config.c                 |   70 +-
 drivers/vfio/pci/vfio_pci_core.c                   | 2158 ++++++++++++++++++
 drivers/vfio/pci/vfio_pci_igd.c                    |   23 +-
 drivers/vfio/pci/vfio_pci_intrs.c                  |   42 +-
 drivers/vfio/pci/vfio_pci_rdwr.c                   |   18 +-
 drivers/vfio/pci/vfio_pci_zdev.c                   |   11 +-
 drivers/vfio/platform/Kconfig                      |    6 +-
 drivers/vfio/platform/reset/Kconfig                |    4 +-
 .../vfio/platform/reset/vfio_platform_bcmflexrm.c  |   10 +-
 drivers/vfio/platform/vfio_platform_common.c       |   86 +-
 drivers/vfio/platform/vfio_platform_private.h      |    1 -
 drivers/vfio/vfio.c                                |  144 +-
 drivers/vfio/vfio_iommu_type1.c                    |    8 +-
 include/linux/mdev.h                               |    9 +-
 include/linux/mod_devicetable.h                    |    6 +
 include/linux/pci.h                                |   29 +
 include/linux/vfio.h                               |   26 +-
 .../linux/vfio_pci_core.h                          |   96 +-
 samples/vfio-mdev/mbochs.c                         |   40 +-
 samples/vfio-mdev/mdpy.c                           |   40 +-
 samples/vfio-mdev/mtty.c                           |   40 +-
 scripts/mod/devicetable-offsets.c                  |    1 +
 scripts/mod/file2alias.c                           |   17 +-
 45 files changed, 3005 insertions(+), 2964 deletions(-)
 create mode 100644 drivers/vfio/pci/vfio_pci_core.c
 rename drivers/vfio/pci/vfio_pci_private.h => include/linux/vfio_pci_core.h (56%)

