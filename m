Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE22353B19
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 05:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhDEDh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 23:37:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15538 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbhDEDhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 23:37:15 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FDGVS2hK2zPnlv;
        Mon,  5 Apr 2021 11:34:24 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Mon, 5 Apr 2021 11:36:57 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH 05/10] tty: tty_jobctrl: Remove spaces before tabs
Date:   Mon, 5 Apr 2021 11:34:17 +0800
Message-ID: <1617593662-25900-6-git-send-email-tanxiaofei@huawei.com>
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

Remove spaces before tabs following the advice of checkpatch.pl.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/tty/tty_jobctrl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index 4d78422..2f7d4ba 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -244,10 +244,10 @@ int tty_signal_session_leader(struct tty_struct *tty, int exit_session)
  *	it wants to disassociate itself from its controlling tty.
  *
  *	It performs the following functions:
- * 	(1)  Sends a SIGHUP and SIGCONT to the foreground process group
- * 	(2)  Clears the tty from being controlling the session
- * 	(3)  Clears the controlling tty for all processes in the
- * 		session group.
+ *	(1)  Sends a SIGHUP and SIGCONT to the foreground process group
+ *	(2)  Clears the tty from being controlling the session
+ *	(3)  Clears the controlling tty for all processes in the
+ *		session group.
  *
  *	The argument on_exit is set to 1 if called when a process is
  *	exiting; it is 0 if called by the ioctl TIOCNOTTY.
-- 
2.8.1

