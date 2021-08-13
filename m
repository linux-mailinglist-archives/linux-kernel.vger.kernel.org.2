Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8663EB713
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 16:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240903AbhHMOxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 10:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240915AbhHMOxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:53:43 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AFEC061756;
        Fri, 13 Aug 2021 07:53:17 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso20987672pjb.2;
        Fri, 13 Aug 2021 07:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E455nQV9HLyqLM+MacGIncFDmfddwYhQ46Kp4bapbdA=;
        b=pKJlHtYS0XJMAzSx444LQqTIQ3zT5LlDeUlBAxzG/M/9FDEXJ11qM8isyY9Vtu0x+w
         GA6JyxNrJjTIsbQN68NlvI5xocxcPE4Vep8vRAdC9Lw6PHQ1BdWjNd/fZuWVda4K2Kkw
         ugzxZsDh0fgq4vZUCUwqhNWsgp4azSTIYhUx1UD5WcG2Sy4cYzB74Gusag6I8YlQdm9j
         4uIsOHDhYHElxdALsOktZKvqEg+478t00yJV47aHNEKC425JMAQGStqN8npeWofQyung
         vO1Ntd9Mfjlzm0hL+kwZqayWIX1Pz+QDMwmEZ9gI45OVkliznq9jXKsClF/KkRheoU6U
         SyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E455nQV9HLyqLM+MacGIncFDmfddwYhQ46Kp4bapbdA=;
        b=jLeBBz70A+b0wU7SHsHELF5JUYTy9QCf1YZha4Zj5TVd27fOOmMuUqan6RVlPpne8W
         kxHIe5JprjKOlBOf4ZVnZONPRhru55izM+1hoLQKmeeE81nHT3CeFV7c8YFMI85Z0x3y
         KdhPzFg05u/VQ4DaTL/KRPb3ufC1WqBYs3BhcAB7FQ6igXv+qzk1iSIKiaSc9H4JnsSC
         pfu1ole/tTpgQlVCG2+eqIb05XA47Gs4VRUNnyF9mOQdU9+JUrbPx9nr2TMeAs8RDaDB
         ZfeamER92SmPxyeEzA+NNFs9+AIAaIULHcLc3OyAdU02/sFxVKa0yb6jyli9xygvJM9/
         QcCw==
X-Gm-Message-State: AOAM532dxz3lHeq1l9TIN1/jb6xcT8vq62+g5G684bGQxUiKJB8rJmjj
        /YToXzzf3chSwI8ufT9k/TU=
X-Google-Smtp-Source: ABdhPJzeYivNHCfPWEKFl6M2Pivxmkk6bDPGYw6VwAOqMoxFOD1oF9Z4nw/a+210VcrVNwH5SbsL1A==
X-Received: by 2002:a17:902:aa43:b029:12d:242f:32eb with SMTP id c3-20020a170902aa43b029012d242f32ebmr2420490plr.66.1628866396549;
        Fri, 13 Aug 2021 07:53:16 -0700 (PDT)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e12sm2524787pfc.214.2021.08.13.07.53.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Aug 2021 07:53:16 -0700 (PDT)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com,
        pony1.wu@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 2/6] drm/sprd: add Unisoc's drm kms master
Date:   Fri, 13 Aug 2021 22:52:58 +0800
Message-Id: <20210813145302.3933-3-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210813145302.3933-1-kevin3.tang@gmail.com>
References: <20210813145302.3933-1-kevin3.tang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds drm support for the Unisoc's display subsystem.

This is drm kms driver, this driver provides support for the
application framework in Android, Yocto and more.

Application framework can access Unisoc's display internal
peripherals through libdrm or libkms, it's test ok by modetest
(DRM/KMS test tool) and Android HWComposer.

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>

v4:
  - Move the devm_drm_dev_alloc to master_ops->bind function.
  - The managed drmm_mode_config_init() it is no longer necessary for drivers to explicitly call drm_mode_config_cleanup, so delete it.

v5:
  - Remove subdir-ccflgas-y for Makefile.
  - Keep the selects sorted by alphabet for Kconfig.
