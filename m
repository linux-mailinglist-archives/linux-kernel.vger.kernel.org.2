Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFE3397086
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 11:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbhFAJqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 05:46:12 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:22229 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233160AbhFAJqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:46:11 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Uat98i9_1622540656;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Uat98i9_1622540656)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Jun 2021 17:44:17 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     paul.walmsley@sifive.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] clk: analogbits: Fix kernel-doc
Date:   Tue,  1 Jun 2021 17:44:11 +0800
Message-Id: <1622540651-99141-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix function name in wrpll-cln28hpc.c kernel-doc comment
to remove a warning found by clang(make W=1 LLVM=1).

drivers/clk/analogbits/wrpll-cln28hpc.c:227: warning: expecting
prototype for wrpll_configure(). Prototype was for
wrpll_configure_for_rate() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/clk/analogbits/wrpll-cln28hpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/analogbits/wrpll-cln28hpc.c b/drivers/clk/analogbits/wrpll-cln28hpc.c
index 776ead3..3b19475 100644
--- a/drivers/clk/analogbits/wrpll-cln28hpc.c
+++ b/drivers/clk/analogbits/wrpll-cln28hpc.c
@@ -198,7 +198,7 @@ static int __wrpll_update_parent_rate(struct wrpll_cfg *c,
 }
 
 /**
- * wrpll_configure() - compute PLL configuration for a target rate
+ * wrpll_configure_for_rate() - compute PLL configuration for a target rate
  * @c: ptr to a struct wrpll_cfg record to write into
  * @target_rate: target PLL output clock rate (post-Q-divider)
  * @parent_rate: PLL input refclk rate (pre-R-divider)
-- 
1.8.3.1

