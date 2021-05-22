Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D114C38D50D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 12:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhEVKT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 06:19:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3911 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhEVKT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 06:19:58 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FnK9p5WvPzBvPp;
        Sat, 22 May 2021 18:15:42 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 18:18:31 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500008.china.huawei.com (7.185.36.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 18:18:31 +0800
From:   Hao Fang <fanghao11@huawei.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>
CC:     <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
        <john.stultz@linaro.org>, <kong.kongxinwei@hisilicon.com>,
        <linux-kernel@vger.kernel.org>, <prime.zeng@hisilicon.com>,
        <fanghao11@huawei.com>
Subject: [PATCH RESEND] drm/hisilicon/kirin: Use the correct HiSilicon copyright
Date:   Sat, 22 May 2021 18:15:29 +0800
Message-ID: <1621678529-14389-1-git-send-email-fanghao11@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/Hisilicon/HiSilicon/.
It should use capital S, according to
https://www.hisilicon.com/en.

Signed-off-by: Hao Fang <fanghao11@huawei.com>
Acked-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c    | 2 +-
 drivers/gpu/drm/hisilicon/kirin/dw_dsi_reg.h    | 2 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h | 2 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 2 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 2 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

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
index 6dcf9ec..1ab9462 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -3,7 +3,7 @@
  * Hisilicon Hi6220 SoC ADE(Advanced Display Engine)'s crtc&plane driver
  *
  * Copyright (c) 2016 Linaro Limited.
- * Copyright (c) 2014-2016 Hisilicon Limited.
+ * Copyright (c) 2014-2016 HiSilicon Limited.
  *
  * Author:
  *	Xinliang Liu <z.liuxinliang@hisilicon.com>
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 4349da3..e590e19 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -3,7 +3,7 @@
  * Hisilicon Kirin SoCs drm master driver
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

