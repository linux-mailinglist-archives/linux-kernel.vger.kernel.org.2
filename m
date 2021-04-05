Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A19A354751
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 22:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240452AbhDEUEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 16:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240448AbhDEUEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 16:04:07 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F22C061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 13:04:00 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e18so11882017wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 13:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iq6sk4M0ER3Zgi3ABFpbJFrQaqzKVp7U7JBAXlyNsPU=;
        b=yNG4gsb3MPsFf6S7doVmfsjzSXPpXEGo0eLReJl60qPeOlc9PC4EqkVMFF9OIi2Y7X
         uI/JL5kRwpb1nCbVfE42nsXO9vtdob9Qw1MTZlen3S3ivgWPQV48F751vi/agdDx3P8J
         sXssXEwk+dWNYe3pyPRi94QmCk7ePtJv4nY/8+wCHnUw3QGENDaKpufffxz/yggfx7i3
         +BY5LOciFL4D3IQbzsy+3tT+VF8SaVlwombozEiO6g5Wa2EQAp5ayueKjgTHRWF8fAE7
         r+yMrEbTB2lcfofdPfpQyAPreTU4+s/WED+roBn6iIxSRqCwuAzgapKsEdAF/8nZsWTp
         UCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iq6sk4M0ER3Zgi3ABFpbJFrQaqzKVp7U7JBAXlyNsPU=;
        b=YTux6TLc6b0/Ci+jkjTNq3GIJG5lY96Top72XUd1RVQFBRuVHWGi7imxdRv+9t5m3Y
         hNS7m45bXVnZw+KXLdU/9MnauqiZuFsc4VTysNtdFV+pLiCQxQg7TjpJo5k+mW200eeu
         LjkWj1Z7kgf8yAn5sybgo7HVokLHBOvwJBqs/PO5+AIPo1T5HZGSB+5n6MKuuAzEbm8I
         KesCMBssi2LziFvRpOuTMrDob88SqD7Akd54jP63Jq0TFJo2Oxi8MRSA9sArrPOBB2xz
         I9uL0ZOO6jIOZuYFtQyQoeEszTW1aREvMS5lCEcTAjzpP6pc8E2J8pccSwsVwkRqt0V5
         798w==
X-Gm-Message-State: AOAM531x0zHjQZgpfpbvbqPMkpUjLrOCoLbCmTsNjkIrGgNOM2S1jRck
        2MXW70i2spjTVVuDLENECF2U7ECPJB8VmyXZ
X-Google-Smtp-Source: ABdhPJwL/GfhUNJgnX1/PyHGr2s1okb14TrKuliA5RPUs5s3fGatDI+r4aJgQDjX2DYgwcTu8ridgQ==
X-Received: by 2002:a5d:5046:: with SMTP id h6mr8570852wrt.265.1617653039583;
        Mon, 05 Apr 2021 13:03:59 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id i26sm657406wmb.18.2021.04.05.13.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 13:03:59 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     mkorpershoek@baylibre.com, Fabien Parent <fparent@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 2/2] soc: mediatek: mmsys: Add support for MT8167 SoC
Date:   Mon,  5 Apr 2021 22:03:53 +0200
Message-Id: <20210405200354.2194930-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210405200354.2194930-1-fparent@baylibre.com>
References: <20210405200354.2194930-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add routing table for DSI on MT8167 SoC. The registers are mostly
incompatible with the current defines, so new one for MT8167 are added.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

V2: Rebased on top of [0]

[0] https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/log/?h=for-next

 drivers/soc/mediatek/mt8167-mmsys.h | 35 +++++++++++++++++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.c    | 11 +++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 drivers/soc/mediatek/mt8167-mmsys.h

