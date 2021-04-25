Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46EEC36A6A8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 12:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhDYK3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 06:29:53 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:31976 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229899AbhDYK3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 06:29:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UWg8-M1_1619346499;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UWg8-M1_1619346499)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 25 Apr 2021 18:28:55 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] mtd: mtd_oobtest: Remove redundant assignment to err
Date:   Sun, 25 Apr 2021 18:28:18 +0800
Message-Id: <1619346498-43617-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable err is set to zero but this value is never read as it is
overwritten with a new value later on, hence it is a redundant
assignment and can be removed.

Cleans up the following clang-analyzer warning:

drivers/mtd/tests/oobtest.c:626:4: warning: Value stored to 'err' is
never read [clang-analyzer-deadcode.DeadStores].

drivers/mtd/tests/oobtest.c:603:4: warning: Value stored to 'err' is
never read [clang-analyzer-deadcode.DeadStores].

drivers/mtd/tests/oobtest.c:579:4: warning: Value stored to 'err' is
never read [clang-analyzer-deadcode.DeadStores].

drivers/mtd/tests/oobtest.c:556:4: warning: Value stored to 'err' is
never read [clang-analyzer-deadcode.DeadStores].

drivers/mtd/tests/oobtest.c:532:3: warning: Value stored to 'err' is
never read [clang-analyzer-deadcode.DeadStores].

drivers/mtd/tests/oobtest.c:509:3: warning: Value stored to 'err' is
never read [clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/mtd/tests/oobtest.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/mtd/tests/oobtest.c b/drivers/mtd/tests/oobtest.c
index c71daa8..3a31a2c 100644
--- a/drivers/mtd/tests/oobtest.c
+++ b/drivers/mtd/tests/oobtest.c
@@ -506,7 +506,6 @@ static int __init mtd_oobtest_init(void)
 	err = mtd_write_oob(mtd, addr0, &ops);
 	if (err) {
 		pr_info("error occurred as expected\n");
-		err = 0;
 	} else {
 		pr_err("error: can write past end of OOB\n");
 		errcnt += 1;
@@ -529,7 +528,6 @@ static int __init mtd_oobtest_init(void)
 
 	if (err) {
 		pr_info("error occurred as expected\n");
-		err = 0;
 	} else {
 		pr_err("error: can read past end of OOB\n");
 		errcnt += 1;
@@ -553,7 +551,6 @@ static int __init mtd_oobtest_init(void)
 		err = mtd_write_oob(mtd, mtd->size - mtd->writesize, &ops);
 		if (err) {
 			pr_info("error occurred as expected\n");
-			err = 0;
 		} else {
 			pr_err("error: wrote past end of device\n");
 			errcnt += 1;
@@ -576,7 +573,6 @@ static int __init mtd_oobtest_init(void)
 
 		if (err) {
 			pr_info("error occurred as expected\n");
-			err = 0;
 		} else {
 			pr_err("error: read past end of device\n");
 			errcnt += 1;
@@ -600,7 +596,6 @@ static int __init mtd_oobtest_init(void)
 		err = mtd_write_oob(mtd, mtd->size - mtd->writesize, &ops);
 		if (err) {
 			pr_info("error occurred as expected\n");
-			err = 0;
 		} else {
 			pr_err("error: wrote past end of device\n");
 			errcnt += 1;
@@ -623,7 +618,6 @@ static int __init mtd_oobtest_init(void)
 
 		if (err) {
 			pr_info("error occurred as expected\n");
-			err = 0;
 		} else {
 			pr_err("error: read past end of device\n");
 			errcnt += 1;
-- 
1.8.3.1

