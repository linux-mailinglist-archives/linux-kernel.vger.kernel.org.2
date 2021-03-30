Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF1F34E5A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhC3Kop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhC3Koh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:44:37 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FF7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:44:37 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so7458696pjv.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U4UTdCcB3WVCxZspli0lltbVfgTksXjTHIiVIuKPdEc=;
        b=X81T9M1HusNIU7yzUkbMq8G+76rIBCtyQIMCX77rAbeRKgbkOPxfPjWVnbOV5U9Jff
         gQLM+3ofkKLvHQTPoOi7Tx1THZy/RWRYRKHesFoPHfTjLC0RqRzqit1HJi6Cql3RzOFD
         ECaeNpMoi7KM668vR8hQcdFJKt1mx2sqcqxOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U4UTdCcB3WVCxZspli0lltbVfgTksXjTHIiVIuKPdEc=;
        b=lr0ew68Qwo5MDWgZ+k9Qh7YSdsM7C7KkacgDeDALQLMmXi/0Gd7cxmzlJPTXmRGwE6
         hLOJWgSOxCz2wTf1yZgkhkn8Dvb5sMZcasvm+hL3/MlsJmMYYpVCBrnHFmmUO/E3754p
         GhV4h4PYMa+TC1xdYs3KdiVdVQEIdst7ZurRFz5VNqoCPskJQ3sZHlEuzz5mO/TPmyva
         tBmXiz13tSt+4yJLlyD03qiA6V+UCUZLVmF5LJjOBN92+pKdrgwVyPjLC/LDXHKOsJum
         Xb1PvoLdRXcGAJN75GGVkQFLyD6NR2MftS0Lr069GdguLEUZq0R5TuJph/UWFroP5kP+
         YBRQ==
X-Gm-Message-State: AOAM531dy8VJRHRjvnPG0aXCZabJ/B/C8m43LPb7NnlW5l4Q/kzJCeh/
        Acu2gPilXAeNJ9q+yx1r+HYamck1v8XxcJyz
X-Google-Smtp-Source: ABdhPJwJqKKOmVhnPqI3eRF4RXx9ihm/N3Q4eFXU2TLtl6wIII4nsHdWykklWZV/9tWhFzoWrnvAUQ==
X-Received: by 2002:a17:90a:1f0e:: with SMTP id u14mr3746666pja.155.1617101076842;
        Tue, 30 Mar 2021 03:44:36 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:71d0:f547:14ae:a717])
        by smtp.gmail.com with ESMTPSA id t184sm1231078pgt.32.2021.03.30.03.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 03:44:36 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org,
        weiyi.lu@mediatek.com, ck.hu@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, enric.balletbo@collabora.com
Subject: [PATCH v2] soc: mediatek: mmsys: Add mt8183 mmsys routing table
Date:   Tue, 30 Mar 2021 18:44:32 +0800
Message-Id: <20210330104432.3432574-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mt8183 has different routing registers than mt8173.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
v1->v2:
Move mt8183 routing table to mt8183-mmsys.h

This patch is based on https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git v5.12-next/soc
---
 drivers/soc/mediatek/mt8183-mmsys.h | 56 +++++++++++++++++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.c    |  3 ++
 2 files changed, 59 insertions(+)
 create mode 100644 drivers/soc/mediatek/mt8183-mmsys.h

