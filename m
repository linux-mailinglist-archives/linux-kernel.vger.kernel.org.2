Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6A93B6618
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbhF1Pw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236490AbhF1Pwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:52:40 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAF0C07AF09;
        Mon, 28 Jun 2021 08:31:29 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9291C301;
        Mon, 28 Jun 2021 15:31:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9291C301
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1624894288; bh=JrLmw0/UttQmSUm8W2Agz6/QM+N81ydy6EsFVzrY2wM=;
        h=From:To:Cc:Subject:Date:From;
        b=B3Db9Wo+5OxYOf4mT2jQspqINZhg+4Sm4tMKZfVD5RYvwzYCXuNFtVeAk42zdct9X
         R/FbUshf2WYNTD2R1L93C8EAn/vYNe2ZLhgLGfr6sWPrhSqzyNa+W6dyXPlmjiecZS
         8Jt04UkHo9daRMe3rF0u8a5kSvRQPKpzhon6YJZqh97+4uWtxOgVxav19BDiR+dWqd
         6dZ9lLA+ETlLF7HjLeG9LzbBPY96boXE55L6+xO+seUbXYLDCuNpBfwFXq8QA97nwv
         SpKqM+yNA/2155FMKV2IQoeE+fZLAmC6CYpMXlz1+7IxyMsGndaBrujmsQL+UL0zAs
         9jyu328XmsmWw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation for 5.14
Date:   Mon, 28 Jun 2021 09:31:27 -0600
Message-ID: <87czs6ypio.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7240cd200541543008a7ce4fcaf2ba5a5556128f:

  Remove link to nonexistent rocket driver docs (2021-05-11 11:02:39 -0600)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.14

for you to fetch changes up to 98cf4951842adbb03079dadedddf30b95e623cb0:

  Merge branch 'path-lookup' into docs-next (2021-06-18 11:37:35 -0600)

----------------------------------------------------------------
This was a reasonably active cycle for documentation; this pull includes:

 - Some kernel-doc cleanups.  That script is still regex onslaught from
   hell, but it has gotten a little better.

 - Improvements to the checkpatch docs, which are also used by the tool
   itself.

 - A major update to the pathname lookup documentation.

 - Elimination of :doc: markup, since our automarkup magic can create
   references from filenames without all the extra noise.

 - The flurry of Chinese translation activity continues.

Plus, of course, the usual collection of updates, typo fixes, and warning
fixes.

Expect a couple of minor conflicts as usual; the linux-next resolutions
are correct.

----------------------------------------------------------------
Aditya Srivastava (1):
      scripts: kernel-doc: reduce repeated regex expressions into variables

Akira Yokosawa (2):
      docs: Activate exCJK only in CJK chapters
      docs: pdfdocs: Prevent column squeezing by tabulary

Andrew Jeffery (1):
      Documentation: checkpatch: Tweak BIT() macro include

Baoquan He (1):
      Documentation: kdump: update kdump guide

Barry Song (1):
      docs: kernel-parameters: mark numa=off is supported by a bundle of architectures

Carlos Bilbao (1):
      docs: typo fixes in Documentation/ABI/

Carlos Llamas (1):
      docs: printk-formats: update size-casting examples

Chun-Hung Tseng (1):
      Documentation: scheduler: fixed 2 typos in sched-nice-design.rst

Colin Ian King (1):
      tools: Fix "the the" in a message in kernel-chktaint

Dwaipayan Ray (2):
      docs: Add more message type documentations for checkpatch
      docs: checkpatch: Document and segregate more checkpatch message types

Fox Chen (13):
      docs: path-lookup: update follow_managed() part
      docs: path-lookup: update path_to_nameidata() part
      docs: path-lookup: update path_mountpoint() part
      docs: path-lookup: update do_last() part
      docs: path-lookup: remove filename_mountpoint
      docs: path-lookup: Add macro name to symlink limit description
      docs: path-lookup: i_op->follow_link replaced with i_op->get_link
      docs: path-lookup: update i_op->put_link and cookie description
      docs: path-lookup: no get_link()
      docs: path-lookup: update WALK_GET, WALK_PUT desc
      docs: path-lookup: update get_link() ->follow_link description
      docs: path-lookup: update symlink description
      docs: path-lookup: use bare function() rather than literals

