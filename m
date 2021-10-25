Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDBB439257
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 11:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbhJYJa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 05:30:26 -0400
Received: from first.geanix.com ([116.203.34.67]:37404 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232511AbhJYJaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 05:30:24 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id D60A9D6861;
        Mon, 25 Oct 2021 09:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1635154080; bh=038jLJ8ZIomplxvGbzXp9SEcCbMFrdIXsyP6DJ+NpCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NYAIAbRqNDRPpSw5Z2N95w5Z9WgqbhiM0cr4HbzuYyvdAGkqIRqALbNix+b5UcZ5o
         HCBOG6Htjmza0aZQARexNEYC32LX7V4oKMigyY2EGSNtyf3Nheq3o8Rz0Yz6kEWHHQ
         6Ipd28hq0tl3t9HiKL93qEQsuvjNlOosVsJ6RC12fsjdGgXHmdc3HQTqMjaev9X0nU
         Q4ncI+3wR1Yqrg9cZs0FFaABb9rnqxuIbUMSDS9lzmJWyxz7AL0MvjUy6uZCdSYC7q
         dDIEdaTocsR5SVzW6dh6d5LDiuIq/Z8Z9nkeGhaXb7vt/wCZOHka+pwKYPv8BDhkoG
         OrBrRczISFr+Q==
From:   Sean Nyekjaer <sean@geanix.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Sean Nyekjaer <sean@geanix.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] mtd: core: protect access to MTD devices while in suspend
Date:   Mon, 25 Oct 2021 11:27:51 +0200
Message-Id: <20211025092752.2824678-4-sean@geanix.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025092752.2824678-1-sean@geanix.com>
References: <20211025092752.2824678-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent MTD access while in a suspended state. Also
prevent suspending a device which is still currently in use.

Commit 013e6292aaf5 ("mtd: rawnand: Simplify the locking") allows the
rawnand layer to return errors rather than waiting in a blocking wait.

Tested on a iMX6ULL.

Fixes: 013e6292aaf5 ("mtd: rawnand: Simplify the locking")
Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/mtd/mtdcore.c   | 124 +++++++++++++++++++++++++++++++++++-----
 include/linux/mtd/mtd.h |  81 +++++++++++++++++++++-----
 2 files changed, 176 insertions(+), 29 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 153229198947..8e6b7e858ada 100644
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
@@ -1267,7 +1269,9 @@ int mtd_erase(struct mtd_info *mtd, struct erase_info *instr)
 
 	adjinstr.addr += mst_ofs;
 
+	mtd_start_access(master);
 	ret = master->_erase(master, &adjinstr);
+	mtd_end_access(master);
 
 	if (adjinstr.fail_addr != MTD_FAIL_ADDR_UNKNOWN) {
 		instr->fail_addr = adjinstr.fail_addr - mst_ofs;
@@ -1289,6 +1293,7 @@ int mtd_point(struct mtd_info *mtd, loff_t from, size_t len, size_t *retlen,
 	      void **virt, resource_size_t *phys)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
+	int ret;
 
 	*retlen = 0;
 	*virt = NULL;
@@ -1301,8 +1306,12 @@ int mtd_point(struct mtd_info *mtd, loff_t from, size_t len, size_t *retlen,
 	if (!len)
 		return 0;
 
+	mtd_start_access(master);
 	from = mtd_get_master_ofs(mtd, from);
-	return master->_point(master, from, len, retlen, virt, phys);
+	ret = master->_point(master, from, len, retlen, virt, phys);
+	mtd_end_access(master);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mtd_point);
 
@@ -1310,6 +1319,7 @@ EXPORT_SYMBOL_GPL(mtd_point);
 int mtd_unpoint(struct mtd_info *mtd, loff_t from, size_t len)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
+	int ret;
 
 	if (!master->_unpoint)
 		return -EOPNOTSUPP;
@@ -1317,7 +1327,12 @@ int mtd_unpoint(struct mtd_info *mtd, loff_t from, size_t len)
 		return -EINVAL;
 	if (!len)
 		return 0;
-	return master->_unpoint(master, mtd_get_master_ofs(mtd, from), len);
+
+	mtd_start_access(master);
+	ret =  master->_unpoint(master, mtd_get_master_ofs(mtd, from), len);
+	mtd_end_access(master);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mtd_unpoint);
 
@@ -1372,6 +1387,7 @@ int mtd_read(struct mtd_info *mtd, loff_t from, size_t len, size_t *retlen,
 	};
 	int ret;
 
+	/* mtd_read_oob_std handles mtd access protection */
 	ret = mtd_read_oob(mtd, from, &ops);
 	*retlen = ops.retlen;
 
@@ -1388,6 +1404,7 @@ int mtd_write(struct mtd_info *mtd, loff_t to, size_t len, size_t *retlen,
 	};
 	int ret;
 
+	/* mtd_write_oob_std handles mtd access protection */
 	ret = mtd_write_oob(mtd, to, &ops);
 	*retlen = ops.retlen;
 
