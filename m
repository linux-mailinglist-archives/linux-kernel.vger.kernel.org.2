Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F903C9E34
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 14:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhGOMKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 08:10:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:50191 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231689AbhGOMKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 08:10:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="210344050"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="210344050"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 05:07:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="460371672"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 15 Jul 2021 05:07:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 52CD32CB; Thu, 15 Jul 2021 15:08:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Liu Ying <victor.liu@nxp.com>
Subject: [PATCH v1 2/3] clk: fractional-divider: Introduce NO_PRESCALER flag
Date:   Thu, 15 Jul 2021 15:07:51 +0300
Message-Id: <20210715120752.29174-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715120752.29174-1-andriy.shevchenko@linux.intel.com>
References: <20210715120752.29174-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly introduced flag, when set, makes the flow to skip
the assumption that the caller will use an additional 2^scale
prescaler to get the desired clock rate.

Reported-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/clk/clk-fractional-divider.c | 2 +-
 include/linux/clk-provider.h         | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index 535d299af646..b2f9aae9f172 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -84,7 +84,7 @@ void clk_fractional_divider_general_approximation(struct clk_hw *hw,
 	 * by (scale - fd->nwidth) bits.
 	 */
 	scale = fls_long(*parent_rate / rate - 1);
-	if (scale > fd->nwidth)
+	if (scale > fd->nwidth && !(fd->flags & CLK_FRAC_DIVIDER_NO_PRESCALER))
 		rate <<= scale - fd->nwidth;
 
 	rational_best_approximation(rate, *parent_rate,
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index d83b829305c0..f74d0afe275f 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1001,6 +1001,10 @@ struct clk_hw *devm_clk_hw_register_fixed_factor(struct device *dev,
  * CLK_FRAC_DIVIDER_BIG_ENDIAN - By default little endian register accesses are
  *	used for the divider register.  Setting this flag makes the register
  *	accesses big endian.
+ * CLK_FRAC_DIVIDER_NO_PRESCALER - By default the resulting rate may be shifted
+ *	left by a few bits in case when the asked one is quite small to satisfy
+ *	the desired range of denominator. If the caller wants to get the best
+ *	rate without using an additional prescaler, this flag may be set.
  */
 struct clk_fractional_divider {
 	struct clk_hw	hw;
@@ -1022,6 +1026,7 @@ struct clk_fractional_divider {
 
 #define CLK_FRAC_DIVIDER_ZERO_BASED		BIT(0)
 #define CLK_FRAC_DIVIDER_BIG_ENDIAN		BIT(1)
+#define CLK_FRAC_DIVIDER_NO_PRESCALER		BIT(2)
 
 extern const struct clk_ops clk_fractional_divider_ops;
 struct clk *clk_register_fractional_divider(struct device *dev,
-- 
2.30.2

