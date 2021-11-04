Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0292445393
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 14:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhKDNNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 09:13:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231616AbhKDNM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 09:12:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4866361053;
        Thu,  4 Nov 2021 13:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636031421;
        bh=cgykf5QDtVlAvPM1gbrt8O+YBRqgR4+YY2SNFP35uM8=;
        h=Date:From:To:Cc:Subject:From;
        b=U1iQ4A4nP8NtSspPmfY/A63BYGocD15L637bHpYNcRX9GZ3lZnObVVN81lYjh06jo
         zbvkvmchqYGE+SYo2zN0aa41f4BbwMLoRp7QdVqzYr9FfAPM1HibtKpdsO8ug/lSIp
         w9Cx3Ojt/G2OFsLWUfSKRk6d6H5no7xmCIqne57c=
Date:   Thu, 4 Nov 2021 14:10:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core changes for 5.16-rc1
Message-ID: <YYPbujTBPoDtuPM1@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 519d81956ee277b4419c723adfb154603c2565ba:

  Linux 5.15-rc6 (2021-10-17 20:00:13 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.16-rc1

for you to fetch changes up to 27e0bcd02990f7291adb0f111e300f06c495d509:

  device property: Drop redundant NULL checks (2021-10-26 19:14:01 +0200)

----------------------------------------------------------------
Driver core changes for 5.16-rc1

Here is the big set of driver core changes for 5.16-rc1.

All of these have been in linux-next for a while now with no reported
problems.

Included in here are:
	- big update and cleanup of the sysfs abi documentation files
	  and scripts from Mauro.  We are almost at the place where we
	  can properly check that the running kernel's sysfs abi is
	  documented fully.
	- firmware loader updates
	- dyndbg updates
	- kernfs cleanups and fixes from Christoph
	- device property updates
	- component fix
	- other minor driver core cleanups and fixes

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andrew Halaney (3):
      dyndbg: make dyndbg a known cli param
      dyndbg: Remove support for ddebug_query param
      Documentation: dyndbg: Improve cli param examples

Andy Shevchenko (5):
      device property: Add missed header in fwnode.h
      driver core: Provide device_match_acpi_handle() helper
      i2c: acpi: Replace custom function with device_match_acpi_handle()
      gpiolib: acpi: Replace custom code with device_match_acpi_handle()
      device property: Drop redundant NULL checks

Borislav Petkov (1):
      x86/microcode: Use the firmware_loader built-in API

Cai Huoqing (1):
      driver core: platform: Make use of the helper macro SET_RUNTIME_PM_OPS()

Christoph Hellwig (5):
      kernfs: remove kernfs_create_file and kernfs_create_file_ns
      kernfs: remove the unused lockdep_key field in struct kernfs_ops
      sysfs: split out binary attribute handling from sysfs_add_file_mode_ns
      sysfs: refactor sysfs_add_file_mode_ns
      sysfs: simplify sysfs_kf_seq_show

Douglas Anderson (1):
      driver core: Clarify that dev_err_probe() is OK even w/out -EPROBE_DEFER

Greg Kroah-Hartman (2):
      Merge 5.15-rc4 into driver-core-next
      Merge 5.15-rc6 into driver-core-next

Jim Cromie (5):
      dyndbg: show module in vpr-info in dd-exec-queries
      dyndbg: vpr-info on remove-module complete, not starting
      dyndbg: no vpr-info on empty queries
      dyndbg: fix spurious vNpr_info change
      dyndbg: refine verbosity 1-4 summary-detail

Kai Vehmanen (1):
      component: do not leave master devres group open after bind

Luis Chamberlain (10):
      fs/kernfs/symlink.c: replace S_IRWXUGO with 0777 on kernfs_create_link()
      firmware_loader: fix pre-allocated buf built-in firmware use
      firmware_loader: split built-in firmware call
      firmware_loader: add a sanity check for firmware_request_builtin()
      fs/sysfs/dir.c: replace S_IRWXU|S_IRUGO|S_IXUGO with 0755 sysfs_create_dir_ns()
      firmware_loader: formalize built-in firmware API
      firmware_loader: remove old DECLARE_BUILTIN_FIRMWARE()
      firmware_loader: move struct builtin_fw to the only place used
      vmlinux.lds.h: wrap built-in firmware support under FW_LOADER
      x86/build: Tuck away built-in firmware under FW_LOADER

Mauro Carvalho Chehab (84):
      ABI: sysfs-bus-usb: better document variable argument
      ABI: sysfs-tty: better document module name parameter
      ABI: sysfs-kernel-slab: use a wildcard for the cache name
      ABI: security: fix location for evm and ima_policy
      ABI: sysfs-class-tpm: use wildcards for pcr-* nodes
      ABI: sysfs-bus-rapidio: use wildcards on What definitions
      ABI: sysfs-class-cxl: place "not in a guest" at description
      ABI: sysfs-class-devfreq-event: use the right wildcards on What
      ABI: sysfs-class-mic: use the right wildcards on What definitions
      ABI: pstore: Fix What field
      ABI: sysfs-class-typec: fix a typo on a What field
      ABI: sysfs-ata: use a proper wildcard for ata_*
      ABI: sysfs-class-infiniband: use wildcards on What definitions
      ABI: sysfs-bus-pci: use wildcards on What definitions
      ABI: sysfs-bus-soundwire-master: use wildcards on What definitions
      ABI: sysfs-bus-soundwire-slave: use wildcards on What definitions
      ABI: sysfs-class-gnss: use wildcards on What definitions
      ABI: sysfs-class-mei: use wildcards on What definitions
      ABI: sysfs-class-mux: use wildcards on What definitions
      ABI: sysfs-class-pwm: use wildcards on What definitions
      ABI: sysfs-class-rc: use wildcards on What definitions
      ABI: sysfs-class-rc-nuvoton: use wildcards on What definitions
      ABI: sysfs-class-uwb_rc: use wildcards on What definitions
      ABI: sysfs-class-uwb_rc-wusbhc: use wildcards on What definitions
      ABI: sysfs-devices-platform-dock: use wildcards on What definitions
      ABI: sysfs-devices-system-cpu: use wildcards on What definitions
      ABI: sysfs-firmware-efi-esrt: use wildcards on What definitions
      ABI: sysfs-platform-sst-atom: use wildcards on What definitions
      ABI: sysfs-ptp: use wildcards on What definitions
      ABI: sysfs-class-rapidio: use wildcards on What definitions
      scripts: get_abi.pl: Better handle multiple What parameters
      scripts: get_abi.pl: Check for missing symbols at the ABI specs
      scripts: get_abi.pl: detect softlinks
      scripts: get_abi.pl: add an option to filter undefined results
      scripts: get_abi.pl: don't skip what that ends with wildcards
      scripts: get_abi.pl: Ignore fs/cgroup sysfs nodes earlier
      scripts: get_abi.pl: add a graph to speedup the undefined algorithm
      scripts: get_abi.pl: Fix get_abi.pl search output
      scripts: get_abi.pl: call get_leave() a little late
      scripts: get_abi.pl: improve debug logic
      scripts: get_abi.pl: Better handle leaves with wildcards
      scripts: get_abi.pl: ignore some sysfs nodes earlier
      scripts: get_abi.pl: stop check loop earlier when regex is found
      scripts: get_abi.pl: precompile what match regexes
      scripts: get_abi.pl: ensure that "others" regex will be parsed
      scripts: get_abi.pl: create a valid ReST with duplicated tags
      ABI: sysfs-platform-dell-privacy-wmi: correct ABI entries
      ABI: sysfs-platform-dptf: Add tables markup to a table
      ABI: configfs-usb-gadget-uac1: fix a broken table
      ABI: configfs-usb-gadget-uac2: fix a broken table
      ABI: sysfs-devices-removable: make a table valid as ReST markup
      ABI: sysfs-platform-intel-pmc: add blank lines to make it valid for ReST
      scripts: get_abi.pl: produce an error if the ref tree is broken
      scripts: get_abi.pl: fix parse logic for DT firmware
      scripts: get_abi.pl: update its documentation
      scripts: get_abi.pl: use STDERR for search-string and show-hints
      scripts: get_abi.pl: show progress
      ABI: evm: place a second what at the next line
      ABI: stable/sysfs-module: better document modules
      ABI: stable/sysfs-module: document version and srcversion
      ABI: testing/sysfs-module: document initstate
      ABI: sysfs-devices-power: document some RPM statistics
      ABI: sysfs-devices: add /dev ABI
      ABI: sysfs-bus-pci: add documentation for modalias
      ABI: o2cb: add an obsolete file for /sys/o2cb
      ABI: sysfs-kernel-slab: Document some stats
      ABI: sysfs-devices-power: add some debug sysfs files
      ABI: sysfs-bus-pci: add a alternative What fields
      ABI: sysfs-class-bdi: use What: to describe each property
      ABI: sysfs-bus-mdio: add alternate What for mdio symbols
      ABI: sysfs-bus-usb: use a wildcard for interface name on What
      ABI: sysfs-bus-usb: add missing sysfs fields
      ABI: obsolete/sysfs-bus-iio: add some missing blank lines
      ABI: sysfs-driver-ufs: Add another What for platform drivers
      ABI: sysfs-bus-platform: add modalias description
      scripts: get_abi.pl: make undefined search more deterministic
      scripts: get_abi.pl: fix fallback rule for undefined symbols
      scripts: get_abi.pl: better generate regex from what fields
      ABI: sysfs-mce: add a new ABI file
      ABI: sysfs-mce: add 3 missing files
      ABI: sysfs-class-hwmon: add ABI documentation for it
      ABI: sysfs-class-hwmon: add a description for tempY_crit_alarm
      ABI: sysfs-class-extcon: use uppercase X for wildcards
      ABI: sysfs-devices-system-cpu: use cpuX instead of cpu#

Max Gurtovoy (2):
      driver core: use NUMA_NO_NODE during device_initialize
      PCI/sysfs: use NUMA_NO_NODE macro

Mianhan Liu (2):
      drivers/base/arch_topology.c: remove superfluous header
      drivers/base/component.c: remove superfluous header files from component.c

Qu Wenruo (1):
      kobject: unexport kobject_create() in kobject.h

Yang Yingliang (1):
      driver core: Fix possible memory leak in device_link_add()

 Documentation/ABI/obsolete/o2cb                    |  11 +
 Documentation/ABI/obsolete/sysfs-bus-iio           |   4 +
 Documentation/ABI/stable/o2cb                      |   2 +-
 Documentation/ABI/stable/sysfs-class-infiniband    |  64 +-
 Documentation/ABI/stable/sysfs-class-tpm           |   2 +-
 Documentation/ABI/stable/sysfs-devices             |   7 +
 Documentation/ABI/stable/sysfs-module              |  25 +-
 Documentation/ABI/testing/configfs-usb-gadget-uac1 |  42 +-
 Documentation/ABI/testing/configfs-usb-gadget-uac2 |  43 +-
 Documentation/ABI/testing/evm                      |   5 +-
 Documentation/ABI/testing/ima_policy               |   2 +-
 Documentation/ABI/testing/pstore                   |   3 +-
 Documentation/ABI/testing/sysfs-ata                |   2 +-
 Documentation/ABI/testing/sysfs-bus-mdio           |   9 +
 Documentation/ABI/testing/sysfs-bus-pci            |  24 +-
 Documentation/ABI/testing/sysfs-bus-platform       |  12 +
 Documentation/ABI/testing/sysfs-bus-rapidio        |  32 +-
 .../ABI/testing/sysfs-bus-soundwire-master         |  20 +-
 .../ABI/testing/sysfs-bus-soundwire-slave          |  62 +-
 Documentation/ABI/testing/sysfs-bus-usb            | 292 ++++++-
 Documentation/ABI/testing/sysfs-class-bdi          |  30 +-
 Documentation/ABI/testing/sysfs-class-cxl          |  15 +-
 .../ABI/testing/sysfs-class-devfreq-event          |  12 +-
 Documentation/ABI/testing/sysfs-class-extcon       |  12 +-
 Documentation/ABI/testing/sysfs-class-gnss         |   2 +-
 Documentation/ABI/testing/sysfs-class-hwmon        | 932 +++++++++++++++++++++
 Documentation/ABI/testing/sysfs-class-mei          |  18 +-
 Documentation/ABI/testing/sysfs-class-mic          |  24 +-
 Documentation/ABI/testing/sysfs-class-mux          |   2 +-
 Documentation/ABI/testing/sysfs-class-pwm          |  20 +-
 Documentation/ABI/testing/sysfs-class-rapidio      |   4 +-
 Documentation/ABI/testing/sysfs-class-rc           |  14 +-
 Documentation/ABI/testing/sysfs-class-rc-nuvoton   |   2 +-
 Documentation/ABI/testing/sysfs-class-typec        |   2 +-
 Documentation/ABI/testing/sysfs-class-uwb_rc       |  26 +-
 .../ABI/testing/sysfs-class-uwb_rc-wusbhc          |  10 +-
 .../ABI/testing/sysfs-devices-platform-dock        |  10 +-
 Documentation/ABI/testing/sysfs-devices-power      |  36 +
 Documentation/ABI/testing/sysfs-devices-removable  |   8 +-
 Documentation/ABI/testing/sysfs-devices-system-cpu |  68 +-
 Documentation/ABI/testing/sysfs-driver-ufs         | 126 +++
 Documentation/ABI/testing/sysfs-firmware-efi-esrt  |  16 +-
 Documentation/ABI/testing/sysfs-kernel-slab        | 115 +--
 Documentation/ABI/testing/sysfs-mce                | 129 +++
 Documentation/ABI/testing/sysfs-module             |   7 +
 .../ABI/testing/sysfs-platform-dell-privacy-wmi    |  60 +-
 Documentation/ABI/testing/sysfs-platform-dptf      |   4 +
 Documentation/ABI/testing/sysfs-platform-intel-pmc |   2 +
 Documentation/ABI/testing/sysfs-platform-sst-atom  |   2 +-
 Documentation/ABI/testing/sysfs-ptp                |  30 +-
 Documentation/ABI/testing/sysfs-tty                |  32 +-
 Documentation/admin-guide/dynamic-debug-howto.rst  |  15 +-
 Documentation/admin-guide/kernel-parameters.txt    |   5 -
 Documentation/hwmon/sysfs-interface.rst            | 596 +------------
 Documentation/x86/x86_64/machinecheck.rst          |  56 +-
 MAINTAINERS                                        |   3 +
 arch/x86/include/asm/microcode.h                   |   3 -
 arch/x86/kernel/cpu/microcode/amd.c                |  14 +-
 arch/x86/kernel/cpu/microcode/core.c               |  17 -
 arch/x86/kernel/cpu/microcode/intel.c              |   9 +-
 arch/x86/tools/relocs.c                            |   2 +
 drivers/base/arch_topology.c                       |   3 -
 drivers/base/component.c                           |   6 +-
 drivers/base/core.c                                |  17 +-
 drivers/base/firmware_loader/builtin/Makefile      |   6 +-
 drivers/base/firmware_loader/builtin/main.c        | 106 +++
 drivers/base/firmware_loader/firmware.h            |  17 +
 drivers/base/firmware_loader/main.c                |  65 +-
 drivers/base/platform.c                            |   3 +-
 drivers/base/swnode.c                              |   6 -
 drivers/gpio/gpiolib-acpi.c                        |   5 +-
 drivers/i2c/i2c-core-acpi.c                        |  22 +-
 drivers/pci/pci-sysfs.c                            |   6 +-
 fs/kernfs/symlink.c                                |   3 +-
 fs/sysfs/dir.c                                     |   3 +-
 fs/sysfs/file.c                                    | 140 ++--
 fs/sysfs/group.c                                   |  15 +-
 fs/sysfs/sysfs.h                                   |   8 +-
 include/asm-generic/vmlinux.lds.h                  |  20 +-
 include/linux/device/bus.h                         |   1 +
 include/linux/firmware.h                           |  30 +-
 include/linux/fwnode.h                             |   1 +
 include/linux/kernfs.h                             |  28 -
 include/linux/kobject.h                            |   1 -
 lib/dynamic_debug.c                                |  60 +-
 lib/kobject.c                                      |   2 +-
 scripts/get_abi.pl                                 | 493 ++++++++++-
 87 files changed, 2893 insertions(+), 1327 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/o2cb
 create mode 100644 Documentation/ABI/testing/sysfs-class-hwmon
 create mode 100644 Documentation/ABI/testing/sysfs-mce
 create mode 100644 drivers/base/firmware_loader/builtin/main.c
