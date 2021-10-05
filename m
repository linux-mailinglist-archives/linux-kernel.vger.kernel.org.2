Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB85421C58
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 04:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhJECKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 22:10:32 -0400
Received: from mx.socionext.com ([202.248.49.38]:46766 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230514AbhJECKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 22:10:19 -0400
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 05 Oct 2021 11:08:28 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 11F702058B40;
        Tue,  5 Oct 2021 11:08:28 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 5 Oct 2021 11:08:28 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 9ECE4AB192;
        Tue,  5 Oct 2021 11:08:27 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 5/5] clk: uniphier: Add SoC-glue clock source selector support for Pro4
Date:   Tue,  5 Oct 2021 11:08:26 +0900
Message-Id: <1633399706-1251-6-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1633399706-1251-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1633399706-1251-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SoC-glue clock source selector for ahci controller on UniPhier SoCs.
Currently this supports Pro4 only.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/clk/uniphier/clk-uniphier-core.c |  5 +++++
 drivers/clk/uniphier/clk-uniphier-sys.c  | 17 +++++++++++++++++
 drivers/clk/uniphier/clk-uniphier.h      |  1 +
 3 files changed, 23 insertions(+)

diff --git a/drivers/clk/uniphier/clk-uniphier-core.c b/drivers/clk/uniphier/clk-uniphier-core.c
index 0a947e7..46c66fa 100644
--- a/drivers/clk/uniphier/clk-uniphier-core.c
+++ b/drivers/clk/uniphier/clk-uniphier-core.c
@@ -210,6 +210,11 @@ static const struct of_device_id uniphier_clk_match[] = {
 		.compatible = "socionext,uniphier-nx1-peri-clock",
 		.data = uniphier_pro4_peri_clk_data,
 	},
+	/* SoC-glue clock */
+	{
+		.compatible = "socionext,uniphier-pro4-sg-clock",
+		.data = uniphier_pro4_sg_clk_data,
+	},
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/clk/uniphier/clk-uniphier-sys.c b/drivers/clk/uniphier/clk-uniphier-sys.c
index e8bf85c..0180470 100644
--- a/drivers/clk/uniphier/clk-uniphier-sys.c
+++ b/drivers/clk/uniphier/clk-uniphier-sys.c
@@ -330,3 +330,20 @@ const struct uniphier_clk_data uniphier_nx1_sys_clk_data[] = {
 			     "cpll/32"),
 	{ /* sentinel */ }
 };
+
+const struct uniphier_clk_data uniphier_pro4_sg_clk_data[] = {
+	UNIPHIER_CLK_DIV("gpll", 4),
+	{
+		.name = "sata-ref",
+		.type = UNIPHIER_CLK_TYPE_MUX,
+		.idx = 0,
+		.data.mux = {
+			.parent_names = { "gpll/4", "ref", },
+			.num_parents = 2,
+			.reg = 0x1a28,
+			.masks = { 0x1, 0x1, },
+			.vals  = { 0x0, 0x1, },
+		},
+	},
+	{ /* sentinel */ }
+};
diff --git a/drivers/clk/uniphier/clk-uniphier.h b/drivers/clk/uniphier/clk-uniphier.h
index c54fb78..dea0c78 100644
--- a/drivers/clk/uniphier/clk-uniphier.h
+++ b/drivers/clk/uniphier/clk-uniphier.h
@@ -155,5 +155,6 @@ extern const struct uniphier_clk_data uniphier_ld4_mio_clk_data[];
 extern const struct uniphier_clk_data uniphier_pro5_sd_clk_data[];
 extern const struct uniphier_clk_data uniphier_ld4_peri_clk_data[];
 extern const struct uniphier_clk_data uniphier_pro4_peri_clk_data[];
+extern const struct uniphier_clk_data uniphier_pro4_sg_clk_data[];
 
 #endif /* __CLK_UNIPHIER_H__ */
-- 
2.7.4

