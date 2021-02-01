Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2F830A0C2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 05:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhBAEBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 23:01:13 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:48449 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229842AbhBAEBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 23:01:08 -0500
X-UUID: 6fb78aae7f54460d9220e4470c3ad4a1-20210201
X-UUID: 6fb78aae7f54460d9220e4470c3ad4a1-20210201
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yz.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 687227818; Mon, 01 Feb 2021 12:00:23 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 1 Feb 2021 12:00:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 1 Feb 2021 12:00:18 +0800
From:   <Yz.Wu@mediatek.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Seiya Wang <seiya.wang@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Ryan Wu <Yz.Wu@mediatek.com>
Subject: [PATCH v4 2/2] arm64: dts: mt8192: add eFuse support for MT8192 SoC
Date:   Mon, 1 Feb 2021 11:59:46 +0800
Message-ID: <1612151986-19820-3-git-send-email-Yz.Wu@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1612151986-19820-1-git-send-email-Yz.Wu@mediatek.com>
References: <1612151986-19820-1-git-send-email-Yz.Wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D9CD2D45EC8FAB4537609052FAC0466141216DD3643AE3B27CF4D06AC34ADF4D2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Wu <Yz.Wu@mediatek.com>

Add eFuse node to read Mediatek eFuse

Signed-off-by: Ryan Wu <Yz.Wu@mediatek.com>
---
This patch dependents on "arm64: dts: Add Mediatek SoC MT8192 and evaluation board dts and Makefile"[1]

mt8192.dtsi file is needed for this patch.
Please also accept this patch together with [1].

[1]http://lists.infradead.org/pipermail/linux-mediatek/2020-November/019378.html
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 69d45c7..4a0d941 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -422,6 +422,11 @@
 			#clock-cells = <1>;
 		};
 
+		efuse: efuse@11c10000 {
+			compatible = "mediatek,mt8192-efuse",
+				     "mediatek,efuse";
+		};
+
 		i2c3: i2c3@11cb0000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11cb0000 0 0x1000>,
-- 
2.6.4

