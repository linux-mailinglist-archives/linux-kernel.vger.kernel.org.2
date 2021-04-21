Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DFE366D24
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242780AbhDUNt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:49:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235222AbhDUNtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:49:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6582260C3E;
        Wed, 21 Apr 2021 13:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619012931;
        bh=GO+ss1xX6Lr1YX4hNiDs80lMaAeRx4c1oZ6yYsxMykQ=;
        h=From:To:Cc:Subject:Date:From;
        b=VrG0KnI6VBOhtLUFd2RazGeMmsYt/daXvXTmZ48fKOGiBpLc9UDe7tiwvERYGRlsr
         3+JTtEavmFpxvPm3gDmSTSWXU6o0OnNUXGuL8h92WrArf0xSN1OBIAhDfg6W4yT2cW
         pU7oikukC4k6PU52frLsP8agFnx3/QBTrT0CvtFoCzm61TXVIST3CIrXfgSwDKItO8
         YwPvUOJtvpGWuPZxOJyNaLne5TuJTpietQOD3wOZ+0jsa+i0nVr0SBtLxzlL2neqDh
         eIW4IKw6uEa7quqxXb9DMzWPlfKKKKjPe2HJyWvkkR8FHm6dq0BDHLI0Mp1ikFc2BA
         IBPgBmYntdr7A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: zynqmp: fix compile testing without ZYNQMP_FIRMWARE
Date:   Wed, 21 Apr 2021 15:48:36 +0200
Message-Id: <20210421134844.3297838-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When the firmware code is disabled, the incomplete error handling
in the clk driver causes compile-time warnings:

drivers/clk/zynqmp/pll.c: In function 'zynqmp_pll_recalc_rate':
drivers/clk/zynqmp/pll.c:147:29: error: 'fbdiv' is used uninitialized [-Werror=uninitialized]
  147 |         rate =  parent_rate * fbdiv;
      |                 ~~~~~~~~~~~~^~~~~~~
In function 'zynqmp_pll_get_mode',
    inlined from 'zynqmp_pll_recalc_rate' at drivers/clk/zynqmp/pll.c:148:6:
drivers/clk/zynqmp/pll.c:61:27: error: 'ret_payload' is used uninitialized [-Werror=uninitialized]
   61 |         return ret_payload[1];
      |                ~~~~~~~~~~~^~~
drivers/clk/zynqmp/pll.c: In function 'zynqmp_pll_recalc_rate':
drivers/clk/zynqmp/pll.c:53:13: note: 'ret_payload' declared here
   53 |         u32 ret_payload[PAYLOAD_ARG_CNT];
      |             ^~~~~~~~~~~
drivers/clk/zynqmp/clk-mux-zynqmp.c: In function 'zynqmp_clk_mux_get_parent':
drivers/clk/zynqmp/clk-mux-zynqmp.c:57:16: error: 'val' is used uninitialized [-Werror=uninitialized]
   57 |         return val;
      |                ^~~

As it was apparently intentional to support this for compile testing
purposes, change the code to have just enough error handling for the
compiler to not notice the remaining bugs.

Fixes: 21f237534661 ("clk: zynqmp: Drop dependency on ARCH_ZYNQMP")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/zynqmp/clk-mux-zynqmp.c | 4 +++-
 drivers/clk/zynqmp/pll.c            | 8 ++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/zynqmp/clk-mux-zynqmp.c b/drivers/clk/zynqmp/clk-mux-zynqmp.c
index 06194149be83..2afded3c7c11 100644
--- a/drivers/clk/zynqmp/clk-mux-zynqmp.c
+++ b/drivers/clk/zynqmp/clk-mux-zynqmp.c
@@ -50,9 +50,11 @@ static u8 zynqmp_clk_mux_get_parent(struct clk_hw *hw)
 
 	ret = zynqmp_pm_clock_getparent(clk_id, &val);
 
-	if (ret)
+	if (ret) {
 		pr_warn_once("%s() getparent failed for clock: %s, ret = %d\n",
 			     __func__, clk_name, ret);
+		return ret;
+	}
 
 	return val;
 }
diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
index abe6afbf3407..67d2a2d260c1 100644
--- a/drivers/clk/zynqmp/pll.c
+++ b/drivers/clk/zynqmp/pll.c
@@ -54,9 +54,11 @@ static inline enum pll_mode zynqmp_pll_get_mode(struct clk_hw *hw)
 	int ret;
 
 	ret = zynqmp_pm_get_pll_frac_mode(clk_id, ret_payload);
-	if (ret)
+	if (ret) {
 		pr_warn_once("%s() PLL get frac mode failed for %s, ret = %d\n",
 			     __func__, clk_name, ret);
+		return ret;
+	}
 
 	return ret_payload[1];
 }
@@ -140,9 +142,11 @@ static unsigned long zynqmp_pll_recalc_rate(struct clk_hw *hw,
 	int ret;
 
 	ret = zynqmp_pm_clock_getdivider(clk_id, &fbdiv);
-	if (ret)
+	if (ret) {
 		pr_warn_once("%s() get divider failed for %s, ret = %d\n",
 			     __func__, clk_name, ret);
+		return -1ul;
+	}
 
 	rate =  parent_rate * fbdiv;
 	if (zynqmp_pll_get_mode(hw) == PLL_MODE_FRAC) {
-- 
2.29.2

