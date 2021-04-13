Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF46F35D610
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 05:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344433AbhDMDjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 23:39:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17319 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhDMDjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 23:39:32 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FKB9f4xkRzB01y;
        Tue, 13 Apr 2021 11:36:54 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Tue, 13 Apr 2021
 11:39:01 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <alex.williamson@redhat.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, <liulongfang@huawei.com>
Subject: [RFC PATCH 0/3] vfio/hisilicon: add acc live migration driver
Date:   Tue, 13 Apr 2021 11:36:20 +0800
Message-ID: <1618284983-55581-1-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The live migration solution relies on the vfio_device_migration_info protocol.
The structure vfio_device_migration_info is placed at the 0th offset of
the VFIO_REGION_SUBTYPE_MIGRATION region to get and set VFIO device related
migration information. Field accesses from this structure are only supported
at their native width and alignment. Otherwise, the result is undefined and
vendor drivers should return an error.

(1).The driver framework is based on vfio_pci_register_dev_region() of vfio-pci,
and then a new live migration region is added, and the live migration is
realized through the ops of this region.

(2).In order to ensure the compatibility of the devices before and after the
migration, the device compatibility information check will be performed in
the Pre-copy stage. If the check fails, an error will be returned and the
source VM will exit the migration function.

(3).After the compatibility check is passed, it will enter the Stop-and-copy
stage. At this time, all the live migration data will be copied, and then
saved to the VF device of the destination, and then the VF device of the
destination will be started and the VM of the source will be exited.

Longfang Liu (3):
  vfio/hisilicon: add acc live migration driver
  vfio/hisilicon: register the driver to vfio
  vfio/hisilicom: add debugfs for driver

 drivers/vfio/pci/Kconfig                      |    8 +
 drivers/vfio/pci/Makefile                     |    1 +
 drivers/vfio/pci/hisilicon/acc_vf_migration.c | 1337 +++++++++++++++++++++++++
 drivers/vfio/pci/hisilicon/acc_vf_migration.h |  170 ++++
 drivers/vfio/pci/vfio_pci.c                   |   11 +
 drivers/vfio/pci/vfio_pci_private.h           |    9 +
 6 files changed, 1536 insertions(+)
 create mode 100644 drivers/vfio/pci/hisilicon/acc_vf_migration.c
 create mode 100644 drivers/vfio/pci/hisilicon/acc_vf_migration.h

-- 
2.8.1

