Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093FA36D554
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 12:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238938AbhD1KDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 06:03:15 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:59554 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238684AbhD1KDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 06:03:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UX3IHwS_1619604144;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UX3IHwS_1619604144)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 28 Apr 2021 18:02:26 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, nathan@kernel.org,
        ndesaulniers@google.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] mtd: tests: Remove redundant assignment to err
Date:   Wed, 28 Apr 2021 18:02:22 +0800
Message-Id: <1619604142-119891-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable 'err' is set to 0 but this value is never read as it is
overwritten with a new value later on, hence it is a redundant
assignment and can be removed.

Cleans up the following clang-analyzer warning:

drivers/mtd/tests/torturetest.c:233:2: warning: Value stored to 'err' is
never read [clang-analyzer-deadcode.DeadStores]

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/mtd/tests/torturetest.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mtd/tests/torturetest.c b/drivers/mtd/tests/torturetest.c
index 6787ac5..841689b 100644
--- a/drivers/mtd/tests/torturetest.c
+++ b/drivers/mtd/tests/torturetest.c
@@ -230,8 +230,6 @@ static int __init tort_init(void)
 	if (!bad_ebs)
 		goto out_check_buf;
 
-	err = 0;
-
 	/* Initialize patterns */
 	memset(patt_FF, 0xFF, mtd->erasesize);
 	for (i = 0; i < mtd->erasesize / pgsize; i++) {
-- 
1.8.3.1

