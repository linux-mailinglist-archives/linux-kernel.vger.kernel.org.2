Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321863BC21D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 19:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhGEROV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 13:14:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229686AbhGEROU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 13:14:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C737861166;
        Mon,  5 Jul 2021 17:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625505103;
        bh=wpZh1O0sZcTHpd6fq7SwYUo9j+iF1SyfRLxUJx2i2Kg=;
        h=Date:From:To:Cc:Subject:From;
        b=V0yP9ldgs6Krc5GEHKTIU8nhKfjJp2KyAC2EMJgEITbTFbqYHhEY3hwnQPbvrINfK
         TUgXapNhEGxwmLXNXrEqpinLBydEBzSQF6BZT5RavzMZm1Ff5w8vg5ZtUcE/1qs43A
         uzukT6rRCHICxVX7b5ccQ3EbPHZXBQXKRVU72+AA=
Date:   Mon, 5 Jul 2021 19:11:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver patches for 5.14-rc1
Message-ID: <YOM9TAEXx2EsohjB@kroah.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.14-rc1

for you to fetch changes up to 6f746d485fb9188dc67dce7de63d21f0c28a1f2e:

  mcb: Use DEFINE_RES_MEM() helper macro and fix the end address (2021-06-24 15:56:25 +0200)

----------------------------------------------------------------
Char / Misc driver updates for 5.14-rc1

Here is the big set of char / misc and other driver subsystem updates
for 5.14-rc1.  Included in here are:
	- habanna driver updates
	- fsl-mc driver updates
	- comedi driver updates
	- fpga driver updates
	- extcon driver updates
	- interconnect driver updates
	- mei driver updates
	- nvmem driver updates
	- phy driver updates
	- pnp driver updates
	- soundwire driver updates
	- lots of other tiny driver updates for char and misc drivers

This is looking more and more like the "various driver subsystems mushed
together" tree...

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aditya Srivastava (3):
      w1: ds2482: fix kernel-doc syntax in file
      ipac: ipoctal: fix kernel-doc syntax and remove filename from file headers
      ipac: tpci200: fix kernel-doc syntax and remove filename from file header

Alexander Shishkin (2):
      intel_th: msu: Make contiguous buffers uncached
      intel_th: Wait until port is in reset before programming it

Alon Mizrahi (1):
      habanalabs: use mmu cache range invalidation

Amelie Delaunay (2):
      dt-bindings: phy: add vbus-supply optional property to phy-stm32-usbphyc
      phy: stm32: manage optional vbus regulator on phy_power_on/off

Andy Shevchenko (6):
      video: ssd1307fb: Drop OF dependency
      parport: Use string_upper() instead of open coded variant
      eeprom: idt_89hpesx: Put fwnode in matching case during ->probe()
      eeprom: idt_89hpesx: Restore printing the unsupported fwnode name
      eeprom: idt_89hpesx: use SPDX-License-Identifier
      coresight: core: Switch to krealloc_array()

Anupama K Patil (1):
      drivers: pnp: proc.c: Removed unnecessary varibles

Aswath Govindraju (3):
      phy: core: Reword the comment specifying the units of max_link_rate to be Mbps
      dt-bindings: phy: Add binding for TI TCAN104x CAN transceivers
      phy: phy-can-transceiver: Add support for generic CAN transceiver driver

Baochen Qiang (1):
      bus: mhi: Wait for M2 state during system resume

Baokun Li (1):
      misc: bcm-vk: use list_move_tail instead of list_del/list_add_tail in bcm_vk_msg.c

Baruch Siach (2):
      dt-bindings: phy: qcom,qmp: Add IPQ60xx PCIe PHY bindings
      dt-bindings: pci: qcom: Document PCIe bindings for IPQ6018 SoC

Bharat Jauhari (1):
      habanalabs: enable dram scramble before linux f/w

Christoph Hellwig (1):
      remove the raw driver

Christophe JAILLET (15):
      uio: uio_aec: Use pci_iounmap instead of iounmap
      nvmem: sprd: Fix an error message
      cxl: Fix an error message
      misc/pvpanic-pci: Fix error handling in 'pvpanic_pci_probe()'
      misc/pvpanic-pci: Use GFP_KERNEL instead of GFP_ATOMIC
      misc/pvpanic-mmio: Fix error handling in 'pvpanic_mmio_probe()'
      misc/pvpanic-mmio: Use GFP_KERNEL instead of GFP_ATOMIC
      misc/pvpanic: Make 'pvpanic_probe()' resource managed
      firmware: stratix10-svc: Fix a resource leak in an error handling path
      misc/pvpanic: Remove some dead-code
      nvmem: core: add a missing of_node_put
      firewire: nosy: switch from 'pci_' to 'dma_' API
      habanalabs: Fix an error handling path in 'hl_pci_probe()'
      phy: ti: dm816x: Fix the error handling path in 'dm816x_usb_phy_probe()
      bus: mhi: pci-generic: Add missing 'pci_disable_pcie_error_reporting()' calls

Chunfeng Yun (1):
      phy: qcom-qmp: remove redundant error of clock bulk

Clayton Casciato (1):
      accessibility: braille: braille_console: fix whitespace style issues

Colin Ian King (4):
      char: xillybus: Fix spelling mistake "overflew" -> "overflowed"
      fsi: core: Fix return of error values on failures
      habanalabs/gaudi: remove redundant assignment to variable err
      phy: rockchip: remove redundant initialization of pointer cfg

Douglas Anderson (2):
      nvmem: core: constify nvmem_cell_read_variable_common() return value
      nvmem: qfprom: Improve the comment about regulator setting

