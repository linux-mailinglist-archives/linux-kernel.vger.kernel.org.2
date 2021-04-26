Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38AED36B419
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 15:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbhDZN1l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Apr 2021 09:27:41 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:34423 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhDZN1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 09:27:40 -0400
X-Originating-IP: 90.89.138.59
Received: from xps13 (lfbn-tou-1-1325-59.w90-89.abo.wanadoo.fr [90.89.138.59])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id E3C8F1BF20B;
        Mon, 26 Apr 2021 13:26:54 +0000 (UTC)
Date:   Mon, 26 Apr 2021 15:26:47 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Changes for 5.13
Message-ID: <20210426152647.5522f59c@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This is the MTD PR for v5.13-rc1.

Thanks,
Miquèl


The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.13

for you to fetch changes up to a881537dfaf281bfcb94313d69dcf9ef8fc89afe:

  Revert "mtd: rawnand: bbt: Skip bad blocks when searching for the BBT in NAND" (2021-04-19 18:10:18 +0200)

----------------------------------------------------------------
MTD core:
* Handle possible -EPROBE_DEFER from parse_mtd_partitions()
* Constify buf in mtd_write_user_prot_reg()
* Constify name param in mtd_bdi_init
* Fix fall-through warnings for Clang
* Get rid of Big MTD Lock ouf of mtdchar
* Drop mtd_mutex usage from mtdchar_open()
* Don't lock when recursively deleting partitions
* Use module_mtd_blktrans() to register driver when relevant
* Parse MTD as NVMEM cells
* New OTP (one-time-programmable) erase ioctl
* Require write permissions for locking and badblock ioctls
* physmap:
  - Fix error return code of physmap_flash_remove()
  - physmap-bt1-rom: Fix unintentional stack access
* ofpart parser:
  - Support Linksys Northstar partitions
  - Make symbol 'bcm4908_partitions_quirks' static
  - Limit parsing of deprecated DT syntax
  - Support BCM4908 fixed partitions
* Qcom parser:
  - Incompatible with spi-nor 4k sectors
  - Fix error condition
  - Extend Qcom SMEM parser to SPI flash

CFI:
* Disable broken buffered writes for CFI chips within ID 0x2201
* Address a Coverity report for unused value

SPI NOR core:
* Add OTP support
* Fix module unload while an op in progress
* Add various cleanup patches
* Add Michael and Pratyush as designated reviewers in MAINTAINERS

SPI NOR controller drivers:
* intel-spi:
  - Move platform data header to x86 subfolder

NAND core:
* Fix error handling in nand_prog_page_op() (x2)
* Add a helper to retrieve the number of ECC bytes per step
* Add a helper to retrieve the number of ECC steps
* Let ECC engines advertize the exact number of steps
* ECC Hamming:
  - Populate the public nsteps field
  - Use the public nsteps field
* ECC BCH:
  - Populate the public nsteps field
  - Use the public nsteps field

Raw NAND core:
* Add support for secure regions in NAND memory
* Try not to use the ECC private structures
* Remove duplicate include in rawnand.h
* BBT:
  - Skip bad blocks when searching for the BBT in NAND (APPLIED THEN REVERTED)

Raw NAND controller drivers:
* Qcom:
  - Convert bindings to YAML
  - Use dma_mapping_error() for error check
  - Add missing nand_cleanup() in error path
  - Return actual error code instead of -ENODEV
  - Update last code word register
  - Add helper to configure location register
  - Rename parameter name in macro
  - Add helper to check last code word
  - Convert nandc to chip in Read/Write helper
  - Update register macro name for 0x2c offset
* GPMI:
  - Fix a double free in gpmi_nand_init
* Rockchip:
  - Use flexible-array member instead of zero-length array
* Atmel:
  - Update ecc_stats.corrected counter
* MXC:
  - Remove unneeded of_match_ptr()
* R852:
  - replace spin_lock_irqsave by spin_lock in hard IRQ
* Brcmnand:
  - Move to polling in pio mode on oops write
  - Read/write oob during EDU transfer
  - Fix OOB R/W with Hamming ECC
* FSMC:
  - Fix error code in fsmc_nand_probe()
* OMAP:
  - Use ECC information from the generic structures

SPI-NAND core:
* Add missing MODULE_DEVICE_TABLE()

SPI-NAND drivers:
* gigadevice: Support GD5F1GQ5UExxG

----------------------------------------------------------------
Alexander Lobakin (1):
      mtd: spinand: core: add missing MODULE_DEVICE_TABLE()

Alexander Sverdlin (2):
      mtd: char: Drop mtd_mutex usage from mtdchar_open()
      mtd: char: Get rid of Big MTD Lock

