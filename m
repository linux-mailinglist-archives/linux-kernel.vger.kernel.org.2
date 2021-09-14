Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B8940A340
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 04:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237825AbhINCSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 22:18:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50828 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236938AbhINCST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:18:19 -0400
X-UUID: f93b193f8b2946c1b9debd5126998a17-20210914
X-UUID: f93b193f8b2946c1b9debd5126998a17-20210914
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1296953729; Tue, 14 Sep 2021 10:17:00 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 10:16:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Sep 2021 10:16:58 +0800
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
Subject: [v3 05/24] clk: mediatek: Fix resource leak in mtk_clk_simple_probe
Date:   Tue, 14 Sep 2021 10:16:14 +0800
Message-ID: <20210914021633.26377-6-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210914021633.26377-1-chun-jie.chen@mediatek.com>
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Release clock data when clock driver probe fail to fix
possible resource leak.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mtk.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index c3d385c0cfcb..74890759e98c 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -314,7 +314,15 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 
 	r = mtk_clk_register_gates(node, mcd->clks, mcd->num_clks, clk_data);
 	if (r)
-		return r;
+		goto free_data;
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r)
+		goto free_data;
+
+	return r;
+
+free_data:
+	mtk_free_clk_data(clk_data);
+	return r;
 }
-- 
2.18.0