Eddie James (6):
      fsi: scom: Reset the FSI2PIB engine for any error
      fsi: occ: Don't accept response from un-initialized OCC
      fsi: occ: Log error for checksum failure
      hwmon: (occ) Start sequence number at one
      hwmon: (occ) Print response status in first poll error message
      fsi: Aspeed: Reduce poll timeout

Eli Billauer (4):
      char: xillybus: Move class-related functions to new xillybus_class.c
      char: xillybus: Add driver for XillyUSB (Xillybus variant for USB)
      char: xillybus: Fix condition for invoking the xillybus/ subdirectory
      char: xillybus: Remove unneeded MODULE_VERSION() usage

Emmanuel Gil Peyrot (3):
      misc: eeprom_93xx46: Remove hardcoded bit lengths
      misc: eeprom_93xx46: Add new 93c56 and 93c66 compatible strings
      dt-bindings: eeprom-93xx46: Add support for 93C46, 93C56 and 93C66

Ferry Toth (1):
      extcon: intel-mrfld: Sync hardware and software state on init

Firas Ashkar (1):
      uio: uio_pci_generic: add memory resource mappings

Geert Uytterhoeven (1):
      dt-bindings: phy: renesas,rcar-gen3-pcie-phy: Convert to json-schema

Greg Kroah-Hartman (10):
      Merge 50f09a3dd587 ("Merge tag 'char-misc-5.13-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc") into char-misc-next
      w1: fix build warning in w1_ds2438.rst
      Merge 5.13-rc4 into char-misc-next
      Merge tag 'fsi-for-v5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi into char-misc-next
      Merge tag 'v5.13-rc6' into char-misc-next
      Merge tag 'soundwire-5.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire into char-misc-next
      Merge tag 'misc-habanalabs-next-2021-06-22' of https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux into char-misc-next
      Merge tag 'icc-5.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-next
      Merge tag 'phy-for-5.14_v2' of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy into char-misc-next
      Merge tag 'extcon-next-for-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon into char-misc-next

Guenter Roeck (2):
      mei: Drop unnecessary NULL check after container_of
      misc: xilinx-sdfec: Drop unnecessary NULL check after container_of

Guoqing Chi (1):
      misc: ibmasm: Modify matricies to matrices

Gustavo A. R. Silva (1):
      misc: bcm-vk: Replace zero-length array with flexible array member

Guy Nisan (1):
      habanalabs: modify progress status messages

He Ying (4):
      phy: bcm-ns-usb3: Remove redundant dev_err call in bcm_ns_usb3_mdio_probe()
      phy: phy-mmp3-hsic: Remove redundant dev_err call in mmp3_hsic_phy_probe()
      phy: phy-mtk-mipi-dsi: Remove redundant dev_err call in mtk_mipi_tx_probe()
      phy: phy-mtk-hdmi: Remove redundant dev_err call in mtk_hdmi_phy_probe()

Heiko Stuebner (2):
      dt-bindings: phy: add yaml binding for rockchip-inno-csi-dphy
      phy/rockchip: add Innosilicon-based CSI dphy

Heiner Kallweit (16):
      sysfs: Add helper BIN_ATTRIBUTE_GROUPS
      eeprom: ee1004: Let device core handle attribute eeprom
      eeprom: ee1004: Use kobj_to_i2c_client to simplify the code
      eeprom: ee1004: Remove not needed check in ee1004_read
      eeprom: ee1004: Remove not needed check in ee1004_eeprom_read
      eeprom: ee1004: Remove usage of i2c_adapter_id in adapter comparison
      eeprom: ee1004: Improve check for SMBUS features
      eeprom: ee1004: Improve creating dummy devices
      eeprom: ee1004: Switch to i2c probe_new callback
      eeprom: ee1004: Cache current page at initialization of first device only
      eeprom: ee1004: Factor out setting page to ee1004_set_current_page
      eeprom: ee1004: Improve error handling in ee1004_read
      eeprom: ee1004: Move call to ee1004_set_current_page to ee1004_eeprom_read
      eeprom: ee1004: Add constant EE1004_NUM_PAGES
      eeprom: ee1004: Add helper ee1004_cleanup
      eeprom: ee1004: Remove not needed debug message

Huilong Deng (1):
      mcb: Remove trailing semicolon in macros

Jeremy Linton (1):
      coresight: Propagate symlink failure

Jim Cromie (1):
      dyndbg: display KiB of data memory used.

Jinchao Wang (1):
      PNP: moved EXPORT_SYMBOL so that it immediately followed its function/variable

Jiri Prchal (3):
      nvmem: prepare basics for FRAM support
      nvmem: eeprom: at25: fix type compiler warnings
      nvmem: eeprom: at25: fram discovery simplification

Joachim Fenkes (2):
      fsi/sbefifo: Clean up correct FIFO when receiving reset request from SBE
      fsi/sbefifo: Fix reset timeout

Joel Stanley (2):
      fsi: aspeed: Emit fewer barriers in opb operations
      fsi: scom: Remove retries

Johan Jonker (1):
      dt-bindings: phy: convert rockchip-usb-phy.txt to YAML

Juerg Haefliger (1):
      uio: Remove leading spaces in Kconfig

Junhao He (3):
      coresight: core: Fix use of uninitialized pointer
      coresight: core: Remove unnecessary assignment
      coresight: etm4x: core: Remove redundant check of attr

Junlin Yang (1):
      misc: vmw_vmci: return the correct errno code

Kai Ye (1):
      uacce: add print information if not enable sva