Andy Shevchenko (1):
      mtd: spi-nor: intel-spi: Move platform data header to x86 subfolder

Ansuel Smith (3):
      mtd: core: add nvmem-cells compatible to parse mtd as nvmem cells
      dt-bindings: nvmem: drop $nodename restriction
      dt-bindings: mtd: Document use of nvmem-cells compatible

Baruch Siach (2):
      mtd: parsers: extend Qcom SMEM parser to SPI flash
      mtd: parsers: qcom: incompatible with spi-nor 4k sectors

Colin Ian King (1):
      mtd: cfi_cmdset_0002: remove redundant assignment to variable timeo

Dan Carpenter (1):
      mtd: rawnand: fsmc: Fix error code in fsmc_nand_probe()

David Bauer (1):
      mtd: don't lock when recursively deleting partitions

Dejin Zheng (8):
      mtd: Add helper macro for register_mtd_blktrans boilerplate
      mtd: ftl: Use module_mtd_blktrans to register driver
      mtd: inftlcore: Use module_mtd_blktrans to register driver
      mtd: mtdblock: Use module_mtd_blktrans to register driver
      mtd: mtdblock_ro: Use module_mtd_blktrans to register driver
      mtd: mtdswap: Use module_mtd_blktrans to register driver
      mtd: nftlcore: Use module_mtd_blktrans to register driver
      mtd: rfd_ftl: Use module_mtd_blktrans to register driver

Fabio Estevam (2):
      mtd: rawnand: mxc: Remove unneeded of_match_ptr()
      Revert "mtd: rawnand: bbt: Skip bad blocks when searching for the BBT in NAND"

Gustavo A. R. Silva (6):
      mtd: physmap: physmap-bt1-rom: Fix unintentional stack access
      mtd: cfi: Fix fall-through warnings for Clang
      mtd: mtdchar: Fix fall-through warnings for Clang
      mtd: onenand: Fix fall-through warnings for Clang
      mtd: rawnand: fsmc: Fix fall-through warnings for Clang
      mtd: rawnand: stm32_fmc2: Fix fall-through warnings for Clang

Jia-Ju Bai (1):
      mtd: maps: fix error return code of physmap_flash_remove()

Kai Stuhlemmer (ebee Engineering) (1):
      mtd: rawnand: atmel: Update ecc_stats.corrected counter

Kamal Dasu (2):
      mtd: rawnand: brcmnand: read/write oob during EDU transfer
      mtd: rawnand: brcmnand: move to polling in pio mode on oops write

Lv Yunlong (1):
      mtd: rawnand: gpmi: Fix a double free in gpmi_nand_init

Manivannan Sadhasivam (7):
      mtd: Handle possible -EPROBE_DEFER from parse_mtd_partitions()
      mtd: rawnand: qcom: Return actual error code instead of -ENODEV
      dt-bindings: mtd: Convert Qcom NANDc binding to YAML
      dt-bindings: mtd: Add a property to declare secure regions in NAND chips
      mtd: rawnand: Add support for secure regions in NAND memory
      mtd: rawnand: qcom: Add missing nand_cleanup() in error path
      mtd: rawnand: qcom: Use dma_mapping_error() for error check

Mauri Sandberg (1):
      mtd: cfi_cmdset_0002: Disable buffered writes for AMD chip 0x2201

Md Sadre Alam (6):
      mtd: rawnand: qcom: Update register macro name for 0x2c offset
      mtd: rawnand: qcom: Convert nandc to chip in Read/Write helper
      mtd: rawnand: qcom: Add helper to check last code word
      mtd: rawnand: qcom: Rename parameter name in macro
      mtd: rawnand: qcom: Add helper to configure location register
      mtd: rawnand: qcom: update last code word register

Michael Walle (6):
      mtd: spi-nor: use is_power_of_2()
      mtd: require write permissions for locking and badblock ioctls
      mtd: add OTP (one-time-programmable) erase ioctl
      mtd: spi-nor: add OTP support
      mtd: spi-nor: implement OTP support for Winbond and similar flashes
      mtd: spi-nor: winbond: add OTP support to w25q32fw/jw

Miquel Raynal (10):
      mtd: nand: Let ECC engines advertize the exact number of steps
      mtd: nand: ecc-bch: Populate the public nsteps field
      mtd: nand: ecc-hamming: Populate the public nsteps field
      mtd: nand: Add a helper to retrieve the number of ECC steps
      mtd: nand: Add a helper to retrieve the number of ECC bytes per step
      mtd: rawnand: Try not to use the ECC private structures
      mtd: rawnand: omap: Use ECC information from the generic structures
      mtd: nand: ecc-bch: Use the public nsteps field
      mtd: nand: ecc-hamming: Use the public nsteps field
      mtd: parsers: qcom: Fix error condition

