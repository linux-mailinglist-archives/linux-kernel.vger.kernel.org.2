Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D1B452E63
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 10:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbhKPJwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 04:52:46 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:40868 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233479AbhKPJwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 04:52:39 -0500
X-UUID: 6e32d49352f347e6b4b110153ffaa555-20211116
X-UUID: 6e32d49352f347e6b4b110153ffaa555-20211116
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2144681982; Tue, 16 Nov 2021 17:49:38 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 16 Nov 2021 17:49:36 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 16 Nov
 2021 17:49:35 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 16 Nov 2021 17:49:34 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>, <stonea168@163.com>,
        <huijuan.xie@mediatek.com>, <shuijing.li@mediatek.com>,
        <liangxu.xu@mediatek.com>, <xinlei.li@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v3 1/2] drm/panel: panel-boe-tv101wum-nl6: tune the power sequence to avoid leakage
Date:   Tue, 16 Nov 2021 17:49:29 +0800
Message-ID: <20211116094930.11470-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.12.5
In-Reply-To: <20211116094930.11470-1-jitao.shi@mediatek.com>
References: <20211116094930.11470-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"auo,kd101n80-45na" 2st LCD SPEC update, need to modify the timing
between IOVCC and mipi data.
The 2st version of SPEC modifies the timing requirements from IOVCC to
Mipi Data. IOVCC is now required to take precedence over MIPI DATA,
otherwise there is a risk of leakage. It is recommended that the time
for MIPI to enter LP11 be postponed after IOVCC (delay20ms).

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Change-Id: Ic5212e2145a7dbf2efef9e5585904a93e1bc5a28
---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 88 +++++++++++++++++++-------
 include/drm/panel_boe_tv101wum_nl6.h           | 28 ++++++++
 2 files changed, 94 insertions(+), 22 deletions(-)
 create mode 100644 include/drm/panel_boe_tv101wum_nl6.h

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index db9d0b86d542..02efee06c430 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -49,7 +49,7 @@ struct boe_panel {
 	struct regulator *avee;
 	struct regulator *avdd;
 	struct gpio_desc *enable_gpio;
-
+	int powered_refcnt;
 	bool prepared;
 };
 
@@ -488,19 +488,15 @@ static int boe_panel_enter_sleep_mode(struct boe_panel *boe)
 	return 0;
 }
 
-static int boe_panel_unprepare(struct drm_panel *panel)
+static int boe_panel_power_off(struct drm_panel *panel)
 {
 	struct boe_panel *boe = to_boe_panel(panel);
-	int ret;
 
-	if (!boe->prepared)
-		return 0;
+	if (WARN_ON(boe->powered_refcnt == 0))
+		return -EINVAL;
 
-	ret = boe_panel_enter_sleep_mode(boe);
-	if (ret < 0) {
-		dev_err(panel->dev, "failed to set panel off: %d\n", ret);
-		return ret;
-	}
+	if (--boe->powered_refcnt != 0)
+		return 0;
 
 	msleep(150);
 
@@ -520,17 +516,45 @@ static int boe_panel_unprepare(struct drm_panel *panel)
 		regulator_disable(boe->pp1800);
 	}
 
+	return 0;
+}
+
+int panel_unprepare_power(struct drm_panel *panel)
+{
+	if (of_device_is_compatible(panel->dev->of_node, "auo,kd101n80-45na"))
+		return boe_panel_power_off(panel);
+
+	return 0;
+}
+EXPORT_SYMBOL(panel_unprepare_power);
+
+static int boe_panel_unprepare(struct drm_panel *panel)
+{
+	struct boe_panel *boe = to_boe_panel(panel);
+	int ret;
+
+	if (!boe->prepared)
+		return 0;
+
+	ret = boe_panel_enter_sleep_mode(boe);
+	if (ret < 0) {
+		dev_err(panel->dev, "failed to set panel off: %d\n", ret);
+		return ret;
+	}
+
+	boe_panel_power_off(panel);
+
 	boe->prepared = false;
 
 	return 0;
 }
 
-static int boe_panel_prepare(struct drm_panel *panel)
+static int boe_panel_power_on(struct drm_panel *panel)
 {
 	struct boe_panel *boe = to_boe_panel(panel);
 	int ret;
 
-	if (boe->prepared)
+	if (++boe->powered_refcnt != 1)
 		return 0;
 
 	gpiod_set_value(boe->enable_gpio, 0);
@@ -558,18 +582,8 @@ static int boe_panel_prepare(struct drm_panel *panel)
 	gpiod_set_value(boe->enable_gpio, 1);
 	usleep_range(6000, 10000);
 
-	ret = boe_panel_init_dcs_cmd(boe);
-	if (ret < 0) {
-		dev_err(panel->dev, "failed to init panel: %d\n", ret);
-		goto poweroff;
-	}
-
-	boe->prepared = true;
-
 	return 0;
 
-poweroff:
-	regulator_disable(boe->avee);
 poweroffavdd:
 	regulator_disable(boe->avdd);
 poweroff1v8:
@@ -580,6 +594,36 @@ static int boe_panel_prepare(struct drm_panel *panel)
 	return ret;
 }
 
+int panel_prepare_power(struct drm_panel *panel)
+{
+	if (of_device_is_compatible(panel->dev->of_node, "auo,kd101n80-45na"))
+		return boe_panel_power_on(panel);
+
+	return 0;
+}
+EXPORT_SYMBOL(panel_prepare_power);
+
+static int boe_panel_prepare(struct drm_panel *panel)
+{
+	struct boe_panel *boe = to_boe_panel(panel);
+	int ret;
+
+	boe_panel_power_on(panel);
+
+	if (boe->prepared)
+		return 0;
+
+	ret = boe_panel_init_dcs_cmd(boe);
+	if (ret < 0) {
+		dev_err(panel->dev, "failed to init panel: %d\n", ret);
+		return ret;
+	}
+
+	boe->prepared = true;
+
+	return 0;
+}
+
 static int boe_panel_enable(struct drm_panel *panel)
 {
 	msleep(130);
diff --git a/include/drm/panel_boe_tv101wum_nl6.h b/include/drm/panel_boe_tv101wum_nl6.h
new file mode 100644
index 000000000000..72abe3eb7840
--- /dev/null
+++ b/include/drm/panel_boe_tv101wum_nl6.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: Jitao Shi <jitao.shi@mediatek.com>
+ */
+
+#ifndef __PANEL_BOE_TV101WUM_NL6_H__
+#define __PANEL_BOE_TV101WUM_NL6_H__
+
+#include <linux/types.h>
+#include <drm/drm_panel.h>
+
+#if defined(CONFIG_DRM_PANEL_BOE_TV101WUM_NL6)
+int panel_unprepare_power(struct drm_panel *panel);
+int panel_prepare_power(struct drm_panel *panel);
+#else
+int panel_unprepare_power(struct drm_panel *panel)
+{
+	return 0;
+}
+
+int panel_prepare_power(struct drm_panel *panel)
+{
+	return 0;
+}
+#endif
+#endif /* __PANEL_BOE_TV101WUM_NL6_H__ */
+
-- 
2.12.5

