Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F04E31D8E5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 12:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbhBQLzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 06:55:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:34034 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232435AbhBQLtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 06:49:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7D7EB80D;
        Wed, 17 Feb 2021 11:48:32 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eric Anholt <eric@anholt.net>
Cc:     f.fainelli@gmail.com, linux-rpi-kernel@lists.infradead.org,
        phil@raspberrypi.com, wahrenst@gmx.net,
        bcm-kernel-feedback-list@broadcom.com, mripard@kernel.org,
        robh@kernel.org, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v3 12/15] drm/v3d: Add support for bcm2711
Date:   Wed, 17 Feb 2021 12:48:07 +0100
Message-Id: <20210217114811.22069-13-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210217114811.22069-1-nsaenzjulienne@suse.de>
References: <20210217114811.22069-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string and Kconfig options for bcm2711.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/gpu/drm/v3d/Kconfig   | 2 +-
 drivers/gpu/drm/v3d/v3d_drv.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/Kconfig b/drivers/gpu/drm/v3d/Kconfig
index 9a5c44606337..b0e048697964 100644
--- a/drivers/gpu/drm/v3d/Kconfig
+++ b/drivers/gpu/drm/v3d/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config DRM_V3D
 	tristate "Broadcom V3D 3.x and newer"
-	depends on ARCH_BCM || ARCH_BCMSTB || COMPILE_TEST
+	depends on ARCH_BCM || ARCH_BCMSTB || ARCH_BCM2835 || COMPILE_TEST
 	depends on DRM
 	depends on COMMON_CLK
 	depends on MMU
diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index 7a3336443a12..1504b6f84441 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -184,6 +184,7 @@ static const struct drm_driver v3d_drm_driver = {
 static const struct of_device_id v3d_of_match[] = {
 	{ .compatible = "brcm,7268-v3d" },
 	{ .compatible = "brcm,7278-v3d" },
+	{ .compatible = "brcm,bcm2711-v3d" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, v3d_of_match);
-- 
2.30.0