Gao Mingfei (1):
      docs: block: fix stat.rst document error

Hailong Liu (1):
      docs/zh_CN: Add zh_CN/admin-guide/lockup-watchdogs.rst

Hao Chen (1):
      Documentation: ACPI: fix error script name

Haocheng Xie (1):
      docs: Fix typos in Documentation/trace/ftrace.rst

Igor Matheus Andrade Torrente (1):
      docs: convert dax.txt to rst

Jonathan Corbet (3):
      Merge branch 'mauro' into docs-next
      docs: Take a little noise out of the build process
      Merge branch 'path-lookup' into docs-next

Kees Cook (2):
      docs: networking: Replace strncpy() with strscpy()
      docs: Makefile: Use CONFIG_SHELL not SHELL

Kir Kolyshkin (1):
      docs: fix a cross-ref

Mauro Carvalho Chehab (50):
      docs: update sysfs-platform_profile.rst reference
      docs: vcpu-requests.rst: fix reference for atomic ops
      docs: translations/zh_CN: fix a typo at 8.Conclusion.rst
      docs: sched-bwc.rst: fix a typo on a doc name
      docs: update pin-control.rst references
      docs: virt: api.rst: fix a pointer to SGX documentation
      docs: ABI: iommu: remove duplicated definition for sysfs-kernel-iommu_groups
      docs: ABI: sysfs-class-backlight: unify ambient light zone nodes
      docs: ABI: sysfs-class-led-trigger-pattern: remove repeat duplication
      iio: ABI: sysfs-bus-iio: fix a typo
      iio: ABI: sysfs-bus-iio: avoid a warning when doc is built
      scripts: sphinx-pre-install: rework the sphinx install logic
      scripts: sphinx-pre-install: fix the need of virtenv packages
      docs: admin-guide: reporting-issues.rst: replace some characters
      docs: trace: coresight: coresight-etm4x-reference.rst: replace some characters
      docs: driver-api: ioctl.rst: replace some characters
      docs: usb: replace some characters
      docs: vm: zswap.rst: replace some characters
      docs: filesystems: ext4: blockgroup.rst: replace some characters
      docs: networking: device_drivers: replace some characters
      docs: PCI: Replace non-breaking spaces to avoid PDF issues
      docs: devices.rst: better reference documentation docs
      docs: dev-tools: kunit: don't use a table for docs name
      docs: admin-guide: pm: avoid using ReST :doc:`foo` markup
      docs: admin-guide: hw-vuln: avoid using ReST :doc:`foo` markup
      docs: admin-guide: sysctl: avoid using ReST :doc:`foo` markup
      docs: block: biodoc.rst: avoid using ReST :doc:`foo` markup
      docs: bpf: bpf_lsm.rst: avoid using ReST :doc:`foo` markup
      docs: core-api: avoid using ReST :doc:`foo` markup
      docs: dev-tools: testing-overview.rst: avoid using ReST :doc:`foo` markup
      docs: dev-tools: kunit: avoid using ReST :doc:`foo` markup
      docs: devicetree: bindings: submitting-patches.rst: avoid using ReST :doc:`foo` markup
      docs: doc-guide: avoid using ReST :doc:`foo` markup
      docs: driver-api: avoid using ReST :doc:`foo` markup
      docs: driver-api: gpio: using-gpio.rst: avoid using ReST :doc:`foo` markup
      docs: driver-api: surface_aggregator: avoid using ReST :doc:`foo` markup
      docs: driver-api: usb: avoid using ReST :doc:`foo` markup
      docs: firmware-guide: acpi: avoid using ReST :doc:`foo` markup
      docs: i2c: avoid using ReST :doc:`foo` markup
      docs: kernel-hacking: hacking.rst: avoid using ReST :doc:`foo` markup
      docs: networking: devlink: avoid using ReST :doc:`foo` markup
      docs: PCI: endpoint: pci-endpoint-cfs.rst: avoid using ReST :doc:`foo` markup
      docs: PCI: pci.rst: avoid using ReST :doc:`foo` markup
      docs: process: submitting-patches.rst: avoid using ReST :doc:`foo` markup
      docs: security: landlock.rst: avoid using ReST :doc:`foo` markup
      docs: trace: coresight: coresight.rst: avoid using ReST :doc:`foo` markup
      docs: trace: ftrace.rst: avoid using ReST :doc:`foo` markup
      docs: userspace-api: landlock.rst: avoid using ReST :doc:`foo` markup
      docs: virt: kvm: s390-pv-boot.rst: avoid using ReST :doc:`foo` markup
      docs: x86: avoid using ReST :doc:`foo` markup