Rafał Miłecki (4):
      mtd: parsers: ofpart: support BCM4908 fixed partitions
      mtd: parsers: ofpart: limit parsing of deprecated DT syntax
      dt-bindings: mtd: add binding for Linksys Northstar partitions
      mtd: parsers: ofpart: support Linksys Northstar partitions

Reto Schneider (1):
      mtd: spinand: gigadevice: Support GD5F1GQ5UExxG

Richard Weinberger (3):
      Merge tag 'cfi/for-5.13' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux into mtd/next
      Merge tag 'spi-nor/for-5.13' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux into mtd/next
      Merge tag 'nand/for-5.13' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux into mtd/next

Sascha Hauer (2):
      mtd: nand: fix error handling in nand_prog_page_op() #1
      mtd: nand: fix error handling in nand_prog_page_op() #2

Shuhao Mai (1):
      mtd: spi-nor: winbond: Add support for w25q512jvq

Stefan Riedmueller (1):
      mtd: rawnand: bbt: Skip bad blocks when searching for the BBT in NAND

Tian Tao (1):
      mtd: rawnand: r852: replace spin_lock_irqsave by spin_lock in hard IRQ

Tomas Winkler (1):
      mtd: mtdcore: constify name param in mtd_bdi_init

Tudor Ambarus (9):
      MAINTAINERS: Add Michael and Pratyush as designated reviewers for SPI NOR
      mtd: spi-nor: core: Advance erase after the erase cmd has been completed
      mtd: spi-nor: core: Add vdbg msg for spi_nor_erase_multi_sectors()
      mtd: spi-nor: Get rid of duplicated argument in spi_nor_parse_sfdp()
      mtd: spi-nor: core: Update comment about the default flash parameters
      mtd: spi-nor: Move Software Write Protection logic out of the core
      mtd: spi-nor: swp: Improve code around spi_nor_check_lock_status_sr()
      Revert "mtd: spi-nor: macronix: Add support for mx25l51245g"
      mtd: core: Constify buf in mtd_write_user_prot_reg()

Wan Jiabing (1):
      include: linux: mtd: Remove duplicate include of nand.h

Wei Yongjun (1):
      mtd: parsers: ofpart: make symbol 'bcm4908_partitions_quirks' static

Xiang Chen (1):
      mtd: spi-nor: core: Fix an issue of releasing resources during read/write

Zhang Yunkai (1):
      mtd: rawnand: remove duplicate include in rawnand.h

Zou Wei (1):
      mtd: rawnand: rockchip: Use flexible-array member instead of zero-length array

