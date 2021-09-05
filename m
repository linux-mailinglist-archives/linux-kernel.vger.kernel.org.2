Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B5A400EFC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 12:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbhIEKJx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 5 Sep 2021 06:09:53 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:55925 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237643AbhIEKJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 06:09:52 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id DFFC410000B;
        Sun,  5 Sep 2021 10:08:46 +0000 (UTC)
Date:   Sun, 5 Sep 2021 12:08:45 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] [v2] mtd: Changes for 5.15
Message-ID: <20210905120845.09877033@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

I was checking why the pull request sent on Thursday 3rd did not
receive any reply and I figured out that the final push operation
did not make it to the kernel.org repository.

I just pushed once again the missing change (a merge commit) and
re-generated the below request.

This is the final MTD PR for 5.15.

Thanks,
Miquèl

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.15

for you to fetch changes up to c1fe77e42440d2cad76055df6fb58caabf622d51:

  Merge tag 'nand/for-5.15' into mtd/next (2021-09-03 00:04:16 +0200)

----------------------------------------------------------------
MTD changes:
* blkdevs:
  - Simplify the refcounting in blktrans_{open, release}
  - Simplify blktrans_getgeo
  - Remove blktrans_ref_mutex
  - Simplify blktrans_dev_get
  - Use lockdep_assert_held
  - Don't hold del_mtd_blktrans_dev in blktrans_{open, release}
* ftl:
  - Don't cast away the type when calling add_mtd_blktrans_dev
  - Don't cast away the type when calling add_mtd_blktrans_dev
  - Use container_of() rather than cast
  - Fix use-after-free
  - Add discard support
  - Allow use of MTD_RAM for testing purposes
* concat:
  - Check _read, _write callbacks existence before assignment
  - Judge callback existence based on the master
* maps:
  - Maps: remove dead MTD map driver for PMC-Sierra MSP boards
* mtdblock:
  - Warn if added for a NAND device
  - Add comment about UBI block devices
  - Update old JFFS2 mention in Kconfig
* partitions:
  - Redboot: convert to YAML

NAND core changes:
* Repair Miquel Raynal's email address in MAINTAINERS
* Fix a couple of spelling mistakes in Kconfig
* bbt: Skip bad blocks when searching for the BBT in NAND
* Remove never changed ret variable

Raw NAND changes:
* cafe: Fix a resource leak in the error handling path of 'cafe_nand_probe()'
* intel: Fix error handling in probe
* omap: Fix kernel doc warning on 'calcuate' typo
* gpmc: Fix the ECC bytes vs. OOB bytes equation

SPI-NAND core changes:
* Properly fill the OOB area.
* Fix comment

SPI-NAND drivers changes:
* macronix: Add Quad support for serial NAND flash

----------------------------------------------------------------
Christoph Hellwig (8):
      mtd_blkdevs: don't hold del_mtd_blktrans_dev in blktrans_{open, release}
      mtd_blkdevs: use lockdep_assert_held
      mtd/ftl: don't cast away the type when calling add_mtd_blktrans_dev
      mtd/rfd_ftl: don't cast away the type when calling add_mtd_blktrans_dev
      mtd_blkdevs: simplify blktrans_dev_get
      mtd_blkdevs: remove blktrans_ref_mutex
      mtd_blkdevs: simplify blktrans_getgeo
      mtd_blkdevs: simplify the refcounting in blktrans_{open, release}

Christophe JAILLET (1):
      mtd: rawnand: cafe: Fix a resource leak in the error handling path of 'cafe_nand_probe()'

Colin Ian King (1):
      mtd: rawnand: Fix a couple of spelling mistakes in Kconfig

Corentin Labbe (1):
      dt_bindings: mtd: partitions: redboot: convert to YAML

Daniel Palmer (1):
      mtd: spinand: core: Properly fill the OOB area.

Evgeny Novikov (1):
      mtd: rawnand: intel: Fix error handling in probe

Ezequiel Garcia (3):
      mtdblock: Update old JFFS2 mention in Kconfig
      mtdblock: Add comment about UBI block devices
      mtdblock: Warn if added for a NAND device

Jaime Liao (1):
      mtd: spinand: macronix: Add Quad support for serial NAND flash

Jason Wang (1):
      mtd: rawnand: remove never changed ret variable

Lukas Bulwahn (2):
      MAINTAINERS: repair Miquel Raynal's email address
      mtd: maps: remove dead MTD map driver for PMC-Sierra MSP boards

Miquel Raynal (3):
      dt-bindings: mtd: gpmc: Fix the ECC bytes vs. OOB bytes equation
      mtd: spinand: Fix comment
      Merge tag 'nand/for-5.15' into mtd/next

Sean Young (4):
      mtd: rfd_ftl: allow use of MTD_RAM for testing purposes
      mtd: rfd_ftl: add discard support
      mtd: rfd_ftl: fix use-after-free
      mtd: rfd_ftl: use container_of() rather than cast

Stefan Riedmueller (1):
      mtd: rawnand: nand_bbt: Skip bad blocks when searching for the BBT in NAND

Vladimir Molokov (1):
      mtd: rawnand: omap: Fix kernel doc warning on 'calcuate' typo

Zhihao Cheng (2):
      mtd: mtdconcat: Judge callback existence based on the master
      mtd: mtdconcat: Check _read, _write callbacks existence before assignment

 Documentation/devicetree/bindings/mtd/gpmc-nand.txt               |   2 +-
 Documentation/devicetree/bindings/mtd/partitions/redboot-fis.txt  |  27 ----------
 Documentation/devicetree/bindings/mtd/partitions/redboot-fis.yaml |  42 ++++++++++++++++
 MAINTAINERS                                                       |   4 +-
 drivers/mtd/Kconfig                                               |  10 ++--
 drivers/mtd/ftl.c                                                 |   2 +-
 drivers/mtd/maps/Kconfig                                          |  23 ---------
 drivers/mtd/maps/Makefile                                         |   1 -
 drivers/mtd/maps/pmcmsp-flash.c                                   | 227 -----------------------------------------------------------------------------------
 drivers/mtd/mtd_blkdevs.c                                         |  60 +++-------------------
 drivers/mtd/mtdblock.c                                            |   4 ++
 drivers/mtd/mtdblock_ro.c                                         |   4 ++
 drivers/mtd/mtdconcat.c                                           |  33 ++++++++----
 drivers/mtd/nand/raw/Kconfig                                      |   4 +-
 drivers/mtd/nand/raw/cafe_nand.c                                  |   4 +-
 drivers/mtd/nand/raw/intel-nand-controller.c                      |  27 ++++++----
 drivers/mtd/nand/raw/meson_nand.c                                 |   4 +-
 drivers/mtd/nand/raw/nand_bbt.c                                   |  33 ++++++++++++
 drivers/mtd/nand/raw/omap2.c                                      |   2 +-
 drivers/mtd/nand/spi/core.c                                       |   4 +-
 drivers/mtd/nand/spi/macronix.c                                   |  16 +++---
 drivers/mtd/rfd_ftl.c                                             |  46 ++++++++++++++---
 22 files changed, 198 insertions(+), 381 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/partitions/redboot-fis.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/redboot-fis.yaml
 delete mode 100644 drivers/mtd/maps/pmcmsp-flash.c
