Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CEF4473E4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 17:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbhKGQst convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 7 Nov 2021 11:48:49 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:45695 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbhKGQso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 11:48:44 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 96E921C0002;
        Sun,  7 Nov 2021 16:45:56 +0000 (UTC)
Date:   Sun, 7 Nov 2021 17:45:55 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Changes for 5.16
Message-ID: <20211107174555.2d1a5eec@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This is the MTD PR for 5.16.

Thanks,
Miquèl

The following changes since commit 9e1ff307c779ce1f0f810c7ecce3d95bbae40896:

  Linux 5.15-rc4 (2021-10-03 14:08:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next

for you to fetch changes up to e269d7caf9e0dbd95fac9991991298f74930c2c0:

  Merge tag 'spi-nor/for-5.16' into mtd/next (2021-11-07 17:38:36 +0100)

----------------------------------------------------------------
Arnd Bergmann (1):
      mtd: fixup CFI on ixp4xx

Cai Huoqing (19):
      mtd: rawnand: atmel: Make use of the helper function devm_platform_ioremap_resource()
      mtd: rawnand: bcm6368: Make use of the helper function devm_platform_ioremap_resource_byname()
      mtd: rawnand: denali: Make use of the helper function devm_platform_ioremap_resource_byname()
      mtd: rawnand: gpio: Make use of the helper function devm_platform_ioremap_resource()
      mtd: rawnand: gpmi: Make use of the helper function devm_platform_ioremap_resource_byname()
      mtd: rawnand: hisi504: Make use of the helper function devm_platform_ioremap_resource()
      mtd: rawnand: mtk: Make use of the helper function devm_platform_ioremap_resource()
      mtd: rawnand: mtk_ecc: Make use of the helper function devm_platform_ioremap_resource()
      mtd: rawnand: omap_elm: Make use of the helper function devm_platform_ioremap_resource()
      mtd: rawnand: oxnas: Make use of the helper function devm_platform_ioremap_resource()
      mtd: rawnand: plat_nand: Make use of the helper function devm_platform_ioremap_resource()
      mtd: rawnand: stm32_fmc2: Make use of the helper function devm_platform_ioremap_resource()
      mtd: rawnand: tegra: Make use of the helper function devm_platform_ioremap_resource()
      mtd: rawnand: txx9ndfm: Make use of the helper function devm_platform_ioremap_resource()
      mtd: rawnand: vf610: Make use of the helper function devm_platform_ioremap_resource()
      mtd: rawnand: xway: Make use of the helper function devm_platform_ioremap_resource()
      mtd: spi-nor: hisi-sfc: Make use of the helper function devm_platform_ioremap_resource_byname()
      mtd: spi-nor: nxp-spifi: Make use of the helper function devm_platform_ioremap_resource_byname()
      MAINTAINERS: Update the devicetree documentation path of hyperbus

Chris Morgan (1):
      mtd: rawnand: hynix: Add support for H27UCG8T2ETR-BC MLC NAND

Colin Ian King (1):
      mtd: mtdswap: Remove redundant assignment of pointer eb

Evgeny Novikov (2):
      mtd: rawnand: intel: Fix potential buffer overflow in probe
      mtd: spi-nor: hisi-sfc: Remove excessive clk_disable_unprepare()

GONG, Ruiqi (1):
      mtd: Remove obsolete macros only used by the old nand_ecclayout struct

Joachim Wiberg (2):
      mtd: block2mtd: minor refactor to avoid hard coded constant
      mtd: block2mtd: add support for an optional custom MTD label

Jonathan Lemon (1):
      mtd: spi-nor: Enable locking for n25q128a13

Krzysztof Kozlowski (1):
      mtd: onenand: samsung: drop Exynos4 and describe driver in KConfig

Manivannan Sadhasivam (1):
      MAINTAINERS: Add entry for Qualcomm NAND controller driver

Miquel Raynal (20):
      mtd: rawnand: fsmc: Fix use of SM ORDER
      mtd: rawnand: Let callers use the bare Hamming helpers
      Revert "mtd: rawnand: txx9ndfmc: Fix external use of SW Hamming ECC helper"
      Revert "mtd: rawnand: tmio: Fix external use of SW Hamming ECC helper"
      Revert "mtd: rawnand: sharpsl: Fix external use of SW Hamming ECC helper"
      Revert "mtd: rawnand: ndfc: Fix external use of SW Hamming ECC helper"
      Revert "mtd: rawnand: lpc32xx_slc: Fix external use of SW Hamming ECC helper"
      Revert "mtd: rawnand: cs553x: Fix external use of SW Hamming ECC helper"
      mtd: rawnand: ams-delta: Keep the driver compatible with on-die ECC engines
      mtd: rawnand: au1550nd: Keep the driver compatible with on-die ECC engines
      mtd: rawnand: gpio: Keep the driver compatible with on-die ECC engines
      mtd: rawnand: mpc5121: Keep the driver compatible with on-die ECC engines
      mtd: rawnand: orion: Keep the driver compatible with on-die ECC engines
      mtd: rawnand: pasemi: Keep the driver compatible with on-die ECC engines
      mtd: rawnand: plat_nand: Keep the driver compatible with on-die ECC engines
      mtd: rawnand: socrates: Keep the driver compatible with on-die ECC engines
      mtd: rawnand: xway: Keep the driver compatible with on-die ECC engines
      mtd: rawnand: arasan: Prevent an unsupported configuration
      Merge tag 'nand/for-5.16' into mtd/next
      Merge tag 'spi-nor/for-5.16' into mtd/next

Pratyush Yadav (1):
      MAINTAINERS: Add spi-nor device tree binding under SPI NOR maintainers

Zev Weiss (1):
      mtd: core: don't remove debugfs directory if device is in use

 MAINTAINERS                                   | 12 ++++++++++--
 drivers/mtd/chips/Kconfig                     |  2 ++
 drivers/mtd/devices/block2mtd.c               | 29 +++++++++++++++++++++--------
 drivers/mtd/maps/Kconfig                      |  2 +-
 drivers/mtd/mtdcore.c                         |  4 ++--
 drivers/mtd/mtdswap.c                         |  1 -
 drivers/mtd/nand/ecc-sw-hamming.c             |  7 ++++---
 drivers/mtd/nand/onenand/Kconfig              |  9 +++++----
 drivers/mtd/nand/raw/ams-delta.c              | 12 +++++++++---
 drivers/mtd/nand/raw/arasan-nand-controller.c | 15 +++++++++++++++
 drivers/mtd/nand/raw/atmel/pmecc.c            |  7 ++-----
 drivers/mtd/nand/raw/au1550nd.c               | 12 +++++++++---
 drivers/mtd/nand/raw/brcmnand/bcm6368_nand.c  |  5 +----
 drivers/mtd/nand/raw/cs553x_nand.c            | 12 +-----------
 drivers/mtd/nand/raw/denali_dt.c              |  7 ++-----
 drivers/mtd/nand/raw/fsmc_nand.c              |  4 +++-
 drivers/mtd/nand/raw/gpio.c                   | 15 ++++++++++-----
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c    |  4 +---
 drivers/mtd/nand/raw/hisi504_nand.c           |  7 ++-----
 drivers/mtd/nand/raw/intel-nand-controller.c  |  5 +++++
 drivers/mtd/nand/raw/lpc32xx_slc.c            | 15 +--------------
 drivers/mtd/nand/raw/mpc5121_nfc.c            | 12 +++++++++---
 drivers/mtd/nand/raw/mtk_ecc.c                |  4 +---
 drivers/mtd/nand/raw/mtk_nand.c               |  4 +---
 drivers/mtd/nand/raw/nand_hynix.c             | 14 ++++++++++++++
 drivers/mtd/nand/raw/nand_ids.c               |  4 ++++
 drivers/mtd/nand/raw/ndfc.c                   | 12 +-----------
 drivers/mtd/nand/raw/omap_elm.c               |  5 ++---
 drivers/mtd/nand/raw/orion_nand.c             | 12 +++++++++---
 drivers/mtd/nand/raw/oxnas_nand.c             |  4 +---
 drivers/mtd/nand/raw/pasemi_nand.c            | 12 +++++++++---
 drivers/mtd/nand/raw/plat_nand.c              | 16 ++++++++++------
 drivers/mtd/nand/raw/sharpsl.c                | 12 +-----------
 drivers/mtd/nand/raw/socrates_nand.c          | 12 +++++++++---
 drivers/mtd/nand/raw/stm32_fmc2_nand.c        |  8 ++------
 drivers/mtd/nand/raw/tegra_nand.c             |  4 +---
 drivers/mtd/nand/raw/tmio_nand.c              |  8 +++-----
 drivers/mtd/nand/raw/txx9ndfmc.c              |  9 +++------
 drivers/mtd/nand/raw/vf610_nfc.c              |  4 +---
 drivers/mtd/nand/raw/xway_nand.c              | 16 ++++++++++------
 drivers/mtd/spi-nor/controllers/hisi-sfc.c    |  8 ++------
 drivers/mtd/spi-nor/controllers/nxp-spifi.c   |  7 ++-----
 drivers/mtd/spi-nor/micron-st.c               |  4 +++-
 include/linux/mtd/mtd.h                       |  2 --
 44 files changed, 204 insertions(+), 175 deletions(-)
