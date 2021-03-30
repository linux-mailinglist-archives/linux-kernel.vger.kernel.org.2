Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B9D34E607
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbhC3LEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhC3LE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:04:29 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340E2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:04:29 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so7499130pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FMhBXNDUu18Nx4oVs0q4h6SRvqYZuwc7QpYMrUAt5VE=;
        b=k8yMndEAD//moVQlp2k9f3Get8rceORt9KZJTpoka6uTGzUcPWO011MOHMLEjjBXiV
         HEyecO5hmwIUF3bW3gY5sZaUIgDgxOnX5pmFIi/sANLnmBizGQeKoktTeN/NoGMF2aXl
         jDzHk/oVO+LqeSV3hyAuszZXSdS0X9DHgXEeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FMhBXNDUu18Nx4oVs0q4h6SRvqYZuwc7QpYMrUAt5VE=;
        b=bV1xHStnZyX/OOSVegymaMglLUkk71s10w0Tl/sEIRUPKcxgBBxPi26PgT+GAhvHGi
         pAKPcV0MkGjIfnVA+xWxEQNBXl/hhTu6EJW0tWH9NIPBJUq8xLIIS/j06x5NRz9yMHWQ
         DcVqMhlzVFF6B/UztPt4eaxSuVpaXezFThKNkNtaY86rRzeujGacCyEV326ACEKdWXAg
         dhbZcMU59OuKM8tp0roKVuLjeG7RFCrc1tY3HizggFBsO44QMBLTFj9wtl4Wl1vsQHD4
         96JX9TwOQEAZbv6IgMD9XGARAt05S6bS2Hxw/qdzpmXd/SKOZLefozvEHj8VbZXIk59S
         QZiw==
X-Gm-Message-State: AOAM531Du7EhRA9ShqtgyfpDd6mU/u0wScbetLIvrA4KQQ/ABVGzXLnl
        nHjW8vBu0DbCNmZ1cJuNaziU2VyWfhZLcUuC
X-Google-Smtp-Source: ABdhPJzqgbpfnNkYAMfYaqM0w634uSngO51qCSynBowzU1lQ41SopXqbKtWvKyh0yr2GrbeS0X5hdw==
X-Received: by 2002:a17:902:ea0e:b029:e4:81d4:ddae with SMTP id s14-20020a170902ea0eb02900e481d4ddaemr33970302plg.12.1617102267979;
        Tue, 30 Mar 2021 04:04:27 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:71d0:f547:14ae:a717])
        by smtp.gmail.com with ESMTPSA id m1sm2613873pjf.8.2021.03.30.04.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 04:04:27 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org,
        weiyi.lu@mediatek.com, ck.hu@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, enric.balletbo@collabora.com
Subject: [PATCH v3] soc: mediatek: mmsys: Add mt8183 mmsys routing table
Date:   Tue, 30 Mar 2021 19:04:23 +0800
Message-Id: <20210330110423.3542163-1-hsinyi@chromium.org>
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
v2->v3:
Fix comments.

v1->v2:
Move mt8183 routing table to mt8183-mmsys.h

This patch is based on https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git v5.12-next/soc
---
 drivers/soc/mediatek/mt8183-mmsys.h | 54 +++++++++++++++++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.c    |  3 ++
 2 files changed, 57 insertions(+)
 create mode 100644 drivers/soc/mediatek/mt8183-mmsys.h

diff --git a/drivers/soc/mediatek/mt8183-mmsys.h b/drivers/soc/mediatek/mt8183-mmsys.h
new file mode 100644
index 000000000000..579dfc8dc8fc
--- /dev/null
+++ b/drivers/soc/mediatek/mt8183-mmsys.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __SOC_MEDIATEK_MT8183_MMSYS_H
+#define __SOC_MEDIATEK_MT8183_MMSYS_H
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
index c46d8ab8b0c2..79e55150210e 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -11,6 +11,7 @@
 #include <linux/soc/mediatek/mtk-mmsys.h>
 
 #include "mtk-mmsys.h"
+#include "mt8183-mmsys.h"
 
 static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
 	.clk_driver = "clk-mt2701-mm",
@@ -40,6 +41,8 @@ static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
 
 static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
 	.clk_driver = "clk-mt8183-mm",
+	.routes = mmsys_mt8183_routing_table,
+	.num_routes = ARRAY_SIZE(mmsys_mt8183_routing_table),
 };
 
 struct mtk_mmsys {
-- 
2.31.0.291.g576ba9dcdaf-goog

