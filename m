Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E58406D60
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 16:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbhIJOOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 10:14:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233783AbhIJOOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 10:14:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59B6761026;
        Fri, 10 Sep 2021 14:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631283171;
        bh=g5951wZWje9hIRSOfytjpLRGzJIdR6p2NSp7c8C6ves=;
        h=Date:From:To:Cc:Subject:From;
        b=X9DW8a0g+gZ4PLFUmASSa8iT+OlJCiQDfXDkWJYpuSE4ArAzemE8uC4uEoRQO2Fdy
         aio5m9BZxGAYfual6aWK9UXd3FG7AXz2opYN+6f/3HqJsk6rqDbUYtmUtVmbj9pO1T
         khWxD1da5SFyJlgz5AtJz5fXrosT1xpQ8vHz+E+4=
Date:   Fri, 10 Sep 2021 16:12:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Oded Gabbay <ogabbay@kernel.org>
Subject: [GIT PULL] More Char/Misc driver changes for 5.15-rc1
Message-ID: <YTtn4YSxwlQ5GbLT@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ba1dc7f273c73b93e0e1dd9707b239ed69eebd70:

  Merge tag 'char-misc-5.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc (2021-09-01 08:35:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.15-rc1-2

for you to fetch changes up to 4cd67adc44a3ccdb3b8526c9f932f905284e028f:

  Merge tag 'misc-habanalabs-next-2021-09-01' of https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux into char-misc-next (2021-09-01 20:13:05 +0200)

----------------------------------------------------------------
Misc driver patches for 5.15-rc1, second round

Here is a second round of misc driver patches for 5.15-rc1.

In here is only updates for the Habanalabs driver.  This request is late
because the previously-objected-to dma-buf patches are all removed and
some fixes that you and others found are now included in here as well.

All of these have been in linux-next for well over a week with no
reports of problems, and they are all self-contained to only this one
driver.  Full details are in the shortlog.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alon Mizrahi (1):
      habanalabs/gaudi: add monitored SOBs to state dump

Greg Kroah-Hartman (1):
      Merge tag 'misc-habanalabs-next-2021-09-01' of https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux into char-misc-next

Koby Elbaz (2):
      habanalabs: fix race between soft reset and heartbeat
      habanalabs: clear msg_to_cpu_reg to avoid misread after reset

Oded Gabbay (29):
      habanalabs: rename enum vm_type_t to vm_type
      habanalabs: re-init completion object upon retry
      habanalabs: release pending user interrupts on device fini
      habanalabs: handle case of interruptable wait
      habanalabs: user mappings can be 64-bit
      habanalabs: allow disabling huge page use
      habanalabs: use get_task_pid() to take PID
      habanalabs: fix type of variable
      habanalabs: add asic property of host dma offset
      habanalabs: set dma max segment size
      habanalabs/gaudi: fix information printed on SM event
      habanalabs: update firmware header to latest version
      habanalabs/goya: add missing initialization
      habanalabs: revise prints on FD close
      habanalabs: remove redundant warning message
      habanalabs: expose server type in INFO IOCTL
      habanalabs/gaudi: move scrubbing to late init
      habanalabs/gaudi: minimize number of register reads
      habanalabs: update to latest firmware headers
      habanalabs/gaudi: increase boot fit timeout
      habanalabs/gaudi: restore user registers when context opens
      habanalabs/gaudi: define DC POWER for secured PMC
      habanalabs/gaudi: size should be printed in decimal
      habanalabs/gaudi: invalidate PMMU mem cache on init
      habanalabs: disable IRQ in user interrupts spinlock
      habanalabs: remove unnecessary device status check
      habanalabs: never copy_from_user inside spinlock
      habanalabs/gaudi: block ICACHE_BASE_ADDERESS_HIGH in TPC
      habanalabs: add support for f/w reset