Álvaro Fernández Rojas (1):
      mtd: rawnand: brcmnand: fix OOB R/W with Hamming ECC

 Documentation/devicetree/bindings/mtd/nand-controller.yaml      |   7 +
 .../bindings/mtd/partitions/linksys,ns-partitions.yaml          |  74 +++++
 .../devicetree/bindings/mtd/partitions/nvmem-cells.yaml         |  99 ++++++
 Documentation/devicetree/bindings/mtd/qcom,nandc.yaml           | 196 +++++++++++
 Documentation/devicetree/bindings/mtd/qcom_nandc.txt            | 142 --------
 Documentation/devicetree/bindings/nvmem/nvmem.yaml              |   3 -
 MAINTAINERS                                                     |   2 +
 drivers/mtd/chips/cfi_cmdset_0001.c                             |   8 +-
 drivers/mtd/chips/cfi_cmdset_0002.c                             |  14 +-
 drivers/mtd/chips/cfi_cmdset_0020.c                             |   2 +
 drivers/mtd/devices/mtd_dataflash.c                             |   2 +-
 drivers/mtd/ftl.c                                               |  14 +-
 drivers/mtd/inftlcore.c                                         |  13 +-
 drivers/mtd/maps/physmap-bt1-rom.c                              |   2 +-
 drivers/mtd/maps/physmap-core.c                                 |   4 +-
 drivers/mtd/mtdblock.c                                          |  14 +-
 drivers/mtd/mtdblock_ro.c                                       |  13 +-
 drivers/mtd/mtdchar.c                                           |  40 +--
 drivers/mtd/mtdcore.c                                           |  23 +-
 drivers/mtd/mtdpart.c                                           |   2 +-
 drivers/mtd/mtdswap.c                                           |  14 +-
 drivers/mtd/nand/ecc-sw-bch.c                                   |  10 +-
 drivers/mtd/nand/ecc-sw-hamming.c                               |  10 +-
 drivers/mtd/nand/onenand/onenand_base.c                         |   5 +-
 drivers/mtd/nand/onenand/onenand_samsung.c                      |   1 +
 drivers/mtd/nand/raw/atmel/nand-controller.c                    |   6 +-
 drivers/mtd/nand/raw/brcmnand/brcmnand.c                        |  69 +++-
 drivers/mtd/nand/raw/fsmc_nand.c                                |   3 +
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c                      |   2 +-
 drivers/mtd/nand/raw/mxc_nand.c                                 |   2 +-
 drivers/mtd/nand/raw/nand_base.c                                | 145 +++++++--
 drivers/mtd/nand/raw/omap2.c                                    |  14 +-
 drivers/mtd/nand/raw/qcom_nandc.c                               | 263 +++++++++------
 drivers/mtd/nand/raw/r852.c                                     |   5 +-
 drivers/mtd/nand/raw/rockchip-nand-controller.c                 |   2 +-
 drivers/mtd/nand/raw/stm32_fmc2_nand.c                          |   2 +
 drivers/mtd/nand/spi/core.c                                     |   2 +
 drivers/mtd/nand/spi/gigadevice.c                               |  69 +++-
 drivers/mtd/nftlcore.c                                          |  13 +-
 drivers/mtd/parsers/Kconfig                                     |  24 +-
 drivers/mtd/parsers/Makefile                                    |   3 +
 drivers/mtd/parsers/ofpart_bcm4908.c                            |  64 ++++
 drivers/mtd/parsers/ofpart_bcm4908.h                            |  15 +
 drivers/mtd/parsers/{ofpart.c => ofpart_core.c}                 |  38 ++-
 drivers/mtd/parsers/ofpart_linksys_ns.c                         |  50 +++
 drivers/mtd/parsers/ofpart_linksys_ns.h                         |  18 ++
 drivers/mtd/parsers/qcomsmempart.c                              |   9 +-
 drivers/mtd/rfd_ftl.c                                           |  13 +-
 drivers/mtd/spi-nor/Makefile                                    |   2 +-
 drivers/mtd/spi-nor/controllers/intel-spi.c                     |   1 -
 drivers/mtd/spi-nor/controllers/intel-spi.h                     |   2 +-
 drivers/mtd/spi-nor/core.c                                      | 482 ++++------------------------
 drivers/mtd/spi-nor/core.h                                      |  71 +++-
 drivers/mtd/spi-nor/issi.c                                      |   3 +-
 drivers/mtd/spi-nor/macronix.c                                  |   6 +-
 drivers/mtd/spi-nor/otp.c                                       | 377 ++++++++++++++++++++++
 drivers/mtd/spi-nor/sfdp.c                                      |  72 ++---
 drivers/mtd/spi-nor/sfdp.h                                      |   3 +-
 drivers/mtd/spi-nor/spansion.c                                  |  12 +-
 drivers/mtd/spi-nor/swp.c                                       | 427 ++++++++++++++++++++++++
 drivers/mtd/spi-nor/winbond.c                                   |  22 +-
 include/linux/mfd/lpc_ich.h                                     |   2 +-
 include/linux/mtd/blktrans.h                                    |  11 +
 include/linux/mtd/mtd.h                                         |   9 +-
 include/linux/mtd/nand-ecc-sw-bch.h                             |   2 -
 include/linux/mtd/nand-ecc-sw-hamming.h                         |   2 -
 include/linux/mtd/nand.h                                        |  22 ++
 include/linux/mtd/rawnand.h                                     |  15 +-
 include/linux/mtd/spi-nor.h                                     |   8 +
 include/linux/platform_data/{ => x86}/intel-spi.h               |   0
 include/uapi/mtd/mtd-abi.h                                      |   2 +
 71 files changed, 2155 insertions(+), 943 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/linksys,ns-partitions.yaml
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
 create mode 100644 Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/qcom_nandc.txt
 create mode 100644 drivers/mtd/parsers/ofpart_bcm4908.c
 create mode 100644 drivers/mtd/parsers/ofpart_bcm4908.h
 rename drivers/mtd/parsers/{ofpart.c => ofpart_core.c} (84%)
 create mode 100644 drivers/mtd/parsers/ofpart_linksys_ns.c
 create mode 100644 drivers/mtd/parsers/ofpart_linksys_ns.h
 create mode 100644 drivers/mtd/spi-nor/otp.c
 create mode 100644 drivers/mtd/spi-nor/swp.c
 rename include/linux/platform_data/{ => x86}/intel-spi.h (100%)
