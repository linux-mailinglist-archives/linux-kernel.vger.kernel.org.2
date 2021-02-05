Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074433109DA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhBELIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:08:31 -0500
Received: from gloria.sntech.de ([185.11.138.130]:42282 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231965AbhBELFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:05:51 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1l7yvB-0001Ja-Di; Fri, 05 Feb 2021 12:05:05 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     heiko@sntech.de
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH 2/5] clk: rockchip: use clock ids for PCLK_DPHYRX and PCLK_DPHYTX0 on rk3368
Date:   Fri,  5 Feb 2021 12:04:59 +0100
Message-Id: <20210205110502.1850669-2-heiko@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210205110502.1850669-1-heiko@sntech.de>
References: <20210205110502.1850669-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

Export the clocks via the newly added clock-ids.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 drivers/clk/rockchip/clk-rk3368.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3368.c b/drivers/clk/rockchip/clk-rk3368.c
index 55443349439b..76fb04120089 100644
--- a/drivers/clk/rockchip/clk-rk3368.c
+++ b/drivers/clk/rockchip/clk-rk3368.c
@@ -818,8 +818,8 @@ static struct rockchip_clk_branch rk3368_clk_branches[] __initdata = {
 	 * pclk_vio gates
 	 * pclk_vio comes from the exactly same source as hclk_vio
 	 */
-	GATE(0, "pclk_dphyrx", "hclk_vio", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(14), 8, GFLAGS),
-	GATE(0, "pclk_dphytx", "hclk_vio", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(14), 8, GFLAGS),
+	GATE(PCLK_DPHYRX, "pclk_dphyrx", "hclk_vio", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(14), 8, GFLAGS),
+	GATE(PCLK_DPHYTX0, "pclk_dphytx0", "hclk_vio", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(14), 8, GFLAGS),
 
 	/* pclk_pd_pmu gates */
 	GATE(PCLK_PMUGRF, "pclk_pmugrf", "pclk_pd_pmu", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(23), 5, GFLAGS),
-- 
2.29.2