diff --git a/drivers/soc/mediatek/mt8167-mmsys.h b/drivers/soc/mediatek/mt8167-mmsys.h
new file mode 100644
index 000000000000..2772ef5e3934
--- /dev/null
+++ b/drivers/soc/mediatek/mt8167-mmsys.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __SOC_MEDIATEK_MT8167_MMSYS_H
+#define __SOC_MEDIATEK_MT8167_MMSYS_H
+
+#define MT8167_DISP_REG_CONFIG_DISP_OVL0_MOUT_EN	0x030
+#define MT8167_DISP_REG_CONFIG_DISP_DITHER_MOUT_EN	0x038
+#define MT8167_DISP_REG_CONFIG_DISP_COLOR0_SEL_IN	0x058
+#define MT8167_DISP_REG_CONFIG_DISP_DSI0_SEL_IN		0x064
+#define MT8167_DISP_REG_CONFIG_DISP_RDMA0_SOUT_SEL_IN	0x06c
+
+#define MT8167_DITHER_MOUT_EN_RDMA0			0x1
+#define MT8167_RDMA0_SOUT_DSI0				0x2
+#define MT8167_DSI0_SEL_IN_RDMA0			0x1
+
+static const struct mtk_mmsys_routes mt8167_mmsys_routing_table[] = {
+	{
+		DDP_COMPONENT_OVL0, DDP_COMPONENT_COLOR0,
+		MT8167_DISP_REG_CONFIG_DISP_OVL0_MOUT_EN, OVL0_MOUT_EN_COLOR0,
+	}, {
+		DDP_COMPONENT_DITHER, DDP_COMPONENT_RDMA0,
+		MT8167_DISP_REG_CONFIG_DISP_DITHER_MOUT_EN, MT8167_DITHER_MOUT_EN_RDMA0
+	}, {
+		DDP_COMPONENT_OVL0, DDP_COMPONENT_COLOR0,
+		MT8167_DISP_REG_CONFIG_DISP_COLOR0_SEL_IN, COLOR0_SEL_IN_OVL0
+	}, {
+		DDP_COMPONENT_RDMA0, DDP_COMPONENT_DSI0,
+		MT8167_DISP_REG_CONFIG_DISP_DSI0_SEL_IN, MT8167_DSI0_SEL_IN_RDMA0
+	}, {
+		DDP_COMPONENT_RDMA0, DDP_COMPONENT_DSI0,
+		MT8167_DISP_REG_CONFIG_DISP_RDMA0_SOUT_SEL_IN, MT8167_RDMA0_SOUT_DSI0
+	},
+};
+
+#endif /* __SOC_MEDIATEK_MT8167_MMSYS_H */
diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 79e55150210e..080660ef11bf 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -11,6 +11,7 @@
 #include <linux/soc/mediatek/mtk-mmsys.h>
 
 #include "mtk-mmsys.h"
+#include "mt8167-mmsys.h"
 #include "mt8183-mmsys.h"
 
 static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
@@ -33,6 +34,12 @@ static const struct mtk_mmsys_driver_data mt6797_mmsys_driver_data = {
 	.clk_driver = "clk-mt6797-mm",
 };
 
+static const struct mtk_mmsys_driver_data mt8167_mmsys_driver_data = {
+	.clk_driver = "clk-mt8167-mm",
+	.routes = mt8167_mmsys_routing_table,
+	.num_routes = ARRAY_SIZE(mt8167_mmsys_routing_table),
+};
+
 static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
 	.clk_driver = "clk-mt8173-mm",
 	.routes = mmsys_default_routing_table,
@@ -138,6 +145,10 @@ static const struct of_device_id of_match_mtk_mmsys[] = {
 		.compatible = "mediatek,mt6797-mmsys",
 		.data = &mt6797_mmsys_driver_data,
 	},
+	{
+		.compatible = "mediatek,mt8167-mmsys",
+		.data = &mt8167_mmsys_driver_data,
+	},
 	{
 		.compatible = "mediatek,mt8173-mmsys",
 		.data = &mt8173_mmsys_driver_data,
-- 
2.31.0

