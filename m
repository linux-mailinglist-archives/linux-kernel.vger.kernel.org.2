Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3836432BD0E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447929AbhCCPQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:16:54 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58334 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241433AbhCCK2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:28:49 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lHO1m-0000ol-IK; Wed, 03 Mar 2021 09:42:46 +0000
From:   Colin King <colin.king@canonical.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] mtd: nand: Fix error handling in nand_prog_page_op
Date:   Wed,  3 Mar 2021 09:42:46 +0000
Message-Id: <20210303094246.5724-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The less than zero comparison with status is always false because status
is a u8. Fix this by using ret as the return check for the call to
chip->legacy.waitfunc() and checking on this and assigning status to ret
if it is OK.

Addresses-Coverity: ("Unsigned compared against 0")
Fixes: 52f67def97f1 ("mtd: nand: fix error handling in nand_prog_page_op() #1")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mtd/nand/raw/nand_base.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 0f6babefaed2..4f263c22c80d 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -1462,9 +1462,10 @@ int nand_prog_page_op(struct nand_chip *chip, unsigned int page,
 				     page);
 		chip->legacy.write_buf(chip, buf, len);
 		chip->legacy.cmdfunc(chip, NAND_CMD_PAGEPROG, -1, -1);
-		status = chip->legacy.waitfunc(chip);
-		if (status < 0)
-			return status;
+		ret = chip->legacy.waitfunc(chip);
+		if (ret < 0)
+			return ret;
+		status = ret;
 	}
 
 	if (status & NAND_STATUS_FAIL)
-- 
2.30.0

