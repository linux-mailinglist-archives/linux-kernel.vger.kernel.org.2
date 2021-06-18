Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569A13AC7AD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 11:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbhFRJfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 05:35:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49387 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhFRJfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 05:35:50 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1luAsV-0004ax-80; Fri, 18 Jun 2021 09:33:31 +0000
From:   Colin King <colin.king@canonical.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH]  mtd: spi-nor: remove redundant continue statement
Date:   Fri, 18 Jun 2021 10:33:31 +0100
Message-Id: <20210618093331.100006-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The continue statement at the end of a for-loop has no effect,
invert the if expression and remove the continue.

Addresses-Coverity: ("Continue has no effect")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mtd/spi-nor/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 970ed6e3f3ba..cc08bd707378 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1411,9 +1411,7 @@ spi_nor_find_best_erase_type(const struct spi_nor_erase_map *map,
 			continue;
 
 		spi_nor_div_by_erase_size(erase, addr, &rem);
-		if (rem)
-			continue;
-		else
+		if (!rem)
 			return erase;
 	}
 
-- 
2.31.1