Nobuhiro Iwamatsu (1):
      docs: Fix typo in Documentation/arm/marvell.rst

Rasmus Villemoes (1):
      docs: admin-guide: update description for kernel.hotplug sysctl

Rob Herring (1):
      documentation-file-ref-check: Make git check work for multiple working directories

Tian Tao (1):
      docs: cputopology: move the sysfs ABI description to right place

Tiezhu Yang (2):
      samples/kprobes: Fix typo in handler_fault()
      samples/kprobes: Fix typo in handler_post()

Wan Jiabing (1):
      docs/zh_CN: add translations in zh_CN/dev-tools/kasan

Wei Ming Chen (2):
      docs: usb: function: Modify path name
      docs: Use fallthrough pseudo-keyword

Wolfram Sang (1):
      docs: fault-injection: fix non-working usage of negative values

Wu XiangCheng (6):
      docs/zh_CN: Add translation zh_CN/maintainer/index.rst
      docs/zh_CN: Add translation zh_CN/maintainer/configure-git.rst
      docs/zh_CN: Add translation zh_CN/maintainer/rebasing-and-merging.rst
      docs/zh_CN: Add translation zh_CN/maintainer/pull-requests.rst
      docs/zh_CN: Add translation zh_CN/maintainer/maintainer-entry-profile.rst
      docs/zh_CN: Add translation zh_CN/maintainer/modifying-patches.rst

Yanteng Si (14):
      docs/zh_CN: add core-api kernel-api.rst translation
      docs/zh_CN: add core-api printk-basics.rst translation
      docs/zh_CN: add core-api printk-formats.rst translation
      docs/zh_CN: add core-api workqueue.rst translation
      docs/zh_CN: add core api kobject translation
      docs/zh_CN: add parisc index translation
      docs/zh_CN: add parisc debugging.rst translation
      docs/zh_CN: add parisc registers.rst translation
      docs/zh_CN:add core-api refcount-vs-atomic.rst translation.
      docs/zh_CN: add core api local_ops.rst translation
      docs: zh_CN: update Chinese translations
      docs/zh_CN: add core-api symbol-namespaces.rst translation
      docs/zh_CN:add core-api padata translation
      docs/zh_CN: add core api cachetlb translation

