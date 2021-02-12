Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17088319CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 11:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhBLKnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 05:43:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:54028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230311AbhBLKlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 05:41:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5876864E6B;
        Fri, 12 Feb 2021 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613126425;
        bh=xzoXFaoeYDTEMR3GxWVBJHXTFKlnfSz6FIU6JbD02kg=;
        h=Date:From:To:Cc:Subject:From;
        b=OdS1E/690pVqNSZvz1hzx9/9wmwurZzzpcY4AbVAjTN0P4zswcp6MDU2ezyVlqltY
         vjY1YHqdStftk1JhFtRgM76uLU0EmIHPwNWtlEWYO3ndST1KJ3YsrPHdA+uvSTOEnx
         I8elamVniEYZmov6Cw8uvECwV/WekrStAWPeAyriL/hGurbRCIG8LreOGUyAnpLAQV
         RMGj0N6kl+/Gpl5L8M/h+OPtCTliU05lHFDlx9tIbAWGpXWB8QWj2eq1TxEO91LXIs
         bUZ2rWMkjznQoAGv8nFgdRpj7J5F/D1XdqMHNJpdlRW+nd+ayjkScO1Bd3g2RW755h
         +cuefkoNQrvrw==
Date:   Fri, 12 Feb 2021 04:40:22 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH] mtd: physmap: physmap-bt1-rom: Fix unintentional stack access
Message-ID: <20210212104022.GA242669@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cast &data to (char *) in order to avoid unintentionally accessing
the stack.

Notice that data is of type u32, so any increment to &data
will be in the order of 4-byte chunks, and this piece of code
is actually intended to be a byte offset.

Fixes: b3e79e7682e0 ("mtd: physmap: Add Baikal-T1 physically mapped ROM support")
Addresses-Coverity-ID: 1497765 ("Out-of-bounds access")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/mtd/maps/physmap-bt1-rom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/maps/physmap-bt1-rom.c b/drivers/mtd/maps/physmap-bt1-rom.c
index a35450002284..58782cfaf71c 100644
--- a/drivers/mtd/maps/physmap-bt1-rom.c
+++ b/drivers/mtd/maps/physmap-bt1-rom.c
@@ -79,7 +79,7 @@ static void __xipram bt1_rom_map_copy_from(struct map_info *map,
 	if (shift) {
 		chunk = min_t(ssize_t, 4 - shift, len);
 		data = readl_relaxed(src - shift);
-		memcpy(to, &data + shift, chunk);
+		memcpy(to, (char *)&data + shift, chunk);
 		src += chunk;
 		to += chunk;
 		len -= chunk;
-- 
2.27.0

