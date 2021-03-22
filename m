Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69795343AE8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 08:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhCVHvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 03:51:52 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:2552 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhCVHvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 03:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1616399499; x=1647935499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BS3l/RCifC+bX7HJE8uF0SIkdzE8mpm041D8WS2g5RI=;
  b=XHjX29ifeOCjAjTsMZTWxbGqo+96hSf70qzJB2OmNcUUV5mieeRmPyCH
   wmELxdleKvOsrVcTEDJDd6oO8TmYo53DxnREG5C7vUkcLIdVEqbCfRS5R
   qzMhS+An1GSsH0DP+8rjTSS2zfRJpxDfPwWSuubxx7xZWximEBHV4sbte
   HmpBXe+lyzmun2ea89Xq3cwLMABp0IT5R98pk/0KPieiW5+XO462OhXYw
   cNzYRpaVj/Yh2w60KwBQkYFezJtEMDM82OqVpQnWFE9vzIrFoBoNoJGDa
   69MnluZK9mOErIc8t19fPh2wb8paciu+mrhZFXvU+H6y3JN8TeQCTNzdW
   Q==;
IronPort-SDR: KHw5gTJezYztAwmlXrX1dDI4SwuvzV+/gz9iI+gYkE3ENIJFbF9kTot+UMN/nBgLgjeAngDI8T
 wKi0Dx6jIWUIk4g7D13jxyRQNahaEFxA9szrlwEbLKD7XvvTV3jQsMETbdj6nasjpCr0VKL+Kp
 GjHCEDi0ImHOs30zBjnl0x/PNDZfFziYGd29zGFfTLE6+bwyDeyUci0wp0QiaEHmL0a11zHovM
 LXvju71/J5wVvBbalOYSsFzZ82JbhGVkJ4AdPG0wrpQkSKdCy8px4Ic5QFVNF6F05C89Kp3i/K
 5TM=
X-IronPort-AV: E=Sophos;i="5.81,268,1610434800"; 
   d="scan'208";a="114084654"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Mar 2021 00:51:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 22 Mar 2021 00:51:37 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 22 Mar 2021 00:51:35 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vigneshr@ti.com>, <michael@walle.cc>, <p.yadav@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH v3 1/2] mtd: spi-nor: Move Software Write Protection logic out of the core
Date:   Mon, 22 Mar 2021 09:51:30 +0200
Message-ID: <20210322075131.45093-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210322075131.45093-1-tudor.ambarus@microchip.com>
References: <20210322075131.45093-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It makes the core file a bit smaller and provides better separation
between the Software Write Protection features and the core logic.
All the next generic software write protection features (e.g. Individual
Block Protection) will reside in swp.c.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v3:
- Add description at the top of swp.c file:
"SPI NOR Software Write Protection logic."
- Move if (!nor->params->locking_ops) check in spi_nor_register_locking_ops()

v2: new patch

 drivers/mtd/spi-nor/Makefile |   2 +-
 drivers/mtd/spi-nor/core.c   | 406 +--------------------------------
 drivers/mtd/spi-nor/core.h   |   4 +
 drivers/mtd/spi-nor/swp.c    | 424 +++++++++++++++++++++++++++++++++++
 4 files changed, 432 insertions(+), 404 deletions(-)
 create mode 100644 drivers/mtd/spi-nor/swp.c

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index 653923896205..da05b03f28d2 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-spi-nor-objs			:= core.o sfdp.o
+spi-nor-objs			:= core.o sfdp.o swp.o
 spi-nor-objs			+= atmel.o
 spi-nor-objs			+= catalyst.o
 spi-nor-objs			+= eon.o
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index fbc34158a883..5bc7ecfe7740 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1730,376 +1730,6 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 	return ret;
 }
 