Yue Hu (1):
      docs: block: blk-mq.rst: correct drive -> driver

 Documentation/ABI/obsolete/sysfs-cpuidle           |   2 +-
 Documentation/ABI/removed/sysfs-kernel-uids        |   2 +-
 Documentation/ABI/stable/sysfs-bus-vmbus           |   2 +-
 Documentation/ABI/stable/sysfs-bus-xen-backend     |   2 +-
 Documentation/ABI/stable/sysfs-devices-system-cpu  |  83 +++
 Documentation/ABI/stable/sysfs-driver-dma-idxd     |   2 +-
 Documentation/ABI/stable/sysfs-driver-mlxreg-io    |   4 +-
 Documentation/ABI/testing/configfs-iio             |   2 +-
 Documentation/ABI/testing/configfs-most            |   8 +-
 Documentation/ABI/testing/configfs-usb-gadget      |   2 +-
 Documentation/ABI/testing/configfs-usb-gadget-uvc  |   4 +-
 Documentation/ABI/testing/debugfs-driver-genwqe    |   2 +-
 .../ABI/testing/debugfs-driver-habanalabs          |   2 +-
 Documentation/ABI/testing/sysfs-bus-fsi            |   2 +-
 Documentation/ABI/testing/sysfs-bus-iio            |   6 +-
 Documentation/ABI/testing/sysfs-bus-pci            |   4 +-
 Documentation/ABI/testing/sysfs-class-backlight    | 100 ++++
 .../ABI/testing/sysfs-class-backlight-adp5520      |  31 --
 .../ABI/testing/sysfs-class-backlight-adp8860      |  37 --
 .../testing/sysfs-class-backlight-driver-adp8870   |  32 --
 .../ABI/testing/sysfs-class-led-driver-el15203000  |   9 -
 .../ABI/testing/sysfs-class-led-trigger-pattern    |   3 +
 Documentation/ABI/testing/sysfs-devices-system-cpu |  10 +-
 Documentation/ABI/testing/sysfs-driver-ufs         |   4 +-
 Documentation/ABI/testing/sysfs-fs-f2fs            |   2 +-
 .../ABI/testing/sysfs-kernel-iommu_groups          |  12 +-
 Documentation/Makefile                             |   2 +-
 Documentation/PCI/acpi-info.rst                    |  18 +-
 Documentation/PCI/endpoint/pci-endpoint-cfs.rst    |   2 +-
 Documentation/PCI/pci.rst                          |   6 +-
 Documentation/admin-guide/cputopology.rst          |  85 +--
 Documentation/admin-guide/ext4.rst                 |   2 +-
 .../special-register-buffer-data-sampling.rst      |   3 +-
 Documentation/admin-guide/kdump/kdump.rst          | 170 +++---
 Documentation/admin-guide/kernel-parameters.txt    |   3 +
 Documentation/admin-guide/pm/intel_idle.rst        |  16 +-
 Documentation/admin-guide/pm/intel_pstate.rst      |   9 +-
 Documentation/admin-guide/reporting-issues.rst     |   2 +-
 Documentation/admin-guide/sysctl/abi.rst           |   2 +-
 Documentation/admin-guide/sysctl/kernel.rst        |  44 +-
 Documentation/arm/marvell.rst                      |   2 +-
 Documentation/block/biodoc.rst                     |   2 +-
 Documentation/block/blk-mq.rst                     |   4 +-
 Documentation/block/stat.rst                       |   2 +-
 Documentation/bpf/bpf_lsm.rst                      |  13 +-
 Documentation/conf.py                              |  24 +-
 Documentation/core-api/bus-virt-phys-mapping.rst   |   2 +-
 Documentation/core-api/dma-api.rst                 |   5 +-
 Documentation/core-api/dma-isa-lpc.rst             |   2 +-
 Documentation/core-api/index.rst                   |   4 +-
 Documentation/core-api/printk-formats.rst          |   9 +-
 Documentation/dev-tools/checkpatch.rst             | 509 ++++++++++++++++--
 Documentation/dev-tools/kunit/api/index.rst        |   8 +-
 Documentation/dev-tools/kunit/faq.rst              |   2 +-
 Documentation/dev-tools/kunit/index.rst            |  14 +-
 Documentation/dev-tools/kunit/start.rst            |   4 +-
 Documentation/dev-tools/kunit/tips.rst             |   5 +-
 Documentation/dev-tools/kunit/usage.rst            |   8 +-
 Documentation/dev-tools/testing-overview.rst       |  18 +-
 .../devicetree/bindings/submitting-patches.rst     |  11 +-
 Documentation/doc-guide/contributing.rst           |   8 +-
 Documentation/driver-api/acpi/linuxized-acpica.rst |   2 +-
 Documentation/driver-api/gpio/using-gpio.rst       |   4 +-
 Documentation/driver-api/ioctl.rst                 |  10 +-
 Documentation/driver-api/pm/devices.rst            |   8 +-
 .../surface_aggregator/clients/index.rst           |   3 +-
 .../driver-api/surface_aggregator/internal.rst     |  15 +-
 .../driver-api/surface_aggregator/overview.rst     |   6 +-
 Documentation/driver-api/usb/dma.rst               |   6 +-
 Documentation/fault-injection/fault-injection.rst  |  24 +-
 Documentation/filesystems/dax.rst                  | 291 ++++++++++
 Documentation/filesystems/dax.txt                  | 257 ---------
 Documentation/filesystems/ext2.rst                 |   2 +-
 Documentation/filesystems/ext4/blockgroup.rst      |   2 +-
 Documentation/filesystems/index.rst                |   1 +
 Documentation/filesystems/path-lookup.rst          | 194 +++----
 .../acpi/dsd/data-node-references.rst              |   3 +-
 Documentation/firmware-guide/acpi/dsd/graph.rst    |   2 +-
 Documentation/firmware-guide/acpi/enumeration.rst  |   7 +-
 Documentation/i2c/instantiating-devices.rst        |   2 +-
 Documentation/i2c/old-module-parameters.rst        |   3 +-
 Documentation/i2c/smbus-protocol.rst               |   4 +-
 Documentation/input/joydev/joystick-api.rst        |   2 +-
 Documentation/kernel-hacking/hacking.rst           |   4 +-
 .../device_drivers/ethernet/intel/i40e.rst         |   6 +-
 .../device_drivers/ethernet/intel/iavf.rst         |   2 +-
 .../networking/devlink/devlink-region.rst          |   2 +-
 Documentation/networking/devlink/devlink-trap.rst  |   4 +-
 Documentation/networking/packet_mmap.rst           |   2 +-
 Documentation/networking/tuntap.rst                |   2 +-
 Documentation/process/submitting-patches.rst       |  32 +-
 Documentation/scheduler/sched-bwc.rst              |   2 +-
 Documentation/scheduler/sched-nice-design.rst      |   2 +-
 Documentation/security/landlock.rst                |   3 +-
 .../trace/coresight/coresight-etm4x-reference.rst  |   2 +-
 Documentation/trace/coresight/coresight.rst        |   8 +-
 Documentation/trace/ftrace.rst                     |   6 +-
 Documentation/translations/index.rst               |   4 +
 Documentation/translations/it_IT/index.rst         |   4 +
 .../translations/it_IT/process/coding-style.rst    |   2 +-
 Documentation/translations/ja_JP/index.rst         |   5 +-
 Documentation/translations/ko_KR/index.rst         |   5 +-
 .../translations/zh_CN/admin-guide/index.rst       |   2 +-
 .../zh_CN/admin-guide/lockup-watchdogs.rst         |  66 +++
 .../translations/zh_CN/core-api/cachetlb.rst       | 336 ++++++++++++
 .../translations/zh_CN/core-api/index.rst          |  24 +-
 .../translations/zh_CN/core-api/kernel-api.rst     | 369 +++++++++++++
 .../translations/zh_CN/core-api/kobject.rst        | 378 +++++++++++++
 .../translations/zh_CN/core-api/local_ops.rst      | 194 +++++++
 .../translations/zh_CN/core-api/padata.rst         | 158 ++++++
 .../translations/zh_CN/core-api/printk-basics.rst  | 110 ++++
 .../translations/zh_CN/core-api/printk-formats.rst | 595 +++++++++++++++++++++
 .../zh_CN/core-api/refcount-vs-atomic.rst          | 154 ++++++
 .../zh_CN/core-api/symbol-namespaces.rst           | 142 +++++
 .../translations/zh_CN/core-api/workqueue.rst      | 337 ++++++++++++
 .../translations/zh_CN/dev-tools/index.rst         |   2 +-
 .../translations/zh_CN/dev-tools/kasan.rst         | 417 +++++++++++++++
 Documentation/translations/zh_CN/index.rst         |   5 +-
 .../zh_CN/maintainer/configure-git.rst             |  62 +++
 .../translations/zh_CN/maintainer/index.rst        |  21 +
 .../zh_CN/maintainer/maintainer-entry-profile.rst  |  92 ++++
 .../zh_CN/maintainer/modifying-patches.rst         |  51 ++
 .../zh_CN/maintainer/pull-requests.rst             | 148 +++++
 .../zh_CN/maintainer/rebasing-and-merging.rst      | 165 ++++++
 .../translations/zh_CN/parisc/debugging.rst        |  42 ++
 Documentation/translations/zh_CN/parisc/index.rst  |  28 +
 .../translations/zh_CN/parisc/registers.rst        | 153 ++++++
 .../translations/zh_CN/process/8.Conclusion.rst    |   2 +-
 .../translations/zh_CN/process/coding-style.rst    |   2 +-
 Documentation/usb/ehci.rst                         |   2 +-
 Documentation/usb/gadget_configfs.rst              |   2 +-
 Documentation/usb/gadget_printer.rst               |   2 +-
 Documentation/userspace-api/landlock.rst           |  11 +-
 Documentation/virt/kvm/api.rst                     |   2 +-
 Documentation/virt/kvm/s390-pv-boot.rst            |   2 +-
 Documentation/virt/kvm/vcpu-requests.rst           |   2 +-
 Documentation/vm/zswap.rst                         |   4 +-
 Documentation/x86/boot.rst                         |   4 +-
 Documentation/x86/mtrr.rst                         |   2 +-
 include/linux/device.h                             |   2 +-
 include/linux/mfd/madera/pdata.h                   |   2 +-
 include/linux/pinctrl/pinconf-generic.h            |   2 +-
 include/linux/platform_profile.h                   |   2 +-
 samples/kprobes/kprobe_example.c                   |  33 +-
 scripts/documentation-file-ref-check               |   2 +-
 scripts/kernel-doc                                 |  71 ++-
 scripts/sphinx-pre-install                         | 262 ++++++---
 tools/debugging/kernel-chktaint                    |   2 +-
 148 files changed, 5722 insertions(+), 1078 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-class-backlight-adp5520
 delete mode 100644 Documentation/ABI/testing/sysfs-class-backlight-adp8860
 delete mode 100644 Documentation/ABI/testing/sysfs-class-backlight-driver-adp8870
 delete mode 100644 Documentation/ABI/testing/sysfs-class-led-driver-el15203000
 create mode 100644 Documentation/filesystems/dax.rst
 delete mode 100644 Documentation/filesystems/dax.txt
 create mode 100644 Documentation/translations/zh_CN/admin-guide/lockup-watchdogs.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/cachetlb.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/kernel-api.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/kobject.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/local_ops.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/padata.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/printk-basics.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/printk-formats.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/refcount-vs-atomic.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/symbol-namespaces.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/workqueue.rst
 create mode 100644 Documentation/translations/zh_CN/dev-tools/kasan.rst
 create mode 100644 Documentation/translations/zh_CN/maintainer/configure-git.rst
 create mode 100644 Documentation/translations/zh_CN/maintainer/index.rst
 create mode 100644 Documentation/translations/zh_CN/maintainer/maintainer-entry-profile.rst
 create mode 100644 Documentation/translations/zh_CN/maintainer/modifying-patches.rst
 create mode 100644 Documentation/translations/zh_CN/maintainer/pull-requests.rst
 create mode 100644 Documentation/translations/zh_CN/maintainer/rebasing-and-merging.rst
 create mode 100644 Documentation/translations/zh_CN/parisc/debugging.rst
 create mode 100644 Documentation/translations/zh_CN/parisc/index.rst
 create mode 100644 Documentation/translations/zh_CN/parisc/registers.rst