---
 drivers/gpu/drm/Kconfig         |   2 +
 drivers/gpu/drm/Makefile        |   1 +
 drivers/gpu/drm/sprd/Kconfig    |  11 ++
 drivers/gpu/drm/sprd/Makefile   |   3 +
 drivers/gpu/drm/sprd/sprd_drm.c | 205 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/sprd/sprd_drm.h |  16 +++
 6 files changed, 238 insertions(+)
 create mode 100644 drivers/gpu/drm/sprd/Kconfig
 create mode 100644 drivers/gpu/drm/sprd/Makefile
 create mode 100644 drivers/gpu/drm/sprd/sprd_drm.c
 create mode 100644 drivers/gpu/drm/sprd/sprd_drm.h

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 3c16bd1af..a92525445 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -386,6 +386,8 @@ source "drivers/gpu/drm/xlnx/Kconfig"
 
 source "drivers/gpu/drm/gud/Kconfig"
 
+source "drivers/gpu/drm/sprd/Kconfig"
+
 # Keep legacy drivers last
 
 menuconfig DRM_LEGACY
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 5279db439..03a52d1dc 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -126,3 +126,4 @@ obj-$(CONFIG_DRM_MCDE) += mcde/
 obj-$(CONFIG_DRM_TIDSS) += tidss/
 obj-y			+= xlnx/
 obj-y			+= gud/
