Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D09D393D68
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 09:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhE1HEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 03:04:22 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2510 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhE1HEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 03:04:20 -0400
Received: from dggeml758-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FrwYH17c0zYqSB;
        Fri, 28 May 2021 15:00:03 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggeml758-chm.china.huawei.com (10.1.199.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 15:02:43 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 28
 May 2021 15:02:43 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <Xinhui.Pan@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/radeon/radeon_pm: use DEVICE_ATTR_RW macro
Date:   Fri, 28 May 2021 15:02:17 +0800
Message-ID: <20210528070217.9204-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR_RW() helper instead of plain DEVICE_ATTR(),
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/radeon/radeon_pm.c | 56 ++++++++++++------------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_pm.c b/drivers/gpu/drm/radeon/radeon_pm.c
index 3861c0b98fcf..edf10cc3947e 100644
--- a/drivers/gpu/drm/radeon/radeon_pm.c
+++ b/drivers/gpu/drm/radeon/radeon_pm.c
@@ -352,9 +352,8 @@ static void radeon_pm_print_states(struct radeon_device *rdev)
 	}
 }
 
-static ssize_t radeon_get_pm_profile(struct device *dev,
-				     struct device_attribute *attr,
-				     char *buf)
+static ssize_t power_profile_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct radeon_device *rdev = ddev->dev_private;
@@ -366,10 +365,8 @@ static ssize_t radeon_get_pm_profile(struct device *dev,
 			  (cp == PM_PROFILE_HIGH) ? "high" : "default");
 }
 
-static ssize_t radeon_set_pm_profile(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf,
-				     size_t count)
+static ssize_t power_profile_store(struct device *dev, struct device_attribute *attr,
+				   const char *buf, size_t count)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct radeon_device *rdev = ddev->dev_private;
@@ -406,9 +403,8 @@ static ssize_t radeon_set_pm_profile(struct device *dev,
 	return count;
 }
 
-static ssize_t radeon_get_pm_method(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf)
+static ssize_t power_method_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct radeon_device *rdev = ddev->dev_private;
@@ -418,10 +414,9 @@ static ssize_t radeon_get_pm_method(struct device *dev,
 			  (pm == PM_METHOD_PROFILE) ? "profile" : "dpm");
 }
 
-static ssize_t radeon_set_pm_method(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf,
-				    size_t count)
+static ssize_t power_method_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct radeon_device *rdev = ddev->dev_private;
@@ -462,9 +457,8 @@ static ssize_t radeon_set_pm_method(struct device *dev,
 	return count;
 }
 
-static ssize_t radeon_get_dpm_state(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf)
+static ssize_t power_dpm_state_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct radeon_device *rdev = ddev->dev_private;
@@ -475,10 +469,9 @@ static ssize_t radeon_get_dpm_state(struct device *dev,
 			  (pm == POWER_STATE_TYPE_BALANCED) ? "balanced" : "performance");
 }
 
-static ssize_t radeon_set_dpm_state(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf,
-				    size_t count)
+static ssize_t power_dpm_state_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct radeon_device *rdev = ddev->dev_private;
@@ -506,9 +499,9 @@ static ssize_t radeon_set_dpm_state(struct device *dev,
 	return count;
 }
 
-static ssize_t radeon_get_dpm_forced_performance_level(struct device *dev,
-						       struct device_attribute *attr,
-						       char *buf)
+static ssize_t power_dpm_force_performance_level_show(struct device *dev,
+						      struct device_attribute *attr,
+						      char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct radeon_device *rdev = ddev->dev_private;
@@ -523,10 +516,9 @@ static ssize_t radeon_get_dpm_forced_performance_level(struct device *dev,
 			  (level == RADEON_DPM_FORCED_LEVEL_LOW) ? "low" : "high");
 }
 
-static ssize_t radeon_set_dpm_forced_performance_level(struct device *dev,
+static ssize_t power_dpm_force_performance_level_store(struct device *dev,
 						       struct device_attribute *attr,
-						       const char *buf,
-						       size_t count)
+						       const char *buf, size_t count)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct radeon_device *rdev = ddev->dev_private;
@@ -658,12 +650,10 @@ static ssize_t radeon_hwmon_get_pwm1(struct device *dev,
 	return sprintf(buf, "%i\n", speed);
 }
 
-static DEVICE_ATTR(power_profile, S_IRUGO | S_IWUSR, radeon_get_pm_profile, radeon_set_pm_profile);
-static DEVICE_ATTR(power_method, S_IRUGO | S_IWUSR, radeon_get_pm_method, radeon_set_pm_method);
-static DEVICE_ATTR(power_dpm_state, S_IRUGO | S_IWUSR, radeon_get_dpm_state, radeon_set_dpm_state);
-static DEVICE_ATTR(power_dpm_force_performance_level, S_IRUGO | S_IWUSR,
-		   radeon_get_dpm_forced_performance_level,
-		   radeon_set_dpm_forced_performance_level);
+static DEVICE_ATTR_RW(power_profile);
+static DEVICE_ATTR_RW(power_method);
+static DEVICE_ATTR_RW(power_dpm_state);
+static DEVICE_ATTR_RW(power_dpm_force_performance_level);
 
 static ssize_t radeon_hwmon_show_temp(struct device *dev,
 				      struct device_attribute *attr,
-- 
2.17.1

