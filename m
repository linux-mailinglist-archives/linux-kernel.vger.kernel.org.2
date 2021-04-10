Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D98D35B043
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 22:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbhDJUCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 16:02:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234439AbhDJUCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 16:02:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B40C610A7;
        Sat, 10 Apr 2021 20:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618084907;
        bh=QIsgkPx0zC6WnVNpaFrrqpLcZJ+yIUv2rlH5fE2vQxU=;
        h=Date:From:To:Cc:Subject:From;
        b=bB/eI2KSAcyBefCFmhUKy1BOpyA28uYJ5adJ9teHYb2PvhAoNjHiQZfNipBqnPvW5
         yjUfsAgxfLLgWm0TUVf9w76qESSyYn1hzhQtPL2AOtg4mjPBsxH6rMqribesj+mg83
         79bqcI6bYTPeqdhiitMfu/yXMK93091hPsozIF2dt3Uf+WO764HiJ2owRuz6Ajx32c
         YayAVY52RI+pfOMOy53FUEhlGOcRkajz8G/Ljr5EQV9/ySPgO8dgjTTthuYpBbfJlR
         kSCWM5Pbsfbigl75JfZ+BqdviFrOfBOQYRvNNAFHOY8uuMf4VWMpO1PNgMPDVJCW7z
         Mv+RUL2JYOXpA==
Date:   Sat, 10 Apr 2021 23:01:42 +0300
From:   Oded Gabbay <ogabbay@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs pull request for kernel 5.13
Message-ID: <20210410200142.GA336@CORE.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This is habanalabs pull request for the merge window of kernel 5.13.
It contains changes and new features, support for new firmware.
Details are in the tag.

Thanks,
Oded

