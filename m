Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4174353B16
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 05:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhDEDhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 23:37:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15908 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbhDEDhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 23:37:11 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FDGWT6Wwvzkhb1;
        Mon,  5 Apr 2021 11:35:17 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Mon, 5 Apr 2021 11:36:57 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH 04/10] tty: tty_jobctrl: Fix coding style issues of block comments
Date:   Mon, 5 Apr 2021 11:34:16 +0800
Message-ID: <1617593662-25900-5-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617593662-25900-1-git-send-email-tanxiaofei@huawei.com>
References: <1617593662-25900-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coding style issues of block comments, reported by checkpatch.pl.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/tty/tty_jobctrl.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index 86070f7..4d78422 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -204,8 +204,10 @@ int tty_signal_session_leader(struct tty_struct *tty, int exit_session)
 			spin_lock_irq(&p->sighand->siglock);
 			if (p->signal->tty == tty) {
 				p->signal->tty = NULL;
-				/* We defer the dereferences outside fo
-				   the tasklist lock */
+				/*
+				 * We defer the dereferences outside fo
+				 * the tasklist lock
+				 */
 				refs++;
 			}
 			if (!p->signal->leader) {
@@ -328,9 +330,11 @@ void disassociate_ctty(int on_exit)
  */
 void no_tty(void)
 {
-	/* FIXME: Review locking here. The tty_lock never covered any race
-	   between a new association and proc_clear_tty but possible we need
-	   to protect against this anyway */
+	/*
+	 * FIXME: Review locking here. The tty_lock never covered any race
+	 * between a new association and proc_clear_tty but possible we need
+	 * to protect against this anyway
+	 */
 	struct task_struct *tsk = current;
 
 	disassociate_ctty(0);
@@ -536,7 +540,7 @@ static int tiocgsid(struct tty_struct *tty, struct tty_struct *real_tty, pid_t _
 	/*
 	 * (tty == real_tty) is a cheap way of
 	 * testing if the tty is NOT a master pty.
-	*/
+	 */
 	if (tty == real_tty && current->signal->tty != real_tty)
 		return -ENOTTY;
 
-- 
2.8.1

