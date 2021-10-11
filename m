Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0859C428C62
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbhJKLzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:55:17 -0400
Received: from first.geanix.com ([116.203.34.67]:37360 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236234AbhJKLzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:55:16 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id D7CF0C3DAF;
        Mon, 11 Oct 2021 11:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1633953194; bh=0zDQiRwHm1wvs57rK5lMS4f3kyKcpKi3AIaDDdl1PjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VWT4H8p9lBVJzwQnLZ0kd+GEl7lZa0te8Jx3RUIWlIqEiYs5jHwtnOLkTPX7mcHm3
         6KQae7DQBfyFhaoWVELWx2AOY1AIxM3HgsW49FCwsZgsrtDxe8xwD3X+J61HzlpkoE
         H7w36ZNpbaPE5mYQubrt+37xo9J+zKSxmEe9PGxpaqwt/ZGSgcFXPaze6sHjU/mqRu
         Hg9zoiySXhNxgOZJ9MSg5ZdQbKDKrkuu1/0qcEfPb9oPyCmsWagd8JajbIV3I0gOYi
         7JGwPOmDOxbSvZtD/8OSWSZAnDEyxdK/BWXrbTyztvY5mlqoLIJnjU5DLxUOiODKjs
         2vRQAeUbipcAQ==
From:   Sean Nyekjaer <sean@geanix.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Sean Nyekjaer <sean@geanix.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mtd: core: protect access to MTD devices while in suspend
Date:   Mon, 11 Oct 2021 13:52:51 +0200
Message-Id: <20211011115253.38497-2-sean@geanix.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011115253.38497-1-sean@geanix.com>
References: <20211011115253.38497-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent accessing the devices while in a suspended state. Also
prevent suspending a device which is still currently in use.

Commit 013e6292aaf5 ("mtd: rawnand: Simplify the locking") allows the
rawnand layer to return errors rather than waiting in a blocking wait.

Tested on a iMX6ULL.

Fixes: 013e6292aaf5 ("mtd: rawnand: Simplify the locking")
Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/mtd/mtdcore.c   | 133 +++++++++++++++++++++++++++++++++++-----
 include/linux/mtd/mtd.h | 109 +++++++++++++++++++++++++++-----
 2 files changed, 211 insertions(+), 31 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index c8fd7f758938..51be9b46ef54 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -777,6 +777,8 @@ static void mtd_set_dev_defaults(struct mtd_info *mtd)
 	INIT_LIST_HEAD(&mtd->partitions);
 	mutex_init(&mtd->master.partitions_lock);
 	mutex_init(&mtd->master.chrdev_lock);
+	init_waitqueue_head(&mtd->master.resume_wq);
+	init_rwsem(&mtd->master.suspend_lock);
 }
 
 static ssize_t mtd_otp_size(struct mtd_info *mtd, bool is_user)
@@ -1257,6 +1259,8 @@ int mtd_erase(struct mtd_info *mtd, struct erase_info *instr)
 
 	ledtrig_mtd_activity();
 
+	mtd_start_access(mtd);
+
 	if (mtd->flags & MTD_SLC_ON_MLC_EMULATION) {
 		adjinstr.addr = (loff_t)mtd_div_by_eb(instr->addr, mtd) *
 				master->erasesize;
@@ -1278,6 +1282,8 @@ int mtd_erase(struct mtd_info *mtd, struct erase_info *instr)
 		}
 	}
 
+	mtd_end_access(mtd);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(mtd_erase);
@@ -1289,6 +1295,7 @@ int mtd_point(struct mtd_info *mtd, loff_t from, size_t len, size_t *retlen,
 	      void **virt, resource_size_t *phys)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
+	int ret;
 
 	*retlen = 0;
 	*virt = NULL;
@@ -1301,8 +1308,12 @@ int mtd_point(struct mtd_info *mtd, loff_t from, size_t len, size_t *retlen,
 	if (!len)
 		return 0;
 
+	mtd_start_access(mtd);
 	from = mtd_get_master_ofs(mtd, from);
-	return master->_point(master, from, len, retlen, virt, phys);
+	ret = master->_point(master, from, len, retlen, virt, phys);
+	mtd_end_access(mtd);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mtd_point);
 
