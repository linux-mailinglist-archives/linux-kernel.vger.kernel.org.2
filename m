Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB9037B933
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhELJbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:31:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2645 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhELJao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:30:44 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fg8Zh6mDfzldZT;
        Wed, 12 May 2021 17:27:24 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 17:29:25 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH 07/17] tty: tty_io: Add a blank line after declarations
Date:   Wed, 12 May 2021 17:26:15 +0800
Message-ID: <1620811585-18582-8-git-send-email-tanxiaofei@huawei.com>
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

Add a blank line after declarations, reported by checkpatch.pl.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/tty/tty_io.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index c5b0e49..8b9430c 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -320,6 +320,7 @@ static struct tty_driver *get_tty_driver(dev_t device, int *index)
 
 	list_for_each_entry(p, &tty_drivers, tty_drivers) {
 		dev_t base = MKDEV(p->major, p->minor_start);
+
 		if (device < base || device >= base + p->num)
 			continue;
 		*index = device - base;
@@ -1033,6 +1034,7 @@ static inline ssize_t do_tty_write(
 	/* Do the write .. */
 	for (;;) {
 		size_t size = count;
+
 		if (size > chunk)
 			size = chunk;
 
@@ -1155,6 +1157,7 @@ ssize_t redirected_tty_write(struct kiocb *iocb, struct iov_iter *iter)
 	 */
 	if (p) {
 		ssize_t res;
+
 		res = file_tty_write(p, iocb, iter);
 		fput(p);
 		return res;
@@ -1942,6 +1945,7 @@ static struct tty_driver *tty_lookup_driver(dev_t device, struct file *filp,
 #ifdef CONFIG_VT
 	case MKDEV(TTY_MAJOR, 0): {
 		extern struct tty_driver *console_driver;
+
 		driver = tty_driver_kref_get(console_driver);
 		*index = fg_console;
 		break;
@@ -1949,6 +1953,7 @@ static struct tty_driver *tty_lookup_driver(dev_t device, struct file *filp,
 #endif
 	case MKDEV(TTYAUX_MAJOR, 1): {
 		struct tty_driver *console_driver = console_device(index);
+
 		if (console_driver) {
 			driver = tty_driver_kref_get(console_driver);
 			if (driver && filp) {
@@ -2388,6 +2393,7 @@ EXPORT_SYMBOL(tty_do_resize);
 static int tiocswinsz(struct tty_struct *tty, struct winsize __user *arg)
 {
 	struct winsize tmp_ws;
+
 	if (copy_from_user(&tmp_ws, arg, sizeof(*arg)))
 		return -EFAULT;
 
@@ -2412,6 +2418,7 @@ static int tioccons(struct file *file)
 		return -EPERM;
 	if (file->f_op->write_iter == redirected_tty_write) {
 		struct file *f;
+
 		spin_lock(&redirect_lock);
 		f = redirect;
 		redirect = NULL;
@@ -2734,6 +2741,7 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case TIOCGEXCL:
 	{
 		int excl = test_bit(TTY_EXCLUSIVE, &tty->flags);
+
 		return put_user(excl, (int __user *)p);
 	}
 	case TIOCGETD:
@@ -2748,6 +2756,7 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case TIOCGDEV:
 	{
 		unsigned int ret = new_encode_dev(tty_devnum(real_tty));
+
 		return put_user(ret, (unsigned int __user *)p);
 	}
 	/*
@@ -3103,6 +3112,7 @@ EXPORT_SYMBOL(do_SAK);
 static struct device *tty_get_device(struct tty_struct *tty)
 {
 	dev_t devt = tty_devnum(tty);
+
 	return class_find_device_by_devt(tty_class, devt);
 }
 
-- 
2.8.1

