Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3336B34080C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 15:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhCROm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 10:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhCROmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 10:42:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7EBC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 07:42:39 -0700 (PDT)
Received: from [2a0a:edc0:0:c01:1d::a2] (helo=drehscheibe.grey.stw.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1lMtr5-0005zS-9Q; Thu, 18 Mar 2021 15:42:31 +0100
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1lMtr4-0000UH-2H; Thu, 18 Mar 2021 15:42:30 +0100
Received: from mtr by dude03.red.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1lMtr4-00EQOY-15; Thu, 18 Mar 2021 15:42:30 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     colin.king@canonical.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org
Cc:     m.tretter@pengutronix.de, mturquette@baylibre.com,
        michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: xilinx: vcu: rewrite and fix xvcu_clk_hw_unregister_leaf
Date:   Thu, 18 Mar 2021 15:42:30 +0100
Message-Id: <20210318144230.3438009-1-m.tretter@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The xvcu_clk_hw_unregister_leaf function was missing a check if the
clock mux exits before unregistering the clock mux.

Fix the error by rewriting the entire function. The function now first
finds all clocks that are part of the output clock and afterwards
unregisters all found clocks. This avoids mixing the unregister calls
with get_parent calls and makes the code more readable.

Reported-by: Colin Ian King <colin.king@canonical.com>
Fixes: 9c789deea206 ("soc: xilinx: vcu: implement clock provider for output clocks")
Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
---
Hi,

This is a cleanup and rewrite of the function following the issue
reported by Colin [0]. Hopefully, this is going to clear up the
confusion and makes the code easier to follow.

[0] https://lore.kernel.org/kernel-janitors/20210211095700.158960-1-colin.king@canonical.com/

Michael
---
 drivers/clk/xilinx/xlnx_vcu.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/xilinx/xlnx_vcu.c b/drivers/clk/xilinx/xlnx_vcu.c
index d66b1315114e..266ee797fdb7 100644
--- a/drivers/clk/xilinx/xlnx_vcu.c
+++ b/drivers/clk/xilinx/xlnx_vcu.c
@@ -499,23 +499,22 @@ static struct clk_hw *xvcu_clk_hw_register_leaf(struct device *dev,
 static void xvcu_clk_hw_unregister_leaf(struct clk_hw *hw)
 {
 	struct clk_hw *gate = hw;
-	struct clk_hw *divider;
-	struct clk_hw *mux;
-
-	if (!gate)
-		return;
-
-	divider = clk_hw_get_parent(gate);
-	clk_hw_unregister_gate(gate);
-	if (!divider)
-		return;
-
-	mux = clk_hw_get_parent(divider);
-	clk_hw_unregister_mux(mux);
-	if (!divider)
-		return;
+	struct clk_hw *divider = NULL;
+	struct clk_hw *mux = NULL;
 
-	clk_hw_unregister_divider(divider);
+	/* Get all clocks of this output clock */
+	if (gate)
+		divider = clk_hw_get_parent(gate);
+	if (divider)
+		mux = clk_hw_get_parent(divider);
+
+	/* Unregister clocks of this output clock if they have been found */
+	if (gate)
+		clk_hw_unregister_gate(gate);
+	if (divider)
+		clk_hw_unregister_divider(divider);
+	if (mux)
+		clk_hw_unregister_mux(mux);
 }
 
 static int xvcu_register_clock_provider(struct xvcu_device *xvcu)
-- 
2.29.2