@@ -1310,6 +1321,7 @@ EXPORT_SYMBOL_GPL(mtd_point);
 int mtd_unpoint(struct mtd_info *mtd, loff_t from, size_t len)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
+	int ret;
 
 	if (!master->_unpoint)
 		return -EOPNOTSUPP;
@@ -1317,7 +1329,12 @@ int mtd_unpoint(struct mtd_info *mtd, loff_t from, size_t len)
 		return -EINVAL;
 	if (!len)
 		return 0;
-	return master->_unpoint(master, mtd_get_master_ofs(mtd, from), len);
+
+	mtd_start_access(mtd);
+	ret =  master->_unpoint(master, mtd_get_master_ofs(mtd, from), len);
+	mtd_end_access(mtd);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mtd_unpoint);
 
@@ -1372,6 +1389,7 @@ int mtd_read(struct mtd_info *mtd, loff_t from, size_t len, size_t *retlen,
 	};
 	int ret;
 
+	/* mtd_read_oob handles mtd access protection */
 	ret = mtd_read_oob(mtd, from, &ops);
 	*retlen = ops.retlen;
 
@@ -1388,6 +1406,7 @@ int mtd_write(struct mtd_info *mtd, loff_t to, size_t len, size_t *retlen,
 	};
 	int ret;
 
+	/* mtd_write_oob handles mtd access protection */
 	ret = mtd_write_oob(mtd, to, &ops);
 	*retlen = ops.retlen;
 
@@ -1406,6 +1425,7 @@ int mtd_panic_write(struct mtd_info *mtd, loff_t to, size_t len, size_t *retlen,
 		    const u_char *buf)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
+	int ret;
 
 	*retlen = 0;
 	if (!master->_panic_write)
@@ -1419,8 +1439,12 @@ int mtd_panic_write(struct mtd_info *mtd, loff_t to, size_t len, size_t *retlen,
 	if (!master->oops_panic_write)
 		master->oops_panic_write = true;
 
-	return master->_panic_write(master, mtd_get_master_ofs(mtd, to), len,
-				    retlen, buf);
+	mtd_start_access(mtd);
+	ret = master->_panic_write(master, mtd_get_master_ofs(mtd, to), len,
+				   retlen, buf);
+	mtd_end_access(mtd);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mtd_panic_write);
 
@@ -1566,6 +1590,8 @@ int mtd_read_oob(struct mtd_info *mtd, loff_t from, struct mtd_oob_ops *ops)
 
 	ledtrig_mtd_activity();
 
+	mtd_start_access(mtd);
+
 	/* Check the validity of a potential fallback on mtd->_read */
 	if (!master->_read_oob && (!master->_read || ops->oobbuf))
 		return -EOPNOTSUPP;
@@ -1576,7 +1602,7 @@ int mtd_read_oob(struct mtd_info *mtd, loff_t from, struct mtd_oob_ops *ops)
 		ret_code = mtd_read_oob_std(mtd, from, ops);
 
 	mtd_update_ecc_stats(mtd, master, &old_stats);
