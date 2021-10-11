Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DF842980B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 22:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbhJKUTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 16:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbhJKUTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 16:19:10 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64920C061570;
        Mon, 11 Oct 2021 13:17:09 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id E99401F5FA;
        Mon, 11 Oct 2021 22:17:04 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/msm/dsi: Use division result from div_u64_rem in 7nm and 14nm PLL
Date:   Mon, 11 Oct 2021 22:16:40 +0200
Message-Id: <20211011201642.167700-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

div_u64_rem provides the result of the division and additionally the
remainder; don't use this function to solely calculate the remainder
while calculating the division again with div_u64.

A similar improvement was applied earlier to the 10nm pll in
5c191fef4ce2 ("drm/msm/dsi_pll_10nm: Fix dividing the same numbers
twice").

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---

Changes in v2:
- Corrected two typos in the first commit-message sentence.

 drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c | 4 +---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c  | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
index 9a959a5dcc1e..de3c6556a587 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
@@ -215,9 +215,7 @@ static void pll_14nm_dec_frac_calc(struct dsi_pll_14nm *pll, struct dsi_pll_conf
 	DBG("vco_clk_rate=%lld ref_clk_rate=%lld", vco_clk_rate, fref);

 	dec_start_multiple = div_u64(vco_clk_rate * multiplier, fref);
-	div_u64_rem(dec_start_multiple, multiplier, &div_frac_start);
-
-	dec_start = div_u64(dec_start_multiple, multiplier);
+	dec_start = div_u64_rem(dec_start_multiple, multiplier, &div_frac_start);

 	pconf->dec_start = (u32)dec_start;
 	pconf->div_frac_start = div_frac_start;
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
index 9f7c408325ba..36eb6109cb88 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
@@ -114,9 +114,7 @@ static void dsi_pll_calc_dec_frac(struct dsi_pll_7nm *pll, struct dsi_pll_config

 	multiplier = 1 << FRAC_BITS;
 	dec_multiple = div_u64(pll_freq * multiplier, divider);
-	div_u64_rem(dec_multiple, multiplier, &frac);
-
-	dec = div_u64(dec_multiple, multiplier);
+	dec = div_u64_rem(dec_multiple, multiplier, &frac);

 	if (!(pll->phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V4_1))
 		config->pll_clock_inverters = 0x28;
--
2.33.0

