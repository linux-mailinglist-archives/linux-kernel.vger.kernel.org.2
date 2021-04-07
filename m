Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F9335702C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353490AbhDGPZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:25:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45676 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236449AbhDGPZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:25:10 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lUA37-0007DX-Ny; Wed, 07 Apr 2021 15:24:57 +0000
From:   Colin King <colin.king@canonical.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: uniphier: Fix potential infinite loop
Date:   Wed,  7 Apr 2021 16:24:57 +0100
Message-Id: <20210407152457.497346-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The for-loop iterates with a u8 loop counter i and compares this
with the loop upper limit of num_parents that is an int type.
There is a potential infinite loop if num_parents is larger than
the u8 loop counter. Fix this by making the loop counter the same
type as num_parents.

Addresses-Coverity: ("Infinite loop")
Fixes: 734d82f4a678 ("clk: uniphier: add core support code for UniPhier clock driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/clk/uniphier/clk-uniphier-mux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/uniphier/clk-uniphier-mux.c b/drivers/clk/uniphier/clk-uniphier-mux.c
index 462c84321b2d..ce219e0d2a85 100644
--- a/drivers/clk/uniphier/clk-uniphier-mux.c
+++ b/drivers/clk/uniphier/clk-uniphier-mux.c
@@ -34,7 +34,7 @@ static u8 uniphier_clk_mux_get_parent(struct clk_hw *hw)
 	int num_parents = clk_hw_get_num_parents(hw);
 	int ret;
 	unsigned int val;
-	u8 i;
+	int i;
 
 	ret = regmap_read(mux->regmap, mux->reg, &val);
 	if (ret)
-- 
2.30.2

