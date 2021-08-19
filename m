Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED21B3F179E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238449AbhHSLCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:02:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238410AbhHSLCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:02:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1101C61152;
        Thu, 19 Aug 2021 11:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629370933;
        bh=HR5umDo9Nwsi1J9k9xPr2WIMj3OhvTv4BlNFy6XUSAU=;
        h=Date:From:To:Cc:Subject:From;
        b=VZn8JTCEJ2qs3DO/TZNfy2uaCIdHmpQqC4wRH0ZKmClu0frqBiEtyFsFr9F7uhH79
         uLaOlQDf9pBBAZyHRXXKPYZDJPO05StDGwxpYLijc1vHFJYrPQbl4ASMTm6pf5wNOQ
         I7uBjNlq38OYj3EC9B9QfB3V9MYbsLjHdI1BJ6kEVajcn9Z7Ampw12972Ung9xP+1c
         b59nddnUwiLrig3aX62NpbzV87sd8cP/owDgYAlj8NsMoN1KAFJDL0Vno3ZnBAUHEB
         SVFu4SaelCRRMUjAfdckWPWv9iiwXIyARJE7WGFIPgekfEAUqBLj/hy/7iBjCXnzXa
         xboKMht3OTIHw==
Date:   Thu, 19 Aug 2021 14:02:09 +0300
From:   Oded Gabbay <ogabbay@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs pull request for kernel 5.15
Message-ID: <20210819110209.GA115485@ogabbay-vm2.habana-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This is habanalabs pull request for the merge window of kernel 5.15.
The commits divide roughly 50/50 between adding new features, such
as peer-to-peer support with DMA-BUF or signaling from within a graph,
and fixing various bugs, small improvements, etc.

Full details are in the tag.

Thanks,
Oded

The following changes since commit b2159182dd498fdb0f49e371ccc94efbc12d1f8e:

  lkdtm: remove IDE_CORE_CP crashpoint (2021-08-19 07:40:22 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-next-2021-08-19

for you to fetch changes up to a3f369db34e33236f994d4ca3f13655109394d06:

  habanalabs/gaudi: invalidate PMMU mem cache on init (2021-08-19 11:43:43 +0300)

----------------------------------------------------------------
This tag contains habanalabs driver changes for v5.15:

- Add a new uAPI (under the memory ioctl) to request from the driver
  to export a DMA-BUF object that represents a memory region on
  the device's DRAM. This is needed to enable peer-to-peer over PCIe
  between habana device and an RDMA adapter (e.g. mlnx5 adapter).

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

Oded Gabbay (25):
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
      habanalabs: define uAPI to export FD for DMA-BUF
      habanalabs/gaudi: move scrubbing to late init
      habanalabs/gaudi: minimize number of register reads
      habanalabs: update to latest firmware headers
      habanalabs/gaudi: increase boot fit timeout
      habanalabs/gaudi: restore user registers when context opens
      habanalabs/gaudi: define DC POWER for secured PMC
      habanalabs/gaudi: size should be printed in decimal
      habanalabs/gaudi: invalidate PMMU mem cache on init

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

Tomer Tayar (4):
      habanalabs: fix nullifying of destroyed mmu pgt pool
      habanalabs: mark linux image as not loaded after hw_fini
      habanalabs: add support for dma-buf exporter
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

farah kassabri (4):
      habanalabs: support hint addresses range reservation
      habanalabs: signal/wait change sync object reset flow
      habanalabs: add support for encapsulated signals reservation
      habanalabs: add support for encapsulated signals submission

 .../ABI/testing/debugfs-driver-habanalabs          |   19 +
 drivers/misc/habanalabs/Kconfig                    |    1 +
 drivers/misc/habanalabs/common/Makefile            |    3 +-
 drivers/misc/habanalabs/common/command_buffer.c    |    2 +-
 .../misc/habanalabs/common/command_submission.c    | 1347 +++++++++++++++-----
 drivers/misc/habanalabs/common/context.c           |  146 ++-
 drivers/misc/habanalabs/common/debugfs.c           |  184 ++-
 drivers/misc/habanalabs/common/device.c            |  133 +-
 drivers/misc/habanalabs/common/firmware_if.c       |   56 +-
 drivers/misc/habanalabs/common/habanalabs.h        |  422 +++++-
 drivers/misc/habanalabs/common/habanalabs_drv.c    |    3 +-
 drivers/misc/habanalabs/common/habanalabs_ioctl.c  |    2 +
 drivers/misc/habanalabs/common/hw_queue.c          |  198 ++-
 drivers/misc/habanalabs/common/memory.c            |  689 +++++++++-
 drivers/misc/habanalabs/common/mmu/mmu_v1.c        |   12 +-
 drivers/misc/habanalabs/common/pci/pci.c           |    2 +
 drivers/misc/habanalabs/common/state_dump.c        |  718 +++++++++++
 drivers/misc/habanalabs/gaudi/gaudi.c              |  684 ++++++++--
 drivers/misc/habanalabs/gaudi/gaudiP.h             |   17 +
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c    |    5 -
 drivers/misc/habanalabs/goya/goya.c                |   88 +-
 drivers/misc/habanalabs/include/common/cpucp_if.h  |  103 +-
 .../misc/habanalabs/include/common/hl_boot_if.h    |   62 +-
 .../habanalabs/include/gaudi/asic_reg/gaudi_regs.h |    3 +
 .../misc/habanalabs/include/gaudi/gaudi_masks.h    |   17 +
 .../misc/habanalabs/include/gaudi/gaudi_reg_map.h  |    2 -
 include/uapi/misc/habanalabs.h                     |  211 ++-
 27 files changed, 4370 insertions(+), 759 deletions(-)
 create mode 100644 drivers/misc/habanalabs/common/state_dump.c