+obj-$(CONFIG_DRM_SPRD) += sprd/
diff --git a/drivers/gpu/drm/sprd/Kconfig b/drivers/gpu/drm/sprd/Kconfig
new file mode 100644
index 000000000..726c3e76d
--- /dev/null
+++ b/drivers/gpu/drm/sprd/Kconfig
@@ -0,0 +1,11 @@
+config DRM_SPRD
+	tristate "DRM Support for Unisoc SoCs Platform"
+	depends on ARCH_SPRD || COMPILE_TEST
+	depends on DRM && OF
+	select DRM_GEM_CMA_HELPER
+	select DRM_KMS_CMA_HELPER
+	select DRM_KMS_HELPER
+	help
+	  Choose this option if you have a Unisoc chipset.
+	  If M is selected the module will be called sprd_drm.
+
diff --git a/drivers/gpu/drm/sprd/Makefile b/drivers/gpu/drm/sprd/Makefile
new file mode 100644
index 000000000..9850f00b8
--- /dev/null
+++ b/drivers/gpu/drm/sprd/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y := sprd_drm.o
diff --git a/drivers/gpu/drm/sprd/sprd_drm.c b/drivers/gpu/drm/sprd/sprd_drm.c
new file mode 100644
index 000000000..6b00a6f27
--- /dev/null
+++ b/drivers/gpu/drm/sprd/sprd_drm.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Unisoc Inc.
+ */
+
+#include <linux/component.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_graph.h>
+#include <linux/of_platform.h>
+
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_of.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_vblank.h>
+
+#include "sprd_drm.h"
+
+#define DRIVER_NAME	"sprd"
+#define DRIVER_DESC	"Spreadtrum SoCs' DRM Driver"
+#define DRIVER_DATE	"20200201"
+#define DRIVER_MAJOR	1
+#define DRIVER_MINOR	0
+
+static const struct drm_mode_config_helper_funcs sprd_drm_mode_config_helper = {
+	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
+};
+
+static const struct drm_mode_config_funcs sprd_drm_mode_config_funcs = {
+	.fb_create = drm_gem_fb_create,
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit,
+};
+
+static void sprd_drm_mode_config_init(struct drm_device *drm)
+{
+	drm->mode_config.min_width = 0;
+	drm->mode_config.min_height = 0;
+	drm->mode_config.max_width = 8192;
+	drm->mode_config.max_height = 8192;
+	drm->mode_config.allow_fb_modifiers = true;
+
+	drm->mode_config.funcs = &sprd_drm_mode_config_funcs;
+	drm->mode_config.helper_private = &sprd_drm_mode_config_helper;
+}
+
+DEFINE_DRM_GEM_CMA_FOPS(sprd_drm_fops);
+
+static struct drm_driver sprd_drm_drv = {
+	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
+	.fops			= &sprd_drm_fops,
+
+	/* GEM Operations */
+	DRM_GEM_CMA_DRIVER_OPS,
+
+	.name			= DRIVER_NAME,
+	.desc			= DRIVER_DESC,
+	.date			= DRIVER_DATE,
+	.major			= DRIVER_MAJOR,
+	.minor			= DRIVER_MINOR,
+};
+
+static int sprd_drm_bind(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct drm_device *drm;
+	struct sprd_drm *sprd;
+	int ret;
+
+	sprd = devm_drm_dev_alloc(dev, &sprd_drm_drv, struct sprd_drm, drm);
+	if (IS_ERR(sprd))
+		return PTR_ERR(sprd);
+
+	drm = &sprd->drm;
+	platform_set_drvdata(pdev, drm);
+
+	ret = drmm_mode_config_init(drm);
+	if (ret)
+		return ret;
+
+	sprd_drm_mode_config_init(drm);
+
+	/* bind and init sub drivers */
+	ret = component_bind_all(drm->dev, drm);
+	if (ret) {
+		drm_err(drm, "failed to bind all component.\n");
+		return ret;
+	}
+
+	/* vblank init */
+	ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
+	if (ret) {
+		drm_err(drm, "failed to initialize vblank.\n");
+		goto err_unbind_all;
+	}
+	/* with irq_enabled = true, we can use the vblank feature. */
+	drm->irq_enabled = true;
+
+	/* reset all the states of crtc/plane/encoder/connector */
+	drm_mode_config_reset(drm);
+
+	/* init kms poll for handling hpd */
+	drm_kms_helper_poll_init(drm);
+
+	ret = drm_dev_register(drm, 0);
+	if (ret < 0)
+		goto err_kms_helper_poll_fini;
+
+	return 0;
+
+err_kms_helper_poll_fini:
+	drm_kms_helper_poll_fini(drm);
+err_unbind_all:
+	component_unbind_all(drm->dev, drm);
+	return ret;
+}
+
+static void sprd_drm_unbind(struct device *dev)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+
+	drm_dev_unregister(drm);
+
+	drm_kms_helper_poll_fini(drm);
+
+	component_unbind_all(drm->dev, drm);
+}
+
+static const struct component_master_ops drm_component_ops = {
+	.bind = sprd_drm_bind,
+	.unbind = sprd_drm_unbind,
+};
+
+static int compare_of(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
+static int sprd_drm_probe(struct platform_device *pdev)
+{
+	return drm_of_component_probe(&pdev->dev, compare_of, &drm_component_ops);
+}
+
+static int sprd_drm_remove(struct platform_device *pdev)
+{
+	component_master_del(&pdev->dev, &drm_component_ops);
+	return 0;
+}
+
+static void sprd_drm_shutdown(struct platform_device *pdev)
+{
+	struct drm_device *drm = platform_get_drvdata(pdev);
+
+	if (!drm) {
+		drm_warn(drm, "drm device is not available, no shutdown\n");
+		return;
+	}
+
+	drm_atomic_helper_shutdown(drm);
+}
+
+static const struct of_device_id drm_match_table[] = {
+	{ .compatible = "sprd,display-subsystem", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, drm_match_table);
+
+static struct platform_driver sprd_drm_driver = {
+	.probe = sprd_drm_probe,
+	.remove = sprd_drm_remove,
+	.shutdown = sprd_drm_shutdown,
+	.driver = {
+		.name = "sprd-drm-drv",
+		.of_match_table = drm_match_table,
+	},
+};
+
+static struct platform_driver *sprd_drm_drivers[]  = {
+	&sprd_drm_driver,
+};
+
+static int __init sprd_drm_init(void)
+{
+	return platform_register_drivers(sprd_drm_drivers,
+					ARRAY_SIZE(sprd_drm_drivers));
+}
+
+static void __exit sprd_drm_exit(void)
+{
+	platform_unregister_drivers(sprd_drm_drivers,
+				    ARRAY_SIZE(sprd_drm_drivers));
+}
+
+module_init(sprd_drm_init);
+module_exit(sprd_drm_exit);
+
+MODULE_AUTHOR("Leon He <leon.he@unisoc.com>");
+MODULE_AUTHOR("Kevin Tang <kevin.tang@unisoc.com>");
+MODULE_DESCRIPTION("Unisoc DRM KMS Master Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/gpu/drm/sprd/sprd_drm.h b/drivers/gpu/drm/sprd/sprd_drm.h
new file mode 100644
index 000000000..9781fd591
--- /dev/null
+++ b/drivers/gpu/drm/sprd/sprd_drm.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Unisoc Inc.
+ */
+
+#ifndef _SPRD_DRM_H_
+#define _SPRD_DRM_H_
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_print.h>
+
+struct sprd_drm {
+	struct drm_device drm;
+};
+
+#endif /* _SPRD_DRM_H_ */
-- 
2.29.0

