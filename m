Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174FB3C9E32
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 14:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhGOMKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 08:10:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:42283 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231689AbhGOMKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 08:10:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="210518739"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="210518739"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 05:07:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="495407872"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jul 2021 05:07:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4413C262; Thu, 15 Jul 2021 15:08:03 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH v1 1/3] clk: fractional-divider: Export approximation algo to the CCF users
Date:   Thu, 15 Jul 2021 15:07:50 +0300
Message-Id: <20210715120752.29174-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least one user currently duplicates some functions that are provided
by fractional divider module. Let's export approximation algo and replace
the open-coded variant.

As a bonus the exported function will get better documentation in place.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/clk/clk-fractional-divider.c | 11 +++++++----
 drivers/clk/clk-fractional-divider.h |  9 +++++++++
 drivers/clk/rockchip/clk.c           | 17 +++--------------
 3 files changed, 19 insertions(+), 18 deletions(-)
 create mode 100644 drivers/clk/clk-fractional-divider.h

diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index b1e556f20911..535d299af646 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -14,6 +14,8 @@
 #include <linux/slab.h>
 #include <linux/rational.h>
 
+#include "clk-fractional-divider.h"
+
 static inline u32 clk_fd_readl(struct clk_fractional_divider *fd)
 {
 	if (fd->flags & CLK_FRAC_DIVIDER_BIG_ENDIAN)
@@ -68,9 +70,10 @@ static unsigned long clk_fd_recalc_rate(struct clk_hw *hw,
 	return ret;
 }
 
-static void clk_fd_general_approximation(struct clk_hw *hw, unsigned long rate,
-					 unsigned long *parent_rate,
-					 unsigned long *m, unsigned long *n)
+void clk_fractional_divider_general_approximation(struct clk_hw *hw,
+						  unsigned long rate,
+						  unsigned long *parent_rate,
+						  unsigned long *m, unsigned long *n)
 {
 	struct clk_fractional_divider *fd = to_clk_fd(hw);
 	unsigned long scale;
@@ -102,7 +105,7 @@ static long clk_fd_round_rate(struct clk_hw *hw, unsigned long rate,
 	if (fd->approximation)
 		fd->approximation(hw, rate, parent_rate, &m, &n);
 	else
-		clk_fd_general_approximation(hw, rate, parent_rate, &m, &n);
+		clk_fractional_divider_general_approximation(hw, rate, parent_rate, &m, &n);
 
 	ret = (u64)*parent_rate * m;
 	do_div(ret, n);
diff --git a/drivers/clk/clk-fractional-divider.h b/drivers/clk/clk-fractional-divider.h
new file mode 100644
index 000000000000..4fa359a12ef4
--- /dev/null
+++ b/drivers/clk/clk-fractional-divider.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+struct clk_hw;
+
+void clk_fractional_divider_general_approximation(struct clk_hw *hw,
+						  unsigned long rate,
+						  unsigned long *parent_rate,
+						  unsigned long *m,
+						  unsigned long *n);
diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index 049e5e0b64f6..ce7b71594827 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -22,7 +22,9 @@
 #include <linux/regmap.h>
 #include <linux/reboot.h>
 #include <linux/rational.h>
+
 #include "clk.h"
+#include "clk-fractional-divider.h"
 
 /*
  * Register a clock branch.
@@ -178,10 +180,8 @@ static void rockchip_fractional_approximation(struct clk_hw *hw,
 		unsigned long rate, unsigned long *parent_rate,
 		unsigned long *m, unsigned long *n)
 {
-	struct clk_fractional_divider *fd = to_clk_fd(hw);
 	unsigned long p_rate, p_parent_rate;
 	struct clk_hw *p_parent;
-	unsigned long scale;
 
 	p_rate = clk_hw_get_rate(clk_hw_get_parent(hw));
 	if ((rate * 20 > p_rate) && (p_rate % rate != 0)) {
@@ -190,18 +190,7 @@ static void rockchip_fractional_approximation(struct clk_hw *hw,
 		*parent_rate = p_parent_rate;
 	}
 
-	/*
-	 * Get rate closer to *parent_rate to guarantee there is no overflow
-	 * for m and n. In the result it will be the nearest rate left shifted
-	 * by (scale - fd->nwidth) bits.
-	 */
-	scale = fls_long(*parent_rate / rate - 1);
-	if (scale > fd->nwidth)
-		rate <<= scale - fd->nwidth;
-
-	rational_best_approximation(rate, *parent_rate,
-			GENMASK(fd->mwidth - 1, 0), GENMASK(fd->nwidth - 1, 0),
-			m, n);
+	clk_fractional_divider_general_approximation(hw, rate, parent_rate, m, n);
 }
 
 static struct clk *rockchip_clk_register_frac_branch(
-- 
2.30.2

