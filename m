Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59907431406
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 12:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhJRKFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 06:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhJRKFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:05:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5719660F57;
        Mon, 18 Oct 2021 10:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634551375;
        bh=y0mro2FgkRIxQ83VpxLayD94+80WbOviBdvzfdUkVj8=;
        h=Date:From:To:Cc:Subject:From;
        b=ZME0cI/vqwyuz5uaKrraPgGjlC5287lj33t4JZcsbhud3VoktK545wTFu+516HWDz
         3z+hXYu/mkJ75PscG2Zuy+jQinjMd2qx/aAeXFRrnIEkjssLa4s5eSqyGIkoJNP3bh
         BRnntKw+3JTJGrQ2Ewc+hMOSxzggdMvNDvwC06cGNradeSRK9g5gMOTz5RwRIE6fzz
         90TYZfhTulMrAqT/FHNceZA9/qdv252z32kxsMlUg1HsQ5Cif78bq/1Bo8mjzPG6Xm
         Iru8vFQmvUMiQthu4LTeL5gWfIem4hjxKCDeVPbEiYokmvDlUEYstOt8814lIKi4xz
         XgnIlJXuMMRuA==
Date:   Mon, 18 Oct 2021 13:02:50 +0300
From:   Oded Gabbay <ogabbay@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, jgg@ziepe.ca, daniel.vetter@ffwll.ch,
        ogabbay@habana.ai, airlied@gmail.com
Subject: [git pull] habanalabs pull request for kernel 5.16
Message-ID: <20211018100250.GA1132625@ogabbay-vm-u20.habana-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This is habanalabs pull request for the merge window of kernel 5.16.
It's a relatively small pull request as Gaudi code is mostly mature.
Please note this contains the peer-to-peer support with DMA-BUF code.

Full details are in the tag.

Thanks,
Oded

The following changes since commit 22d4f9beaf32a7cda9edeafdf5e99bec3de32c51:

  Merge 5.15-rc6 into char-misc-next (2021-10-18 09:29:27 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-next-2021-10-18

for you to fetch changes up to b2faac3887df87a6e4bc3356280ea35dc7459c0b:

  habanalabs: refactor fence handling in hl_cs_poll_fences (2021-10-18 12:05:48 +0300)

----------------------------------------------------------------
This tag contains habanalabs driver changes for v5.16:

- Add a new uAPI (under the memory ioctl) to request from the driver
  to export a DMA-BUF object that represents a memory region on
  the device's DRAM. This is needed to enable peer-to-peer over PCIe
  between habana device and an RDMA adapter (e.g. mlnx5 or efa
  rdma adapter).

- Add debugfs node to dynamically configure CS timeout. Up until now,
  it was only configurable through kernel module parameter.

- Fetch more comprehensive power information from the firmware.

- Always take timestamp when waiting for user interrupt, as the user
  needs that information to optimize the graph runtime compilation.

- Modify user interrupt to look on 64-bit user value as fence, instead
  of 32-bit.

- Bypass reset in case of repeated h/w error event after device reset.
  This is to prevent endless loop of resets to the device.

- Fix several bugs in multi CS completion code.

- Fix race condition in fd close/open.

- Update to latest firmware headers

- Add select CRC32 in kconfig

- Small fixes, cosmetics

----------------------------------------------------------------
Alon Mizrahi (1):
      habanalabs: generalize COMMS message sending procedure

Bharat Jauhari (1):
      habanalabs: bypass reset for continuous h/w error event

Dani Liberman (3):
      habanalabs: fix race condition in multi CS completion
      habanalabs: fix NULL pointer dereference
      habanalabs: refactor fence handling in hl_cs_poll_fences

Moti Haimovski (1):
      habanalabs: initialize hpriv fields before adding new node

Oded Gabbay (7):
      habanalabs: add kernel-doc style comments
      habanalabs: define soft-reset as inference op
      habanalabs: refactor reset log message
      habanalabs: prevent race between fd close/open
      habanalabs: update firmware files
      habanalabs: use only u32
      habanalabs: define uAPI to export FD for DMA-BUF

Ofir Bitton (3):
      habanalabs: add debugfs node for configuring CS timeout
      habanalabs: remove redundant cs validity checks
      habanalabs: add support for a long interrupt target value

Omer Shpigelman (1):
      habanalabs: context cleanup cosmetics

Rajaravi Krishna Katta (3):
      habanalabs: create static map of f/w hwmon enums
      habanalabs: enable power info via HWMON framework
      habanalabs: Unify frequency set/get functionality

Tomer Tayar (1):
      habanalabs: add support for dma-buf exporter

Vegard Nossum (1):
      habanalabs: select CRC32

Yuri Nudelman (3):
      habanalabs: fix debugfs device memory MMU VA translation
      habanalabs: take timestamp on wait for interrupt
      habanalabs: simplify wait for interrupt with timestamp flow

 .../ABI/testing/debugfs-driver-habanalabs          |   6 +
 drivers/misc/habanalabs/Kconfig                    |   2 +
 drivers/misc/habanalabs/common/Makefile            |   2 +-
 .../misc/habanalabs/common/command_submission.c    | 105 +++--
 drivers/misc/habanalabs/common/context.c           |   8 +-
 drivers/misc/habanalabs/common/debugfs.c           |  51 ++
 drivers/misc/habanalabs/common/device.c            | 159 +++++--
 drivers/misc/habanalabs/common/firmware_if.c       |  28 +-
 drivers/misc/habanalabs/common/habanalabs.h        |  64 ++-
 drivers/misc/habanalabs/common/habanalabs_drv.c    |  24 +-
 .../{gaudi/gaudi_hwmgr.c => common/hwmgr.c}        |  38 +-
 drivers/misc/habanalabs/common/hwmon.c             | 194 +++++++-
 drivers/misc/habanalabs/common/irq.c               |   5 +-
 drivers/misc/habanalabs/common/memory.c            | 513 ++++++++++++++++++++-
 drivers/misc/habanalabs/common/mmu/mmu.c           |  30 +-
 drivers/misc/habanalabs/common/sysfs.c             |   6 +-
 drivers/misc/habanalabs/gaudi/Makefile             |   2 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              |  22 +-
 drivers/misc/habanalabs/gaudi/gaudiP.h             |   4 -
 drivers/misc/habanalabs/goya/goya.c                |  13 +-
 drivers/misc/habanalabs/goya/goyaP.h               |   1 -
 drivers/misc/habanalabs/goya/goya_hwmgr.c          |  31 --
 drivers/misc/habanalabs/include/common/cpucp_if.h  |  22 +-
 .../misc/habanalabs/include/common/hl_boot_if.h    | 189 +++++---
 .../misc/habanalabs/include/gaudi/gaudi_fw_if.h    |  10 +-
 .../misc/habanalabs/include/gaudi/gaudi_reg_map.h  |   1 +
 include/uapi/misc/habanalabs.h                     |  84 +++-
 27 files changed, 1309 insertions(+), 305 deletions(-)
 rename drivers/misc/habanalabs/{gaudi/gaudi_hwmgr.c => common/hwmgr.c} (61%)
