Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977AB3A7602
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 06:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhFOEkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 00:40:14 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:59387 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229520AbhFOEkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 00:40:12 -0400
X-UUID: 0c7592555d634b3397370a004882f099-20210615
X-UUID: 0c7592555d634b3397370a004882f099-20210615
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2009050895; Tue, 15 Jun 2021 12:36:27 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Jun 2021 12:36:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Jun 2021 12:36:26 +0800
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [PATCH 2/4] dt-bindings: power: Add MT8195 power domains
Date:   Tue, 15 Jun 2021 12:36:01 +0800
Message-ID: <20210615043603.20412-3-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210615043603.20412-1-chun-jie.chen@mediatek.com>
References: <20210615043603.20412-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power domains dt-bindings for MT8195.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 .../power/mediatek,power-controller.yaml      |  2 +
 include/dt-bindings/power/mt8195-power.h      | 51 +++++++++++++++++++
 2 files changed, 53 insertions(+)
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
index 000000000000..43fd36e1f538
--- /dev/null
+++ b/include/dt-bindings/power/mt8195-power.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
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
+#define MT8195_POWER_DOMAIN_AUDIO_ASRC		8
+#define MT8195_POWER_DOMAIN_NNA			9
+#define MT8195_POWER_DOMAIN_NNA0		10
+#define MT8195_POWER_DOMAIN_NNA1		11
+#define MT8195_POWER_DOMAIN_MFG0		12
+#define MT8195_POWER_DOMAIN_MFG1		13
+#define MT8195_POWER_DOMAIN_MFG2		14
+#define MT8195_POWER_DOMAIN_MFG3		15
+#define MT8195_POWER_DOMAIN_MFG4		16
+#define MT8195_POWER_DOMAIN_MFG5		17
+#define MT8195_POWER_DOMAIN_MFG6		18
+#define MT8195_POWER_DOMAIN_VPPSYS0		19
+#define MT8195_POWER_DOMAIN_VDOSYS0		20
+#define MT8195_POWER_DOMAIN_VPPSYS1		21
+#define MT8195_POWER_DOMAIN_VDOSYS1		22
+#define MT8195_POWER_DOMAIN_DP_TX		23
+#define MT8195_POWER_DOMAIN_EPD_TX		24
+#define MT8195_POWER_DOMAIN_HDMI_TX		25
+#define MT8195_POWER_DOMAIN_HDMI_RX		26
+#define MT8195_POWER_DOMAIN_WPESYS		27
+#define MT8195_POWER_DOMAIN_VDEC0		28
+#define MT8195_POWER_DOMAIN_VDEC1		29
+#define MT8195_POWER_DOMAIN_VDEC2		30
+#define MT8195_POWER_DOMAIN_VENC		31
+#define MT8195_POWER_DOMAIN_VENC_CORE1		32
+#define MT8195_POWER_DOMAIN_IMG			33
+#define MT8195_POWER_DOMAIN_DIP			34
+#define MT8195_POWER_DOMAIN_IPE			35
+#define MT8195_POWER_DOMAIN_CAM			36
+#define MT8195_POWER_DOMAIN_CAM_RAWA		37
+#define MT8195_POWER_DOMAIN_CAM_RAWB		38
+#define MT8195_POWER_DOMAIN_CAM_MRAW		39
+
+#endif /* _DT_BINDINGS_POWER_MT8195_POWER_H */
-- 
2.18.0