@@ -1406,6 +1423,7 @@ int mtd_panic_write(struct mtd_info *mtd, loff_t to, size_t len, size_t *retlen,
 		    const u_char *buf)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
+	int ret;
 
 	*retlen = 0;
 	if (!master->_panic_write)
@@ -1419,8 +1437,12 @@ int mtd_panic_write(struct mtd_info *mtd, loff_t to, size_t len, size_t *retlen,
 	if (!master->oops_panic_write)
 		master->oops_panic_write = true;
 
-	return master->_panic_write(master, mtd_get_master_ofs(mtd, to), len,
-				    retlen, buf);
+	mtd_start_access(master);
+	ret = master->_panic_write(master, mtd_get_master_ofs(mtd, to), len,
+				   retlen, buf);
+	mtd_end_access(master);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mtd_panic_write);
 
@@ -1464,11 +1486,13 @@ static int mtd_read_oob_std(struct mtd_info *mtd, loff_t from,
 	int ret;
 
 	from = mtd_get_master_ofs(mtd, from);
+	mtd_start_access(master);
 	if (master->_read_oob)
 		ret = master->_read_oob(master, from, ops);
 	else
 		ret = master->_read(master, from, ops->len, &ops->retlen,
 				    ops->datbuf);
+	mtd_end_access(master);
 
 	return ret;
 }
@@ -1480,11 +1504,13 @@ static int mtd_write_oob_std(struct mtd_info *mtd, loff_t to,
 	int ret;
 
 	to = mtd_get_master_ofs(mtd, to);
+	mtd_start_access(master);
 	if (master->_write_oob)
 		ret = master->_write_oob(master, to, ops);
 	else
 		ret = master->_write(master, to, ops->len, &ops->retlen,
 				     ops->datbuf);
+	mtd_end_access(master);
 
 	return ret;
 }
@@ -1992,12 +2018,18 @@ int mtd_get_fact_prot_info(struct mtd_info *mtd, size_t len, size_t *retlen,
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
+	mtd_start_access(master);
+	ret = master->_get_fact_prot_info(master, len, retlen, buf);
+	mtd_end_access(master);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mtd_get_fact_prot_info);
 
@@ -2005,13 +2037,19 @@ int mtd_read_fact_prot_reg(struct mtd_info *mtd, loff_t from, size_t len,
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
+	mtd_start_access(master);
+	ret = master->_read_fact_prot_reg(master, from, len, retlen, buf);
+	mtd_end_access(master);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mtd_read_fact_prot_reg);
 
@@ -2019,12 +2057,18 @@ int mtd_get_user_prot_info(struct mtd_info *mtd, size_t len, size_t *retlen,
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
+	mtd_start_access(master);
+	ret =  master->_get_user_prot_info(master, len, retlen, buf);
+	mtd_end_access(master);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mtd_get_user_prot_info);
 
@@ -2032,13 +2076,19 @@ int mtd_read_user_prot_reg(struct mtd_info *mtd, loff_t from, size_t len,
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
+	mtd_start_access(master);
+	ret = master->_read_user_prot_reg(master, from, len, retlen, buf);
+	mtd_end_access(master);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mtd_read_user_prot_reg);
 
@@ -2053,7 +2103,11 @@ int mtd_write_user_prot_reg(struct mtd_info *mtd, loff_t to, size_t len,
 		return -EOPNOTSUPP;
 	if (!len)
 		return 0;
+
+	mtd_start_access(master);
 	ret = master->_write_user_prot_reg(master, to, len, retlen, buf);
+	mtd_end_access(master);
+
 	if (ret)
 		return ret;
 
@@ -2068,24 +2122,36 @@ EXPORT_SYMBOL_GPL(mtd_write_user_prot_reg);
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
+	mtd_start_access(master);
+	ret = master->_lock_user_prot_reg(master, from, len);
+	mtd_end_access(master);
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
+	mtd_start_access(master);
+	ret = master->_erase_user_prot_reg(master, from, len);
+	mtd_end_access(master);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mtd_erase_user_prot_reg);
 
@@ -2093,6 +2159,7 @@ EXPORT_SYMBOL_GPL(mtd_erase_user_prot_reg);
 int mtd_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
+	int ret;
 
 	if (!master->_lock)
 		return -EOPNOTSUPP;
@@ -2106,13 +2173,18 @@ int mtd_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 		len = (u64)mtd_div_by_eb(len, mtd) * master->erasesize;
 	}
 
-	return master->_lock(master, mtd_get_master_ofs(mtd, ofs), len);
+	mtd_start_access(master);
+	ret = master->_lock(master, mtd_get_master_ofs(mtd, ofs), len);
+	mtd_end_access(master);
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
@@ -2126,13 +2198,18 @@ int mtd_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 		len = (u64)mtd_div_by_eb(len, mtd) * master->erasesize;
 	}
 
