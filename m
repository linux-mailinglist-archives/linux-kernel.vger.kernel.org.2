Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E0441BA03
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 00:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243089AbhI1WQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 18:16:56 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:52935 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243073AbhI1WQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 18:16:51 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 0E1831C0006;
        Tue, 28 Sep 2021 22:15:07 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Cc:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/8] Cleanup series about Hamming helpers 
Date:   Wed, 29 Sep 2021 00:14:59 +0200
Message-Id: <20210928221507.199198-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The detailed description is available in each patch description but
basically:
* The FSMC driver was (I believe) still broken so here is a patch for
  that.
* As requested by Linus when he pulled a series of fixes during the 5.13
  cycle, the need for declaring individual indentical helpers in each
  driver using the "raw" Hamming ECC helpers was unjustified:
  - Here is a proposal for simplifying the situation
  - Followed by a series of revert (no need to backport these, it's just
    general cleanup).

Thanks,
Miquèl

Miquel Raynal (8):
  mtd: rawnand: fsmc: Fix use of SM ORDER
  mtd: rawnand: Let callers use the bare Hamming helpers
  Revert "mtd: rawnand: txx9ndfmc: Fix external use of SW Hamming ECC
    helper"
  Revert "mtd: rawnand: tmio: Fix external use of SW Hamming ECC helper"
  Revert "mtd: rawnand: sharpsl: Fix external use of SW Hamming ECC
    helper"
  Revert "mtd: rawnand: ndfc: Fix external use of SW Hamming ECC helper"
  Revert "mtd: rawnand: lpc32xx_slc: Fix external use of SW Hamming ECC
    helper"
  Revert "mtd: rawnand: cs553x: Fix external use of SW Hamming ECC
    helper"

 drivers/mtd/nand/ecc-sw-hamming.c  |  7 ++++---
 drivers/mtd/nand/raw/cs553x_nand.c | 12 +-----------
 drivers/mtd/nand/raw/fsmc_nand.c   |  4 +++-
 drivers/mtd/nand/raw/lpc32xx_slc.c | 15 +--------------
 drivers/mtd/nand/raw/ndfc.c        | 12 +-----------
 drivers/mtd/nand/raw/sharpsl.c     | 12 +-----------
 drivers/mtd/nand/raw/tmio_nand.c   |  8 +++-----
 drivers/mtd/nand/raw/txx9ndfmc.c   |  5 ++---
 8 files changed, 16 insertions(+), 59 deletions(-)

-- 
2.27.0

