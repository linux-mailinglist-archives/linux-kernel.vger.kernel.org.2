Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060D9353B14
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 05:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhDEDhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 23:37:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15907 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbhDEDhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 23:37:10 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FDGWT6n8Gzkhb9;
        Mon,  5 Apr 2021 11:35:17 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Mon, 5 Apr 2021 11:36:56 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH 03/10] tty: tty_jobctrl: Add a blank line after declarations
Date:   Mon, 5 Apr 2021 11:34:15 +0800
Message-ID: <1617593662-25900-4-git-send-email-tanxiaofei@huawei.com>
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

Add a blank line after declarations, reported by checkpatch.pl.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/tty/tty_jobctrl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index 4b751b9..86070f7 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -75,6 +75,7 @@ void proc_clear_tty(struct task_struct *p)
 {
 	unsigned long flags;
 	struct tty_struct *tty;
+
 	spin_lock_irqsave(&p->sighand->siglock, flags);
 	tty = p->signal->tty;
 	p->signal->tty = NULL;
@@ -173,6 +174,7 @@ EXPORT_SYMBOL_GPL(get_current_tty);
 void session_clear_tty(struct pid *session)
 {
 	struct task_struct *p;
+
 	do_each_pid_task(session, PIDTYPE_SID, p) {
 		proc_clear_tty(p);
 	} while_each_pid_task(session, PIDTYPE_SID, p);
@@ -269,6 +271,7 @@ void disassociate_ctty(int on_exit)
 			tty_vhangup_session(tty);
 		} else {
 			struct pid *tty_pgrp = tty_get_pgrp(tty);
+
 			if (tty_pgrp) {
 				kill_pgrp(tty_pgrp, SIGHUP, on_exit);
 				if (!on_exit)
@@ -280,6 +283,7 @@ void disassociate_ctty(int on_exit)
 
 	} else if (on_exit) {
 		struct pid *old_pgrp;
+
 		spin_lock_irq(&current->sighand->siglock);
 		old_pgrp = current->signal->tty_old_pgrp;
 		current->signal->tty_old_pgrp = NULL;
@@ -328,6 +332,7 @@ void no_tty(void)
 	   between a new association and proc_clear_tty but possible we need
 	   to protect against this anyway */
 	struct task_struct *tsk = current;
+
 	disassociate_ctty(0);
 	proc_clear_tty(tsk);
 }
-- 
2.8.1