-static u8 spi_nor_get_sr_bp_mask(struct spi_nor *nor)
-{
-	u8 mask = SR_BP2 | SR_BP1 | SR_BP0;
-
-	if (nor->flags & SNOR_F_HAS_SR_BP3_BIT6)
-		return mask | SR_BP3_BIT6;
-
-	if (nor->flags & SNOR_F_HAS_4BIT_BP)
-		return mask | SR_BP3;
-
-	return mask;
-}
-
-static u8 spi_nor_get_sr_tb_mask(struct spi_nor *nor)
-{
-	if (nor->flags & SNOR_F_HAS_SR_TB_BIT6)
-		return SR_TB_BIT6;
-	else
-		return SR_TB_BIT5;
-}
-
-static u64 spi_nor_get_min_prot_length_sr(struct spi_nor *nor)
-{
-	unsigned int bp_slots, bp_slots_needed;
-	u8 mask = spi_nor_get_sr_bp_mask(nor);
-
-	/* Reserved one for "protect none" and one for "protect all". */
-	bp_slots = (1 << hweight8(mask)) - 2;
-	bp_slots_needed = ilog2(nor->info->n_sectors);
-
-	if (bp_slots_needed > bp_slots)
-		return nor->info->sector_size <<
-			(bp_slots_needed - bp_slots);
-	else
-		return nor->info->sector_size;
-}
-
-static void spi_nor_get_locked_range_sr(struct spi_nor *nor, u8 sr, loff_t *ofs,
-					uint64_t *len)
-{
-	struct mtd_info *mtd = &nor->mtd;
-	u64 min_prot_len;
-	u8 mask = spi_nor_get_sr_bp_mask(nor);
-	u8 tb_mask = spi_nor_get_sr_tb_mask(nor);
-	u8 bp, val = sr & mask;
-
-	if (nor->flags & SNOR_F_HAS_SR_BP3_BIT6 && val & SR_BP3_BIT6)
-		val = (val & ~SR_BP3_BIT6) | SR_BP3;
-
-	bp = val >> SR_BP_SHIFT;
-
-	if (!bp) {
-		/* No protection */
-		*ofs = 0;
-		*len = 0;
-		return;
-	}
-
-	min_prot_len = spi_nor_get_min_prot_length_sr(nor);
-	*len = min_prot_len << (bp - 1);
-
-	if (*len > mtd->size)
-		*len = mtd->size;
-
-	if (nor->flags & SNOR_F_HAS_SR_TB && sr & tb_mask)
-		*ofs = 0;
-	else
-		*ofs = mtd->size - *len;
-}
-
-/*
- * Return 1 if the entire region is locked (if @locked is true) or unlocked (if
- * @locked is false); 0 otherwise
- */
-static int spi_nor_check_lock_status_sr(struct spi_nor *nor, loff_t ofs,
-					uint64_t len, u8 sr, bool locked)
-{
-	loff_t lock_offs;
-	uint64_t lock_len;
-
-	if (!len)
-		return 1;
-
-	spi_nor_get_locked_range_sr(nor, sr, &lock_offs, &lock_len);
-
-	if (locked)
-		/* Requested range is a sub-range of locked range */
-		return (ofs + len <= lock_offs + lock_len) && (ofs >= lock_offs);
-	else
-		/* Requested range does not overlap with locked range */
-		return (ofs >= lock_offs + lock_len) || (ofs + len <= lock_offs);
-}
-
-static int spi_nor_is_locked_sr(struct spi_nor *nor, loff_t ofs, uint64_t len,
-				u8 sr)
-{
-	return spi_nor_check_lock_status_sr(nor, ofs, len, sr, true);
-}
-
-static int spi_nor_is_unlocked_sr(struct spi_nor *nor, loff_t ofs, uint64_t len,
-				  u8 sr)
-{
-	return spi_nor_check_lock_status_sr(nor, ofs, len, sr, false);
-}
-
-/*
- * Lock a region of the flash. Compatible with ST Micro and similar flash.
- * Supports the block protection bits BP{0,1,2}/BP{0,1,2,3} in the status
- * register
- * (SR). Does not support these features found in newer SR bitfields:
- *   - SEC: sector/block protect - only handle SEC=0 (block protect)
- *   - CMP: complement protect - only support CMP=0 (range is not complemented)
- *
- * Support for the following is provided conditionally for some flash:
- *   - TB: top/bottom protect
- *
- * Sample table portion for 8MB flash (Winbond w25q64fw):
- *
- *   SEC  |  TB   |  BP2  |  BP1  |  BP0  |  Prot Length  | Protected Portion
- *  --------------------------------------------------------------------------
- *    X   |   X   |   0   |   0   |   0   |  NONE         | NONE
- *    0   |   0   |   0   |   0   |   1   |  128 KB       | Upper 1/64
- *    0   |   0   |   0   |   1   |   0   |  256 KB       | Upper 1/32
- *    0   |   0   |   0   |   1   |   1   |  512 KB       | Upper 1/16
- *    0   |   0   |   1   |   0   |   0   |  1 MB         | Upper 1/8
- *    0   |   0   |   1   |   0   |   1   |  2 MB         | Upper 1/4
- *    0   |   0   |   1   |   1   |   0   |  4 MB         | Upper 1/2
- *    X   |   X   |   1   |   1   |   1   |  8 MB         | ALL
- *  ------|-------|-------|-------|-------|---------------|-------------------
- *    0   |   1   |   0   |   0   |   1   |  128 KB       | Lower 1/64
- *    0   |   1   |   0   |   1   |   0   |  256 KB       | Lower 1/32
- *    0   |   1   |   0   |   1   |   1   |  512 KB       | Lower 1/16
- *    0   |   1   |   1   |   0   |   0   |  1 MB         | Lower 1/8
- *    0   |   1   |   1   |   0   |   1   |  2 MB         | Lower 1/4
- *    0   |   1   |   1   |   1   |   0   |  4 MB         | Lower 1/2
- *
- * Returns negative on errors, 0 on success.
- */
-static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
-{
-	struct mtd_info *mtd = &nor->mtd;
-	u64 min_prot_len;
-	int ret, status_old, status_new;
-	u8 mask = spi_nor_get_sr_bp_mask(nor);
-	u8 tb_mask = spi_nor_get_sr_tb_mask(nor);
-	u8 pow, val;
-	loff_t lock_len;
-	bool can_be_top = true, can_be_bottom = nor->flags & SNOR_F_HAS_SR_TB;
-	bool use_top;
-
-	ret = spi_nor_read_sr(nor, nor->bouncebuf);
-	if (ret)
-		return ret;
-
-	status_old = nor->bouncebuf[0];
-
-	/* If nothing in our range is unlocked, we don't need to do anything */
-	if (spi_nor_is_locked_sr(nor, ofs, len, status_old))
-		return 0;
-
-	/* If anything below us is unlocked, we can't use 'bottom' protection */
-	if (!spi_nor_is_locked_sr(nor, 0, ofs, status_old))
-		can_be_bottom = false;
-
-	/* If anything above us is unlocked, we can't use 'top' protection */
-	if (!spi_nor_is_locked_sr(nor, ofs + len, mtd->size - (ofs + len),
-				  status_old))
-		can_be_top = false;
-
-	if (!can_be_bottom && !can_be_top)
-		return -EINVAL;
-
-	/* Prefer top, if both are valid */
-	use_top = can_be_top;
-
-	/* lock_len: length of region that should end up locked */
-	if (use_top)
-		lock_len = mtd->size - ofs;
-	else
-		lock_len = ofs + len;
-
-	if (lock_len == mtd->size) {
-		val = mask;
-	} else {
-		min_prot_len = spi_nor_get_min_prot_length_sr(nor);
-		pow = ilog2(lock_len) - ilog2(min_prot_len) + 1;
-		val = pow << SR_BP_SHIFT;
-
-		if (nor->flags & SNOR_F_HAS_SR_BP3_BIT6 && val & SR_BP3)
-			val = (val & ~SR_BP3) | SR_BP3_BIT6;
-
-		if (val & ~mask)
-			return -EINVAL;
-
-		/* Don't "lock" with no region! */
-		if (!(val & mask))
-			return -EINVAL;
-	}
-
-	status_new = (status_old & ~mask & ~tb_mask) | val;
-
-	/* Disallow further writes if WP pin is asserted */
-	status_new |= SR_SRWD;
-
-	if (!use_top)
-		status_new |= tb_mask;
-
-	/* Don't bother if they're the same */
-	if (status_new == status_old)
-		return 0;
-
-	/* Only modify protection if it will not unlock other areas */
-	if ((status_new & mask) < (status_old & mask))
-		return -EINVAL;
-
-	return spi_nor_write_sr_and_check(nor, status_new);
-}
-
-/*
- * Unlock a region of the flash. See spi_nor_sr_lock() for more info
- *
- * Returns negative on errors, 0 on success.
- */
-static int spi_nor_sr_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
-{
-	struct mtd_info *mtd = &nor->mtd;
-	u64 min_prot_len;
-	int ret, status_old, status_new;
-	u8 mask = spi_nor_get_sr_bp_mask(nor);
-	u8 tb_mask = spi_nor_get_sr_tb_mask(nor);
-	u8 pow, val;
-	loff_t lock_len;
-	bool can_be_top = true, can_be_bottom = nor->flags & SNOR_F_HAS_SR_TB;
-	bool use_top;
-
-	ret = spi_nor_read_sr(nor, nor->bouncebuf);
-	if (ret)
-		return ret;
-
-	status_old = nor->bouncebuf[0];
-
-	/* If nothing in our range is locked, we don't need to do anything */
-	if (spi_nor_is_unlocked_sr(nor, ofs, len, status_old))
-		return 0;
-
-	/* If anything below us is locked, we can't use 'top' protection */
-	if (!spi_nor_is_unlocked_sr(nor, 0, ofs, status_old))
-		can_be_top = false;
-
-	/* If anything above us is locked, we can't use 'bottom' protection */
-	if (!spi_nor_is_unlocked_sr(nor, ofs + len, mtd->size - (ofs + len),
-				    status_old))
-		can_be_bottom = false;
-
-	if (!can_be_bottom && !can_be_top)
-		return -EINVAL;
-
-	/* Prefer top, if both are valid */
-	use_top = can_be_top;
-
-	/* lock_len: length of region that should remain locked */
-	if (use_top)
-		lock_len = mtd->size - (ofs + len);
-	else
-		lock_len = ofs;
-
-	if (lock_len == 0) {
-		val = 0; /* fully unlocked */
-	} else {
-		min_prot_len = spi_nor_get_min_prot_length_sr(nor);
-		pow = ilog2(lock_len) - ilog2(min_prot_len) + 1;
-		val = pow << SR_BP_SHIFT;
-
-		if (nor->flags & SNOR_F_HAS_SR_BP3_BIT6 && val & SR_BP3)
-			val = (val & ~SR_BP3) | SR_BP3_BIT6;
-
-		/* Some power-of-two sizes are not supported */
-		if (val & ~mask)
-			return -EINVAL;
-	}
-
-	status_new = (status_old & ~mask & ~tb_mask) | val;
-
-	/* Don't protect status register if we're fully unlocked */
-	if (lock_len == 0)
-		status_new &= ~SR_SRWD;
-
-	if (!use_top)
-		status_new |= tb_mask;
-
-	/* Don't bother if they're the same */
-	if (status_new == status_old)
-		return 0;
-
-	/* Only modify protection if it will not lock other areas */
-	if ((status_new & mask) > (status_old & mask))
-		return -EINVAL;
-
-	return spi_nor_write_sr_and_check(nor, status_new);
-}
-
-/*
- * Check if a region of the flash is (completely) locked. See spi_nor_sr_lock()
- * for more info.
- *
- * Returns 1 if entire region is locked, 0 if any portion is unlocked, and
- * negative on errors.
- */
-static int spi_nor_sr_is_locked(struct spi_nor *nor, loff_t ofs, uint64_t len)
-{
-	int ret;
-
-	ret = spi_nor_read_sr(nor, nor->bouncebuf);
-	if (ret)
-		return ret;
-
-	return spi_nor_is_locked_sr(nor, ofs, len, nor->bouncebuf[0]);
-}
-
-static const struct spi_nor_locking_ops spi_nor_sr_locking_ops = {
-	.lock = spi_nor_sr_lock,
-	.unlock = spi_nor_sr_unlock,
-	.is_locked = spi_nor_sr_is_locked,
-};
-
-static int spi_nor_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
-{
-	struct spi_nor *nor = mtd_to_spi_nor(mtd);
-	int ret;
-
-	ret = spi_nor_lock_and_prep(nor);
-	if (ret)
-		return ret;
-
-	ret = nor->params->locking_ops->lock(nor, ofs, len);
-
-	spi_nor_unlock_and_unprep(nor);
-	return ret;
-}
-
-static int spi_nor_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
-{
-	struct spi_nor *nor = mtd_to_spi_nor(mtd);
-	int ret;
-
-	ret = spi_nor_lock_and_prep(nor);
-	if (ret)
-		return ret;
-
-	ret = nor->params->locking_ops->unlock(nor, ofs, len);
-
-	spi_nor_unlock_and_unprep(nor);
-	return ret;
-}
-
-static int spi_nor_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
-{
-	struct spi_nor *nor = mtd_to_spi_nor(mtd);
-	int ret;
-
-	ret = spi_nor_lock_and_prep(nor);
-	if (ret)
-		return ret;
-
-	ret = nor->params->locking_ops->is_locked(nor, ofs, len);
-
-	spi_nor_unlock_and_unprep(nor);
-	return ret;
-}
-
 /**
  * spi_nor_sr1_bit6_quad_enable() - Set the Quad Enable BIT(6) in the Status
  * Register 1.
@@ -3046,7 +2676,7 @@ static void spi_nor_late_init_params(struct spi_nor *nor)
 	 * the default ones.
 	 */
 	if (nor->flags & SNOR_F_HAS_LOCK && !nor->params->locking_ops)
