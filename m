Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3735837B92E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhELJa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:30:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2458 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhELJam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:30:42 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fg8Z22YHDzBtTP;
        Wed, 12 May 2021 17:26:50 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 17:29:24 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH 02/17] tty: tty_baudrate: Fix coding style issues of block comments
Date:   Wed, 12 May 2021 17:26:10 +0800
Message-ID: <1620811585-18582-3-git-send-email-tanxiaofei@huawei.com>
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
Besides, add a period at the end of comment sentenses.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/tty/tty_baudrate.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/tty_baudrate.c b/drivers/tty/tty_baudrate.c
index b3f5ba9..426b125 100644
--- a/drivers/tty/tty_baudrate.c
+++ b/drivers/tty/tty_baudrate.c
@@ -159,8 +159,9 @@ void tty_termios_encode_baud_rate(struct ktermios *termios,
 #endif
 #ifdef BOTHER
 	/* If the user asked for a precise weird speed give a precise weird
-	   answer. If they asked for a Bfoo speed they may have problems
-	   digesting non-exact replies so fuzz a bit */
+	 * answer. If they asked for a Bfoo speed they may have problems
+	 * digesting non-exact replies so fuzz a bit.
+	 */
 
 	if ((termios->c_cflag & CBAUD) == BOTHER) {
 		oclose = 0;
@@ -191,7 +192,8 @@ void tty_termios_encode_baud_rate(struct ktermios *termios,
 		if (ibaud - iclose <= baud_table[i] &&
 		    ibaud + iclose >= baud_table[i]) {
 			/* For the case input == output don't set IBAUD bits
-			   if the user didn't do so */
+			 * if the user didn't do so.
+			 */
 			if (ofound == i && !ibinput)
 				ifound  = i;
 #ifdef IBSHIFT
@@ -211,7 +213,8 @@ void tty_termios_encode_baud_rate(struct ktermios *termios,
 	if (ofound == -1)
 		termios->c_cflag |= BOTHER;
 	/* Set exact input bits only if the input and output differ or the
-	   user already did */
+	 * user already did.
+	 */
 	if (ifound == -1 && (ibaud != obaud || ibinput))
 		termios->c_cflag |= (BOTHER << IBSHIFT);
 #else
-- 
2.8.1

