Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E4C370706
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 13:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhEALZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 07:25:28 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:48218 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbhEALZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 07:25:27 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d12 with ME
        id zPQZ2400621Fzsu03PQZHM; Sat, 01 May 2021 13:24:35 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 01 May 2021 13:24:35 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mturquette@baylibre.com, sboyd@kernel.org, michal.simek@xilinx.com,
        quanyang.wang@windriver.com, rajan.vaja@xilinx.com,
        jolly.shah@xilinx.com, tejasp@xilinx.com,
        shubhrajyoti.datta@xilinx.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] clk: zynqmp: pll: Remove some dead code
Date:   Sat,  1 May 2021 13:24:32 +0200
Message-Id: <71a9fed5f762a71248b8ac73c0a15af82f3ce1e2.1619867987.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'clk_hw_set_rate_range()' does not return any error code and 'ret' is
known to be 0 at this point, so this message can never be displayed.

Remove it.

Fixes: 3fde0e16d016 ("drivers: clk: Add ZynqMP clock driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
HOWEVER, the message is about 'clk_set_rate_range()', not
'clk_hw_set_rate_range()'. So the message is maybe correct and the
'xxx_rate_range()' function incorrect.
---
 drivers/clk/zynqmp/pll.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
index abe6afbf3407..af11e9400058 100644
--- a/drivers/clk/zynqmp/pll.c
+++ b/drivers/clk/zynqmp/pll.c
@@ -331,8 +331,6 @@ struct clk_hw *zynqmp_clk_register_pll(const char *name, u32 clk_id,
 	}
 
 	clk_hw_set_rate_range(hw, PS_PLL_VCO_MIN, PS_PLL_VCO_MAX);
-	if (ret < 0)
-		pr_err("%s:ERROR clk_set_rate_range failed %d\n", name, ret);
 
 	return hw;
 }
-- 
2.30.2

