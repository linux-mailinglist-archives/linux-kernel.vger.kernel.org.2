Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730C439A195
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 14:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhFCMzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 08:55:18 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3531 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhFCMzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 08:55:15 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fwm374J2tzYpn8;
        Thu,  3 Jun 2021 20:50:43 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 20:53:29 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 20:53:28 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 2/2] mtd: core: use MTD_DEVICE_ATTR_RO/RW() helper macros
Date:   Thu, 3 Jun 2021 20:53:23 +0800
Message-ID: <20210603125323.12142-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210603125323.12142-1-thunder.leizhen@huawei.com>
References: <20210603125323.12142-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use MTD_DEVICE_ATTR_RO/RW() helper macros instead of plain DEVICE_ATTR(),
which makes the code a bit shorter and easier to read.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/mtd/mtdcore.c | 46 ++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 770f64d6701567a..b5ccd3037788a24 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -139,7 +139,7 @@ static ssize_t mtd_type_show(struct device *dev,
 
 	return sysfs_emit(buf, "%s\n", type);
 }
-static DEVICE_ATTR(type, S_IRUGO, mtd_type_show, NULL);
+MTD_DEVICE_ATTR_RO(type);
 
 static ssize_t mtd_flags_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -148,7 +148,7 @@ static ssize_t mtd_flags_show(struct device *dev,
 
 	return sysfs_emit(buf, "0x%lx\n", (unsigned long)mtd->flags);
 }
-static DEVICE_ATTR(flags, S_IRUGO, mtd_flags_show, NULL);
+MTD_DEVICE_ATTR_RO(flags);
 
 static ssize_t mtd_size_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -157,7 +157,7 @@ static ssize_t mtd_size_show(struct device *dev,
 
 	return sysfs_emit(buf, "%llu\n", (unsigned long long)mtd->size);
 }
-static DEVICE_ATTR(size, S_IRUGO, mtd_size_show, NULL);
+MTD_DEVICE_ATTR_RO(size);
 
 static ssize_t mtd_erasesize_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -166,7 +166,7 @@ static ssize_t mtd_erasesize_show(struct device *dev,
 
 	return sysfs_emit(buf, "%lu\n", (unsigned long)mtd->erasesize);
 }
-static DEVICE_ATTR(erasesize, S_IRUGO, mtd_erasesize_show, NULL);
+MTD_DEVICE_ATTR_RO(erasesize);
 
 static ssize_t mtd_writesize_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -175,7 +175,7 @@ static ssize_t mtd_writesize_show(struct device *dev,
 
 	return sysfs_emit(buf, "%lu\n", (unsigned long)mtd->writesize);
 }
-static DEVICE_ATTR(writesize, S_IRUGO, mtd_writesize_show, NULL);
+MTD_DEVICE_ATTR_RO(writesize);
 
 static ssize_t mtd_subpagesize_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -185,7 +185,7 @@ static ssize_t mtd_subpagesize_show(struct device *dev,
 
 	return sysfs_emit(buf, "%u\n", subpagesize);
 }
-static DEVICE_ATTR(subpagesize, S_IRUGO, mtd_subpagesize_show, NULL);
+MTD_DEVICE_ATTR_RO(subpagesize);
 
 static ssize_t mtd_oobsize_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -194,7 +194,7 @@ static ssize_t mtd_oobsize_show(struct device *dev,
 
 	return sysfs_emit(buf, "%lu\n", (unsigned long)mtd->oobsize);
 }
-static DEVICE_ATTR(oobsize, S_IRUGO, mtd_oobsize_show, NULL);
+MTD_DEVICE_ATTR_RO(oobsize);
 
 static ssize_t mtd_oobavail_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
@@ -203,7 +203,7 @@ static ssize_t mtd_oobavail_show(struct device *dev,
 
 	return sysfs_emit(buf, "%u\n", mtd->oobavail);
 }
-static DEVICE_ATTR(oobavail, S_IRUGO, mtd_oobavail_show, NULL);
+MTD_DEVICE_ATTR_RO(oobavail);
 
 static ssize_t mtd_numeraseregions_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -212,8 +212,7 @@ static ssize_t mtd_numeraseregions_show(struct device *dev,
 
 	return sysfs_emit(buf, "%u\n", mtd->numeraseregions);
 }
