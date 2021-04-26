Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA87436B345
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 14:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbhDZMkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 08:40:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232107AbhDZMkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 08:40:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA4B36109E;
        Mon, 26 Apr 2021 12:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619440781;
        bh=1PL2E75/7LE91DrJIiQfVxnmo48PS2GcNYxysDj95KE=;
        h=Date:From:To:Cc:Subject:From;
        b=gwt2ZGxWJEh7AYzGOveD7fkYAoEXRMnCoMT18VY56mkW+JYvw3q3zwQi3KpEkPnO3
         WbOB01T3269ZmppAiSW/UafQNg1RdkiYaEgmLj0kbNk6K7uV0GZHbt913nxW6AQ0f4
         8nHlgbsK7zQM9QiBQqSOGUV5nNwzaKr5aiP7T6yo=
Date:   Mon, 26 Apr 2021 14:39:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core changes for 5.13-rc1
Message-ID: <YIa0iifkxGDmlG+8@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d434405aaab7d0ebc516b68a8fc4100922d7f5ef:

  Linux 5.12-rc7 (2021-04-11 15:16:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.13-rc1

for you to fetch changes up to a943d76352dbb4707a5e5537bbe696c00f5ddd36:

  devm-helpers: Fix devm_delayed_work_autocancel() kerneldoc (2021-04-22 08:20:15 +0200)

----------------------------------------------------------------
Driver core changes for 5.13-rc1

Here is the "big" set of driver core changes for 5.13-rc1.

Nothing major, just lots of little core changes and cleanups, notable
things are:
	- finally set fw_devlink=on by default.  All reported issues
	  with this have been shaken out over the past 9 months or so,
	  but we will be paying attention to any fallout here in case we
	  need to revert this as the default boot value (symptoms of
	  problems are a simple lack of booting)
	- fixes found to be needed by fw_devlink=on value in some
	  subsystems (like clock).
	- delayed work initialization cleanup
	- driver core cleanups and minor updates
	- software node cleanups and tweaks
	- devtmpfs cleanups
	- minor debugfs cleanups

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ahmad Fatoum (1):
      driver core: add helper for deferred probe reason setting

Andy Shevchenko (14):
      device property: Sync descriptions of swnode array and group APIs
      device property: Add test cases for fwnode_property_count_*() APIs
      driver core: platform: Make clear error code used for missed IRQ
      driver core: platform: Declare early_platform_cleanup() prototype
      driver core: Cast to (void *) with __force for __percpu pointer
      driver core: Replace printf() specifier and drop unneeded casting
      driver core: platform: Make platform_get_irq_optional() optional
      software node: Free resources explicitly when swnode_register() fails
      software node: Introduce software_node_alloc()/software_node_free()
      software node: Deduplicate code in fwnode_create_software_node()
      software node: Imply kobj_to_swnode() to be no-op
      software node: Introduce SOFTWARE_NODE_REFERENCE() helper macro
      media: ipu3-cio2: Switch to use SOFTWARE_NODE_REFERENCE()
      PM / wakeup: use dev_set_name() directly

Arnd Bergmann (1):
      devcoredump: avoid -Wempty-body warnings

Bhaskar Chowdhury (1):
      driver core: Trivial typo fix

Colin Ian King (1):
      drivers/base/cpu: remove redundant assignment of variable retval

Dan Carpenter (1):
      node: fix device cleanups in error handling code

Dave Jiang (1):
      driver core: auxiliary bus: Remove unneeded module bits

Greg Kroah-Hartman (6):
      driver core: component: remove dentry pointer in "struct master"
      driver core: dd: remove deferred_devices variable
      Merge 5.12-rc6 into driver-core-next
      Revert "driver core: platform: Make platform_get_irq_optional() optional"
      kobject_uevent: remove warning in init_uevent_argv()
      Merge tag 'v5.12-rc7' into driver-core-next

Heikki Krogerus (1):
      software node: Allow node addition to already existing device

Jia-Ju Bai (1):
      base: dd: fix error return code of driver_sysfs_add()

Jiapeng Chong (1):
      firmware_loader: Remove unnecessary conversion to bool

Kees Cook (1):
      debugfs: Make debugfs_allow RO after init

Matti Vaittinen (10):
      workqueue: Add resource managed version of delayed work init
      MAINTAINERS: Add entry for devm helpers
      extconn: Clean-up few drivers by using managed work init
      hwmon: raspberry-pi: Clean-up few drivers by using managed work init
      platform/x86: gpd pocket fan: Clean-up by using managed work init
      power: supply: Clean-up few drivers by using managed work init
      regulator: qcom_spmi-regulator: Clean-up by using managed work init
      watchdog: retu_wdt: Clean-up by using managed work init
      power: supply: axp20x_usb_power: fix work-queue init
      devm-helpers: Fix devm_delayed_work_autocancel() kerneldoc

Nico Pache (1):
      kunit: software node: adhear to KUNIT formatting standard

Pierre-Louis Bossart (4):
      driver core: remove kernel-doc warnings
      driver core: attribute_container: remove kernel-doc warnings
      platform-msi: fix kernel-doc warnings
      devcoredump: fix kernel-doc warning

Rasmus Villemoes (3):
      devtmpfs: fix placement of complete() call
      devtmpfs: actually reclaim some init memory
      debugfs: drop pointless nul-termination in debugfs_read_file_bool()

Saravana Kannan (5):
      driver core: Avoid pointless deferred probe attempts
      driver core: Update device link status properly for device_bind_driver()
      Revert "Revert "driver core: Set fw_devlink=on by default""
      of: property: fw_devlink: Add support for remote-endpoint
      driver core: Improve fw_devlink & deferred_probe_timeout interaction

Tudor Ambarus (1):
      clk: Mark fwnodes when their clock provider is added

Yogesh Lal (1):
      driver core: Use unbound workqueue for deferred probes

 MAINTAINERS                                     |   6 ++
 drivers/base/attribute_container.c              |   4 +
 drivers/base/auxiliary.c                        |   5 --
 drivers/base/base.h                             |   2 +
 drivers/base/component.c                        |   9 +-
 drivers/base/core.c                             | 112 +++++++++++++++++++++---
 drivers/base/cpu.c                              |   6 +-
 drivers/base/dd.c                               |  48 +++++++---
 drivers/base/devcoredump.c                      |  19 ++--
 drivers/base/devres.c                           |   6 +-
 drivers/base/devtmpfs.c                         |   6 +-
 drivers/base/node.c                             |  26 +++---
 drivers/base/platform-msi.c                     |   3 +-
 drivers/base/platform.c                         |  11 ++-
 drivers/base/power/wakeup_stats.c               |   2 +-
 drivers/base/swnode.c                           | 106 ++++++++++++----------
 drivers/base/test/Kconfig                       |   2 +-
 drivers/base/test/Makefile                      |   2 +-
 drivers/base/test/property-entry-test.c         |  61 ++++++++++---
 drivers/clk/clk.c                               |   2 +
 drivers/extcon/extcon-gpio.c                    |  15 +---
 drivers/extcon/extcon-intel-int3496.c           |  16 +---
 drivers/extcon/extcon-palmas.c                  |  17 ++--
 drivers/extcon/extcon-qcom-spmi-misc.c          |  17 ++--
 drivers/hwmon/raspberrypi-hwmon.c               |  17 ++--
 drivers/media/pci/intel/ipu3/cio2-bridge.c      |   4 +-
 drivers/of/property.c                           |  48 ++++++----
 drivers/platform/x86/gpd-pocket-fan.c           |  17 ++--
 drivers/power/supply/axp20x_usb_power.c         |  17 ++--
 drivers/power/supply/bq24735-charger.c          |  18 ++--
 drivers/power/supply/ltc2941-battery-gauge.c    |  20 ++---
 drivers/power/supply/sbs-battery.c              |  16 ++--
 drivers/regulator/qcom_spmi-regulator.c         |  34 ++-----
 drivers/watchdog/retu_wdt.c                     |  22 ++---
 fs/debugfs/file.c                               |   3 +-
 fs/debugfs/inode.c                              |   2 +-
 include/linux/device.h                          |   6 +-
 include/linux/devm-helpers.h                    |  54 ++++++++++++
 include/linux/platform_device.h                 |   3 +
 include/linux/property.h                        |  13 +--
 lib/kobject_uevent.c                            |   9 +-
 tools/testing/selftests/firmware/fw_namespace.c |   2 +-
 42 files changed, 481 insertions(+), 327 deletions(-)
 create mode 100644 include/linux/devm-helpers.h
