Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700E44221E5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbhJEJPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 05:15:18 -0400
Received: from unicom145.biz-email.net ([210.51.26.145]:53608 "EHLO
        unicom145.biz-email.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbhJEJPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:15:17 -0400
Received: from ([60.208.111.195])
        by unicom145.biz-email.net ((LNX1044)) with ASMTP (SSL) id ZLT00021;
        Tue, 05 Oct 2021 17:13:21 +0800
Received: from localhost.localdomain (10.200.104.119) by
 jtjnmail201606.home.langchao.com (10.100.2.6) with Microsoft SMTP Server id
 15.1.2308.14; Tue, 5 Oct 2021 17:13:20 +0800
From:   Kai Song <songkai01@inspur.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Kai Song <songkai01@inspur.com>
Subject: [PATCH] ubi: Fix a mistake in comment
Date:   Tue, 5 Oct 2021 14:56:55 +0800
Message-ID: <20211005065656.13497-1-songkai01@inspur.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.119]
tUid:   2021100517132163fb41eca9b96765dce7d25a84d1c897
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 2a734bb8d502 ("UBI: use debugfs for the extra checks knobs")
There is a mistake in docstrings, it should be ubi_debugfs_exit_dev
instead of dbg_debug_exit_dev.

Signed-off-by: Kai Song <songkai01@inspur.com>
---
 drivers/mtd/ubi/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
index 3c0c8eca4d51..31d427ee191a 100644
--- a/drivers/mtd/ubi/debug.c
+++ b/drivers/mtd/ubi/debug.c
@@ -562,7 +562,7 @@ int ubi_debugfs_init_dev(struct ubi_device *ubi)
 }
 
 /**
- * dbg_debug_exit_dev - free all debugfs files corresponding to device @ubi
+ * ubi_debugfs_exit_dev - free all debugfs files corresponding to device @ubi
  * @ubi: UBI device description object
  */
 void ubi_debugfs_exit_dev(struct ubi_device *ubi)
-- 
2.27.0

