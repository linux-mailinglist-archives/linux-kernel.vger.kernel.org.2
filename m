Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E78375082
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 10:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbhEFIBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 04:01:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17471 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbhEFIBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 04:01:24 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FbQt61WgMzkWpZ;
        Thu,  6 May 2021 15:57:50 +0800 (CST)
Received: from huawei.com (10.69.192.56) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Thu, 6 May 2021
 16:00:18 +0800
From:   Luo Jiaxing <luojiaxing@huawei.com>
To:     <pmladek@suse.com>, <sergey.senozhatsky@gmail.com>,
        <rostedt@goodmis.org>, <john.ogness@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <luojiaxing@huawei.com>, <bobo.shaobowang@huawei.com>
Subject: [PATCH] printk: stop spining waiter when console resume to flush prb
Date:   Thu, 6 May 2021 16:00:26 +0800
Message-ID: <1620288026-5373-1-git-send-email-luojiaxing@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some threads still call printk() for printing when resume_console() is
being executed. In practice, the printk() is executed for a period of time
and then returned. The duration is determined by the number of prints
cached in the prb during the suspend/resume process. At the same time,
resume_console() returns quickly.

Base on owner/waiter machanism, the frist one who fail to lock console will
become waiter, and start spining. When current owner finish print one
informance, if a waiter is waitting, owner will give up and let waiter
become a new owner. New owner need to flush the whole prb unitl prb empty
or another new waiter come and take the job from him.

So the first waiter after resume_console() will take seconds to help to
flush prb, but driver which call printk() may be bothered by this. New
a flag to mark resume flushing prb. When the console resume, before the
prb is empty, stop to set a new waiter temporarily.

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
---
 kernel/printk/printk.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 575a34b..2c680a5 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -287,6 +287,9 @@ EXPORT_SYMBOL(console_set_on_cmdline);
 /* Flag: console code may call schedule() */
 static int console_may_schedule;
 
+/* Flags: console flushing prb when resume */
+static atomic_t console_resume_flush_prb = ATOMIC_INIT(0);
+
 enum con_msg_format_flags {
 	MSG_FORMAT_DEFAULT	= 0,
 	MSG_FORMAT_SYSLOG	= (1 << 0),
@@ -1781,7 +1784,8 @@ static int console_trylock_spinning(void)
 	raw_spin_lock(&console_owner_lock);
 	owner = READ_ONCE(console_owner);
 	waiter = READ_ONCE(console_waiter);
-	if (!waiter && owner && owner != current) {
+	if (!waiter && owner && owner != current &&
+	    !atomic_read(&console_resume_flush_prb)) {
 		WRITE_ONCE(console_waiter, true);
 		spin = true;
 	}
@@ -2355,6 +2359,7 @@ void resume_console(void)
 	if (!console_suspend_enabled)
 		return;
 	down_console_sem();
+	atomic_set(&console_resume_flush_prb, 1);
 	console_suspended = 0;
 	console_unlock();
 }
@@ -2592,6 +2597,8 @@ void console_unlock(void)
 	raw_spin_unlock(&logbuf_lock);
 
 	up_console_sem();
+	if (atomic_read(&console_resume_flush_prb))
+		atomic_set(&console_resume_flush_prb, 0);
 
 	/*
 	 * Someone could have filled up the buffer again, so re-check if there's
-- 
2.7.4

