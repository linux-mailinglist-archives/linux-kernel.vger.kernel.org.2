Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D776B3D3972
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 13:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbhGWKrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 06:47:37 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:16149 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231428AbhGWKrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 06:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1627039690; x=1658575690;
  h=from:to:cc:subject:date:message-id;
  bh=aAPkXdl9E/1o3H8cpUC5g2ADIsYXfWAWx1RrAJRr6nI=;
  b=LK7gENqpFNtQk3A/yolYcRTXL4RnVwVQvPoDzLakQJ1mhz0ZpUcgt6oH
   nr3/wCZTasADbzl/0wmRyFEjWO0lVRdiL27P7sCyBmDaGZT8IK+8AWaRP
   Z+7feMwsEOj5/KGSjtMRif7FQlHgV5xEmFMD/sPKIFM/EtcsYntJMYHbj
   SK/UHyzgAp8zU5YtomQZp7mwQrovL099Mupfu1yaeYBaFDqtaT+7wkDvS
   Xp/8OlA7Gx3eCOqvgUIpUV3mLPDtTTZTWcgx1cfdHqWHA4miVYPwyLHEh
   TYNLjvoSeJ1zX41+8nZ3ghYcLPDn0kN7OqL4cHJ9xvIJkiOcRcXk7WVsm
   w==;
X-IronPort-AV: E=Sophos;i="5.84,263,1620684000"; 
   d="scan'208";a="18612749"
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
  bh=aAPkXdl9E/1o3H8cpUC5g2ADIsYXfWAWx1RrAJRr6nI=;
  b=h4KSTu0h3PRuS4TF+4Lr4py4OjWHemgSnDmoSAktY+VA75Tyupz9m+sw
   dDPs9kSFTFWHulQTBTr/nkxsJ3GJNv5ZmvRlW6mHq/YUqCTLdRowc2XVa
   fd3mnICkP47GEK7UzpJW85XHquUH8uoMbenmyvd9cQDarXBcvLddJlCKW
   84XEWtJ2aNIpZesuMjbB0qWEiTBaNftJlAZpYVnITs1L04G56f8Ew/DKK
   koM6YH+JOLNgq7nWaFMCCMqqe1jlh0mk4epFGE9Tpezljh/U1WrnQLZ64
   g4N21Hlz+pFuv0v1Xm1AHW+5K75kSO5ogxW4CFwZ5AlAApp5YrdaFQEmi
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,263,1620684000"; 
   d="scan'208";a="18612748"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 Jul 2021 13:28:09 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 0EEA4280070;
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
Subject: [PATCH 1/2] mtd: spi-nor: micron-st: sync flags of mt25ql02g and mt25qu02g with other mt25q
Date:   Fri, 23 Jul 2021 13:27:47 +0200
Message-Id: <c7b6c666aef9a8a2195acabe9954a417f04b6582.1627039534.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All mt25q variants have the same features.

Unlike the smaller variants, no n25q with 2G exists, so we don't need to
match on the extended ID to distinguish n25q and mt25q series for these
models.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/mtd/spi-nor/micron-st.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index c224e59820a1..d5baa8762c8d 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -181,11 +181,11 @@ static const struct flash_info st_parts[] = {
 			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
 			      NO_CHIP_ERASE) },
 	{ "mt25ql02g",   INFO(0x20ba22, 0, 64 * 1024, 4096,
-			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
-			      NO_CHIP_ERASE) },
+			      SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
+			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ "mt25qu02g",   INFO(0x20bb22, 0, 64 * 1024, 4096,
 			      SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
+			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 
 	{ "m25p05",  INFO(0x202010,  0,  32 * 1024,   2, 0) },
 	{ "m25p10",  INFO(0x202011,  0,  32 * 1024,   4, 0) },
-- 
2.17.1

