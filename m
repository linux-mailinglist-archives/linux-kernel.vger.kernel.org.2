Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109833561E1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 05:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348320AbhDGD2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 23:28:48 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38682 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229736AbhDGD2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 23:28:45 -0400
X-UUID: 80a363a11fea4e12874ff2a0f613028b-20210407
X-UUID: 80a363a11fea4e12874ff2a0f613028b-20210407
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2066322995; Wed, 07 Apr 2021 11:28:35 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 7 Apr 2021 11:28:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 7 Apr 2021 11:28:33 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Flora Fu <flora.fu@mediatek.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>,
        Chiawen Lee <chiawen.lee@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH 1/8] dt-bindings: clock: Add MT8192 APU clock bindings
Date:   Wed, 7 Apr 2021 11:27:59 +0800
Message-ID: <1617766086-5502-2-git-send-email-flora.fu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1617766086-5502-1-git-send-email-flora.fu@mediatek.com>
References: <1617766086-5502-1-git-send-email-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock bindings for APU on MT8192.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>
---
 include/dt-bindings/clock/mt8192-clk.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/dt-bindings/clock/mt8192-clk.h b/include/dt-bindings/clock/mt8192-clk.h
index ece5b4c0356c..71e07858f5dc 100644
--- a/include/dt-bindings/clock/mt8192-clk.h
+++ b/include/dt-bindings/clock/mt8192-clk.h
@@ -164,7 +164,15 @@
 #define CLK_TOP_APLL12_DIV9		152
 #define CLK_TOP_SSUSB_TOP_REF		153
 #define CLK_TOP_SSUSB_PHY_REF		154
-#define CLK_TOP_NR_CLK			155
+#define CLK_TOP_DSP_SEL			155
+#define CLK_TOP_DSP1_SEL		156
+#define CLK_TOP_DSP1_NPUPLL_SEL		157
+#define CLK_TOP_DSP2_SEL		158
+#define CLK_TOP_DSP2_NPUPLL_SEL		159
+#define CLK_TOP_DSP5_SEL		160
+#define CLK_TOP_DSP5_APUPLL_SEL		161
+#define CLK_TOP_IPU_IF_SEL		162
+#define CLK_TOP_NR_CLK			163
 
 /* INFRACFG */
 
@@ -309,7 +317,9 @@
 #define CLK_APMIXED_APLL1		8
 #define CLK_APMIXED_APLL2		9
 #define CLK_APMIXED_MIPID26M		10
-#define CLK_APMIXED_NR_CLK		11
+#define CLK_APMIXED_APUPLL		11
+#define CLK_APMIXED_NPUPLL		12
+#define CLK_APMIXED_NR_CLK		13
 
 /* SCP_ADSP */
 
-- 
2.18.0

