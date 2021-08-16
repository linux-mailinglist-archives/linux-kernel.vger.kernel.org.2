Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307E13ED9C7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 17:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbhHPPVk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Aug 2021 11:21:40 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:43769 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236568AbhHPPVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 11:21:21 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id D804D4000A;
        Mon, 16 Aug 2021 15:20:41 +0000 (UTC)
Date:   Mon, 16 Aug 2021 17:20:40 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Changes for 5.14-rc7
Message-ID: <20210816172040.7a67f8da@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This is the MTD fixes PR for the next -rc. Again, sorry for the delay.

Thanks,
Miquèl


The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.14-rc7

for you to fetch changes up to b48027083a78b13356695555a05b0e085e378687:

  mtd: rawnand: Fix probe failure due to of_get_nand_secure_regions() (2021-08-06 21:44:16 +0200)

----------------------------------------------------------------
MTD core fixes:
* Fix lock hierarchy in deregister_mtd_blktrans
* Handle flashes without OTP gracefully
* Break circular locks in register_mtd_blktrans

MTD device fixes:
* mchp48l640:
  - Fix memory leak on cmd
  - Silence some uninitialized variable warnings
* blkdevs:
  - Initialize rq.limits.discard_granularity

CFI fixes:
* Fix crash when erasing/writing AMD cards

Raw NAND fixes:
* Fix of_get_nand_secure_regions():
  - Add a missing check
  - Avoid an unwanted probe failure when a DT property is missing

----------------------------------------------------------------
Andreas Persson (1):
      mtd: cfi_cmdset_0002: fix crash when erasing/writing AMD cards

Colin Ian King (1):
      mtd: devices: mchp48l640: Fix memory leak on cmd

Dan Carpenter (2):
      mtd: rawnand: Add a check in of_get_nand_secure_regions()
      mtd: mchp48l640: silence some uninitialized variable warnings

Desmond Cheong Zhi Xi (2):
      mtd: break circular locks in register_mtd_blktrans
      mtd: fix lock hierarchy in deregister_mtd_blktrans

Manivannan Sadhasivam (1):
      mtd: rawnand: Fix probe failure due to of_get_nand_secure_regions()

Michael Walle (1):
      mtd: core: handle flashes without OTP gracefully

Zhihao Cheng (1):
      mtd: mtd_blkdevs: Initialize rq.limits.discard_granularity

 drivers/mtd/chips/cfi_cmdset_0002.c |  2 +-
 drivers/mtd/devices/mchp48l640.c    |  5 +++--
 drivers/mtd/mtd_blkdevs.c           | 11 ++++-------
 drivers/mtd/mtdcore.c               |  4 +++-
 drivers/mtd/nand/raw/nand_base.c    | 10 ++++++++--
 5 files changed, 19 insertions(+), 13 deletions(-)
