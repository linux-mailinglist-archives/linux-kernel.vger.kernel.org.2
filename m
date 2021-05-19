Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B678D389383
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355204AbhESQUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355180AbhESQUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:20:15 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A72C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:18:54 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so3794188wmk.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1tDzYjlDgxmjzjobVmYcSz4r7xXPp8M3cZtPHLcuKcM=;
        b=VEjoOzDCPyBnjHP/G+BRd8AKbPY6qS8lTWusp2nzrpszqPBx3pksX3LvcjKvTFtI4h
         x+kr1EYslL8oMYIPdVG1M1ncBdLkReUq/bcmfEmLyVrfvRxJhyfS+5jQFQvVPVImSk01
         Wt2NDHNbIn5QIHUDYnWOSogfESFmWpESmHZgpgVvgnw/msKDXXkj9ulWEB4UE6IYkswJ
         oMW6al367zYMbFEfHtWTxi2BvY25srwWc1GkULdPeNSTq8HhFesYmbiryAbr6Bbr8eDk
         ArNWLn54QKUA0Q0mRTPPRYMOE55ypC7xQnpYMudhPpYBfCzdjAA3RVF8ImwGYDCH+I0Z
         rgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1tDzYjlDgxmjzjobVmYcSz4r7xXPp8M3cZtPHLcuKcM=;
        b=HSAJa7ARqabfVkxhD0nx0vTTb84T+3zcYVdO4+hdbahRhyHkYj1hBr9f3f7DAtA5N5
         BWZYjj8LTf7/rEeiaXAfANRS+GUGrOSpAc42ZUM51rFpYOZNltEpPooa0hQuHVD4dLRI
         9eb1YlMRTV9oeICRuYFQ0NQKbCErAo0Qb3rsnWNyTxm1JXWWwQ03t0OtBZzWQd5nieDM
         flTTTwiwwkbbwWIaS8abUdsUdwTqXdLxjVqHnKaM1hnK5fVF4RaaTnpr8sNzGcoeHK9x
         pJwK8GQo+yq5G4NxM5VjTqCXc5vtrTIvETwvA1q+bDvQm8SYmo/4vIsuyPP/7rBiQUA7
         HaHQ==
X-Gm-Message-State: AOAM531v2wFVYrU/q0+O2Gma7VwKE0AJSEjjOORI/LBisvc1nWSGPgGU
        hF4mqL27UI03zyJIuvZjqjFrlA==
X-Google-Smtp-Source: ABdhPJx339v7qsUtnr6FF5kKHb2G5akgAZXS2RG7+qV4roVMKFwgXBX6GCtrEbz0xlJFj1y+X7Zepg==
X-Received: by 2002:a1c:65c2:: with SMTP id z185mr143143wmb.2.1621441133512;
        Wed, 19 May 2021 09:18:53 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id m9sm5638547wmq.40.2021.05.19.09.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 09:18:53 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     mkorpershoek@baylibre.com, Fabien Parent <fparent@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 3/3] soc: mediatek: mmsys: add MT8365 support
Date:   Wed, 19 May 2021 18:18:46 +0200
Message-Id: <20210519161847.3747352-3-fparent@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519161847.3747352-1-fparent@baylibre.com>
References: <20210519161847.3747352-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DSI mmsys connections for the MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/soc/mediatek/mt8365-mmsys.h | 60 +++++++++++++++++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.c    | 11 ++++++
 2 files changed, 71 insertions(+)
 create mode 100644 drivers/soc/mediatek/mt8365-mmsys.h

