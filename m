Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4582439B479
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 10:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhFDICS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 04:02:18 -0400
Received: from mail.loongson.cn ([114.242.206.163]:37218 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229955AbhFDICP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 04:02:15 -0400
Received: from li-pc.loongson.cn (unknown [10.20.41.133])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxYOJ23blguu8JAA--.10063S4;
        Fri, 04 Jun 2021 15:59:52 +0800 (CST)
From:   lichenyang <lichenyang@loongson.cn>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH 3/3] drm/loongson: Add interrupt driver for LS7A
Date:   Fri,  4 Jun 2021 15:59:31 +0800
Message-Id: <20210604075931.306636-3-lichenyang@loongson.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604075931.306636-1-lichenyang@loongson.cn>
References: <20210604075931.306636-1-lichenyang@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9BxYOJ23blguu8JAA--.10063S4
X-Coremail-Antispam: 1UD129KBjvJXoW3AFy3KryrKFy8GFW5GFyfZwb_yoWDGw15pr
        sxAa4F9r45tF47uwn5AFZ5Ar13C3yfKas7WFZrG34akryktw1UXa4rCFW7JF47Zry7Jw4a
        qryxGFWrCF1Uu3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Eb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv
        6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
        02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
        4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK6svPMxAIw28IcxkI7VAKI4
        8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
        wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjx
        v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
        Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
        AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5N_-PUUUUU==
X-CM-SenderInfo: xolfxvxq1d0wo6or00hjvr0hdfq/1tbiAQACA13QvNXwUQABsE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LS7A DC vsync interrupt enable and close function, and
register irq_handler function interface.
Add vbrank event processing flow.

Signed-off-by: lichenyang <lichenyang@loongson.cn>
---
 drivers/gpu/drm/loongson/Makefile        |   3 +-
 drivers/gpu/drm/loongson/loongson_crtc.c |  43 +++++++++-
 drivers/gpu/drm/loongson/loongson_drv.c  |   8 ++
 drivers/gpu/drm/loongson/loongson_drv.h  |  17 +++-
 drivers/gpu/drm/loongson/loongson_irq.c  | 105 +++++++++++++++++++++++
 5 files changed, 170 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpu/drm/loongson/loongson_irq.c

diff --git a/drivers/gpu/drm/loongson/Makefile b/drivers/gpu/drm/loongson/Makefile
index 773b806e99a2..cc50b65c7e03 100644
--- a/drivers/gpu/drm/loongson/Makefile
+++ b/drivers/gpu/drm/loongson/Makefile
@@ -11,5 +11,6 @@ loongson-y := loongson_drv.o \
 	loongson_device.o \
 	loongson_connector.o \
 	loongson_encoder.o \
-	loongson_i2c.o
+	loongson_i2c.o \
+	loongson_irq.o
 obj-$(CONFIG_DRM_LOONGSON) += loongson.o
