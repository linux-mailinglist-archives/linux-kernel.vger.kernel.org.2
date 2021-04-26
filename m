Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE1436B0AF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 11:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbhDZJda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 05:33:30 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:60024 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232871AbhDZJdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 05:33:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UWpMjTz_1619429550;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UWpMjTz_1619429550)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 26 Apr 2021 17:32:31 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] mtd: return -ENOMEM when kmalloc failed
Date:   Mon, 26 Apr 2021 17:32:23 +0800
Message-Id: <1619429543-52234-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is using -1 instead of the -ENOMEM defined macro to
specify that a buffer allocation failed. Using the correct error
code is more intuitive

Smatch tool warning:
drivers/mtd/inftlmount.c:333 check_free_sectors() warn: returning -1
instead of -ENOMEM is sloppy
drivers/mtd/nftlmount.c:272 check_free_sectors() warn: returning -1
instead of -ENOMEM is sloppy

No functional change, just more standardized.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/mtd/inftlmount.c | 2 +-
 drivers/mtd/nftlmount.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/inftlmount.c b/drivers/mtd/inftlmount.c
index af16d34..39d0241 100644
--- a/drivers/mtd/inftlmount.c
+++ b/drivers/mtd/inftlmount.c
@@ -330,7 +330,7 @@ static int check_free_sectors(struct INFTLrecord *inftl, unsigned int address,
 
 	buf = kmalloc(SECTORSIZE + mtd->oobsize, GFP_KERNEL);
 	if (!buf)
-		return -1;
+		return -ENOMEM;
 
 	ret = -1;
 	for (i = 0; i < len; i += SECTORSIZE) {
diff --git a/drivers/mtd/nftlmount.c b/drivers/mtd/nftlmount.c
index 444a77b..fd331bc 100644
--- a/drivers/mtd/nftlmount.c
+++ b/drivers/mtd/nftlmount.c
@@ -269,7 +269,7 @@ static int check_free_sectors(struct NFTLrecord *nftl, unsigned int address, int
 
 	buf = kmalloc(SECTORSIZE + mtd->oobsize, GFP_KERNEL);
 	if (!buf)
-		return -1;
+		return -ENOMEM;
 
 	ret = -1;
 	for (i = 0; i < len; i += SECTORSIZE) {
-- 
1.8.3.1

