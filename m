Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D363A87C7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhFORfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:35:31 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:35338 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231199AbhFORez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:34:55 -0400
X-UUID: 8d4b15fd808f4b959c5b70b847e000b1-20210616
X-UUID: 8d4b15fd808f4b959c5b70b847e000b1-20210616
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 336697304; Wed, 16 Jun 2021 01:32:44 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Jun 2021 01:32:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Jun 2021 01:32:42 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <seiya.wang@mediatek.com>, <wenst@google.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Crystal Guo <crystal.guo@mediatek.com>
Subject: [PATCH 01/27] arm64: dts: mt8195: add infracfg_rst node
Date:   Wed, 16 Jun 2021 01:32:08 +0800
Message-ID: <20210615173233.26682-2-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
In-Reply-To: <20210615173233.26682-1-tinghan.shen@mediatek.com>
References: <20210615173233.26682-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Crystal Guo <crystal.guo@mediatek.com>

add infracfg_rst node which is for MT8195 platform

Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 629cd883facf..8cda62f736b3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -8,6 +8,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/reset/ti-syscon.h>
 
 / {
 	compatible = "mediatek,mt8195";
@@ -273,6 +274,20 @@
 			};
 		};
 
+		infracfg: syscon@10001000 {
+			compatible = "mediatek,mt8195-infracfg", "syscon", "simple-mfd";
+			reg = <0 0x10001000 0 0x1000>;
+			#clock-cells = <1>;
+
+			infracfg_rst: reset-controller {
+				compatible = "ti,syscon-reset";
+				#reset-cells = <1>;
+				ti,reset-bits = <
+					0x140 26 0x144 26 0 0 (ASSERT_SET | DEASSERT_SET | STATUS_NONE)
+				>;
+			};
+		};
+
 		watchdog: watchdog@10007000 {
 			compatible = "mediatek,mt8195-wdt", "mediatek,mt6589-wdt";
 			reg = <0 0x10007000 0 0x100>;
-- 
2.18.0

