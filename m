Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603E53C829E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 12:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239060AbhGNKUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 06:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239013AbhGNKUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 06:20:31 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6277DC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 03:17:39 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:39cc:190a:2775:cfe7])
        by albert.telenet-ops.be with bizsmtp
        id UyHd2500Y1ccfby06yHdua; Wed, 14 Jul 2021 12:17:37 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m3bxR-0016dr-J9; Wed, 14 Jul 2021 12:17:37 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m3bxR-00A6PD-67; Wed, 14 Jul 2021 12:17:37 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH resend] clk: Align provider-specific CLK_* bit definitions
Date:   Wed, 14 Jul 2021 12:17:36 +0200
Message-Id: <5468cd9e50cda8fc59cb6baab9413c6c0de1a974.1626257689.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The definition of CLK_MULTIPLIER_ROUND_CLOSEST is not aligned to the two
bit definitions next to it.  A deeper inspection reveals that the
alignment of CLK_MULTIPLIER_ROUND_CLOSEST does match the most common
alignment.

Align the bit definitions for the various provider types throughout the
file at 40 columns, to increase uniformity.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/clk-provider.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index d83b829305c05d40..7be81d5fcf8c4844 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -342,7 +342,7 @@ struct clk_fixed_rate {
 	unsigned long	flags;
 };
 
-#define CLK_FIXED_RATE_PARENT_ACCURACY		BIT(0)
+#define CLK_FIXED_RATE_PARENT_ACCURACY	BIT(0)
 
 extern const struct clk_ops clk_fixed_rate_ops;
 struct clk_hw *__clk_hw_register_fixed_rate(struct device *dev,
@@ -1020,8 +1020,8 @@ struct clk_fractional_divider {
 
 #define to_clk_fd(_hw) container_of(_hw, struct clk_fractional_divider, hw)
 
-#define CLK_FRAC_DIVIDER_ZERO_BASED		BIT(0)
-#define CLK_FRAC_DIVIDER_BIG_ENDIAN		BIT(1)
+#define CLK_FRAC_DIVIDER_ZERO_BASED	BIT(0)
+#define CLK_FRAC_DIVIDER_BIG_ENDIAN	BIT(1)
 
 extern const struct clk_ops clk_fractional_divider_ops;
 struct clk *clk_register_fractional_divider(struct device *dev,
@@ -1069,9 +1069,9 @@ struct clk_multiplier {
 
 #define to_clk_multiplier(_hw) container_of(_hw, struct clk_multiplier, hw)
 
-#define CLK_MULTIPLIER_ZERO_BYPASS		BIT(0)
+#define CLK_MULTIPLIER_ZERO_BYPASS	BIT(0)
 #define CLK_MULTIPLIER_ROUND_CLOSEST	BIT(1)
-#define CLK_MULTIPLIER_BIG_ENDIAN		BIT(2)
+#define CLK_MULTIPLIER_BIG_ENDIAN	BIT(2)
 
 extern const struct clk_ops clk_multiplier_ops;
 
-- 
2.25.1

