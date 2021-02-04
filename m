Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EEC30EAFD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 04:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbhBDDdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 22:33:42 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:39532 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231759AbhBDDdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 22:33:39 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UNp.PXn_1612409572;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UNp.PXn_1612409572)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 04 Feb 2021 11:32:57 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     will@kernel.org
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] drivers/perf: convert sysfs sprintf/snprintf family to sysfs_emit
Date:   Thu,  4 Feb 2021 11:32:51 +0800
Message-Id: <1612409571-56451-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

./drivers/perf/arm-cci.c:708:8-16: WARNING: use scnprintf or sprintf.
./drivers/perf/arm-cci.c:699:8-16: WARNING: use scnprintf or sprintf.
./drivers/perf/arm-cci.c:528:8-16: WARNING: use scnprintf or sprintf.
./drivers/perf/arm-cci.c:309:8-16: WARNING: use scnprintf or sprintf.

Reported-by: Abaci Robot<abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/perf/arm-cci.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 87c4be9..efc39cb 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -306,7 +306,7 @@ static ssize_t cci400_pmu_cycle_event_show(struct device *dev,
 {
 	struct dev_ext_attribute *eattr = container_of(attr,
 				struct dev_ext_attribute, attr);
-	return snprintf(buf, PAGE_SIZE, "config=0x%lx\n", (unsigned long)eattr->var);
+	return sysfs_emit(buf, "config=0x%lx\n", (unsigned long)eattr->var);
 }
 
 static int cci400_get_event_idx(struct cci_pmu *cci_pmu,
@@ -525,8 +525,8 @@ static ssize_t cci5xx_pmu_global_event_show(struct device *dev,
 	struct dev_ext_attribute *eattr = container_of(attr,
 					struct dev_ext_attribute, attr);
 	/* Global events have single fixed source code */
-	return snprintf(buf, PAGE_SIZE, "event=0x%lx,source=0x%x\n",
-				(unsigned long)eattr->var, CCI5xx_PORT_GLOBAL);
+	return sysfs_emit(buf, "event=0x%lx,source=0x%x\n",
+			  (unsigned long)eattr->var, CCI5xx_PORT_GLOBAL);
 }
 
 /*
@@ -696,7 +696,7 @@ static ssize_t cci_pmu_format_show(struct device *dev,
 {
 	struct dev_ext_attribute *eattr = container_of(attr,
 				struct dev_ext_attribute, attr);
-	return snprintf(buf, PAGE_SIZE, "%s\n", (char *)eattr->var);
+	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
 }
 
 static ssize_t cci_pmu_event_show(struct device *dev,
@@ -705,8 +705,7 @@ static ssize_t cci_pmu_event_show(struct device *dev,
 	struct dev_ext_attribute *eattr = container_of(attr,
 				struct dev_ext_attribute, attr);
 	/* source parameter is mandatory for normal PMU events */
-	return snprintf(buf, PAGE_SIZE, "source=?,event=0x%lx\n",
-					 (unsigned long)eattr->var);
+	return sysfs_emit(buf, "source=?,event=0x%lx\n", (unsigned long)eattr->var);
 }
 
 static int pmu_is_valid_counter(struct cci_pmu *cci_pmu, int idx)
-- 
1.8.3.1

