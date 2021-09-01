Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2753FDDB2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 16:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244659AbhIAORc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 10:17:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233922AbhIAORb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 10:17:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C2D26108B;
        Wed,  1 Sep 2021 14:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630505794;
        bh=6kRwqwi1684ftpPu4WQde4rERfL7gxUV5Hsp3U67//o=;
        h=Date:From:To:Cc:Subject:From;
        b=2X51hCGWUcBBVI1sM8TA3KR8ulVZgn2sxzL/ryd6g/KSIdzukKjJiSD+Wu2QrvotT
         2Af0HKFy4JqfljkEJYzap6chg9LhEZDpNNmgV8QymdLC8T45+1EuX7Wwxsv1M+uMsR
         dZXnRm/SYam7rkCf/IgNVBMlvP+3H5O3uxs9/FpI=
Date:   Wed, 1 Sep 2021 16:16:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core changes for 5.15-rc1
Message-ID: <YS+LQJnyf5w93K+A@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 36a21d51725af2ce0700c6ebcb6b9594aac658a6:

  Linux 5.14-rc5 (2021-08-08 13:49:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.15-rc1

for you to fetch changes up to 049d1693db78144c979b34e2084287ada912cf7f:

  MAINTAINERS: Add dri-devel for component.[hc] (2021-08-27 10:40:38 +0200)

----------------------------------------------------------------
Driver core update for 5.15-rc1

Here is the big set of driver core patches for 5.15-rc1.

These do change a number of different things across different
subsystems, and because of that, there were 2 stable tags created that
might have already come into your tree from different pulls that did the
following
	- changed the bus remove callback to return void
	- sysfs iomem_get_mapping rework

The latter one will cause a tiny merge issue with your tree, as there
was a last-minute fix for this in 5.14 in your tree, but the fixup
should be "obvious".  If you want me to provide a fixed merge for this,
please let me know.

Other than those two things, there's only a few small things in here:
	- kernfs performance improvements for huge numbers of sysfs
	  users at once
	- tiny api cleanups
	- other minor changes

All of these have been in linux-next for a while with no reported
problems, other than the before-mentioned merge issue.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Barry Song (1):
      lib: test_bitmap: add bitmap_print_bitmask/list_to_buf test cases

Daniel Vetter (1):
      MAINTAINERS: Add dri-devel for component.[hc]

Geert Uytterhoeven (1):
      sysfs: Use local reference in compat_only_sysfs_link_entry_to_kobj()

Greg Kroah-Hartman (3):
      Merge 5.14-rc3 into driver-core-next
      Merge tag 'sysfs_defferred_iomem_get_mapping-5.15' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core driver-core-next
      Merge 5.14-rc5 into driver-core-next

Heikki Krogerus (2):
      ARM: tegra: paz00: Handle device properties with software node API
      driver core: platform: Remove platform_device_add_properties()

Ian Kent (5):
      kernfs: add a revision to identify directory node changes
      kernfs: use VFS negative dentry caching
      kernfs: switch kernfs to use an rwsem
      kernfs: use i_lock to protect concurrent inode updates
      kernfs: dont call d_splice_alias() under kernfs node lock

Jinchao Wang (2):
      driver: base: Replace symbolic permissions with octal permissions
      driver: base: Prefer unsigned int to bare use of unsigned

Krzysztof Wilczyński (2):
      sysfs: Invoke iomem_get_mapping() from the sysfs open callback
      sysfs: Rename struct bin_attribute member to f_mapping

Shuah Khan (1):
      selftests: firmware: Fix ignored return val of asprintf() warn

Sven Eckelmann (1):
      debugfs: Return error during {full/open}_proxy_open() on rmmod

Tian Tao (3):
      cpumask: introduce cpumap_print_list/bitmask_to_buf to support large bitmask and list
      topology: use bin_attribute to break the size limitation of cpumap ABI
      drivers/base/node.c: use bin_attribute to break the size limitation of cpumap ABI

Uwe Kleine-König (10):
      PCI: endpoint: Make struct pci_epf_driver::remove return void
      s390/cio: Make struct css_driver::remove return void
      s390/ccwgroup: Drop if with an always false condition
      s390/scm: Make struct scm_driver::remove return void
      bus: Make remove callback return void
      nubus: Make struct nubus_driver::remove return void
      nubus: Simplify check in remove callback
      sh: superhyway: Simplify check in remove callback
      zorro: Simplify remove callback
      zorro: Drop useless (and hardly used) .driver member in struct zorro_dev

Xiongfeng Wang (1):
      cacheinfo: clear cache_leaves(cpu) in free_cache_attributes()

Yury Norov (1):
      bitmap: extend comment to bitmap_print_bitmask/list_to_buf

Zhen Lei (2):
      firmware: fix theoretical UAF race with firmware cache and resume
      driver core: Fix error return code in really_probe()

 MAINTAINERS                                     |   5 +
 arch/arm/common/locomo.c                        |   3 +-
 arch/arm/common/sa1111.c                        |   4 +-
 arch/arm/mach-rpc/ecard.c                       |   4 +-
 arch/arm/mach-tegra/board-paz00.c               |   2 +-
 arch/mips/sgi-ip22/ip22-gio.c                   |   3 +-
 arch/parisc/kernel/drivers.c                    |   5 +-
 arch/powerpc/platforms/ps3/system-bus.c         |   3 +-
 arch/powerpc/platforms/pseries/ibmebus.c        |   3 +-
 arch/powerpc/platforms/pseries/vio.c            |   3 +-
 arch/s390/include/asm/eadm.h                    |   2 +-
 arch/sparc/kernel/vio.c                         |   4 +-
 drivers/acpi/bus.c                              |   3 +-
 drivers/amba/bus.c                              |   4 +-
 drivers/base/auxiliary.c                        |   4 +-
 drivers/base/bus.c                              |   6 +-
 drivers/base/cacheinfo.c                        |   1 +
 drivers/base/cpu.c                              |   4 +-
 drivers/base/dd.c                               |  16 ++-
 drivers/base/firmware_loader/main.c             |  20 ++--
 drivers/base/isa.c                              |   4 +-
 drivers/base/map.c                              |  12 +-
 drivers/base/node.c                             |  71 ++++++-----
 drivers/base/platform.c                         |  24 +---
 drivers/base/power/wakeup.c                     |   2 +-
 drivers/base/topology.c                         | 115 ++++++++++--------
 drivers/bcma/main.c                             |   6 +-
 drivers/bus/sunxi-rsb.c                         |   4 +-
 drivers/cxl/core.c                              |   3 +-
 drivers/dax/bus.c                               |   4 +-
 drivers/dma/idxd/sysfs.c                        |   4 +-
 drivers/firewire/core-device.c                  |   4 +-
 drivers/firmware/arm_scmi/bus.c                 |   4 +-
 drivers/firmware/google/coreboot_table.c        |   4 +-
 drivers/fpga/dfl.c                              |   4 +-
 drivers/hid/hid-core.c                          |   4 +-
 drivers/hid/intel-ish-hid/ishtp/bus.c           |   4 +-
 drivers/hv/vmbus_drv.c                          |   5 +-
 drivers/hwtracing/intel_th/core.c               |   4 +-
 drivers/i2c/i2c-core-base.c                     |   5 +-
 drivers/i3c/master.c                            |   4 +-
 drivers/input/gameport/gameport.c               |   3 +-
 drivers/input/serio/serio.c                     |   3 +-
 drivers/ipack/ipack.c                           |   4 +-
 drivers/macintosh/macio_asic.c                  |   4 +-
 drivers/mcb/mcb-core.c                          |   4 +-
 drivers/media/pci/bt8xx/bttv-gpio.c             |   3 +-
 drivers/memstick/core/memstick.c                |   3 +-
 drivers/mfd/mcp-core.c                          |   3 +-
 drivers/misc/mei/bus.c                          |   4 +-
 drivers/misc/tifm_core.c                        |   3 +-
 drivers/mmc/core/bus.c                          |   4 +-
 drivers/mmc/core/sdio_bus.c                     |   4 +-
 drivers/net/ethernet/8390/mac8390.c             |   3 +-
 drivers/net/ethernet/natsemi/macsonic.c         |   4 +-
 drivers/net/netdevsim/bus.c                     |   3 +-
 drivers/ntb/core.c                              |   4 +-
 drivers/ntb/ntb_transport.c                     |   4 +-
 drivers/nubus/bus.c                             |   8 +-
 drivers/nvdimm/bus.c                            |   3 +-
 drivers/pci/endpoint/pci-epf-core.c             |   7 +-
 drivers/pci/pci-driver.c                        |   3 +-
 drivers/pci/pci-sysfs.c                         |   6 +-
 drivers/pcmcia/ds.c                             |   4 +-
 drivers/platform/surface/aggregator/bus.c       |   4 +-
 drivers/platform/x86/wmi.c                      |   4 +-
 drivers/pnp/driver.c                            |   3 +-
 drivers/rapidio/rio-driver.c                    |   4 +-
 drivers/rpmsg/rpmsg_core.c                      |   7 +-
 drivers/s390/block/scm_drv.c                    |   4 +-
 drivers/s390/cio/ccwgroup.c                     |   6 +-
 drivers/s390/cio/chsc_sch.c                     |   3 +-
 drivers/s390/cio/css.c                          |   7 +-
 drivers/s390/cio/css.h                          |   2 +-
 drivers/s390/cio/device.c                       |   9 +-
 drivers/s390/cio/eadm_sch.c                     |   4 +-
 drivers/s390/cio/scm.c                          |   5 +-
 drivers/s390/cio/vfio_ccw_drv.c                 |   3 +-
 drivers/s390/crypto/ap_bus.c                    |   4 +-
 drivers/scsi/scsi_debug.c                       |   3 +-
 drivers/sh/superhyway/superhyway.c              |   8 +-
 drivers/siox/siox-core.c                        |   4 +-
 drivers/slimbus/core.c                          |   4 +-
 drivers/soc/qcom/apr.c                          |   4 +-
 drivers/spi/spi.c                               |   4 +-
 drivers/spmi/spmi.c                             |   3 +-
 drivers/ssb/main.c                              |   4 +-
 drivers/staging/fieldbus/anybuss/host.c         |   4 +-
 drivers/staging/greybus/gbphy.c                 |   4 +-
 drivers/target/loopback/tcm_loop.c              |   5 +-
 drivers/thunderbolt/domain.c                    |   4 +-
 drivers/tty/serdev/core.c                       |   4 +-
 drivers/usb/common/ulpi.c                       |   4 +-
 drivers/usb/serial/bus.c                        |   4 +-
 drivers/usb/typec/bus.c                         |   4 +-
 drivers/vdpa/vdpa.c                             |   4 +-
 drivers/vfio/mdev/mdev_driver.c                 |   4 +-
 drivers/virtio/virtio.c                         |   3 +-
 drivers/vlynq/vlynq.c                           |   4 +-
 drivers/vme/vme.c                               |   4 +-
 drivers/xen/xenbus/xenbus.h                     |   2 +-
 drivers/xen/xenbus/xenbus_probe.c               |   4 +-
 drivers/zorro/zorro-driver.c                    |  16 +--
 fs/debugfs/file.c                               |   8 +-
 fs/kernfs/dir.c                                 | 153 +++++++++++++-----------
 fs/kernfs/file.c                                |   4 +-
 fs/kernfs/inode.c                               |  26 ++--
 fs/kernfs/kernfs-internal.h                     |  24 +++-
 fs/kernfs/mount.c                               |  12 +-
 fs/kernfs/symlink.c                             |   4 +-
 fs/sysfs/file.c                                 |   4 +-
 fs/sysfs/group.c                                |   2 +-
 include/linux/bitmap.h                          |   6 +
 include/linux/cpumask.h                         |  38 ++++++
 include/linux/device/bus.h                      |   2 +-
 include/linux/kernfs.h                          |   7 +-
 include/linux/nubus.h                           |   2 +-
 include/linux/pci-epf.h                         |   2 +-
 include/linux/platform_device.h                 |   2 -
 include/linux/sysfs.h                           |   2 +-
 include/linux/zorro.h                           |   1 -
 lib/bitmap.c                                    | 121 +++++++++++++++++++
 lib/test_bitmap.c                               | 150 +++++++++++++++++++++++
 sound/ac97/bus.c                                |   6 +-
 sound/aoa/soundbus/core.c                       |   4 +-
 tools/testing/selftests/firmware/fw_namespace.c |   3 +-
 126 files changed, 729 insertions(+), 512 deletions(-)