diff --git a/drivers/gpu/drm/loongson/loongson_crtc.c b/drivers/gpu/drm/loongson/loongson_crtc.c
index 4cb65fa08778..4c62d5b2bd56 100644
--- a/drivers/gpu/drm/loongson/loongson_crtc.c
+++ b/drivers/gpu/drm/loongson/loongson_crtc.c
@@ -154,19 +154,25 @@ static void loongson_crtc_mode_set_nofb(struct drm_crtc *crtc)
 }
 
 static void loongson_crtc_atomic_enable(struct drm_crtc *crtc,
-					struct drm_atomic_state *old_state)
+					struct drm_atomic_state *old_crtc_state)
 {
 	struct drm_device *dev = crtc->dev;
 	struct loongson_device *ldev = dev->dev_private;
 	struct loongson_crtc *lcrtc = to_loongson_crtc(crtc);
 	u32 reg_offset = lcrtc->reg_offset;
 
+	if (lcrtc->cfg_reg & CFG_ENABLE)
+		goto vblank_on;
+
 	lcrtc->cfg_reg |= CFG_ENABLE;
 	ls7a_mm_wreg(ldev, FB_CFG_REG + reg_offset, lcrtc->cfg_reg);
+
+vblank_on:
+	drm_crtc_vblank_on(crtc);
 }
 
 static void loongson_crtc_atomic_disable(struct drm_crtc *crtc,
-					 struct drm_atomic_state *old_state)
+					 struct drm_atomic_state *old_crtc_state)
 {
 	struct drm_device *dev = crtc->dev;
 	struct loongson_device *ldev = dev->dev_private;
@@ -175,10 +181,36 @@ static void loongson_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	lcrtc->cfg_reg &= ~CFG_ENABLE;
 	ls7a_mm_wreg(ldev, FB_CFG_REG + reg_offset, lcrtc->cfg_reg);
+
+	spin_lock_irq(&crtc->dev->event_lock);
+	if (crtc->state->event) {
+		drm_crtc_send_vblank_event(crtc, crtc->state->event);
+		crtc->state->event = NULL;
+	}
+	spin_unlock_irq(&crtc->dev->event_lock);
+
+	drm_crtc_vblank_off(crtc);
+}
+
+static void loongson_crtc_atomic_flush(struct drm_crtc *crtc,
+				       struct drm_crtc_state *old_crtc_state)
+{
+	struct drm_pending_vblank_event *event = crtc->state->event;
+
+	if (event) {
+		crtc->state->event = NULL;
+
+		spin_lock_irq(&crtc->dev->event_lock);
+		if (drm_crtc_vblank_get(crtc) == 0)
+			drm_crtc_arm_vblank_event(crtc, event);
+		else
+			drm_crtc_send_vblank_event(crtc, event);
+		spin_unlock_irq(&crtc->dev->event_lock);
+	}
 }
 
 static enum drm_mode_status loongson_mode_valid(struct drm_crtc *crtc,
-						const struct drm_display_mode *mode)
+		const struct drm_display_mode *mode)
 {
 	if (mode->hdisplay > 1920)
 		return MODE_BAD;
@@ -194,9 +226,10 @@ static enum drm_mode_status loongson_mode_valid(struct drm_crtc *crtc,
 
 static const struct drm_crtc_helper_funcs loongson_crtc_helper_funcs = {
 	.mode_valid = loongson_mode_valid,
+	.mode_set_nofb = loongson_crtc_mode_set_nofb,
+	.atomic_flush = loongson_crtc_atomic_flush,
 	.atomic_enable = loongson_crtc_atomic_enable,
 	.atomic_disable = loongson_crtc_atomic_disable,
-	.mode_set_nofb = loongson_crtc_mode_set_nofb,
 };
 
 static const struct drm_crtc_funcs loongson_crtc_funcs = {
@@ -206,6 +239,8 @@ static const struct drm_crtc_funcs loongson_crtc_funcs = {
 	.destroy = drm_crtc_cleanup,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+	.enable_vblank = loongson_crtc_enable_vblank,
+	.disable_vblank = loongson_crtc_disable_vblank,
 };
 
 int loongson_crtc_init(struct loongson_device *ldev, int index)
diff --git a/drivers/gpu/drm/loongson/loongson_drv.c b/drivers/gpu/drm/loongson/loongson_drv.c
index 252be9e25aff..89450c8c9102 100644
--- a/drivers/gpu/drm/loongson/loongson_drv.c
+++ b/drivers/gpu/drm/loongson/loongson_drv.c
@@ -167,6 +167,10 @@ static int loongson_drm_load(struct drm_device *dev, unsigned long flags)
 	if (ret)
 		dev_err(dev->dev, "Fatal error during modeset init: %d\n", ret);
 
+	ret = loongson_irq_init(ldev);
+	if (ret)
+		dev_err(dev->dev, "Fatal error during irq init: %d\n", ret);
+
 	drm_kms_helper_poll_init(dev);
 	drm_mode_config_reset(dev);
 
@@ -192,6 +196,10 @@ static struct drm_driver loongson_drm_driver = {
 	.fops = &fops,
 	DRM_GEM_VRAM_DRIVER,
 
+	.irq_handler = loongson_irq_handler,
+	.irq_preinstall = loongson_irq_preinstall,
+	.irq_uninstall = loongson_irq_uninstall,
+
 	.name = DRIVER_NAME,
 	.desc = DRIVER_DESC,
 	.date = DRIVER_DATE,
diff --git a/drivers/gpu/drm/loongson/loongson_drv.h b/drivers/gpu/drm/loongson/loongson_drv.h
index 24a534c3c79c..60f5bd48f7f2 100644
--- a/drivers/gpu/drm/loongson/loongson_drv.h
+++ b/drivers/gpu/drm/loongson/loongson_drv.h
@@ -4,9 +4,11 @@
 #define __LOONGSON_DRV_H__
 
 #include <drm/drm_drv.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_vblank.h>
 #include <drm/drm_gem.h>
+#include <drm/drm_irq.h>
 #include <drm/drm_fb_helper.h>
-#include <drm/drm_fourcc.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
@@ -49,6 +51,7 @@
 #define FB_HSYNC_REG (0x1420)
 #define FB_VDISPLAY_REG (0x1480)
 #define FB_VSYNC_REG (0x14a0)
+#define FB_INT_REG (0x1570)
 
 #define CFG_FMT GENMASK(2, 0)
 #define CFG_FBSWITCH BIT(7)
@@ -60,6 +63,10 @@
 #define FB_PANCFG_DEF 0x80001311
 #define FB_HSYNC_PULSE (1 << 30)
 #define FB_VSYNC_PULSE (1 << 30)
+#define FB_VSYNC1_ENABLE (1 << 16)
+#define FB_VSYNC0_ENABLE (1 << 18)
+#define FB_VSYNC1_INT (1 << 0)
+#define FB_VSYNC0_INT (1 << 2)
 
 /* PIX PLL */
 #define LOOPC_MIN 24
@@ -136,6 +143,14 @@ int loongson_encoder_init(struct loongson_device *ldev, int index);
 /* plane */
 int loongson_plane_init(struct loongson_crtc *lcrtc);
 
+/* irq */
+int loongson_irq_init(struct loongson_device *ldev);
+int loongson_crtc_enable_vblank(struct drm_crtc *crtc);
+void loongson_crtc_disable_vblank(struct drm_crtc *crtc);
+irqreturn_t loongson_irq_handler(int irq, void *arg);
+void loongson_irq_preinstall(struct drm_device *dev);
+void loongson_irq_uninstall(struct drm_device *dev);
+
 /* i2c */
 int loongson_dc_gpio_init(struct loongson_device *ldev);
 
diff --git a/drivers/gpu/drm/loongson/loongson_irq.c b/drivers/gpu/drm/loongson/loongson_irq.c
new file mode 100644
index 000000000000..d212e16f3c00
--- /dev/null
+++ b/drivers/gpu/drm/loongson/loongson_irq.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include "loongson_drv.h"
+#include <linux/pci.h>
+
+int loongson_irq_init(struct loongson_device *ldev)
+{
+	struct drm_device *dev;
+	int ret, irq;
+
+	dev = ldev->dev;
+	irq = dev->pdev->irq;
+
+	ret = drm_vblank_init(dev, ldev->num_crtc);
+	if (ret) {
+		dev_err(dev->dev, "Fatal error during vblank init: %d\n", ret);
+		return ret;
+	}
+	DRM_INFO("drm vblank init finished\n");
+
+	ret = drm_irq_install(dev, irq);
+	if (ret) {
+		dev_err(dev->dev, "Fatal error during irq install: %d\n", ret);
+		return ret;
+	}
+	DRM_INFO("loongson irq initialized\n");
+
+	return 0;
+}
+
+int loongson_crtc_enable_vblank(struct drm_crtc *crtc)
+{
+	struct loongson_crtc *lcrtc = to_loongson_crtc(crtc);
+	struct loongson_device *ldev = lcrtc->ldev;
+	u32 reg_val;
+
+	if (lcrtc->crtc_id) {
+		reg_val = ls7a_mm_rreg(ldev, FB_INT_REG);
+		reg_val |= FB_VSYNC1_ENABLE;
+		ls7a_mm_wreg(ldev, FB_INT_REG, reg_val);
+	} else {
+		reg_val = ls7a_mm_rreg(ldev, FB_INT_REG);
+		reg_val |= FB_VSYNC0_ENABLE;
+		ls7a_mm_wreg(ldev, FB_INT_REG, reg_val);
+	}
+
+	return 0;
+}
+
+void loongson_crtc_disable_vblank(struct drm_crtc *crtc)
+{
+	struct loongson_crtc *lcrtc = to_loongson_crtc(crtc);
+	struct loongson_device *ldev = lcrtc->ldev;
+	u32 reg_val;
+
+	if (lcrtc->crtc_id) {
+		reg_val = ls7a_mm_rreg(ldev, FB_INT_REG);
+		reg_val &= ~FB_VSYNC1_ENABLE;
+		ls7a_mm_wreg(ldev, FB_INT_REG, reg_val);
+	} else {
+		reg_val = ls7a_mm_rreg(ldev, FB_INT_REG);
+		reg_val &= ~FB_VSYNC0_ENABLE;
+		ls7a_mm_wreg(ldev, FB_INT_REG, reg_val);
+	}
+}
+
+irqreturn_t loongson_irq_handler(int irq, void *arg)
+{
+	struct drm_device *dev = (struct drm_device *) arg;
+	struct loongson_device *ldev = dev->dev_private;
+	struct loongson_crtc *lcrtc;
+	u32 val;
+
+	val = ls7a_mm_rreg(ldev, FB_INT_REG);
+	ls7a_mm_wreg(ldev, FB_INT_REG, val & (0xffff << 16));
+
+	if (val & FB_VSYNC0_INT) {
+		lcrtc = ldev->mode_info[0].crtc;
+		drm_crtc_handle_vblank(&lcrtc->base);
+	}
+
+	if (val & FB_VSYNC1_INT) {
+		lcrtc = ldev->mode_info[1].crtc;
+		drm_crtc_handle_vblank(&lcrtc->base);
+	}
+
+	return IRQ_HANDLED;
+}
+
+void loongson_irq_preinstall(struct drm_device *dev)
+{
+	struct loongson_device *ldev = dev->dev_private;
+
+	ls7a_mm_wreg(ldev, FB_INT_REG, 0x0000 << 16);
+}
+
+void loongson_irq_uninstall(struct drm_device *dev)
+{
+	struct loongson_device *ldev = dev->dev_private;
+
+	if (ldev == NULL)
+		return;
+
+	ls7a_mm_wreg(ldev, FB_INT_REG, 0x0000 << 16);
+}
-- 
2.31.1

