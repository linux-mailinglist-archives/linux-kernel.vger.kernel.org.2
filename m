Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CA33F4754
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 11:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbhHWJZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 05:25:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44800 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235699AbhHWJY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 05:24:56 -0400
X-UUID: 8be3143b3fe740b5a63841f2196c9ed1-20210823
X-UUID: 8be3143b3fe740b5a63841f2196c9ed1-20210823
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 363415715; Mon, 23 Aug 2021 17:24:11 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 23 Aug 2021 17:24:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 23 Aug 2021 17:24:10 +0800
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [v4 1/5] dt-bindings: power: Add MT8195 power domains
Date:   Mon, 23 Aug 2021 17:23:49 +0800
Message-ID: <20210823092353.3502-2-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210823092353.3502-1-chun-jie.chen@mediatek.com>
References: <20210823092353.3502-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power domains dt-bindings for MT8195.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
remove unused power domain like audio_src, nna and hdmi_rx.
---
 .../power/mediatek,power-controller.yaml      |  2 +
 include/dt-bindings/power/mt8195-power.h      | 46 +++++++++++++++++++
 2 files changed, 48 insertions(+)
 create mode 100644 include/dt-bindings/power/mt8195-power.h

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index f234a756c193..d6ebd77d28a7 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -27,6 +27,7 @@ properties:
       - mediatek,mt8173-power-controller
       - mediatek,mt8183-power-controller
       - mediatek,mt8192-power-controller
+      - mediatek,mt8195-power-controller
 
   '#power-domain-cells':
     const: 1
@@ -64,6 +65,7 @@ patternProperties:
               "include/dt-bindings/power/mt8173-power.h" - for MT8173 type power domain.
               "include/dt-bindings/power/mt8183-power.h" - for MT8183 type power domain.
               "include/dt-bindings/power/mt8192-power.h" - for MT8192 type power domain.
+              "include/dt-bindings/power/mt8195-power.h" - for MT8195 type power domain.
         maxItems: 1
 
       clocks:
diff --git a/include/dt-bindings/power/mt8195-power.h b/include/dt-bindings/power/mt8195-power.h
new file mode 100644
index 000000000000..b20ca4b3e3a8
--- /dev/null
+++ b/include/dt-bindings/power/mt8195-power.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ * Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
+ */
+
+#ifndef _DT_BINDINGS_POWER_MT8195_POWER_H
+#define _DT_BINDINGS_POWER_MT8195_POWER_H
+
+#define MT8195_POWER_DOMAIN_PCIE_MAC_P0		0
+#define MT8195_POWER_DOMAIN_PCIE_MAC_P1		1
+#define MT8195_POWER_DOMAIN_PCIE_PHY		2
+#define MT8195_POWER_DOMAIN_SSUSB_PCIE_PHY	3
+#define MT8195_POWER_DOMAIN_CSI_RX_TOP		4
+#define MT8195_POWER_DOMAIN_ETHER		5
+#define MT8195_POWER_DOMAIN_ADSP		6
+#define MT8195_POWER_DOMAIN_AUDIO		7
+#define MT8195_POWER_DOMAIN_MFG0		8
+#define MT8195_POWER_DOMAIN_MFG1		9
+#define MT8195_POWER_DOMAIN_MFG2		10
+#define MT8195_POWER_DOMAIN_MFG3		11
+#define MT8195_POWER_DOMAIN_MFG4		12
+#define MT8195_POWER_DOMAIN_MFG5		13
+#define MT8195_POWER_DOMAIN_MFG6		14
+#define MT8195_POWER_DOMAIN_VPPSYS0		15
+#define MT8195_POWER_DOMAIN_VDOSYS0		16
+#define MT8195_POWER_DOMAIN_VPPSYS1		17
+#define MT8195_POWER_DOMAIN_VDOSYS1		18
+#define MT8195_POWER_DOMAIN_DP_TX		19
+#define MT8195_POWER_DOMAIN_EPD_TX		20
+#define MT8195_POWER_DOMAIN_HDMI_TX		21
+#define MT8195_POWER_DOMAIN_WPESYS		22
+#define MT8195_POWER_DOMAIN_VDEC0		23
+#define MT8195_POWER_DOMAIN_VDEC1		24
+#define MT8195_POWER_DOMAIN_VDEC2		25
+#define MT8195_POWER_DOMAIN_VENC		26
+#define MT8195_POWER_DOMAIN_VENC_CORE1		27
+#define MT8195_POWER_DOMAIN_IMG			28
+#define MT8195_POWER_DOMAIN_DIP			29
+#define MT8195_POWER_DOMAIN_IPE			30
+#define MT8195_POWER_DOMAIN_CAM			31
+#define MT8195_POWER_DOMAIN_CAM_RAWA		32
+#define MT8195_POWER_DOMAIN_CAM_RAWB		33
+#define MT8195_POWER_DOMAIN_CAM_MRAW		34
+
+#endif /* _DT_BINDINGS_POWER_MT8195_POWER_H */
-- 
2.18.0

