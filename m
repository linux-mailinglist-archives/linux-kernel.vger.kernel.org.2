Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55097435D2D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 10:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhJUIqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 04:46:04 -0400
Received: from mx24.baidu.com ([111.206.215.185]:47538 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231524AbhJUIqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:46:02 -0400
Received: from BC-Mail-Ex03.internal.baidu.com (unknown [172.31.51.43])
        by Forcepoint Email with ESMTPS id 0FA979DB31A7193B259A;
        Thu, 21 Oct 2021 16:43:46 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex03.internal.baidu.com (172.31.51.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 21 Oct 2021 16:43:45 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 21 Oct 2021 16:43:45 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Richard Weinberger <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ubifs: Make use of the helper macro kthread_run()
Date:   Thu, 21 Oct 2021 16:43:43 +0800
Message-ID: <20211021084344.2501-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex11.internal.baidu.com (172.31.51.51) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Repalce kthread_create/wake_up_process() with kthread_run()
to simplify the code.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 fs/ubifs/super.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index f0fb25727d96..0e7f206c43cf 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -1367,7 +1367,7 @@ static int mount_ubifs(struct ubifs_info *c)
 	sprintf(c->bgt_name, BGT_NAME_PATTERN, c->vi.ubi_num, c->vi.vol_id);
 	if (!c->ro_mount) {
 		/* Create background thread */
-		c->bgt = kthread_create(ubifs_bg_thread, c, "%s", c->bgt_name);
+		c->bgt = kthread_run(ubifs_bg_thread, c, "%s", c->bgt_name);
 		if (IS_ERR(c->bgt)) {
 			err = PTR_ERR(c->bgt);
 			c->bgt = NULL;
@@ -1375,7 +1375,6 @@ static int mount_ubifs(struct ubifs_info *c)
 				  c->bgt_name, err);
 			goto out_wbufs;
 		}
-		wake_up_process(c->bgt);
 	}
 
 	err = ubifs_read_master(c);
@@ -1780,7 +1779,7 @@ static int ubifs_remount_rw(struct ubifs_info *c)
 		goto out;
 
 	/* Create background thread */
-	c->bgt = kthread_create(ubifs_bg_thread, c, "%s", c->bgt_name);
+	c->bgt = kthread_run(ubifs_bg_thread, c, "%s", c->bgt_name);
 	if (IS_ERR(c->bgt)) {
 		err = PTR_ERR(c->bgt);
 		c->bgt = NULL;
@@ -1788,7 +1787,6 @@ static int ubifs_remount_rw(struct ubifs_info *c)
 			  c->bgt_name, err);
 		goto out;
 	}
-	wake_up_process(c->bgt);
 
 	c->orph_buf = vmalloc(c->leb_size);
 	if (!c->orph_buf) {
-- 
2.25.1

