Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721F2403EE9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 20:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349554AbhIHSPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 14:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349202AbhIHSPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 14:15:08 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCCFC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 11:14:00 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 17so3491064pgp.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 11:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uzvU0TWDqoO4AhItKda+Ka4vpknel8tSLxFVqVBoaHc=;
        b=dWLekvtSO0q46ozawqJd+04F7FuB57Cc0/SYjtEAJ/zPKT1iReWuzDc8VmgpGffCxq
         74mKvOXwSMsvA3xgPC5At98vactbCz5vxbdwYWaPWteBLn2zgIWeJjocuti+bMFGoqk3
         gXkiZClJdgCsQVK/pYBE9UTCRL4aEhZ4ZENpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uzvU0TWDqoO4AhItKda+Ka4vpknel8tSLxFVqVBoaHc=;
        b=TIV1Z20ZaYynU+gsde9DbKKzh+RRO6BQQwXVwNFDiyTYrrW6/phPGa3nEhiyTXEGqz
         tyvziBlcXTHtYlJ2Ap66PVLzrkoRYn75ouvLlRm1GE3FLCFItJ6C14Ll2KrTqE4pm1rI
         EVWib+oV+XZXnrSlDg5WTLZr6mN4C8FT8xsWmadK2JakFH/8OPIaUOkmi+8+pFpcwOOF
         XfREsprOyGkeP6oDdlfF7JSIkwRLhji7FEc6kkYzV2bR2pgpueUIkeZICvhLq5REX1/k
         8RUmdwYS+5acBtrK+2mRPiDzzUa1fzcH1gcyi73/n65CgLRuXuOIpwFUZz1w5+bDA//o
         NaBw==
X-Gm-Message-State: AOAM533pyqL71vHam4/hin9TOlxf80NOC1vrx6gliP3qXo9ykx7pzCEP
        UdFkNftFbWnnrQszAGoX6ZY78A==
X-Google-Smtp-Source: ABdhPJyDQMGH0+RxUGQtHUeCYv4lJd35HOoioyP4NMAPxkHx4TB4s0fz74029ULAwuaRpQEaZQyUDw==
X-Received: by 2002:a63:584:: with SMTP id 126mr4916161pgf.165.1631124839684;
        Wed, 08 Sep 2021 11:13:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7556:e88d:6fba:e1d0])
        by smtp.gmail.com with UTF8SMTPSA id o3sm2709858pji.26.2021.09.08.11.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 11:13:58 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 1/3] clk: rockchip: rk3399: make CPU clocks critical
Date:   Wed,  8 Sep 2021 11:13:38 -0700
Message-Id: <20210908111337.v2.1.I006bb36063555079b1a88f01d20e38d7e4705ae0@changeid>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU clocks don't currently have any owner (e.g., cpufreq-dt doesn't
enable() them -- and even if it did, it's not early enough compared to
other consumers -- nor does arch/arm64/kernel/smp.c), and instead are
simply assumed to be "on" all the time.

They are also parents of a few other clocks which haven't been
previously exposed for other devices to consume. If we want to expose
those clocks, then the common clock framework may eventually choose to
disable their parents (including the CPU PLLs) -- which is no fun for
anyone.

Thus, mark the CPU clocks as critical, to prevent them from being
disabled implicitly.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
  - New, split from the patch that requires this change

 drivers/clk/rockchip/clk-rk3399.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 62a4f2543960..0ac9c72c4ee8 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -1514,7 +1514,10 @@ static const char *const rk3399_cru_critical_clocks[] __initconst = {
 	"aclk_vio_noc",
 
 	/* ddrc */
-	"sclk_ddrc"
+	"sclk_ddrc",
+
+	"armclkl",
+	"armclkb",
 };
 
 static const char *const rk3399_pmucru_critical_clocks[] __initconst = {
@@ -1549,9 +1552,6 @@ static void __init rk3399_clk_init(struct device_node *np)
 	rockchip_clk_register_branches(ctx, rk3399_clk_branches,
 				  ARRAY_SIZE(rk3399_clk_branches));
 
-	rockchip_clk_protect_critical(rk3399_cru_critical_clocks,
-				      ARRAY_SIZE(rk3399_cru_critical_clocks));
-
 	rockchip_clk_register_armclk(ctx, ARMCLKL, "armclkl",
 			mux_armclkl_p, ARRAY_SIZE(mux_armclkl_p),
 			&rk3399_cpuclkl_data, rk3399_cpuclkl_rates,
@@ -1562,6 +1562,9 @@ static void __init rk3399_clk_init(struct device_node *np)
 			&rk3399_cpuclkb_data, rk3399_cpuclkb_rates,
 			ARRAY_SIZE(rk3399_cpuclkb_rates));
 
+	rockchip_clk_protect_critical(rk3399_cru_critical_clocks,
+				      ARRAY_SIZE(rk3399_cru_critical_clocks));
+
 	rockchip_register_softrst(np, 21, reg_base + RK3399_SOFTRST_CON(0),
 				  ROCKCHIP_SOFTRST_HIWORD_MASK);
 
-- 
2.33.0.153.gba50c8fa24-goog

