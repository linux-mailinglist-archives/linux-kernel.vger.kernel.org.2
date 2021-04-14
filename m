Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D5535EE42
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 09:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349689AbhDNHTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:19:16 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37098 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1349632AbhDNHTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:19:05 -0400
X-UUID: 6d976679a07b4c62a7c2690842ec4850-20210414
X-UUID: 6d976679a07b4c62a7c2690842ec4850-20210414
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <yz.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1808014518; Wed, 14 Apr 2021 15:18:41 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 14 Apr 2021 15:18:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Apr 2021 15:18:34 +0800
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
Subject: [PATCH v5 2/2] arm64: dts: mt8192: add eFuse support for MT8192 SoC
Date:   Wed, 14 Apr 2021 15:17:49 +0800
Message-ID: <1618384669-30070-3-git-send-email-Yz.Wu@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1618384669-30070-1-git-send-email-Yz.Wu@mediatek.com>
References: <1618384669-30070-1-git-send-email-Yz.Wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
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
index 9757138..4d4e4de 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -436,6 +436,11 @@
 			status = "disable";
 		};
 
+		efuse: efuse@11c10000 {
+				compatible = "mediatek,mt8192-efuse",
+							 "mediatek,efuse";
+		};
+
 		i2c3: i2c3@11cb0000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11cb0000 0 0x1000>,
-- 
2.6.4

