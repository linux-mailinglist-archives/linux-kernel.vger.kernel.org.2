Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B17037B92F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhELJa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:30:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2462 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhELJan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:30:43 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fg8Z225PlzBtTL;
        Wed, 12 May 2021 17:26:50 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 17:29:25 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH 06/17] tty: tty_io: Remove spaces before tabs
Date:   Wed, 12 May 2021 17:26:14 +0800
Message-ID: <1620811585-18582-7-git-send-email-tanxiaofei@huawei.com>
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

Remove spaces before tabs following the advice of checkpatch.pl.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/tty/tty_io.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 5b5e996..c5b0e49 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -33,7 +33,7 @@
  *	-- Nick Holloway <alfie@dcs.warwick.ac.uk>, 27th May 1993.
  *
  * Rewrote canonical mode and added more termios flags.
- * 	-- julian@uhunix.uhcc.hawaii.edu (J. Cowley), 13Jan94
+ *	-- julian@uhunix.uhcc.hawaii.edu (J. Cowley), 13Jan94
  *
  * Reorganized FASYNC support so mouse code can share it.
  *	-- ctm@ardi.com, 9Sep95
@@ -1114,7 +1114,7 @@ void tty_write_message(struct tty_struct *tty, char *msg)
 static ssize_t file_tty_write(struct file *file, struct kiocb *iocb, struct iov_iter *from)
 {
 	struct tty_struct *tty = file_tty(file);
- 	struct tty_ldisc *ld;
+	struct tty_ldisc *ld;
 	ssize_t ret;
 
 	if (tty_paranoia_check(tty, file_inode(file), "tty_write"))
@@ -1928,8 +1928,8 @@ static struct tty_struct *tty_open_current_tty(dev_t device, struct file *filp)
  *	@index: index for the device in the @return driver
  *	@return: driver for this inode (with increased refcount)
  *
- * 	If @return is not erroneous, the caller is responsible to decrement the
- * 	refcount by tty_driver_kref_put.
+ *	If @return is not erroneous, the caller is responsible to decrement the
+ *	refcount by tty_driver_kref_put.
  *
  *	Locking: tty_mutex protects get_tty_driver
  */
@@ -3317,11 +3317,11 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
 EXPORT_SYMBOL_GPL(tty_register_device_attr);
 
 /**
- * 	tty_unregister_device - unregister a tty device
- * 	@driver: the tty driver that describes the tty device
- * 	@index: the index in the tty driver for this tty device
+ *	tty_unregister_device - unregister a tty device
+ *	@driver: the tty driver that describes the tty device
+ *	@index: the index in the tty driver for this tty device
  *
- * 	If a tty device is registered with a call to tty_register_device() then
+ *	If a tty device is registered with a call to tty_register_device() then
  *	this function must be called when the tty device is gone.
  *
  *	Locking: ??
-- 
2.8.1

