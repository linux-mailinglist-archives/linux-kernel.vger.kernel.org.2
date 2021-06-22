Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1703B006A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 11:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhFVJir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 05:38:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhFVJiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 05:38:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 665F561353;
        Tue, 22 Jun 2021 09:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624354591;
        bh=Z4l/GS7hvjNNjhOF6XI9MfhUs7GP86J5MN8QrYJq7CE=;
        h=Date:From:To:Cc:Subject:From;
        b=eKtYxDW3I6w82NgT5nVO3ouo/damrVv4OFyoHVs/MjrUQsxtv6KgDs44ngV67eBsz
         qXRA8e8qWBU6sKs5Y79PbcuuH0mjjP22VpFQ9M1oMJ4IcfJgcdOqldw0P9z+pU9M0q
         b8h4z5MpXuvs+pqVCOkEiFbKsfTXsgbdSEPqO4iKnul8AjW5IPJ7Xy0uE7kKZ5iR70
         Wq7TRuF5R+NCSXY2UG5RD4S7kQ0W5X8aTh51Z+Waj1a8X6NKNa2p5SduAvQlIRPnyV
         fNoxGAs8Qk2OEkulovQrMHaV3PeFtpX05q90YkU6nEZe2DOd8JzOzv157c3yM5zfW0
         k0lsdRIATn3EA==
Date:   Tue, 22 Jun 2021 12:36:27 +0300
From:   Oded Gabbay <ogabbay@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs pull request for kernel 5.14
Message-ID: <20210622093627.GA4857@CORE.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This is habanalabs pull request for the merge window of kernel 5.14.
The bulk of the commits relate to improvements of the communication
between the driver and the firmware that is running inside the ASIC.

There are also many small changes, new debug features, improvements, etc.
Details are in the tag.

Thanks,
Oded

