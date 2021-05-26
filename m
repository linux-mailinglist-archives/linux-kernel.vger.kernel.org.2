Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1269391C95
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 17:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbhEZQBF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 May 2021 12:01:05 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:46923 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbhEZQBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 12:01:01 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 9A06860007;
        Wed, 26 May 2021 15:59:25 +0000 (UTC)
Date:   Wed, 26 May 2021 17:59:24 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Changes for v5.13-rc4
Message-ID: <20210526175924.4f9ab124@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This is an MTD fixes PR for the next release cycle.

Thanks,
Miquèl


The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.13-rc4

for you to fetch changes up to 562b4e91d3b221f737f84ff78ee7d348c8a6891f:

  mtd: parsers: ofpart: fix parsing subpartitions (2021-05-10 18:34:30 +0200)

----------------------------------------------------------------
MTD parsers:
* ofpart:
  - Fix subpartitions parsing

Raw NAND:
* txx9ndfmc, tmio, sharpsl, ndfc, lpc32xx_slc, fsmc, cs553x:
  - Fix external use of SW Hamming ECC helper

----------------------------------------------------------------
Miquel Raynal (7):
      mtd: rawnand: cs553x: Fix external use of SW Hamming ECC helper
      mtd: rawnand: fsmc: Fix external use of SW Hamming ECC helper
      mtd: rawnand: lpc32xx_slc: Fix external use of SW Hamming ECC helper
      mtd: rawnand: ndfc: Fix external use of SW Hamming ECC helper
      mtd: rawnand: sharpsl: Fix external use of SW Hamming ECC helper
      mtd: rawnand: tmio: Fix external use of SW Hamming ECC helper
      mtd: rawnand: txx9ndfmc: Fix external use of SW Hamming ECC helper

Rafał Miłecki (1):
      mtd: parsers: ofpart: fix parsing subpartitions

 drivers/mtd/nand/raw/cs553x_nand.c | 12 +++++++++++-
 drivers/mtd/nand/raw/fsmc_nand.c   | 12 +++++++++++-
 drivers/mtd/nand/raw/lpc32xx_slc.c | 15 ++++++++++++++-
 drivers/mtd/nand/raw/ndfc.c        | 12 +++++++++++-
 drivers/mtd/nand/raw/sharpsl.c     | 12 +++++++++++-
 drivers/mtd/nand/raw/tmio_nand.c   |  8 +++++---
 drivers/mtd/nand/raw/txx9ndfmc.c   |  5 +++--
 drivers/mtd/parsers/ofpart_core.c  | 26 ++++++++++++++------------
 8 files changed, 80 insertions(+), 22 deletions(-)
