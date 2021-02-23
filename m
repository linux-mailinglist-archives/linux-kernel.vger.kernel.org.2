Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71FC32285E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 11:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbhBWJ7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 04:59:09 -0500
Received: from lucky1.263xmail.com ([211.157.147.131]:49966 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbhBWJ42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 04:56:28 -0500
Received: from localhost (unknown [192.168.167.130])
        by lucky1.263xmail.com (Postfix) with ESMTP id 2824CB8878;
        Tue, 23 Feb 2021 17:53:59 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P21323T140439055234816S1614074035264055_;
        Tue, 23 Feb 2021 17:53:59 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <4ce57b2d39e1c22797ef4b8f76607591>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: sboyd@kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     sboyd@kernel.org, heiko@sntech.de
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, tony.xie@rock-chips.com,
        finley.xiao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v1 3/4] clk: rockchip: support more core div setting
Date:   Tue, 23 Feb 2021 17:53:51 +0800
Message-Id: <20210223095352.11544-4-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210223095352.11544-1-zhangqing@rock-chips.com>
References: <20210223095352.11544-1-zhangqing@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A55 supports each core to work at different frequencies, and each core
has an independent divider control.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-cpu.c | 25 +++++++++++++++++++++++++
 drivers/clk/rockchip/clk.h     | 17 ++++++++++++++++-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-cpu.c b/drivers/clk/rockchip/clk-cpu.c
index fa9027fb1920..cac06f4f7573 100644
--- a/drivers/clk/rockchip/clk-cpu.c
+++ b/drivers/clk/rockchip/clk-cpu.c
@@ -164,6 +164,18 @@ static int rockchip_cpuclk_pre_rate_change(struct rockchip_cpuclk *cpuclk,
 				     reg_data->mux_core_mask,
 				     reg_data->mux_core_shift),
 		       cpuclk->reg_base + reg_data->core_reg);
+		if (reg_data->core1_reg)
+			writel(HIWORD_UPDATE(alt_div, reg_data->div_core1_mask,
+					     reg_data->div_core1_shift),
+			       cpuclk->reg_base + reg_data->core1_reg);
+		if (reg_data->core2_reg)
+			writel(HIWORD_UPDATE(alt_div, reg_data->div_core2_mask,
+					     reg_data->div_core2_shift),
+			       cpuclk->reg_base + reg_data->core2_reg);
+		if (reg_data->core3_reg)
+			writel(HIWORD_UPDATE(alt_div, reg_data->div_core3_mask,
+					     reg_data->div_core3_shift),
+			       cpuclk->reg_base + reg_data->core3_reg);
 	} else {
 		/* select alternate parent */
 		writel(HIWORD_UPDATE(reg_data->mux_core_alt,
@@ -209,6 +221,19 @@ static int rockchip_cpuclk_post_rate_change(struct rockchip_cpuclk *cpuclk,
 				reg_data->mux_core_shift),
 	       cpuclk->reg_base + reg_data->core_reg);
 
+	if (reg_data->core1_reg)
+		writel(HIWORD_UPDATE(0, reg_data->div_core1_mask,
+				     reg_data->div_core1_shift),
+		       cpuclk->reg_base + reg_data->core1_reg);
+	if (reg_data->core2_reg)
+		writel(HIWORD_UPDATE(0, reg_data->div_core2_mask,
+				     reg_data->div_core2_shift),
+		       cpuclk->reg_base + reg_data->core2_reg);
+	if (reg_data->core3_reg)
+		writel(HIWORD_UPDATE(0, reg_data->div_core3_mask,
+				     reg_data->div_core3_shift),
+		       cpuclk->reg_base + reg_data->core3_reg);
+
 	if (ndata->old_rate > ndata->new_rate)
 		rockchip_cpuclk_set_dividers(cpuclk, rate);
 
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 2271a84124b0..b46c93fd0cb5 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -322,7 +322,7 @@ struct rockchip_cpuclk_clksel {
 	u32 val;
 };
 
-#define ROCKCHIP_CPUCLK_NUM_DIVIDERS	2
+#define ROCKCHIP_CPUCLK_NUM_DIVIDERS	5
 struct rockchip_cpuclk_rate_table {
 	unsigned long prate;
 	struct rockchip_cpuclk_clksel divs[ROCKCHIP_CPUCLK_NUM_DIVIDERS];
@@ -333,6 +333,12 @@ struct rockchip_cpuclk_rate_table {
  * @core_reg:		register offset of the core settings register
  * @div_core_shift:	core divider offset used to divide the pll value
  * @div_core_mask:	core divider mask
+ * @div_core1_shift:	core1 divider offset used to divide the pll value
+ * @div_core1_mask:	core1 divider mask
+ * @div_core2_shift:	core2 divider offset used to divide the pll value
+ * @div_core2_mask:	core2 divider mask
+ * @div_core3_shift:	core3 divider offset used to divide the pll value
+ * @div_core3_mask:	core3 divider mask
  * @mux_core_alt:	mux value to select alternate parent
  * @mux_core_main:	mux value to select main parent of core
  * @mux_core_shift:	offset of the core multiplexer
@@ -342,6 +348,15 @@ struct rockchip_cpuclk_reg_data {
 	int		core_reg;
 	u8		div_core_shift;
 	u32		div_core_mask;
+	int		core1_reg;
+	u8		div_core1_shift;
+	u32		div_core1_mask;
+	int		core2_reg;
+	u8		div_core2_shift;
+	u32		div_core2_mask;
+	int		core3_reg;
+	u8		div_core3_shift;
+	u32		div_core3_mask;
 	u8		mux_core_alt;
 	u8		mux_core_main;
 	u8		mux_core_shift;
-- 
2.17.1



