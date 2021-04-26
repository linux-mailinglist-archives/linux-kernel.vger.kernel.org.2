Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2E736B343
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 14:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbhDZMkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 08:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233378AbhDZMkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 08:40:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92F746100C;
        Mon, 26 Apr 2021 12:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619440762;
        bh=kjLZqd3ycPcU8bBZYXO5mpGstxiiL1TJw/FiZwOmz9I=;
        h=Date:From:To:Cc:Subject:From;
        b=Fbw4k3rGG+0D/Zv8xdD6cqG2aeEaLstvxlkY9UazEPqiO6vK7ntdP+gRKj9MfJhHI
         QKSQ0B4loj8mjkRt3ljFvNZUV8waJnEa4D0195j576XZsFFRO4vhqk9hxbAfylMc5a
         IWspq8y5Pkc6DYDhzG6XEABq6mZdFOLib7CgNJDc=
Date:   Mon, 26 Apr 2021 14:39:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver changes for 5.13-rc1
Message-ID: <YIa0d685cQZ7a2mR@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e49d033bddf5b565044e2abe4241353959bc9120:

  Linux 5.12-rc6 (2021-04-04 14:15:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.13-rc1

for you to fetch changes up to e2cb6b891ad2b8caa9131e3be70f45243df82a80:

  bluetooth: eliminate the potential race condition when removing the HCI controller (2021-04-23 13:25:04 +0200)

----------------------------------------------------------------
Char/Misc driver updates for 5.13-rc1

Here is the big set of various smaller driver subsystem updates for
5.13-rc1.

Major bits in here are:
	- habanalabs driver updates
	- hwtracing driver updates
	- interconnect driver updates
	- mhi driver updates
	- extcon driver updates
	- fpga driver updates
	- new binder features added
	- nvmem driver updates
	- phy driver updates
	- soundwire driver updates
	- smaller misc and char driver fixes and updates.
	- bluetooth driver bugfix that maintainer wanted to go through
	  this tree.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Shishkin (3):
      intel_th: Constify all drvdata references
      intel_th: pci: Add Rocket Lake CPU support
      intel_th: pci: Add Alder Lake-M support

Alon Mizrahi (1):
      habanalabs: add custom timeout flag per cs

Amelie Delaunay (2):
      dt-bindings: phy: phy-stm32-usbphyc: add #clock-cells property
      phy: stm32: register usbphyc as clock provider of ck_usbo_48m clock

Andy Shevchenko (11):
      pps: clients: gpio: Bail out on error when requesting GPIO echo line
      pps: clients: gpio: Use dev_err_probe() to avoid log noise
      pps: clients: gpio: Remove redundant condition in ->remove()
      pps: clients: gpio: Get rid of legacy platform data
      pps: clients: gpio: Make use of device properties
      pps: clients: gpio: Use struct device pointer directly
      pps: clients: gpio: Rearrange optional stuff in pps_gpio_setup()
      mux: gpio: Use bitmap API instead of direct assignment
      mux: gpio: Make it OF independent
      mux: gpio: Simplify code by using dev_err_probe()
      stm class: Use correct UUID APIs

AngeloGioacchino Del Regno (2):
      dt-bindings: interconnect: Add bindings for Qualcomm SDM660 NoC
      interconnect: qcom: Add SDM660 interconnect provider driver

Anirudh Ghayal (1):
      extcon: qcom-spmi: Add support for VBUS detection

Arnd Bergmann (1):
      kgdb: fix gcc-11 warning on indentation

Bard Liao (4):
      soundwire: add master quirks for bus clash and parity
      soundwire: bus: handle master quirks for bus clash and parity
      soundwire: intel: add master quirks for bus clash and parity
      soundwire: intel_init: test link->cdns

Benjamin Li (1):
      interconnect: qcom: icc-rpm: record slave RPM id in error log

Bharat Jauhari (1):
      habanalabs: move dram scrub to free sequence

Bhaskar Chowdhury (5):
      cxl: Fix couple of spellings
      w1: slaves: Typo fixes
      phy: intel: Fix a typo
      misc: genwqe: Rudimentary typo fixes
      scripts/spdxcheck.py: Fix a typo

Bhaumik Bhatt (25):
      bus: mhi: core: Add missing checks for MMIO register entries
      bus: mhi: core: Destroy SBL devices when moving to mission mode
      bus: mhi: core: Download AMSS image from appropriate function
      bus: mhi: core: Process execution environment changes serially
      bus: mhi: core: Update debug prints to include local device state
      bus: mhi: Make firmware image optional for controller
      bus: mhi: core: Rely on accurate method to determine EDL mode
      bus: mhi: core: Wait for ready after an EDL firmware download
      bus: mhi: core: Handle EDL mode entry appropriately
      bus: mhi: core: Identify Flash Programmer as a mission mode use case
      bus: mhi: core: Wait for MHI READY state in most scenarios
      bus: mhi: core: Improve state strings for debug messages
      bus: mhi: core: Introduce internal register poll helper function
      bus: mhi: core: Move to polling method to wait for MHI ready
      bus: mhi: core: Remove pre_init flag used for power purposes
      bus: mhi: pci_generic: Add SDX65 based modem support
      bus: mhi: core: Allow sending the STOP channel command
      bus: mhi: core: Clear context for stopped channels from remove()
      bus: mhi: core: Improvements to the channel handling state machine
      bus: mhi: core: Update debug messages to use client device
      bus: mhi: core: Hold device wake for channel update commands
      bus: mhi: core: Clear configuration from channel context during reset
      bus: mhi: core: Check channel execution environment before issuing reset
      bus: mhi: core: Remove __ prefix for MHI channel unprepare function
      bus: mhi: Improve documentation on channel transfer setup APIs

Brad Warrum (1):
      MAINTAINERS: Update entry for ibmvmc driver

Carl Yin (1):
      bus: mhi: core: Add support for Flash Programmer execution environment

Chen Huang (2):
      w1: ds2805: Use module_w1_family to simplify the code
      w1: ds28e17: Use module_w1_family to simplify the code

Chunfeng Yun (3):
      dt-bindings: phy: mediatek: dsi-phy: modify compatible dependence
      dt-bindings: phy: mediatek: hdmi-phy: modify compatible items
      dt-bindings: phy: mediatek: tphy: change patternProperties

Colin Ian King (3):
      bus: mhi: core: remove redundant initialization of variables state and ee
      nvmem: core: Fix unintentional sign extension issue
      habanalabs/gaudi: Fix uninitialized return code rc when read size is zero

Dan Carpenter (1):
      w1: w1_therm: use clamp() in int_to_short()

Daniel Thompson (1):
      kgdbts: Switch to do_sys_openat2() for breakpoint testing

Dinghao Liu (1):
      drivers: misc: ad525x_dpot: Add missing check in dpot_read_spi

Dmitry Baryshkov (5):
      dt-bindings: phy: qcom,qmp-usb3-dp-phy: move usb3 compatibles back to qcom,qmp-phy.yaml
      dt-bindings: phy: qcom,qmp-usb3-dp: Add support for SM8250
      phy: qcom-qmp: move DP functions to callbacks
      phy: qcom-qmp: rename common registers
      phy: qcom-qmp: add support for sm8250-usb3-dp phy

Douglas Anderson (1):
      nvmem: core: Add functions to make number reading easy

Evan Green (1):
      firmware: google: Enable s0ix logging by default

Faiz Abbas (1):
      phy: ti: j721e-wiz: Do not configure wiz if its already configured

Fan Wu (1):
      bus: mhi: core: Return EAGAIN if MHI ring is full

Geert Uytterhoeven (4):
      uapi: map_to_7segment: Remove licence boilerplate
      phy: marvell: ARMADA375_USBCLUSTER_PHY should not default to y, unconditionally
      phy: microchip: PHY_SPARX5_SERDES should depend on ARCH_SPARX5
      dt-bindings: fpga: fpga-region: Convert to sugar syntax

Georgi Djakov (5):
      interconnect: qcom: sdm660: Fix kerneldoc warning
      interconnect: qcom: sm8350: Use the correct ids
      interconnect: qcom: sm8350: Add missing link between nodes
      Merge branch 'icc-sdm660' into icc-next
      Merge branch 'icc-sm8350' into icc-next

Gleb Fotengauer-Malinovskiy (1):
      vmci_host: print unexpanded names of ioctl requests in debug messages

Greg Kroah-Hartman (12):
      virtio_console: remove pointless check for debugfs_create_dir()
      drivers: vmw_balloon: remove dentry pointer for debugfs
      drivers: habanalabs: remove unused dentry pointer for debugfs files
      Merge v5.12-rc3 into char-misc-next
      Merge 5.12-rc6 into char-misc-next
      Merge tag 'soundwire-5.13-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire into char-misc-next
      Merge tag 'phy-for-5.13' of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy into char-misc-next
      Merge tag 'fpga-late-for-5.13' of git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga into char-misc-next
      Merge tag 'extcon-next-for-5.13' of git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon into char-misc-next
      Merge tag 'misc-habanalabs-next-2021-04-10' of https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux into char-misc-next
      Merge tag 'mhi-for-v5.13' of git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi into char-misc-next
      Merge tag 'icc-5.13-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-next

Guru Das Srinagesh (2):
      bindings: pm8941-misc: Convert bindings to YAML
      bindings: pm8941-misc: Add support for VBUS detection

Gustavo A. R. Silva (1):
      phy: qcom-usb-hs: Fix fall-through warnings for Clang

Gustavo Pimentel (6):
      misc: Add Synopsys DesignWare xData IP driver
      Documentation: misc-devices: Add Documentation for dw-xdata-pcie driver
      MAINTAINERS: Add Synopsys xData IP driver maintainer
      docs: ABI: Add sysfs documentation interface of dw-xdata-pcie driver
      dw-xdata-pcie: Fix documentation build warns
      dw-xdata-pcie: Update outdated info and improve text format

Hang Lu (2):
      binder: fix the missing BR_FROZEN_REPLY in binder_return_strings
      binder: tell userspace to dump current backtrace when detected oneway spamming

Hans de Goede (3):
      misc: lis3lv02d: Fix false-positive WARN on various HP models
      misc: lis3lv02d: Change lis3lv02d_init_device() return value for unknown sensors to -ENODEV
      misc: lis3lv02d: Do not log an error when kmalloc fails

Hao Fang (1):
      phy: hisilicon: Use the correct HiSilicon copyright

He Ying (1):
      firmware: qcom-scm: Fix QCOM_SCM configuration

Jarvis Jiang (2):
      bus: mhi: pci_generic: Introduce Foxconn T99W175 support
      bus: mhi: fix typo in comments for struct mhi_channel_config

Jeffrey Hugo (3):
      bus: mhi: core: Fix check for syserr at power_up
      bus: mhi: core: Check state before processing power_down
      bus: mhi: core: Sanity check values from remote device before use

Jiapeng Chong (1):
      stm class: Remove an unused function

Junlin Yang (2):
      phy: rockchip-typec: add missing of_node_put
      phy: ti: j721e-wiz: add missing of_node_put

Kai Ye (1):
      uacce: delete unneeded variable initialization

Kishon Vijay Abraham I (29):
      dt-bindings: phy: ti,phy-j721e-wiz: Add bindings for AM64 SERDES Wrapper
      dt-bindings: phy: cadence-torrent: Add binding for refclk driver
      dt-bindings: ti-serdes-mux: Add defines for AM64 SoC
      phy: ti: j721e-wiz: Remove "regmap_field" from wiz_clk_{mux|div}_sel
      phy: ti: j721e-wiz: Delete "clk_div_sel" clk provider during cleanup
      phy: ti: j721e-wiz: Configure full rate divider for AM64
      phy: ti: j721e-wiz: Model the internal clocks without device tree input
      phy: ti: j721e-wiz: Enable reference clock output in cmn_refclk_<p/m>
      phy: cadence-torrent: Add support to drive refclk out
      phy: ti: j721e-wiz: Add support for configuring QSGMII
      phy: cadence-torrent: Update SGMII/QSGMII configuration specific to TI
      phy: cadence: Sierra: Fix PHY power_on sequence
      phy: ti: j721e-wiz: Invoke wiz_init() before of_platform_device_create()
      phy: cadence: Sierra: Create PHY only for "phy" or "link" sub-nodes
      phy: ti: j721e-wiz: Get PHY properties only for "phy" or "link" subnode
      phy: cadence: Sierra: Move all clk_get_*() to a separate function
      phy: cadence: Sierra: Move all reset_control_get*() to a separate function
      phy: cadence: Sierra: Explicitly request exclusive reset control
      phy: cadence-torrent: Use a common header file for Cadence SERDES
      phy: cadence: Sierra: Add array of input clocks in "struct cdns_sierra_phy"
      phy: cadence: Sierra: Add missing clk_disable_unprepare() in .remove callback
      dt-bindings: phy: phy-cadence-sierra: Add binding to model Sierra as clock provider
      phy: cadence: Sierra: Model PLL_CMNLC and PLL_CMNLC1 as clocks (mux clocks)
      phy: cadence: Sierra: Enable pll_cmnlc and pll_cmnlc1 clocks
      phy: cadence-torrent: Group reset APIs and clock APIs
      phy: cadence-torrent: Do not configure SERDES if it's already configured
      phy: cadence-torrent: Explicitly request exclusive reset control
      phy: cadence-torrent: Add delay for PIPE clock to be stable
      phy: ti: j721e-wiz: Configure 'p_standard_mode' only for DP/QSGMII

Koby Elbaz (2):
      habanalabs: improve utilization calculation
      habanalabs: support DEVICE_UNUSABLE error indication from FW

Konstantin Porotchkin (3):
      drivers: phy: add support for Armada CP110 UTMI PHY
      dt-bindings: phy: convert phy-mvebu-utmi to YAML schema
      devicetree/bindings: add support for CP110 UTMI PHY

Kuogee Hsieh (1):
      phy: qcom-qmp: add hbr3_hbr2 voltage and premphasis swing table

Laurent Dufour (1):
      cxl: don't manipulate the mm.mm_users field directly

Liam Beguin (1):
      phy: tusb1210: use bitmasks to set VENDOR_SPECIFIC2

Lin Ma (1):
      bluetooth: eliminate the potential race condition when removing the HCI controller

Loic Poulain (14):
      bus: mhi: pci_generic: Parametrable element count for events
      bus: mhi: pci_generic: Introduce quectel EM1XXGR-L support
      bus: mhi: pci_generic: Add SDX24 based modem support
      bus: mhi: pci_generic: No-Op for device_wake operations
      bus: mhi: pci_generic: Use generic PCI power management
      bus: mhi: pci_generic: Add support for runtime PM
      bus: mhi: pci_generic: Remove WQ_MEM_RECLAIM flag from state workqueue
      bus: mhi: core: Fix invalid error returning in mhi_queue
      bus: mhi: core: Rename debugfs directory name
      bus: mhi: Early MHI resume failure in non M3 state
      bus: mhi: core: Fix MHI runtime_pm behavior
      bus: mhi: pm: reduce PM state change verbosity
      bus: mhi: pci_generic: Implement PCI shutdown callback
      bus: mhi: pci_generic: Add FIREHOSE channels

Luca Ceresoli (2):
      fpga: fpga-mgr: xilinx-spi: fix error messages on -EPROBE_DEFER
      fpga: fpga-mgr: xilinx-spi: fix error messages on -EPROBE_DEFER

Manish Narani (1):
      phy: zynqmp: Handle the clock enable/disable properly

Manivannan Sadhasivam (2):
      bus: mhi: pci_generic: Constify mhi_controller_config struct definitions
      bus: mhi: core: Fix shadow declarations

Marco Ballesio (3):
      binder: BINDER_FREEZE ioctl
      binder: use EINTR for interrupted wait for work
      binder: BINDER_GET_FROZEN_INFO ioctl

Mathieu Poirier (1):
      MAINTAINERS: Add CoreSight header files

Matt Hsiao (1):
      misc: hpilo: MAINTAINERS: add entry for hpilo

Michal Simek (2):
      fpga: xilinx-pr-decoupler: Simplify code by using dev_err_probe()
      fpga: xilinx-pr-decoupler: Simplify code by using dev_err_probe()

Mihai Carabas (3):
      misc/pvpanic: split-up generic and platform dependent code
      misc/pvpanic: probe multiple instances
      misc/pvpanic: add PCI driver

Mike Leach (1):
      coresight: etm-perf: Fix define build issue when built as module

Nava kishore Manne (4):
      dt-bindings: fpga: Add compatible value for Xilinx DFX AXI shutdown manager
      fpga: Add support for Xilinx DFX AXI Shutdown manager
      dt-bindings: fpga: Add compatible value for Xilinx DFX AXI shutdown manager
      fpga: Add support for Xilinx DFX AXI Shutdown manager

Nikita Travkin (1):
      extcon: sm5502: Detect OTG when USB_ID is connected to ground

Oded Gabbay (11):
      habanalabs: reset after device is actually released
      habanalabs: fail reset if device is not idle
      habanalabs: reset_upon_device_release is for bring-up
      habanalabs: print if device is used on FD close
      habanalabs: change default CS timeout to 30 seconds
      habanalabs: use correct define for 32-bit max value
      habanalabs/gaudi: always use single-msi mode
      habanalabs/gaudi: add debugfs to DMA from the device
      habanalabs: remove the store jobs array from CS IOCTL
      habanalabs: use strscpy instead of sprintf and strlcpy
      habanalabs: print f/w boot unknown error

Ofir Bitton (13):
      habanalabs: add reset support when user closes FD
      habanalabs: enable all IRQs for user interrupt support
      habanalabs: wait for interrupt support
      habanalabs: use a single FW loading bringup flag
      habanalabs/gaudi: update extended async event header
      habanalabs: replace GFP_ATOMIC with GFP_KERNEL
      habanalabs: debugfs access to user mapped host addresses
      habanalabs/gaudi: reset device upon BMC request
      habanalabs/gaudi: unsecure TPC cfg status registers
      habanalabs/gaudi: Update async events header
      habanalabs: move relevant datapath work outside cs lock
      habanalabs/gaudi: derive security status from pci id
      habanalabs/gaudi: skip iATU if F/W security is enabled

Ohad Sharabi (6):
      habanalabs: reset device in case of sync error
      habanalabs: skip DISABLE PCI packet to FW on heartbeat
      habanalabs: update hl_boot_if.h
      habanalabs: support legacy and new pll indexes
      habanalabs: send dynamic msi-x indexes to f/w
      habanalabs: update to latest F/W communication header

Pavel Machek (1):
      intel_th: Consistency and off-by-one fix

Phillip Potter (1):
      fbdev: zero-fill colormap in fbcmap.c

Pierre-Louis Bossart (22):
      soundwire: Intel: introduce DMI quirks for HP Spectre x360 Convertible
      soundwire: Intel: add DMI quirk for Dell SKU 0A3E
      soundwire: intel: add missing \n in dev_err()
      soundwire: bandwidth_allocation: add missing \n in dev_err()
      soundwire: cadence: add missing \n in dev_err()
      soundwire: stream: add missing \n in dev_err()
      soundwire: qcom: add missing \n in dev_err()
      soundwire: bus: use correct driver name in error messages
      soundwire: bus: test read status
      soundwire: bus: use consistent tests for return values
      soundwire: bus: demote clock stop prepare log to dev_dbg()
      soundwire: bus: uniquify dev_err() for SCP_INT access
      soundwire: bus: remove useless initialization
      soundwire: generic_bandwidth_allocation: remove useless init
      soundwire: intel: remove useless readl
      soundwire: qcom: check of_property_read status
      soundwire: stream: remove useless initialization
      soundwire: stream: remove useless bus initializations
      soundwire: cadence_master: fix kernel-doc
      soundwire: add definition for DPn BlockPackingMode
      soundwire: generic_allocation: fix confusion between group and packing
      soundwire: cadence: only prepare attached devices on clock stop

Qi Liu (1):
      coresight: core: Fix typo in coresight-core.c

Qiang Ma (1):
      char: lp: remove redundant space around (inside) parenthesized expressions

Qiheng Lin (1):
      misc/pvpanic: fix return value check in pvpanic_pci_probe()

Rafał Miłecki (6):
      phy: phy-brcm-usb: select SOC_BRCMSTB on brcmstb only
      dt-bindings: phy: brcm,brcmstb-usb-phy: add power-domains
      dt-bindings: phy: bcm-ns-usb2-phy: convert to yaml
      dt-bindings: phy: bcm-ns-usb3-phy: convert to yaml
      dt-bindings: nvmem: add Broadcom's NVRAM
      nvmem: brcm_nvram: new driver exposing Broadcom's NVRAM

Rajendra Nayak (2):
      dt-bindings: nvmem: Add SoC compatible for sc7280
      nvmem: qfprom: Add support for fuse blowing on sc7280

Rander Wang (1):
      soundwire: stream: fix memory leak in stream config error path

Randy Dunlap (2):
      phy: marvell: phy-mvebu-cp11i-utmi needs USB_COMMON
      greybus: es2: fix kernel-doc warnings

Rasmus Villemoes (1):
      greybus: remove stray nul byte in apb_log_enable_read output

Ravi Kumar Bokka (1):
      drivers: nvmem: Fix voltage settings for QTI qfprom-efuse

Rikard Falkeborn (1):
      intel_th: Constify attribute_group structs

Russ Weight (2):
      fpga: dfl: afu: harden port enable logic
      fpga: dfl: pci: add DID for D5005 PAC cards

Ryan Wu (1):
      dt-bindings: nvmem: mediatek: add support for MediaTek mt8192 SoC

Sagiv Ozeri (2):
      habanalabs: support HW blocks vm show
      habanalabs: return current power via INFO IOCTL

Sai Prakash Ranjan (1):
      coresight: etm4x: Add ETM PID for Cortex-A78

Sandeep Maheswaram (1):
      dt-bindings: phy: qcom,usb-snps-femto-v2: Add bindings for SC7280

Seiya Wang (3):
      dt-bindings: phy: Add compatible for Mediatek MT8195
      dt-bindings: phy: Add compatible for Mediatek MT8195
      dt-bindings: phy: fix dt_binding_check warning in mediatek, ufs-phy.yaml

Sergio Paracuellos (1):
      phy: ralink: phy-mt7621-pci: fix XTAL bitmask

Shixin Liu (3):
      drivers: most: use DEFINE_SPINLOCK() for spinlock
      drivers: most: use LIST_HEAD() for list_head
      phy: ti: j721e-wiz: Add missing include linux/slab.h

Shuo Liu (1):
      virt: acrn: Fix document of acrn_msi_inject()

Srinivas Kandagatla (17):
      soundwire: bus: Fix device found flag correctly
      dt-bindings: soundwire: qcom: clarify data port bus parameters
      soundwire: qcom: add support to missing transport params
      soundwire: qcom: set continue execution flag for ignored commands
      soundwire: qcom: start the clock during initialization
      soundwire: qcom: update register read/write routine
      soundwire: qcom: add support to new interrupts
      soundwire: export sdw_compare_devid, sdw_extract_slave_id and sdw_slave_add
      soundwire: qcom: add auto enumeration support
      soundwire: qcom: wait for enumeration to be complete in probe
      nvmem: rmem: fix undefined reference to memremap
      soundwire: add static port mapping support
      soundwire: qcom: update port map allocation bit mask
      soundwire: qcom: add static port map support
      soundwire: qcom: wait for fifo space to be available before read/write
      soundwire: qcom: cleanup internal port config indexing
      soundwire: qcom: handle return correctly in qcom_swrm_transport_params

Steen Hegelund (4):
      dt-bindings: phy: Add sparx5-serdes bindings
      phy: Add media type and speed serdes configuration interfaces
      phy: Add Sparx5 ethernet serdes PHY driver
      phy: Sparx5 Eth SerDes: Use direct register operations

Swapnil Jakhade (2):
      phy: cadence-torrent: Update PCIe + QSGMII config for correct PLL1 clock
      phy: cadence-torrent: Update PCIe + USB config for correct PLL1 clock

Tetsuo Handa (2):
      misc: vmw_vmci: explicitly initialize vmci_notify_bm_set_msg struct
      misc: vmw_vmci: explicitly initialize vmci_datagram payload

Timon Baetz (1):
      extcon: max8997: Add CHGINS and CHGRM interrupt handling

Tomas Winkler (1):
      mei: me: add Alder Lake P device id.

Tomer Tayar (1):
      habanalabs/gaudi: clear QM errors only if not in stop_on_err mode

Vinod Koul (8):
      MAINTAINERS: Add linux-phy list and patchwork
      Merge tag 'ti-serdes-for-5.13' into next
      soundwire: add override addr ops
      dt-bindings: interconnect: Add Qualcomm SM8350 DT bindings
      interconnect: qcom: Add SM8350 interconnect provider driver
      MAINTAINERS: icc: add interconnect tree
      soundwire: qcom: use signed variable for error return
      phy: Revert "phy: ti: j721e-wiz: add missing of_node_put"

Wei Yongjun (3):
      phy: ralink: phy-mt7621-pci: fix return value check in mt7621_pci_phy_probe()
      phy: ingenic: Fix a typo in ingenic_usb_phy_probe()
      coresight: etm: perf: Make symbol 'format_attr_contextid' static

Xu Jia (1):
      applicom: fix some err codes returned by ac_ioctl

Xu Yilun (2):
      uio: uio_dfl: add userspace i/o driver for DFL bus
      Documentation: fpga: dfl: Add description for DFL UIO support

Yang Li (4):
      char/mwave: turn tp3780I_Cleanup() into void function
      misc/sgi-xp: use NULL instead of using plain integer as pointer
      phy: ti: j721e-wiz: add missing call to of_node_put()
      habanalabs: Switch to using the new API kobj_to_dev()

Yang Yingliang (2):
      speakup: i18n: Switch to kmemdup_nul() in spk_msg_set()
      phy: phy-twl4030-usb: Fix possible use-after-free in twl4030_usb_remove()

YueHaibing (1):
      misc/pvpanic: Make some symbols static

Zhang Yunkai (1):
      phy: qualcomm: remove duplicate argument

Zheng Yongjun (1):
      nvmem: convert comma to semicolon

Zou Wei (1):
      misc: sgi-xp: xp_main: make some symbols static

dongjian (1):
      w1: Use kobj_to_dev()[RESEND]

farah kassabri (3):
      habanalabs: set max asid to 2
      habanalabs: avoid soft lockup bug upon mapping error
      habanalabs/gaudi: sync stream add protection to SOB reset flow

kernel test robot (1):
      phy: fix resource_size.cocci warnings

 .../ABI/testing/debugfs-driver-habanalabs          |   70 +-
 .../ABI/testing/sysfs-bus-pci-devices-pvpanic      |    4 +-
 Documentation/ABI/testing/sysfs-driver-xdata       |   49 +
 .../bindings/extcon/qcom,pm8941-misc.txt           |   41 -
 .../bindings/extcon/qcom,pm8941-misc.yaml          |   62 +
 .../devicetree/bindings/fpga/fpga-region.txt       |  187 +-
 .../bindings/fpga/xilinx-pr-decoupler.txt          |   24 +-
 .../bindings/interconnect/qcom,rpmh.yaml           |   10 +
 .../bindings/interconnect/qcom,sdm660.yaml         |  147 ++
 .../devicetree/bindings/nvmem/brcm,nvram.yaml      |   34 +
 .../devicetree/bindings/nvmem/mtk-efuse.txt        |    1 +
 .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |    1 +
 .../devicetree/bindings/phy/bcm-ns-usb2-phy.txt    |   21 -
 .../devicetree/bindings/phy/bcm-ns-usb2-phy.yaml   |   59 +
 .../devicetree/bindings/phy/bcm-ns-usb3-phy.txt    |   34 -
 .../devicetree/bindings/phy/bcm-ns-usb3-phy.yaml   |   62 +
 .../bindings/phy/brcm,brcmstb-usb-phy.yaml         |    3 +
 .../bindings/phy/marvell,armada-3700-utmi-phy.yaml |   57 +
 .../phy/marvell,armada-cp110-utmi-phy.yaml         |  109 +
 .../devicetree/bindings/phy/mediatek,dsi-phy.yaml  |   13 +-
 .../devicetree/bindings/phy/mediatek,hdmi-phy.yaml |   11 +-
 .../devicetree/bindings/phy/mediatek,tphy.yaml     |    3 +-
 .../devicetree/bindings/phy/mediatek,ufs-phy.yaml  |    7 +-
 .../bindings/phy/microchip,sparx5-serdes.yaml      |  100 +
 .../bindings/phy/phy-cadence-sierra.yaml           |   17 +-
 .../bindings/phy/phy-cadence-torrent.yaml          |   22 +-
 .../devicetree/bindings/phy/phy-mvebu-utmi.txt     |   38 -
 .../devicetree/bindings/phy/phy-stm32-usbphyc.yaml |    5 +
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |    2 +
 .../bindings/phy/qcom,qmp-usb3-dp-phy.yaml         |    3 +-
 .../bindings/phy/qcom,usb-snps-femto-v2.yaml       |    1 +
 .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml  |    4 +
 .../devicetree/bindings/soundwire/qcom,sdw.txt     |   20 +
 Documentation/fpga/dfl.rst                         |   26 +
 Documentation/misc-devices/dw-xdata-pcie.rst       |   64 +
 Documentation/misc-devices/index.rst               |    1 +
 MAINTAINERS                                        |   18 +-
 drivers/accessibility/speakup/i18n.c               |    4 +-
 drivers/android/binder.c                           |  228 +-
 drivers/android/binder_alloc.c                     |   15 +-
 drivers/android/binder_alloc.h                     |    8 +-
 drivers/android/binder_internal.h                  |   24 +-
 drivers/bus/mhi/core/boot.c                        |   64 +-
 drivers/bus/mhi/core/debugfs.c                     |    2 +-
 drivers/bus/mhi/core/init.c                        |   72 +-
 drivers/bus/mhi/core/internal.h                    |   20 +-
 drivers/bus/mhi/core/main.c                        |  416 ++-
 drivers/bus/mhi/core/pm.c                          |  119 +-
 drivers/bus/mhi/pci_generic.c                      |  330 ++-
 drivers/char/applicom.c                            |    2 +-
 drivers/char/lp.c                                  |    4 +-
 drivers/char/mwave/tp3780i.c                       |    6 +-
 drivers/char/mwave/tp3780i.h                       |    2 +-
 drivers/char/virtio_console.c                      |   23 +-
 drivers/extcon/extcon-max8997.c                    |    4 +
 drivers/extcon/extcon-qcom-spmi-misc.c             |   99 +-
 drivers/extcon/extcon-sm5502.c                     |   22 +-
 drivers/firmware/Kconfig                           |    1 +
 drivers/firmware/google/gsmi.c                     |   14 +-
 drivers/fpga/Kconfig                               |    9 +-
 drivers/fpga/dfl-afu-error.c                       |   10 +-
 drivers/fpga/dfl-afu-main.c                        |   35 +-
 drivers/fpga/dfl-afu.h                             |    2 +-
 drivers/fpga/dfl-pci.c                             |   18 +-
 drivers/fpga/xilinx-pr-decoupler.c                 |   45 +-
 drivers/fpga/xilinx-spi.c                          |   24 +-
 drivers/greybus/es2.c                              |    8 +-
 drivers/hwtracing/coresight/coresight-core.c       |    2 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |    4 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c |    1 +
 drivers/hwtracing/intel_th/core.c                  |    2 +-
 drivers/hwtracing/intel_th/gth.c                   |    4 +-
 drivers/hwtracing/intel_th/intel_th.h              |    8 +-
 drivers/hwtracing/intel_th/msu.c                   |    2 +-
 drivers/hwtracing/intel_th/pci.c                   |   12 +-
 drivers/hwtracing/intel_th/pti.c                   |    4 +-
 drivers/hwtracing/stm/p_sys-t.c                    |    6 +-
 drivers/hwtracing/stm/policy.c                     |    5 -
 drivers/interconnect/qcom/Kconfig                  |   18 +
 drivers/interconnect/qcom/Makefile                 |    4 +
 drivers/interconnect/qcom/icc-rpm.c                |    4 +-
 drivers/interconnect/qcom/sdm660.c                 |  923 +++++++
 drivers/interconnect/qcom/sm8350.c                 |  633 +++++
 drivers/interconnect/qcom/sm8350.h                 |  168 ++
 drivers/misc/Kconfig                               |   19 +-
 drivers/misc/Makefile                              |    3 +-
 drivers/misc/ad525x_dpot.c                         |    3 +
 drivers/misc/cxl/context.c                         |    2 +-
 drivers/misc/cxl/fault.c                           |    2 +-
 drivers/misc/dw-xdata-pcie.c                       |  420 +++
 drivers/misc/genwqe/card_ddcb.c                    |   10 +-
 drivers/misc/habanalabs/common/command_buffer.c    |   12 +-
 .../misc/habanalabs/common/command_submission.c    |  368 ++-
 drivers/misc/habanalabs/common/context.c           |   14 +-
 drivers/misc/habanalabs/common/debugfs.c           |  224 +-
 drivers/misc/habanalabs/common/device.c            |  221 +-
 drivers/misc/habanalabs/common/firmware_if.c       |  238 +-
 drivers/misc/habanalabs/common/habanalabs.h        |  184 +-
 drivers/misc/habanalabs/common/habanalabs_drv.c    |   28 +-
 drivers/misc/habanalabs/common/habanalabs_ioctl.c  |   35 +-
 drivers/misc/habanalabs/common/hw_queue.c          |   10 +-
 drivers/misc/habanalabs/common/irq.c               |   56 +
 drivers/misc/habanalabs/common/memory.c            |  182 +-
 drivers/misc/habanalabs/common/mmu/mmu.c           |    3 +
 drivers/misc/habanalabs/common/pci/pci.c           |   52 +
 drivers/misc/habanalabs/common/sysfs.c             |   33 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              |  357 ++-
 drivers/misc/habanalabs/gaudi/gaudiP.h             |    3 +
 drivers/misc/habanalabs/gaudi/gaudi_security.c     |    8 -
 drivers/misc/habanalabs/goya/goya.c                |  140 +-
 drivers/misc/habanalabs/goya/goyaP.h               |    2 +
 drivers/misc/habanalabs/include/common/cpucp_if.h  |   99 +-
 .../misc/habanalabs/include/common/hl_boot_if.h    |  219 ++
 drivers/misc/habanalabs/include/gaudi/gaudi.h      |    2 +-
 .../habanalabs/include/gaudi/gaudi_async_events.h  |    2 +
 .../include/gaudi/gaudi_async_ids_map_extended.h   |   43 +-
 .../misc/habanalabs/include/gaudi/gaudi_fw_if.h    |   14 -
 drivers/misc/habanalabs/include/goya/goya.h        |    2 +-
 .../habanalabs/include/goya/goya_async_events.h    |    1 +
 drivers/misc/habanalabs/include/goya/goya_fw_if.h  |   11 -
 drivers/misc/kgdbts.c                              |   74 +-
 drivers/misc/lis3lv02d/lis3lv02d.c                 |   27 +-
 drivers/misc/mei/hw-me-regs.h                      |    1 +
 drivers/misc/mei/pci-me.c                          |    1 +
 drivers/misc/pvpanic/Kconfig                       |   27 +
 drivers/misc/pvpanic/Makefile                      |    8 +
 drivers/misc/{pvpanic.c => pvpanic/pvpanic-mmio.c} |   89 +-
 drivers/misc/pvpanic/pvpanic-pci.c                 |  125 +
 drivers/misc/pvpanic/pvpanic.c                     |  113 +
 drivers/misc/pvpanic/pvpanic.h                     |   21 +
 drivers/misc/sgi-xp/xp_main.c                      |    4 +-
 drivers/misc/sgi-xp/xpc_main.c                     |    2 +-
 drivers/misc/uacce/uacce.c                         |    2 +-
 drivers/misc/vmw_balloon.c                         |   11 +-
 drivers/misc/vmw_vmci/vmci_doorbell.c              |    2 +-
 drivers/misc/vmw_vmci/vmci_guest.c                 |    2 +-
 drivers/misc/vmw_vmci/vmci_host.c                  |    2 +-
 drivers/most/most_cdev.c                           |    6 +-
 drivers/mux/gpio.c                                 |   19 +-
 drivers/nvmem/Kconfig                              |   10 +
 drivers/nvmem/Makefile                             |    2 +
 drivers/nvmem/brcm_nvram.c                         |   78 +
 drivers/nvmem/core.c                               |   95 +
 drivers/nvmem/qcom-spmi-sdam.c                     |    2 +-
 drivers/nvmem/qfprom.c                             |   44 +
 drivers/nvmem/snvs_lpgpr.c                         |    2 +-
 drivers/phy/Kconfig                                |    1 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/broadcom/Kconfig                       |    2 +-
 drivers/phy/cadence/Kconfig                        |    2 +
 drivers/phy/cadence/phy-cadence-sierra.c           |  419 ++-
 drivers/phy/cadence/phy-cadence-torrent.c          |  475 +++-
 drivers/phy/hisilicon/phy-hi6220-usb.c             |    2 +-
 drivers/phy/hisilicon/phy-hix5hd2-sata.c           |    2 +-
 drivers/phy/ingenic/phy-ingenic-usb.c              |    4 +-
 drivers/phy/intel/phy-intel-lgm-combo.c            |    2 +-
 drivers/phy/marvell/Kconfig                        |   12 +-
 drivers/phy/marvell/Makefile                       |    1 +
 drivers/phy/marvell/phy-mvebu-cp110-utmi.c         |  384 +++
 drivers/phy/microchip/Kconfig                      |   13 +
 drivers/phy/microchip/Makefile                     |    6 +
 drivers/phy/microchip/sparx5_serdes.c              | 2513 ++++++++++++++++++
 drivers/phy/microchip/sparx5_serdes.h              |  136 +
 drivers/phy/microchip/sparx5_serdes_regs.h         | 2695 ++++++++++++++++++++
 drivers/phy/phy-core.c                             |   30 +
 drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c        |    4 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                |  528 +++-
 drivers/phy/qualcomm/phy-qcom-qmp.h                |   77 +-
 drivers/phy/qualcomm/phy-qcom-usb-hs.c             |    1 +
 drivers/phy/ralink/phy-mt7621-pci.c                |    6 +-
 drivers/phy/rockchip/phy-rockchip-typec.c          |    1 +
 drivers/phy/st/Kconfig                             |    1 +
 drivers/phy/st/phy-stm32-usbphyc.c                 |   65 +
 drivers/phy/ti/phy-j721e-wiz.c                     |  449 +++-
 drivers/phy/ti/phy-tusb1210.c                      |   27 +-
 drivers/phy/ti/phy-twl4030-usb.c                   |    2 +-
 drivers/phy/xilinx/phy-zynqmp.c                    |   58 +-
 drivers/pps/clients/pps-gpio.c                     |  108 +-
 drivers/soundwire/Makefile                         |    2 +-
 drivers/soundwire/bus.c                            |  100 +-
 drivers/soundwire/bus.h                            |    2 +
 drivers/soundwire/bus_type.c                       |   15 +-
 drivers/soundwire/cadence_master.c                 |   16 +-
 drivers/soundwire/dmi-quirks.c                     |   96 +
 drivers/soundwire/generic_bandwidth_allocation.c   |   15 +-
 drivers/soundwire/intel.c                          |   24 +-
 drivers/soundwire/intel_init.c                     |    9 +
 drivers/soundwire/qcom.c                           |  652 ++++-
 drivers/soundwire/slave.c                          |    9 +-
 drivers/soundwire/stream.c                         |   28 +-
 drivers/uio/Kconfig                                |   17 +
 drivers/uio/Makefile                               |    1 +
 drivers/uio/uio_dfl.c                              |   66 +
 drivers/video/fbdev/core/fbcmap.c                  |    8 +-
 drivers/virt/acrn/vm.c                             |    2 +-
 drivers/w1/slaves/w1_ds2780.c                      |    2 +-
 drivers/w1/slaves/w1_ds2781.c                      |    2 +-
 drivers/w1/slaves/w1_ds2805.c                      |   15 +-
 drivers/w1/slaves/w1_ds28e17.c                     |   16 +-
 drivers/w1/slaves/w1_therm.c                       |    7 +-
 include/dt-bindings/interconnect/qcom,sdm660.h     |  116 +
 include/dt-bindings/interconnect/qcom,sm8350.h     |  172 ++
 include/dt-bindings/mux/ti-serdes.h                |    5 +
 include/dt-bindings/phy/phy-cadence-torrent.h      |   13 -
 include/dt-bindings/phy/phy-cadence.h              |   20 +
 include/dt-bindings/phy/phy-ti.h                   |   21 +
 include/linux/mhi.h                                |   28 +-
 include/linux/nvmem-consumer.h                     |    4 +
 include/linux/phy/phy.h                            |   26 +
 include/linux/pps-gpio.h                           |   19 -
 include/linux/soundwire/sdw.h                      |   36 +-
 include/uapi/linux/android/binder.h                |   28 +
 include/uapi/linux/map_to_7segment.h               |   14 -
 include/uapi/misc/habanalabs.h                     |   77 +-
 net/bluetooth/hci_request.c                        |   12 +-
 scripts/spdxcheck.py                               |    2 +-
 216 files changed, 16281 insertions(+), 1994 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xdata
 delete mode 100644 Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/marvell,armada-3700-utmi-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
 create mode 100644 Documentation/misc-devices/dw-xdata-pcie.rst
 create mode 100644 drivers/interconnect/qcom/sdm660.c
 create mode 100644 drivers/interconnect/qcom/sm8350.c
 create mode 100644 drivers/interconnect/qcom/sm8350.h
 create mode 100644 drivers/misc/dw-xdata-pcie.c
 create mode 100644 drivers/misc/pvpanic/Kconfig
 create mode 100644 drivers/misc/pvpanic/Makefile
 rename drivers/misc/{pvpanic.c => pvpanic/pvpanic-mmio.c} (62%)
 create mode 100644 drivers/misc/pvpanic/pvpanic-pci.c
 create mode 100644 drivers/misc/pvpanic/pvpanic.c
 create mode 100644 drivers/misc/pvpanic/pvpanic.h
 create mode 100644 drivers/nvmem/brcm_nvram.c
 create mode 100644 drivers/phy/marvell/phy-mvebu-cp110-utmi.c
 create mode 100644 drivers/phy/microchip/Kconfig
 create mode 100644 drivers/phy/microchip/Makefile
 create mode 100644 drivers/phy/microchip/sparx5_serdes.c
 create mode 100644 drivers/phy/microchip/sparx5_serdes.h
 create mode 100644 drivers/phy/microchip/sparx5_serdes_regs.h
 create mode 100644 drivers/soundwire/dmi-quirks.c
 create mode 100644 drivers/uio/uio_dfl.c
 create mode 100644 include/dt-bindings/interconnect/qcom,sdm660.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8350.h
 delete mode 100644 include/dt-bindings/phy/phy-cadence-torrent.h
 create mode 100644 include/dt-bindings/phy/phy-cadence.h
 create mode 100644 include/dt-bindings/phy/phy-ti.h
 delete mode 100644 include/linux/pps-gpio.h