Kees Cook (9):
      selftests/lkdtm: Avoid needing explicit sub-shell
      selftests/lkdtm: Fix expected text for CR4 pinning
      selftests/lkdtm: Fix expected text for free poison
      lkdtm/bugs: XFAIL UNALIGNED_LOAD_STORE_WRITE
      lkdtm/heap: Add vmalloc linear overflow test
      lkdtm: Enable DOUBLE_FAULT on all architectures
      lkdtm: Add CONFIG hints in errors where possible
      selftests/lkdtm: Enable various testable CONFIGs
      lkdtm/heap: Add init_on_alloc tests

Koby Elbaz (15):
      habanalabs/gaudi: use scratchpad regs instead of GIC controller
      habanalabs/gaudi: send hard reset cause to preboot
      habanalabs/gaudi: read GIC sts after FW is loaded
      habanalabs: read preboot status bits in an earlier stage
      habanalabs/gaudi: disable GIC usage if security is enabled
      habanalabs/gaudi: use COMMS to reset device / halt CPU
      habanalabs/gaudi: set the correct cpu_id on MME2_QM failure
      habanalabs: small code refactoring
      habanalabs: zero complex structures using memset
      habanalabs: set rc as 'valid' in case of intentional func exit
      habanalabs: remove node from list before freeing the node
      habanalabs/gaudi: set the correct rc in case of err
      habanalabs/goya: add '__force' attribute to suppress false alarm
      habanalabs: get lower/upper 32 bits via masking
      habanalabs/gaudi: refactor hard-reset related code

Kunihiko Hayashi (1):
      phy: uniphier-pcie: Fix updating phy parameters

Lee Jones (16):
      char: pcmcia: cm4000_cs: Remove unused variable 'tmp'
      char: pcmcia: cm4040_cs: Remove unused variable 'uc'
      char: hpet: Remove unused variable 'm'
      char: hw_random: pseries-rng: Demote non-conformant kernel-doc header
      comedi: comedi_8254: Fix descriptions for 'i8254' and 'iobase'
      comedi: drivers: ni_tio: Fix slightly broken kernel-doc and demote others
      comedi: drivers: ni_routes: Demote non-conforming kernel-doc headers
      comedi: drivers: comedi_isadma: Fix misspelling of 'dma_chan1'
      bus: fsl-mc: mc-io: Supply function names for 'fsl_create_mc_io()' and 'fsl_destroy_mc_io()'
      bus: fsl-mc: mc-sys: Supply missing function names in kernel-doc headers
      bus: fsl-mc: fsl-mc-bus: Demote a bunch of non-conformant kernel-doc headers and help others
      bus: fsl-mc: dprc: Fix a couple of misspelling and formatting issues
      bus: fsl-mc: dprc-driver: Fix some missing/incorrect function parameter descriptions
      bus: fsl-mc: fsl-mc-allocator: Fix misspelling of 'new_mc_adev' and demote non-kernel-doc headers
      bus: fsl-mc-msi: Fix a little doc-rot pertaining to 'np' to 'fwnode' conversion
      bus: fsl-mc: mc-io: Correct misdocumentation of 'dpmcp_dev' param

Loic Poulain (1):
      bus: mhi: core: Fix power down latency

Longpeng(Mike) (1):
      nitro_enclaves: Set Bus Master for the NE PCI device

Luiz Sampaio (6):
      w1: ds2438: fixed a coding style issue
      w1: ds2438: fixed if brackets coding style issue
      w1: ds2438: changed sysfs macro for rw file
      w1: ds2438: fixing bug that would always get page0
      w1: ds2438: adding support for reading page1
      w1: ds2438: support for writing to offset register

Lv Yunlong (2):
      misc/libmasm/module: Fix two use after free in ibmasm_init_one
      ipack/carriers/tpci200: Fix a double free in tpci200_pci_probe

Manivannan Sadhasivam (3):
      dt-bindings: phy: qcom,qmp: Add binding for SDX55 PCIe PHY
      phy: qcom-qmp: Use phy_status field for the status bit offset
      phy: qcom-qmp: Add support for SDX55 QMP PCIe PHY

Marek Szyprowski (1):
      extcon: max8997: Add missing modalias string

Masahiro Yamada (1):
      comedi: remove editor modelines and cruft (again)

Matt Hsiao (1):
      misc: hpilo: map iLO shared memory by PCI revision id

Mauro Carvalho Chehab (1):
      MAINTAINERS: update marvell,armada-3700-utmi-phy.yaml reference

Moritz Fischer (1):
      fpga: machxo2-spi: Address warning about unused variable

Moti Haimovski (1):
      habanalabs: increase ELBI reset timeout for PLDM

Nijam Haider (1):
      char: pcmcia: scr24x_cs: Fix redundant fops

Oded Gabbay (15):
      habanalabs: update firmware files to latest
      habanalabs: update to latest f/w headers
      habanalabs: use dev_dbg upon hint address failure
      habanalabs: ignore device unusable status
      habanalabs: better error print for pin failure
      habanalabs: notify before f/w loading
      habanalabs: set memory scrubbing to disabled by default
      habanalabs: check running index in eqe control
      habanalabs/gaudi: refactor reset code
      habanalabs/gaudi: don't use nic_ports_mask in compute
      habanalabs: prefer ASYNC device probing
      habanalabs/gaudi: update to latest f/w specs
      habanalabs/gaudi: use standard error codes
      habanalabs: print firmware versions
      habanalabs: remove a rogue #ifdef

Odelu Kukatla (2):
      dt-bindings: interconnect: Add Qualcomm SC7280 DT bindings
      interconnect: qcom: Add SC7280 interconnect provider driver

