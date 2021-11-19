Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39765456AFC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 08:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhKSHmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 02:42:18 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:54003 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhKSHmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 02:42:17 -0500
Received: (Authenticated sender: herve.codina@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPA id 605EC20008;
        Fri, 19 Nov 2021 07:39:13 +0000 (UTC)
From:   Herve Codina <herve.codina@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Herve Codina <herve.codina@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 0/4] mtd: rawnand: Fixes nand infra delay setting and FSMC nand controller
Date:   Fri, 19 Nov 2021 08:39:05 +0100
Message-Id: <20211119073909.1492538-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series is mainly related to FSMC nand controller fixes except
for the two first patches which fix some issues in nand base.

Details are given in each patches.

Related to the v1 series:
- the patch related to 8bit accesses has been removed as it was
  not needed (I misunderstood 8bit accesses meaning).
- A new patch is introduced related to nand_choose_best_timings()
  issue I discovered during this v2 testing.

Best regards,
Herve Codina

Herve Codina (4):
  mtd: rawnand: Fix nand_erase_op delay
  mtd: rawnand: Fix nand_choose_best_timings() on unsupported interface
  mtd: rawnand: fsmc: Take instruction delay into account
  mtd: rawnand: fsmc: Fix timing computation

 drivers/mtd/nand/raw/fsmc_nand.c | 36 +++++++++++++++++++++++++-------
 drivers/mtd/nand/raw/nand_base.c |  6 +++---
 2 files changed, 31 insertions(+), 11 deletions(-)

-- 
2.31.1