diff --git a/drivers/soc/mediatek/mt8365-mmsys.h b/drivers/soc/mediatek/mt8365-mmsys.h
new file mode 100644
index 000000000000..2475aeb79791
--- /dev/null
+++ b/drivers/soc/mediatek/mt8365-mmsys.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __SOC_MEDIATEK_MT8365_MMSYS_H
+#define __SOC_MEDIATEK_MT8365_MMSYS_H
+
+#define MT8365_DISP_REG_CONFIG_DISP_OVL0_MOUT_EN	0xf3c
+#define MT8365_DISP_REG_CONFIG_DISP_RDMA0_SOUT_SEL	0xf4c
+#define MT8365_DISP_REG_CONFIG_DISP_DITHER0_MOUT_EN	0xf50
+#define MT8365_DISP_REG_CONFIG_DISP_RDMA0_SEL_IN	0xf54
+#define MT8365_DISP_REG_CONFIG_DISP_RDMA0_RSZ0_SEL_IN	0xf60
+#define MT8365_DISP_REG_CONFIG_DISP_COLOR0_SEL_IN	0xf64
+#define MT8365_DISP_REG_CONFIG_DISP_DSI0_SEL_IN		0xf68
+
+#define MT8365_RDMA0_SOUT_COLOR0			0x1
+#define MT8365_DITHER_MOUT_EN_DSI0			0x1
+#define MT8365_DSI0_SEL_IN_DITHER			0x1
+#define MT8365_RDMA0_SEL_IN_OVL0			0x0
+#define MT8365_RDMA0_RSZ0_SEL_IN_RDMA0			0x0
+#define MT8365_DISP_COLOR_SEL_IN_COLOR0			0x0
+#define MT8365_OVL0_MOUT_PATH0_SEL			BIT(0)
+
+static const struct mtk_mmsys_routes mt8365_mmsys_routing_table[] = {
+	{
+		DDP_COMPONENT_OVL0, DDP_COMPONENT_RDMA0,
+		MT8365_DISP_REG_CONFIG_DISP_OVL0_MOUT_EN,
+		MT8365_OVL0_MOUT_PATH0_SEL
+	},
+	{
+		DDP_COMPONENT_OVL0, DDP_COMPONENT_RDMA0,
+		MT8365_DISP_REG_CONFIG_DISP_RDMA0_SEL_IN,
+		MT8365_RDMA0_SEL_IN_OVL0
+	},
+	{
+		DDP_COMPONENT_RDMA0, DDP_COMPONENT_COLOR0,
+		MT8365_DISP_REG_CONFIG_DISP_RDMA0_SOUT_SEL,
+		MT8365_RDMA0_SOUT_COLOR0
+	},
+	{
+		DDP_COMPONENT_COLOR0, DDP_COMPONENT_CCORR,
+		MT8365_DISP_REG_CONFIG_DISP_COLOR0_SEL_IN,
+		MT8365_DISP_COLOR_SEL_IN_COLOR0
+	},
+	{
+		DDP_COMPONENT_DITHER, DDP_COMPONENT_DSI0,
+		MT8365_DISP_REG_CONFIG_DISP_DITHER0_MOUT_EN,
+		MT8365_DITHER_MOUT_EN_DSI0
+	},
+	{
+		DDP_COMPONENT_DITHER, DDP_COMPONENT_DSI0,
+		MT8365_DISP_REG_CONFIG_DISP_DSI0_SEL_IN,
+		MT8365_DSI0_SEL_IN_DITHER
+	},
+	{
+		DDP_COMPONENT_RDMA0, DDP_COMPONENT_COLOR0,
+		MT8365_DISP_REG_CONFIG_DISP_RDMA0_RSZ0_SEL_IN,
+		MT8365_RDMA0_RSZ0_SEL_IN_RDMA0
+	},
+};
+
+#endif /* __SOC_MEDIATEK_MT8365_MMSYS_H */
diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 080660ef11bf..44aff822d035 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -13,6 +13,7 @@
 #include "mtk-mmsys.h"
 #include "mt8167-mmsys.h"
 #include "mt8183-mmsys.h"
+#include "mt8365-mmsys.h"
 
 static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
 	.clk_driver = "clk-mt2701-mm",
@@ -52,6 +53,12 @@ static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
 	.num_routes = ARRAY_SIZE(mmsys_mt8183_routing_table),
 };
 
+static const struct mtk_mmsys_driver_data mt8365_mmsys_driver_data = {
+	.clk_driver = "clk-mt8365-mm",
+	.routes = mt8365_mmsys_routing_table,
+	.num_routes = ARRAY_SIZE(mt8365_mmsys_routing_table),
+};
+
 struct mtk_mmsys {
 	void __iomem *regs;
 	const struct mtk_mmsys_driver_data *data;
@@ -157,6 +164,10 @@ static const struct of_device_id of_match_mtk_mmsys[] = {
 		.compatible = "mediatek,mt8183-mmsys",
 		.data = &mt8183_mmsys_driver_data,
 	},
+	{
+		.compatible = "mediatek,mt8365-mmsys",
+		.data = &mt8365_mmsys_driver_data,
+	},
 	{ }
 };
 
-- 
2.31.1

