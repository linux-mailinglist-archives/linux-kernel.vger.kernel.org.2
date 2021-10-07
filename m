Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163184252B5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 14:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241360AbhJGMLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 08:11:41 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:64006 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241424AbhJGMLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1633608567; x=1665144567;
  h=from:to:cc:subject:date:message-id;
  bh=VI9Tcp4Ze00HFFj8ItEOXjKUFSXQBnT6Yos7WuUkTbY=;
  b=H9TdhNo+glNitSVOQgiatDXj5WelBwHtASVFYnowxRMm2MEL1gvLm0qx
   b/CtvvRvz1GegPeLcOxg41Fb7JNyS8PZ1otgXLrii3dFC2cmbz6Yjfw0j
   u7WyjIO27SakMtZiLHl2SMnGVhTp2KR9RU4v3QE/RXbebotlCipy+C757
   wYezQ7riQk3J0/d1AE7vc8kJg6x4opP/ns7X3soGOPqz+S12rCOgeYM9a
   +N1l04BkAP2U6qoOxHcoPUas4ZK17rUBZHA7jYvXLkEAtiz+3X3GNT7X8
   /Ai/4Phppm4YpduX+fCgtZF5BLEnDXeh42JYE5dvx4ML8LIXP9p7BLczj
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,354,1624312800"; 
   d="scan'208";a="19920236"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Oct 2021 14:09:25 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 07 Oct 2021 14:09:25 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 07 Oct 2021 14:09:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1633608565; x=1665144565;
  h=from:to:cc:subject:date:message-id;
  bh=VI9Tcp4Ze00HFFj8ItEOXjKUFSXQBnT6Yos7WuUkTbY=;
  b=CzWoZOWDApOfsKfHLh9Q5UtAUT7nWAE9kcfDv6plMYpsSmPnvBAAZCOZ
   MvVic/DtXpadPDzmLmuRwy1ZDFHdJRbwYoIntHwWJj11e/ti7coDAWLKR
   2Mj46pElk6fysTzKS+0HV7duCN0s2t4lE/T40OLEZt7jRr4aZ8EvcSA6l
   r+D+vzMnyjemMu96sahu4Rrm37zu1RW0lh6AxTr4imspmiqPH4hTbWQ/+
   dkAB1/OnD9Xtda1b43UEddohYYDEv6CI3wEUKCwEoLJYAu7oHFgFaY94b
   u3VNtWhreP8NWhUoJKor0XmDg0Tsaj/u9nFG+2Y4GHiquzrlzqh5SQN3E
   g==;
X-IronPort-AV: E=Sophos;i="5.85,354,1624312800"; 
   d="scan'208";a="19920235"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Oct 2021 14:09:25 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id DABEE280065;
        Thu,  7 Oct 2021 14:09:24 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 1/2] mtd: spi-nor: micron-st: make mt25ql02g/mt25qu02g match more specific, add 4B opcodes
Date:   Thu,  7 Oct 2021 14:08:11 +0200
Message-Id: <a69181ccf225424a8bd11349aad0df7face9715e.1633607826.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the mt25ql02g/mt25qu02g entries to include SPI_NOR_4B_OPCODES. In
addition, the SPI_NOR_DUAL_READ flag is added to mt25ql02g; this seems
to have been an accidental omission, as mt25ql02g and mt25qu02g should
support the same features.

In addition, the entries are made more specific by matching on the mt25q
extended ID, like it is already done for the smaller n25q derivatives.
It is unclear whether n25q derivatives with 2Gbit exist that do not
support 4B opcodes (like it is the case for sizes up to 512MBit), so we
do not have a match for such variants anymore (as we wouldn't even know
how to name such hypothetical models).

The changes were tested with a mt25qu01g, which should support the same
features as the mt25ql02g/mt25qu02g.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2:
- add extended ID match
- add back NO_CHIP_ERASE

 drivers/mtd/spi-nor/micron-st.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index c224e59820a1..a000a0790ecd 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -180,12 +180,14 @@ static const struct flash_info st_parts[] = {
 	{ "n25q00a",     INFO(0x20bb21, 0, 64 * 1024, 2048,
 			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
 			      NO_CHIP_ERASE) },
-	{ "mt25ql02g",   INFO(0x20ba22, 0, 64 * 1024, 4096,
-			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
-			      NO_CHIP_ERASE) },
-	{ "mt25qu02g",   INFO(0x20bb22, 0, 64 * 1024, 4096,
-			      SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
+	{ "mt25ql02g",   INFO6(0x20ba22, 0x104400, 64 * 1024, 4096,
+			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
+			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES |
+			       NO_CHIP_ERASE) },
+	{ "mt25qu02g",   INFO6(0x20bb22, 0x104400, 64 * 1024, 4096,
+			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
+			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES |
+			       NO_CHIP_ERASE) },
 
 	{ "m25p05",  INFO(0x202010,  0,  32 * 1024,   2, 0) },
 	{ "m25p10",  INFO(0x202011,  0,  32 * 1024,   4, 0) },
-- 
2.17.1