Ofir Bitton (6):
      habanalabs: update firmware header files
      habanalabs: missing mutex_unlock in process kill procedure
      habanalabs/gaudi: trigger state dump in case of SM errors
      habanalabs: add validity check for event ID received from F/W
      habanalabs/gaudi: scrub HBM to a specific value
      habanalabs/gaudi: fetch TPC/MME ECC errors from F/W

Ohad Sharabi (5):
      habanalabs: get multiple fences under same cs_lock
      habanalabs: add wait-for-multi-CS uAPI
      habanalabs: convert PCI BAR offset to u64
      habanalabs: make set_pci_regions asic function
      habanalabs: modify multi-CS to wait on stream masters

Omer Shpigelman (1):
      habanalabs: add "in device creation" status

Rajaravi Krishna Katta (1):
      habanalabs/gaudi: hwmon default card name

Tomer Tayar (3):
      habanalabs: fix nullifying of destroyed mmu pgt pool
      habanalabs: mark linux image as not loaded after hw_fini
      habanalabs/gaudi: unmask out of bounds SLM access interrupt

Yuri Nudelman (7):
      habanalabs: allow fail on inability to respect hint
      habanalabs: expose state dump
      habanalabs: state dump monitors and fences infrastructure
      habanalabs/gaudi: implement state dump
      habanalabs: save pid per userptr
      habanalabs: fix mmu node address resolution in debugfs
      habanalabs: add userptr_lookup node in debugfs

Zvika Yehudai (1):
      habanalabs: rename cb_mmap to mmap

farah kassabri (5):
      habanalabs: support hint addresses range reservation
      habanalabs: signal/wait change sync object reset flow
      habanalabs: add support for encapsulated signals reservation
      habanalabs: add support for encapsulated signals submission
      habanalabs: cannot sleep while holding spinlock

 .../ABI/testing/debugfs-driver-habanalabs          |   19 +
 drivers/misc/habanalabs/common/Makefile            |    3 +-
 drivers/misc/habanalabs/common/command_buffer.c    |    4 +-
 .../misc/habanalabs/common/command_submission.c    | 1387 +++++++++++++++-----
 drivers/misc/habanalabs/common/context.c           |  146 ++-
 drivers/misc/habanalabs/common/debugfs.c           |  184 ++-
 drivers/misc/habanalabs/common/device.c            |  163 +--
 drivers/misc/habanalabs/common/firmware_if.c       |   56 +-
 drivers/misc/habanalabs/common/habanalabs.h        |  421 +++++-
 drivers/misc/habanalabs/common/habanalabs_drv.c    |   13 +-
 drivers/misc/habanalabs/common/habanalabs_ioctl.c  |    2 +
 drivers/misc/habanalabs/common/hw_queue.c          |  198 ++-
 drivers/misc/habanalabs/common/memory.c            |  169 ++-
 drivers/misc/habanalabs/common/mmu/mmu_v1.c        |   12 +-
 drivers/misc/habanalabs/common/pci/pci.c           |    2 +
 drivers/misc/habanalabs/common/state_dump.c        |  718 ++++++++++
 drivers/misc/habanalabs/common/sysfs.c             |   20 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              |  716 ++++++++--
 drivers/misc/habanalabs/gaudi/gaudiP.h             |   19 +-
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c    |    5 -
 drivers/misc/habanalabs/gaudi/gaudi_security.c     |    8 +
 drivers/misc/habanalabs/goya/goya.c                |  102 +-
 drivers/misc/habanalabs/include/common/cpucp_if.h  |  115 +-
 .../misc/habanalabs/include/common/hl_boot_if.h    |   62 +-
 .../habanalabs/include/gaudi/asic_reg/gaudi_regs.h |    3 +
 .../misc/habanalabs/include/gaudi/gaudi_masks.h    |   17 +
 .../misc/habanalabs/include/gaudi/gaudi_reg_map.h  |    2 -
 include/uapi/misc/habanalabs.h                     |  186 ++-
 28 files changed, 3918 insertions(+), 834 deletions(-)
 create mode 100644 drivers/misc/habanalabs/common/state_dump.c
