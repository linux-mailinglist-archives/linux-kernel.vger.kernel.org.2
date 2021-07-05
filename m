Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0F53BC21E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 19:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhGEROm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 13:14:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229743AbhGEROl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 13:14:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D12D61166;
        Mon,  5 Jul 2021 17:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625505124;
        bh=VL83sY2k9tVr1lf8GMP75En8K5kmtv3fjlWYR3ndlow=;
        h=Date:From:To:Cc:Subject:From;
        b=QQqpPVtxySzEUjQZBjxQ+CEbtWhmuyySNfYlppA9vfGD1FQYJ3kJGBn1wm+Ed+OWo
         hlS8/Pf9IGZp4SdaGiuOhxxatXUQVDmFYOsztdIPlhqPBqkpjWB1PQDKwy8yAPetOR
         d1BndpWXSMPiSkBf9Ssli2MhE/LC4UrliKUPeHYI=
Date:   Mon, 5 Jul 2021 19:12:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core patches for 5.14-rc1
Message-ID: <YOM9YqVUJc9+LjKr@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 009c9aa5be652675a06d5211e1640e02bbb1c33d:

  Linux 5.13-rc6 (2021-06-13 14:43:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.14-rc1

for you to fetch changes up to 3b1f941536af17537da09a7552c8e74804dd6823:

  docs: ABI: testing: sysfs-firmware-memmap: add some memmap types. (2021-06-24 16:24:51 +0200)

----------------------------------------------------------------
Driver core changes for 5.14-rc1

Here is the small set of driver core and debugfs updates for 5.14-rc1.

Included in here are:
	- debugfs api cleanups (touched some drivers)
	- devres updates
	- tiny driver core updates and tweaks

Nothing major in here at all, and all have been in linux-next for a
while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (5):
      device property: Don't check for NULL twice in the loops
      devres: Make locking straight forward in release_nodes()
      devres: Use list_for_each_safe_from() in remove_nodes()
      devres: No need to call remove_nodes() when there none present
      devres: Enable trace events

Greg Kroah-Hartman (9):
      Merge 5.13-rc2 into driver-core-next
      drm/i915/gvt: remove local storage of debugfs file
      b43legacy: don't save dentries for debugfs
      b43: don't save dentries for debugfs
      scsi: snic: debugfs: remove local storage of debugfs files
      debugfs: remove return value of debugfs_create_bool()
      debugfs: remove return value of debugfs_create_ulong()
      Merge 5.13-rc4 into driver-core-next
      Merge tag 'v5.13-rc6' into driver-core-next

Ian Kent (1):
      kernfs: move revalidate to be near lookup

Jianpeng Ma (1):
      docs: ABI: testing: sysfs-firmware-memmap: add some memmap types.

Johannes Berg (1):
      devcoredump: remove contact information

Julian Wiedmann (1):
      driver core: replace open-coded device_lock_assert()

Masahiro Yamada (1):
      firmware_loader: remove unneeded 'comma' macro

Quentin Perret (1):
      export: Make CRCs robust to symbol trimming

Rikard Falkeborn (1):
      drivers/base: Constify static attribute_group structs

Ruiqi Gong (1):
      drivers/base/node.c: make CACHE_ATTR define static DEVICE_ATTR_RO

Shawn Guo (1):
      firmware: replace HOTPLUG with UEVENT in FW_ACTION defines

Stephen Boyd (2):
      component: Drop 'dev' argument to component_match_realloc()
      component: Rename 'dev' to 'parent'

Uwe Kleine-König (2):
      driver core: auxiliary bus: Fix typo in the docs
      driver core: Drop helper devm_platform_ioremap_resource_wc()

Wolfram Sang (1):
      debugfs: only accept read attributes for blobs

Yang Yingliang (1):
      driver core: attribute_container: fix W=1 warnings

Zhen Lei (1):
      lib: devres: Add error information printing for __devm_ioremap_resource()

 Documentation/ABI/testing/sysfs-firmware-memmap   |   4 +
 Documentation/driver-api/auxiliary_bus.rst        |   2 +-
 Documentation/driver-api/driver-model/devres.rst  |   1 -
 Documentation/filesystems/debugfs.rst             |   4 +-
 drivers/base/Makefile                             |   3 +
 drivers/base/attribute_container.c                |   6 +-
 drivers/base/component.c                          |  96 ++++++++++----------
 drivers/base/core.c                               |   2 +-
 drivers/base/cpu.c                                |   4 +-
 drivers/base/devcoredump.c                        |   4 -
 drivers/base/devres.c                             | 105 ++++++++++------------
 drivers/base/firmware_loader/builtin/Makefile     |   1 -
 drivers/base/memory.c                             |   4 +-
 drivers/base/node.c                               |   4 +-
 drivers/base/platform.c                           |  22 +----
 drivers/base/property.c                           |  16 ++--
 drivers/base/trace.c                              |  10 +++
 drivers/base/trace.h                              |  56 ++++++++++++
 drivers/dma/imx-sdma.c                            |   2 +-
 drivers/gpu/drm/i915/gvt/kvmgt.c                  |  11 ++-
 drivers/media/platform/exynos4-is/fimc-is.c       |   2 +-
 drivers/mfd/iqs62x.c                              |   2 +-
 drivers/misc/lattice-ecp3-config.c                |   2 +-
 drivers/misc/sram.c                               |   6 +-
 drivers/net/wireless/broadcom/b43/debugfs.c       |  34 ++-----
 drivers/net/wireless/broadcom/b43/debugfs.h       |   3 -
 drivers/net/wireless/broadcom/b43legacy/debugfs.c |  29 ++----
 drivers/net/wireless/broadcom/b43legacy/debugfs.h |   3 -
 drivers/net/wireless/ti/wlcore/main.c             |   2 +-
 drivers/platform/x86/dell/dell_rbu.c              |   2 +-
 drivers/remoteproc/remoteproc_core.c              |   2 +-
 drivers/scsi/lpfc/lpfc_init.c                     |   2 +-
 drivers/scsi/snic/snic_debugfs.c                  |  23 ++---
 drivers/scsi/snic/snic_trc.h                      |   3 -
 drivers/tty/serial/ucc_uart.c                     |   2 +-
 fs/debugfs/file.c                                 |  38 +++-----
 fs/kernfs/dir.c                                   |  86 +++++++++---------
 include/linux/debugfs.h                           |  26 ++----
 include/linux/device.h                            |   9 --
 include/linux/export.h                            |   5 ++
 include/linux/firmware.h                          |   4 +-
 include/linux/platform_device.h                   |   3 -
 lib/devres.c                                      |   4 +-
 lib/test_firmware.c                               |  10 +--
 sound/soc/codecs/wm8958-dsp2.c                    |   6 +-
 45 files changed, 304 insertions(+), 361 deletions(-)
 create mode 100644 drivers/base/trace.c
 create mode 100644 drivers/base/trace.h
