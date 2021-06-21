Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7746D3AE9D4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 15:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhFUNQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 09:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhFUNQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 09:16:11 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA9DC061756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 06:13:53 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b3so9361456wrm.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 06:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2j5aqshvMmv3SFWLZl++fZj3Ut8b4ASWXCLeBWk+mKA=;
        b=UT4A6/tyLrxmzFAtlnMFgnjpyeuVjy8i3JweZRE6JO0MkNe02kYE6YnkxEZXhYGMZ5
         ZY+pplPGwLhnW7waLUJQ85CramDYgsSUEE6K9mdDWkc3q087EvJRuFSjbALch+GTZMCK
         SsLoqSOGLvMQ2MkkFHtWTQuFKZP7/X0jwbQSvWcj6yBWf2ZD6HWrKhbKZ1XbF71NVI4A
         szhoIqKRo5qUGZHZSfUzJqH/U1SQfqvEpSob8xfHEYapMXHk+1vJLvPXDgaNQGWwh1cb
         lm4rw4kJv1l/365B/h6+rexzYQQ3gOjP0HhBnsI28i9h3gonHwQ5qhwWTF2VrlhXaJr1
         pNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=2j5aqshvMmv3SFWLZl++fZj3Ut8b4ASWXCLeBWk+mKA=;
        b=ZL3KSs12sQC9Eu4H41aQeFCxu+v4Vb9xLwGjcWQnDbWxxL180SWd9B/p/W0Eu1udfl
         Zi901nE4jaT8qVBNXaOW6DrsA4xtrJT84faPzUdH9ZPgrS9XWAUCdPIbCQuy95nOfXUt
         vGWQzGhwScu+S1WzbdQdLuHtBdRWzIxm4s1zBsOBXPmTDs362a1PO0puQ9TqQdGwG/w7
         ia0DbsLHXMLEKM+H+TUHdlvENjuZ9oKZLiso8F1oagkriVemBPit15BxiqI2HSmmAsZW
         J6P+wbmKMgm5oaFPu+jHycTauV/yoKfLTD31zQOJzGO/RkQhXhx9B9g8eK2o10fFO12L
         Ubig==
X-Gm-Message-State: AOAM530KVdVTysYsyUFSMIFdL5DXTHQG9I41BmdSgav9Fmv0p4gC7XZ7
        c0ww+DAsqX+PgqaLUce1HojPjv47mUtt1vB8
X-Google-Smtp-Source: ABdhPJxHYIboQGK0uRn5qPAdEup5HvcA17rhoedHpQq/bhwfl8l3cnFtHaT+ODFqG07ayJQaZD3qQw==
X-Received: by 2002:a5d:6daf:: with SMTP id u15mr28295933wrs.400.1624281231767;
        Mon, 21 Jun 2021 06:13:51 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::648])
        by smtp.gmail.com with ESMTPSA id y7sm13147550wma.22.2021.06.21.06.13.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jun 2021 06:13:51 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH v2] clk: zynqmp: fix compile testing without ZYNQMP_FIRMWARE
Date:   Mon, 21 Jun 2021 15:13:47 +0200
Message-Id: <fdee3a286defb103aa07b5493b805d1987885165.1624281224.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When the firmware code is disabled, the incomplete error handling
in the clk driver causes compile-time warnings:

drivers/clk/zynqmp/pll.c: In function 'zynqmp_pll_recalc_rate':
drivers/clk/zynqmp/pll.c:147:29: error: 'fbdiv' is used uninitialized [-Werror=uninitialized]
  147 |         rate =  parent_rate * fbdiv;
      |                 ~~~~~~~~~~~~^~~~~~~
In function 'zynqmp_pll_get_mode',
    inlined from 'zynqmp_pll_recalc_rate' at drivers/clk/zynqmp/pll.c:148:6:
drivers/clk/zynqmp/pll.c:61:27: error: 'ret_payload' is used uninitialized [-Werror=uninitialized]
   61 |         return ret_payload[1];
      |                ~~~~~~~~~~~^~~
drivers/clk/zynqmp/pll.c: In function 'zynqmp_pll_recalc_rate':
drivers/clk/zynqmp/pll.c:53:13: note: 'ret_payload' declared here
   53 |         u32 ret_payload[PAYLOAD_ARG_CNT];
      |             ^~~~~~~~~~~
drivers/clk/zynqmp/clk-mux-zynqmp.c: In function 'zynqmp_clk_mux_get_parent':
drivers/clk/zynqmp/clk-mux-zynqmp.c:57:16: error: 'val' is used uninitialized [-Werror=uninitialized]
   57 |         return val;
      |                ^~~

