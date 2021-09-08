Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F4F403EEB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 20:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349668AbhIHSPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 14:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349590AbhIHSPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 14:15:10 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB99C061757
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 11:14:02 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t1so3498618pgv.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 11:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YmaBqKj8o4HmKcMeIl0Rd4QT1PMQFox+evWowfdT4pM=;
        b=LhDZLw+XEOIsX47v4NpnWSsriew4EbKSYY+nTXSZ9TmzNi61j7u4637SNRUlYjyoO8
         4R4YpmU0eL3um0lTV+i052dCvVbo4xV0OYKht0oajmhCceVIlOxvjPyxbVM/YbGWSWBS
         ZIRkmc+hJiyaUDFaiaiH2UcD7B2bPGrHAFmv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YmaBqKj8o4HmKcMeIl0Rd4QT1PMQFox+evWowfdT4pM=;
        b=KOqxKjkNRtLS6U44g1GSjOR146q9gW5/zvQVCS9RzlJKCX6agvZ4Nav9+ibflOd4FA
         zGZlpz2k0aUivWaWGxMGvp9zj6sb6aSNvDi4u5h4XRaVsiY81pqo7VOPRwgVvz6OzA04
         Hy1stEs/xtl/yBH0En8tDGbLu6FwP3M/95tLjPp7BuPQ8ZUekBaN0omNulcXOk82s7aZ
         0giIPR6Zvgw0vHRKQafL8RoxXJEP+HX09PtEr99FhuGcVYppqnqIODrUiD3k6z59Ybfi
         Gk5YEVMmt1+CORljNHMt0tvvF0EdmGlEp+5CGHJZcrIadmU4iJsGe6lMfSWxnCOYijOU
         FSoQ==
X-Gm-Message-State: AOAM531pTlKYI1xLVuzOkWsdOw4+CSTW+q+xuDWFPUkJnVfQ3aZXkszY
        mwtZBAC4HaB4BzJDIRwNPNgKuw==
X-Google-Smtp-Source: ABdhPJz7vRfq/pAFYK+fNsy+aJ/Sx1OQI+A2rftCimRi2r9//7V/EaLJIn03rX6MPvX0ZYsKroiejA==
X-Received: by 2002:a63:ef58:: with SMTP id c24mr4826337pgk.299.1631124841813;
        Wed, 08 Sep 2021 11:14:01 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7556:e88d:6fba:e1d0])
        by smtp.gmail.com with UTF8SMTPSA id e19sm2982086pfi.139.2021.09.08.11.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 11:14:01 -0700 (PDT)
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
Subject: [PATCH v2 2/3] clk: rockchip: rk3399: expose PCLK_COREDBG_{B,L}
Date:   Wed,  8 Sep 2021 11:13:39 -0700
Message-Id: <20210908111337.v2.2.If29cd838efbcee4450a62b8d84a99b23c86e0a3f@changeid>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
In-Reply-To: <20210908111337.v2.1.I006bb36063555079b1a88f01d20e38d7e4705ae0@changeid>
References: <20210908111337.v2.1.I006bb36063555079b1a88f01d20e38d7e4705ae0@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have DT IDs for PCLK_COREDBG_L and PCLK_COREDBG_B, but we don't
actually expose them.

Note that this requires the previous patch (making "armclkl" and
"armclkb" into "critical" clocks) to prevent these clocks from taking
down the CPU.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
  - Split "CPU clocks are critical" to a new patch, to make it more
    obvious

 drivers/clk/rockchip/clk-rk3399.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 0ac9c72c4ee8..53ed5cca335b 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -481,7 +481,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 	COMPOSITE_NOMUX(0, "atclk_core_l", "armclkl", CLK_IGNORE_UNUSED,
 			RK3399_CLKSEL_CON(1), 0, 5, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RK3399_CLKGATE_CON(0), 5, GFLAGS),
-	COMPOSITE_NOMUX(0, "pclk_dbg_core_l", "armclkl", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(PCLK_COREDBG_L, "pclk_dbg_core_l", "armclkl", CLK_IGNORE_UNUSED,
 			RK3399_CLKSEL_CON(1), 8, 5, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RK3399_CLKGATE_CON(0), 6, GFLAGS),
 
@@ -531,7 +531,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 	GATE(ACLK_GIC_ADB400_CORE_B_2_GIC, "aclk_core_adb400_core_b_2_gic", "armclkb", CLK_IGNORE_UNUSED,
 			RK3399_CLKGATE_CON(14), 4, GFLAGS),
 
-	DIV(0, "pclken_dbg_core_b", "pclk_dbg_core_b", CLK_IGNORE_UNUSED,
+	DIV(PCLK_COREDBG_B, "pclken_dbg_core_b", "pclk_dbg_core_b", CLK_IGNORE_UNUSED,
 			RK3399_CLKSEL_CON(3), 13, 2, DFLAGS | CLK_DIVIDER_READ_ONLY),
 
 	GATE(0, "pclk_dbg_cxcs_pd_core_b", "pclk_dbg_core_b", CLK_IGNORE_UNUSED,
-- 
2.33.0.153.gba50c8fa24-goog