-
+	mtd_end_access(mtd);
 	/*
 	 * In cases where ops->datbuf != NULL, mtd->_read_oob() has semantics
 	 * similar to mtd->_read(), returning a non-negative integer
@@ -1597,6 +1623,8 @@ int mtd_write_oob(struct mtd_info *mtd, loff_t to,
 	struct mtd_info *master = mtd_get_master(mtd);
 	int ret;
 
+	mtd_start_access(mtd);
+
 	ops->retlen = ops->oobretlen = 0;
 
 	if (!(mtd->flags & MTD_WRITEABLE))
@@ -1615,7 +1643,10 @@ int mtd_write_oob(struct mtd_info *mtd, loff_t to,
 	if (mtd->flags & MTD_SLC_ON_MLC_EMULATION)
 		return mtd_io_emulated_slc(mtd, to, false, ops);
 
-	return mtd_write_oob_std(mtd, to, ops);
+	ret = mtd_write_oob_std(mtd, to, ops);
+	mtd_end_access(mtd);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mtd_write_oob);
 
@@ -1992,12 +2023,18 @@ int mtd_get_fact_prot_info(struct mtd_info *mtd, size_t len, size_t *retlen,
 			   struct otp_info *buf)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
+	int ret;
 
 	if (!master->_get_fact_prot_info)
 		return -EOPNOTSUPP;
 	if (!len)
 		return 0;
-	return master->_get_fact_prot_info(master, len, retlen, buf);
+
+	mtd_start_access(mtd);
+	ret = master->_get_fact_prot_info(master, len, retlen, buf);
+	mtd_end_access(mtd);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mtd_get_fact_prot_info);
 
@@ -2005,13 +2042,19 @@ int mtd_read_fact_prot_reg(struct mtd_info *mtd, loff_t from, size_t len,
 			   size_t *retlen, u_char *buf)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
+	int ret;
 
 	*retlen = 0;
 	if (!master->_read_fact_prot_reg)
 		return -EOPNOTSUPP;
 	if (!len)
 		return 0;
-	return master->_read_fact_prot_reg(master, from, len, retlen, buf);
+
+	mtd_start_access(mtd);
+	ret = master->_read_fact_prot_reg(master, from, len, retlen, buf);
+	mtd_end_access(mtd);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mtd_read_fact_prot_reg);
 
@@ -2019,12 +2062,18 @@ int mtd_get_user_prot_info(struct mtd_info *mtd, size_t len, size_t *retlen,
 			   struct otp_info *buf)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
+	int ret;
 
 	if (!master->_get_user_prot_info)
 		return -EOPNOTSUPP;
 	if (!len)
 		return 0;
-	return master->_get_user_prot_info(master, len, retlen, buf);
+
+	mtd_start_access(mtd);
+	ret =  master->_get_user_prot_info(master, len, retlen, buf);
+	mtd_end_access(mtd);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mtd_get_user_prot_info);
 
@@ -2032,13 +2081,19 @@ int mtd_read_user_prot_reg(struct mtd_info *mtd, loff_t from, size_t len,
 			   size_t *retlen, u_char *buf)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
+	int ret;
 
 	*retlen = 0;
 	if (!master->_read_user_prot_reg)
 		return -EOPNOTSUPP;
 	if (!len)
 		return 0;
-	return master->_read_user_prot_reg(master, from, len, retlen, buf);
+
+	mtd_start_access(mtd);
+	ret = master->_read_user_prot_reg(master, from, len, retlen, buf);
+	mtd_end_access(mtd);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mtd_read_user_prot_reg);
 
@@ -2053,7 +2108,11 @@ int mtd_write_user_prot_reg(struct mtd_info *mtd, loff_t to, size_t len,
 		return -EOPNOTSUPP;
 	if (!len)
 		return 0;
+
+	mtd_start_access(mtd);
 	ret = master->_write_user_prot_reg(master, to, len, retlen, buf);
+	mtd_end_access(mtd);
+
 	if (ret)
 		return ret;
 
@@ -2068,24 +2127,36 @@ EXPORT_SYMBOL_GPL(mtd_write_user_prot_reg);
 int mtd_lock_user_prot_reg(struct mtd_info *mtd, loff_t from, size_t len)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
+	int ret;
 
 	if (!master->_lock_user_prot_reg)
 		return -EOPNOTSUPP;
 	if (!len)
 		return 0;
-	return master->_lock_user_prot_reg(master, from, len);
+
+	mtd_start_access(mtd);
+	ret = master->_lock_user_prot_reg(master, from, len);
+	mtd_end_access(mtd);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mtd_lock_user_prot_reg);
 
 int mtd_erase_user_prot_reg(struct mtd_info *mtd, loff_t from, size_t len)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
+	int ret;
 
 	if (!master->_erase_user_prot_reg)
 		return -EOPNOTSUPP;
 	if (!len)
 		return 0;
-	return master->_erase_user_prot_reg(master, from, len);
+
+	mtd_start_access(mtd);
+	ret = master->_erase_user_prot_reg(master, from, len);
+	mtd_end_access(mtd);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mtd_erase_user_prot_reg);
 
@@ -2093,6 +2164,7 @@ EXPORT_SYMBOL_GPL(mtd_erase_user_prot_reg);
 int mtd_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
+	int ret;
 
 	if (!master->_lock)
 		return -EOPNOTSUPP;
@@ -2106,13 +2178,18 @@ int mtd_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 		len = (u64)mtd_div_by_eb(len, mtd) * master->erasesize;
 	}
 
-	return master->_lock(master, mtd_get_master_ofs(mtd, ofs), len);
+	mtd_start_access(mtd);
+	ret = master->_lock(master, mtd_get_master_ofs(mtd, ofs), len);
+	mtd_end_access(mtd);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mtd_lock);
 
 int mtd_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
+	int ret;
 
 	if (!master->_unlock)
 		return -EOPNOTSUPP;
@@ -2126,13 +2203,18 @@ int mtd_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 		len = (u64)mtd_div_by_eb(len, mtd) * master->erasesize;
 	}
 
-	return master->_unlock(master, mtd_get_master_ofs(mtd, ofs), len);
+	mtd_start_access(mtd);
+	ret = master->_unlock(master, mtd_get_master_ofs(mtd, ofs), len);
+	mtd_end_access(mtd);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mtd_unlock);
 
 int mtd_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
+	int ret;
 
 	if (!master->_is_locked)
 		return -EOPNOTSUPP;
@@ -2146,13 +2228,18 @@ int mtd_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 		len = (u64)mtd_div_by_eb(len, mtd) * master->erasesize;
 	}
 
-	return master->_is_locked(master, mtd_get_master_ofs(mtd, ofs), len);
+	mtd_start_access(mtd);
+	ret = master->_is_locked(master, mtd_get_master_ofs(mtd, ofs), len);
+	mtd_end_access(mtd);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mtd_is_locked);
 
 int mtd_block_isreserved(struct mtd_info *mtd, loff_t ofs)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
+	int ret;
 
 	if (ofs < 0 || ofs >= mtd->size)
 		return -EINVAL;
@@ -2162,13 +2249,18 @@ int mtd_block_isreserved(struct mtd_info *mtd, loff_t ofs)
 	if (mtd->flags & MTD_SLC_ON_MLC_EMULATION)
 		ofs = (loff_t)mtd_div_by_eb(ofs, mtd) * master->erasesize;
 
-	return master->_block_isreserved(master, mtd_get_master_ofs(mtd, ofs));
+	mtd_start_access(mtd);
+	ret = master->_block_isreserved(master, mtd_get_master_ofs(mtd, ofs));
+	mtd_end_access(mtd);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mtd_block_isreserved);
 
 int mtd_block_isbad(struct mtd_info *mtd, loff_t ofs)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
+	int ret;
 
 	if (ofs < 0 || ofs >= mtd->size)
 		return -EINVAL;
@@ -2178,7 +2270,11 @@ int mtd_block_isbad(struct mtd_info *mtd, loff_t ofs)
 	if (mtd->flags & MTD_SLC_ON_MLC_EMULATION)
 		ofs = (loff_t)mtd_div_by_eb(ofs, mtd) * master->erasesize;
 
-	return master->_block_isbad(master, mtd_get_master_ofs(mtd, ofs));
+	mtd_start_access(mtd);
+	ret = master->_block_isbad(master, mtd_get_master_ofs(mtd, ofs));
+	mtd_end_access(mtd);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mtd_block_isbad);
 
@@ -2197,7 +2293,10 @@ int mtd_block_markbad(struct mtd_info *mtd, loff_t ofs)
 	if (mtd->flags & MTD_SLC_ON_MLC_EMULATION)
 		ofs = (loff_t)mtd_div_by_eb(ofs, mtd) * master->erasesize;
 
+	mtd_start_access(mtd);
 	ret = master->_block_markbad(master, mtd_get_master_ofs(mtd, ofs));
+	mtd_end_access(mtd);
+
 	if (ret)
 		return ret;
 
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 88227044fc86..7765d1fcfc8b 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -231,6 +231,8 @@ struct mtd_master {
 	struct mutex partitions_lock;
 	struct mutex chrdev_lock;
 	unsigned int suspended : 1;
+	wait_queue_head_t resume_wq;
+	struct rw_semaphore suspend_lock;
 };
 
 struct mtd_info {
@@ -476,10 +478,49 @@ static inline u32 mtd_oobavail(struct mtd_info *mtd, struct mtd_oob_ops *ops)
 	return ops->mode == MTD_OPS_AUTO_OOB ? mtd->oobavail : mtd->oobsize;
 }
 
+static inline void mtd_start_access(struct mtd_info *mtd)
+{
+	struct mtd_info *master = mtd_get_master(mtd);
+
+	/*
+	 * Don't take the suspend_lock on devices that don't
+	 * implement the suspend hook. Otherwise, lockdep will
+	 * complain about nested locks when trying to suspend MTD
+	 * partitions or MTD devices created by gluebi which are
+	 * backed by real devices.
+	 */
+	if (!master->_suspend)
+		return;
+
+	/*
+	 * Wait until the device is resumed. Should we have a
+	 * non-blocking mode here?
+	 */
+	while (1) {
+		down_read(&master->master.suspend_lock);
+		if (!master->master.suspended)
+			return;
+
+		up_read(&master->master.suspend_lock);
+		wait_event(master->master.resume_wq, master->master.suspended == 0);
+	}
+}
+
+static inline void mtd_end_access(struct mtd_info *mtd)
+{
+	struct mtd_info *master = mtd_get_master(mtd);
+
+	if (!master->_suspend)
+		return;
+
+	up_read(&master->master.suspend_lock);
+}
+
 static inline int mtd_max_bad_blocks(struct mtd_info *mtd,
 				     loff_t ofs, size_t len)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
