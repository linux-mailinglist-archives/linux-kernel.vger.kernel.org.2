Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D668C37B932
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhELJbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:31:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2641 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhELJao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:30:44 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fg8Zh5tbMzldX7;
        Wed, 12 May 2021 17:27:24 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 17:29:27 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH 13/17] tty: tty_io: Delete a blank line before EXPORT_SYMBOL(foo)
Date:   Wed, 12 May 2021 17:26:21 +0800
Message-ID: <1620811585-18582-14-git-send-email-tanxiaofei@huawei.com>
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

Delete a blank line before EXPORT_SYMBOL(foo) so that EXPORT_SYMBOL(foo)
immediately follow its function/variable, reported by checkpatch.pl.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/tty/tty_io.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 6e65726..ce07aca 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -131,7 +131,6 @@ struct ktermios tty_std_termios = {	/* for the benefit of tty drivers  */
 	.c_ospeed = 38400,
 	/* .c_line = N_TTY, */
 };
-
 EXPORT_SYMBOL(tty_std_termios);
 
 /* This list gets poked at by procfs and various bits of boot up code. This
@@ -249,7 +248,6 @@ const char *tty_name(const struct tty_struct *tty)
 		return "NULL tty";
 	return tty->name;
 }
-
 EXPORT_SYMBOL(tty_name);
 
 const char *tty_driver_name(const struct tty_struct *tty)
@@ -539,7 +537,6 @@ void tty_wakeup(struct tty_struct *tty)
 	}
 	wake_up_interruptible_poll(&tty->write_wait, EPOLLOUT);
 }
-
 EXPORT_SYMBOL_GPL(tty_wakeup);
 
 /**
@@ -697,7 +694,6 @@ void tty_hangup(struct tty_struct *tty)
 	tty_debug_hangup(tty, "hangup\n");
 	schedule_work(&tty->hangup_work);
 }
-
 EXPORT_SYMBOL(tty_hangup);
 
 /**
@@ -714,7 +710,6 @@ void tty_vhangup(struct tty_struct *tty)
 	tty_debug_hangup(tty, "vhangup\n");
 	__tty_hangup(tty, 0);
 }
-
 EXPORT_SYMBOL(tty_vhangup);
 
 
@@ -764,7 +759,6 @@ int tty_hung_up_p(struct file *filp)
 {
 	return (filp && filp->f_op == &hung_up_tty_fops);
 }
-
 EXPORT_SYMBOL(tty_hung_up_p);
 
 /**
@@ -3110,7 +3104,6 @@ void do_SAK(struct tty_struct *tty)
 		return;
 	schedule_work(&tty->SAK_work);
 }
-
 EXPORT_SYMBOL(do_SAK);
 
 /* Must put_device() after it's unused! */
-- 
2.8.1

