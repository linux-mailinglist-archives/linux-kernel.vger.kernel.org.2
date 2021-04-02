Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2421835276F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 10:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhDBI3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 04:29:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15530 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhDBI3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 04:29:15 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FBY6w3qzMzNsGg;
        Fri,  2 Apr 2021 16:26:32 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Fri, 2 Apr 2021 16:29:07 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH] tty: pty: Add a blank line after declarations
Date:   Fri, 2 Apr 2021 16:26:30 +0800
Message-ID: <1617351990-5189-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
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
 drivers/tty/pty.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 5e23745..106265a 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -159,6 +159,7 @@ static int pty_chars_in_buffer(struct tty_struct *tty)
 static int pty_set_lock(struct tty_struct *tty, int __user *arg)
 {
 	int val;
+
 	if (get_user(val, arg))
 		return -EFAULT;
 	if (val)
@@ -171,6 +172,7 @@ static int pty_set_lock(struct tty_struct *tty, int __user *arg)
 static int pty_get_lock(struct tty_struct *tty, int __user *arg)
 {
 	int locked = test_bit(TTY_PTY_LOCK, &tty->flags);
+
 	return put_user(locked, arg);
 }
 
@@ -200,6 +202,7 @@ static int pty_set_pktmode(struct tty_struct *tty, int __user *arg)
 static int pty_get_pktmode(struct tty_struct *tty, int __user *arg)
 {
 	int pktmode = tty->packet;
+
 	return put_user(pktmode, arg);
 }
 
@@ -463,6 +466,7 @@ static int pty_install(struct tty_driver *driver, struct tty_struct *tty)
 static void pty_remove(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct tty_struct *pair = tty->link;
+
 	driver->ttys[tty->index] = NULL;
 	if (pair)
 		pair->driver->ttys[pair->index] = NULL;
-- 
2.8.1

