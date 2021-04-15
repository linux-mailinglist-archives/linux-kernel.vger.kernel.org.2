Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FBB360206
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhDOFxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:53:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48167 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230400AbhDOFxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:53:21 -0400
X-UUID: 491c0a29e5ac42648ce6c520b93ffde2-20210415
X-UUID: 491c0a29e5ac42648ce6c520b93ffde2-20210415
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 239175052; Thu, 15 Apr 2021 13:52:55 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Apr 2021 13:52:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Apr 2021 13:52:53 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Flora Fu <flora.fu@mediatek.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>,
        Chiawen Lee <chiawen.lee@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
Subject: [PATCH v2 6/7] arm64: dts: mt8192: Add APU node
Date:   Thu, 15 Apr 2021 13:52:39 +0800
Message-ID: <1618465960-3013-7-git-send-email-flora.fu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1618465960-3013-1-git-send-email-flora.fu@mediatek.com>
References: <1618465960-3013-1-git-send-email-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add APU node to MT8192.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index eb17274c3719..561025d2ebab 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -1016,6 +1016,23 @@
 			#clock-cells = <1>;
 		};
 
+		apu_mbox: apu_mbox@19000000 {
+			compatible = "mediatek,mt8192-apu-mbox", "syscon";
+			reg = <0 0x19000000 0 0x1000>;
+		};
+
+		apu_conn: apu_conn@19020000 {
+			compatible = "mediatek,mt8192-apu-conn", "syscon";
+			reg = <0 0x19020000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		apu_vcore: apu_vcore@19029000 {
+			compatible = "mediatek,mt8192-apu-vcore", "syscon";
+			reg = <0 0x19029000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		larb13: larb@1a001000 {
 			compatible = "mediatek,mt8192-smi-larb";
 			reg = <0 0x1a001000 0 0x1000>;
-- 
2.18.0

