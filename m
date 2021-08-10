Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2173E5891
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239909AbhHJKtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:49:52 -0400
Received: from smtpbgau1.qq.com ([54.206.16.166]:52674 "EHLO smtpbgau1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236505AbhHJKtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:49:49 -0400
X-Greylist: delayed 33956 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Aug 2021 06:49:49 EDT
X-QQ-mid: bizesmtp38t1628592561t3i6idy1
Received: from localhost.localdomain (unknown [124.126.19.250])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 10 Aug 2021 18:49:19 +0800 (CST)
X-QQ-SSF: 0140000000200030C000B00A0000000
X-QQ-FEAT: G6zDt5+RCFLACr9ra9b07AMSF+tXSXWxZrOY4hjm3B28zxywUvx8NsQnG5OWs
        arJeiUYfiB8F1y7m9rXI2FI12dJ1oW2uwMY98Y8uySq6oXO/RrPUU4STU1t0lqoYV5JM7v3
        uF4NsBhglssNWYGsjF0wuUPSytdW9qm7F998ZNraV2LYxbuI49Dr3bj+iYyZ6h25AU7kiPm
        CLG1HziyT8gdVONkKAN1p8ekk7vn5JQW47zhepzL2Vd011/LOHx+BGGuaoGPADQ/v//Ef1h
        rCzp2356lhx1wOJhCXcrjPDBT0c+6b4Xbitmbf1V3jgbxOLSJbR2D0FS1eZ1Ot9e3bLTfrO
        1SgR1/wJgcItukMLDhwz4T0anV8qw==
X-QQ-GoodBg: 2
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH v3] drm/msm: Remove initialization of static variables
Date:   Tue, 10 Aug 2021 18:49:14 +0800
Message-Id: <20210810104914.29419-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Address the following checkpatch errors:
ERROR: do not initialise statics to false

FILE: :drivers/gpu/drm/msm/msm_drv.c:21:
-static bool reglog = false;

FILE: :drivers/gpu/drm/msm/msm_drv.c:31:
-bool dumpstate = false;

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
v3: Subject should start out with drm/msm, not drm/drv 
 drivers/gpu/drm/msm/msm_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 9b8fa2ad0d84..d9ca4bc9620b 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -59,7 +59,7 @@ static const struct drm_mode_config_helper_funcs mode_config_helper_funcs = {
 };
 
 #ifdef CONFIG_DRM_MSM_REGISTER_LOGGING
-static bool reglog = false;
+static bool reglog;
 MODULE_PARM_DESC(reglog, "Enable register read/write logging");
 module_param(reglog, bool, 0600);
 #else
@@ -76,7 +76,7 @@ static char *vram = "16m";
 MODULE_PARM_DESC(vram, "Configure VRAM size (for devices without IOMMU/GPUMMU)");
 module_param(vram, charp, 0);
 
-bool dumpstate = false;
+bool dumpstate;
 MODULE_PARM_DESC(dumpstate, "Dump KMS state on errors");
 module_param(dumpstate, bool, 0600);
 
-- 
2.20.1



