Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09BA3FC46A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240410AbhHaIk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 04:40:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53364 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240422AbhHaIk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 04:40:57 -0400
X-UUID: c2bb3395cc704301b8105ff7d3b932e2-20210831
X-UUID: c2bb3395cc704301b8105ff7d3b932e2-20210831
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1722613409; Tue, 31 Aug 2021 16:39:59 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 31 Aug 2021 16:39:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 31 Aug 2021 16:39:57 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH] ASoC: dt-bindings: mt8195: remove dependent headers in the example
Date:   Tue, 31 Aug 2021 16:39:56 +0800
Message-ID: <20210831083956.9804-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the use of the defines including clock and power id, so that
we can remove the headers which are not applied in the example.

Fixes: b5bac34fcfb4 ("dt-bindings: mediatek: mt8195: add audio afe document")
Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 .../bindings/sound/mt8195-afe-pcm.yaml        | 40 +++++++++----------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mt8195-afe-pcm.yaml b/Documentation/devicetree/bindings/sound/mt8195-afe-pcm.yaml
index 53e9434a6d9d..dcf790b053d2 100644
--- a/Documentation/devicetree/bindings/sound/mt8195-afe-pcm.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8195-afe-pcm.yaml
@@ -130,36 +130,34 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/mt8195-clk.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/interrupt-controller/irq.h>
-    #include <dt-bindings/power/mt8195-power.h>
 
     afe: mt8195-afe-pcm@10890000 {
         compatible = "mediatek,mt8195-audio";
         reg = <0x10890000 0x10000>;
         interrupts = <GIC_SPI 822 IRQ_TYPE_LEVEL_HIGH 0>;
         mediatek,topckgen = <&topckgen>;
-        power-domains = <&spm MT8195_POWER_DOMAIN_AUDIO>;
+        power-domains = <&spm 7>; //MT8195_POWER_DOMAIN_AUDIO
         clocks = <&clk26m>,
-                 <&topckgen CLK_TOP_APLL1>,
-                 <&topckgen CLK_TOP_APLL2>,
-                 <&topckgen CLK_TOP_APLL12_DIV0>,
-                 <&topckgen CLK_TOP_APLL12_DIV1>,
-                 <&topckgen CLK_TOP_APLL12_DIV2>,
-                 <&topckgen CLK_TOP_APLL12_DIV3>,
-                 <&topckgen CLK_TOP_APLL12_DIV9>,
-                 <&topckgen CLK_TOP_A1SYS_HP_SEL>,
-                 <&topckgen CLK_TOP_AUD_INTBUS_SEL>,
-                 <&topckgen CLK_TOP_AUDIO_H_SEL>,
-                 <&topckgen CLK_TOP_AUDIO_LOCAL_BUS_SEL>,
-                 <&topckgen CLK_TOP_DPTX_M_SEL>,
-                 <&topckgen CLK_TOP_I2SO1_M_SEL>,
-                 <&topckgen CLK_TOP_I2SO2_M_SEL>,
-                 <&topckgen CLK_TOP_I2SI1_M_SEL>,
-                 <&topckgen CLK_TOP_I2SI2_M_SEL>,
-                 <&infracfg_ao CLK_INFRA_AO_AUDIO_26M_B>,
-                 <&scp_adsp CLK_SCP_ADSP_AUDIODSP>;
+                 <&topckgen 163>, //CLK_TOP_APLL1
+                 <&topckgen 166>, //CLK_TOP_APLL2
+                 <&topckgen 233>, //CLK_TOP_APLL12_DIV0
+                 <&topckgen 234>, //CLK_TOP_APLL12_DIV1
+                 <&topckgen 235>, //CLK_TOP_APLL12_DIV2
+                 <&topckgen 236>, //CLK_TOP_APLL12_DIV3
+                 <&topckgen 238>, //CLK_TOP_APLL12_DIV9
+                 <&topckgen 100>, //CLK_TOP_A1SYS_HP_SEL
+                 <&topckgen 33>, //CLK_TOP_AUD_INTBUS_SEL
+                 <&topckgen 34>, //CLK_TOP_AUDIO_H_SEL
+                 <&topckgen 107>, //CLK_TOP_AUDIO_LOCAL_BUS_SEL
+                 <&topckgen 98>, //CLK_TOP_DPTX_M_SEL
+                 <&topckgen 94>, //CLK_TOP_I2SO1_M_SEL
+                 <&topckgen 95>, //CLK_TOP_I2SO2_M_SEL
+                 <&topckgen 96>, //CLK_TOP_I2SI1_M_SEL
+                 <&topckgen 97>, //CLK_TOP_I2SI2_M_SEL
+                 <&infracfg_ao 50>, //CLK_INFRA_AO_AUDIO_26M_B
+                 <&scp_adsp 0>; //CLK_SCP_ADSP_AUDIODSP
         clock-names = "clk26m",
                       "apll1_ck",
                       "apll2_ck",
-- 
2.18.0