-		nor->params->locking_ops = &spi_nor_sr_locking_ops;
+		spi_nor_init_default_locking_ops(nor);
 }
 
 /**
@@ -3158,32 +2788,6 @@ static int spi_nor_quad_enable(struct spi_nor *nor)
 	return nor->params->quad_enable(nor);
 }
 
-/**
- * spi_nor_try_unlock_all() - Tries to unlock the entire flash memory array.
- * @nor:	pointer to a 'struct spi_nor'.
- *
- * Some SPI NOR flashes are write protected by default after a power-on reset
- * cycle, in order to avoid inadvertent writes during power-up. Backward
- * compatibility imposes to unlock the entire flash memory array at power-up
- * by default.
- *
- * Unprotecting the entire flash array will fail for boards which are hardware
- * write-protected. Thus any errors are ignored.
- */
-static void spi_nor_try_unlock_all(struct spi_nor *nor)
-{
-	int ret;
-
-	if (!(nor->flags & SNOR_F_HAS_LOCK))
-		return;
-
-	dev_dbg(nor->dev, "Unprotecting entire flash array\n");
-
-	ret = spi_nor_unlock(&nor->mtd, 0, nor->params->size);
-	if (ret)
-		dev_dbg(nor->dev, "Failed to unlock the entire flash memory array\n");
-}
-
 static int spi_nor_init(struct spi_nor *nor)
 {
 	int err;
@@ -3494,12 +3098,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	mtd->_suspend = spi_nor_suspend;
 	mtd->_resume = spi_nor_resume;
 
-	if (nor->params->locking_ops) {
-		mtd->_lock = spi_nor_lock;
-		mtd->_unlock = spi_nor_unlock;
-		mtd->_is_locked = spi_nor_is_locked;
-	}
-
 	if (info->flags & USE_FSR)
 		nor->flags |= SNOR_F_USE_FSR;
 	if (info->flags & SPI_NOR_HAS_TB) {
@@ -3551,6 +3149,8 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	if (ret)
 		return ret;
 
+	spi_nor_register_locking_ops(nor);
+
 	/* Send all the required SPI flash commands to initialize device */
 	ret = spi_nor_init(nor);
 	if (ret)
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index db07832ee66c..74f6026b7335 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -471,6 +471,10 @@ int spi_nor_post_bfpt_fixups(struct spi_nor *nor,
 			     const struct sfdp_parameter_header *bfpt_header,
 			     const struct sfdp_bfpt *bfpt);
 
+void spi_nor_init_default_locking_ops(struct spi_nor *nor);
+void spi_nor_try_unlock_all(struct spi_nor *nor);
+void spi_nor_register_locking_ops(struct spi_nor *nor);
+
 static struct spi_nor __maybe_unused *mtd_to_spi_nor(struct mtd_info *mtd)
 {
 	return mtd->priv;
diff --git a/drivers/mtd/spi-nor/swp.c b/drivers/mtd/spi-nor/swp.c
new file mode 100644
index 000000000000..5b236db6bb56
--- /dev/null
+++ b/drivers/mtd/spi-nor/swp.c
@@ -0,0 +1,424 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SPI NOR Software Write Protection logic.
+ *
+ * Copyright (C) 2005, Intec Automation Inc.
+ * Copyright (C) 2014, Freescale Semiconductor, Inc.
+ */
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/spi-nor.h>
+
+#include "core.h"
+
+static u8 spi_nor_get_sr_bp_mask(struct spi_nor *nor)
+{
+	u8 mask = SR_BP2 | SR_BP1 | SR_BP0;
+
+	if (nor->flags & SNOR_F_HAS_SR_BP3_BIT6)
+		return mask | SR_BP3_BIT6;
+
+	if (nor->flags & SNOR_F_HAS_4BIT_BP)
+		return mask | SR_BP3;
+
+	return mask;
+}
+
+static u8 spi_nor_get_sr_tb_mask(struct spi_nor *nor)
+{
+	if (nor->flags & SNOR_F_HAS_SR_TB_BIT6)
+		return SR_TB_BIT6;
+	else
+		return SR_TB_BIT5;
+}
+
+static u64 spi_nor_get_min_prot_length_sr(struct spi_nor *nor)
+{
+	unsigned int bp_slots, bp_slots_needed;
+	u8 mask = spi_nor_get_sr_bp_mask(nor);
+
+	/* Reserved one for "protect none" and one for "protect all". */
+	bp_slots = (1 << hweight8(mask)) - 2;
+	bp_slots_needed = ilog2(nor->info->n_sectors);
+
+	if (bp_slots_needed > bp_slots)
+		return nor->info->sector_size <<
+			(bp_slots_needed - bp_slots);
+	else
+		return nor->info->sector_size;
+}
+
+static void spi_nor_get_locked_range_sr(struct spi_nor *nor, u8 sr, loff_t *ofs,
+					uint64_t *len)
+{
+	struct mtd_info *mtd = &nor->mtd;
+	u64 min_prot_len;
+	u8 mask = spi_nor_get_sr_bp_mask(nor);
+	u8 tb_mask = spi_nor_get_sr_tb_mask(nor);
+	u8 bp, val = sr & mask;
+
+	if (nor->flags & SNOR_F_HAS_SR_BP3_BIT6 && val & SR_BP3_BIT6)
+		val = (val & ~SR_BP3_BIT6) | SR_BP3;
+
+	bp = val >> SR_BP_SHIFT;
+
+	if (!bp) {
+		/* No protection */
+		*ofs = 0;
+		*len = 0;
+		return;
+	}
+
+	min_prot_len = spi_nor_get_min_prot_length_sr(nor);
+	*len = min_prot_len << (bp - 1);
+
+	if (*len > mtd->size)
+		*len = mtd->size;
+
+	if (nor->flags & SNOR_F_HAS_SR_TB && sr & tb_mask)
+		*ofs = 0;
+	else
+		*ofs = mtd->size - *len;
+}
+
+/*
+ * Return 1 if the entire region is locked (if @locked is true) or unlocked (if
+ * @locked is false); 0 otherwise
+ */
+static int spi_nor_check_lock_status_sr(struct spi_nor *nor, loff_t ofs,
+					uint64_t len, u8 sr, bool locked)
+{
+	loff_t lock_offs;
+	uint64_t lock_len;
+
+	if (!len)
+		return 1;
+
+	spi_nor_get_locked_range_sr(nor, sr, &lock_offs, &lock_len);
+
+	if (locked)
+		/* Requested range is a sub-range of locked range */
+		return (ofs + len <= lock_offs + lock_len) && (ofs >= lock_offs);
+	else
+		/* Requested range does not overlap with locked range */
+		return (ofs >= lock_offs + lock_len) || (ofs + len <= lock_offs);
+}
+
+static int spi_nor_is_locked_sr(struct spi_nor *nor, loff_t ofs, uint64_t len,
+				u8 sr)
+{
+	return spi_nor_check_lock_status_sr(nor, ofs, len, sr, true);
+}
+
+static int spi_nor_is_unlocked_sr(struct spi_nor *nor, loff_t ofs, uint64_t len,
+				  u8 sr)
+{
+	return spi_nor_check_lock_status_sr(nor, ofs, len, sr, false);
+}
+
+/*
+ * Lock a region of the flash. Compatible with ST Micro and similar flash.
+ * Supports the block protection bits BP{0,1,2}/BP{0,1,2,3} in the status
+ * register
+ * (SR). Does not support these features found in newer SR bitfields:
+ *   - SEC: sector/block protect - only handle SEC=0 (block protect)
+ *   - CMP: complement protect - only support CMP=0 (range is not complemented)
+ *
+ * Support for the following is provided conditionally for some flash:
+ *   - TB: top/bottom protect
+ *
+ * Sample table portion for 8MB flash (Winbond w25q64fw):
+ *
+ *   SEC  |  TB   |  BP2  |  BP1  |  BP0  |  Prot Length  | Protected Portion
+ *  --------------------------------------------------------------------------
+ *    X   |   X   |   0   |   0   |   0   |  NONE         | NONE
+ *    0   |   0   |   0   |   0   |   1   |  128 KB       | Upper 1/64
+ *    0   |   0   |   0   |   1   |   0   |  256 KB       | Upper 1/32
+ *    0   |   0   |   0   |   1   |   1   |  512 KB       | Upper 1/16
+ *    0   |   0   |   1   |   0   |   0   |  1 MB         | Upper 1/8
+ *    0   |   0   |   1   |   0   |   1   |  2 MB         | Upper 1/4
+ *    0   |   0   |   1   |   1   |   0   |  4 MB         | Upper 1/2
+ *    X   |   X   |   1   |   1   |   1   |  8 MB         | ALL
+ *  ------|-------|-------|-------|-------|---------------|-------------------
+ *    0   |   1   |   0   |   0   |   1   |  128 KB       | Lower 1/64
+ *    0   |   1   |   0   |   1   |   0   |  256 KB       | Lower 1/32
+ *    0   |   1   |   0   |   1   |   1   |  512 KB       | Lower 1/16
+ *    0   |   1   |   1   |   0   |   0   |  1 MB         | Lower 1/8
+ *    0   |   1   |   1   |   0   |   1   |  2 MB         | Lower 1/4
+ *    0   |   1   |   1   |   1   |   0   |  4 MB         | Lower 1/2
+ *
+ * Returns negative on errors, 0 on success.
+ */
+static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	struct mtd_info *mtd = &nor->mtd;
+	u64 min_prot_len;
+	int ret, status_old, status_new;
+	u8 mask = spi_nor_get_sr_bp_mask(nor);
+	u8 tb_mask = spi_nor_get_sr_tb_mask(nor);
+	u8 pow, val;
+	loff_t lock_len;
+	bool can_be_top = true, can_be_bottom = nor->flags & SNOR_F_HAS_SR_TB;
+	bool use_top;
+
+	ret = spi_nor_read_sr(nor, nor->bouncebuf);
+	if (ret)
+		return ret;
+
+	status_old = nor->bouncebuf[0];
+
+	/* If nothing in our range is unlocked, we don't need to do anything */
+	if (spi_nor_is_locked_sr(nor, ofs, len, status_old))
+		return 0;
+
+	/* If anything below us is unlocked, we can't use 'bottom' protection */
+	if (!spi_nor_is_locked_sr(nor, 0, ofs, status_old))
+		can_be_bottom = false;
+
+	/* If anything above us is unlocked, we can't use 'top' protection */
+	if (!spi_nor_is_locked_sr(nor, ofs + len, mtd->size - (ofs + len),
+				  status_old))
+		can_be_top = false;
+
+	if (!can_be_bottom && !can_be_top)
+		return -EINVAL;
+
+	/* Prefer top, if both are valid */
+	use_top = can_be_top;
+
+	/* lock_len: length of region that should end up locked */
+	if (use_top)
+		lock_len = mtd->size - ofs;
+	else
+		lock_len = ofs + len;
+
+	if (lock_len == mtd->size) {
+		val = mask;
+	} else {
+		min_prot_len = spi_nor_get_min_prot_length_sr(nor);
+		pow = ilog2(lock_len) - ilog2(min_prot_len) + 1;
+		val = pow << SR_BP_SHIFT;
+
+		if (nor->flags & SNOR_F_HAS_SR_BP3_BIT6 && val & SR_BP3)
+			val = (val & ~SR_BP3) | SR_BP3_BIT6;
+
+		if (val & ~mask)
+			return -EINVAL;
+
+		/* Don't "lock" with no region! */
+		if (!(val & mask))
+			return -EINVAL;
+	}
+
+	status_new = (status_old & ~mask & ~tb_mask) | val;
+
+	/* Disallow further writes if WP pin is asserted */
+	status_new |= SR_SRWD;
+
+	if (!use_top)
+		status_new |= tb_mask;
+
+	/* Don't bother if they're the same */
+	if (status_new == status_old)
+		return 0;
+
+	/* Only modify protection if it will not unlock other areas */
+	if ((status_new & mask) < (status_old & mask))
+		return -EINVAL;
+
+	return spi_nor_write_sr_and_check(nor, status_new);
+}
+
+/*
+ * Unlock a region of the flash. See spi_nor_sr_lock() for more info
+ *
+ * Returns negative on errors, 0 on success.
+ */
+static int spi_nor_sr_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	struct mtd_info *mtd = &nor->mtd;
+	u64 min_prot_len;
+	int ret, status_old, status_new;
+	u8 mask = spi_nor_get_sr_bp_mask(nor);
+	u8 tb_mask = spi_nor_get_sr_tb_mask(nor);
+	u8 pow, val;
+	loff_t lock_len;
+	bool can_be_top = true, can_be_bottom = nor->flags & SNOR_F_HAS_SR_TB;
+	bool use_top;
+
+	ret = spi_nor_read_sr(nor, nor->bouncebuf);
+	if (ret)
+		return ret;
+
+	status_old = nor->bouncebuf[0];
+
+	/* If nothing in our range is locked, we don't need to do anything */
+	if (spi_nor_is_unlocked_sr(nor, ofs, len, status_old))
+		return 0;
+
+	/* If anything below us is locked, we can't use 'top' protection */
+	if (!spi_nor_is_unlocked_sr(nor, 0, ofs, status_old))
+		can_be_top = false;
+
+	/* If anything above us is locked, we can't use 'bottom' protection */
+	if (!spi_nor_is_unlocked_sr(nor, ofs + len, mtd->size - (ofs + len),
+				    status_old))
+		can_be_bottom = false;
+
+	if (!can_be_bottom && !can_be_top)
+		return -EINVAL;
+
+	/* Prefer top, if both are valid */
+	use_top = can_be_top;
+
+	/* lock_len: length of region that should remain locked */
+	if (use_top)
+		lock_len = mtd->size - (ofs + len);
+	else
+		lock_len = ofs;
+
+	if (lock_len == 0) {
+		val = 0; /* fully unlocked */
+	} else {
+		min_prot_len = spi_nor_get_min_prot_length_sr(nor);
+		pow = ilog2(lock_len) - ilog2(min_prot_len) + 1;
+		val = pow << SR_BP_SHIFT;
+
+		if (nor->flags & SNOR_F_HAS_SR_BP3_BIT6 && val & SR_BP3)
+			val = (val & ~SR_BP3) | SR_BP3_BIT6;
+
+		/* Some power-of-two sizes are not supported */
+		if (val & ~mask)
+			return -EINVAL;
+	}
+
+	status_new = (status_old & ~mask & ~tb_mask) | val;
+
+	/* Don't protect status register if we're fully unlocked */
+	if (lock_len == 0)
+		status_new &= ~SR_SRWD;
+
+	if (!use_top)
+		status_new |= tb_mask;
+
+	/* Don't bother if they're the same */
+	if (status_new == status_old)
+		return 0;
+
+	/* Only modify protection if it will not lock other areas */
+	if ((status_new & mask) > (status_old & mask))
+		return -EINVAL;
+
+	return spi_nor_write_sr_and_check(nor, status_new);
+}
+
+/*
+ * Check if a region of the flash is (completely) locked. See spi_nor_sr_lock()
+ * for more info.
+ *
+ * Returns 1 if entire region is locked, 0 if any portion is unlocked, and
+ * negative on errors.
+ */
+static int spi_nor_sr_is_locked(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	int ret;
+
+	ret = spi_nor_read_sr(nor, nor->bouncebuf);
+	if (ret)
+		return ret;
+
+	return spi_nor_is_locked_sr(nor, ofs, len, nor->bouncebuf[0]);
+}
+
+static const struct spi_nor_locking_ops spi_nor_sr_locking_ops = {
+	.lock = spi_nor_sr_lock,
+	.unlock = spi_nor_sr_unlock,
+	.is_locked = spi_nor_sr_is_locked,
+};
+
+void spi_nor_init_default_locking_ops(struct spi_nor *nor)
+{
+	nor->params->locking_ops = &spi_nor_sr_locking_ops;
+}
+
+static int spi_nor_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	int ret;
+
+	ret = spi_nor_lock_and_prep(nor);
+	if (ret)
+		return ret;
+
+	ret = nor->params->locking_ops->lock(nor, ofs, len);
+
+	spi_nor_unlock_and_unprep(nor);
+	return ret;
+}
+
+static int spi_nor_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	int ret;
+
+	ret = spi_nor_lock_and_prep(nor);
+	if (ret)
+		return ret;
+
+	ret = nor->params->locking_ops->unlock(nor, ofs, len);
+
+	spi_nor_unlock_and_unprep(nor);
+	return ret;
+}
+
+static int spi_nor_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	int ret;
+
+	ret = spi_nor_lock_and_prep(nor);
+	if (ret)
+		return ret;
+
+	ret = nor->params->locking_ops->is_locked(nor, ofs, len);
+
+	spi_nor_unlock_and_unprep(nor);
+	return ret;
+}
+
+/**
+ * spi_nor_try_unlock_all() - Tries to unlock the entire flash memory array.
+ * @nor:	pointer to a 'struct spi_nor'.
+ *
+ * Some SPI NOR flashes are write protected by default after a power-on reset
+ * cycle, in order to avoid inadvertent writes during power-up. Backward
+ * compatibility imposes to unlock the entire flash memory array at power-up
+ * by default.
+ *
+ * Unprotecting the entire flash array will fail for boards which are hardware
+ * write-protected. Thus any errors are ignored.
+ */
+void spi_nor_try_unlock_all(struct spi_nor *nor)
+{
+	int ret;
+
+	if (!(nor->flags & SNOR_F_HAS_LOCK))
+		return;
+
+	dev_dbg(nor->dev, "Unprotecting entire flash array\n");
+
+	ret = spi_nor_unlock(&nor->mtd, 0, nor->params->size);
+	if (ret)
+		dev_dbg(nor->dev, "Failed to unlock the entire flash memory array\n");
+}
+
+void spi_nor_register_locking_ops(struct spi_nor *nor)
+{
+	struct mtd_info *mtd = &nor->mtd;
+
+	if (!nor->params->locking_ops)
+		return;
+
+	mtd->_lock = spi_nor_lock;
+	mtd->_unlock = spi_nor_unlock;
+	mtd->_is_locked = spi_nor_is_locked;
+}
-- 
2.25.1

