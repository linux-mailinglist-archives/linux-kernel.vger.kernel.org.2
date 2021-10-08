Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CF0426CD6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242406AbhJHOkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:40:52 -0400
Received: from first.geanix.com ([116.203.34.67]:37350 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229756AbhJHOkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:40:49 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id A046CC3B5C;
        Fri,  8 Oct 2021 14:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1633703931; bh=c1SgJ9T6g8A+11+EuJzpHcBIGdJS0HhtpmvKb6agfcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=D1dC5wY3Uj3FTyXO+CXAFip2Knr+6pqvJdvXq1AayN7nXZK6ExL0QuFI+57uSf9Qk
         3vMYSQa0lFvcN9e3wP/dq+YZUrF42i2JIifY8g1kKPjXuHvoyT3/svqoTx1c+ny0Nu
         SRyhEwT5E82SSJmfbYC9eV728pwpYCnViwZhAh9zzJfeus09lMTM/BGOqGsgNtkX+5
         /bluvwsYb9TsjZzYJtX8yP3IDw7hsIbWudnlVXF6eQUh1vtPDHtjNTc6Srdg1FKSi4
         5ohB/7RhMbTXZKV2CtDosztH7q27mrExFRw6FWI9X/Kxja8Gy3mUb71ab0qnYst/qw
         YLFCVeZUR9ocA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Sean Nyekjaer <sean@geanix.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] mtd: core: protect access to mtd devices while in suspend
Date:   Fri,  8 Oct 2021 16:38:24 +0200
Message-Id: <20211008143825.3717116-1-sean@geanix.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211008141524.20ca8219@collabora.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will prevent reading/writing/erasing to a suspended mtd device.
It will force mtd_write()/mtd_read()/mtd_erase() to wait for
mtd_resume() to unlock access to mtd devices.

Exec_op[0] speed things up, so we see this race when rawnand devices going
into suspend. But it's actually "mtd: rawnand: Simplify the locking" that
allows it to return errors rather than locking, before that commit it would
have waited for the rawnand device to resume.

Tested on a iMX6ULL.

[0]:
ef347c0cfd61 ("mtd: rawnand: gpmi: Implement exec_op")

Fixes: 013e6292aaf5 ("mtd: rawnand: Simplify the locking")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---

Hope I got it all :)

 drivers/mtd/mtdcore.c   | 57 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/mtd/mtd.h | 36 ++++++++++++++++++--------
 2 files changed, 81 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index c8fd7f758938..3c93202e6cbb 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -36,6 +36,44 @@
 
 struct backing_dev_info *mtd_bdi;
 
+static void mtd_start_access(struct mtd_info *mtd)
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
+static void mtd_end_access(struct mtd_info *mtd)
+{
+	struct mtd_info *master = mtd_get_master(mtd);
+
+	if (!master->_suspend)
+		return;
+
+	up_read(&master->master.suspend_lock);
+}
+
 #ifdef CONFIG_PM_SLEEP
 
 static int mtd_cls_suspend(struct device *dev)
@@ -1000,6 +1038,9 @@ int mtd_device_parse_register(struct mtd_info *mtd, const char * const *types,
 
 	ret = mtd_otp_nvmem_add(mtd);
 
+	init_waitqueue_head(&mtd->master.resume_wq);
+	init_rwsem(&mtd->master.suspend_lock);
+
 out:
 	if (ret && device_is_registered(&mtd->dev))
 		del_mtd_device(mtd);
@@ -1241,6 +1282,8 @@ int mtd_erase(struct mtd_info *mtd, struct erase_info *instr)
 	struct erase_info adjinstr;
 	int ret;
 
+	mtd_start_access(mtd);
+
 	instr->fail_addr = MTD_FAIL_ADDR_UNKNOWN;
 	adjinstr = *instr;
 
@@ -1278,6 +1321,8 @@ int mtd_erase(struct mtd_info *mtd, struct erase_info *instr)
 		}
 	}
 
+	mtd_end_access(mtd);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(mtd_erase);
@@ -1558,6 +1603,8 @@ int mtd_read_oob(struct mtd_info *mtd, loff_t from, struct mtd_oob_ops *ops)
 	struct mtd_ecc_stats old_stats = master->ecc_stats;
 	int ret_code;
 
+	mtd_start_access(mtd);
+
 	ops->retlen = ops->oobretlen = 0;
 
 	ret_code = mtd_check_oob_ops(mtd, from, ops);
@@ -1577,6 +1624,8 @@ int mtd_read_oob(struct mtd_info *mtd, loff_t from, struct mtd_oob_ops *ops)
 
 	mtd_update_ecc_stats(mtd, master, &old_stats);
 
+	mtd_end_access(mtd);
+
 	/*
 	 * In cases where ops->datbuf != NULL, mtd->_read_oob() has semantics
 	 * similar to mtd->_read(), returning a non-negative integer
@@ -1597,6 +1646,8 @@ int mtd_write_oob(struct mtd_info *mtd, loff_t to,
 	struct mtd_info *master = mtd_get_master(mtd);
 	int ret;
 
+	mtd_start_access(mtd);
+
 	ops->retlen = ops->oobretlen = 0;
 
 	if (!(mtd->flags & MTD_WRITEABLE))
@@ -1615,7 +1666,11 @@ int mtd_write_oob(struct mtd_info *mtd, loff_t to,
 	if (mtd->flags & MTD_SLC_ON_MLC_EMULATION)
 		return mtd_io_emulated_slc(mtd, to, false, ops);
 
-	return mtd_write_oob_std(mtd, to, ops);
+	ret = mtd_write_oob_std(mtd, to, ops);
+
+	mtd_end_access(mtd);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mtd_write_oob);
 
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 88227044fc86..cfab07b02dc9 100644
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
@@ -546,30 +548,42 @@ int mtd_block_markbad(struct mtd_info *mtd, loff_t ofs);
 static inline int mtd_suspend(struct mtd_info *mtd)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
-	int ret;
+	int ret = 0;
 
-	if (master->master.suspended)
-		return 0;
 
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
 
-	master->master.suspended = 0;
+	down_write(&master->master.suspend_lock);
+	if (master->master.suspended) {
+		if (master->_resume)
+			master->_resume(master);
+
+		master->master.suspended = 0;
+
+		/* The MTD dev has been resumed, wake up all waiters. */
+		wake_up_all(&master->master.resume_wq);
+	}
+	up_write(&master->master.suspend_lock);
 }
 
 static inline uint32_t mtd_div_by_eb(uint64_t sz, struct mtd_info *mtd)
-- 
2.33.0

