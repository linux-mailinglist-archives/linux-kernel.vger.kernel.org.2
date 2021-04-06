Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFD0355214
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245579AbhDFL2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:28:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16355 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245511AbhDFL1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:27:44 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FF4vP6x4rz9405;
        Tue,  6 Apr 2021 19:25:21 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 19:27:25 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH v2 08/10] tty: tty_ldisc: Fix coding style issues of block comments
Date:   Tue, 6 Apr 2021 19:24:46 +0800
Message-ID: <1617708288-14847-9-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617708288-14847-1-git-send-email-tanxiaofei@huawei.com>
References: <1617708288-14847-1-git-send-email-tanxiaofei@huawei.com>
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
 drivers/tty/tty_ldisc.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index df0b589..874d238 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -529,9 +529,11 @@ static void tty_ldisc_restore(struct tty_struct *tty, struct tty_ldisc *old)
 		const char *name = tty_name(tty);
 
 		pr_warn("Falling back ldisc for %s.\n", name);
-		/* The traditional behaviour is to fall back to N_TTY, we
-		   want to avoid falling back to N_NULL unless we have no
-		   choice to avoid the risk of breaking anything */
+		/*
+		 * The traditional behaviour is to fall back to N_TTY, we
+		 * want to avoid falling back to N_NULL unless we have no
+		 * choice to avoid the risk of breaking anything
+		 */
 		if (tty_ldisc_failto(tty, N_TTY) < 0 &&
 		    tty_ldisc_failto(tty, N_NULL) < 0)
 			panic("Couldn't open N_NULL ldisc for %s.", name);
@@ -600,17 +602,21 @@ int tty_set_ldisc(struct tty_struct *tty, int disc)
 		up_read(&tty->termios_rwsem);
 	}
 
-	/* At this point we hold a reference to the new ldisc and a
-	   reference to the old ldisc, or we hold two references to
-	   the old ldisc (if it was restored as part of error cleanup
-	   above). In either case, releasing a single reference from
-	   the old ldisc is correct. */
+	/*
+	 * At this point we hold a reference to the new ldisc and a
+	 * reference to the old ldisc, or we hold two references to
+	 * the old ldisc (if it was restored as part of error cleanup
+	 * above). In either case, releasing a single reference from
+	 * the old ldisc is correct.
+	 */
 	new_ldisc = old_ldisc;
 out:
 	tty_ldisc_unlock(tty);
 
-	/* Restart the work queue in case no characters kick it off. Safe if
-	   already running */
+	/*
+	 * Restart the work queue in case no characters kick it off. Safe if
+	 * already running
+	 */
 	tty_buffer_restart_work(tty->port);
 err:
 	tty_ldisc_put(new_ldisc);	/* drop the extra reference */
@@ -812,8 +818,10 @@ void tty_ldisc_release(struct tty_struct *tty)
 		tty_ldisc_kill(o_tty);
 	tty_ldisc_unlock_pair(tty, o_tty);
 
-	/* And the memory resources remaining (buffers, termios) will be
-	   disposed of when the kref hits zero */
+	/*
+	 * And the memory resources remaining (buffers, termios) will be
+	 * disposed of when the kref hits zero
+	 */
 
 	tty_ldisc_debug(tty, "released\n");
 }
-- 
2.8.1