Ofir Bitton (10):
      habanalabs: give FW a grace time for configuring iATU
      habanalabs/gaudi: do not move HBM bar if iATU done by FW
      habanalabs/gaudi: split host irq interfaces towards FW
      habanalabs/gaudi: don't use disabled ports in collective wait
      habanalabs/gaudi: add FW alive event support
      habanalabs: reset device upon FD close if not idle
      habanalabs: enable stop on error for all QMANs and engines
      habanalabs/gaudi: correct driver events numbering
      habanalabs: allow reset upon device release
      habanalabs/gaudi: add support for NIC DERR

Ohad Sharabi (17):
      habanalabs: prepare preboot stage to dynamic f/w load
      habanalabs: request f/w in separate function
      habanalabs: refactor init device cpu code
      habanalabs: use common fw_version read
      habanalabs: dynamic fw load reset protocol
      habanalabs: expose ASIC specific PCI info to common code
      habanalabs: load boot fit to device
      habanalabs: load linux image to device
      habanalabs: set dma mask from fw once fw done iatu config
      habanalabs: avoid using uninitialized pointer
      habanalabs: read f/w's 2-nd sts and err registers
      habanalabs: check if asic secured with asic type
      habanalabs: track security status using positive logic
      habanalabs: skip valid test for boot_dev_sts regs
      habanalabs: fix mask to obtain page offset
      habanalabs: report EQ fault during heartbeat
      habanalabs/gaudi: print last QM PQEs on error

Omer Shpigelman (2):
      habanalabs: add missing space after casting
      habanalabs: add hard reset timeout for PLDM

Pierre-Louis Bossart (9):
      soundwire/ASoC: add leading zeroes in peripheral device name
      soundwire: bandwidth allocation: improve error messages
      soundwire: bus: only use CLOCK_STOP_MODE0 and fix confusions
      soundwire: add missing kernel-doc description
      soundwire: bus: handle -ENODATA errors in clock stop/start sequences
      soundwire: bus: add missing \n in dynamic debug
      soundwire: cadence_master: always set CMD_ACCEPT
      soundwire: dmi-quirks: remove duplicate initialization
      soundwire: intel: move to auxiliary bus

Rajendra Nayak (1):
      nvmem: qfprom: minor nit fixes

Randy Dunlap (1):
      stm class: Spelling fix

Richard Fitzgerald (2):
      soundwire: bus: Make sdw_nwrite() data pointer argument const
      soundwire: stream: Fix test for DP prepare complete

Rob Herring (1):
      phy: Allow a NULL phy name for devm_phy_get()

Russ Weight (5):
      fpga: altera-pr-ip: Remove function alt_pr_unregister
      fpga: stratix10-soc: Add missing fpga_mgr_free() call
      fpga: mgr: Rename dev to parent for parent device
      fpga: bridge: Rename dev to parent for parent device
      fpga: region: Rename dev to parent for parent device

Sai Prakash Ranjan (1):
      coresight: tmc-etf: Fix global-out-of-bounds in tmc_update_etf_buffer()

Samuel Holland (1):
      nvmem: sunxi_sid: Set type to OTP

Samuel Thibault (1):
      speakup: Separate out translations for bright colors names

Sebastian Fricke (1):
      phy: phy-core-mipi-dphy.c: Correct reference version

Selvam Sathappan Periakaruppan (1):
      phy: qcom-qmp: add QMP V2 PCIe PHY support for ipq60xx

Sergio Paracuellos (5):
      dt-bindings: phy: mediatek,mt7621-pci-phy: add clock entries
      phy: ralink: phy-mt7621-pci: use kernel clock APIS
      phy: ralink: Kconfig: enable COMPILE_TEST on mt7621-pci-phy driver
      phy: ralink: Kconfig: convert mt7621-pci-phy into 'bool'
      phy: ralink: phy-mt7621-pci: properly print pointer address

Shaokun Zhang (1):
      soundwire: cadence: remove the repeated declaration

Shubhankar Kuranagatti (1):
      phy: phy-xgene.c: Fix alignment of comment

Stephan Gerhold (7):
      extcon: sm5502: Drop invalid register write in sm5502_reg_data
      extcon: sm5502: Use devm_regmap_add_irq_chip()
      extcon: sm5502: Implement i2c_driver->probe_new()
      dt-bindings: extcon: sm5502: Convert to DT schema
      dt-bindings: extcon: sm5502: Document siliconmitus,sm5504-muic
      extcon: sm5502: Refactor driver to use chip-specific struct
      extcon: sm5502: Add support for SM5504

Tal Albo (1):
      habanalabs/gaudi: update coresight configuration

Tamar Mashiah (1):
      mei: fix kdoc in the driver

Thorsten Scherer (1):
      siox: Simplify error handling via dev_err_probe()

Tobias Schramm (2):
      dt-bindings: phy: rockchip-inno-usb2: add compatible for rk3308 USB phy
      phy: phy-rockchip-inno-usb2: add support for RK3308 USB phy

Tom Rix (10):
      dt-bindings: fpga: fpga-region: change FPGA indirect article to an
      Documentation: fpga: dfl: change FPGA indirect article to an
      Documentation: ocxl.rst: change FPGA indirect article to an
      fpga: change FPGA indirect article to an
      fpga: bridge: change FPGA indirect article to an
      fpga-mgr: change FPGA indirect article to an
      fpga: region: change FPGA indirect article to an
      fpga: of-fpga-region: change FPGA indirect article to an
      fpga: stratix10-soc: change FPGA indirect article to an
      mei: hdcp: SPDX tag should be the first line

Tomas Winkler (1):
      mei: revamp mei extension header structure layout.

Tomer Tayar (2):
      habanalabs/gaudi: add ARB to QM stop on error masks
      habanalabs: print more info when failing to pin user memory

Tong Zhang (2):
      misc: alcor_pci: fix null-ptr-deref when there is no PCI bridge
      misc: alcor_pci: fix inverted branch condition

