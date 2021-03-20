Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC300342CA6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 13:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhCTMAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 08:00:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14412 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhCTMAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 08:00:08 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F2XGp00cVzkbLd;
        Sat, 20 Mar 2021 15:20:33 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Sat, 20 Mar 2021 15:22:01 +0800
From:   Meng Yu <yumeng18@huawei.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>, <wangzhou1@hisilicon.com>,
        <yumeng18@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] Bluetooth: Remove trailing semicolon in macros
Date:   Sat, 20 Mar 2021 15:19:33 +0800
Message-ID: <1616224773-41847-1-git-send-email-yumeng18@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. remove trailing semicolon in macros;
2. fix some coding style.

Signed-off-by: Meng Yu <yumeng18@huawei.com>
---
 net/bluetooth/smp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 26e8cfad..07a193e 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -55,7 +55,7 @@
 #define SMP_ALLOW_CMD(smp, code)	set_bit(code, &smp->allow_cmd)
 
 /* Keys which are not distributed with Secure Connections */
-#define SMP_SC_NO_DIST (SMP_DIST_ENC_KEY | SMP_DIST_LINK_KEY);
+#define SMP_SC_NO_DIST (SMP_DIST_ENC_KEY | SMP_DIST_LINK_KEY)
 
 #define SMP_TIMEOUT	msecs_to_jiffies(30000)
 
@@ -403,7 +403,7 @@ static int smp_e(const u8 *k, u8 *r)
 
 	SMP_DBG("r %16phN", r);
 
-	memzero_explicit(&ctx, sizeof (ctx));
+	memzero_explicit(&ctx, sizeof(ctx));
 	return err;
 }
 
@@ -866,7 +866,7 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 	memset(smp->tk, 0, sizeof(smp->tk));
 	clear_bit(SMP_FLAG_TK_VALID, &smp->flags);
 
-	BT_DBG("tk_request: auth:%d lcl:%d rem:%d", auth, local_io, remote_io);
+	BT_DBG("%s: auth:%d lcl:%d rem:%d", __func__, auth, local_io, remote_io);
 
 	/* If neither side wants MITM, either "just" confirm an incoming
 	 * request or use just-works for outgoing ones. The JUST_CFM
-- 
2.8.1

