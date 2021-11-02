Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DAD442C10
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhKBLFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:05:10 -0400
Received: from first.geanix.com ([116.203.34.67]:37546 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231181AbhKBLEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:04:51 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 408B4D747F;
        Tue,  2 Nov 2021 11:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1635850934; bh=DpYIWsQGX2i1qG2VKEU7tQ6gp/DP02vwh6pgvrOgzt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XjEeXsOe1x1ZRnaG9bJmovs49GhPJcD+3AwNjG6Ln+AETtqAMXRhGPsxGsJ510/kU
         LfNppilsOdb9HPs6c/rPT2vIdPDE2FFIBFYE2CyXpzawTPOFv9T00DsF5bBFV5T8+b
         5I0X1CdteS2a5eAc4Y3D3XmH1ECRcy8ax6lWpAQpoyv/fWdeuPLvxp7YGEjWk+qN2c
         LQXDlpgOBZQ8BNzWbk2yYzGQHepcsSNEDBAWI+xy/z+5eLp9orPJTKRQf30vke+EV5
         Lip1D1qvO1UslkX6aRGJBMwjB9JfUbu68itExXPTbEa+yyryIqXqKXvcuzTZu4sWDy
         uUJO6wYdegy9Q==
From:   Sean Nyekjaer <sean@geanix.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Sean Nyekjaer <sean@geanix.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] mtd: rawnand: remove suspended check
Date:   Tue,  2 Nov 2021 12:02:04 +0100
Message-Id: <20211102110204.3334609-5-sean@geanix.com>
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

Access is protected in upper MTD layer when MTD devices are suspended.

Commit ("mtd: core: protect access to MTD devices while in suspend")
introduces access protection, so it's safe to remove suspended checks.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/mtd/nand/raw/nand_base.c | 52 ++++++++------------------------
 include/linux/mtd/rawnand.h      |  5 +--
 2 files changed, 14 insertions(+), 43 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 3d6c6e880520..aa2874ae3c4a 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -332,19 +332,11 @@ static int nand_isbad_bbm(struct nand_chip *chip, loff_t ofs)
  * @chip: NAND chip structure
  *
  * Lock the device and its controller for exclusive access
- *
- * Return: -EBUSY if the chip has been suspended, 0 otherwise
  */
-static int nand_get_device(struct nand_chip *chip)
+static void nand_get_device(struct nand_chip *chip)
 {
 	mutex_lock(&chip->lock);
-	if (chip->suspended) {
-		mutex_unlock(&chip->lock);
-		return -EBUSY;
-	}
 	mutex_lock(&chip->controller->lock);
-
-	return 0;
 }
 
 /**
@@ -573,10 +565,7 @@ static int nand_block_markbad_lowlevel(struct nand_chip *chip, loff_t ofs)
 		nand_erase_nand(chip, &einfo, 0);
 
 		/* Write bad block marker to OOB */
-		ret = nand_get_device(chip);
-		if (ret)
-			return ret;
-
+		nand_get_device(chip);
 		ret = nand_markbad_bbm(chip, ofs);
 		nand_release_device(chip);
 	}
@@ -3756,9 +3745,7 @@ static int nand_read_oob(struct mtd_info *mtd, loff_t from,
 	    ops->mode != MTD_OPS_RAW)
 		return -ENOTSUPP;
 
-	ret = nand_get_device(chip);
-	if (ret)
-		return ret;
+	nand_get_device(chip);
 
 	if (!ops->datbuf)
 		ret = nand_do_read_oob(chip, from, ops);
@@ -4345,13 +4332,11 @@ static int nand_write_oob(struct mtd_info *mtd, loff_t to,
 			  struct mtd_oob_ops *ops)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	int ret;
+	int ret = 0;
 
 	ops->retlen = 0;
 
-	ret = nand_get_device(chip);
-	if (ret)
-		return ret;
+	nand_get_device(chip);
 
 	switch (ops->mode) {
 	case MTD_OPS_PLACE_OOB:
@@ -4410,10 +4395,8 @@ int nand_erase_nand(struct nand_chip *chip, struct erase_info *instr,
 	if (nand_region_is_secured(chip, instr->addr, instr->len))
 		return -EIO;
 
-	/* Grab the lock and see if the device is available */
-	ret = nand_get_device(chip);
-	if (ret)
-		return ret;
+	/* Grab the lock */
+	nand_get_device(chip);
 
 	/* Shift to get first page */
 	page = (int)(instr->addr >> chip->page_shift);
@@ -4499,8 +4482,8 @@ static void nand_sync(struct mtd_info *mtd)
 
 	pr_debug("%s: called\n", __func__);
 
-	/* Grab the lock and see if the device is available */
-	WARN_ON(nand_get_device(chip));
+	/* Grab the lock */
+	nand_get_device(chip);
 	/* Release it and go back */
 	nand_release_device(chip);
 }
@@ -4517,9 +4500,7 @@ static int nand_block_isbad(struct mtd_info *mtd, loff_t offs)
 	int ret;
 
 	/* Select the NAND device */
-	ret = nand_get_device(chip);
-	if (ret)
-		return ret;
+	nand_get_device(chip);
 
 	nand_select_target(chip, chipnr);
 
@@ -4565,8 +4546,6 @@ static int nand_suspend(struct mtd_info *mtd)
 	mutex_lock(&chip->lock);
 	if (chip->ops.suspend)
 		ret = chip->ops.suspend(chip);
-	if (!ret)
-		chip->suspended = 1;
 	mutex_unlock(&chip->lock);
 
 	return ret;
@@ -4580,15 +4559,10 @@ static void nand_resume(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
 
+
 	mutex_lock(&chip->lock);
-	if (chip->suspended) {
-		if (chip->ops.resume)
-			chip->ops.resume(chip);
-		chip->suspended = 0;
-	} else {
-		pr_err("%s called for a chip which is not in suspended state\n",
-			__func__);
-	}
+	if (chip->ops.resume)
+		chip->ops.resume(chip);
 	mutex_unlock(&chip->lock);
 }
 
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index b2f9dd3cbd69..1198a6548912 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1237,9 +1237,7 @@ struct nand_secure_region {
  * @pagecache.page: Page number currently in the cache. -1 means no page is
  *                  currently cached
  * @buf_align: Minimum buffer alignment required by a platform
- * @lock: Lock protecting the suspended field. Also used to serialize accesses
- *        to the NAND device
- * @suspended: Set to 1 when the device is suspended, 0 when it's not
+ * @lock: Lock to serialize accesses to the NAND device
  * @cur_cs: Currently selected target. -1 means no target selected, otherwise we
  *          should always have cur_cs >= 0 && cur_cs < nanddev_ntargets().
  *          NAND Controller drivers should not modify this value, but they're
@@ -1293,7 +1291,6 @@ struct nand_chip {
 
 	/* Internals */
 	struct mutex lock;
-	unsigned int suspended : 1;
 	int cur_cs;
 	int read_retries;
 	struct nand_secure_region *secure_regions;
-- 
2.33.0

