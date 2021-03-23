Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAADC345786
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 06:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhCWFvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 01:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhCWFvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 01:51:50 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3536C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 22:51:49 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id c204so13156344pfc.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 22:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FtIC9ocJ4+NOnMRBa7jQB43OlZx1SC3ik3qdbBBdMIA=;
        b=X/5/uuwrxFYcF8Awxi1cwtq18Vl4EymKBcOaK9VmY+oiNsIsueGIxRe1utA/39s1qG
         7FbBz+ekJlBjND28eTk8IF0Ah/P72WMDBm6F0UtBW+rUSBRpCuQmI6L9F4AWAjn/S2Le
         9960srFiKAxVa69Tps1YeIwAqpv/24hSuXRKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FtIC9ocJ4+NOnMRBa7jQB43OlZx1SC3ik3qdbBBdMIA=;
        b=cdIdiDkqql0TyXpFmnUOxatr47fyCgAn4N1BGVRTsHzPHmLXNgHYz6bkwSbi4zBwGs
         NMslCfTl0E2eOjSkW2gCkzghD8mVCUi4w7RCOmUZFseErOl1k0iz18YF4PYlt5gJOs64
         Icx9zfkqbuOwYxAwjGjzZcBySJ+ZjHzMrDaKDdZ7vF6jMYDXAv1HeyAzwHvDQglikmYv
         hFUcNrJFXQ8QEkfIg5a+ynf3/4mOcRDuoMaD17485RU5lghMww6dulp3xSm/UxDGLGUb
         DLeQ1PZh9tl/VWk66Ab+wMtjev1JobVVE5zr6L6/TwCqObCA3eMt6bRW0rpJu/s8z77E
         pnIg==
X-Gm-Message-State: AOAM5306iitGO5RC7F03TcX6PU7vyD1leMAAylvIVlzNt3lpYy8yKN/y
        kcAkgWyUBuKJQ2zrtnO1Mff3xc801BJr6NlS
X-Google-Smtp-Source: ABdhPJwmGyPV1d4xdJ5P70Yke6owQpM9u/Z2Pscxia8QZ1e+ryjZ+XQiEohTES5v5I74LSSlE1mXbQ==
X-Received: by 2002:a17:902:834a:b029:e6:b6bc:f58c with SMTP id z10-20020a170902834ab02900e6b6bcf58cmr3622329pln.85.1616478708902;
        Mon, 22 Mar 2021 22:51:48 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:c8d1:279a:cb3a:39cd])
        by smtp.gmail.com with ESMTPSA id k11sm7621837pgc.38.2021.03.22.22.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 22:51:48 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org,
        weiyi.lu@mediatek.com, ck.hu@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, enric.balletbo@collabora.com
Subject: [PATCH] soc: mediatek: mmsys: Add mt8183 mmsys routing table
Date:   Tue, 23 Mar 2021 13:51:43 +0800
Message-Id: <20210323055143.607529-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mt8183 has different routing registers than mt8173.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
This patch is based on series ("soc: mediatek: Prepare MMSYS for DDP routing using tables")[1]
and tested with mt8183 krand and mt8183 juniper device.
The register value is referenced from [2].

[1] https://patchwork.kernel.org/project/linux-mediatek/cover/20210317181711.795245-1-enric.balletbo@collabora.com/
[2] https://patchwork.kernel.org/project/linux-mediatek/patch/1609815993-22744-6-git-send-email-yongqiang.niu@mediatek.com/
---
 drivers/soc/mediatek/mtk-mmsys.c |  2 ++
 drivers/soc/mediatek/mtk-mmsys.h | 47 ++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index c46d8ab8b0c2..16bb55b0463a 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -40,6 +40,8 @@ static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
 
 static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
 	.clk_driver = "clk-mt8183-mm",
+	.routes = mmsys_mt8183_routing_table,
+	.num_routes = ARRAY_SIZE(mmsys_mt8183_routing_table),
 };
 
 struct mtk_mmsys {
diff --git a/drivers/soc/mediatek/mtk-mmsys.h b/drivers/soc/mediatek/mtk-mmsys.h
index a760a34e6eca..c55baf5932b8 100644
--- a/drivers/soc/mediatek/mtk-mmsys.h
+++ b/drivers/soc/mediatek/mtk-mmsys.h
@@ -66,6 +66,28 @@
 #define DPI_SEL_IN_BLS				0x0
 #define DSI_SEL_IN_RDMA				0x1
 
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
 struct mtk_mmsys_routes {
 	u32 from_comp;
 	u32 to_comp;
@@ -212,4 +234,29 @@ static const struct mtk_mmsys_routes mmsys_default_routing_table[] = {
 	}
 };
 
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
 #endif /* __SOC_MEDIATEK_MTK_MMSYS_H */
-- 
2.31.0.rc2.261.g7f71774620-goog

