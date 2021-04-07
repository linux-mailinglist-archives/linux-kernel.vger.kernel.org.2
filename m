Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC07E3564C5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 09:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349354AbhDGHJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 03:09:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15148 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349324AbhDGHJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 03:09:49 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FFb6g4vgQzpVwt;
        Wed,  7 Apr 2021 15:06:51 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Wed, 7 Apr 2021 15:09:27 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH v3 05/10] tty: tty_jobctrl: Remove spaces before tabs
Date:   Wed, 7 Apr 2021 15:06:45 +0800
Message-ID: <1617779210-51576-6-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617779210-51576-1-git-send-email-tanxiaofei@huawei.com>
References: <1617779210-51576-1-git-send-email-tanxiaofei@huawei.com>
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
index 5b4ab16..72df97b 100644
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

