Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6202A324092
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236841AbhBXPOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:14:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:33836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235271AbhBXO17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:27:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A01864DD3;
        Wed, 24 Feb 2021 14:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614176836;
        bh=uOdHsmtI9sIVF/MIaSrHy/NrBC5eLRT2RwnY2Aqxmjo=;
        h=Date:From:To:Cc:Subject:From;
        b=JQrJd1LNmr98RItbV9vH1WSN64EqD3oi5kAAiejNpw6Mxx2c7B+aQ0HScJggyFDJZ
         alhV+hHEMzmpnRjaZ/WXoRSI25XzpBICziqaCxDTjakSx37eHmRrjMNTEkovAeIHQl
         /vEjI39kWMjxlwgGxgrqjpdH1Y7dsnbVbMvcz2t8=
Date:   Wed, 24 Feb 2021 15:27:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core / debugfs changes for 5.12-rc1
Message-ID: <YDZiQoP8h/QDSNkJ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04:

  Linux 5.11-rc5 (2021-01-24 16:47:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.12-rc1

for you to fetch changes up to 3e4c982f1ce75faf5314477b8da296d2d00919df:

  Revert "driver core: Set fw_devlink=on by default" (2021-02-19 08:51:04 +0100)

----------------------------------------------------------------
Driver core / debugfs update for 5.12-rc1

Here is the "big" driver core and debugfs update for 5.12-rc1

This set of driver core patches caused a bunch of problems in linux-next
for the past few weeks, when Saravana tried to set fw_devlink=on as the
default functionality.  This caused a number of systems to stop booting,
and lots of bugs were fixed in this area for almost all of the reported
systems, but this option is not ready to be turned on just yet for the
default operation based on this testing, so I've reverted that change at
the very end so we don't have to worry about regressions in 5.12.  We
will try to turn this on for 5.13 if testing goes better over the next
few months.

Other than the fixes caused by the fw_devlink testing in here, there's
not much more:
	- debugfs fixes for invalid input into debugfs_lookup()
	- kerneldoc cleanups
	- warn message if platform drivers return an error on their
	  remove callback (a futile effort, but good to catch).

All of these have been in linux-next for a while now, and the
regressions have gone away with the revert of the fw_devlink change.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Arnd Bergmann (1):
      drivers/base: build kunit tests without structleak plugin

Bhaskar Chowdhury (1):
      drivers: base: power: Fix resposible -> responsible in runtime.c

Colin Ian King (1):
      drivers: base: Kconfig: fix spelling mistake "heterogenous" -> "heterogeneous"

Dave Jiang (1):
      driver core: auxiliary bus: Fix calling stage for auxiliary bus init

Furquan Shaikh (1):
      drivers: core: Detach device from power domain on shutdown

Geert Uytterhoeven (1):
      device.h: Remove bogus "the" in kerneldoc

Greg Kroah-Hartman (5):
      Revert "drivers: core: Detach device from power domain on shutdown"
      Merge 5.11-rc5 into driver-core-next
      debugfs: be more robust at handling improper input in debugfs_lookup()
      debugfs: do not attempt to create a new file before the filesystem is initalized
      Revert "driver core: Set fw_devlink=on by default"

Joe Pater (2):
      drivers: base: remove unused function find_bus()
      drivers: base: change 'driver_create_groups' to 'driver_add_groups' in printk

Saravana Kannan (20):
      driver core: Add debug logs for device link related probe deferrals
      driver core: Add device link support for INFERRED flag
      driver core: Have fw_devlink use DL_FLAG_INFERRED
      driver core: Handle cycles in device links created by fw_devlink
      driver core: Set fw_devlink=on by default
      of: property: Add fw_devlink support for "gpio" and "gpios" binding
      of: property: Add fw_devlink support for interrupts
      gpiolib: Bind gpio_device to a driver to enable fw_devlink=on by default
      gpiolib: Don't probe gpio_device if it's not the primary device
      of: property: Fix fw_devlink handling of interrupts/interrupts-extended
      driver core: fw_devlink: Detect supplier devices that will never be added
      of: property: Don't add links to absent suppliers
      driver core: Add fw_devlink.strict kernel param
      of: property: Add fw_devlink support for optional properties
      driver core: fw_devlink: Handle suppliers that don't use driver core
      irqdomain: Mark fwnodes when their irqdomain is added/removed
      PM: domains: Mark fwnodes when their powerdomain is added/removed
      clk: Mark fwnodes when their clock provider is added/removed
      of: irq: Fix the return value for of_irq_parse_one() stub
      of: property: fw_devlink: Ignore interrupts property for some configs

Stephen Rothwell (1):
      of: irq: make a stub for of_irq_parse_one()

Uwe Kleine-König (1):
      driver core: platform: Emit a warning if a remove callback returned non-zero

kernel test robot (1):
      driver core: fw_devlink_relax_cycle() can be static

 Documentation/admin-guide/kernel-parameters.txt |   5 +
 drivers/base/Kconfig                            |   2 +-
 drivers/base/auxiliary.c                        |  13 +-
 drivers/base/base.h                             |   5 +
 drivers/base/bus.c                              |  19 +--
 drivers/base/core.c                             | 159 +++++++++++++++++++++---
 drivers/base/init.c                             |   1 +
 drivers/base/platform.c                         |  11 +-
 drivers/base/power/domain.c                     |   2 +
 drivers/base/power/runtime.c                    |   2 +-
 drivers/base/test/Makefile                      |   1 +
 drivers/clk/clk.c                               |   3 +
 drivers/gpio/gpiolib-of.c                       |  11 ++
 drivers/gpio/gpiolib-of.h                       |   5 +
 drivers/gpio/gpiolib.c                          |  52 ++++++--
 drivers/of/property.c                           |  59 +++++++--
 fs/debugfs/inode.c                              |   5 +-
 include/linux/device.h                          |   2 +
 include/linux/device/driver.h                   |   2 +-
 include/linux/fwnode.h                          |  20 ++-
 include/linux/of_irq.h                          |   9 +-
 kernel/irq/irqdomain.c                          |   2 +
 22 files changed, 321 insertions(+), 69 deletions(-)
