Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7E2306405
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 20:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhA0TaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 14:30:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:37260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231152AbhA0TaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 14:30:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14A9164DBF;
        Wed, 27 Jan 2021 19:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611775766;
        bh=xsxX58NrvmcqViN89mfBIs4R6Js93M6tq4ucGnzpExM=;
        h=Date:From:To:Cc:Subject:From;
        b=ZBZoKTKKv9AqZsYQPnPXz2UR8xtyXINQVr6gEJK1ABC0hdakVfemr19VhNgmsqPQt
         PAwK7O0tbB/HwhD8Ef/5BnXDtvf5j1GaZWPrydUrfNc6BrlT8xc3DvbiWYoazxILoc
         fV0b9kZCqUxkgRyBxjtDpDmWIvCJjF8tT3tijqSQ/ywtpJ0a+aO99Alad9v3QE6y/Q
         FQWSWUsq2X0SsXmOxWy/kGl+LrdCgvqcxHYNgV3GPXL/0/LJ0RwwmdR2QQmBbZ1RPp
         /iaGv/kfq2sAhVfusudR1wW0cpv1BNnZWnLi19filukvHoE5PyqwIg50+GLs9lsarj
         Zrx5mk1iGeT0w==
Date:   Wed, 27 Jan 2021 21:29:22 +0200
From:   Oded Gabbay <ogabbay@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs pull request for kernel 5.12
Message-ID: <20210127192922.GA7803@CORE.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This is habanalabs pull request for the merge window of kernel 5.12.
It contains changes and new features, support for new firmware.
Details are in the tag.

Thanks,
Oded