As it was apparently intentional to support this for compile testing
purposes, change the code to have just enough error handling for the
compiler to not notice the remaining bugs.

Fixes: 21f237534661 ("clk: zynqmp: Drop dependency on ARCH_ZYNQMP")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
Based on discussion here
Link: https://lore.kernel.org/r/20210421134844.3297838-1-arnd@kernel.org
I have updated error return value which I got from clock core based on
error cases.

zynqmp_clk_mux_get_parent() should return num_parents() as error defined in
clk_core_get_parent_by_index() where num_parents is incorrect index.

Extend zynqmp_pll_get_mode() with PLL_MODE_ERROR to handle error case.

zynqmp_pll_recalc_rate() returns 0 because __clk_core_init() consider 0 as
default rate. But maybe -1ul which was used by Arnd is also good option.

---
 drivers/clk/zynqmp/clk-mux-zynqmp.c | 10 ++++++++--
 drivers/clk/zynqmp/pll.c            | 15 ++++++++++-----
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/zynqmp/clk-mux-zynqmp.c b/drivers/clk/zynqmp/clk-mux-zynqmp.c
index 06194149be83..d576c900dee0 100644
--- a/drivers/clk/zynqmp/clk-mux-zynqmp.c
+++ b/drivers/clk/zynqmp/clk-mux-zynqmp.c
@@ -38,7 +38,7 @@ struct zynqmp_clk_mux {
  * zynqmp_clk_mux_get_parent() - Get parent of clock
  * @hw:		handle between common and hardware-specific interfaces
  *
- * Return: Parent index
+ * Return: Parent index on success or number of parents in case of error
  */
 static u8 zynqmp_clk_mux_get_parent(struct clk_hw *hw)
 {
@@ -50,9 +50,15 @@ static u8 zynqmp_clk_mux_get_parent(struct clk_hw *hw)
 
 	ret = zynqmp_pm_clock_getparent(clk_id, &val);
 
-	if (ret)
+	if (ret) {
 		pr_warn_once("%s() getparent failed for clock: %s, ret = %d\n",
 			     __func__, clk_name, ret);
+		/*
+		 * clk_core_get_parent_by_index() takes num_parents as incorrect
+		 * index which is exactly what I want to return here
+		 */
+		return clk_hw_get_num_parents(hw);
+	}
 
 	return val;
 }
diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
index abe6afbf3407..3fe4d21227d0 100644
--- a/drivers/clk/zynqmp/pll.c
+++ b/drivers/clk/zynqmp/pll.c
@@ -31,8 +31,9 @@ struct zynqmp_pll {
 #define PS_PLL_VCO_MAX 3000000000UL
 
 enum pll_mode {
-	PLL_MODE_INT,
-	PLL_MODE_FRAC,
+	PLL_MODE_INT = 0,
+	PLL_MODE_FRAC = 1,
+	PLL_MODE_ERROR = 2,
 };
 
 #define FRAC_OFFSET 0x8
@@ -54,9 +55,11 @@ static inline enum pll_mode zynqmp_pll_get_mode(struct clk_hw *hw)
 	int ret;
 
 	ret = zynqmp_pm_get_pll_frac_mode(clk_id, ret_payload);
-	if (ret)
+	if (ret) {
 		pr_warn_once("%s() PLL get frac mode failed for %s, ret = %d\n",
 			     __func__, clk_name, ret);
+		return PLL_MODE_ERROR;
+	}
 
 	return ret_payload[1];
 }
@@ -126,7 +129,7 @@ static long zynqmp_pll_round_rate(struct clk_hw *hw, unsigned long rate,
  * @hw:			Handle between common and hardware-specific interfaces
  * @parent_rate:	Clock frequency of parent clock
  *
- * Return: Current clock frequency
+ * Return: Current clock frequency or 0 in case of error
  */
 static unsigned long zynqmp_pll_recalc_rate(struct clk_hw *hw,
 					    unsigned long parent_rate)
@@ -140,9 +143,11 @@ static unsigned long zynqmp_pll_recalc_rate(struct clk_hw *hw,
 	int ret;
 
 	ret = zynqmp_pm_clock_getdivider(clk_id, &fbdiv);
-	if (ret)
+	if (ret) {
 		pr_warn_once("%s() get divider failed for %s, ret = %d\n",
 			     __func__, clk_name, ret);
+		return 0ul;
+	}
 
 	rate =  parent_rate * fbdiv;
 	if (zynqmp_pll_get_mode(hw) == PLL_MODE_FRAC) {
-- 
2.32.0

