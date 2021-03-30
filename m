Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0692134E0A0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 07:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhC3FXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 01:23:44 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:32965 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230306AbhC3FXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 01:23:32 -0400
X-UUID: 76c4364de1ab46a384d56e2a8ab4ad19-20210330
X-UUID: 76c4364de1ab46a384d56e2a8ab4ad19-20210330
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <pk.chi@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 575480467; Tue, 30 Mar 2021 13:23:30 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 30 Mar 2021 13:23:23 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Mar 2021 13:23:23 +0800
From:   Po-Kai Chi <pk.chi@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        Po-Kai Chi <pk.chi@mediatek.com>
Subject: [PATCH v1 3/4] arm64: dts: add DRAMC node for MT6779
Date:   Tue, 30 Mar 2021 13:22:10 +0800
Message-ID: <1617081731-7408-4-git-send-email-pk.chi@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1617081731-7408-1-git-send-email-pk.chi@mediatek.com>
References: <1617081731-7408-1-git-send-email-pk.chi@mediatek.com>
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
index 164f5cb..9a556ad 100644
--- a/arch/arm64/boot/dts/mediatek/mt6779-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt6779-evb.dts
@@ -29,3 +29,12 @@
 &uart0 {
 	status = "okay";
 };
+
+&dramc {
+	dram_type = <0>;
+	channel_cnt = <2>;
+	rank_cnt = <2>;
+	rank_size = <0x0 0x0>;
+	mr_cnt = <1>;
+	mr = <0x5 0xff>;
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt6779.dtsi b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
index 9bdf514..332d48d 100644
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
+			support_channel_cnt = <2>;
+			freq_cnt = <6>;
+			freq_step = <3718 3733>,
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