The following changes since commit b195b20b7145bcae22ad261abc52d68336f5e913:

  Merge tag 'extcon-next-for-5.13' of git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon into char-misc-next (2021-04-08 08:45:30 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-next-2021-04-10

for you to fetch changes up to b575a7673e3d0396992fc72fce850723d39264e3:

  habanalabs: print f/w boot unknown error (2021-04-09 14:10:32 +0300)

----------------------------------------------------------------
This tag contains habanalabs driver changes for v5.13:

- Add support to reset device after the user closes the file descriptor.
  Because we support a single user, we can reset the device (if needs to)
  after a user closes its file descriptor to make sure the device is in
  idle and clean state for the next user.

- Add a new feature to allow the user to wait on interrupt. This is needed
  for future ASICs

- Replace GFP_ATOMIC with GFP_KERNEL wherever possible and add code to
  support failure of allocating with GFP_ATOMIC.

- Update code to support the latest firmware image:
  - More security features are done in the firmware
  - Remove hard-coded assumptions and replace them with values that are
    sent to the firmware on loading.
  - Print device unusable error
  - Reset device in case the communication between driver and firmware
    gets out of sync.
  - Support new PCI device ids for secured GAUDI.

- Expose current power draw through the INFO IOCTL.

- Support resetting the device upon a request from the BMC (through F/W).

- Always use only a single MSI in GAUDI, due to H/W limitation.

- Improve data-path code by taking out code from spinlock protection.

- Allow user to specify custom timeout per Command Submission.

- Some enhancements to debugfs.

- Various minor changes and improvements.

----------------------------------------------------------------
Alon Mizrahi (1):
      habanalabs: add custom timeout flag per cs

Bharat Jauhari (1):
      habanalabs: move dram scrub to free sequence

Koby Elbaz (2):
      habanalabs: improve utilization calculation
      habanalabs: support DEVICE_UNUSABLE error indication from FW

Oded Gabbay (11):
      habanalabs: reset after device is actually released
      habanalabs: fail reset if device is not idle
      habanalabs: reset_upon_device_release is for bring-up
      habanalabs: print if device is used on FD close
      habanalabs: change default CS timeout to 30 seconds
      habanalabs: use correct define for 32-bit max value
      habanalabs/gaudi: always use single-msi mode
      habanalabs/gaudi: add debugfs to DMA from the device
      habanalabs: remove the store jobs array from CS IOCTL
      habanalabs: use strscpy instead of sprintf and strlcpy
      habanalabs: print f/w boot unknown error

Ofir Bitton (13):
      habanalabs: add reset support when user closes FD
      habanalabs: enable all IRQs for user interrupt support
      habanalabs: wait for interrupt support
      habanalabs: use a single FW loading bringup flag
      habanalabs/gaudi: update extended async event header
      habanalabs: replace GFP_ATOMIC with GFP_KERNEL
      habanalabs: debugfs access to user mapped host addresses
      habanalabs/gaudi: reset device upon BMC request
      habanalabs/gaudi: unsecure TPC cfg status registers
      habanalabs/gaudi: Update async events header
      habanalabs: move relevant datapath work outside cs lock
      habanalabs/gaudi: derive security status from pci id
      habanalabs/gaudi: skip iATU if F/W security is enabled

Ohad Sharabi (6):
      habanalabs: reset device in case of sync error
      habanalabs: skip DISABLE PCI packet to FW on heartbeat
      habanalabs: update hl_boot_if.h
      habanalabs: support legacy and new pll indexes
      habanalabs: send dynamic msi-x indexes to f/w
      habanalabs: update to latest F/W communication header

Sagiv Ozeri (2):
      habanalabs: support HW blocks vm show
      habanalabs: return current power via INFO IOCTL

Tomer Tayar (1):
      habanalabs/gaudi: clear QM errors only if not in stop_on_err mode

Yang Li (1):
      habanalabs: Switch to using the new API kobj_to_dev()

farah kassabri (3):
      habanalabs: set max asid to 2
      habanalabs: avoid soft lockup bug upon mapping error
      habanalabs/gaudi: sync stream add protection to SOB reset flow

 .../ABI/testing/debugfs-driver-habanalabs          |  70 +++-
 drivers/misc/habanalabs/common/command_buffer.c    |  12 +-
 .../misc/habanalabs/common/command_submission.c    | 368 +++++++++++++++++----
 drivers/misc/habanalabs/common/context.c           |  14 +-
 drivers/misc/habanalabs/common/debugfs.c           | 224 +++++++++++--
 drivers/misc/habanalabs/common/device.c            | 221 ++++++-------
 drivers/misc/habanalabs/common/firmware_if.c       | 238 +++++++++++--
 drivers/misc/habanalabs/common/habanalabs.h        | 184 ++++++++---
 drivers/misc/habanalabs/common/habanalabs_drv.c    |  28 +-
 drivers/misc/habanalabs/common/habanalabs_ioctl.c  |  35 +-
 drivers/misc/habanalabs/common/hw_queue.c          |  10 +-
 drivers/misc/habanalabs/common/irq.c               |  56 ++++
 drivers/misc/habanalabs/common/memory.c            | 182 +++++++---
 drivers/misc/habanalabs/common/mmu/mmu.c           |   3 +
 drivers/misc/habanalabs/common/pci/pci.c           |  52 +++
 drivers/misc/habanalabs/common/sysfs.c             |  33 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              | 357 +++++++++++++++++---
 drivers/misc/habanalabs/gaudi/gaudiP.h             |   3 +
 drivers/misc/habanalabs/gaudi/gaudi_security.c     |   8 -
 drivers/misc/habanalabs/goya/goya.c                | 140 +++++++-
 drivers/misc/habanalabs/goya/goyaP.h               |   2 +
 drivers/misc/habanalabs/include/common/cpucp_if.h  |  99 +++++-
 .../misc/habanalabs/include/common/hl_boot_if.h    | 219 ++++++++++++
 drivers/misc/habanalabs/include/gaudi/gaudi.h      |   2 +-
 .../habanalabs/include/gaudi/gaudi_async_events.h  |   2 +
 .../include/gaudi/gaudi_async_ids_map_extended.h   |  43 ++-
 .../misc/habanalabs/include/gaudi/gaudi_fw_if.h    |  14 -
 drivers/misc/habanalabs/include/goya/goya.h        |   2 +-
 .../habanalabs/include/goya/goya_async_events.h    |   1 +
 drivers/misc/habanalabs/include/goya/goya_fw_if.h  |  11 -
 include/uapi/misc/habanalabs.h                     |  77 +++--
 31 files changed, 2193 insertions(+), 517 deletions(-)