-static DEVICE_ATTR(numeraseregions, S_IRUGO, mtd_numeraseregions_show,
-	NULL);
+MTD_DEVICE_ATTR_RO(numeraseregions);
 
 static ssize_t mtd_name_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -222,7 +221,7 @@ static ssize_t mtd_name_show(struct device *dev,
 
 	return sysfs_emit(buf, "%s\n", mtd->name);
 }
-static DEVICE_ATTR(name, S_IRUGO, mtd_name_show, NULL);
+MTD_DEVICE_ATTR_RO(name);
 
 static ssize_t mtd_ecc_strength_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
@@ -231,7 +230,7 @@ static ssize_t mtd_ecc_strength_show(struct device *dev,
 
 	return sysfs_emit(buf, "%u\n", mtd->ecc_strength);
 }
-static DEVICE_ATTR(ecc_strength, S_IRUGO, mtd_ecc_strength_show, NULL);
+MTD_DEVICE_ATTR_RO(ecc_strength);
 
 static ssize_t mtd_bitflip_threshold_show(struct device *dev,
 					  struct device_attribute *attr,
@@ -257,9 +256,7 @@ static ssize_t mtd_bitflip_threshold_store(struct device *dev,
 	mtd->bitflip_threshold = bitflip_threshold;
 	return count;
 }
-static DEVICE_ATTR(bitflip_threshold, S_IRUGO | S_IWUSR,
-		   mtd_bitflip_threshold_show,
-		   mtd_bitflip_threshold_store);
+MTD_DEVICE_ATTR_RW(bitflip_threshold);
 
 static ssize_t mtd_ecc_step_size_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -269,9 +266,9 @@ static ssize_t mtd_ecc_step_size_show(struct device *dev,
 	return sysfs_emit(buf, "%u\n", mtd->ecc_step_size);
 
 }
-static DEVICE_ATTR(ecc_step_size, S_IRUGO, mtd_ecc_step_size_show, NULL);
+MTD_DEVICE_ATTR_RO(ecc_step_size);
 
-static ssize_t mtd_ecc_stats_corrected_show(struct device *dev,
+static ssize_t mtd_corrected_bits_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct mtd_info *mtd = dev_get_drvdata(dev);
@@ -279,10 +276,9 @@ static ssize_t mtd_ecc_stats_corrected_show(struct device *dev,
 
 	return sysfs_emit(buf, "%u\n", ecc_stats->corrected);
 }
-static DEVICE_ATTR(corrected_bits, S_IRUGO,
-		   mtd_ecc_stats_corrected_show, NULL);
+MTD_DEVICE_ATTR_RO(corrected_bits);	/* ecc stats corrected */
 
-static ssize_t mtd_ecc_stats_errors_show(struct device *dev,
+static ssize_t mtd_ecc_failures_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct mtd_info *mtd = dev_get_drvdata(dev);
@@ -290,9 +286,9 @@ static ssize_t mtd_ecc_stats_errors_show(struct device *dev,
 
 	return sysfs_emit(buf, "%u\n", ecc_stats->failed);
 }
-static DEVICE_ATTR(ecc_failures, S_IRUGO, mtd_ecc_stats_errors_show, NULL);
+MTD_DEVICE_ATTR_RO(ecc_failures);	/* ecc stats errors */
 
-static ssize_t mtd_badblocks_show(struct device *dev,
+static ssize_t mtd_bad_blocks_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct mtd_info *mtd = dev_get_drvdata(dev);
@@ -300,9 +296,9 @@ static ssize_t mtd_badblocks_show(struct device *dev,
 
 	return sysfs_emit(buf, "%u\n", ecc_stats->badblocks);
 }
-static DEVICE_ATTR(bad_blocks, S_IRUGO, mtd_badblocks_show, NULL);
+MTD_DEVICE_ATTR_RO(bad_blocks);
 
-static ssize_t mtd_bbtblocks_show(struct device *dev,
+static ssize_t mtd_bbt_blocks_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct mtd_info *mtd = dev_get_drvdata(dev);
@@ -310,7 +306,7 @@ static ssize_t mtd_bbtblocks_show(struct device *dev,
 
 	return sysfs_emit(buf, "%u\n", ecc_stats->bbtblocks);
 }
-static DEVICE_ATTR(bbt_blocks, S_IRUGO, mtd_bbtblocks_show, NULL);
+MTD_DEVICE_ATTR_RO(bbt_blocks);
 
 static struct attribute *mtd_attrs[] = {
 	&dev_attr_type.attr,
-- 
2.26.0.106.g9fadedd


