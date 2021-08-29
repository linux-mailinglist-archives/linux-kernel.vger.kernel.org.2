Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A763FAA77
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 11:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbhH2JeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 05:34:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235020AbhH2JeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 05:34:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8D8A6023D;
        Sun, 29 Aug 2021 09:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630229608;
        bh=jjSdn7MeCWicxB3r+uzR04O6FYyUZ82gieELujrVEAk=;
        h=Date:From:To:Cc:Subject:From;
        b=W8lGqlfFj30s1oHx1dHRsUS/Z1ZW1kE+sBrRv+mI1z3MDgTMqzsfcVsmRF173qb1B
         MO3gro4wazYPM3UAM5qsBhtZJCTOD35Pmvf6tUwLFu3498njN4WFdHvq8hrz/Uvif2
         uRuqGiEzkt8OGg75sUoMWruT8Uo4ZbX+VvYXCj1uzZmqDXJPaTj/2xicd61bbqkoXz
         i4B748Ks6CME+RkAr9wTdKDqNoE/1RogII5yEsBRT4pqxOW5EMUAEF8hWD13R3pKqT
         4EXF8pupzNdl/2gjEqS9uJo9n0BzVtsDXBNGeSOn6y3wMUAMdoPYsNprOeiD6g9akA
         I7+jbZYzixw5A==
Date:   Sun, 29 Aug 2021 12:33:23 +0300
From:   Oded Gabbay <ogabbay@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, jgg@mellanox.com,
        daniel.vetter@ffwll.ch, torvalds@linux-foundation.org,
        airlied@gmail.com
Subject: [git pull v2] habanalabs pull request for kernel 5.15
Message-ID: <20210829093323.GA29743@ogabbay-vm2.habana-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Resending habanalabs pull request for for the merge window of kernel 5.15.
I removed the 2 patches concerning DMA-BUF for now, and hopefully we will
have a follow-up discussion on this issue when you get back from your
vacation.

The commits divide roughly 50/50 between adding new features, such
as signaling from within a graph and waiting for multiple workloads,
and between fixing various bugs, small improvements, etc.

I also fixed the issue you told me about, regarding copy_from_user from
inside a spinlock. I missed it while doing the CR, sorry.

Full details are in the tag.

Thanks,
Oded

The following changes since commit 0dc3ad3f859d3a65b335c861ec342d31d91e8bc8:

  Revert "bus: mhi: Add inbound buffers allocation flag" (2021-08-27 21:24:09 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-next-2021-08-29

for you to fetch changes up to 35309eb3de1b1df9d85da4b2991b58e3c0cd45d0:

  habanalabs/gaudi: hwmon default card name (2021-08-29 12:18:22 +0300)

----------------------------------------------------------------
This tag contains habanalabs driver changes for v5.15:

- Add a new uAPI (under the cs ioctl) to enable to user to reserve
  signals and signal them from within its workloads, while the driver
  performs the waiting. This allows finer granularity of pipelining
  between the different engines and resource utilization.

- Add a new uAPI (under the wait_for_cs ioctl) to allow waiting
  on multiple command submissions (workloads) at the same time. This
  is an optimization for the user process so it won't need to call
  multiple times to the wait_for_cs ioctl.

- Add new feature of "state dump", which can be triggered through new
  debugfs node. This is a similar concept to the kernel panic dump.
  This new mechanism retrieves information from the device in case
  one of the workloads that was sent by the user got stuck. This is
  very helpful for debugging the hang.

- Add a new debugfs node to perform lookup of user pointers that are
  mapped to habana device's pmmu.

- Fix to the tracking of user process when running inside a container.

- Allow user to map more than 4GB of memory to the device MMU in single
  IOCTL call.

- Minimize number of register reads done in GAUDI during user operation.

- Allow user to retrieve the device's server type that the device is
  connected to.

- Several fixes to the code of waiting on interrupts on behalf of the
  user.

- Fixes and improvements to the hint mechanism in our VA allocation.

- Update the firmware header files to the latest version while
  maintaining backward compatibility with older firmware versions.

- Multiple fixes to various bugs.

----------------------------------------------------------------
Alon Mizrahi (1):
      habanalabs/gaudi: add monitored SOBs to state dump

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
 include/uapi/misc/habanalabs.h                     |  187 ++-
 28 files changed, 3919 insertions(+), 834 deletions(-)
 create mode 100644 drivers/misc/habanalabs/common/state_dump.c
