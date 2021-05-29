Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BD9394C18
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 13:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhE2Lyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 07:54:31 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2539 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhE2Lya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 07:54:30 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fsfxb2mHVzYrgq;
        Sat, 29 May 2021 19:50:11 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 19:52:52 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 29
 May 2021 19:52:52 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] regulator: core: Use DEVICE_ATTR_RO macro
Date:   Sat, 29 May 2021 19:52:26 +0800
Message-ID: <20210529115226.25376-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR_RO() helper instead of plain DEVICE_ATTR(),
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/regulator/core.c | 130 ++++++++++++++++++---------------------
 1 file changed, 60 insertions(+), 70 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e20e77e4c159..f00eee655ad1 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -591,8 +591,8 @@ regulator_get_suspend_state_check(struct regulator_dev *rdev, suspend_state_t st
 	return rstate;
 }
 
-static ssize_t regulator_uV_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t microvolts_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
 {
 	struct regulator_dev *rdev = dev_get_drvdata(dev);
 	int uV;
@@ -605,16 +605,16 @@ static ssize_t regulator_uV_show(struct device *dev,
 		return uV;
 	return sprintf(buf, "%d\n", uV);
 }
-static DEVICE_ATTR(microvolts, 0444, regulator_uV_show, NULL);
+static DEVICE_ATTR_RO(microvolts);
 
-static ssize_t regulator_uA_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t microamps_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
 {
 	struct regulator_dev *rdev = dev_get_drvdata(dev);
 
 	return sprintf(buf, "%d\n", _regulator_get_current_limit(rdev));
 }
-static DEVICE_ATTR(microamps, 0444, regulator_uA_show, NULL);
+static DEVICE_ATTR_RO(microamps);
 
 static ssize_t name_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
@@ -645,14 +645,14 @@ static ssize_t regulator_print_opmode(char *buf, int mode)
 	return sprintf(buf, "%s\n", regulator_opmode_to_str(mode));
 }
 
-static ssize_t regulator_opmode_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
+static ssize_t opmode_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
 {
 	struct regulator_dev *rdev = dev_get_drvdata(dev);
 
 	return regulator_print_opmode(buf, _regulator_get_mode(rdev));
 }
-static DEVICE_ATTR(opmode, 0444, regulator_opmode_show, NULL);
+static DEVICE_ATTR_RO(opmode);
 
 static ssize_t regulator_print_state(char *buf, int state)
 {
@@ -664,8 +664,8 @@ static ssize_t regulator_print_state(char *buf, int state)
 		return sprintf(buf, "unknown\n");
 }
 
