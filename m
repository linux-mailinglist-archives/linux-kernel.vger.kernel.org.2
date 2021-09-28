Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17D941BA29
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 00:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243072AbhI1WYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 18:24:42 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:49303 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243032AbhI1WYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 18:24:41 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 1133F100004;
        Tue, 28 Sep 2021 22:22:58 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Cc:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/9] Keep on-die ECC engines compatibility
Date:   Wed, 29 Sep 2021 00:22:39 +0200
Message-Id: <20210928222258.199726-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent changes broke the possibility to set the desired ECC engine type
from DT, this is of course an error and needed to be fixed. The fix
applies to all drivers which already received a previous incomplete fix
(about SW support). Hopefully this time we should be good. Sorry for the
noise.

Miquel Raynal (9):
  mtd: rawnand: ams-delta: Keep the driver compatible with on-die ECC
    engines
  mtd: rawnand: au1550nd: Keep the driver compatible with on-die ECC
    engines
  mtd: rawnand: gpio: Keep the driver compatible with on-die ECC engines
  mtd: rawnand: mpc5121: Keep the driver compatible with on-die ECC
    engines
  mtd: rawnand: orion: Keep the driver compatible with on-die ECC
    engines
  mtd: rawnand: pasemi: Keep the driver compatible with on-die ECC
    engines
  mtd: rawnand: plat_nand: Keep the driver compatible with on-die ECC
    engines
  mtd: rawnand: socrates: Keep the driver compatible with on-die ECC
    engines
  mtd: rawnand: xway: Keep the driver compatible with on-die ECC engines

 drivers/mtd/nand/raw/ams-delta.c     | 12 +++++++++---
 drivers/mtd/nand/raw/au1550nd.c      | 12 +++++++++---
 drivers/mtd/nand/raw/gpio.c          | 12 +++++++++---
 drivers/mtd/nand/raw/mpc5121_nfc.c   | 12 +++++++++---
 drivers/mtd/nand/raw/orion_nand.c    | 12 +++++++++---
 drivers/mtd/nand/raw/pasemi_nand.c   | 12 +++++++++---
 drivers/mtd/nand/raw/plat_nand.c     | 12 +++++++++---
 drivers/mtd/nand/raw/socrates_nand.c | 12 +++++++++---
 drivers/mtd/nand/raw/xway_nand.c     | 12 +++++++++---
 9 files changed, 81 insertions(+), 27 deletions(-)

-- 
2.27.0

