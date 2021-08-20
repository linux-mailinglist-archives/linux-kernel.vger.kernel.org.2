Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81473F2AD2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 13:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239271AbhHTLRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 07:17:34 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:39600 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239308AbhHTLRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 07:17:33 -0400
X-UUID: 6cfe8de832044394b3174b06c9d3aaca-20210820
X-UUID: 6cfe8de832044394b3174b06c9d3aaca-20210820
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1794593080; Fri, 20 Aug 2021 19:16:53 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 20 Aug 2021 19:16:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 20 Aug 2021 19:16:51 +0800
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [v2 03/24] clk: mediatek: Fix corner case of tuner_en_reg
Date:   Fri, 20 Aug 2021 19:14:43 +0800
Message-ID: <20210820111504.350-4-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210820111504.350-1-chun-jie.chen@mediatek.com>
References: <20210820111504.350-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On MT8195, tuner_en_reg is moved to register offest 0x0.
If we only judge by tuner_en_reg, it may lead to wrong address.
Add tuner_en_bit to the check condition. And it has been confirmed,
on all the MediaTek SoCs, bit0 of offset 0x0 is always occupied by
clock square control.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index 7fb001a4e7d8..99ada6e06697 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -332,7 +332,7 @@ static struct clk *mtk_clk_register_pll(const struct mtk_pll_data *data,
 		pll->pcw_chg_addr = pll->base_addr + REG_CON1;
 	if (data->tuner_reg)
 		pll->tuner_addr = base + data->tuner_reg;
-	if (data->tuner_en_reg)
+	if (data->tuner_en_reg || data->tuner_en_bit)
 		pll->tuner_en_addr = base + data->tuner_en_reg;
 	if (data->en_reg)
 		pll->en_addr = base + data->en_reg;
-- 
2.18.0