-static ssize_t regulator_state_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
+static ssize_t state_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
 {
 	struct regulator_dev *rdev = dev_get_drvdata(dev);
 	ssize_t ret;
@@ -676,10 +676,10 @@ static ssize_t regulator_state_show(struct device *dev,
 
 	return ret;
 }
-static DEVICE_ATTR(state, 0444, regulator_state_show, NULL);
+static DEVICE_ATTR_RO(state);
 
-static ssize_t regulator_status_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
+static ssize_t status_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
 {
 	struct regulator_dev *rdev = dev_get_drvdata(dev);
 	int status;
@@ -723,10 +723,10 @@ static ssize_t regulator_status_show(struct device *dev,
 
 	return sprintf(buf, "%s\n", label);
 }
-static DEVICE_ATTR(status, 0444, regulator_status_show, NULL);
+static DEVICE_ATTR_RO(status);
 
-static ssize_t regulator_min_uA_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
+static ssize_t min_microamps_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
 {
 	struct regulator_dev *rdev = dev_get_drvdata(dev);
 
@@ -735,10 +735,10 @@ static ssize_t regulator_min_uA_show(struct device *dev,
 
 	return sprintf(buf, "%d\n", rdev->constraints->min_uA);
 }
-static DEVICE_ATTR(min_microamps, 0444, regulator_min_uA_show, NULL);
+static DEVICE_ATTR_RO(min_microamps);
 
-static ssize_t regulator_max_uA_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
+static ssize_t max_microamps_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
 {
 	struct regulator_dev *rdev = dev_get_drvdata(dev);
 
@@ -747,10 +747,10 @@ static ssize_t regulator_max_uA_show(struct device *dev,
 
 	return sprintf(buf, "%d\n", rdev->constraints->max_uA);
 }
-static DEVICE_ATTR(max_microamps, 0444, regulator_max_uA_show, NULL);
+static DEVICE_ATTR_RO(max_microamps);
 
-static ssize_t regulator_min_uV_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
+static ssize_t min_microvolts_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
 {
 	struct regulator_dev *rdev = dev_get_drvdata(dev);
 
@@ -759,10 +759,10 @@ static ssize_t regulator_min_uV_show(struct device *dev,
 
 	return sprintf(buf, "%d\n", rdev->constraints->min_uV);
 }
-static DEVICE_ATTR(min_microvolts, 0444, regulator_min_uV_show, NULL);
+static DEVICE_ATTR_RO(min_microvolts);
 
-static ssize_t regulator_max_uV_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
+static ssize_t max_microvolts_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
 {
 	struct regulator_dev *rdev = dev_get_drvdata(dev);
 
@@ -771,10 +771,10 @@ static ssize_t regulator_max_uV_show(struct device *dev,
 
 	return sprintf(buf, "%d\n", rdev->constraints->max_uV);
 }
-static DEVICE_ATTR(max_microvolts, 0444, regulator_max_uV_show, NULL);
+static DEVICE_ATTR_RO(max_microvolts);
 
-static ssize_t regulator_total_uA_show(struct device *dev,
-				      struct device_attribute *attr, char *buf)
+static ssize_t requested_microamps_show(struct device *dev,
+					struct device_attribute *attr, char *buf)
 {
 	struct regulator_dev *rdev = dev_get_drvdata(dev);
 	struct regulator *regulator;
@@ -788,7 +788,7 @@ static ssize_t regulator_total_uA_show(struct device *dev,
 	regulator_unlock(rdev);
 	return sprintf(buf, "%d\n", uA);
 }
-static DEVICE_ATTR(requested_microamps, 0444, regulator_total_uA_show, NULL);
+static DEVICE_ATTR_RO(requested_microamps);
 
 static ssize_t num_users_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
@@ -813,104 +813,95 @@ static ssize_t type_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(type);
 
-static ssize_t regulator_suspend_mem_uV_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t suspend_mem_microvolts_show(struct device *dev,
+					   struct device_attribute *attr, char *buf)
 {
 	struct regulator_dev *rdev = dev_get_drvdata(dev);
 
 	return sprintf(buf, "%d\n", rdev->constraints->state_mem.uV);
 }
-static DEVICE_ATTR(suspend_mem_microvolts, 0444,
-		regulator_suspend_mem_uV_show, NULL);
+static DEVICE_ATTR_RO(suspend_mem_microvolts);
 
-static ssize_t regulator_suspend_disk_uV_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t suspend_disk_microvolts_show(struct device *dev,
+					    struct device_attribute *attr, char *buf)
 {
 	struct regulator_dev *rdev = dev_get_drvdata(dev);
 
 	return sprintf(buf, "%d\n", rdev->constraints->state_disk.uV);
 }
-static DEVICE_ATTR(suspend_disk_microvolts, 0444,
-		regulator_suspend_disk_uV_show, NULL);
+static DEVICE_ATTR_RO(suspend_disk_microvolts);
 
-static ssize_t regulator_suspend_standby_uV_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t suspend_standby_microvolts_show(struct device *dev,
+					       struct device_attribute *attr, char *buf)
 {
 	struct regulator_dev *rdev = dev_get_drvdata(dev);
 
 	return sprintf(buf, "%d\n", rdev->constraints->state_standby.uV);
 }
-static DEVICE_ATTR(suspend_standby_microvolts, 0444,
-		regulator_suspend_standby_uV_show, NULL);
+static DEVICE_ATTR_RO(suspend_standby_microvolts);
 
-static ssize_t regulator_suspend_mem_mode_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t suspend_mem_mode_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
 {
 	struct regulator_dev *rdev = dev_get_drvdata(dev);
 
 	return regulator_print_opmode(buf,
 		rdev->constraints->state_mem.mode);
 }
-static DEVICE_ATTR(suspend_mem_mode, 0444,
-		regulator_suspend_mem_mode_show, NULL);
+static DEVICE_ATTR_RO(suspend_mem_mode);
 
-static ssize_t regulator_suspend_disk_mode_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t suspend_disk_mode_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
 {
 	struct regulator_dev *rdev = dev_get_drvdata(dev);
 
 	return regulator_print_opmode(buf,
 		rdev->constraints->state_disk.mode);
 }
-static DEVICE_ATTR(suspend_disk_mode, 0444,
-		regulator_suspend_disk_mode_show, NULL);
+static DEVICE_ATTR_RO(suspend_disk_mode);
 
-static ssize_t regulator_suspend_standby_mode_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t suspend_standby_mode_show(struct device *dev,
+					 struct device_attribute *attr, char *buf)
 {
 	struct regulator_dev *rdev = dev_get_drvdata(dev);
 
 	return regulator_print_opmode(buf,
 		rdev->constraints->state_standby.mode);
 }
-static DEVICE_ATTR(suspend_standby_mode, 0444,
-		regulator_suspend_standby_mode_show, NULL);
+static DEVICE_ATTR_RO(suspend_standby_mode);
 
-static ssize_t regulator_suspend_mem_state_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
+static ssize_t suspend_mem_state_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
 {
 	struct regulator_dev *rdev = dev_get_drvdata(dev);
 
 	return regulator_print_state(buf,
 			rdev->constraints->state_mem.enabled);
 }
-static DEVICE_ATTR(suspend_mem_state, 0444,
-		regulator_suspend_mem_state_show, NULL);
+static DEVICE_ATTR_RO(suspend_mem_state);
 
-static ssize_t regulator_suspend_disk_state_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
+static ssize_t suspend_disk_state_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
 {
 	struct regulator_dev *rdev = dev_get_drvdata(dev);
 
 	return regulator_print_state(buf,
 			rdev->constraints->state_disk.enabled);
 }
-static DEVICE_ATTR(suspend_disk_state, 0444,
-		regulator_suspend_disk_state_show, NULL);
+static DEVICE_ATTR_RO(suspend_disk_state);
 
-static ssize_t regulator_suspend_standby_state_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
+static ssize_t suspend_standby_state_show(struct device *dev,
+					  struct device_attribute *attr, char *buf)
 {
 	struct regulator_dev *rdev = dev_get_drvdata(dev);
 
 	return regulator_print_state(buf,
 			rdev->constraints->state_standby.enabled);
 }
-static DEVICE_ATTR(suspend_standby_state, 0444,
-		regulator_suspend_standby_state_show, NULL);
+static DEVICE_ATTR_RO(suspend_standby_state);
 
-static ssize_t regulator_bypass_show(struct device *dev,
-				     struct device_attribute *attr, char *buf)
+static ssize_t bypass_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
 {
 	struct regulator_dev *rdev = dev_get_drvdata(dev);
 	const char *report;
@@ -928,8 +919,7 @@ static ssize_t regulator_bypass_show(struct device *dev,
 
 	return sprintf(buf, "%s\n", report);
 }
-static DEVICE_ATTR(bypass, 0444,
-		   regulator_bypass_show, NULL);
+static DEVICE_ATTR_RO(bypass);
 
 /* Calculate the new optimum regulator operating mode based on the new total
  * consumer load. All locks held by caller
-- 
2.17.1

