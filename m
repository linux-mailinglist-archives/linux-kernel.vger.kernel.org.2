Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5713A30BAA6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbhBBJLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:11:52 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:37935 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232966AbhBBJHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:07:11 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UNfe6ce_1612256773;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UNfe6ce_1612256773)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Feb 2021 17:06:24 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        john.clements@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] drm/amdgpu: convert sysfs sprintf/snprintf family to sysfs_emit
Date:   Tue,  2 Feb 2021 17:06:12 +0800
Message-Id: <1612256772-70147-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

./drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c:220:8-16: WARNING: use
scnprintf or sprintf.

./drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c:249:8-16: WARNING: use
scnprintf or sprintf.

Reported-by: Abaci Robot<abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 541ef6b..2913d57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -186,7 +186,7 @@ static ssize_t amdgpu_xgmi_show_attrs(struct kobject *kobj,
 		kobj, struct amdgpu_hive_info, kobj);
 
 	if (attr == &amdgpu_xgmi_hive_id)
-		return snprintf(buf, PAGE_SIZE, "%llu\n", hive->hive_id);
+		return sysfs_emit(buf, "%llu\n", hive->hive_id);
 
 	return 0;
 }
@@ -217,7 +217,7 @@ static ssize_t amdgpu_xgmi_show_device_id(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", adev->gmc.xgmi.node_id);
+	return sysfs_emit(buf, "%llu\n", adev->gmc.xgmi.node_id);
 
 }
 
@@ -246,7 +246,7 @@ static ssize_t amdgpu_xgmi_show_error(struct device *dev,
 
 	adev->df.funcs->set_fica(adev, ficaa_pie_status_in, 0, 0);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", error_count);
+	return sysfs_emit(buf, "%u\n", error_count);
 }
 
 
-- 
1.8.3.1

