Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A6E39409E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 12:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbhE1KF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 06:05:57 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2513 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236383AbhE1KFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 06:05:49 -0400
Received: from dggeml765-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fs0Zc0dSWzYr67;
        Fri, 28 May 2021 18:01:28 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggeml765-chm.china.huawei.com (10.1.199.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 18:04:08 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 28
 May 2021 18:04:08 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jani.nikula@linux.intel.com>, <joonas.lahtinen@linux.intel.com>,
        <rodrigo.vivi@intel.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <chris@chris-wilson.co.uk>, <tvrtko.ursulin@intel.com>
CC:     <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/i915: use DEVICE_ATTR_RO macro
Date:   Fri, 28 May 2021 18:04:03 +0800
Message-ID: <20210528100403.21548-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR_RO() helper instead of plain DEVICE_ATTR(),
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/i915/i915_pmu.c   |  8 +++-----
 drivers/gpu/drm/i915/i915_sysfs.c | 30 +++++++++++++++---------------
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index 41651ac255fa..fb215929b05b 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -834,15 +834,13 @@ static ssize_t i915_pmu_event_show(struct device *dev,
 	return sprintf(buf, "config=0x%lx\n", eattr->val);
 }
 
-static ssize_t
-i915_pmu_get_attr_cpumask(struct device *dev,
-			  struct device_attribute *attr,
-			  char *buf)
+static ssize_t cpumask_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
 {
 	return cpumap_print_to_pagebuf(true, buf, &i915_pmu_cpumask);
 }
 
-static DEVICE_ATTR(cpumask, 0444, i915_pmu_get_attr_cpumask, NULL);
+static DEVICE_ATTR_RO(cpumask);
 
 static struct attribute *i915_cpumask_attrs[] = {
 	&dev_attr_cpumask.attr,
diff --git a/drivers/gpu/drm/i915/i915_sysfs.c b/drivers/gpu/drm/i915/i915_sysfs.c
index 4c6b5d52b5ca..183517d1a73d 100644
--- a/drivers/gpu/drm/i915/i915_sysfs.c
+++ b/drivers/gpu/drm/i915/i915_sysfs.c
@@ -58,8 +58,8 @@ static u32 calc_residency(struct drm_i915_private *dev_priv,
 	return DIV_ROUND_CLOSEST_ULL(res, 1000);
 }
 
-static ssize_t
-show_rc6_mask(struct device *kdev, struct device_attribute *attr, char *buf)
+static ssize_t rc6_enable_show(struct device *kdev,
+			       struct device_attribute *attr, char *buf)
 {
 	struct drm_i915_private *dev_priv = kdev_minor_to_i915(kdev);
 	unsigned int mask;
@@ -75,43 +75,43 @@ show_rc6_mask(struct device *kdev, struct device_attribute *attr, char *buf)
 	return sysfs_emit(buf, "%x\n", mask);
 }
 
-static ssize_t
-show_rc6_ms(struct device *kdev, struct device_attribute *attr, char *buf)
+static ssize_t rc6_residency_ms_show(struct device *kdev,
+				     struct device_attribute *attr, char *buf)
 {
 	struct drm_i915_private *dev_priv = kdev_minor_to_i915(kdev);
 	u32 rc6_residency = calc_residency(dev_priv, GEN6_GT_GFX_RC6);
 	return sysfs_emit(buf, "%u\n", rc6_residency);
 }
 
-static ssize_t
-show_rc6p_ms(struct device *kdev, struct device_attribute *attr, char *buf)
+static ssize_t rc6p_residency_ms_show(struct device *kdev,
+				      struct device_attribute *attr, char *buf)
 {
 	struct drm_i915_private *dev_priv = kdev_minor_to_i915(kdev);
 	u32 rc6p_residency = calc_residency(dev_priv, GEN6_GT_GFX_RC6p);
 	return sysfs_emit(buf, "%u\n", rc6p_residency);
 }
 
-static ssize_t
-show_rc6pp_ms(struct device *kdev, struct device_attribute *attr, char *buf)
+static ssize_t rc6pp_residency_ms_show(struct device *kdev,
+				       struct device_attribute *attr, char *buf)
 {
 	struct drm_i915_private *dev_priv = kdev_minor_to_i915(kdev);
 	u32 rc6pp_residency = calc_residency(dev_priv, GEN6_GT_GFX_RC6pp);
 	return sysfs_emit(buf, "%u\n", rc6pp_residency);
 }
 
-static ssize_t
-show_media_rc6_ms(struct device *kdev, struct device_attribute *attr, char *buf)
+static ssize_t media_rc6_residency_ms_show(struct device *kdev,
+					   struct device_attribute *attr, char *buf)
 {
 	struct drm_i915_private *dev_priv = kdev_minor_to_i915(kdev);
 	u32 rc6_residency = calc_residency(dev_priv, VLV_GT_MEDIA_RC6);
 	return sysfs_emit(buf, "%u\n", rc6_residency);
 }
 
-static DEVICE_ATTR(rc6_enable, S_IRUGO, show_rc6_mask, NULL);
-static DEVICE_ATTR(rc6_residency_ms, S_IRUGO, show_rc6_ms, NULL);
-static DEVICE_ATTR(rc6p_residency_ms, S_IRUGO, show_rc6p_ms, NULL);
-static DEVICE_ATTR(rc6pp_residency_ms, S_IRUGO, show_rc6pp_ms, NULL);
-static DEVICE_ATTR(media_rc6_residency_ms, S_IRUGO, show_media_rc6_ms, NULL);
+static DEVICE_ATTR_RO(rc6_enable);
+static DEVICE_ATTR_RO(rc6_residency_ms);
+static DEVICE_ATTR_RO(rc6p_residency_ms);
+static DEVICE_ATTR_RO(rc6pp_residency_ms);
+static DEVICE_ATTR_RO(media_rc6_residency_ms);
 
 static struct attribute *rc6_attrs[] = {
 	&dev_attr_rc6_enable.attr,
-- 
2.17.1

