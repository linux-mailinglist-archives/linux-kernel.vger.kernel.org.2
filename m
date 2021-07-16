Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720603CB7E8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 15:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240045AbhGPNhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 09:37:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:56332 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239996AbhGPNhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 09:37:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="197993394"
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="197993394"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 06:34:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="429191754"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jul 2021 06:34:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4C00A2CB; Fri, 16 Jul 2021 16:34:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Liu Ying <victor.liu@nxp.com>
Subject: [PATCH v2 3/3] clk: fractional-divider: Document the arithmetics used behind the code
Date:   Fri, 16 Jul 2021 16:34:48 +0300
Message-Id: <20210716133448.24890-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210716133448.24890-1-andriy.shevchenko@linux.intel.com>
References: <20210716133448.24890-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that some code lines raise the question why they are needed
and how they are participated in the calculus of the resulting values.

Document this in a form of the top comment in the module file.

Reported-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: renamed variables in formulas to follow the code, added floor()
 drivers/clk/clk-fractional-divider.c | 34 +++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index 5f4b6a8aef67..7f7f688f8de5 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -3,8 +3,38 @@
  * Copyright (C) 2014 Intel Corporation
  *
  * Adjustable fractional divider clock implementation.
- * Output rate = (m / n) * parent_rate.
  * Uses rational best approximation algorithm.
+ *
+ * Output is calculated as
+ *
+ *	rate = (m / n) * parent_rate				(1)
+ *
+ * This is useful when on die we have a prescaler block which asks for
+ * m (numerator) and n (denominator) values to be provided to satisfy
+ * the (1) as much as possible.
+ *
+ * Since m and n have the limitation by a range, e.g.
+ *
+ *	n >= 1, n < N_width, where N_width = 2^nwidth		(2)
+ *
+ * for some cases the output may be saturated. Hence, from (1) and (2),
+ * assuming the worst case when m = 1, the inequality
+ *
+ *	floor(log2(parent_rate / rate)) <= nwidth		(3)
+ *
+ * may be derived. Thus, in cases when
+ *
+ *	(parent_rate / rate) >> N_width				(4)
+ *
+ * we scale up the rate by 2^scale, where
+ *
+ *	scale = floor(log2(parent_rate / rate)) - nwidth	(5)
+ *
+ * and assume that the IP, that needs m and n, has also its own
+ * prescaler, which is capable to divide by 2^scale. In this way
+ * we get the denominator to satisfy the desired range (2) and
+ * at the same time much much better result of m and n than simple
+ * saturated values.
  */
 
 #include <linux/clk-provider.h>
@@ -81,6 +111,8 @@ void clk_fractional_divider_general_approximation(struct clk_hw *hw,
 	 * Get rate closer to *parent_rate to guarantee there is no overflow
 	 * for m and n. In the result it will be the nearest rate left shifted
 	 * by (scale - fd->nwidth) bits.
+	 *
+	 * For the detailed explanation see the top comment in this file.
 	 */
 	if (!(fd->flags & CLK_FRAC_DIVIDER_NO_PRESCALER)) {
 		unsigned long scale = fls_long(*parent_rate / rate - 1);
-- 
2.30.2