The following changes since commit 91812dd0937cc6457e85f7733813c701ee971da5:

  bus: fsl-mc: mc-io: Correct misdocumentation of 'dpmcp_dev' param (2021-06-17 13:44:33 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-next-2021-06-22

for you to fetch changes up to b7a71fddc0ddfdd66cdefcf5bf1f59a0f0bdea57:

  habanalabs/gaudi: refactor hard-reset related code (2021-06-21 10:21:51 +0300)

----------------------------------------------------------------
This tag contains habanalabs driver changes for v5.14:

- Change communication protocol with f/w. The new protocl allows better
  backward compatibility between different f/w versions and is more
  stable.
- Send hard-reset cause to f/w after a hard-reset has happened.
- Move to indirection when generating interrupts to f/w.
- Better progress and error messages during the f/w load stage.
- Recognize that f/w is with enabled security according to device ID.
- Add validity check to event queue mechanism.
- Add new event from f/w that will indicate a daemon has been terminated
  inside the f/w.

- Move to TLB cache range invalidation in the device's MMU.
- Disable memory scrubbing by default for performance.

- Many fixes for sparse/smatch reported errors.
- Enable by default stop-on-err in the ASIC.
- Move to ASYNC device probing to speedup loading of driver in server
  with multiple devices.
- Fix to stop using disabled NIC ports when doing collective operation.
- Use standard error codes instead of positive values.
- Add support for resetting device after user has finished using it.
- Add debugfs option to avoid reset when a CS has got stuck.
- Add print of the last 8 CS pointers in case of error in QMANs.
- Add statistics on opening of the FD of a device.

----------------------------------------------------------------
Alon Mizrahi (1):
      habanalabs: use mmu cache range invalidation

Bharat Jauhari (1):
      habanalabs: enable dram scramble before linux f/w

Christophe JAILLET (1):
      habanalabs: Fix an error handling path in 'hl_pci_probe()'

Guy Nisan (1):
      habanalabs: modify progress status messages

Koby Elbaz (15):
      habanalabs/gaudi: use scratchpad regs instead of GIC controller
      habanalabs/gaudi: send hard reset cause to preboot
      habanalabs/gaudi: read GIC sts after FW is loaded
      habanalabs: read preboot status bits in an earlier stage
      habanalabs/gaudi: disable GIC usage if security is enabled
      habanalabs/gaudi: use COMMS to reset device / halt CPU
      habanalabs/gaudi: set the correct cpu_id on MME2_QM failure
      habanalabs: small code refactoring
      habanalabs: zero complex structures using memset
      habanalabs: set rc as 'valid' in case of intentional func exit
      habanalabs: remove node from list before freeing the node
      habanalabs/gaudi: set the correct rc in case of err
      habanalabs/goya: add '__force' attribute to suppress false alarm
      habanalabs: get lower/upper 32 bits via masking
      habanalabs/gaudi: refactor hard-reset related code

Moti Haimovski (1):
      habanalabs: increase ELBI reset timeout for PLDM

Oded Gabbay (15):
      habanalabs: update firmware files to latest
      habanalabs: update to latest f/w headers
      habanalabs: use dev_dbg upon hint address failure
      habanalabs: ignore device unusable status
      habanalabs: better error print for pin failure
      habanalabs: notify before f/w loading
      habanalabs: set memory scrubbing to disabled by default
      habanalabs: check running index in eqe control
      habanalabs/gaudi: refactor reset code
      habanalabs/gaudi: don't use nic_ports_mask in compute
      habanalabs: prefer ASYNC device probing
      habanalabs/gaudi: update to latest f/w specs
      habanalabs/gaudi: use standard error codes
      habanalabs: print firmware versions
      habanalabs: remove a rogue #ifdef

Ofir Bitton (10):
      habanalabs: give FW a grace time for configuring iATU
      habanalabs/gaudi: do not move HBM bar if iATU done by FW
      habanalabs/gaudi: split host irq interfaces towards FW
      habanalabs/gaudi: don't use disabled ports in collective wait
      habanalabs/gaudi: add FW alive event support
      habanalabs: reset device upon FD close if not idle
      habanalabs: enable stop on error for all QMANs and engines
      habanalabs/gaudi: correct driver events numbering
      habanalabs: allow reset upon device release
      habanalabs/gaudi: add support for NIC DERR

Ohad Sharabi (17):
      habanalabs: prepare preboot stage to dynamic f/w load
      habanalabs: request f/w in separate function
      habanalabs: refactor init device cpu code
      habanalabs: use common fw_version read
      habanalabs: dynamic fw load reset protocol
      habanalabs: expose ASIC specific PCI info to common code
      habanalabs: load boot fit to device
      habanalabs: load linux image to device
      habanalabs: set dma mask from fw once fw done iatu config
      habanalabs: avoid using uninitialized pointer
      habanalabs: read f/w's 2-nd sts and err registers
      habanalabs: check if asic secured with asic type
      habanalabs: track security status using positive logic
      habanalabs: skip valid test for boot_dev_sts regs
      habanalabs: fix mask to obtain page offset
      habanalabs: report EQ fault during heartbeat
      habanalabs/gaudi: print last QM PQEs on error

Omer Shpigelman (2):
      habanalabs: add missing space after casting
      habanalabs: add hard reset timeout for PLDM

Tal Albo (1):
      habanalabs/gaudi: update coresight configuration

Tomer Tayar (2):
      habanalabs/gaudi: add ARB to QM stop on error masks
      habanalabs: print more info when failing to pin user memory

Yuri Nudelman (3):
      habanalabs: add debug flag to prevent failure on timeout
      habanalabs: added open_stats info ioctl
      debugfs: add skip_reset_on_timeout option

Zvika Yehudai (1):
      habanalabs: fix typo

farah kassabri (1):
      habanalabs: add validity check for signal cs

 .../ABI/testing/debugfs-driver-habanalabs          |    8 +
 .../misc/habanalabs/common/command_submission.c    |   81 +-
 drivers/misc/habanalabs/common/context.c           |    9 -
 drivers/misc/habanalabs/common/debugfs.c           |    5 +
 drivers/misc/habanalabs/common/device.c            |   82 +-
 drivers/misc/habanalabs/common/firmware_if.c       | 1806 ++++++++++++++++++--
 drivers/misc/habanalabs/common/habanalabs.h        |  280 ++-
 drivers/misc/habanalabs/common/habanalabs_drv.c    |   24 +-
 drivers/misc/habanalabs/common/habanalabs_ioctl.c  |   23 +-
 drivers/misc/habanalabs/common/hw_queue.c          |   42 +-
 drivers/misc/habanalabs/common/irq.c               |   24 +-
 drivers/misc/habanalabs/common/memory.c            |   22 +-
 drivers/misc/habanalabs/common/mmu/mmu.c           |   14 +-
 drivers/misc/habanalabs/common/pci/pci.c           |   34 +-
 drivers/misc/habanalabs/common/sysfs.c             |    2 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              | 1010 ++++++-----
 drivers/misc/habanalabs/gaudi/gaudiP.h             |    1 +
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c    |    6 +-
 drivers/misc/habanalabs/gaudi/gaudi_security.c     |   15 +-
 drivers/misc/habanalabs/goya/goya.c                |  251 +--
 drivers/misc/habanalabs/goya/goyaP.h               |    2 +-
 drivers/misc/habanalabs/goya/goya_coresight.c      |    2 +-
 drivers/misc/habanalabs/include/common/cpucp_if.h  |   45 +-
 .../misc/habanalabs/include/common/hl_boot_if.h    |  184 +-
 .../habanalabs/include/gaudi/gaudi_async_events.h  |   14 +-
 .../include/gaudi/gaudi_async_ids_map_extended.h   |   31 +-
 .../misc/habanalabs/include/gaudi/gaudi_fw_if.h    |   46 +
 .../misc/habanalabs/include/gaudi/gaudi_masks.h    |   15 +-
 .../misc/habanalabs/include/gaudi/gaudi_reg_map.h  |   10 +
 include/uapi/misc/habanalabs.h                     |   13 +
 30 files changed, 3216 insertions(+), 885 deletions(-)