Uwe Kleine-König (2):
      sparc/vio: make remove callback return void
      intel_th: Remove an unused exit point from intel_th_remove()

Vinod Koul (1):
      phy: Revert "phy: ralink: Kconfig: convert mt7621-pci-phy into 'bool'"

Yang Yingliang (2):
      w1: w1_therm: correct function name bulk_read_support()
      w1: w1_therm: fix build warning in w1_seq_show()

Yangtao Li (1):
      fsi: aspeed: convert to devm_platform_ioremap_resource

Yu Kuai (1):
      char: pcmcia: error out if 'num_bytes_read' is greater than 4 in set_protocol()

YueHaibing (1):
      phy: phy-twl4030-usb: use DEVICE_ATTR_RO macro

Yuri Nudelman (3):
      habanalabs: add debug flag to prevent failure on timeout
      habanalabs: added open_stats info ioctl
      debugfs: add skip_reset_on_timeout option

Zhen Lei (4):
      fsi: master-ast-cf: Remove redundant error printing in fsi_master_acf_probe()
      visorbus: fix error return code in visorchipset_init()
      EISA: use DEVICE_ATTR_RO() helper macro
      mcb: Use DEFINE_RES_MEM() helper macro and fix the end address

Zou Wei (1):
      fsi: Add missing MODULE_DEVICE_TABLE

Zvika Yehudai (1):
      habanalabs: fix typo

