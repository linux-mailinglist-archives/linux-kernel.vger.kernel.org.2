Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D495637B93F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhELJbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:31:37 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2650 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhELJaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:30:46 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fg8Zj0npDzldWd;
        Wed, 12 May 2021 17:27:25 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 17:29:26 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH 10/17] tty: tty_io: Fix coding style issues of block comments
Date:   Wed, 12 May 2021 17:26:18 +0800
Message-ID: <1620811585-18582-11-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1620811585-18582-1-git-send-email-tanxiaofei@huawei.com>
References: <1620811585-18582-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coding style issues of block comments, reported by checkpatch.pl.
Besides, add a period at the end of the sentenses.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/tty/tty_io.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 5ad2b73..72f90ef 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -135,8 +135,9 @@ struct ktermios tty_std_termios = {	/* for the benefit of tty drivers  */
 EXPORT_SYMBOL(tty_std_termios);
 
 /* This list gets poked at by procfs and various bits of boot up code. This
-   could do with some rationalisation such as pulling the tty proc function
-   into this file */
+ * could do with some rationalisation such as pulling the tty proc function
+ * into this file.
+ */
 
 LIST_HEAD(tty_drivers);			/* linked list of tty drivers */
 
@@ -614,8 +615,9 @@ static void __tty_hangup(struct tty_struct *tty, int exit_session)
 	set_bit(TTY_HUPPING, &tty->flags);
 
 	/* inuse_filps is protected by the single tty lock,
-	   this really needs to change if we want to flush the
-	   workqueue with the lock held */
+	 * this really needs to change if we want to flush the
+	 * workqueue with the lock held.
+	 */
 	check_tty_count(tty, "tty_hangup");
 
 	spin_lock(&tty->files_lock);
@@ -942,7 +944,8 @@ static ssize_t tty_read(struct kiocb *iocb, struct iov_iter *to)
 		return -EIO;
 
 	/* We want to wait for the line discipline to sort out in this
-	   situation */
+	 * situation.
+	 */
 	ld = tty_ldisc_ref_wait(tty);
 	if (!ld)
 		return hung_up_tty_read(iocb, to);
@@ -1572,7 +1575,8 @@ static void queue_release_one_tty(struct kref *kref)
 	struct tty_struct *tty = container_of(kref, struct tty_struct, kref);
 
 	/* The hangup queue is now free so we can reuse it rather than
-	   waste a chunk of memory for each port */
+	 *  waste a chunk of memory for each port.
+	 */
 	INIT_WORK(&tty->hangup_work, release_one_tty);
 	schedule_work(&tty->hangup_work);
 }
@@ -1877,7 +1881,8 @@ int tty_release(struct inode *inode, struct file *filp)
 	tty_unlock(tty);
 
 	/* At this point, the tty->count == 0 should ensure a dead tty
-	   cannot be re-opened by a racing opener */
+	 * cannot be re-opened by a racing opener.
+	 */
 
 	if (!final)
 		return 0;
-- 
2.8.1

