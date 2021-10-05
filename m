Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD01422A49
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbhJEOMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:12:54 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:54991 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234170AbhJEOMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1633443062; x=1664979062;
  h=from:to:cc:subject:date:message-id;
  bh=cWnKOg8r6C/fFZOvhLtC59xTSJGhJiS1xNWLXoHO2TQ=;
  b=ALKFp7oTzBG/RNhgKsTjQFf8M+HyuDBe+mAR/8MRV7nS4zpdGekkTcJW
   OyiASyxGrRWb0Kr2R9xPLme2wJ2IoHXGLyIcWk7+uMPgCMKaQMqwQshfC
   KkFufCiRxRJdODkxcwCa9BQ8SQwfmLemKQFWvws9Gcne5XiuQQvT1tr2H
   NxLerAIpfNEX6gQqZfsxjrpefHah9HsNbhzA63aDSprNCjw3CAfho9Eqc
   L9kW0ZyitmSbQVBBUEt1NMkbxjptOiZ1Q4H9I+T9mHhs+MNoIH4VvFA06
   7Fc+IPifdJNhJO4Goo1yEQUYgYAG+ekUh1V4TTSW+/kcNUd3b99Dofd9w
   A==;
X-IronPort-AV: E=Sophos;i="5.85,349,1624312800"; 
   d="scan'208";a="19875743"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 05 Oct 2021 16:11:01 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 05 Oct 2021 16:11:01 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 05 Oct 2021 16:11:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1633443061; x=1664979061;
  h=from:to:cc:subject:date:message-id;
  bh=cWnKOg8r6C/fFZOvhLtC59xTSJGhJiS1xNWLXoHO2TQ=;
  b=g9aRSx+gE9xbAgsy6F4R5hD5+jPtUDFVHRWsQJ1RBP60/qK29/pKNnnu
   DOK9SNFluc63DL8rHdPQnvO+H4oqhuL7DqJNWgFv+R6yXDg2L4ygsKEqG
   PMkfsy+cuH673zBILjQIimeiD0AlMSINS0rZl1PooGOs/86dVPDng6PgD
   O0W92WsJTEKEFcymSUgXYnOzgjaslpRJmnIgedzzZ1hS6Lxs6D0t0tzX2
   Yxu5XraXEvXRY8tkq55CUR/WSLaS6h8S5XCxY9D8T0lWyw74Le9ttZnH9
   BEyWWeoOQqm4RaltNPNvmJs4UXmCwBErOtuRWvWeUsStGNTSVXaQ8EnAs
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,349,1624312800"; 
   d="scan'208";a="19875742"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 05 Oct 2021 16:11:01 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 937D5280065;
        Tue,  5 Oct 2021 16:11:01 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2] drm: fsl-dcu: enable PIXCLK on LS1021A
Date:   Tue,  5 Oct 2021 16:10:41 +0200
Message-Id: <20211005141041.2988-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PIXCLK needs to be enabled in SCFG before accessing the DCU on LS1021A,
or the access will hang.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2:
- rebase
- remove unnecessary argument of fsl_dcu_scfg_config_ls1021a()


 drivers/gpu/drm/fsl-dcu/Kconfig           |  1 +
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 25 +++++++++++++++++++++++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h |  3 +++
 3 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/fsl-dcu/Kconfig b/drivers/gpu/drm/fsl-dcu/Kconfig
index d7dd8ba90e3a..9e5a35e7c00c 100644
--- a/drivers/gpu/drm/fsl-dcu/Kconfig
+++ b/drivers/gpu/drm/fsl-dcu/Kconfig
@@ -8,6 +8,7 @@ config DRM_FSL_DCU
 	select DRM_PANEL
 	select REGMAP_MMIO
 	select VIDEOMODE_HELPERS
+	select MFD_SYSCON if SOC_LS1021A
 	help
 	  Choose this option if you have an Freescale DCU chipset.
 	  If M is selected the module will be called fsl-dcu-drm.
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index 660fe573db96..b6b1cb75fc41 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -50,6 +50,23 @@ static const struct regmap_config fsl_dcu_regmap_config = {
 	.volatile_reg = fsl_dcu_drm_is_volatile_reg,
 };
 
+static int fsl_dcu_scfg_config_ls1021a(void)
+{
+	struct regmap *scfg;
+
+	scfg = syscon_regmap_lookup_by_compatible("fsl,ls1021a-scfg");
+	if (IS_ERR(scfg))
+		return PTR_ERR(scfg);
+
+	/*
+	 * For simplicity, enable the PIXCLK unconditionally. It might
+	 * be possible to disable the clock in PM or on unload as a future
+	 * improvement.
+	 */
+	return regmap_update_bits(scfg, SCFG_PIXCLKCR, SCFG_PIXCLKCR_PXCEN,
+				  SCFG_PIXCLKCR_PXCEN);
+}
+
 static void fsl_dcu_irq_reset(struct drm_device *dev)
 {
 	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
@@ -108,6 +125,14 @@ static int fsl_dcu_load(struct drm_device *dev, unsigned long flags)
 		return ret;
 	}
 
+	if (of_device_is_compatible(fsl_dev->np, "fsl,ls1021a-dcu")) {
+		ret = fsl_dcu_scfg_config_ls1021a();
+		if (ret < 0) {
+			dev_err(dev->dev, "failed to enable pixclk\n");
+			goto done_vblank;
+		}
+	}
+
 	ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
 	if (ret < 0) {
 		dev_err(dev->dev, "failed to initialize vblank\n");
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
index e2049a0e8a92..566396013c04 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
@@ -160,6 +160,9 @@
 #define FSL_DCU_ARGB4444		12
 #define FSL_DCU_YUV422			14
 
+#define SCFG_PIXCLKCR			0x28
+#define SCFG_PIXCLKCR_PXCEN		BIT(31)
+
 #define VF610_LAYER_REG_NUM		9
 #define LS1021A_LAYER_REG_NUM		10
 
-- 
2.17.1