-	return master->_unlock(master, mtd_get_master_ofs(mtd, ofs), len);
+	mtd_start_access(master);
+	ret = master->_unlock(master, mtd_get_master_ofs(mtd, ofs), len);
+	mtd_end_access(master);
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
@@ -2146,13 +2223,18 @@ int mtd_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 		len = (u64)mtd_div_by_eb(len, mtd) * master->erasesize;
 	}
 
-	return master->_is_locked(master, mtd_get_master_ofs(mtd, ofs), len);
+	mtd_start_access(master);
+	ret = master->_is_locked(master, mtd_get_master_ofs(mtd, ofs), len);
+	mtd_end_access(master);
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
@@ -2162,13 +2244,18 @@ int mtd_block_isreserved(struct mtd_info *mtd, loff_t ofs)
 	if (mtd->flags & MTD_SLC_ON_MLC_EMULATION)
 		ofs = (loff_t)mtd_div_by_eb(ofs, mtd) * master->erasesize;
 
-	return master->_block_isreserved(master, mtd_get_master_ofs(mtd, ofs));
+	mtd_start_access(master);
+	ret = master->_block_isreserved(master, mtd_get_master_ofs(mtd, ofs));
+	mtd_end_access(master);
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
@@ -2178,7 +2265,11 @@ int mtd_block_isbad(struct mtd_info *mtd, loff_t ofs)
 	if (mtd->flags & MTD_SLC_ON_MLC_EMULATION)
 		ofs = (loff_t)mtd_div_by_eb(ofs, mtd) * master->erasesize;
 
-	return master->_block_isbad(master, mtd_get_master_ofs(mtd, ofs));
+	mtd_start_access(master);
+	ret = master->_block_isbad(master, mtd_get_master_ofs(mtd, ofs));
+	mtd_end_access(master);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mtd_block_isbad);
 
@@ -2197,7 +2288,10 @@ int mtd_block_markbad(struct mtd_info *mtd, loff_t ofs)
 	if (mtd->flags & MTD_SLC_ON_MLC_EMULATION)
 		ofs = (loff_t)mtd_div_by_eb(ofs, mtd) * master->erasesize;
 
+	mtd_start_access(master);
 	ret = master->_block_markbad(master, mtd_get_master_ofs(mtd, ofs));
+	mtd_end_access(master);
+
 	if (ret)
 		return ret;
 
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 88227044fc86..b074106e2d8e 100644
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
@@ -476,10 +478,47 @@ static inline u32 mtd_oobavail(struct mtd_info *mtd, struct mtd_oob_ops *ops)
 	return ops->mode == MTD_OPS_AUTO_OOB ? mtd->oobavail : mtd->oobsize;
 }
 
+static inline void mtd_start_access(struct mtd_info *master)
+{
+	WARN_ON_ONCE(master != mtd_get_master(master));
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
+		wait_event(master->master.resume_wq, !master->master.suspended);
+	}
+}
+
+static inline void mtd_end_access(struct mtd_info *master)
+{
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
@@ -487,8 +526,12 @@ static inline int mtd_max_bad_blocks(struct mtd_info *mtd,
 	if (mtd->size < (len + ofs) || ofs < 0)
 		return -EINVAL;
 
-	return master->_max_bad_blocks(master, mtd_get_master_ofs(mtd, ofs),
-				       len);
+	mtd_start_access(master);
+	ret = master->_max_bad_blocks(master, mtd_get_master_ofs(mtd, ofs),
+				      len);
+	mtd_end_access(master);
+
+	return ret;
 }
 
 int mtd_wunit_to_pairing_info(struct mtd_info *mtd, int wunit,
@@ -546,30 +589,40 @@ int mtd_block_markbad(struct mtd_info *mtd, loff_t ofs);
 static inline int mtd_suspend(struct mtd_info *mtd)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
-	int ret;
-
-	if (master->master.suspended)
-		return 0;
+	int ret = 0;
 
-	ret = master->_suspend ? master->_suspend(master) : 0;
-	if (ret)
+	if (!master->_suspend)
 		return ret;
 
-	master->master.suspended = 1;
-	return 0;
+	down_write(&master->master.suspend_lock);
+	if (!master->master.suspended) {
+		ret = master->_suspend(master);
+		if (!ret)
+			master->master.suspended = 1;
+	}
+	up_write(&master->master.suspend_lock);
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
+	down_write(&master->master.suspend_lock);
+	if (master->master.suspended) {
+		if (master->_resume)
+			master->_resume(master);
+
+		master->master.suspended = 0;
 
-	master->master.suspended = 0;
+		/* The MTD dev has been resumed, wake up all waiters. */
+		wake_up_all(&master->master.resume_wq);
+	}
+	up_write(&master->master.suspend_lock);
 }
 
 static inline uint32_t mtd_div_by_eb(uint64_t sz, struct mtd_info *mtd)
-- 
2.33.0