+	int ret;
 
 	if (!master->_max_bad_blocks)
 		return -ENOTSUPP;
@@ -487,8 +528,12 @@ static inline int mtd_max_bad_blocks(struct mtd_info *mtd,
 	if (mtd->size < (len + ofs) || ofs < 0)
 		return -EINVAL;
 
-	return master->_max_bad_blocks(master, mtd_get_master_ofs(mtd, ofs),
-				       len);
+	mtd_start_access(mtd);
+	ret = master->_max_bad_blocks(master, mtd_get_master_ofs(mtd, ofs),
+				      len);
+	mtd_end_access(mtd);
+
+	return ret;
 }
 
 int mtd_wunit_to_pairing_info(struct mtd_info *mtd, int wunit,
@@ -543,33 +588,69 @@ int mtd_block_isreserved(struct mtd_info *mtd, loff_t ofs);
 int mtd_block_isbad(struct mtd_info *mtd, loff_t ofs);
 int mtd_block_markbad(struct mtd_info *mtd, loff_t ofs);
 
+static inline int __mtd_suspend(struct mtd_info *mtd)
+{
+	struct mtd_info *master = mtd_get_master(mtd);
+	int ret = 0;
+
+	if (!master->_suspend)
+		return ret;
+
+	if (!master->master.suspended) {
+		ret = master->_suspend(master);
+		if (!ret)
+			master->master.suspended = 1;
+	}
+
+	return ret;
+}
+
 static inline int mtd_suspend(struct mtd_info *mtd)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
-	int ret;
+	int ret = 0;
 
-	if (master->master.suspended)
-		return 0;
+	if (!master->_suspend)
+		return ret;
 
-	ret = master->_suspend ? master->_suspend(master) : 0;
-	if (ret)
+	down_write(&master->master.suspend_lock);
+	ret = __mtd_suspend(mtd);
+	up_write(&master->master.suspend_lock);
+
+	return ret;
+}
+
+static inline int __mtd_resume(struct mtd_info *mtd)
+{
+	struct mtd_info *master = mtd_get_master(mtd);
+	int ret = 0;
+
+	if (!master->_suspend)
 		return ret;
 
-	master->master.suspended = 1;
-	return 0;
+	if (master->master.suspended) {
+		if (master->_resume)
+			master->_resume(master);
+
+		master->master.suspended = 0;
+		ret = 1;
+	}
+
+	return ret;
 }
 
 static inline void mtd_resume(struct mtd_info *mtd)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
 
-	if (!master->master.suspended)
+	if (!master->_suspend)
 		return;
 
-	if (master->_resume)
-		master->_resume(master);
-
-	master->master.suspended = 0;
+	down_write(&master->master.suspend_lock);
+	/* If MTD dev has been resumed, wake up all waiters. */
+	if (__mtd_resume(mtd))
+		wake_up_all(&master->master.resume_wq);
+	up_write(&master->master.suspend_lock);
 }
 
 static inline uint32_t mtd_div_by_eb(uint64_t sz, struct mtd_info *mtd)
-- 
2.33.0

