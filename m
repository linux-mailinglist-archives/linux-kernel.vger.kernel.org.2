Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E317E320D5B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 21:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhBUUCt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 21 Feb 2021 15:02:49 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:48458 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhBUUCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 15:02:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 74C7A60A357B;
        Sun, 21 Feb 2021 21:02:05 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id fjj8azMOkIez; Sun, 21 Feb 2021 21:02:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E987460A3582;
        Sun, 21 Feb 2021 21:02:04 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id S8tQaMGGhfW2; Sun, 21 Feb 2021 21:02:04 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id B8A7160A357B;
        Sun, 21 Feb 2021 21:02:04 +0100 (CET)
Date:   Sun, 21 Feb 2021 21:02:04 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <1860844222.14898.1613937724518.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] MTD changes for 5.12
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Index: 7+C02FdulTyKA9J1LISl0R0IkBqhDg==
Thread-Topic: MTD changes for 5.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 19c329f6808995b142b3966301f217c831e7cf31:

  Linux 5.11-rc4 (2021-01-17 16:37:05 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.12

for you to fetch changes up to 6e9dff6fe3fbc452f16566e4a7e293b0decefdba:

  dt-bindings: mtd: add binding for BCM4908 partitions (2021-02-12 22:24:48 +0100)

----------------------------------------------------------------
MTD core changes:
* Initial support for BCM4908 partitions

Raw NAND controller drivers:
* Intel: Fix an error handling path in 'ebu_dma_start()'
* Tango: Remove the driver
* Marvell: Convert comma to semicolon
* MXC: Convert comma to semicolon
* Qcom: Add support for Qcom SMEM parser

Related MTD changes:
* parsers: Add Qcom SMEM parser

SPI NOR core changes:
* Add non-uniform erase fixes.
* Add Global Block Unlock command. It is defined by few flash
 vendors, and it is used for now just by sst.

SPI NOR controller drivers changes:
* intel-spi: Add support for Intel Alder Lake-P SPI serial flash.
* hisi-sfc: Put child node np on error path.

----------------------------------------------------------------
Arnd Bergmann (1):
      mtd: rawnand: tango: Remove the driver

Christophe JAILLET (1):
      mtd: rawnand: intel: Fix an error handling path in 'ebu_dma_start()'

Colin Ian King (1):
      mtd: remove redundant assignment to pointer eb

Dan Carpenter (1):
      mtd: parser: imagetag: fix error codes in bcm963xx_parse_imagetag_partitions()

Manivannan Sadhasivam (4):
      dt-bindings: mtd: partitions: Add binding for Qcom SMEM parser
      mtd: parsers: Add Qcom SMEM parser
      mtd: rawnand: qcom: Add support for Qcom SMEM parser
      mtd: parsers: afs: Fix freeing the part name memory in failure

Mika Westerberg (1):
      mtd: spi-nor: intel-spi: Add support for Intel Alder Lake-P SPI serial flash

Pan Bian (1):
      mtd: spi-nor: hisi-sfc: Put child node np on error path

Rafał Miłecki (2):
      dt-bindings: mtd: move partition binding to its own file
      dt-bindings: mtd: add binding for BCM4908 partitions

Richard Weinberger (2):
      Merge tag 'nand/for-5.12' of git://git.kernel.org/.../mtd/linux into mtd/next
      Merge tag 'spi-nor/for-5.12' of git://git.kernel.org/.../mtd/linux into mtd/next

Takahiro Kuwano (4):
      mtd: spi-nor: sfdp: Fix wrong erase type bitmask for overlaid region
      mtd: spi-nor: sfdp: Fix last erase region marking
      mtd: spi-nor: core: Fix erase type discovery for overlaid region
      mtd: spi-nor: core: Add erase size check for erase command initialization

Tudor Ambarus (2):
      mtd: spi-nor: Add Global Block Unlock command
      mtd: spi-nor: sst: Add support for Global Unlock on sst26vf

Zheng Yongjun (4):
      mtd: rawnand: mxc: Convert comma to semicolon
      mtd: convert comma to semicolon
      mtd: st_spi_fsm: convert comma to semicolon
      mtd: rawnand: marvell: convert comma to semicolon

yangerkun (1):
      mtd: phram: use div_u64_rem to stop overwrite len in phram_setup

 .../mtd/partitions/brcm,bcm4908-partitions.yaml    |  70 ++
 .../bindings/mtd/partitions/fixed-partitions.yaml  |  33 +-
 .../bindings/mtd/partitions/partition.yaml         |  47 ++
 .../bindings/mtd/partitions/qcom,smem-part.yaml    |  33 +
 drivers/mtd/devices/phram.c                        |   6 +-
 drivers/mtd/devices/st_spi_fsm.c                   |   2 +-
 drivers/mtd/maps/pci.c                             |   8 +-
 drivers/mtd/mtdswap.c                              |   1 -
 drivers/mtd/nand/raw/Kconfig                       |   7 -
 drivers/mtd/nand/raw/Makefile                      |   1 -
 drivers/mtd/nand/raw/intel-nand-controller.c       |   6 +-
 drivers/mtd/nand/raw/marvell_nand.c                |   2 +-
 drivers/mtd/nand/raw/mxc_nand.c                    |   2 +-
 drivers/mtd/nand/raw/qcom_nandc.c                  |   4 +-
 drivers/mtd/nand/raw/tango_nand.c                  | 727 ---------------------
 drivers/mtd/parsers/Kconfig                        |   8 +
 drivers/mtd/parsers/Makefile                       |   1 +
 drivers/mtd/parsers/afs.c                          |   4 +-
 drivers/mtd/parsers/parser_imagetag.c              |   4 +
 drivers/mtd/parsers/qcomsmempart.c                 | 170 +++++
 drivers/mtd/spi-nor/controllers/hisi-sfc.c         |   4 +-
 drivers/mtd/spi-nor/controllers/intel-spi-pci.c    |   1 +
 drivers/mtd/spi-nor/core.c                         |  49 +-
 drivers/mtd/spi-nor/core.h                         |   2 +
 drivers/mtd/spi-nor/sfdp.c                         |   5 +-
 drivers/mtd/spi-nor/sst.c                          |  52 +-
 include/linux/mtd/spi-nor.h                        |   1 +
 27 files changed, 457 insertions(+), 793 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/partition.yaml
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
 delete mode 100644 drivers/mtd/nand/raw/tango_nand.c
 create mode 100644 drivers/mtd/parsers/qcomsmempart.c
