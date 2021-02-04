Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CCC30EB4C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 04:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhBDD5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 22:57:41 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:56361 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232319AbhBDD4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 22:56:21 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UNpI0P._1612410923;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UNpI0P._1612410923)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 04 Feb 2021 11:55:28 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] mtd: convert sysfs sprintf/snprintf family to sysfs_emit
Date:   Thu,  4 Feb 2021 11:55:21 +0800
Message-Id: <1612410921-80984-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

./drivers/mtd/mtdcore.c: WARNING: use scnprintf or sprintf.

Reported-by: Abaci Robot<abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/mtd/mtdcore.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 2d6423d..c37056e 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -131,7 +131,7 @@ static ssize_t mtd_type_show(struct device *dev,
 		type = "unknown";
 	}
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", type);
+	return sysfs_emit(buf, "%s\n", type);
 }
 static DEVICE_ATTR(type, S_IRUGO, mtd_type_show, NULL);
 
@@ -140,7 +140,7 @@ static ssize_t mtd_flags_show(struct device *dev,
 {
 	struct mtd_info *mtd = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "0x%lx\n", (unsigned long)mtd->flags);
+	return sysfs_emit(buf, "0x%lx\n", (unsigned long)mtd->flags);
 }
 static DEVICE_ATTR(flags, S_IRUGO, mtd_flags_show, NULL);
 
@@ -149,8 +149,7 @@ static ssize_t mtd_size_show(struct device *dev,
 {
 	struct mtd_info *mtd = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
-		(unsigned long long)mtd->size);
+	return sysfs_emit(buf, "%llu\n", (unsigned long long)mtd->size);
 }
 static DEVICE_ATTR(size, S_IRUGO, mtd_size_show, NULL);
 
