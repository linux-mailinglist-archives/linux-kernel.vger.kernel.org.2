Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796F439DDDB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 15:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhFGNma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:42:30 -0400
Received: from m12-17.163.com ([220.181.12.17]:59191 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230207AbhFGNm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=pTa78
        3sBoKjxfjRbRwQN/1Zc1yoVx1pZib+9+2C+uI4=; b=myQtrhL/9CZwcuPQM0k8q
        n59M35z7DQXY+WgKQFlJ2M7qbzVm3g1v/Y3c84O1QpslmAm045mUQGP2E3NWZgte
        AxAYAsbZBh/6x7quUOkzYEaEov1CRBGYsoRlK94WSUrnHGuI7+1DGwov1cQTt1iV
        YQPc+27vEL4+PPyxZOUFaE=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp13 (Coremail) with SMTP id EcCowADX45OVIb5gdpPe5w--.51940S2;
        Mon, 07 Jun 2021 21:39:34 +0800 (CST)
From:   Xuezhi Zhang <llyz108@163.com>
To:     liviu.dudau@arm.com, brian.starkey@arm.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Xuezhi Zhang <zhangxuezhi1@yulong.com>
Subject: [PATCH] drm/malidp: convert sysfs snprintf to sysfs_emit
Date:   Mon,  7 Jun 2021 13:39:31 +0000
Message-Id: <20210607133931.52403-1-llyz108@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowADX45OVIb5gdpPe5w--.51940S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrWfXF1UWFy5tw45uw47twb_yoWfuFb_CF
        10qr47Xr40yw1v9ry7CF4fZryIkFWF9Fs5Xr48ta4SvF4qqrnrZryv9r10qryUJF47AF9r
        A3WkWr45JrnrGjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5aZX5UUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: xoo16iiqy6il2tof0z/1tbiMhaqhVWBuNc9+QAAs0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xuezhi Zhang <zhangxuezhi1@yulong.com>

Fix the following coccicheck warning:
drivers/gpu/drm/arm/malidp_drv.c:657:8-16:
WARNING: use scnprintf or sprintf

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@yulong.com>
---
 drivers/gpu/drm/arm/malidp_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index de59f3302516..d1af23f0704d 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -654,7 +654,7 @@ static ssize_t core_id_show(struct device *dev, struct device_attribute *attr,
 	struct drm_device *drm = dev_get_drvdata(dev);
 	struct malidp_drm *malidp = drm->dev_private;
 
-	return snprintf(buf, PAGE_SIZE, "%08x\n", malidp->core_id);
+	return sysfs_emit(buf, "%08x\n", malidp->core_id);
 }
 
 static DEVICE_ATTR_RO(core_id);
-- 
2.25.1


