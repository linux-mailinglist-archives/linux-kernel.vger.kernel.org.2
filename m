Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571A53457C4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 07:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhCWG0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 02:26:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14427 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhCWGZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 02:25:59 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F4LtS1h6Mzkdgp;
        Tue, 23 Mar 2021 14:24:16 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Mar 2021 14:25:51 +0800
From:   Meng Yu <yumeng18@huawei.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] Bluetooth: Remove trailing semicolon in macros
Date:   Tue, 23 Mar 2021 14:22:56 +0800
Message-ID: <1616480576-5249-1-git-send-email-yumeng18@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove trailing semicolon in macros and coding style fix.

Signed-off-by: Meng Yu <yumeng18@huawei.com>
---

Changes in v2
-Re-base in bluetooth-next 

 net/bluetooth/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index efc19f9..2def906 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -54,7 +54,7 @@
 #define SMP_ALLOW_CMD(smp, code)	set_bit(code, &smp->allow_cmd)
 
 /* Keys which are not distributed with Secure Connections */
-#define SMP_SC_NO_DIST (SMP_DIST_ENC_KEY | SMP_DIST_LINK_KEY);
+#define SMP_SC_NO_DIST (SMP_DIST_ENC_KEY | SMP_DIST_LINK_KEY)
 
 #define SMP_TIMEOUT	msecs_to_jiffies(30000)
 
@@ -398,7 +398,7 @@ static int smp_e(const u8 *k, u8 *r)
 
 	SMP_DBG("r %16phN", r);
 
-	memzero_explicit(&ctx, sizeof (ctx));
+	memzero_explicit(&ctx, sizeof(ctx));
 	return err;
 }
 
-- 
2.8.1