@@ -159,7 +158,7 @@ static ssize_t mtd_erasesize_show(struct device *dev,
 {
 	struct mtd_info *mtd = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%lu\n", (unsigned long)mtd->erasesize);
+	return sysfs_emit(buf, "%lu\n", (unsigned long)mtd->erasesize);
 }
 static DEVICE_ATTR(erasesize, S_IRUGO, mtd_erasesize_show, NULL);
 
@@ -168,7 +167,7 @@ static ssize_t mtd_writesize_show(struct device *dev,
 {
 	struct mtd_info *mtd = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%lu\n", (unsigned long)mtd->writesize);
+	return sysfs_emit(buf, "%lu\n", (unsigned long)mtd->writesize);
 }
 static DEVICE_ATTR(writesize, S_IRUGO, mtd_writesize_show, NULL);
 
@@ -178,7 +177,7 @@ static ssize_t mtd_subpagesize_show(struct device *dev,
 	struct mtd_info *mtd = dev_get_drvdata(dev);
 	unsigned int subpagesize = mtd->writesize >> mtd->subpage_sft;
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", subpagesize);
+	return sysfs_emit(buf, "%u\n", subpagesize);
 }
 static DEVICE_ATTR(subpagesize, S_IRUGO, mtd_subpagesize_show, NULL);
 
@@ -187,7 +186,7 @@ static ssize_t mtd_oobsize_show(struct device *dev,
 {
 	struct mtd_info *mtd = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%lu\n", (unsigned long)mtd->oobsize);
+	return sysfs_emit(buf, "%lu\n", (unsigned long)mtd->oobsize);
 }
 static DEVICE_ATTR(oobsize, S_IRUGO, mtd_oobsize_show, NULL);
 
@@ -196,7 +195,7 @@ static ssize_t mtd_oobavail_show(struct device *dev,
 {
 	struct mtd_info *mtd = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", mtd->oobavail);
+	return sysfs_emit(buf, "%u\n", mtd->oobavail);
 }
 static DEVICE_ATTR(oobavail, S_IRUGO, mtd_oobavail_show, NULL);
 
@@ -205,7 +204,7 @@ static ssize_t mtd_numeraseregions_show(struct device *dev,
 {
 	struct mtd_info *mtd = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", mtd->numeraseregions);
+	return sysfs_emit(buf, "%u\n", mtd->numeraseregions);
 }
 static DEVICE_ATTR(numeraseregions, S_IRUGO, mtd_numeraseregions_show,
 	NULL);
@@ -215,7 +214,7 @@ static ssize_t mtd_name_show(struct device *dev,
 {
 	struct mtd_info *mtd = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", mtd->name);
+	return sysfs_emit(buf, "%s\n", mtd->name);
 }
 static DEVICE_ATTR(name, S_IRUGO, mtd_name_show, NULL);
 
@@ -224,7 +223,7 @@ static ssize_t mtd_ecc_strength_show(struct device *dev,
 {
 	struct mtd_info *mtd = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", mtd->ecc_strength);
+	return sysfs_emit(buf, "%u\n", mtd->ecc_strength);
 }
 static DEVICE_ATTR(ecc_strength, S_IRUGO, mtd_ecc_strength_show, NULL);
 
@@ -234,7 +233,7 @@ static ssize_t mtd_bitflip_threshold_show(struct device *dev,
 {
 	struct mtd_info *mtd = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", mtd->bitflip_threshold);
+	return sysfs_emit(buf, "%u\n", mtd->bitflip_threshold);
 }
 
 static ssize_t mtd_bitflip_threshold_store(struct device *dev,
@@ -261,7 +260,7 @@ static ssize_t mtd_ecc_step_size_show(struct device *dev,
 {
 	struct mtd_info *mtd = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", mtd->ecc_step_size);
+	return sysfs_emit(buf, "%u\n", mtd->ecc_step_size);
 
 }
 static DEVICE_ATTR(ecc_step_size, S_IRUGO, mtd_ecc_step_size_show, NULL);
@@ -272,7 +271,7 @@ static ssize_t mtd_ecc_stats_corrected_show(struct device *dev,
 	struct mtd_info *mtd = dev_get_drvdata(dev);
 	struct mtd_ecc_stats *ecc_stats = &mtd->ecc_stats;
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", ecc_stats->corrected);
+	return sysfs_emit(buf, "%u\n", ecc_stats->corrected);
 }
 static DEVICE_ATTR(corrected_bits, S_IRUGO,
 		   mtd_ecc_stats_corrected_show, NULL);
@@ -283,7 +282,7 @@ static ssize_t mtd_ecc_stats_errors_show(struct device *dev,
 	struct mtd_info *mtd = dev_get_drvdata(dev);
 	struct mtd_ecc_stats *ecc_stats = &mtd->ecc_stats;
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", ecc_stats->failed);
+	return sysfs_emit(buf, "%u\n", ecc_stats->failed);
 }
 static DEVICE_ATTR(ecc_failures, S_IRUGO, mtd_ecc_stats_errors_show, NULL);
 
@@ -293,7 +292,7 @@ static ssize_t mtd_badblocks_show(struct device *dev,
 	struct mtd_info *mtd = dev_get_drvdata(dev);
 	struct mtd_ecc_stats *ecc_stats = &mtd->ecc_stats;
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", ecc_stats->badblocks);
+	return sysfs_emit(buf, "%u\n", ecc_stats->badblocks);
 }
 static DEVICE_ATTR(bad_blocks, S_IRUGO, mtd_badblocks_show, NULL);
 
@@ -303,7 +302,7 @@ static ssize_t mtd_bbtblocks_show(struct device *dev,
 	struct mtd_info *mtd = dev_get_drvdata(dev);
 	struct mtd_ecc_stats *ecc_stats = &mtd->ecc_stats;
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", ecc_stats->bbtblocks);
+	return sysfs_emit(buf, "%u\n", ecc_stats->bbtblocks);
 }
 static DEVICE_ATTR(bbt_blocks, S_IRUGO, mtd_bbtblocks_show, NULL);
 
-- 
1.8.3.1

