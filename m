Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945C4361D7D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241876AbhDPJdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 05:33:01 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50761 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241826AbhDPJcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 05:32:53 -0400
X-UUID: 545cf740cc1e4ba7a2584bdaea496853-20210416
X-UUID: 545cf740cc1e4ba7a2584bdaea496853-20210416
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <pk.chi@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 290145491; Fri, 16 Apr 2021 17:32:26 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 16 Apr 2021 17:32:24 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 16 Apr 2021 17:32:24 +0800
From:   Po-Kai Chi <pk.chi@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, CC Hwang <cc.hwang@mediatek.com>,
        Po-Kai Chi <pk.chi@mediatek.com>
Subject: [PATCH v2 3/4] arm64: dts: add DRAMC node for MT6779
Date:   Fri, 16 Apr 2021 17:32:17 +0800
Message-ID: <1618565538-6972-4-git-send-email-pk.chi@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1618565538-6972-1-git-send-email-pk.chi@mediatek.com>
References: <1618565538-6972-1-git-send-email-pk.chi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DRAMC node for the DRAMC kernel driver.

Properties are divided into three categories:

- Platform DTS:
    MediaTek DRAMC platform common part.

- Project DTS:
    Runtime filled in by bootloader according to the board
    hardware configuration.

- Driver level:
    Hardware-specific register settings, encapsulated as
    compatible data for better DTS compatibility.

Signed-off-by: Po-Kai Chi <pk.chi@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt6779-evb.dts |    9 +++++++++
 arch/arm64/boot/dts/mediatek/mt6779.dtsi    |   18 ++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6779-evb.dts b/arch/arm64/boot/dts/mediatek/mt6779-evb.dts
index 164f5cb..5d2dde7 100644
--- a/arch/arm64/boot/dts/mediatek/mt6779-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt6779-evb.dts
@@ -29,3 +29,12 @@
 &uart0 {
 	status = "okay";
 };
+
+&dramc {
+	mediatek,dram-type = <0>;
+	mediatek,channel-cnt = <2>;
+	mediatek,rank-cnt = <2>;
+	mediatek,rank-size = <0x0 0x0>;
+	mediatek,mr-cnt = <1>;
+	mediatek,mr = <0x5 0xff>;
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt6779.dtsi b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
index 9bdf514..28492a0 100644
--- a/arch/arm64/boot/dts/mediatek/mt6779.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
@@ -206,6 +206,24 @@
 			clock-names = "devapc-infra-clock";
 		};
 
+		dramc: dramc@10230000 {
+			compatible = "mediatek,mt6779-dramc";
+			reg = <0 0x10230000 0 0x2000>, /* DRAMC AO CHA */
+				<0 0x10240000 0 0x2000>, /* DRAMC AO CHB */
+				<0 0x10234000 0 0x1000>, /* DRAMC NAO CHA */
+				<0 0x10244000 0 0x1000>, /* DRAMC NAO CHB */
+				<0 0x10238000 0 0x2000>, /* DDRPHY AO CHA */
+				<0 0x10248000 0 0x2000>; /* DDRPHY AO CHB */
+			mediatek,support-channel-cnt = <2>;
+			mediatek,freq-cnt = <6>;
+			mediatek,freq-step = <3718 3733>,
+				<3094 3200>,
+				<2392 2400>,
+				<1534 1600>,
+				<1196 1200>,
+				<754 800>;
+		};
+
 		uart0: serial@11002000 {
 			compatible = "mediatek,mt6779-uart",
 				     "mediatek,mt6577-uart";
-- 
1.7.9.5

