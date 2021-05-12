Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258B337B6A2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 09:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhELHMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 03:12:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:29454 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230070AbhELHM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 03:12:26 -0400
IronPort-SDR: mQNHf0BnFqkEvg8rQ6f/cgXaHEpbQoyDjrA1mHsJX+xdZ1AoVzwHbSzXo5IVhPcMJ3XjTMFgSS
 zfWWUxrkZaXA==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="186770439"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="186770439"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 00:11:18 -0700
IronPort-SDR: txCS/5aKQOd8gkHxhuVsbQu4w1rPLw4xShEl0AH7Sc2bP1IHY2XHJ42jIUJK+9XDkKHd8AqQC0
 qgUuNqC37irQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="541965803"
Received: from aipg-stp-03.iil.intel.com ([143.185.92.28])
  by orsmga004.jf.intel.com with ESMTP; 12 May 2021 00:11:15 -0700
From:   Guy Zadicario <guy.zadicario@intel.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     olof@lixom.net, alexander.shishkin@linux.intel.com,
        andriy.shevchenko@intel.com, yochai.shefi-simchon@intel.com,
        guy.zadicario@intel.com
Subject: [PATCH 00/15] misc: nnpi: New PCIe driver for Intel's NNP-I pcie device
Date:   Wed, 12 May 2021 10:10:31 +0300
Message-Id: <20210512071046.34941-1-guy.zadicario@intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following series is a driver for a new PCIe device from Intel named NNP-I
(Nirvana Neural Processor for Inference). NNP-I is a PCIe connected compute
device used for acceleration of AI deep learning inference applications in the
data-center.

The reason that this driver should be in the kernel is that it aims to serve
multiple users and user-space applications which might share the same NNP-I
card. Workloads from multiple applications can be processed simultanously by
the NNP-I card if enough compute resources exist.

Overview of the NNP-I device, driver structure and ABIs used in the driver is in
patch#1, which adds the info as a document as it might be a useful info for
anyone trying to understand the driver even past review.

In order to ease the review process, there will be multiple series for the
entire driver code. This is the first series, and it implements everything
necessary to initialize the NNP-I device and allow a user-space inference
application to use it. Other features, which are mostly related to maintenance,
device status visibility and error-handling, will be submitted on the next stage.

A basic user-space library and test application which illustrates the flow of
an NNP-I inference application can be found here: https://github.com/IntelAI/nnpi-host
(This series is enough for the test application to run)

This patchset has gone through internal review inside Intel, the summary of the
change log from the internal review follows.

I would appreciate any feedback, questions or comments to this series.

Changes in v22:
   - Patch#13: remove back-to-back mutex acquire when calling to check if response
               ring buffer is empty.
   - Patch#15: remove not needed output argument to do_map_hostres() by calling
               to send_map_hostres_req() from do_map_hostres().

Changes in v21:
   - Fixed kerneldoc warnings.
   - Patch#15 - break ioctl handling function map_hostres() to smaller functions.
   - Few code style issues
   - Removed not-needed error printouts.
   - Removed channel "respq_corrupted" state, instead made chan_read return 0
     without modifying the response ring-buffer.

Changes in v20:
   - Patcg#13: Handle response ring-buffer corruption by adding "respq_corruped"
               state.
   - Patch#15: protect host resource mappings using existing dev_mutex lock
               instead of a new spin lock.
   - Patch#12: removed not needed "force" arg to nnpdev_submit_device_event_to_channels()
   - Replaced two boolean states of cmd_chan to a single channel status state
   - Few code style issues

Changes in v19:
   - Use global mutex to protect device chardev clients list instead of per-device
     mutex. (to simplify handling of device disconnect during device removal).

Changes in v18:
   - Added kref to device chardev client structure to deal with device removal
     possible race condition.
   - Fixed lkp build failure on 32-bit arch.
   - Some code style issues

