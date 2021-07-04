Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7343BAE9F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 21:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhGDTbB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 4 Jul 2021 15:31:01 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:54844 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhGDTbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 15:31:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 202FD610846B;
        Sun,  4 Jul 2021 21:28:22 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id et7VK2uDHlFQ; Sun,  4 Jul 2021 21:28:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 159F5616B566;
        Sun,  4 Jul 2021 21:28:21 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nlT7jhoQT1ec; Sun,  4 Jul 2021 21:28:20 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id D8B53610847F;
        Sun,  4 Jul 2021 21:28:20 +0200 (CEST)
Date:   Sun, 4 Jul 2021 21:28:20 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Message-ID: <713549850.26791.1625426900795.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] MTD updates for 5.14
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Index: +uz8p8dtoyeLb2y943AVlHTr1NqIuA==
Thread-Topic: MTD updates for 5.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit c4681547bcce777daf576925a966ffa824edd09d:

  Linux 5.13-rc3 (2021-05-23 11:42:48 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.14

for you to fetch changes up to 0bcc3939c98d83955397eac1584d5f791fdc88d0:

  Merge tag 'spi-nor/for-5.14' into mtd/next (2021-06-30 12:52:24 +0200)


There is also a known conflict with the devicetree tree which is trivial
to resolve:

        9b358af7c818 ("dt-bindings: mux: Convert mux controller
        bindings to schema") -> Updates all the files referencing the mux-controller.txt
        binding as the file name changed (s/txt/yaml/).

        6947ad674944 ("dt-bindings: mtd: Convert ti, am654-hbmc.txt to
        YAML schema")
        -> Converts one of these files to yaml, the reference to
        mux-controller.{txt,yaml} being dropped during the conversion.

It is then only needed to just take the ti,am654-hbmc yaml conversion
as it is.

----------------------------------------------------------------
MTD core changes:
* Convert list_for_each to entry variant
* Use MTD_DEVICE_ATTR_RO/RW() helper macros
* Remove unnecessary OOM messages
* Potential NULL dereference in mtd_otp_size()
* Fix freeing of otp_info buffer
* Create partname and partid debug files for child MTDs
* tests:
  - Remove redundant assignment to err
  - Fix error return code in mtd_oobtest_init()
* Add OTP NVMEM provider support
* Allow specifying of_node
* Convert sysfs sprintf/snprintf family to sysfs_emit

Bindings changes:
* Convert ti,am654-hbmc.txt to YAML schema
* spi-nor: add otp property
* Add OTP bindings
* add YAML schema for the generic MTD bindings
* Add brcm,trx-magic

MTD device drivers changes:
* Add support for microchip 48l640 EERAM
* Remove superfluous "break"
* sm_ftl:
  - Fix alignment of block comment
* nftl:
  - Return -ENOMEM when kmalloc failed
* nftlcore:
  - Remove set but rewrite variables
* phram:
  - Fix error return code in phram_setup()
* plat-ram:
  - Remove redundant dev_err call in platram_probe()

MTD parsers changes:
* Qcom:
  - Fix leaking of partition name
* Redboot:
  - Fix style issues
  - Seek fis-index-block in the right node
* trx:
  - Allow to use TRX parser on Mediatek SoCs
  - Allow to specify brcm, trx-magic in DT

Raw NAND core:
* Allow SDR timings to be nacked
* Bring support for NV-DDR timings which involved a number of small
  preparation changes to bring new helpers, properly introduce NV-DDR
  structures, fill them, differenciate them and pick the best timing set.
* Add the necessary infrastructure to parse the new gpio-cs property
  which aims at enlarging the number of available CS when a hardware
  controller is too constrained.
* Update dead URL
* Silence static checker warning in nand_setup_interface()
* BBT:
  - Fix corner case in bad block table handling
* onfi:
  - Use more recent ONFI specification wording
  - Use the BIT() macro when possible

Raw NAND controller drivers:
* Atmel:
  - Ensure the data interface is supported.
* Arasan:
  - Finer grain NV-DDR configuration
  - Rename the data interface register
  - Use the right DMA mask
  - Leverage additional GPIO CS
  - Ensure proper configuration for the asserted target
  - Add support for the NV-DDR interface
  - Fix a macro parameter
* brcmnand:
  - Convert bindings to json-schema
* OMAP:
  - Various fixes and style improvements
  - Add larger page NAND chips support
* PL35X:
  - New driver
* QCOM:
  - Avoid writing to obsolete register
  - Delete an unneeded bool conversion
  - Allow override of partition parser
* Marvell:
  - Minor documentation correction
  - Add missing clk_disable_unprepare() on error in marvell_nfc_resume()
* R852:
  - Use DEVICE_ATTR_RO() helper macro
* MTK:
  - Remove redundant dev_err call in mtk_ecc_probe()
* HISI504:
  - Remove redundant dev_err call in probe

SPI-NAND core:
* Light reorganisation for the introduction of a core resume handler
* Fix double counting of ECC stats

SPI-NAND manufacturer drivers:
* Macronix:
  - Add support for serial NAND flash

SPI NOR core changes:
* Ability to dump SFDP tables via sysfs
* Support for erasing OTP regions on Winbond and similar flashes
* Few API doc updates and fixes
* Locking support for MX25L12805D

SPI NOR controller drivers changes:
* Use SPI_MODE_X_MASK in nxp-spifi
* Intel Alder Lake-M SPI serial flash support

----------------------------------------------------------------
Andy Shevchenko (1):
      mtd: spi-nor: nxp-spifi: Use SPI_MODE_X_MASK

Ansuel Smith (1):
      mtd: parsers: qcom: Fix leaking of partition name

Baruch Siach (1):
      mtd: rawnand: qcom: allow override of partition parser

Colin Ian King (1):
      mtd: spi-nor: remove redundant continue statement

Corentin Labbe (2):
      mtd: partitions: redboot: seek fis-index-block in the right node
      mtd: partitions: redboot: fix style issues

Dan Carpenter (2):
      mtd: rawnand: silence static checker warning in nand_setup_interface()
      mtd: core: Potential NULL dereference in mtd_otp_size()

David Bauer (1):
      mtd: spi-nor: enable locking support for MX25L12805D

Ding Senjie (1):
      mtd: devices: Remove superfluous "break"

Doyle, Patrick (1):
      mtd: nand: bbt: Fix corner case in bad block table handling

Hauke Mehrtens (3):
      dt-bindings: mtd: brcm,trx: Add brcm,trx-magic
      mtd: parsers: trx: Allow to specify brcm, trx-magic in DT
      mtd: parsers: trx: Allow to use TRX parser on Mediatek SoCs

Heiko Schocher (2):
      mtd: devices: add devicetree documentation for microchip 48l640
      mtd: devices: add support for microchip 48l640 EERAM

Jaime Liao (1):
      mtd: spinand: macronix: Add support for serial NAND flash

Jiapeng Chong (1):
      mtd: mtd_oobtest: Remove redundant assignment to err

Jon Hunter (1):
      mtd: core: Fix freeing of otp_info buffer

Md Sadre Alam (1):
      mtd: rawnand: qcom: avoid writing to obsolete register

Michael Walle (12):
      nvmem: core: allow specifying of_node
      dt-bindings: mtd: add YAML schema for the generic MTD bindings
      dt-bindings: mtd: add OTP bindings
      dt-bindings: mtd: spi-nor: add otp property
      mtd: core: add OTP nvmem provider support
      mtd: spi-nor: otp: fix kerneldoc typos
      mtd: spi-nor: otp: fix access to security registers in 4 byte mode
      mtd: spi-nor: otp: use more consistent wording
      mtd: spi-nor: otp: return -EROFS if region is read-only
      mtd: spi-nor: otp: implement erase for Winbond and similar flashes
      mtd: spi-nor: sfdp: save a copy of the SFDP data
      mtd: spi-nor: add initial sysfs support

Mika Westerberg (1):
      mtd: spi-nor: intel-spi: Add support for Intel Alder Lake-M SPI serial flash

Miquel Raynal (56):
      mtd: rawnand: Add a helper to clarify the interface configuration
      mtd: rawnand: arasan: Check the proposed data interface is supported
      mtd: rawnand: atmel: Check the proposed data interface is supported
      mtd: rawnand: onfi: Use the BIT() macro when possible
      mtd: rawnand: Update dead URL
      mtd: rawnand: Use more recent ONFI specification wording
      mtd: rawnand: Clarify the NV-DDR entries in the ONFI structure
      mtd: rawnand: Add NV-DDR timings
      mtd: rawnand: Retrieve NV-DDR timing modes from the ONFI parameter page
      mtd: rawnand: Add an indirection on onfi_fill_interface_config()
      mtd: rawnand: Add onfi_fill_nvddr_interface_config() helper
      mtd: rawnand: Avoid accessing NV-DDR timings from legacy code
      mtd: rawnand: Access SDR and NV-DDR timings through a common macro
      mtd: rawnand: Handle the double bytes in NV-DDR mode
      mtd: rawnand: Add a helper to find the closest ONFI NV-DDR mode
      mtd: rawnand: Support enabling NV-DDR through SET_FEATURES
      mtd: rawnand: Allow SDR timings to be nacked
      mtd: rawnand: Choose the best timings, NV-DDR included
      MAINTAINERS: Add myself as co-maintainer of the Arasan NAND controller driver
      mtd: rawnand: arasan: Fix a macro parameter
      mtd: rawnand: arasan: Workaround a misbehaving prog type with NV-DDR
      mtd: rawnand: arasan: Support NV-DDR interface
      dt-binding: mtd: nand: Document the cs-gpios property
      mtd: rawnand: Move struct gpio_desc declaration to the top
      mtd: rawnand: Add a helper to parse the gpio-cs DT property
      mtd: rawnand: arasan: Ensure proper configuration for the asserted target
      mtd: rawnand: arasan: Leverage additional GPIO CS
      dt-binding: memory: pl353-smc: Rephrase the binding
      dt-binding: memory: pl353-smc: Document the range property
      dt-binding: memory: pl353-smc: Drop the partitioning section
      dt-binding: memory: pl353-smc: Describe the child reg property
      dt-binding: memory: pl353-smc: Fix the example syntax and style
      dt-binding: memory: pl353-smc: Drop unsupported nodes from the example
      dt-binding: memory: pl353-smc: Fix the NAND controller node in the example
      memory: pl353-smc: Fix style
      memory: pl353-smc: Rename goto labels
      memory: pl353-smc: Let lower level controller drivers handle inits
      memory: pl353-smc: Avoid useless acronyms in descriptions
      memory: pl353-smc: Declare variables following a reverse christmas tree order
      MAINTAINERS: Add PL353 SMC entry
      dt-binding: memory: pl353-smc: Convert to yaml
      Merge tag 'memory-controller-drv-pl353-5.14' into nand/next
      mtd: spinand: Fix double counting of ECC stats
      mtd: rawnand: arasan: Use the right DMA mask
      mtd: rawnand: onfi: Fix endianness when reading NV-DDR values
      mtd: rawnand: arasan: Rename the data interface register
      mtd: rawnand: arasan: Finer grain NV-DDR configuration
      MAINTAINERS: Add PL353 NAND controller entry
      dt-bindings: mtd: pl353-nand: Describe this hardware controller
      mtd: rawnand: pl353: Add support for the ARM PL353 SMC NAND controller
      mtd: rawnand: omap: Aggregate the HW configuration of the ELM
      mtd: rawnand: omap: Rename a macro
      mtd: rawnand: omap: Check return values
      mtd: rawnand: omap: Various style fixes
      mtd: rawnand: omap: Add larger page NAND chips support
      Merge tag 'spi-nor/for-5.14' into mtd/next

Patrice Chotard (3):
      mtd: spinand: add spinand_read_cfg() helper
      mtd: spinand: Add spinand_init_flash() helper
      mtd: spinand: add SPI-NAND MTD resume handler

Petr Malat (1):
      mtd: Create partname and partid debug files for child MTDs

Pratyush Yadav (1):
      mtd: spi-nor: Add documentation for spi_nor_soft_reset()

Rafał Miłecki (1):
      dt-bindings: mtd: brcmnand: convert to the json-schema

Richard Weinberger (1):
      Merge tag 'nand/for-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux into mtd/next

Shubhankar Kuranagatti (1):
      drivers: mtd: sm_ftl: Fix alignment of block comment

Souptick Joarder (1):
      mtd: rawnand: marvell: Minor documentation correction

Tian Tao (3):
      mtd: core: Convert sysfs sprintf/snprintf family to sysfs_emit
      mtd: mtdpart: Convert sysfs sprintf/snprintf family to sysfs_emit
      mtd: nftlcore: remove set but rewrite variables

Tudor Ambarus (1):
      mtd: spi-nor: macronix: Fix name for mx66l51235f

Vignesh Raghavendra (1):
      dt-bindings: mtd: Convert ti, am654-hbmc.txt to YAML schema

Wei Li (1):
      mtd: rawnand: hisi504: Remove redundant dev_err call in probe

Yang Li (2):
      mtd: *nftl: return -ENOMEM when kmalloc failed
      mtd: tests: Remove redundant assignment to err

Yang Yingliang (1):
      mtd: rawnand: marvell: add missing clk_disable_unprepare() on error in marvell_nfc_resume()

Yu Kuai (3):
      mtd: rawnand: mtk: remove redundant dev_err call in mtk_ecc_probe()
      mtd: plat-ram: remove redundant dev_err call in platram_probe()
      mtd: phram: Fix error return code in phram_setup()

Zhang Xiaoxu (1):
      mtd: mtd_oobtest: fix error return code in mtd_oobtest_init()

Zhen Lei (16):
      mtd: rawnand: qcom: Delete an unneeded bool conversion
      mtd: mtdpart: use DEVICE_ATTR_RO() helper macro
      mtd: core: add MTD_DEVICE_ATTR_RO/RW() helper macros
      mtd: core: use MTD_DEVICE_ATTR_RO/RW() helper macros
      mtd: rfd_ftl: remove unnecessary oom message
      mtd: nftl: remove unnecessary oom message
      mtd: rawnand: sunxi: remove unnecessary oom message
      mtd: rawnand: atmel: remove unnecessary oom message
      mtd: mtdoops: remove unnecessary oom message
      mtd: sun_uflash: remove unnecessary oom message
      mtd: ichxrom: remove unnecessary oom message
      mtd: esb2rom: remove unnecessary oom message
      mtd: ck804xrom: remove unnecessary oom message
      mtd: amd76xrom: remove unnecessary oom message
      mtd: inftl: remove unnecessary oom message
      mtd: rawnand: r852: use DEVICE_ATTR_RO() helper macro

Zou Wei (1):
      mtd: Convert list_for_each to entry variant

 .../ABI/testing/sysfs-bus-spi-devices-spi-nor      |   31 +
 .../bindings/memory-controllers/arm,pl353-smc.yaml |  131 +++
 .../bindings/memory-controllers/pl353-smc.txt      |   47 -
 .../bindings/mtd/arm,pl353-nand-r2p1.yaml          |   53 +
 .../devicetree/bindings/mtd/brcm,brcmnand.txt      |  186 ---
 .../devicetree/bindings/mtd/brcm,brcmnand.yaml     |  242 ++++
 Documentation/devicetree/bindings/mtd/common.txt   |   16 +-
 .../devicetree/bindings/mtd/jedec,spi-nor.yaml     |    6 +
 .../bindings/mtd/microchip,mchp48l640.yaml         |   45 +
 Documentation/devicetree/bindings/mtd/mtd.yaml     |   89 ++
 .../devicetree/bindings/mtd/nand-controller.yaml   |   18 +-
 .../bindings/mtd/partitions/brcm,trx.txt           |    5 +
 .../devicetree/bindings/mtd/ti,am654-hbmc.txt      |   51 -
 .../devicetree/bindings/mtd/ti,am654-hbmc.yaml     |   69 ++
 MAINTAINERS                                        |   17 +
 drivers/memory/pl353-smc.c                         |  314 +----
 drivers/mtd/chips/chipreg.c                        |    5 +-
 drivers/mtd/devices/Kconfig                        |    6 +
 drivers/mtd/devices/Makefile                       |    1 +
 drivers/mtd/devices/mchp48l640.c                   |  373 ++++++
 drivers/mtd/devices/ms02-nv.c                      |    1 -
 drivers/mtd/devices/phram.c                        |    1 +
 drivers/mtd/inftlmount.c                           |   17 +-
 drivers/mtd/maps/amd76xrom.c                       |    6 +-
 drivers/mtd/maps/ck804xrom.c                       |    8 +-
 drivers/mtd/maps/esb2rom.c                         |    7 +-
 drivers/mtd/maps/ichxrom.c                         |    6 +-
 drivers/mtd/maps/plat-ram.c                        |    1 -
 drivers/mtd/maps/sun_uflash.c                      |    4 +-
 drivers/mtd/mtdcore.c                              |  246 +++-
 drivers/mtd/mtdoops.c                              |    4 +-
 drivers/mtd/mtdpart.c                              |    9 +-
 drivers/mtd/nand/bbt.c                             |    2 +-
 drivers/mtd/nand/raw/Kconfig                       |    8 +
 drivers/mtd/nand/raw/Makefile                      |    1 +
 drivers/mtd/nand/raw/arasan-nand-controller.c      |  341 +++++-
 drivers/mtd/nand/raw/atmel/nand-controller.c       |   11 +-
 drivers/mtd/nand/raw/cadence-nand-controller.c     |    6 +-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h         |    2 +-
 drivers/mtd/nand/raw/hisi504_nand.c                |    4 +-
 drivers/mtd/nand/raw/internals.h                   |    5 +
 drivers/mtd/nand/raw/marvell_nand.c                |    6 +-
 drivers/mtd/nand/raw/mtk_ecc.c                     |    4 +-
 drivers/mtd/nand/raw/nand_base.c                   |  364 ++++--
 drivers/mtd/nand/raw/nand_legacy.c                 |    2 +-
 drivers/mtd/nand/raw/nand_onfi.c                   |    5 +-
 drivers/mtd/nand/raw/nand_timings.c                |  370 +++++-
 drivers/mtd/nand/raw/omap2.c                       |  229 ++--
 drivers/mtd/nand/raw/omap_elm.c                    |    2 +-
 drivers/mtd/nand/raw/pl35x-nand-controller.c       | 1194 ++++++++++++++++++++
 drivers/mtd/nand/raw/qcom_nandc.c                  |   23 +-
 drivers/mtd/nand/raw/r852.c                        |    7 +-
 drivers/mtd/nand/raw/sunxi_nand.c                  |    4 +-
 drivers/mtd/nand/spi/core.c                        |  129 ++-
 drivers/mtd/nand/spi/macronix.c                    |  112 ++
 drivers/mtd/nftlcore.c                             |    1 -
 drivers/mtd/nftlmount.c                            |    7 +-
 drivers/mtd/parsers/Kconfig                        |    2 +-
 drivers/mtd/parsers/parser_trx.c                   |    9 +-
 drivers/mtd/parsers/qcomsmempart.c                 |   10 +
 drivers/mtd/parsers/redboot.c                      |   76 +-
 drivers/mtd/rfd_ftl.c                              |    5 +-
 drivers/mtd/sm_ftl.c                               |   51 +-
 drivers/mtd/spi-nor/Makefile                       |    2 +-
 drivers/mtd/spi-nor/controllers/intel-spi-pci.c    |    1 +
 drivers/mtd/spi-nor/controllers/nxp-spifi.c        |    2 +-
 drivers/mtd/spi-nor/core.c                         |   22 +-
 drivers/mtd/spi-nor/core.h                         |   16 +
 drivers/mtd/spi-nor/macronix.c                     |    5 +-
 drivers/mtd/spi-nor/otp.c                          |  160 ++-
 drivers/mtd/spi-nor/sfdp.c                         |   58 +
 drivers/mtd/spi-nor/sysfs.c                        |   93 ++
 drivers/mtd/spi-nor/winbond.c                      |    1 +
 drivers/mtd/tests/oobtest.c                        |    7 +-
 drivers/mtd/tests/torturetest.c                    |    2 -
 drivers/nvmem/core.c                               |    4 +-
 include/linux/mtd/mtd.h                            |    2 +
 include/linux/mtd/onfi.h                           |   41 +-
 include/linux/mtd/rawnand.h                        |  161 ++-
 include/linux/mtd/spi-nor.h                        |    2 +
 include/linux/nvmem-provider.h                     |    2 +
 include/linux/pl353-smc.h                          |   30 -
 82 files changed, 4458 insertions(+), 1160 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
 create mode 100644 Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml
 create mode 100644 Documentation/devicetree/bindings/mtd/mtd.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/ti,am654-hbmc.yaml
 create mode 100644 drivers/mtd/devices/mchp48l640.c
 create mode 100644 drivers/mtd/nand/raw/pl35x-nand-controller.c
 create mode 100644 drivers/mtd/spi-nor/sysfs.c
 delete mode 100644 include/linux/pl353-smc.h
