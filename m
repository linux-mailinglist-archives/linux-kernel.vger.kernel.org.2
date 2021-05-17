Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE90038248A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 08:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbhEQGmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 02:42:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3705 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbhEQGlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 02:41:53 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fk8Zf758Yz16R37;
        Mon, 17 May 2021 14:37:46 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 14:40:31 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 14:40:30 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linuxarm@openeuler.org>, Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH 6/9] tty: hvc_console: Fix coding style issues of block comments
Date:   Mon, 17 May 2021 14:37:10 +0800
Message-ID: <1621233433-27094-7-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1621233433-27094-1-git-send-email-tanxiaofei@huawei.com>
References: <1621233433-27094-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coding style issues of block comments, reported by checkpatch.pl.
Besides, add a period at the end of the sentenses.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/tty/hvc/hvc_console.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 39018e5..a61cdf0 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -177,7 +177,8 @@ static void hvc_console_print(struct console *co, const char *b,
 			r = cons_ops[index]->put_chars(vtermnos[index], c, i);
 			if (r <= 0) {
 				/* throw away characters on error
-				 * but spin in case of -EAGAIN */
+				 * but spin in case of -EAGAIN.
+				 */
 				if (r != -EAGAIN) {
 					i = 0;
 				} else {
@@ -484,7 +485,8 @@ static int hvc_push(struct hvc_struct *hp)
 			return 0;
 		}
 		/* throw away output on error; this happens when
-		   there is no session connected to the vterm. */
+		 *  there is no session connected to the vterm.
+		 */
 		hp->n_outbuf = 0;
 	} else
 		hp->n_outbuf -= n;
@@ -707,7 +709,8 @@ static int __hvc_poll(struct hvc_struct *hp, bool may_sleep)
 			/* XXX should support a sequence */
 			if (buf[i] == '\x0f') {	/* ^O */
 				/* if ^O is pressed again, reset
-				 * sysrq_pressed and flip ^O char */
+				 * sysrq_pressed and flip ^O char.
+				 */
 				sysrq_pressed = !sysrq_pressed;
 				if (sysrq_pressed)
 					continue;
@@ -749,7 +752,8 @@ static int __hvc_poll(struct hvc_struct *hp, bool may_sleep)
 
 	if (read_total) {
 		/* Activity is occurring, so reset the polling backoff value to
-		   a minimum for performance. */
+		 * a minimum for performance.
+		 */
 		timeout = MIN_TIMEOUT;
 
 		tty_flip_buffer_push(&hp->port);
@@ -1037,7 +1041,8 @@ static int hvc_init(void)
 	tty_set_operations(drv, &hvc_ops);
 
 	/* Always start the kthread because there can be hotplug vty adapters
-	 * added later. */
+	 * added later.
+	 */
 	hvc_task = kthread_run(khvcd, NULL, "khvcd");
 	if (IS_ERR(hvc_task)) {
 		printk(KERN_ERR "Couldn't create kthread for console.\n");
-- 
2.8.1