Changes in v17:
   - Fixes v16 review comments only.
   - Added Alex's reviewed-by tag to patches 2,3,5,6,8,9
     (after fixing requested comments)
   - Created new patch#7 as suggested by Alexander Shishkin to pull some
     functionality from patch#6 to a separate patch.
   - Fixed lkp build warning on arm arch by using:
     ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT.
     (This is in patch#2)
   - Rebased on top of 5.12-rc3

Changes in v16:
   - Fixed v15 review comments
   - Added MODULE_DEVICE_TABLE() usage for pci driver.

Changes in v15:
   - fixed v14 review comments
   - few bug fixes found during testing:
       + made channel's resosponse ring buffer be resizable as some stress apps
         stretch it.
       + Use mutex instead of spin_lock for protecting nnpdev pointer in a channel.
         This is since it needs to be locked when applications do write to the channel
         file.

Changes in v14:
   - converted overview document to .rst file
   - refactor into two modules, NNP-I framework and PCIe device driver.
     (as suggested by Andy Shevchenko)
   - changed device remove flow to disconnect device from active clients,
     rather then waiting for clients to exit.
   - Fixed all review comments.

Changes in v13:
   - Fixed errors from codespell
   - Fixed errors reported by sparse and cppcheck
   - Modified commit messages
   - Fixed all comments from v12

Changes in v12:
   - Removed sharing of boot image between multiple devices
   - Fixed comments from v11

Changes in v11:
   - Fixed comments from v10
   - Removed the following features, reducing the size of the patch-set:
      - Sysfs visibility
      - Handling of device errors
      - Visibility to static device system info (total memory, ice count, steping, ...)
      - Access to device crash log
      - BIOS capsule update
      - enable/disable device for new inference contexts
      - PCIe reset and error handling
      - Visibility to device post code and bios flash progress
      - Ability to get more command queue BW for inference contexts comparing to nnpiml channels
      - Device hang detection
      - PCIe error injection
      - Host SW traces
      - Support host resources from dma-buf objects (created by another driver)
      - Block non-privileged users to do any nnpi_ctl commands and query SW counters of ALL contexts.

Changes in v10:
   - removed bitfield in unions from protocol (using bit masks instead)
     (as suggested by Andy Shevchenko)
   - renamed function names to be more consistant
   - changed logical/pci "layers" to be called device and HW layers.
   - removed host resource allocation method from IOCTL. Support only pinning user memory.
   - re-wrote most of the commit messages, based on Alexander Shishkin comments.
   - fixed errors reported by lkp

Changes in v9:
   - fixed potential dead-lock in boot load flow
   - IOCTL structs alignment issues
   - sysfs - one value per-attribute
   - code-style: func arguments and multi-line alignment
   - sparse errors reported by lkp

Changes in v8:
   - broke the most of the big patches to little smaller ones.
   - Reviewed and fixed all comments from v7.

Changes in v7:
   - Added documentation sections to many structs and functions.
   - Added "Terminology" section to Documentation/misc-devices/intel-nnpi.txt
   - Removed use of function pointers with interface to PCIe "h/w layer"
   - Fixed IOCTLs backward compatability support.
   - Patch#13 has removed - ipc s/w counters
   - Patch#15 has removed - handling PCIe link-down in absense of pciehp
   - Byteorder consideration - Fixed data packets sent to the device to be
     in little-endian. Other communications with the device is through
     mmio which is little-endian anyway.
   - Removed sysfs "reset" attribute
   - Removed sysfs attribute which outputs application pids.
   - Fixed and cleaned all other comments.

Changes in v6:
   - lkp build fixes
   - fixes build errors when tracing is enabled
   - made trace compiled by default, define NNP_DISABLE_TRACE to disable.
   - fixed reviewed-by tag to mention first name before last name.
   - serialize pcie reset and remove flows.
   - rebased on top of current linux master

Changes in v5:
   - Makefile fix for out-of-tree builds
     (added $(srctree) when specifying include path)

Changes in v4:
   - Per Dave-Hansen suggestion, abandon patch#20
     (misc: nnpi: Added hostres_min_order module parameter)
     Realized that the benefit it brings not worth the risk.
   - Fixes build failures found by lkp
   - Some bug fixes found in v3
   - Clean W=1 build warnings

Changes in v3:
   - Few small BUG fixes found during testing
   - Add device bios update flow - boot flow has changed to allow
     booting the device either with OS boot image or bios capsule image.
     The device bios will start bios update if capsule image is used.
   - Fixed comments from previous version

Changes in v2:
   - used --strict flag to checkpatch.pl, only left CHECK comments which
     will break the 80 chars line length limit if fixed.
   - removed CONFIG_DMA_SHARED_BUFFER ifdefs
   - moved high order page allocation optimization to separete (last) patch
   - removed device list array
   - removed all c++ style comments

Thanks,
Guy.

Guy Zadicario (15):
  misc: nnpi: Document NNP-I's driver overview
  misc: nnpi: Initialize NNP-I framework and PCIe modules
  misc: nnpi: Manage and schedule messages to device
  misc: nnpi: Define host/card ipc protocol
  misc: nnpi: Manage host memory resources
  misc: nnpi: Allow usermode to manage host resources
  misc: nnpi: Disallow host memory resource access if no NNP-I devices
    exist
  misc: nnpi: Boot NNP-I device
  misc: nnpi: Process device response messages
  misc: nnpi: Query and verify device protocol
  misc: nnpi: Create comm channel from app to device
  misc: nnpi: Route device response messages
  misc: nnpi: Expose command channel file interface
  misc: nnpi: Create command channel from userspace
  misc: nnpi: Map host resources to device channel

 Documentation/ABI/testing/sysfs-driver-intel_nnpi  |    5 +
 Documentation/misc-devices/index.rst               |    1 +
 Documentation/misc-devices/intel-nnpi.rst          |  237 +++++
 MAINTAINERS                                        |    6 +
 drivers/misc/Kconfig                               |    1 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/intel-nnpi/Kconfig                    |   18 +
 drivers/misc/intel-nnpi/Makefile                   |   13 +
 drivers/misc/intel-nnpi/bootimage.c                |  246 +++++
 drivers/misc/intel-nnpi/bootimage.h                |   43 +
 drivers/misc/intel-nnpi/cmd_chan.c                 |  790 ++++++++++++++
 drivers/misc/intel-nnpi/cmd_chan.h                 |  134 +++
 drivers/misc/intel-nnpi/device.c                   | 1081 ++++++++++++++++++++
 drivers/misc/intel-nnpi/device.h                   |  182 ++++
 drivers/misc/intel-nnpi/device_chardev.c           |  789 ++++++++++++++
 drivers/misc/intel-nnpi/device_chardev.h           |   14 +
 drivers/misc/intel-nnpi/host_chardev.c             |  353 +++++++
 drivers/misc/intel-nnpi/host_chardev.h             |   12 +
 drivers/misc/intel-nnpi/hostres.c                  |  627 ++++++++++++
 drivers/misc/intel-nnpi/hostres.h                  |  167 +++
 .../misc/intel-nnpi/ipc_include/ipc_c2h_events.h   |  198 ++++
 drivers/misc/intel-nnpi/ipc_include/ipc_protocol.h |  340 ++++++
 .../misc/intel-nnpi/ipc_include/nnp_boot_defs.h    |   71 ++
 drivers/misc/intel-nnpi/ipc_include/nnp_elbi.h     |   91 ++
 drivers/misc/intel-nnpi/msg_scheduler.c            |  319 ++++++
 drivers/misc/intel-nnpi/msg_scheduler.h            |  153 +++
 drivers/misc/intel-nnpi/nnp_pcie.c                 |  530 ++++++++++
 drivers/misc/intel-nnpi/nnp_user.c                 |  131 +++
 drivers/misc/intel-nnpi/nnp_user.h                 |   79 ++
 include/uapi/misc/intel_nnpi.h                     |  304 ++++++
 30 files changed, 6936 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel_nnpi
 create mode 100644 Documentation/misc-devices/intel-nnpi.rst
 create mode 100644 drivers/misc/intel-nnpi/Kconfig
 create mode 100644 drivers/misc/intel-nnpi/Makefile
 create mode 100644 drivers/misc/intel-nnpi/bootimage.c
 create mode 100644 drivers/misc/intel-nnpi/bootimage.h
 create mode 100644 drivers/misc/intel-nnpi/cmd_chan.c
 create mode 100644 drivers/misc/intel-nnpi/cmd_chan.h
 create mode 100644 drivers/misc/intel-nnpi/device.c
 create mode 100644 drivers/misc/intel-nnpi/device.h
 create mode 100644 drivers/misc/intel-nnpi/device_chardev.c
 create mode 100644 drivers/misc/intel-nnpi/device_chardev.h
 create mode 100644 drivers/misc/intel-nnpi/host_chardev.c
 create mode 100644 drivers/misc/intel-nnpi/host_chardev.h
 create mode 100644 drivers/misc/intel-nnpi/hostres.c
 create mode 100644 drivers/misc/intel-nnpi/hostres.h
 create mode 100644 drivers/misc/intel-nnpi/ipc_include/ipc_c2h_events.h
 create mode 100644 drivers/misc/intel-nnpi/ipc_include/ipc_protocol.h
 create mode 100644 drivers/misc/intel-nnpi/ipc_include/nnp_boot_defs.h
 create mode 100644 drivers/misc/intel-nnpi/ipc_include/nnp_elbi.h
 create mode 100644 drivers/misc/intel-nnpi/msg_scheduler.c
 create mode 100644 drivers/misc/intel-nnpi/msg_scheduler.h
 create mode 100644 drivers/misc/intel-nnpi/nnp_pcie.c
 create mode 100644 drivers/misc/intel-nnpi/nnp_user.c
 create mode 100644 drivers/misc/intel-nnpi/nnp_user.h
 create mode 100644 include/uapi/misc/intel_nnpi.h

-- 
1.8.3.1

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

