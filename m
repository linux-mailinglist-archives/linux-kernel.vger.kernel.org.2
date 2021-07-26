Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CC53D57F6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 12:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbhGZKRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 06:17:33 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34260 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233287AbhGZKR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 06:17:29 -0400
X-UUID: a5980b63cef64bb3886dcbe6f3d68b88-20210726
X-UUID: a5980b63cef64bb3886dcbe6f3d68b88-20210726
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 564945308; Mon, 26 Jul 2021 18:57:56 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 26 Jul 2021 18:57:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 26 Jul 2021 18:57:54 +0800
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
Subject: [v14 05/21] clk: mediatek: Get regmap without syscon compatible check
Date:   Mon, 26 Jul 2021 18:57:03 +0800
Message-ID: <20210726105719.15793-6-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210726105719.15793-1-chun-jie.chen@mediatek.com>
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all clock providers need to be marked compatible with "syscon"
for system configuration usage, so use device_node_to_regmap() to
skip "syscon" check.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-cpumux.c | 2 +-
 drivers/clk/mediatek/clk-mtk.c    | 2 +-
 drivers/clk/mediatek/clk-mux.c    | 2 +-
 drivers/clk/mediatek/reset.c      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-cpumux.c b/drivers/clk/mediatek/clk-cpumux.c
index 79fe09028742..61eeae4e60fb 100644
--- a/drivers/clk/mediatek/clk-cpumux.c
+++ b/drivers/clk/mediatek/clk-cpumux.c
@@ -84,7 +84,7 @@ int mtk_clk_register_cpumuxes(struct device_node *node,
 	struct clk *clk;
 	struct regmap *regmap;
 
-	regmap = syscon_node_to_regmap(node);
+	regmap = device_node_to_regmap(node);
 	if (IS_ERR(regmap)) {
 		pr_err("Cannot find regmap for %pOF: %ld\n", node,
 		       PTR_ERR(regmap));
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index cec1c8a27211..37d2aa32175e 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -106,7 +106,7 @@ int mtk_clk_register_gates_with_dev(struct device_node *node,
 	if (!clk_data)
 		return -ENOMEM;
 
-	regmap = syscon_node_to_regmap(node);
+	regmap = device_node_to_regmap(node);
 	if (IS_ERR(regmap)) {
 		pr_err("Cannot find regmap for %pOF: %ld\n", node,
 				PTR_ERR(regmap));
diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
index b0c61709bacc..e97d58db28cc 100644
--- a/drivers/clk/mediatek/clk-mux.c
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -165,7 +165,7 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
 	struct clk *clk;
 	int i;
 
-	regmap = syscon_node_to_regmap(node);
+	regmap = device_node_to_regmap(node);
 	if (IS_ERR(regmap)) {
 		pr_err("Cannot find regmap for %pOF: %ld\n", node,
 		       PTR_ERR(regmap));
diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
index cb939c071b0c..e562dc3c10a4 100644
--- a/drivers/clk/mediatek/reset.c
+++ b/drivers/clk/mediatek/reset.c
@@ -98,7 +98,7 @@ static void mtk_register_reset_controller_common(struct device_node *np,
 	int ret;
 	struct regmap *regmap;
 
-	regmap = syscon_node_to_regmap(np);
+	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap)) {
 		pr_err("Cannot find regmap for %pOF: %ld\n", np,
 				PTR_ERR(regmap));
-- 
2.18.0

