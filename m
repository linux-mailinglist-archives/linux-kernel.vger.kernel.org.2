Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90CB442C0E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhKBLFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:05:04 -0400
Received: from first.geanix.com ([116.203.34.67]:37540 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230109AbhKBLEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:04:50 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 3B62ED7478;
        Tue,  2 Nov 2021 11:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1635850930; bh=u1QiAAw6X6LgXTU44geERokABB9hy1J5K+hpPufCwYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=eIqmfsTZrIQXJuLn/Z6o8Kwmd/jfmlhJSaVQMNc4HaoDj7YS8mboFjxOEhj3Ux7XK
         RZvFpYe21bAHRGldmTFcnzF3cUGcm5EjEK3jWncNY+pgrSxUhMG/lUXrE6ByYviYP8
         QLcpqcYJQooZDXvp4aF12CjbuaaPXuk1bm1C7EN8t64D9mFK5rOhmHXzvu9LT4/YOK
         uXSWZx6T4qJfTN/lMuiQHZY6OXcSea7aUl+tApxyJYVDxbVzlKMFzehda64ia2OkpW
         amHSJjhK5//21daR36Y9gLWPE5QckisD1IDREQfY8i4jSA19et5kYYQS8uiJ6pqXKT
         qW6QsuG4WoyoQ==
From:   Sean Nyekjaer <sean@geanix.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Sean Nyekjaer <sean@geanix.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/4] mtd: rawnand: nand_bbt: hide suspend/resume hooks while scanning bbt
Date:   Tue,  2 Nov 2021 12:02:01 +0100
Message-Id: <20211102110204.3334609-2-sean@geanix.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211102110204.3334609-1-sean@geanix.com>
References: <20211102110204.3334609-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@collabora.com>

The BBT scan logic use the MTD helpers before the MTD layer had a
chance to initialize the device, and that leads to issues when
accessing the uninitialized suspend lock. Let's temporarily set the
suspend/resume hooks to NULL to skip the lock acquire/release step.

Tested-by: Sean Nyekjaer <sean@geanix.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/mtd/nand/raw/nand_bbt.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bbt.c
index b7ad030225f8..93d385703469 100644
--- a/drivers/mtd/nand/raw/nand_bbt.c
+++ b/drivers/mtd/nand/raw/nand_bbt.c
@@ -1397,8 +1397,28 @@ static int nand_create_badblock_pattern(struct nand_chip *this)
  */
 int nand_create_bbt(struct nand_chip *this)
 {
+	struct mtd_info *mtd = nand_to_mtd(this);
+	int (*suspend) (struct mtd_info *) = mtd->_suspend;
+	void (*resume) (struct mtd_info *) = mtd->_resume;
 	int ret;
 
+	/*
+	 * The BBT scan logic use the MTD helpers before the MTD layer had a
+	 * chance to initialize the device, and that leads to issues when
+	 * accessing the uninitialized suspend lock. Let's temporarily set the
+	 * suspend/resume hooks to NULL to skip the lock acquire/release step.
+	 *
+	 * FIXME: This is an ugly hack, so please don't copy this pattern to
+	 * other MTD implementations. The proper fix would be to implement a
+	 * generic BBT scan logic at the NAND level that's not using any of the
+	 * MTD helpers to access pages. We also might consider doing a two
+	 * step initialization at the MTD level (mtd_device_init() +
+	 * mtd_device_register()) so some of the fields are initialized
+	 * early.
+	 */
+	mtd->_suspend = NULL;
+	mtd->_resume = NULL;
+
 	/* Is a flash based bad block table requested? */
 	if (this->bbt_options & NAND_BBT_USE_FLASH) {
 		/* Use the default pattern descriptors */
@@ -1422,7 +1442,13 @@ int nand_create_bbt(struct nand_chip *this)
 			return ret;
 	}
 
-	return nand_scan_bbt(this, this->badblock_pattern);
+	ret = nand_scan_bbt(this, this->badblock_pattern);
+
+	/* Restore the suspend/resume hooks. */
+	mtd->_suspend = suspend;
+	mtd->_resume = resume;
+
+	return ret;
 }
 EXPORT_SYMBOL(nand_create_bbt);
 
-- 
2.33.0

