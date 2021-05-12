Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6798737B93E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhELJbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:31:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2646 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhELJaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:30:46 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fg8Zj07S5zldZ7;
        Wed, 12 May 2021 17:27:25 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 17:29:27 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH 14/17] tty: tty_io: Remove return in void function
Date:   Wed, 12 May 2021 17:26:22 +0800
Message-ID: <1620811585-18582-15-git-send-email-tanxiaofei@huawei.com>
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

Remove return in void function, reported by checkpatch.pl.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/tty/tty_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index ce07aca..eef5ccc 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1090,7 +1090,6 @@ void tty_write_message(struct tty_struct *tty, char *msg)
 		tty_unlock(tty);
 		tty_write_unlock(tty);
 	}
-	return;
 }
 
 
-- 
2.8.1

