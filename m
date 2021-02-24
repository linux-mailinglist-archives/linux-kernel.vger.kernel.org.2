Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DBB324093
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbhBXPOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:14:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:33958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235333AbhBXO2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:28:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 109DA64EF5;
        Wed, 24 Feb 2021 14:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614176865;
        bh=tcXJ3+GthtgFF9SXVbADzBWNYn96Lvf+eGr5xEJT49U=;
        h=Date:From:To:Cc:Subject:From;
        b=A3akqsJ27WQsJTHS8b9G3e1+bBfNxXpO5joHJan+1keBWXGPhR2iPpjhdADCrcZrH
         Jidu16NskwJjCJMZnLueXoudC4jBS4UwFb9tWu/rxz24lMO6GsUQZokpXl+dpnflux
         BxSIXKxZu10Gu+loqHTWOKMPbNWtcRS9Crm9AHyQ=
Date:   Wed, 24 Feb 2021 15:27:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver changes for 5.12-rc1
Message-ID: <YDZiWiBZsuTaPatM@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04:

  Linux 5.11-rc5 (2021-01-24 16:47:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.12-rc1

for you to fetch changes up to d19db80a366576d3ffadf2508ed876b4c1faf959:

  spmi: spmi-pmic-arb: Fix hw_irq overflow (2021-02-12 12:26:46 +0100)

----------------------------------------------------------------
Char/Misc driver patches for 5.12-rc1

Here is the large set of char/misc/whatever driver subsystem updates for
5.12-rc1.  Over time it seems like this tree is collecting more and more
tiny driver subsystems in one place, making it easier for those
maintainers, which is why this is getting larger.

Included in here are:
	- coresight driver updates
	- habannalabs driver updates
	- virtual acrn driver addition (proper acks from the x86
	  maintainers)
	- broadcom misc driver addition
	- speakup driver updates
	- soundwire driver updates
	- fpga driver updates
	- amba driver updates
	- mei driver updates
	- vfio driver updates
	- greybus driver updates
	- nvmeem driver updates
	- phy driver updates
	- mhi driver updates
	- interconnect driver udpates
	- fsl-mc bus driver updates
	- random driver fix
	- some small misc driver updates (rtsx, pvpanic, etc.)

All of these have been in linux-next for a while, with the only reported
issue being a merge conflict in include/linux/mod_devicetable.h that you
will hit in your tree due to the dfl_device_id addition from the fpga
subsystem in here.  The resolution should be simple.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ahmad Fatoum (1):
      nvmem: core: skip child nodes not matching binding

Alexander Kapshuk (1):
      ver_linux: Eliminate duplicate code in ldconfig processing logic

Alexander Usyskin (10):
      mei: fix transfer over dma with extended header
      mei: hbm: call mei_set_devstate() on hbm stop response
      mei: hbm: drop hbm responses on shutdown
      mei: me: add adler lake point S DID
      mei: me: add adler lake point LP DID
      mei: allow clients on bus to communicate in remove callback
      mei: add support for client dma capability
      mei: hbm: add client dma hbm messages
      mei: implement client dma setup.
      mei: bus: block send with vtag on non-conformat FW

Alexandre Belloni (1):
      misc: remove atmel_tclib

Alexandru Ardelean (1):
      MAINTAINERS: replace my with email with replacements

Alon Mizrahi (2):
      habanalabs: replace WARN/WARN_ON with dev_crit in driver
      habanalabs: return dram virtual address in info ioctl

Amelie Delaunay (6):
      dt-bindings: phy: phy-stm32-usbphyc: move PLL supplies to parent node
      phy: stm32: manage 1v1 and 1v8 supplies at pll activation/deactivation
      phy: stm32: replace regulator_bulk* by multiple regulator_*
      phy: stm32: ensure pll is disabled before phys creation
      phy: stm32: ensure phy are no more active when removing the driver
      phy: stm32: rework PLL Lock detection

Andy Shevchenko (2):
      misc: pti: Remove driver for deprecated platform
      misc: pti: Remove a leftover in documentation

AngeloGioacchino Del Regno (3):
      phy: qcom-qusb2: Allow specifying default clock scheme
      phy: qcom-qusb2: Add configuration for SDM660
      dt-bindings: phy: qcom-qusb2: Document SDM660 compatible

Aswath Govindraju (5):
      misc: eeprom_93xx46: Fix module alias to enable module autoprobe
      misc: eeprom_93xx46: Enable module autoprobe for microchip 93LC46B eeprom
      misc: eeprom_93xx46: Add module alias to avoid breaking support for non device tree users
      Documentation: devicetree: Add new compatible string for eeprom microchip 93LC46B
      misc: eeprom_93xx46: Add quirk to support Microchip 93LC46B eeprom

Bard Liao (6):
      soundwire: intel: don't return error when clock stop failed
      soundwire: bus: add more details to track failed transfers
      soundwire: export sdw_write/read_no_pm functions
      regmap: sdw: use _no_pm functions in regmap_read/write
      regmap: sdw: use no_pm routines for SoundWire 1.2 MBQ
      regmap: sdw-mbq: use MODULE_LICENSE("GPL")

Baruch Siach (1):
      dt-bindings: phy: qcom,qusb2: document ipq6018 compatible

Bert Vermeulen (1):
      spdxcheck.py: Use Python 3

Bjorn Andersson (4):
      dt-bindings: phy: qcom,qmp: Add SC8180X UFS to the QMP binding
      dt-bindings: phy: qcom,qmp: Add SC8180X USB phy
      phy: qcom-qmp: Add SC8180X UFS phy
      phy: qcom-qmp: Add SC8180X USB phy

Boris Brezillon (1):
      phy: mediatek: Add missing MODULE_DEVICE_TABLE()

Carl Huang (1):
      mhi: use irq_flags if controller driver configures it

Chao Song (1):
      soundwire: return earlier if no slave is attached

Chris Ruehl (3):
      phy: rockchip-emmc: emmc_phy_init() always return 0
      devicetree: phy: rockchip-emmc optional add vendor prefix
      phy: rockchip: emmc, add vendor prefix to dts properties

Christian Vogel (2):
      w1/w1.c: w1 address crc quick for DS28E04 eeproms
      w1/masters/ds2490: queue up found IDs during scan

Christophe JAILLET (1):
      habanalabs: Use 'dma_set_mask_and_coherent()'

Chunfeng Yun (5):
      dt-bindings: phy: convert phy-mtk-xsphy.txt to YAML schema
      dt-bindings: phy: convert phy-mtk-tphy.txt to YAML schema
      dt-bindings: phy: convert phy-mtk-ufs.txt to YAML schema
      dt-bindings: phy: convert HDMI PHY binding to YAML schema
      dt-bindings: phy: convert MIPI DSI PHY binding to YAML schema

Chunyan Zhang (1):
      coresight: etm4x: add AMBA id for Cortex-A55 and Cortex-A75

Colin Ian King (1):
      phy: qcom-qmp: make a const array static, makes object smaller

Dan Carpenter (5):
      phy: cadence-torrent: Fix error code in cdns_torrent_phy_probe()
      misc: bcm-vk: unlock on error in bcm_to_h_msg_dequeue()
      misc: bcm-vk: Fix a couple error codes in probe()
      nvmem: core: Fix a resource leak on error in nvmem_add_cells_from_of()
      bus: fsl-mc: Fix test for end of loop

Davidlohr Bueso (1):
      platform/goldfish: Convert pipe tasklet to threaded irq

Desmond Yan (1):
      misc: bcm-vk: fix set_q_num API precedence issue

Eric Biggers (1):
      random: fix the RNDRESEEDCRNG ioctl

Fabio Estevam (1):
      nvmem: imx-iim: Use of_device_get_match_data()

Geert Uytterhoeven (2):
      phy: USB_LGM_PHY should depend on X86
      uapi: map_to_7segment: Update example in documentation

Georgi Djakov (2):
      Merge branch 'icc-msm8939' into icc-next
      Merge branch 'icc-sdx55' into icc-next

Greg Kroah-Hartman (12):
      Merge 5.11-rc3 into char-misc-next
      Merge tag 'fpga-cleanup-for-5.12' of git://git.kernel.org/.../mdf/linux-fpga into char-misc-next
      Merge 5.11-rc5 into char-misc-next
      Merge tag 'misc-habanalabs-next-2021-01-27' of https://git.kernel.org/.../ogabbay/linux into char-misc-next
      Merge tag 'icc-5.12-rc1' of git://git.kernel.org/.../djakov/icc into char-misc-next
      Merge branch 'devel-stable' of git://git.armlinux.org.uk/~rmk/linux-arm into char-misc-next
      Merge tag 'mhi-for-v5.12' of git://git.kernel.org/.../mani/mhi into char-misc-next
      Merge tag 'soundwire-5.12-rc1' of git://git.kernel.org/.../vkoul/soundwire into char-misc-next
      Merge tag 'phy-for-5.12' of git://git.kernel.org/.../phy/linux-phy into char-misc-next
      Merge tag 'misc-habanalabs-next-2021-02-08' of https://git.kernel.org/.../ogabbay/linux into char-misc-next
      Merge tag 'phy-fixes2-5.11' of git://git.kernel.org/.../phy/linux-phy into char-misc-next
      Merge tag 'soundwire-2_5.12-rc1' of git://git.kernel.org/.../vkoul/soundwire into char-misc-next

Hans de Goede (1):
      virt: vbox: Do not use wait_event_interruptible when called from kernel context

Hemant Kumar (1):
      bus: mhi: core: Add helper API to return number of free TREs

Ioana Ciornei (7):
      bus: fsl-mc: move fsl_mc_command struct in a uapi header
      bus: fsl-mc: export mc_cmd_hdr_read_cmdid() to the fsl-mc bus
      bus: fsl-mc: add fsl-mc userspace support
      bus: fsl-mc: add bus rescan attribute
      bus: fsl-mc: add autorescan sysfs
      bus: fsl-mc: add the dpdbg device type
      bus: fsl-mc: list more commands as accepted through the ioctl

Ivan Zaentsev (1):
      w1: w1_therm: Fix conversion result for negative temperatures

Jack Pham (3):
      dt-bindings: phy: qcom,qmp: Add SM8150, SM8250 and SM8350 USB PHY bindings
      phy: qcom-qmp: Add SM8350 USB QMP PHYs
      dt-bindings: phy: qcom,usb-snps-femto-v2: Add SM8250 and SM8350 bindings

Jie Li (1):
      uio: uio_pci_generic: don't fail probe if pdev->irq equals to IRQ_NOTCONNECTED

Joe Perches (1):
      misc: pvpanic: sysfs_emit uses should have a newline

Johan Hovold (1):
      greybus: es2: drop short control-transfer checks

Jonathan Marek (1):
      misc: fastrpc: fix incorrect usage of dma_map_sgtable

Jonathan Zhou (2):
      arm64: Add TRFCR_ELx definitions
      coresight: Add support for v8.4 SelfHosted tracing

Jorgen Hansen (3):
      VMCI: Stop log spew when qp allocation isn't possible
      VMCI: Use set_page_dirty_lock() when unregistering guest memory
      VMCI: Enforce queuepair max size for IOCTL_VMCI_QUEUEPAIR_ALLOC

Jun Nie (5):
      interconnect: qcom: Consolidate interconnect RPM support
      interconnect: qcom: qcs404: use shared code
      dt-bindings: interconnect: single yaml file for RPM interconnect drivers
      dt-bindings: interconnect: Add Qualcomm MSM8939 DT bindings
      interconnect: qcom: Add MSM8939 interconnect provider driver

Kathiravan T (1):
      phy: qcom-qusb2: add QUSB2 support for IPQ6018

Konrad Dybcio (1):
      phy: qualcomm: usb28nm: Add MDM9607 init sequence

Laurentiu Tudor (1):
      bus: fsl-mc: add missing __iomem attribute

Leo Yan (2):
      coresight: etm-perf: Clarify comment on perf options
      Documentation: coresight: Add PID tracing description

Loic Poulain (17):
      bus: mhi: core: Add device hardware reset support
      mhi: pci-generic: Increase number of hardware events
      mhi: pci_generic: Enable burst mode for hardware channels
      mhi: pci_generic: Add support for reset
      mhi: pci_generic: Add suspend/resume/recovery procedure
      mhi: pci_generic: Add PCI error handlers
      mhi: pci_generic: Add health-check
      mhi: pci_generic: Increase controller timeout value
      mhi: pci_generic: Add diag channels
      mhi: pci_generic: Set irq moderation value to 1ms for hw channels
      bus: mhi: Ensure correct ring update ordering with memory barrier
      mhi: unconstify mhi_event_config
      mhi: pci_generic: Fix shared MSI vector support
      mhi: core: Factorize mhi queuing
      mhi: pci_generic: Print warning in case of firmware crash
      bus: mhi: pci_generic: Increase num of elements in hw event ring
      mhi: Fix double dma free

Lukas Bulwahn (1):
      fpga: dfl-pci: rectify ReST formatting

Manivannan Sadhasivam (6):
      dt-bindings: phy: qcom,qmp: Add SDX55 USB PHY binding
      phy: qcom-qmp: Add support for SDX55 QMP PHY
      Merge branch 'mhi-ath11k-immutable' into mhi-next
      dt-bindings: interconnect: Add Qualcomm SDX55 DT bindings
      interconnect: qcom: Add SDX55 interconnect provider driver
      Merge branch 'mhi-net-immutable' into mhi-next

Marcin Ślusarz (1):
      soundwire: intel: fix possible crash when no device is detected

Markus Elfring (1):
      coresight: cti: Reduce scope for the variable 'cs_fwnode' in cti_plat_create_connection()

Mathias Kresin (1):
      phy: lantiq: rcu-usb2: wait after clock enable

Matthew Gerlach (2):
      fpga: dfl: refactor cci_enumerate_feature_devs()
      fpga: dfl-pci: locate DFLs by PCIe vendor specific capability

Mauro Carvalho Chehab (1):
      dt-bindings: phy: update phy-cadence-sierra.yaml reference

Michal Simek (3):
      firmware: xilinx: Remove PM_API_MAX value
      phy: zynqmp: Simplify code by using dev_err_probe()
      firmware: xilinx: Use explicit values for all enum values

Moti Haimovski (2):
      habanalabs: report dram_page_size in hw_ip_info ioctl
      habanalabs: support non power-of-2 DRAM phys page sizes

Nicolas Saenz Julienne (3):
      dt-bindings: nvmem: Add bindings for rmem driver
      nvmem: Add driver to expose reserved memory as nvmem
      nvmem: Kconfig: Correct typo in NVMEM_RMEM

Oded Gabbay (12):
      habanalabs: update firmware boot interface
      habanalabs: add ASIC property of functional HBMs
      habanalabs: update to latest hl_boot_if.h
      habanalabs: update email address in sysfs/debugfs docs
      CREDITS: update email address and home address
      habanalabs: update SyncManager interrupt handling
      habanalabs/gaudi: unmask HBM interrupts after handling
      habanalabs: update to latest hl_boot_if.h spec from F/W
      habanalabs: fix integer handling issue
      habanalabs: enable F/W events after init done
      habanalabs: return block size + block ID
      habanalabs/gaudi: don't enable clock gating on DMA5

Ofir Bitton (22):
      habanalabs: Init the VM module for kernel context
      habanalabs/gaudi: support CS with no completion
      habanalabs: allow user to pass a staged submission seq
      habanalabs/gaudi: remove duplicated gaudi packets masks
      habanalabs/gaudi: add debug prints for security status
      habanalabs/gaudi: set uninitialized symbol
      habanalabs: remove access to kernel memory using debugfs
      habanalabs: report correct dram size in info ioctl
      habanalabs: read device boot errors after cpucp is up
      habanalabs: separate common code to dedicated folders
      habanalabs: increment ctx ref from within a cs allocation
      habanalabs: add driver support for internal cb scheduling
      habanalabs/gaudi: remove PCI access to SM block
      habanalabs/gaudi: print sync manager SEI interrupt info
      habanalabs: ignore F/W BMC errors in case no BMC present
      habanalabs: add security violations dump to debugfs
      habanalabs: add user available interrupt to hw_ip
      habanalabs: add new mem ioctl op for mapping hw blocks
      habanalabs: add CS completion and timeout properties
      habanalabs: staged submission support
      habanalabs: improve communication protocol with cpucp
      habanalabs: support fetching first available user CQ

Ohad Sharabi (6):
      habanalabs: refactor MMU locks code
      habanalabs/goya: move mmu_prepare to context init
      habanalabs: modify device_idle interface
      habanalabs: fix ETR security issue
      habanalabs/gaudi: use HBM_ECC_EN bit for ECC ERR
      habanalabs: update security map after init CPU Qs

Omer Shpigelman (2):
      habanalabs: kernel doc format in memory functions
      habanalabs: modify memory functions signatures

Paul Cercueil (1):
      phy: ingenic: Remove useless field .version

Pierre-Louis Bossart (11):
      soundwire: cadence: reduce timeout on transactions
      soundwire: use consistent format for Slave devID logs
      soundwire: cadence: add status in dev_dbg 'State change' log
      soundwire: cadence: fix ACK/NAK handling
      soundwire: cadence: adjust verbosity in response handling
      soundwire: bus: add better dev_dbg to track complete() calls
      soundwire: bus: use sdw_update_no_pm when initializing a device
      soundwire: bus: use sdw_write_no_pm when setting the bus scale registers
      soundwire: bus: use no_pm IO routines for all interrupt handling
      soundwire: bus: fix confusion on device used by pm_runtime
      soundwire: bus: clarify dev_err/dbg device references

Rafał Miłecki (5):
      phy: phy-brcm-usb: improve getting OF matching data
      phy: phy-brcm-usb: specify init function format at struct level
      dt-bindings: phy: brcm, brcmstb-usb-phy: convert to the json-schema
      dt-bindings: phy: brcm, brcmstb-usb-phy: add BCM4908 binding
      phy: phy-brcm-usb: support PHY on the BCM4908

Randy Dunlap (1):
      ACRN: update MAINTAINERS: mailing list is subscribers-only

Ricky Wu (2):
      misc: rtsx: remove unused function
      misc: rtsx: init of rts522a add OCP power off when no card is present

Rikard Falkeborn (3):
      fpga: dfl: fme: Constify static attribute_group structs
      soundwire: sysfs: Constify static struct attribute_group
      most: core: Constify static attribute_group structs

Russell King (1):
      Merge tag 'amba-make-remove-return-void' of https://git.pengutronix.de/git/ukl/linux into devel-stable

Sabyrzhan Tasbolatov (1):
      drivers/misc/vmw_vmci: restrict too big queue size in qp_host_alloc_queue

Samuel Thibault (6):
      speakup: add the missing synth parameter to all io functions
      speakup: Reference synth from tty and tty from synth
      speakup: Simplify spk_ttyio_out error handling.
      speakup: Add documentation on changing the speakup messages language
      speakup ABI: Advertise synth parameters for all synths
      speakup: Make dectlk flush timeout configurable

Scott Branden (14):
      bcm-vk: add bcm_vk UAPI
      misc: bcm-vk: add Broadcom VK driver
      misc: bcm-vk: add autoload support
      misc: bcm-vk: add misc device to Broadcom VK driver
      misc: bcm-vk: add triggers when host panic or reboots to notify card
      misc: bcm-vk: add open/release
      misc: bcm-vk: add ioctl load_image
      misc: bcm-vk: add get_card_info, peerlog_info, and proc_mon_info
      misc: bcm-vk: add VK messaging support
      misc: bcm-vk: reset_pid support
      misc: bcm-vk: add mmap function for exposing BAR2
      MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
      misc: bcm-vk: add ttyVK support
      misc: bcm-vk: only support ttyVK if CONFIG_TTY is set

Shuo Liu (17):
      docs: acrn: Introduce ACRN
      x86/acrn: Introduce acrn_{setup, remove}_intr_handler()
      x86/acrn: Introduce hypercall interfaces
      virt: acrn: Introduce ACRN HSM basic driver
      virt: acrn: Introduce VM management interfaces
      virt: acrn: Introduce an ioctl to set vCPU registers state
      virt: acrn: Introduce EPT mapping management
      virt: acrn: Introduce I/O request management
      virt: acrn: Introduce PCI configuration space PIO accesses combiner
      virt: acrn: Introduce interfaces for PCI device passthrough
      virt: acrn: Introduce interrupt injection interfaces
      virt: acrn: Introduce interfaces to query C-states and P-states allowed by hypervisor
      virt: acrn: Introduce I/O ranges operation interfaces
      virt: acrn: Introduce ioeventfd
      virt: acrn: Introduce irqfd
      virt: acrn: Introduce an interface for Service VM to control vCPU
      sample/acrn: Introduce a sample of HSM ioctl interface usage

Srinivas Kandagatla (1):
      soundwire: debugfs: use controller id instead of link_id

Subbaraman Narayanamurthy (2):
      nvmem: qcom-spmi-sdam: Fix uninitialized pdev pointer
      spmi: spmi-pmic-arb: Fix hw_irq overflow

Suzuki K Poulose (28):
      coresight: etm4x: Handle access to TRCSSPCICRn
      coresight: etm4x: Skip accessing TRCPDCR in save/restore
      coresight: Introduce device access abstraction
      coresight: tpiu: Prepare for using coresight device access abstraction
      coresight: Convert coresight_timeout to use access abstraction
      coresight: Convert claim/disclaim operations to use access wrappers
      coresight: etm4x: Always read the registers on the host CPU
      coresight: etm4x: Convert all register accesses
      coresight: etm4x: Make offset available for sysfs attributes
      coresight: etm4x: Add commentary on the registers
      coresight: etm4x: Add sysreg access helpers
      coresight: etm4x: Hide sysfs attributes for unavailable registers
      coresight: etm4x: Define DEVARCH register fields
      coresight: etm4x: Check for Software Lock
      coresight: etm4x: Cleanup secure exception level masks
      coresight: etm4x: Clean up exception level masks
      coresight: etm4x: Handle ETM architecture version
      coresight: etm4x: Detect access early on the target CPU
      coresight: etm4x: Use TRCDEVARCH for component discovery
      coresight: etm4x: Expose trcdevarch via sysfs
      coresight: etm4x: Add necessary synchronization for sysreg access
      coresight: etm4x: Detect system instructions support
      coresight: etm4x: Refactor probing routine
      coresight: etm4x: Run arch feature detection on the CPU
      coresight: etm4x: Add support for sysreg only devices
      dts: bindings: coresight: ETM system register access only units
      coresight: etm4x: Handle accesses to TRCSTALLCTLR
      coresight: etm-perf: Support PID tracing for kernel at EL2

Tian Tao (1):
      phy: cpcap-usb: remove unneeded conversion to bool

Tom Rix (2):
      greybus: remove h from printk format specifier
      sgi-xp: remove h from printk format specifier

Tomas Winkler (3):
      mei: document that mei_msg_hdr_init returns ERR_PTR
      mei: me: emmitsburg workstation DID
      mei: use sysfs_emit() in tx_queue_limit_show sysfs

Uwe Kleine-König (14):
      amba: Fix resource leak for drivers without .remove
      amba: reorder functions
      vfio: platform: simplify device removal
      amba: Make the remove callback return void
      amba: Make use of bus_type functions
      ARM: 9055/1: mailbox: arm_mhuv2: make remove callback return void
      coresight: etm4x: Fix merge resolution for amba rework
      mei: bus: simplify mei_cl_device_remove()
      mei: bus: change remove callback to return void
      ipack: Fail earlier for drivers without probe function
      ipack: Handle a driver without remove callback
      firmware: google: make coreboot driver's remove callback return void
      vme: make remove callback return void
      firewire: replace tricky statement by two simple ones

Vinod Koul (5):
      MAINTAINERS: soundwire: Add soundwire tree
      dt-bindings: phy: qcom,qmp: Add SM8350 UFS PHY bindings
      phy: qcom-qmp: Add UFS V5 registers found in SM8350
      phy: qcom-qmp: Add support for SM8350 UFS phy
      soundwire: Revert "soundwire: debugfs: use controller id instead of link_id"

Xu Yilun (6):
      fpga: dfl: fix the definitions of type & feature_id for dfl devices
      fpga: dfl: move dfl_device_id to mod_devicetable.h
      fpga: dfl: add dfl bus support to MODULE_DEVICE_TABLE()
      fpga: dfl: move dfl bus related APIs to include/linux/dfl.h
      fpga: dfl: add support for N3000 Nios private feature
      memory: dfl-emif: add the DFL EMIF private feature driver

Yang Li (4):
      misc: rtsx: Remove unneeded return variable
      phy: phy-brcm-sata: remove unneeded semicolon
      cxl: Simplify bool conversion
      phy: cpcap-usb: Simplify bool conversion

Yin Fengwei (1):
      x86/acrn: Introduce acrn_cpuid_base() and hypervisor feature bits

Zheng Yongjun (3):
      misc: ocxl: use DEFINE_MUTEX() for mutex lock
      soundwire: intel: Use kzalloc for allocating only one thing
      fpga: Use DEFINE_SPINLOCK() for spinlock

Zou Wei (1):
      phy: mediatek: Mark mtk_mipi_tx_driver with static keyword

farah kassabri (2):
      habanalabs: always try to use the hint address
      habanalabs: fix MMU debugfs related nodes

mateng (1):
      misc/vmw_vmci: fix typo

zhenwei pi (2):
      misc: pvpanic: introduce device capability
      misc: pvpanic: introduce events device attribue

 CREDITS                                            |    8 +-
 Documentation/ABI/stable/sysfs-bus-fsl-mc          |   19 +
 Documentation/ABI/stable/sysfs-driver-speakup      |   37 +-
 .../ABI/testing/debugfs-driver-habanalabs          |   50 +-
 .../ABI/testing/sysfs-bus-coresight-devices-etm4x  |    8 +
 .../ABI/testing/sysfs-bus-dfl-devices-emif         |   25 +
 .../ABI/testing/sysfs-bus-dfl-devices-n3000-nios   |   47 +
 .../ABI/testing/sysfs-bus-pci-devices-pvpanic      |   24 +
 Documentation/ABI/testing/sysfs-driver-habanalabs  |   58 +-
 Documentation/admin-guide/spkguide.txt             |   48 +-
 .../devicetree/bindings/arm/coresight.txt          |    5 +-
 .../bindings/display/mediatek/mediatek,dsi.txt     |   18 +-
 .../bindings/display/mediatek/mediatek,hdmi.txt    |   18 +-
 .../bindings/interconnect/qcom,qcs404.yaml         |   77 -
 .../{qcom,msm8916.yaml => qcom,rpm.yaml}           |   22 +-
 .../bindings/interconnect/qcom,rpmh.yaml           |    4 +
 .../devicetree/bindings/misc/eeprom-93xx46.txt     |    1 +
 Documentation/devicetree/bindings/nvmem/rmem.yaml  |   49 +
 .../bindings/phy/brcm,brcmstb-usb-phy.txt          |   86 -
 .../bindings/phy/brcm,brcmstb-usb-phy.yaml         |  196 +++
 .../devicetree/bindings/phy/mediatek,dsi-phy.yaml  |   85 +
 .../devicetree/bindings/phy/mediatek,hdmi-phy.yaml |   92 ++
 .../devicetree/bindings/phy/mediatek,tphy.yaml     |  260 +++
 .../devicetree/bindings/phy/mediatek,ufs-phy.yaml  |   64 +
 .../devicetree/bindings/phy/mediatek,xsphy.yaml    |  199 +++
 .../devicetree/bindings/phy/phy-mtk-tphy.txt       |  162 --
 .../devicetree/bindings/phy/phy-mtk-ufs.txt        |   38 -
 .../devicetree/bindings/phy/phy-mtk-xsphy.txt      |  109 --
 .../devicetree/bindings/phy/phy-stm32-usbphyc.yaml |   22 +-
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |   97 ++
 .../devicetree/bindings/phy/qcom,qusb2-phy.yaml    |    2 +
 .../devicetree/bindings/phy/qcom,usb-hs-28nm.yaml  |    1 +
 .../bindings/phy/qcom,usb-snps-femto-v2.yaml       |    2 +
 .../devicetree/bindings/phy/rockchip-emmc-phy.txt  |   10 +-
 .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml  |    2 +-
 Documentation/driver-api/index.rst                 |    1 -
 Documentation/driver-api/pti_intel_mid.rst         |  108 --
 Documentation/fpga/dfl.rst                         |   28 +
 Documentation/trace/coresight/coresight.rst        |   32 +
 Documentation/userspace-api/ioctl/ioctl-number.rst |    2 +
 Documentation/virt/acrn/cpuid.rst                  |   46 +
 Documentation/virt/acrn/index.rst                  |   12 +
 Documentation/virt/acrn/introduction.rst           |   43 +
 Documentation/virt/acrn/io-request.rst             |   97 ++
 Documentation/virt/index.rst                       |    1 +
 MAINTAINERS                                        |   26 +-
 arch/arm64/include/asm/sysreg.h                    |   11 +
 arch/x86/include/asm/acrn.h                        |   78 +
 arch/x86/kernel/cpu/acrn.c                         |   16 +-
 drivers/accessibility/speakup/serialio.c           |   22 +-
 drivers/accessibility/speakup/speakup_acntpc.c     |    4 +-
 drivers/accessibility/speakup/speakup_apollo.c     |    4 +-
 drivers/accessibility/speakup/speakup_audptr.c     |    8 +-
 drivers/accessibility/speakup/speakup_decext.c     |    2 +-
 drivers/accessibility/speakup/speakup_decpc.c      |    4 +-
 drivers/accessibility/speakup/speakup_dectlk.c     |   13 +-
 drivers/accessibility/speakup/speakup_dtlk.c       |    4 +-
 drivers/accessibility/speakup/speakup_keypc.c      |    4 +-
 drivers/accessibility/speakup/speakup_ltlk.c       |    2 +-
 drivers/accessibility/speakup/speakup_soft.c       |    4 +-
 drivers/accessibility/speakup/speakup_spkout.c     |    4 +-
 drivers/accessibility/speakup/spk_priv.h           |    4 +-
 drivers/accessibility/speakup/spk_ttyio.c          |  185 +--
 drivers/accessibility/speakup/spk_types.h          |   17 +-
 drivers/accessibility/speakup/synth.c              |    9 +-
 drivers/accessibility/speakup/varhandlers.c        |    1 +
 drivers/amba/bus.c                                 |  234 +--
 drivers/base/regmap/regmap-sdw-mbq.c               |   10 +-
 drivers/base/regmap/regmap-sdw.c                   |    4 +-
 drivers/bus/fsl-mc/Kconfig                         |    7 +
 drivers/bus/fsl-mc/Makefile                        |    3 +
 drivers/bus/fsl-mc/dprc-driver.c                   |   33 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |  104 +-
 drivers/bus/fsl-mc/fsl-mc-private.h                |   49 +
 drivers/bus/fsl-mc/fsl-mc-uapi.c                   |  597 +++++++
 drivers/bus/fsl-mc/mc-sys.c                        |    2 +-
 drivers/bus/mhi/core/init.c                        |   12 +-
 drivers/bus/mhi/core/main.c                        |  194 +--
 drivers/bus/mhi/pci_generic.c                      |  381 ++++-
 drivers/char/hw_random/nomadik-rng.c               |    3 +-
 drivers/char/random.c                              |    2 +-
 drivers/dma/pl330.c                                |    3 +-
 drivers/firewire/core-device.c                     |    4 +-
 drivers/firmware/google/coreboot_table.c           |    5 +-
 drivers/firmware/google/coreboot_table.h           |    2 +-
 drivers/firmware/google/framebuffer-coreboot.c     |    4 +-
 drivers/firmware/google/memconsole-coreboot.c      |    4 +-
 drivers/firmware/google/vpd.c                      |    4 +-
 drivers/fpga/Kconfig                               |   11 +
 drivers/fpga/Makefile                              |    2 +
 drivers/fpga/dfl-fme-perf.c                        |    6 +-
 drivers/fpga/dfl-n3000-nios.c                      |  588 +++++++
 drivers/fpga/dfl-pci.c                             |  165 +-
 drivers/fpga/dfl.c                                 |    4 +-
 drivers/fpga/dfl.h                                 |   85 +-
 drivers/fpga/fpga-bridge.c                         |    4 +-
 drivers/gpu/drm/pl111/pl111_drv.c                  |    4 +-
 drivers/greybus/es2.c                              |    9 +-
 drivers/greybus/greybus_trace.h                    |    6 +-
 drivers/hwtracing/coresight/coresight-catu.c       |   15 +-
 drivers/hwtracing/coresight/coresight-core.c       |  122 +-
 drivers/hwtracing/coresight/coresight-cpu-debug.c  |    4 +-
 drivers/hwtracing/coresight/coresight-cti-core.c   |   22 +-
 .../hwtracing/coresight/coresight-cti-platform.c   |    6 +-
 drivers/hwtracing/coresight/coresight-etb10.c      |   14 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |   32 +-
 drivers/hwtracing/coresight/coresight-etm3x-core.c |   13 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c |  822 ++++++----
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |  189 ++-
 drivers/hwtracing/coresight/coresight-etm4x.h      |  505 +++++-
 drivers/hwtracing/coresight/coresight-funnel.c     |   11 +-
 drivers/hwtracing/coresight/coresight-replicator.c |   17 +-
 drivers/hwtracing/coresight/coresight-stm.c        |    8 +-
 drivers/hwtracing/coresight/coresight-tmc-core.c   |   20 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |   10 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |    4 +-
 drivers/hwtracing/coresight/coresight-tpiu.c       |   35 +-
 drivers/i2c/busses/i2c-nomadik.c                   |    4 +-
 drivers/input/serio/ambakmi.c                      |    3 +-
 drivers/interconnect/qcom/Kconfig                  |   18 +
 drivers/interconnect/qcom/Makefile                 |    6 +-
 drivers/interconnect/qcom/icc-rpm.c                |  191 +++
 drivers/interconnect/qcom/icc-rpm.h                |   73 +
 drivers/interconnect/qcom/msm8916.c                |  241 +--
 drivers/interconnect/qcom/msm8939.c                |  355 +++++
 drivers/interconnect/qcom/qcs404.c                 |  242 +--
 drivers/interconnect/qcom/sdx55.c                  |  356 +++++
 drivers/interconnect/qcom/sdx55.h                  |   70 +
 drivers/ipack/ipack.c                              |   11 +-
 drivers/mailbox/arm_mhuv2.c                        |    4 +-
 drivers/memory/Kconfig                             |    9 +
 drivers/memory/Makefile                            |    2 +
 drivers/memory/dfl-emif.c                          |  207 +++
 drivers/memory/pl172.c                             |    4 +-
 drivers/memory/pl353-smc.c                         |    4 +-
 drivers/misc/Kconfig                               |   22 +-
 drivers/misc/Makefile                              |    3 +-
 drivers/misc/atmel_tclib.c                         |  200 ---
 drivers/misc/bcm-vk/Kconfig                        |   29 +
 drivers/misc/bcm-vk/Makefile                       |   12 +
 drivers/misc/bcm-vk/bcm_vk.h                       |  549 +++++++
 drivers/misc/bcm-vk/bcm_vk_dev.c                   | 1652 ++++++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.c                   | 1357 ++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.h                   |  163 ++
 drivers/misc/bcm-vk/bcm_vk_sg.c                    |  275 ++++
 drivers/misc/bcm-vk/bcm_vk_sg.h                    |   61 +
 drivers/misc/bcm-vk/bcm_vk_tty.c                   |  339 ++++
 drivers/misc/cardreader/rts5227.c                  |    5 +
 drivers/misc/cardreader/rtsx_pcr.c                 |    9 +-
 drivers/misc/cxl/sysfs.c                           |    2 +-
 drivers/misc/eeprom/eeprom_93xx46.c                |   17 +
 drivers/misc/fastrpc.c                             |    7 +-
 drivers/misc/habanalabs/common/Makefile            |   10 +-
 drivers/misc/habanalabs/common/asid.c              |    6 +-
 drivers/misc/habanalabs/common/command_buffer.c    |    8 +-
 .../misc/habanalabs/common/command_submission.c    |  473 +++++-
 drivers/misc/habanalabs/common/context.c           |   33 +-
 drivers/misc/habanalabs/common/debugfs.c           |   43 +-
 drivers/misc/habanalabs/common/device.c            |   46 +-
 drivers/misc/habanalabs/common/firmware_if.c       |  157 +-
 drivers/misc/habanalabs/common/habanalabs.h        |  109 +-
 drivers/misc/habanalabs/common/habanalabs_ioctl.c  |   25 +-
 drivers/misc/habanalabs/common/hw_queue.c          |   51 +-
 drivers/misc/habanalabs/common/memory.c            |  621 +++++---
 drivers/misc/habanalabs/common/mmu/Makefile        |    2 +
 drivers/misc/habanalabs/common/{ => mmu}/mmu.c     |  124 +-
 drivers/misc/habanalabs/common/{ => mmu}/mmu_v1.c  |    4 +-
 drivers/misc/habanalabs/common/pci/Makefile        |    2 +
 drivers/misc/habanalabs/common/{ => pci}/pci.c     |   47 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              |  481 ++++--
 drivers/misc/habanalabs/gaudi/gaudiP.h             |    3 +
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c    |   18 +-
 drivers/misc/habanalabs/gaudi/gaudi_security.c     |    5 +
 drivers/misc/habanalabs/goya/goya.c                |  106 +-
 drivers/misc/habanalabs/goya/goyaP.h               |    1 +
 drivers/misc/habanalabs/goya/goya_coresight.c      |   11 +-
 drivers/misc/habanalabs/goya/goya_security.c       |    5 +
 drivers/misc/habanalabs/include/common/cpucp_if.h  |   14 +
 .../misc/habanalabs/include/common/hl_boot_if.h    |   19 +
 .../habanalabs/include/gaudi/gaudi_async_events.h  |    4 +
 .../misc/habanalabs/include/gaudi/gaudi_masks.h    |    5 +-
 .../misc/habanalabs/include/gaudi/gaudi_packets.h  |   27 +-
 .../habanalabs/include/goya/asic_reg/goya_masks.h  |    5 +-
 drivers/misc/mei/bus.c                             |   24 +-
 drivers/misc/mei/client.c                          |  291 +++-
 drivers/misc/mei/client.h                          |    8 +
 drivers/misc/mei/debugfs.c                         |    1 +
 drivers/misc/mei/hbm.c                             |  165 +-
 drivers/misc/mei/hbm.h                             |    4 +-
 drivers/misc/mei/hdcp/mei_hdcp.c                   |    7 +-
 drivers/misc/mei/hw-me-regs.h                      |    5 +
 drivers/misc/mei/hw.h                              |   61 +
 drivers/misc/mei/init.c                            |    5 +-
 drivers/misc/mei/interrupt.c                       |   43 +-
 drivers/misc/mei/main.c                            |    2 +-
 drivers/misc/mei/mei_dev.h                         |   18 +
 drivers/misc/mei/pci-me.c                          |    5 +
 drivers/misc/ocxl/file.c                           |    3 +-
 drivers/misc/pti.c                                 |  978 ------------
 drivers/misc/pvpanic.c                             |   59 +-
 drivers/misc/sgi-xp/xpnet.c                        |    4 +-
 drivers/misc/vmw_vmci/vmci_queue_pair.c            |   19 +-
 drivers/misc/vmw_vmci/vmci_queue_pair.h            |    2 +-
 drivers/mmc/host/mmci.c                            |    4 +-
 drivers/most/core.c                                |    6 +-
 drivers/nfc/microread/mei.c                        |    4 +-
 drivers/nfc/pn544/mei.c                            |    4 +-
 drivers/nvmem/Kconfig                              |    8 +
 drivers/nvmem/Makefile                             |    2 +
 drivers/nvmem/core.c                               |    5 +-
 drivers/nvmem/imx-iim.c                            |    7 +-
 drivers/nvmem/qcom-spmi-sdam.c                     |    7 +-
 drivers/nvmem/rmem.c                               |   97 ++
 drivers/of/platform.c                              |    1 +
 drivers/phy/Kconfig                                |    1 +
 drivers/phy/broadcom/Kconfig                       |    3 +-
 drivers/phy/broadcom/phy-brcm-sata.c               |    2 +-
 drivers/phy/broadcom/phy-brcm-usb.c                |   18 +-
 drivers/phy/cadence/phy-cadence-torrent.c          |    1 +
 drivers/phy/ingenic/phy-ingenic-usb.c              |   23 -
 drivers/phy/lantiq/phy-lantiq-rcu-usb2.c           |   10 +-
 drivers/phy/mediatek/phy-mtk-hdmi.c                |    1 +
 drivers/phy/mediatek/phy-mtk-mipi-dsi.c            |    3 +-
 drivers/phy/motorola/phy-cpcap-usb.c               |    2 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                |  430 ++++-
 drivers/phy/qualcomm/phy-qcom-qmp.h                |  147 ++
 drivers/phy/qualcomm/phy-qcom-qusb2.c              |   74 +-
 drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c        |   13 +
 drivers/phy/rockchip/phy-rockchip-emmc.c           |   12 +-
 drivers/phy/st/phy-stm32-usbphyc.c                 |  222 ++-
 drivers/phy/xilinx/phy-zynqmp.c                    |   11 +-
 drivers/platform/goldfish/goldfish_pipe.c          |   28 +-
 drivers/rtc/rtc-pl030.c                            |    4 +-
 drivers/rtc/rtc-pl031.c                            |    4 +-
 drivers/soundwire/bus.c                            |  179 ++-
 drivers/soundwire/cadence_master.c                 |   31 +-
 drivers/soundwire/intel.c                          |    8 +-
 drivers/soundwire/intel_init.c                     |    3 +-
 drivers/soundwire/slave.c                          |   10 +-
 drivers/soundwire/sysfs_slave.c                    |    2 +-
 drivers/spi/spi-pl022.c                            |    5 +-
 drivers/spmi/spmi-pmic-arb.c                       |    5 +-
 drivers/staging/vme/devices/vme_user.c             |    4 +-
 drivers/tty/Makefile                               |    2 -
 drivers/tty/n_tracerouter.c                        |  233 ---
 drivers/tty/n_tracesink.c                          |  228 ---
 drivers/tty/n_tracesink.h                          |   26 -
 drivers/tty/serial/amba-pl010.c                    |    4 +-
 drivers/tty/serial/amba-pl011.c                    |    3 +-
 drivers/uio/uio_pci_generic.c                      |    2 +-
 drivers/vfio/platform/vfio_amba.c                  |   15 +-
 drivers/video/fbdev/amba-clcd.c                    |    4 +-
 drivers/virt/Kconfig                               |    2 +
 drivers/virt/Makefile                              |    1 +
 drivers/virt/acrn/Kconfig                          |   15 +
 drivers/virt/acrn/Makefile                         |    3 +
 drivers/virt/acrn/acrn_drv.h                       |  227 +++
 drivers/virt/acrn/hsm.c                            |  470 ++++++
 drivers/virt/acrn/hypercall.h                      |  254 +++
 drivers/virt/acrn/ioeventfd.c                      |  273 ++++
 drivers/virt/acrn/ioreq.c                          |  657 ++++++++
 drivers/virt/acrn/irqfd.c                          |  235 +++
 drivers/virt/acrn/mm.c                             |  306 ++++
 drivers/virt/acrn/vm.c                             |  126 ++
 drivers/virt/vboxguest/vboxguest_utils.c           |   18 +-
 drivers/vme/vme.c                                  |    4 +-
 drivers/w1/masters/ds2490.c                        |   25 +-
 drivers/w1/slaves/w1_therm.c                       |   22 +-
 drivers/w1/w1.c                                    |   39 +-
 drivers/watchdog/mei_wdt.c                         |    4 +-
 drivers/watchdog/sp805_wdt.c                       |    4 +-
 include/dt-bindings/interconnect/qcom,msm8939.h    |  105 ++
 include/dt-bindings/interconnect/qcom,sdx55.h      |   76 +
 include/linux/amba/bus.h                           |    2 +-
 include/linux/coresight-pmu.h                      |   20 +-
 include/linux/coresight.h                          |  218 ++-
 include/linux/dfl.h                                |   86 +
 include/linux/eeprom_93xx46.h                      |    2 +
 include/linux/firmware/xlnx-zynqmp.h               |  339 ++--
 include/linux/fsl/mc.h                             |    8 +-
 include/linux/intel-pti.h                          |   35 -
 include/linux/mei_cl_bus.h                         |    2 +-
 include/linux/mhi.h                                |   22 +-
 include/linux/mod_devicetable.h                    |   24 +
 include/linux/soundwire/sdw.h                      |    2 +
 include/linux/vme.h                                |    2 +-
 include/linux/vmw_vmci_defs.h                      |    4 +-
 include/uapi/linux/acrn.h                          |  580 +++++++
 include/uapi/linux/fsl_mc.h                        |   34 +
 include/uapi/linux/map_to_7segment.h               |   11 +-
 include/uapi/linux/misc/bcm_vk.h                   |   84 +
 include/uapi/misc/habanalabs.h                     |   74 +-
 samples/acrn/Makefile                              |   12 +
 samples/acrn/guest.ld                              |    9 +
 samples/acrn/payload.ld                            |    9 +
 samples/acrn/vm-sample.c                           |  136 ++
 scripts/mod/devicetable-offsets.c                  |    4 +
 scripts/mod/file2alias.c                           |   13 +
 scripts/spdxcheck.py                               |    2 +-
 scripts/ver_linux                                  |   12 +-
 sound/arm/aaci.c                                   |    4 +-
 301 files changed, 19074 insertions(+), 5262 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-bus-fsl-mc
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
 create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic
 delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.yaml
 rename Documentation/devicetree/bindings/interconnect/{qcom,msm8916.yaml => qcom,rpm.yaml} (77%)
 create mode 100644 Documentation/devicetree/bindings/nvmem/rmem.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,hdmi-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,ufs-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-mtk-ufs.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt
 delete mode 100644 Documentation/driver-api/pti_intel_mid.rst
 create mode 100644 Documentation/virt/acrn/cpuid.rst
 create mode 100644 Documentation/virt/acrn/index.rst
 create mode 100644 Documentation/virt/acrn/introduction.rst
 create mode 100644 Documentation/virt/acrn/io-request.rst
 create mode 100644 arch/x86/include/asm/acrn.h
 create mode 100644 drivers/bus/fsl-mc/fsl-mc-uapi.c
 create mode 100644 drivers/fpga/dfl-n3000-nios.c
 create mode 100644 drivers/interconnect/qcom/icc-rpm.c
 create mode 100644 drivers/interconnect/qcom/icc-rpm.h
 create mode 100644 drivers/interconnect/qcom/msm8939.c
 create mode 100644 drivers/interconnect/qcom/sdx55.c
 create mode 100644 drivers/interconnect/qcom/sdx55.h
 create mode 100644 drivers/memory/dfl-emif.c
 delete mode 100644 drivers/misc/atmel_tclib.c
 create mode 100644 drivers/misc/bcm-vk/Kconfig
 create mode 100644 drivers/misc/bcm-vk/Makefile
 create mode 100644 drivers/misc/bcm-vk/bcm_vk.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_dev.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_tty.c
 create mode 100644 drivers/misc/habanalabs/common/mmu/Makefile
 rename drivers/misc/habanalabs/common/{ => mmu}/mmu.c (77%)
 rename drivers/misc/habanalabs/common/{ => mmu}/mmu_v1.c (99%)
 create mode 100644 drivers/misc/habanalabs/common/pci/Makefile
 rename drivers/misc/habanalabs/common/{ => pci}/pci.c (91%)
 delete mode 100644 drivers/misc/pti.c
 create mode 100644 drivers/nvmem/rmem.c
 delete mode 100644 drivers/tty/n_tracerouter.c
 delete mode 100644 drivers/tty/n_tracesink.c
 delete mode 100644 drivers/tty/n_tracesink.h
 create mode 100644 drivers/virt/acrn/Kconfig
 create mode 100644 drivers/virt/acrn/Makefile
 create mode 100644 drivers/virt/acrn/acrn_drv.h
 create mode 100644 drivers/virt/acrn/hsm.c
 create mode 100644 drivers/virt/acrn/hypercall.h
 create mode 100644 drivers/virt/acrn/ioeventfd.c
 create mode 100644 drivers/virt/acrn/ioreq.c
 create mode 100644 drivers/virt/acrn/irqfd.c
 create mode 100644 drivers/virt/acrn/mm.c
 create mode 100644 drivers/virt/acrn/vm.c
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8939.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sdx55.h
 create mode 100644 include/linux/dfl.h
 delete mode 100644 include/linux/intel-pti.h
 create mode 100644 include/uapi/linux/acrn.h
 create mode 100644 include/uapi/linux/fsl_mc.h
 create mode 100644 include/uapi/linux/misc/bcm_vk.h
 create mode 100644 samples/acrn/Makefile
 create mode 100644 samples/acrn/guest.ld
 create mode 100644 samples/acrn/payload.ld
 create mode 100644 samples/acrn/vm-sample.c
