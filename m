Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EA93601F5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhDOFxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:53:16 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48054 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230351AbhDOFxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:53:12 -0400
X-UUID: 6ef29a052a1a429e9a561b573d0febee-20210415
X-UUID: 6ef29a052a1a429e9a561b573d0febee-20210415
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1311287674; Thu, 15 Apr 2021 13:52:45 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Apr 2021 13:52:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Apr 2021 13:52:43 +0800
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
Subject: [PATCH v2 1/7] dt-bindings: clock: Add MT8192 APU clock bindings
Date:   Thu, 15 Apr 2021 13:52:34 +0800
Message-ID: <1618465960-3013-2-git-send-email-flora.fu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1618465960-3013-1-git-send-email-flora.fu@mediatek.com>
References: <1618465960-3013-1-git-send-email-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock bindings for APU on MT8192.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
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

