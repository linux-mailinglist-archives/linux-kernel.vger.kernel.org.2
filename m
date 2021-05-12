Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA27637B92A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhELJas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:30:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2456 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhELJam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:30:42 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fg8Z22mjpzBtTY;
        Wed, 12 May 2021 17:26:50 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 17:29:24 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH 05/17] tty: tty_buffer: Fix coding style issues of block comments
Date:   Wed, 12 May 2021 17:26:13 +0800
Message-ID: <1620811585-18582-6-git-send-email-tanxiaofei@huawei.com>
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
 drivers/tty/tty_buffer.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 721491df..e9ff5dd 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -170,7 +170,8 @@ static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
 	}
 
 	/* Should possibly check if this fails for the largest buffer we
-	   have queued and recycle that ? */
+	 * have queued and recycle that ?
+	 */
 	if (atomic_read(&port->buf.mem_used) > port->buf.mem_limit)
 		return NULL;
 	p = kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC);
@@ -329,7 +330,8 @@ int tty_insert_flip_string_fixed_flag(struct tty_port *port,
 		copied += space;
 		chars += space;
 		/* There is a small chance that we need to split the data over
-		   several buffers. If this is the case we must loop */
+		 * several buffers. If this is the case we must loop.
+		 */
 	} while (unlikely(size > copied));
 	return copied;
 }
@@ -366,7 +368,8 @@ int tty_insert_flip_string_flags(struct tty_port *port,
 		chars += space;
 		flags += space;
 		/* There is a small chance that we need to split the data over
-		   several buffers. If this is the case we must loop */
+		 * several buffers. If this is the case we must loop.
+		 */
 	} while (unlikely(size > copied));
 	return copied;
 }
-- 
2.8.1

