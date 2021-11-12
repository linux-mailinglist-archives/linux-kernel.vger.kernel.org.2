Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B1244E912
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 15:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbhKLOmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 09:42:10 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:40535 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbhKLOmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 09:42:09 -0500
Received: (Authenticated sender: herve.codina@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPA id 9D3734000A;
        Fri, 12 Nov 2021 14:39:16 +0000 (UTC)
From:   Herve Codina <herve.codina@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Herve Codina <herve.codina@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 0/4] mtd: rawnand: Fixes nand infra delay setting and FSMC nand controller
Date:   Fri, 12 Nov 2021 15:38:51 +0100
Message-Id: <20211112143855.2678989-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series is mainly related to FSMC nand controller fixes except
for the first patch which fixes an operation delay setting in nand base.

Details are given in each patches.

Best regards,
Herve Codina

Herve Codina (4):
  mtd: rawnand: Fix nand_erase_op delay
  mtd: rawnand: fsmc: Force to use 8 bits access when expected
  mtd: rawnand: fsmc: Take instruction delay into account
  mtd: rawnand: fsmc: Fix timing computation

 drivers/mtd/nand/raw/fsmc_nand.c | 46 ++++++++++++++++++++++----------
 drivers/mtd/nand/raw/nand_base.c |  2 +-
 2 files changed, 33 insertions(+), 15 deletions(-)

-- 
2.31.1

