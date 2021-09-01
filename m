Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E853FDDB1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 16:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbhIAORO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 10:17:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233922AbhIAORN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 10:17:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B344161053;
        Wed,  1 Sep 2021 14:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630505776;
        bh=Pzjd5aXATJphmWkK1S4ETpwSE94dLIV9oXWgancwoKQ=;
        h=Date:From:To:Cc:Subject:From;
        b=cfrqaKuLparGpOLWZInMR7B28fEQeG2mJRPcNN9/19ypEdQFe5BZG0cAI0JqwnRwn
         oYr3g8nXWOF3s08nWe/RxJ/DriPgK7WNNfhLSHWRmavnGpUobcPMwmLIFZFRmFAF6i
         XWxSL2perohiUsy15UaYUOzrjnm6RYNtMOWet55I=
Date:   Wed, 1 Sep 2021 16:16:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver changes for 5.15-rc1
Message-ID: <YS+LLVtSMVPfEgeS@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93:

  Linux 5.14-rc7 (2021-08-22 14:24:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.15-rc1

for you to fetch changes up to 0dc3ad3f859d3a65b335c861ec342d31d91e8bc8:

  Revert "bus: mhi: Add inbound buffers allocation flag" (2021-08-27 21:24:09 +0200)

----------------------------------------------------------------
Char / Misc driver changes for 5.15-rc1

Here is the big set of char/misc driver changes for 5.15-rc1.

Lots of different driver subsystems are being updated in here, notably:
	- mhi subsystem update
	- fpga subsystem update
	- coresight/hwtracing subsystem update
	- interconnect subsystem update
	- nvmem subsystem update
	- parport drivers update
	- phy subsystem update
	- soundwire subsystem update
and there are some other char/misc drivers being updated as well:
	- binder driver additions
	- new misc drivers
	- lkdtm driver updates
	- mei driver updates
	- sram driver updates
	- other minor driver updates.

Note, there are no habanna labs driver updates in this pull request,
that will probably come later before -rc1 is out in a different request.

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Usyskin (1):
      samples: mei: don't wait on read completion upon write.

Anand Moon (2):
      phy: amlogic: meson8b-usb2: Power off the PHY by putting it into reset mode
      phy: amlogic: meson8b-usb2: don't log an error on -EPROBE_DEFER

Andy Shevchenko (3):
      parport: serial: Get rid of IRQ_NONE abuse
      parport: serial: Retrieve IRQ vector with help of special getter
      pps: clients: parport: Switch to use module_parport_driver()

Appana Durga Kedareswara rao (1):
      dt-bindings: fpga: Add binding doc for versal fpga manager

Arnd Bergmann (1):
      phy: tegra: xusb: mark PM functions as __maybe_unused

Bard Liao (3):
      soundwire: bus: update Slave status in sdw_clear_slave_status
      soundwire: stream: don't abort bank switch on Command_Ignored/-ENODATA
      soundwire: stream: don't program mockup device ports

Baruch Siach (2):
      dt-bindings: phy: qcom,qmp: Add IPQ6018 USB3 PHY
      phy: qcom-qmp: add USB3 PHY support for IPQ6018

Bhaumik Bhatt (8):
      bus: mhi: core: Set BHI/BHIe offsets on power up preparation
      bus: mhi: core: Set BHI and BHIe pointers to NULL in clean-up
      bus: mhi: Add MMIO region length to controller structure
      ath11k: set register access length for MHI driver
      bus: mhi: pci_generic: Set register access length for MHI driver
      bus: mhi: core: Add range checks for BHI and BHIe
      bus: mhi: core: Replace DMA allocation wrappers with original APIs
      bus: mhi: core: Improve debug messages for power up

Biju Das (2):
      dt-bindings: phy: renesas,usb2-phy: Document RZ/G2L phy bindings
      phy: renesas: phy-rcar-gen3-usb2: Add USB2.0 PHY support for RZ/G2L

Bjorn Andersson (10):
      dt-bindings: phy: qcom,qmp: Add sc8180x PCIe compatible
      phy: qcom-qmp: Add sc8180x PCIe support
      interconnect: Sanity check that node isn't already on list
      phy: qcom-qmp: Fix sc8180x PCIe definition
      dt-bindings: phy: qcom,qmp-usb3-dp: Add support for sc8180x
      phy: qcom: qmp: Add SC8180x USB/DP combo
      dt-bindings: interconnect: Add SC8180x to OSM L3 DT binding
      interconnect: qcom: osm-l3: Add sc8180x support
      interconnect: qcom: osm-l3: Use driver-specific naming
      phy: qmp: Provide unique clock names for DP clocks

Carlos Llamas (3):
      binderfs: add support for feature files
      docs: binderfs: add section about feature files
      selftests/binderfs: add test for feature files

Chanho Park (2):
      phy: samsung-ufs: move phy-exynos7-ufs header
      phy: samsung-ufs: support exynosauto ufs phy driver

Christophe JAILLET (1):
      firmware: raspberrypi: Fix a leak in 'rpi_firmware_get()'

Chunfeng Yun (12):
      dt-bindings: phy: mediatek: tphy: add support hardware version 3
      phy: phy-mtk-tphy: support new hardware version
      phy: phy-mtk-tphy: add support mt8195
      dt-bindings: phy: mediatek: tphy: support type switch by pericfg
      phy: phy-mtk-tphy: use clock bulk to get clocks
      phy: phy-mtk-tphy: support type switch by pericfg
      phy: phy-mtk-tphy: print error log using child device
      phy: phy-mtk-tphy: remove error log of ioremap failure
      phy: phy-mtk-ufs: use clock bulk to get clocks
      phy: phy-mtk-hdmi: convert to devm_platform_ioremap_resource
      phy: phy-mtk-mipi-dsi: remove dummy assignment of error number
      phy: phy-mtk-mipi-dsi: convert to devm_platform_ioremap_resource

Colin Ian King (4):
      speakup: use C99 syntax for array initializers
      fpga: Fix spelling mistake "eXchnage" -> "exchange" in Kconfig
      misc: gehc-achc: Fix spelling mistake "Verfication" -> "Verification"
      parport: remove non-zero check on count

Dong Aisheng (1):
      dt-bindings: phy: imx8mq-usb-phy: convert to json schema

Emmanuel Gil Peyrot (2):
      dt-bindings: nintendo-otp: Document the Wii and Wii U OTP support
      nvmem: nintendo-otp: Add new driver for the Wii and Wii U OTP

Eric Auger (1):
      misc/pvpanic-pci: Allow automatic loading

Geert Uytterhoeven (1):
      dt-bindings: phy: Rename Intel Keem Bay USB PHY bindings

Georgi Djakov (2):
      dt-bindings: interconnect: Add Qualcomm SC8180x DT bindings
      interconnect: qcom: Add SC8180x providers

Greg Kroah-Hartman (9):
      Merge 5.14-rc3 into char-misc-next
      Merge tag 'fpga-for-5.15-early' of git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga into char-misc-next
      Merge tag 'fpga-for-5.15' of git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga into char-misc-next
      Merge 5.14-rc5 into char-misc-next
      Merge 5.14-rc7 into char-misc-next
      Merge tag 'icc-5.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-next
      Merge tag 'phy-for-5.15' of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy into char-misc-next
      Merge tag 'soundwire-5.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire into char-misc-next
      Revert "bus: mhi: Add inbound buffers allocation flag"

Iskren Chernev (2):
      dt-bindings: phy: qcom,qmp: Add SM6115 UFS PHY bindings
      phy: qcom-qmp: Add support for SM6115 UFS phy

Kees Cook (4):
      lkdtm/bugs: Add ARRAY_BOUNDS to selftests
      lkdtm/fortify: Consolidate FORTIFY_SOURCE tests
      lkdtm: Add kernel version to failure hints
      lkdtm/heap: Avoid __alloc_size hint warning for VMALLOC_LINEAR_OVERFLOW

Kevin Mitchell (2):
      lkdtm: replace SCSI_DISPATCH_CMD with SCSI_QUEUE_RQ
      lkdtm: remove IDE_CORE_CP crashpoint

Kishon Vijay Abraham I (1):
      dt-bindings: phy: Convert AM654 SERDES bindings to YAML

Krzysztof Kozlowski (1):
      mei: constify passed buffers and structures

Laurentiu Tudor (8):
      bus: fsl-mc: fix arg in call to dprc_scan_objects()
      bus: fsl-mc: handle DMA config deferral in ACPI case
      bus: fsl-mc: fully resume the firmware
      bus: fsl-mc: add .shutdown() op for the bus driver
      bus: fsl-mc: pause the MC firmware before IOMMU setup
      bus: fsl-mc: pause the MC firmware when unloading
      bus: fsl-mc: rescan devices if endpoint not found
      bus: fsl-mc: fix mmio base address for child DPRCs

Loic Poulain (1):
      bus: mhi: Add inbound buffers allocation flag

Martin Hundebøll (3):
      fpga: dfl: pci: add device IDs for Silicom N501x PAC cards
      fpga: dfl: expose feature revision from struct dfl_device
      spi: spi-altera-dfl: support n5010 feature revision

Mauro Carvalho Chehab (1):
      docs: driver-api: fpga: avoid using UTF-8 chars

Michal Simek (1):
      firmware: xilinx: Fix incorrect names in kernel-doc

Mihai Carabas (1):
      misc/pvpanic: fix set driver data

Mike Leach (10):
      coresight: syscfg: Initial coresight system configuration
      coresight: syscfg: Add registration and feature loading for cs devices
      coresight: config: Add configuration and feature generic functions
      coresight: etm-perf: Update to handle configuration selection
      coresight: syscfg: Add API to activate and enable configurations
      coresight: etm-perf: Update to activate selected configuration
      coresight: etm4x: Add complex configuration handlers to etmv4
      coresight: config: Add preloaded configurations
      coresight: syscfg: Add initial configfs support
      Documentation: coresight: Add documentation for CoreSight config

Mike Tipton (1):
      interconnect: qcom: icc-rpmh: Consolidate probe functions

Mikko Perttunen (1):
      misc: sram: Only map reserved areas in Tegra SYSRAM

Moritz Fischer (5):
      fpga: altera-freeze-bridge: Address warning about unused variable
      fpga: xiilnx-spi: Address warning about unused variable
      fpga: xilinx-pr-decoupler: Address warning about unused variable
      fpga: zynqmp-fpga: Address warning about unused variable
      fpga: versal-fpga: Remove empty functions

Nava kishore Manne (4):
      drivers: firmware: Add PDI load API support
      dt-bindings: firmware: Add bindings for xilinx firmware
      dt-bindings: firmware: Remove xlnx,zynqmp-firmware.txt file
      fpga: versal-fpga: Add versal fpga manager driver

Navin Sankar Velliangiri (1):
      fpga: fpga-bridge: removed repeated word

Nishanth Menon (1):
      scripts/spdxcheck-test.sh: Drop python2

Peter Ujfalusi (1):
      soundwire: cadence: Remove ret variable from sdw_cdns_irq()

Pierre-Louis Bossart (16):
      ASoC: codecs: add SoundWire mockup device support
      ASoC: soc-acpi: cnl: add table for SoundWire mockup devices
      ASoC: soc-acpi: tgl: add table for SoundWire mockup devices
      ASoC: Intel: boards: sof_sdw: add SoundWire mockup codecs for tests
      soundwire: dmi-quirks: add ull suffix for SoundWire _ADR values
      soundwire: bus: filter out more -EDATA errors on clock stop
      soundwire: dmi-quirks: add quirk for Intel 'Bishop County' NUC M15
      soundwire: cadence: add paranoid check on self-clearing bits
      soundwire: add flag to ignore all command/control for mockup devices
      soundwire: bus: squelch error returned by mockup devices
      soundwire: cadence: add debugfs interface for PDI loopbacks
      soundwire: cadence: override PDI configurations to create loopback
      soundwire: intel: fix potential race condition during power down
      soundwire: intel: skip suspend/resume/wake when link was not started
      soundwire: intel: conditionally exit clock stop mode on system suspend
      soundwire: cadence: do not extend reset delay

Piyush Mehta (1):
      phy: xilinx: zynqmp: skip PHY initialization and PLL lock for USB

Rajendra Nayak (3):
      dt-bindings: nvmem: qfprom: Add optional power-domains property
      nvmem: qfprom: Fix up qfprom_disable_fuse_blowing() ordering
      nvmem: qfprom: sc7280: Handle the additional power-domains vote

Ramji Jiyani (1):
      binder: Add invalid handle info in user error log

Randy Dunlap (3):
      MOST: cdev: rename 'mod_init' & 'mod_exit' functions to be module-specific
      phy: qualcomm: phy-qcom-usb-hs: repair non-kernel-doc comment
      char: move RANDOM_TRUST_CPU & RANDOM_TRUST_BOOTLOADER into the Character devices menu

Richard Weinberger (1):
      misc: pci_endpoint_test: Ensure relationship between miscdev and PCI

Salah Triki (1):
      dio: return -ENOMEM when kzalloc() fails

Samuel Thibault (1):
      speakup: replace sprintf() by scnprintf()

Sebastian Andrzej Siewior (2):
      sgi-xpc: Replace deprecated CPU-hotplug functions.
      coresight: Replace deprecated CPU-hotplug functions.

Sebastian Reichel (3):
      dt-bindings: misc: ge-achc: Convert to DT schema format
      ARM: dts: imx53-ppd: Fix ACHC entry
      misc: gehc-achc: new driver

Srinivas Kandagatla (1):
      nvmem: core: fix error handling while validating keepout regions

Swapnil Jakhade (9):
      phy: cadence-torrent: Remove use of CamelCase to fix checkpatch CHECK message
      phy: cadence-torrent: Reorder few functions to remove function declarations
      phy: cadence-torrent: Add enum for supported input reference clock frequencies
      phy: cadence-torrent: Configure PHY registers as a function of input reference clock rate
      phy: cadence-torrent: Add PHY registers for DP in array format
      phy: cadence-torrent: Add PHY configuration for DP with 100MHz ref clock
      phy: cadence-torrent: Add separate functions for reusable code
      phy: cadence-torrent: Add debug information for PHY configuration
      phy: cadence-torrent: Check PIPE mode PHY status to be ready for operation

Tom Rix (8):
      fpga: fix spelling mistakes
      fpga: fpga-mgr: wrap the write_init() op
      fpga: fpga-mgr: make write_complete() op optional
      fpga: fpga-mgr: wrap the write() op
      fpga: fpga-mgr: wrap the status() op
      fpga: fpga-mgr: wrap the state() op
      fpga: fpga-mgr: wrap the fpga_remove() op
      fpga: fpga-mgr: wrap the write_sg() op

Tony Lindgren (1):
      phy: phy-twl4030-usb: Disable PHY for suspend

ULRICH Thomas (1):
      bus: mhi: pci_generic: Add Cinterion MV31-W PCIe to MHI

Vinod Koul (1):
      Merge tag 'asoc-sdw-mockup-codec' into next

Wan Jiabing (1):
      lkdtm: remove duplicated include of init.h

Wang Hai (1):
      VMCI: fix NULL pointer dereference when unmapping queue pair

Xiyu Yang (1):
      misc: sgi-gru: Convert from atomic_t to refcount_t on gru_thread_state->ts_refcnt

jing yangyang (1):
      char: mware: fix returnvar.cocci warnings

kernel test robot (1):
      phy: rockchip-inno-usb2: fix for_each_child.cocci warnings

 Documentation/ABI/testing/sysfs-driver-ge-achc     |   15 +
 Documentation/admin-guide/binderfs.rst             |   13 +
 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |   44 -
 .../firmware/xilinx/xlnx,zynqmp-firmware.yaml      |   89 +
 .../devicetree/bindings/fpga/xlnx,versal-fpga.yaml |   33 +
 .../bindings/interconnect/qcom,osm-l3.yaml         |    1 +
 .../bindings/interconnect/qcom,rpmh.yaml           |   11 +
 Documentation/devicetree/bindings/misc/ge-achc.txt |   26 -
 .../devicetree/bindings/misc/ge-achc.yaml          |   65 +
 .../devicetree/bindings/nvmem/nintendo-otp.yaml    |   44 +
 .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |    3 +
 .../devicetree/bindings/phy/fsl,imx8mq-usb-phy.txt |   20 -
 .../bindings/phy/fsl,imx8mq-usb-phy.yaml           |   53 +
 ...keembay-usb.yaml => intel,keembay-phy-usb.yaml} |    2 +-
 .../devicetree/bindings/phy/mediatek,tphy.yaml     |   30 +-
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |    4 +
 .../bindings/phy/qcom,qmp-usb3-dp-phy.yaml         |    1 +
 .../devicetree/bindings/phy/renesas,usb2-phy.yaml  |   15 +
 .../devicetree/bindings/phy/samsung,ufs-phy.yaml   |    1 +
 .../bindings/phy/ti,phy-am654-serdes.txt           |   82 -
 .../bindings/phy/ti,phy-am654-serdes.yaml          |  103 +
 Documentation/driver-api/fpga/fpga-bridge.rst      |   10 +-
 Documentation/driver-api/fpga/fpga-mgr.rst         |   12 +-
 Documentation/driver-api/fpga/fpga-programming.rst |    8 +-
 Documentation/driver-api/fpga/fpga-region.rst      |   20 +-
 Documentation/fault-injection/provoke-crashes.rst  |    3 +-
 Documentation/fpga/dfl.rst                         |    4 +-
 Documentation/trace/coresight/coresight-config.rst |  244 ++
 Documentation/trace/coresight/coresight.rst        |   15 +
 arch/arm/boot/dts/imx53-ppd.dts                    |   23 +-
 drivers/accessibility/speakup/i18n.c               |   14 +-
 drivers/accessibility/speakup/speakup_soft.c       |   15 +-
 drivers/android/binder.c                           |    4 +-
 drivers/android/binderfs.c                         |   39 +
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |  134 +-
 drivers/bus/mhi/core/boot.c                        |   17 +-
 drivers/bus/mhi/core/init.c                        |   93 +-
 drivers/bus/mhi/core/internal.h                    |   22 +-
 drivers/bus/mhi/core/main.c                        |   15 +-
 drivers/bus/mhi/core/pm.c                          |   34 +-
 drivers/bus/mhi/pci_generic.c                      |   38 +
 drivers/char/Kconfig                               |    4 +-
 drivers/char/mwave/tp3780i.c                       |    4 +-
 drivers/dio/dio.c                                  |    2 +-
 drivers/firmware/raspberrypi.c                     |   10 +-
 drivers/firmware/xilinx/zynqmp.c                   |   23 +-
 drivers/fpga/Kconfig                               |   11 +-
 drivers/fpga/Makefile                              |    1 +
 drivers/fpga/altera-cvp.c                          |    2 +-
 drivers/fpga/altera-freeze-bridge.c                |    2 +
 drivers/fpga/dfl-fme-mgr.c                         |    6 -
 drivers/fpga/dfl-fme-pr.c                          |    2 +-
 drivers/fpga/dfl-n3000-nios.c                      |    2 +-
 drivers/fpga/dfl-pci.c                             |    5 +
 drivers/fpga/dfl.c                                 |   27 +-
 drivers/fpga/dfl.h                                 |    3 +-
 drivers/fpga/fpga-bridge.c                         |    8 +-
 drivers/fpga/fpga-mgr.c                            |  111 +-
 drivers/fpga/stratix10-soc.c                       |    6 -
 drivers/fpga/ts73xx-fpga.c                         |    6 -
 drivers/fpga/versal-fpga.c                         |   83 +
 drivers/fpga/xilinx-pr-decoupler.c                 |    2 +
 drivers/fpga/xilinx-spi.c                          |    2 +
 drivers/fpga/zynq-fpga.c                           |    6 +-
 drivers/fpga/zynqmp-fpga.c                         |   10 +-
 drivers/hwtracing/coresight/Kconfig                |    1 +
 drivers/hwtracing/coresight/Makefile               |    7 +-
 drivers/hwtracing/coresight/coresight-cfg-afdo.c   |  153 +
 .../hwtracing/coresight/coresight-cfg-preload.c    |   31 +
 .../hwtracing/coresight/coresight-cfg-preload.h    |   13 +
 drivers/hwtracing/coresight/coresight-config.c     |  272 ++
 drivers/hwtracing/coresight/coresight-config.h     |  253 ++
 drivers/hwtracing/coresight/coresight-core.c       |   12 +-
 drivers/hwtracing/coresight/coresight-cpu-debug.c  |    4 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |  150 +-
 drivers/hwtracing/coresight/coresight-etm-perf.h   |   12 +-
 drivers/hwtracing/coresight/coresight-etm4x-cfg.c  |  182 ++
 drivers/hwtracing/coresight/coresight-etm4x-cfg.h  |   30 +
 drivers/hwtracing/coresight/coresight-etm4x-core.c |   38 +-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |    3 +
 .../coresight/coresight-syscfg-configfs.c          |  396 +++
 .../coresight/coresight-syscfg-configfs.h          |   45 +
 drivers/hwtracing/coresight/coresight-syscfg.c     |  847 ++++++
 drivers/hwtracing/coresight/coresight-syscfg.h     |   81 +
 drivers/interconnect/core.c                        |    3 +
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/icc-rpmh.c               |   93 +
 drivers/interconnect/qcom/icc-rpmh.h               |    2 +
 drivers/interconnect/qcom/osm-l3.c                 |   60 +-
 drivers/interconnect/qcom/sc7180.c                 |   96 +-
 drivers/interconnect/qcom/sc7280.c                 |   96 +-
 drivers/interconnect/qcom/sc8180x.c                |  626 ++++
 drivers/interconnect/qcom/sc8180x.h                |  174 ++
 drivers/interconnect/qcom/sdm845.c                 |   99 +-
 drivers/interconnect/qcom/sdx55.c                  |   96 +-
 drivers/interconnect/qcom/sm8150.c                 |   96 +-
 drivers/interconnect/qcom/sm8250.c                 |   96 +-
 drivers/interconnect/qcom/sm8350.c                 |   97 +-
 drivers/misc/Kconfig                               |   12 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/gehc-achc.c                           |  565 ++++
 drivers/misc/lkdtm/bugs.c                          |   51 +-
 drivers/misc/lkdtm/core.c                          |    8 +-
 drivers/misc/lkdtm/fortify.c                       |   53 +
 drivers/misc/lkdtm/heap.c                          |    9 +-
 drivers/misc/lkdtm/lkdtm.h                         |   24 +-
 drivers/misc/mei/bus.c                             |   18 +-
 drivers/misc/mei/client.h                          |    2 +-
 drivers/misc/mei/mei_dev.h                         |    2 +-
 drivers/misc/pci_endpoint_test.c                   |    1 +
 drivers/misc/pvpanic/pvpanic-pci.c                 |    2 +
 drivers/misc/pvpanic/pvpanic.c                     |    2 +
 drivers/misc/sgi-gru/grumain.c                     |    6 +-
 drivers/misc/sgi-gru/grutables.h                   |    3 +-
 drivers/misc/sgi-xp/xpc_uv.c                       |    8 +-
 drivers/misc/sram.c                                |  103 +-
 drivers/misc/sram.h                                |    9 +
 drivers/misc/vmw_vmci/vmci_queue_pair.c            |    6 +-
 drivers/most/most_cdev.c                           |    8 +-
 drivers/net/mhi/net.c                              |    2 +-
 drivers/net/wireless/ath/ath11k/mhi.c              |    1 +
 drivers/net/wwan/mhi_wwan_ctrl.c                   |    2 +-
 drivers/nvmem/Kconfig                              |   11 +
 drivers/nvmem/Makefile                             |    2 +
 drivers/nvmem/core.c                               |    7 +-
 drivers/nvmem/nintendo-otp.c                       |  124 +
 drivers/nvmem/qfprom.c                             |   31 +-
 drivers/parport/ieee1284_ops.c                     |    2 +-
 drivers/parport/parport_serial.c                   |    9 +-
 drivers/phy/amlogic/phy-meson8b-usb2.c             |    8 +-
 drivers/phy/cadence/phy-cadence-torrent.c          | 3181 +++++++++++---------
 drivers/phy/mediatek/phy-mtk-hdmi.c                |    7 +-
 drivers/phy/mediatek/phy-mtk-mipi-dsi.c            |   13 +-
 drivers/phy/mediatek/phy-mtk-tphy.c                |  224 +-
 drivers/phy/mediatek/phy-mtk-ufs.c                 |   44 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                |  321 +-
 drivers/phy/qualcomm/phy-qcom-qmp.h                |   18 +
 drivers/phy/qualcomm/phy-qcom-usb-hs.c             |    2 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           |   97 +-
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      |    4 +-
 drivers/phy/samsung/Makefile                       |    5 +-
 .../{phy-exynos7-ufs.h => phy-exynos7-ufs.c}       |    8 +-
 drivers/phy/samsung/phy-exynosautov9-ufs.c         |   67 +
 drivers/phy/samsung/phy-samsung-ufs.c              |    3 +
 drivers/phy/samsung/phy-samsung-ufs.h              |   13 +-
 drivers/phy/tegra/xusb.c                           |    4 +-
 drivers/phy/ti/phy-twl4030-usb.c                   |   15 +
 drivers/phy/xilinx/phy-zynqmp.c                    |    3 +
 drivers/pps/clients/pps_parport.c                  |   42 +-
 drivers/soundwire/bus.c                            |   14 +-
 drivers/soundwire/cadence_master.c                 |  229 +-
 drivers/soundwire/cadence_master.h                 |    7 +
 drivers/soundwire/dmi-quirks.c                     |   36 +-
 drivers/soundwire/intel.c                          |  166 +-
 drivers/soundwire/intel.h                          |    1 +
 drivers/soundwire/stream.c                         |    5 +-
 drivers/spi/spi-altera-dfl.c                       |   21 +-
 drivers/spi/spidev.c                               |    1 -
 include/dt-bindings/interconnect/qcom,sc8180x.h    |  185 ++
 include/linux/coresight.h                          |    9 +
 include/linux/dfl.h                                |    1 +
 include/linux/firmware/xlnx-zynqmp.h               |   10 +
 include/linux/fpga/fpga-mgr.h                      |    2 +-
 include/linux/mei_cl_bus.h                         |    9 +-
 include/linux/mhi.h                                |    9 +-
 include/linux/soundwire/sdw.h                      |    3 +
 net/qrtr/mhi.c                                     |    2 +-
 samples/mei/mei-amt-version.c                      |   51 +-
 scripts/spdxcheck-test.sh                          |   16 +-
 sound/soc/codecs/Kconfig                           |   18 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/sdw-mockup.c                      |  312 ++
 sound/soc/intel/boards/Kconfig                     |    1 +
 sound/soc/intel/boards/sof_sdw.c                   |   41 +
 sound/soc/intel/common/Makefile                    |    3 +-
 sound/soc/intel/common/soc-acpi-intel-cnl-match.c  |   15 +
 .../intel/common/soc-acpi-intel-sdw-mockup-match.c |  166 +
 .../intel/common/soc-acpi-intel-sdw-mockup-match.h |   17 +
 sound/soc/intel/common/soc-acpi-intel-tgl-match.c  |   23 +
 .../selftests/filesystems/binderfs/binderfs_test.c |   17 +
 tools/testing/selftests/lkdtm/config               |    2 +
 tools/testing/selftests/lkdtm/tests.txt            |    3 +
 183 files changed, 9456 insertions(+), 3036 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-ge-achc
 delete mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
 delete mode 100644 Documentation/devicetree/bindings/misc/ge-achc.txt
 create mode 100644 Documentation/devicetree/bindings/misc/ge-achc.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
 rename Documentation/devicetree/bindings/phy/{intel,phy-keembay-usb.yaml => intel,keembay-phy-usb.yaml} (93%)
 delete mode 100644 Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.txt
 create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.yaml
 create mode 100644 Documentation/trace/coresight/coresight-config.rst
 create mode 100644 drivers/fpga/versal-fpga.c
 create mode 100644 drivers/hwtracing/coresight/coresight-cfg-afdo.c
 create mode 100644 drivers/hwtracing/coresight/coresight-cfg-preload.c
 create mode 100644 drivers/hwtracing/coresight/coresight-cfg-preload.h
 create mode 100644 drivers/hwtracing/coresight/coresight-config.c
 create mode 100644 drivers/hwtracing/coresight/coresight-config.h
 create mode 100644 drivers/hwtracing/coresight/coresight-etm4x-cfg.c
 create mode 100644 drivers/hwtracing/coresight/coresight-etm4x-cfg.h
 create mode 100644 drivers/hwtracing/coresight/coresight-syscfg-configfs.c
 create mode 100644 drivers/hwtracing/coresight/coresight-syscfg-configfs.h
 create mode 100644 drivers/hwtracing/coresight/coresight-syscfg.c
 create mode 100644 drivers/hwtracing/coresight/coresight-syscfg.h
 create mode 100644 drivers/interconnect/qcom/sc8180x.c
 create mode 100644 drivers/interconnect/qcom/sc8180x.h
 create mode 100644 drivers/misc/gehc-achc.c
 create mode 100644 drivers/nvmem/nintendo-otp.c
 rename drivers/phy/samsung/{phy-exynos7-ufs.h => phy-exynos7-ufs.c} (93%)
 create mode 100644 drivers/phy/samsung/phy-exynosautov9-ufs.c
 create mode 100644 include/dt-bindings/interconnect/qcom,sc8180x.h
 create mode 100644 sound/soc/codecs/sdw-mockup.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-sdw-mockup-match.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-sdw-mockup-match.h
