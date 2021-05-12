Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3269437B938
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhELJb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:31:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2643 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbhELJao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:30:44 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fg8Zh6YKSzldYh;
        Wed, 12 May 2021 17:27:24 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 17:29:26 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH 09/17] tty: tty_io: Fix trailing whitespace issues
Date:   Wed, 12 May 2021 17:26:17 +0800
Message-ID: <1620811585-18582-10-git-send-email-tanxiaofei@huawei.com>
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

Fix trailing whitespace issues, reported by checkpatch.pl.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/tty/tty_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 93a9142..5ad2b73 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3015,7 +3015,7 @@ static int this_tty(const void *t, struct file *file, unsigned fd)
 		return 0;
 	return file_tty(file) != t ? 0 : fd + 1;
 }
-	
+
 /*
  * This implements the "Secure Attention Key" ---  the idea is to
  * prevent trojan horses by killing all processes associated with this
-- 
2.8.1

