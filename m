Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3ADE34FDB5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 12:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbhCaKAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 06:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234985AbhCaJ7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:59:51 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE4AC061760
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:59:50 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:ada2:b4da:6568:5ad5])
        by andre.telenet-ops.be with bizsmtp
        id mxzc2400c5W9KJv01xzcoU; Wed, 31 Mar 2021 11:59:49 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lRXdQ-00BseR-3H; Wed, 31 Mar 2021 11:59:36 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lRXdP-001cdD-ED; Wed, 31 Mar 2021 11:59:35 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        John Ogness <john.ogness@linutronix.de>,
        Gary R Hook <gary.hook@amd.com>,
        Marco Elver <elver@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-embedded@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] clk: Align provider-specific CLK_* bit definitions
Date:   Wed, 31 Mar 2021 11:59:19 +0200
Message-Id: <505e19bac2deb6015e76391ce7ad044c43499681.1617184676.git.geert+renesas@glider.be>
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
index 58f6fe866ae9b797..8f37829565f9640e 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -342,7 +342,7 @@ struct clk_fixed_rate {
 	unsigned long	flags;
 };
 
-#define CLK_FIXED_RATE_PARENT_ACCURACY		BIT(0)
+#define CLK_FIXED_RATE_PARENT_ACCURACY	BIT(0)
 
 extern const struct clk_ops clk_fixed_rate_ops;
 struct clk_hw *__clk_hw_register_fixed_rate(struct device *dev,
@@ -984,8 +984,8 @@ struct clk_fractional_divider {
 
 #define to_clk_fd(_hw) container_of(_hw, struct clk_fractional_divider, hw)
 
-#define CLK_FRAC_DIVIDER_ZERO_BASED		BIT(0)
-#define CLK_FRAC_DIVIDER_BIG_ENDIAN		BIT(1)
+#define CLK_FRAC_DIVIDER_ZERO_BASED	BIT(0)
+#define CLK_FRAC_DIVIDER_BIG_ENDIAN	BIT(1)
 
 extern const struct clk_ops clk_fractional_divider_ops;
 struct clk *clk_register_fractional_divider(struct device *dev,
@@ -1033,9 +1033,9 @@ struct clk_multiplier {
 
 #define to_clk_multiplier(_hw) container_of(_hw, struct clk_multiplier, hw)
 
-#define CLK_MULTIPLIER_ZERO_BYPASS		BIT(0)
+#define CLK_MULTIPLIER_ZERO_BYPASS	BIT(0)
 #define CLK_MULTIPLIER_ROUND_CLOSEST	BIT(1)
-#define CLK_MULTIPLIER_BIG_ENDIAN		BIT(2)
+#define CLK_MULTIPLIER_BIG_ENDIAN	BIT(2)
 
 extern const struct clk_ops clk_multiplier_ops;
 
-- 
2.25.1

