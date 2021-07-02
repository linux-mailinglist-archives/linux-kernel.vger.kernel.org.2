Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC3A3B9A71
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 03:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbhGBBNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 21:13:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230404AbhGBBNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 21:13:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 770E861410;
        Fri,  2 Jul 2021 01:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625188259;
        bh=VT8bYjp/GuyWhw9fGjfNZxY3I6cLgA34n5FSfysMQF4=;
        h=From:To:Cc:Subject:Date:From;
        b=mYoZ0n5WGbPM0kWEPdeGqSF6alrD6L0gD58V0IUPgTfjdOMZU479kqraLDEIqaBgI
         I/BxKQNjuKYD56qcQ2frJw3GdHeh58+MyHkqAKWjHj8QH0iQddPOuoR3x7zFsHRUqr
         gN98MmiiAEkFZDnVtbFmpXfBFFO5Olad2JmcrohgFlrlUng8NtOXPHdvVecUdbP7SQ
         f3Td2xzx9XPgvlZ/KNuDE1Wcrii5yJAMjBP4pkrUW97dp9JC7KHhUVFa76TCyf5IF2
         uMyj3txUoM08DgAHY91NnPThKK6U6Bgkhnh9M1ykw+aqIQh0Zx5+0ctUOcib2S6rQO
         RckPGnHu8KYAQ==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] Revert "clk: divider: Switch from .round_rate to .determine_rate by default"
Date:   Thu,  1 Jul 2021 18:10:58 -0700
Message-Id: <20210702011058.77284-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit db400ac1444b756030249ed4a35e53a68e557b59. We have
drivers that are still using the .round_rate ops from here. We could
implement both determine_rate and round_rate for these divider ops, but
for now let's just kick out the commit that tried to change it and
convert various drivers properly.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: db400ac1444b ("clk: divider: Switch from .round_rate to .determine_rate by default")
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk-divider.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 9e05e81116af..87ba4966b0e8 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -425,8 +425,8 @@ long divider_ro_round_rate_parent(struct clk_hw *hw, struct clk_hw *parent,
 }
 EXPORT_SYMBOL_GPL(divider_ro_round_rate_parent);
 
-static int clk_divider_determine_rate(struct clk_hw *hw,
-				      struct clk_rate_request *req)
+static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *prate)
 {
 	struct clk_divider *divider = to_clk_divider(hw);
 
@@ -437,13 +437,13 @@ static int clk_divider_determine_rate(struct clk_hw *hw,
 		val = clk_div_readl(divider) >> divider->shift;
 		val &= clk_div_mask(divider->width);
 
-		return divider_ro_determine_rate(hw, req, divider->table,
-						 divider->width,
-						 divider->flags, val);
+		return divider_ro_round_rate(hw, rate, prate, divider->table,
+					     divider->width, divider->flags,
+					     val);
 	}
 
-	return divider_determine_rate(hw, req, divider->table, divider->width,
-				      divider->flags);
+	return divider_round_rate(hw, rate, prate, divider->table,
+				  divider->width, divider->flags);
 }
 
 int divider_get_val(unsigned long rate, unsigned long parent_rate,
@@ -500,14 +500,14 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 
 const struct clk_ops clk_divider_ops = {
 	.recalc_rate = clk_divider_recalc_rate,
-	.determine_rate = clk_divider_determine_rate,
+	.round_rate = clk_divider_round_rate,
 	.set_rate = clk_divider_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_divider_ops);
 
 const struct clk_ops clk_divider_ro_ops = {
 	.recalc_rate = clk_divider_recalc_rate,
-	.determine_rate = clk_divider_determine_rate,
+	.round_rate = clk_divider_round_rate,
 };
 EXPORT_SYMBOL_GPL(clk_divider_ro_ops);
 

base-commit: 498cc50b3fa99b545532dc433d53d3c0b889cc98
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