diff --git a/drivers/soc/mediatek/mt8183-mmsys.h b/drivers/soc/mediatek/mt8183-mmsys.h
new file mode 100644
index 000000000000..38e9f683e5bd
--- /dev/null
+++ b/drivers/soc/mediatek/mt8183-mmsys.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __SOC_MEDIATEK_MT8183_MMSYS_H
+#define __SOC_MEDIATEK_MT8183_MMSYS_H
+
+#include "mtk-mmsys.h"
+
+#define MT8183_DISP_OVL0_MOUT_EN		0xf00
+#define MT8183_DISP_OVL0_2L_MOUT_EN		0xf04
+#define MT8183_DISP_OVL1_2L_MOUT_EN		0xf08
+#define MT8183_DISP_DITHER0_MOUT_EN		0xf0c
+#define MT8183_DISP_PATH0_SEL_IN		0xf24
+#define MT8183_DISP_DSI0_SEL_IN			0xf2c
+#define MT8183_DISP_DPI0_SEL_IN			0xf30
+#define MT8183_DISP_RDMA0_SOUT_SEL_IN		0xf50
+#define MT8183_DISP_RDMA1_SOUT_SEL_IN		0xf54
+
+#define MT8183_OVL0_MOUT_EN_OVL0_2L		BIT(4)
+#define MT8183_OVL0_2L_MOUT_EN_DISP_PATH0	BIT(0)
+#define MT8183_OVL1_2L_MOUT_EN_RDMA1		BIT(4)
+#define MT8183_DITHER0_MOUT_IN_DSI0		BIT(0)
+#define MT8183_DISP_PATH0_SEL_IN_OVL0_2L	0x1
+#define MT8183_DSI0_SEL_IN_RDMA0		0x1
+#define MT8183_DSI0_SEL_IN_RDMA1		0x3
+#define MT8183_DPI0_SEL_IN_RDMA0		0x1
+#define MT8183_DPI0_SEL_IN_RDMA1		0x2
+#define MT8183_RDMA0_SOUT_COLOR0		0x1
+#define MT8183_RDMA1_SOUT_DSI0			0x1
+
+static const struct mtk_mmsys_routes mmsys_mt8183_routing_table[] = {
+	{
+		DDP_COMPONENT_OVL0, DDP_COMPONENT_OVL_2L0,
+		MT8183_DISP_OVL0_MOUT_EN, MT8183_OVL0_MOUT_EN_OVL0_2L
+	}, {
+		DDP_COMPONENT_OVL_2L0, DDP_COMPONENT_RDMA0,
+		MT8183_DISP_OVL0_2L_MOUT_EN, MT8183_OVL0_2L_MOUT_EN_DISP_PATH0
+	}, {
+		DDP_COMPONENT_OVL_2L1, DDP_COMPONENT_RDMA1,
+		MT8183_DISP_OVL1_2L_MOUT_EN, MT8183_OVL1_2L_MOUT_EN_RDMA1
+	}, {
+		DDP_COMPONENT_DITHER, DDP_COMPONENT_DSI0,
+		MT8183_DISP_DITHER0_MOUT_EN, MT8183_DITHER0_MOUT_IN_DSI0
+	}, {
+		DDP_COMPONENT_OVL_2L0, DDP_COMPONENT_RDMA0,
+		MT8183_DISP_PATH0_SEL_IN, MT8183_DISP_PATH0_SEL_IN_OVL0_2L
+	}, {
+		DDP_COMPONENT_RDMA1, DDP_COMPONENT_DPI0,
+		MT8183_DISP_DPI0_SEL_IN, MT8183_DPI0_SEL_IN_RDMA1
+	}, {
+		DDP_COMPONENT_RDMA0, DDP_COMPONENT_COLOR0,
+		MT8183_DISP_RDMA0_SOUT_SEL_IN, MT8183_RDMA0_SOUT_COLOR0
+	}
+};
+
+#endif /* __SOC_MEDIATEK_MT8183_MMSYS_H */
+
diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index c46d8ab8b0c2..ac68a989854e 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -10,6 +10,7 @@
 #include <linux/platform_device.h>
 #include <linux/soc/mediatek/mtk-mmsys.h>
 
+#include "mt8183-mmsys.h"
 #include "mtk-mmsys.h"
 
 static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
@@ -40,6 +41,8 @@ static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
 
 static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
 	.clk_driver = "clk-mt8183-mm",
+	.routes = mmsys_mt8183_routing_table,
+	.num_routes = ARRAY_SIZE(mmsys_mt8183_routing_table),
 };
 
 struct mtk_mmsys {
-- 
2.31.0.291.g576ba9dcdaf-goog

