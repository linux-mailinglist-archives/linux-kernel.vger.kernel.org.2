Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7DB4252B6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 14:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241315AbhJGMLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 08:11:54 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:64006 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241348AbhJGMLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1633608587; x=1665144587;
  h=from:to:cc:subject:date:message-id;
  bh=7w27w8BwmpEXztoWO/m+fRD1rLpJNdh3W4ZaUKWsinE=;
  b=N6EuElsQ+ukpgt5sOJGCABSVx30QlLcyFzaqICdq99XB+nJwJhxqRee9
   jL/qNgp2BeHrTBu7PngMi6hZSu9JgD8MOdODJ5jIl2EMuDXFCP4UuEnWo
   4SCUcD/iXYrl+KM9uxPWJL1BF+LICrq981PhJaHDk5T544ABzNd/PHNkP
   AGiaMaY5mU54UhK0lCwtrpQ/tEIgTjdovdBwjhfiDNgy5ZZPwWb5CMj58
   q3+5MpWxuJ6+u3fqvDNGcYCE6eB6INxQL7qG5IJ6omZ3U3WcT4irUnRTi
   YZYo6XWGIpatlkgrdwCoxTLEs9xkJLZzzwyl9mLONbgbtxY5Z7v7knnZv
   A==;
X-IronPort-AV: E=Sophos;i="5.85,354,1624312800"; 
   d="scan'208";a="19920238"
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
  bh=7w27w8BwmpEXztoWO/m+fRD1rLpJNdh3W4ZaUKWsinE=;
  b=RfgtTIe8JPr8Wr15X/N9m+bqWvC6SlFrscrTRU1FeCxRJla/ZBO6PdJU
   ya/RWtwOGVMljgJuxQxAl/TT33BdAALmVc6qPksVfIVJGoFL8kLCDWfMo
   fVn7rMJBl2ltQPouNqhd0+G912OgtTaZgb/a2KTfuta4eJZjDBU159D91
   LSRDo5Ts0cGKn1GA1NK5Krndtkb3vJ3q41Rg4cxwCN5EcBaJqobhRyqSn
   jDxUsHqaVE6OOwvJNvTNLP88BkYovlGhdID5JlY0z8WHnkubbsSBPZ1WP
   ZwVnyeB7or0Kzgt5C7IQ4BSAJBTVWlRbdQZXWyHpD5sVaA/f5cwAWqFFa
   g==;
X-IronPort-AV: E=Sophos;i="5.85,354,1624312800"; 
   d="scan'208";a="19920237"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Oct 2021 14:09:25 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 0DE61280075;
        Thu,  7 Oct 2021 14:09:25 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 2/2] mtd: spi-nor: micron-st: add support for mt25ql01g and mt25qu01g
Date:   Thu,  7 Oct 2021 14:08:12 +0200
Message-Id: <c347908fd453fadf673000144cdbdf63c51db303.1633607826.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <a69181ccf225424a8bd11349aad0df7face9715e.1633607826.git.matthias.schiffer@ew.tq-group.com>
References: <a69181ccf225424a8bd11349aad0df7face9715e.1633607826.git.matthias.schiffer@ew.tq-group.com>
In-Reply-To: <a69181ccf225424a8bd11349aad0df7face9715e.1633607826.git.matthias.schiffer@ew.tq-group.com>
References: <a69181ccf225424a8bd11349aad0df7face9715e.1633607826.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split these mt25q models from the older n25q models by matching their
extended IDs to allow adding support for 4byte opcodes.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: add NO_CHIP_ERASE

 drivers/mtd/spi-nor/micron-st.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index a000a0790ecd..6593b6ebe0da 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -172,11 +172,19 @@ static const struct flash_info st_parts[] = {
 			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
 			      SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB |
 			      SPI_NOR_4BIT_BP | SPI_NOR_BP3_SR_BIT6) },
+	{ "mt25ql01g",   INFO6(0x20ba21, 0x104400, 64 * 1024, 2048,
+			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
+			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES |
+			       NO_CHIP_ERASE) },
 	{ "n25q00",      INFO(0x20ba21, 0, 64 * 1024, 2048,
 			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
 			      SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB |
 			      SPI_NOR_4BIT_BP | SPI_NOR_BP3_SR_BIT6 |
 			      NO_CHIP_ERASE) },
+	{ "mt25qu01g",   INFO6(0x20bb21, 0x104400, 64 * 1024, 2048,
+			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
+			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES |
+			       NO_CHIP_ERASE) },
 	{ "n25q00a",     INFO(0x20bb21, 0, 64 * 1024, 2048,
 			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
 			      NO_CHIP_ERASE) },
-- 
2.17.1

