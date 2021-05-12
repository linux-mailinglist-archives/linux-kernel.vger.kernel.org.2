Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFF337B931
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhELJbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:31:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2642 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhELJao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:30:44 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fg8Zh65bJzldXR;
        Wed, 12 May 2021 17:27:24 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 17:29:29 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH 17/17] tty: tty_port: Fix coding style issues of block comments
Date:   Wed, 12 May 2021 17:26:25 +0800
Message-ID: <1620811585-18582-18-git-send-email-tanxiaofei@huawei.com>
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

Fix coding style issues of block comments, reported by checkpatch.pl.
Besides, add a period at the end of the sentenses.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/tty/tty_port.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 4047954..36d49ac 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -468,7 +468,8 @@ int tty_port_block_til_ready(struct tty_port *port,
 	DEFINE_WAIT(wait);
 
 	/* if non-blocking mode is set we can pass directly to open unless
-	   the port has just hung up or is in another error state */
+	 * the port has just hung up or is in another error state.
+	 */
 	if (tty_io_error(tty)) {
 		tty_port_set_active(port, 1);
 		return 0;
@@ -485,8 +486,9 @@ int tty_port_block_til_ready(struct tty_port *port,
 		do_clocal = 1;
 
 	/* Block waiting until we can proceed. We may need to wait for the
-	   carrier, but we must also wait for any close that is in progress
-	   before the next open may complete */
+	 * carrier, but we must also wait for any close that is in progress
+	 * before the next open may complete.
+	 */
 
 	retval = 0;
 
@@ -503,7 +505,8 @@ int tty_port_block_til_ready(struct tty_port *port,
 
 		prepare_to_wait(&port->open_wait, &wait, TASK_INTERRUPTIBLE);
 		/* Check for a hangup or uninitialised port.
-							Return accordingly */
+		 * Return accordingly.
+		 */
 		if (tty_hung_up_p(filp) || !tty_port_initialized(port)) {
 			if (port->flags & ASYNC_HUP_NOTIFY)
 				retval = -EAGAIN;
@@ -530,7 +533,8 @@ int tty_port_block_til_ready(struct tty_port *port,
 	finish_wait(&port->open_wait, &wait);
 
 	/* Update counts. A parallel hangup will have set count to zero and
-	   we must not mess that up further */
+	 * we must not mess that up further.
+	 */
 	spin_lock_irqsave(&port->lock, flags);
 	if (!tty_hung_up_p(filp))
 		port->count++;
-- 
2.8.1

