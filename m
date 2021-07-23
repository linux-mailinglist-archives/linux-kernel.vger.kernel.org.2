Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5043D3973
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 13:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbhGWKrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 06:47:40 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:16149 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232129AbhGWKrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 06:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1627039691; x=1658575691;
  h=from:to:cc:subject:date:message-id;
  bh=dD4m+5jvnpLz3g9QjfJTZRKHJTBtcnmMU1A7kvKDBLY=;
  b=VFIv+9oXQnKMF2XUs+hlgiWNGTjrZfLjMxmlmhljJ7MAD/+GmtH0K5KA
   HhGWJWJ2lTtooDtihZWEo4NK/ucTwhcxi7zpG6v8ouD5BO3bsdbi5VgEI
   s1BgiwHLVQUueuJ6xkI9JNTQkYzdsH4RpcoumC714GI8Xfd07GZ16z15B
   5bVbN8YxYOW6g+t7vI/0GDFwTdP/tvE6A74VPN7KQgYJwKYLlCfIJYngP
   Wj3uRqe9i7e8oeqdyI0dsEADTPIGKzT9/2gNkTjmpR/E1Zl5XXGfJGiKv
   /8s8DC5dkuA1qh16Dt4lu/UvPoOjfFAPNQcFlLtnisf+3ZFY50V5Xaae/
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,263,1620684000"; 
   d="scan'208";a="18612751"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 23 Jul 2021 13:28:09 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 23 Jul 2021 13:28:09 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 23 Jul 2021 13:28:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1627039689; x=1658575689;
  h=from:to:cc:subject:date:message-id;
  bh=dD4m+5jvnpLz3g9QjfJTZRKHJTBtcnmMU1A7kvKDBLY=;
  b=S05bLAhTE9aoIg4LVyrkgqzmo+gN345ba6bBlWbUDT6o6saGV8LCryL5
   1IE0ixdtbca5yUD82OR31H5uCWC9ewZf52WSIb+AucZTuJ2PzXTD0hn5m
   LfUcUZ/sHC2YzDDT0DZLEA4eE5JA/0O4PDxg1uumOQ/6Lz/zEZccusAmK
   D28yRsbcn6WQVhQEk8+N5Vr/b8BM+6PtHNKMB2d3bL+eotBax18WWxnkp
   zudYD1AZ1lpEq6/LlZH1xaLSkuxqUF36+NI1BbeWYYTikjdA55m8X+WoZ
   yRcrbR3iphe/C0a0mjv88UUIKSfii7apet9rXa3vNps0bIf7zzHVrjzAj
   g==;
X-IronPort-AV: E=Sophos;i="5.84,263,1620684000"; 
   d="scan'208";a="18612750"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 Jul 2021 13:28:09 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 3FA2C280075;
        Fri, 23 Jul 2021 13:28:09 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 2/2] mtd: spi-nor: micron-st: add support for mt25ql01g and mt25qu01g
Date:   Fri, 23 Jul 2021 13:27:48 +0200
Message-Id: <a979f3a66e9e4391844d1fae144a32646933c86f.1627039534.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <c7b6c666aef9a8a2195acabe9954a417f04b6582.1627039534.git.matthias.schiffer@ew.tq-group.com>
References: <c7b6c666aef9a8a2195acabe9954a417f04b6582.1627039534.git.matthias.schiffer@ew.tq-group.com>
In-Reply-To: <c7b6c666aef9a8a2195acabe9954a417f04b6582.1627039534.git.matthias.schiffer@ew.tq-group.com>
References: <c7b6c666aef9a8a2195acabe9954a417f04b6582.1627039534.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split these mt25q models from the older n25q models by matching their
extended IDs to allow adding support for 4byte opcodes.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/mtd/spi-nor/micron-st.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index d5baa8762c8d..2fca5de2504f 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -172,11 +172,17 @@ static const struct flash_info st_parts[] = {
 			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
 			      SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB |
 			      SPI_NOR_4BIT_BP | SPI_NOR_BP3_SR_BIT6) },
+	{ "mt25ql01g",   INFO6(0x20ba21, 0x104400, 64 * 1024, 2048,
+			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
+			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ "n25q00",      INFO(0x20ba21, 0, 64 * 1024, 2048,
 			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
 			      SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB |
 			      SPI_NOR_4BIT_BP | SPI_NOR_BP3_SR_BIT6 |
 			      NO_CHIP_ERASE) },
+	{ "mt25qu01g",   INFO6(0x20bb21, 0x104400, 64 * 1024, 2048,
+			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
+			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ "n25q00a",     INFO(0x20bb21, 0, 64 * 1024, 2048,
 			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
 			      NO_CHIP_ERASE) },
-- 
2.17.1