farah kassabri (1):
      habanalabs: add validity check for signal cs

 Documentation/ABI/stable/sysfs-driver-w1_ds2438    |   13 +
 .../ABI/testing/debugfs-driver-habanalabs          |    8 +
 Documentation/ABI/testing/sysfs-class-spi-eeprom   |   19 +
 Documentation/devicetree/bindings/eeprom/at25.yaml |   31 +-
 .../devicetree/bindings/extcon/extcon-sm5502.txt   |   21 -
 .../bindings/extcon/siliconmitus,sm5502-muic.yaml  |   52 +
 .../devicetree/bindings/fpga/fpga-region.txt       |   22 +-
 .../bindings/interconnect/qcom,rpmh.yaml           |   12 +
 .../devicetree/bindings/misc/eeprom-93xx46.txt     |    3 +
 .../devicetree/bindings/pci/qcom,pcie.txt          |   24 +
 .../bindings/phy/mediatek,mt7621-pci-phy.yaml      |    5 +
 .../bindings/phy/phy-rockchip-inno-usb2.yaml       |    1 +
 .../devicetree/bindings/phy/phy-stm32-usbphyc.yaml |   11 +
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |   27 +
 .../devicetree/bindings/phy/rcar-gen3-phy-pcie.txt |   24 -
 .../bindings/phy/renesas,rcar-gen3-pcie-phy.yaml   |   53 +
 .../bindings/phy/rockchip-inno-csi-dphy.yaml       |   79 +
 .../devicetree/bindings/phy/rockchip-usb-phy.txt   |   52 -
 .../devicetree/bindings/phy/rockchip-usb-phy.yaml  |   81 +
 .../devicetree/bindings/phy/ti,tcan104x-can.yaml   |   56 +
 Documentation/fpga/dfl.rst                         |    4 +-
 Documentation/userspace-api/accelerators/ocxl.rst  |    2 +-
 Documentation/w1/slaves/w1_ds2438.rst              |   19 +-
 MAINTAINERS                                        |    4 +-
 arch/sparc/include/asm/vio.h                       |    2 +-
 arch/sparc/kernel/ds.c                             |    6 -
 arch/sparc/kernel/vio.c                            |    4 +-
 drivers/accessibility/braille/braille_console.c    |    3 +
 drivers/accessibility/speakup/i18n.c               |    7 +
 drivers/accessibility/speakup/i18n.h               |    9 +-
 drivers/accessibility/speakup/main.c               |    4 -
 drivers/block/sunvdc.c                             |    3 +-
 drivers/bus/fsl-mc/dprc-driver.c                   |    8 +-
 drivers/bus/fsl-mc/dprc.c                          |    4 +-
 drivers/bus/fsl-mc/fsl-mc-allocator.c              |   10 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |   19 +-
 drivers/bus/fsl-mc/fsl-mc-msi.c                    |    2 +-
 drivers/bus/fsl-mc/mc-io.c                         |    6 +-
 drivers/bus/fsl-mc/mc-sys.c                        |   19 +-
 drivers/bus/mhi/core/pm.c                          |   19 +-
 drivers/bus/mhi/pci_generic.c                      |    5 +-
 drivers/char/Kconfig                               |   21 -
 drivers/char/Makefile                              |    3 +-
 drivers/char/hpet.c                                |    4 +-
 drivers/char/hw_random/pseries-rng.c               |    2 +-
 drivers/char/mem.c                                 |    1 -
 drivers/char/pcmcia/cm4000_cs.c                    |    7 +-
 drivers/char/pcmcia/cm4040_cs.c                    |    3 +-
 drivers/char/pcmcia/scr24x_cs.c                    |    1 -
 drivers/char/raw.c                                 |  362 ----
 drivers/char/xillybus/Kconfig                      |   22 +-
 drivers/char/xillybus/Makefile                     |    2 +
 drivers/char/xillybus/xillybus.h                   |   10 +-
 drivers/char/xillybus/xillybus_class.c             |  262 +++
 drivers/char/xillybus/xillybus_class.h             |   30 +
 drivers/char/xillybus/xillybus_core.c              |  180 +-
 drivers/char/xillybus/xillybus_of.c                |    1 -
 drivers/char/xillybus/xillybus_pcie.c              |    1 -
 drivers/char/xillybus/xillyusb.c                   | 2259 ++++++++++++++++++++
 drivers/comedi/drivers/comedi_8254.c               |    3 +-
 drivers/comedi/drivers/comedi_isadma.c             |    2 +-
 drivers/comedi/drivers/ni_routes.c                 |    7 +-
 drivers/comedi/drivers/ni_routes.h                 |    1 -
 .../comedi/drivers/ni_routing/ni_device_routes.c   |    1 -
 .../comedi/drivers/ni_routing/ni_device_routes.h   |    1 -
 .../drivers/ni_routing/ni_device_routes/all.h      |    1 -
 .../ni_routing/ni_device_routes/pci-6070e.c        |    1 -
 .../drivers/ni_routing/ni_device_routes/pci-6220.c |    1 -
 .../drivers/ni_routing/ni_device_routes/pci-6221.c |    1 -
 .../drivers/ni_routing/ni_device_routes/pci-6229.c |    1 -
 .../drivers/ni_routing/ni_device_routes/pci-6251.c |    1 -
 .../drivers/ni_routing/ni_device_routes/pci-6254.c |    1 -
 .../drivers/ni_routing/ni_device_routes/pci-6259.c |    1 -
 .../drivers/ni_routing/ni_device_routes/pci-6534.c |    1 -
 .../drivers/ni_routing/ni_device_routes/pci-6602.c |    1 -
 .../drivers/ni_routing/ni_device_routes/pci-6713.c |    1 -
 .../drivers/ni_routing/ni_device_routes/pci-6723.c |    1 -
 .../drivers/ni_routing/ni_device_routes/pci-6733.c |    1 -
 .../ni_routing/ni_device_routes/pxi-6030e.c        |    1 -
 .../drivers/ni_routing/ni_device_routes/pxi-6224.c |    1 -
 .../drivers/ni_routing/ni_device_routes/pxi-6225.c |    1 -
 .../drivers/ni_routing/ni_device_routes/pxi-6251.c |    1 -
 .../drivers/ni_routing/ni_device_routes/pxi-6733.c |    1 -
 .../ni_routing/ni_device_routes/pxie-6251.c        |    1 -
 .../ni_routing/ni_device_routes/pxie-6535.c        |    1 -
 .../ni_routing/ni_device_routes/pxie-6738.c        |    1 -
 .../comedi/drivers/ni_routing/ni_route_values.c    |    1 -
 .../comedi/drivers/ni_routing/ni_route_values.h    |    1 -
 .../drivers/ni_routing/ni_route_values/all.h       |    1 -
 .../drivers/ni_routing/ni_route_values/ni_660x.c   |    1 -
 .../ni_routing/ni_route_values/ni_eseries.c        |    1 -
 .../ni_routing/ni_route_values/ni_mseries.c        |    1 -
 .../drivers/ni_routing/tools/convert_c_to_py.c     |    1 -
 .../drivers/ni_routing/tools/convert_csv_to_c.py   |    7 -
 .../drivers/ni_routing/tools/convert_py_to_csv.py  |    1 -
 .../drivers/ni_routing/tools/csv_collection.py     |    1 -
 .../drivers/ni_routing/tools/make_blank_csv.py     |    1 -
 .../comedi/drivers/ni_routing/tools/ni_names.py    |    1 -
 drivers/comedi/drivers/ni_tio.c                    |   12 +-
 drivers/comedi/drivers/tests/comedi_example_test.c |    1 -
 drivers/comedi/drivers/tests/ni_routes_test.c      |    1 -
 drivers/comedi/drivers/tests/unittest.h            |    1 -
 drivers/eisa/eisa-bus.c                            |   23 +-
 drivers/extcon/Kconfig                             |    2 +-
 drivers/extcon/extcon-intel-mrfld.c                |    9 +
 drivers/extcon/extcon-max8997.c                    |    1 +
 drivers/extcon/extcon-sm5502.c                     |  212 +-
 drivers/extcon/extcon-sm5502.h                     |   82 +-
 drivers/firewire/nosy.c                            |   43 +-
 drivers/firmware/stratix10-svc.c                   |   22 +-
 drivers/fpga/Kconfig                               |    4 +-
 drivers/fpga/altera-pr-ip-core.c                   |   10 -
 drivers/fpga/fpga-bridge.c                         |   40 +-
 drivers/fpga/fpga-mgr.c                            |   42 +-
 drivers/fpga/fpga-region.c                         |   30 +-
 drivers/fpga/machxo2-spi.c                         |    2 +
 drivers/fpga/of-fpga-region.c                      |    8 +-
 drivers/fpga/stratix10-soc.c                       |    3 +-
 drivers/fsi/fsi-core.c                             |    4 +-
 drivers/fsi/fsi-master-aspeed.c                    |   33 +-
 drivers/fsi/fsi-master-ast-cf.c                    |    2 +-
 drivers/fsi/fsi-master-gpio.c                      |    1 +
 drivers/fsi/fsi-occ.c                              |   12 +-
 drivers/fsi/fsi-sbefifo.c                          |   10 +-
 drivers/fsi/fsi-scom.c                             |  105 +-
 drivers/hwmon/occ/common.c                         |    7 +-
 drivers/hwtracing/coresight/coresight-core.c       |   11 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c |    5 -
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |    2 +-
 drivers/hwtracing/intel_th/core.c                  |   29 +-
 drivers/hwtracing/intel_th/gth.c                   |   16 +
 drivers/hwtracing/intel_th/intel_th.h              |    3 +
 drivers/hwtracing/intel_th/msu.c                   |   48 +-
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/sc7280.c                 | 1938 +++++++++++++++++
 drivers/interconnect/qcom/sc7280.h                 |  154 ++
 drivers/ipack/carriers/tpci200.c                   |    9 +-
 drivers/ipack/carriers/tpci200.h                   |    4 +-
 drivers/ipack/devices/ipoctal.c                    |    4 +-
 drivers/ipack/devices/ipoctal.h                    |    6 +-
 drivers/mcb/mcb-lpc.c                              |   13 +-
 drivers/misc/bcm-vk/bcm_vk_msg.c                   |    6 +-
 drivers/misc/bcm-vk/bcm_vk_msg.h                   |    2 +-
 drivers/misc/cardreader/alcor_pci.c                |    8 +-
 drivers/misc/cxl/file.c                            |    5 +-
 drivers/misc/eeprom/Kconfig                        |    5 +-
 drivers/misc/eeprom/at25.c                         |  158 +-
 drivers/misc/eeprom/ee1004.c                       |  223 +-
 drivers/misc/eeprom/eeprom_93xx46.c                |   90 +-
 drivers/misc/eeprom/idt_89hpesx.c                  |   41 +-
 .../misc/habanalabs/common/command_submission.c    |   81 +-
 drivers/misc/habanalabs/common/context.c           |    9 -
 drivers/misc/habanalabs/common/debugfs.c           |    5 +
 drivers/misc/habanalabs/common/device.c            |   82 +-
 drivers/misc/habanalabs/common/firmware_if.c       | 1806 ++++++++++++++--
 drivers/misc/habanalabs/common/habanalabs.h        |  280 ++-
 drivers/misc/habanalabs/common/habanalabs_drv.c    |   24 +-
 drivers/misc/habanalabs/common/habanalabs_ioctl.c  |   23 +-
 drivers/misc/habanalabs/common/hw_queue.c          |   42 +-
 drivers/misc/habanalabs/common/irq.c               |   24 +-
 drivers/misc/habanalabs/common/memory.c            |   22 +-
 drivers/misc/habanalabs/common/mmu/mmu.c           |   14 +-
 drivers/misc/habanalabs/common/pci/pci.c           |   34 +-
 drivers/misc/habanalabs/common/sysfs.c             |    2 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              | 1013 +++++----
 drivers/misc/habanalabs/gaudi/gaudiP.h             |    1 +
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c    |    6 +-
 drivers/misc/habanalabs/gaudi/gaudi_security.c     |   15 +-
 drivers/misc/habanalabs/goya/goya.c                |  251 ++-
 drivers/misc/habanalabs/goya/goyaP.h               |    2 +-
 drivers/misc/habanalabs/goya/goya_coresight.c      |    2 +-
 drivers/misc/habanalabs/include/common/cpucp_if.h  |   45 +-
 .../misc/habanalabs/include/common/hl_boot_if.h    |  184 +-
 .../habanalabs/include/gaudi/gaudi_async_events.h  |   14 +-
 .../include/gaudi/gaudi_async_ids_map_extended.h   |   31 +-
 .../misc/habanalabs/include/gaudi/gaudi_fw_if.h    |   46 +
 .../misc/habanalabs/include/gaudi/gaudi_masks.h    |   15 +-
 .../misc/habanalabs/include/gaudi/gaudi_reg_map.h  |   10 +
 drivers/misc/hpilo.c                               |   10 +-
 drivers/misc/hpilo.h                               |    3 +
 drivers/misc/ibmasm/module.c                       |    5 +-
 drivers/misc/ibmasm/remote.h                       |    2 +-
 drivers/misc/lkdtm/bugs.c                          |   11 +-
 drivers/misc/lkdtm/cfi.c                           |    3 +-
 drivers/misc/lkdtm/core.c                          |   58 +-
 drivers/misc/lkdtm/fortify.c                       |    3 +-
 drivers/misc/lkdtm/heap.c                          |   97 +-
 drivers/misc/lkdtm/lkdtm.h                         |   46 +-
 drivers/misc/lkdtm/stackleak.c                     |    4 +-
 drivers/misc/lkdtm/usercopy.c                      |    7 +-
 drivers/misc/mei/bus-fixup.c                       |    2 +-
 drivers/misc/mei/client.c                          |   22 +-
 drivers/misc/mei/hbm.c                             |    2 +-
 drivers/misc/mei/hdcp/Kconfig                      |    1 -
 drivers/misc/mei/hw-me.c                           |    4 +-
 drivers/misc/mei/hw.h                              |   28 +-
 drivers/misc/mei/interrupt.c                       |   23 +-
 drivers/misc/mei/main.c                            |    4 +-
 drivers/misc/mei/pci-txe.c                         |    2 +-
 drivers/misc/pvpanic/pvpanic-mmio.c                |   17 +-
 drivers/misc/pvpanic/pvpanic-pci.c                 |   22 +-
 drivers/misc/pvpanic/pvpanic.c                     |   33 +-
 drivers/misc/pvpanic/pvpanic.h                     |    3 +-
 drivers/misc/uacce/uacce.c                         |   11 +-
 drivers/misc/vmw_vmci/vmci_context.c               |    2 +-
 drivers/misc/xilinx_sdfec.c                        |    3 -
 drivers/net/ethernet/sun/ldmvsw.c                  |    4 +-
 drivers/net/ethernet/sun/sunvnet.c                 |    3 +-
 drivers/nvmem/core.c                               |   23 +-
 drivers/nvmem/qfprom.c                             |    9 +-
 drivers/nvmem/sprd-efuse.c                         |    2 +-
 drivers/nvmem/sunxi_sid.c                          |    1 +
 drivers/parport/probe.c                            |   11 +-
 drivers/phy/Kconfig                                |    9 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/broadcom/phy-bcm-ns-usb3.c             |    4 +-
 drivers/phy/marvell/phy-mmp3-hsic.c                |    4 +-
 drivers/phy/mediatek/phy-mtk-hdmi.c                |    4 +-
 drivers/phy/mediatek/phy-mtk-mipi-dsi.c            |    4 +-
 drivers/phy/phy-can-transceiver.c                  |  146 ++
 drivers/phy/phy-core-mipi-dphy.c                   |    2 +-
 drivers/phy/phy-core.c                             |   16 +-
 drivers/phy/phy-xgene.c                            |    3 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                |  315 ++-
 drivers/phy/qualcomm/phy-qcom-qmp.h                |  189 +-
 drivers/phy/ralink/Kconfig                         |    2 +-
 drivers/phy/ralink/phy-mt7621-pci.c                |   37 +-
 drivers/phy/rockchip/Kconfig                       |    9 +
 drivers/phy/rockchip/Makefile                      |    1 +
 drivers/phy/rockchip/phy-rockchip-inno-csidphy.c   |  459 ++++
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c      |    4 +-
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      |   44 +
 drivers/phy/socionext/phy-uniphier-pcie.c          |   11 +-
 drivers/phy/st/phy-stm32-usbphyc.c                 |   31 +
 drivers/phy/ti/phy-dm816x-usb.c                    |   17 +-
 drivers/phy/ti/phy-twl4030-usb.c                   |    6 +-
 drivers/pnp/card.c                                 |    7 +-
 drivers/pnp/driver.c                               |    9 +-
 drivers/pnp/isapnp/compat.c                        |    1 -
 drivers/pnp/isapnp/proc.c                          |   13 +-
 drivers/pnp/manager.c                              |    7 +-
 drivers/pnp/support.c                              |    1 -
 drivers/siox/siox-bus-gpio.c                       |   19 +-
 drivers/soundwire/Kconfig                          |    1 +
 drivers/soundwire/bus.c                            |  163 +-
 drivers/soundwire/cadence_master.c                 |   21 +-
 drivers/soundwire/cadence_master.h                 |    3 -
 drivers/soundwire/dmi-quirks.c                     |    2 +-
 drivers/soundwire/generic_bandwidth_allocation.c   |   14 +-
 drivers/soundwire/intel.c                          |   56 +-
 drivers/soundwire/intel.h                          |   14 +-
 drivers/soundwire/intel_init.c                     |  232 +-
 drivers/soundwire/slave.c                          |    4 +-
 drivers/soundwire/stream.c                         |   13 +-
 drivers/tty/vcc.c                                  |    4 +-
 drivers/uio/Kconfig                                |    2 +-
 drivers/uio/uio_aec.c                              |    2 +-
 drivers/uio/uio_pci_generic.c                      |   32 +
 drivers/video/fbdev/Kconfig                        |    1 -
 drivers/virt/nitro_enclaves/ne_pci_dev.c           |    2 +
 drivers/visorbus/visorchipset.c                    |    6 +-
 drivers/w1/masters/ds2482.c                        |   94 +-
 drivers/w1/slaves/w1_ds2438.c                      |  122 +-
 drivers/w1/slaves/w1_therm.c                       |    5 +-
 drivers/watchdog/mei_wdt.c                         |    4 +-
 fs/block_dev.c                                     |    6 +-
 include/dt-bindings/interconnect/qcom,sc7280.h     |  165 ++
 include/linux/eeprom_93xx46.h                      |    3 +
 include/linux/fpga/altera-pr-ip-core.h             |    1 -
 include/linux/fpga/fpga-bridge.h                   |    2 +-
 include/linux/fpga/fpga-mgr.h                      |    2 +-
 include/linux/fs.h                                 |    3 -
 include/linux/mcb.h                                |    2 +-
 include/linux/nvmem-provider.h                     |    1 +
 include/linux/phy/phy.h                            |    2 +-
 include/linux/soundwire/sdw.h                      |    5 +-
 include/linux/soundwire/sdw_intel.h                |    6 +-
 include/linux/stm.h                                |    2 +-
 include/linux/sysfs.h                              |    6 +
 include/uapi/linux/raw.h                           |   17 -
 include/uapi/misc/habanalabs.h                     |   13 +
 lib/dynamic_debug.c                                |    6 +-
 sound/soc/intel/boards/sof_sdw.c                   |    4 +-
 tools/testing/selftests/lkdtm/config               |    7 +
 tools/testing/selftests/lkdtm/run.sh               |   12 +-
 tools/testing/selftests/lkdtm/stack-entropy.sh     |    1 +
 tools/testing/selftests/lkdtm/tests.txt            |   11 +-
 288 files changed, 11676 insertions(+), 2828 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-w1_ds2438
 create mode 100644 Documentation/ABI/testing/sysfs-class-spi-eeprom
 delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-sm5502.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/rcar-gen3-phy-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/phy/renesas,rcar-gen3-pcie-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip-usb-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
 delete mode 100644 drivers/char/raw.c
 create mode 100644 drivers/char/xillybus/xillybus_class.c
 create mode 100644 drivers/char/xillybus/xillybus_class.h
 create mode 100644 drivers/char/xillybus/xillyusb.c
 create mode 100644 drivers/interconnect/qcom/sc7280.c
 create mode 100644 drivers/interconnect/qcom/sc7280.h
 create mode 100644 drivers/phy/phy-can-transceiver.c
 create mode 100644 drivers/phy/rockchip/phy-rockchip-inno-csidphy.c
 create mode 100644 include/dt-bindings/interconnect/qcom,sc7280.h
 delete mode 100644 include/uapi/linux/raw.h