The following changes since commit 0fc99422bc034de018607ef6b70f92d4bc4a236d:

  firmware: xilinx: Remove PM_API_MAX value (2021-01-26 19:38:54 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-next-2021-01-27

for you to fetch changes up to f1aebf5e3d606a2a910eed54bc8d17655f12b606:

  habanalabs: update to latest hl_boot_if.h spec from F/W (2021-01-27 21:03:51 +0200)

----------------------------------------------------------------
This tag contains habanalabs driver changes for v5.12:

- Add feature called "staged command submissions". In this feature,
  the driver allows the user to submit multiple command submissions
  that describe a single pass on the deep learning graph. The driver
  tracks the completion of the entire pass by the last stage CS.

- Update code to support the latest firmware image

- Optimizations and improvements to MMU code:
  - Support page size that is not power-of-2
  - Make the locks scheme simpler
  - mmap areas in device configuration space to userspace

- Security fixes:
  - Make ETR non-secured
  - Remove access to kernel memory through debug-fs interface
  - Remove access through PCI bar to SyncManager register block
    in Gaudi

- Many small bug fixes

----------------------------------------------------------------
Alon Mizrahi (2):
      habanalabs: replace WARN/WARN_ON with dev_crit in driver
      habanalabs: return dram virtual address in info ioctl

Christophe JAILLET (1):
      habanalabs: Use 'dma_set_mask_and_coherent()'

Moti Haimovski (2):
      habanalabs: report dram_page_size in hw_ip_info ioctl
      habanalabs: support non power-of-2 DRAM phys page sizes

Oded Gabbay (8):
      habanalabs: update firmware boot interface
      habanalabs: add ASIC property of functional HBMs
      habanalabs: update to latest hl_boot_if.h
      habanalabs: update email address in sysfs/debugfs docs
      CREDITS: update email address and home address
      habanalabs: update SyncManager interrupt handling
      habanalabs/gaudi: unmask HBM interrupts after handling
      habanalabs: update to latest hl_boot_if.h spec from F/W

Ofir Bitton (20):
      habanalabs: Init the VM module for kernel context
      habanalabs/gaudi: support CS with no completion
      habanalabs: allow user to pass a staged submission seq
      habanalabs/gaudi: remove duplicated gaudi packets masks
      habanalabs/gaudi: add debug prints for security status
      habanalabs/gaudi: set uninitialized symbol
      habanalabs: remove access to kernel memory using debugfs
      habanalabs: report correct dram size in info ioctl
      habanalabs: read device boot errors after cpucp is up
      habanalabs: separate common code to dedicated folders
      habanalabs: increment ctx ref from within a cs allocation
      habanalabs: add driver support for internal cb scheduling
      habanalabs/gaudi: remove PCI access to SM block
      habanalabs/gaudi: print sync manager SEI interrupt info
      habanalabs: ignore F/W BMC errors in case no BMC present
      habanalabs: add security violations dump to debugfs
      habanalabs: add user available interrupt to hw_ip
      habanalabs: add new mem ioctl op for mapping hw blocks
      habanalabs: add CS completion and timeout properties
      habanalabs: staged submission support

Ohad Sharabi (4):
      habanalabs: refactor MMU locks code
      habanalabs/goya: move mmu_prepare to context init
      habanalabs: modify device_idle interface
      habanalabs: fix ETR security issue

Omer Shpigelman (2):
      habanalabs: kernel doc format in memory functions
      habanalabs: modify memory functions signatures

farah kassabri (2):
      habanalabs: always try to use the hint address
      habanalabs: fix MMU debugfs related nodes

 CREDITS                                            |   8 +-
 .../ABI/testing/debugfs-driver-habanalabs          |  50 +-
 Documentation/ABI/testing/sysfs-driver-habanalabs  |  58 +-
 drivers/misc/habanalabs/common/Makefile            |  10 +-
 drivers/misc/habanalabs/common/asid.c              |   6 +-
 drivers/misc/habanalabs/common/command_buffer.c    |   8 +-
 .../misc/habanalabs/common/command_submission.c    | 473 ++++++++++++++--
 drivers/misc/habanalabs/common/context.c           |  33 +-
 drivers/misc/habanalabs/common/debugfs.c           |  43 +-
 drivers/misc/habanalabs/common/device.c            |  23 +-
 drivers/misc/habanalabs/common/firmware_if.c       | 143 +++--
 drivers/misc/habanalabs/common/habanalabs.h        | 100 +++-
 drivers/misc/habanalabs/common/habanalabs_ioctl.c  |  22 +-
 drivers/misc/habanalabs/common/hw_queue.c          |  51 +-
 drivers/misc/habanalabs/common/memory.c            | 614 +++++++++++++--------
 drivers/misc/habanalabs/common/mmu/Makefile        |   2 +
 drivers/misc/habanalabs/common/{ => mmu}/mmu.c     | 124 ++++-
 drivers/misc/habanalabs/common/{ => mmu}/mmu_v1.c  |   4 +-
 drivers/misc/habanalabs/common/pci/Makefile        |   2 +
 drivers/misc/habanalabs/common/{ => pci}/pci.c     |  47 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              | 436 +++++++++++----
 drivers/misc/habanalabs/gaudi/gaudiP.h             |   3 +
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c    |  18 +-
 drivers/misc/habanalabs/gaudi/gaudi_security.c     |   5 +
 drivers/misc/habanalabs/goya/goya.c                |  83 ++-
 drivers/misc/habanalabs/goya/goyaP.h               |   1 +
 drivers/misc/habanalabs/goya/goya_coresight.c      |  11 +-
 drivers/misc/habanalabs/goya/goya_security.c       |   5 +
 drivers/misc/habanalabs/include/common/cpucp_if.h  |  14 +
 .../misc/habanalabs/include/common/hl_boot_if.h    |  14 +
 .../habanalabs/include/gaudi/gaudi_async_events.h  |   4 +
 .../misc/habanalabs/include/gaudi/gaudi_masks.h    |   5 +-
 .../misc/habanalabs/include/gaudi/gaudi_packets.h  |  27 +-
 .../habanalabs/include/goya/asic_reg/goya_masks.h  |   5 +-
 include/uapi/misc/habanalabs.h                     |  56 +-
 35 files changed, 1824 insertions(+), 684 deletions(-)
 create mode 100644 drivers/misc/habanalabs/common/mmu/Makefile
 rename drivers/misc/habanalabs/common/{ => mmu}/mmu.c (77%)
 rename drivers/misc/habanalabs/common/{ => mmu}/mmu_v1.c (99%)
 create mode 100644 drivers/misc/habanalabs/common/pci/Makefile
 rename drivers/misc/habanalabs/common/{ => pci}/pci.c (91%)
