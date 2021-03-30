Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EC734E171
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 08:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhC3GqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 02:46:10 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15814 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhC3Gpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 02:45:45 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F8fzZ463tz93c2;
        Tue, 30 Mar 2021 14:43:38 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Tue, 30 Mar 2021 14:45:35 +0800
From:   Hao Fang <fanghao11@huawei.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>
CC:     <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
        <john.stultz@linaro.org>, <kong.kongxinwei@hisilicon.com>,
        <puck.chen@hisilicon.com>, <linux-kernel@vger.kernel.org>,
        <prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
Subject: [PATCH] drm/hisilicon/kirin: Use the correct HiSilicon copyright
Date:   Tue, 30 Mar 2021 14:43:02 +0800
Message-ID: <1617086582-8688-1-git-send-email-fanghao11@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/Hisilicon/HiSilicon/g.
It should use capital S, according to
https://www.hisilicon.com/en/terms-of-use.

Signed-off-by: Hao Fang <fanghao11@huawei.com>
---
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c    | 2 +-
 drivers/gpu/drm/hisilicon/kirin/dw_dsi_reg.h    | 2 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h | 2 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 6 +++---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 4 ++--
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
index 00e87c2..9b565a0 100644
--- a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
+++ b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
@@ -3,7 +3,7 @@
  * DesignWare MIPI DSI Host Controller v1.02 driver
  *
  * Copyright (c) 2016 Linaro Limited.
- * Copyright (c) 2014-2016 Hisilicon Limited.
+ * Copyright (c) 2014-2016 HiSilicon Limited.
  *
  * Author:
  *	Xinliang Liu <z.liuxinliang@hisilicon.com>
diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_dsi_reg.h b/drivers/gpu/drm/hisilicon/kirin/dw_dsi_reg.h
index 19e81ff..d79fc03 100644
--- a/drivers/gpu/drm/hisilicon/kirin/dw_dsi_reg.h
+++ b/drivers/gpu/drm/hisilicon/kirin/dw_dsi_reg.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (c) 2016 Linaro Limited.
- * Copyright (c) 2014-2016 Hisilicon Limited.
+ * Copyright (c) 2014-2016 HiSilicon Limited.
  */
 
 #ifndef __DW_DSI_REG_H__
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h b/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
index e2ac098..be9e789 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (c) 2016 Linaro Limited.
- * Copyright (c) 2014-2016 Hisilicon Limited.
+ * Copyright (c) 2014-2016 HiSilicon Limited.
  */
 
 #ifndef __KIRIN_ADE_REG_H__
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index aa6c53f..20f2c2a 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Hisilicon Hi6220 SoC ADE(Advanced Display Engine)'s crtc&plane driver
+ * HiSilicon Hi6220 SoC ADE(Advanced Display Engine)'s crtc&plane driver
  *
  * Copyright (c) 2016 Linaro Limited.
- * Copyright (c) 2014-2016 Hisilicon Limited.
+ * Copyright (c) 2014-2016 HiSilicon Limited.
  *
  * Author:
  *	Xinliang Liu <z.liuxinliang@hisilicon.com>
@@ -923,7 +923,7 @@ static const struct drm_driver ade_driver = {
 	.fops = &ade_fops,
 	DRM_GEM_CMA_DRIVER_OPS,
 	.name = "kirin",
-	.desc = "Hisilicon Kirin620 SoC DRM Driver",
+	.desc = "HiSilicon Kirin620 SoC DRM Driver",
 	.date = "20150718",
 	.major = 1,
 	.minor = 0,
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 4349da3..046798c 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Hisilicon Kirin SoCs drm master driver
+ * HiSilicon Kirin SoCs drm master driver
  *
  * Copyright (c) 2016 Linaro Limited.
- * Copyright (c) 2014-2016 Hisilicon Limited.
+ * Copyright (c) 2014-2016 HiSilicon Limited.
  *
  * Author:
  *	Xinliang Liu <z.liuxinliang@hisilicon.com>
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
index 386d137..db0dc7b 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (c) 2016 Linaro Limited.
- * Copyright (c) 2014-2016 Hisilicon Limited.
+ * Copyright (c) 2014-2016 HiSilicon Limited.
  */
 
 #ifndef __KIRIN_DRM_DRV_H__
-- 
2.8.1

