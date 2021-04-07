Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B993564C7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 09:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349368AbhDGHKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 03:10:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15151 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346161AbhDGHJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 03:09:52 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FFb6g66QJzpVx4;
        Wed,  7 Apr 2021 15:06:51 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Wed, 7 Apr 2021 15:09:28 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH v3 09/10] tty: tty_ldisc: Do not use assignment in if condition
Date:   Wed, 7 Apr 2021 15:06:49 +0800
Message-ID: <1617779210-51576-10-git-send-email-tanxiaofei@huawei.com>
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

Do not use assignment in if condition following the advice of
checkpatch.pl.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/tty/tty_ldisc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 874d238..56e67f7 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -508,7 +508,8 @@ static int tty_ldisc_failto(struct tty_struct *tty, int ld)
 		return PTR_ERR(disc);
 	tty->ldisc = disc;
 	tty_set_termios_ldisc(tty, ld);
-	if ((r = tty_ldisc_open(tty, disc)) < 0)
+	r = tty_ldisc_open(tty, disc);
+	if (r < 0)
 		tty_ldisc_put(disc);
 	return r;
 }
-- 
2.8.1

