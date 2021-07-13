Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B763C7A25
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 01:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbhGMX2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 19:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237025AbhGMX2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 19:28:14 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508DCC0613E9;
        Tue, 13 Jul 2021 16:25:22 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso2707876wmh.4;
        Tue, 13 Jul 2021 16:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GKBmLxZ/MZx7CczP7FFF2PJqNgRA/+uJ7jpUaxIibgg=;
        b=alXl50zMviQMFDIloQ0a/1ZCw7r0DFafRoauJg+Vu6ekY+mM1c0mbIBq1t35C61f7Y
         D07RylNZQpT3U9hFfhLRoNpOmFfPnTFfxA1XlhQCCmxBd1VhrCc0DMhfVenPwtQ7228P
         cO22gRHZzX2T6laObBY12AxrluscttOTOiYD85ccII1tR4u8ylbfMWmvV1QQdZ2pWRLN
         C8kR6Fmf+zhDxPpCF/FUkxMWqpxdqOc+EA6rO7XpqdeFDKWhYhD7Fqa4arcenukuk8bj
         liLpWRVhoRMHWoAcRGQDPMsUb5pWNQYVgVMqtQj1N/tk9eM9gUrdqLUCPoETxmEMzQf/
         xywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GKBmLxZ/MZx7CczP7FFF2PJqNgRA/+uJ7jpUaxIibgg=;
        b=NQln5D/UkMqH+ScjlUIL5SvZtdqEdrBNvZlJjte3DhTMmNqY0EleLTGXmTIeE5Ud1i
         OBA8YEDFRitlCLxfnQFtvSu5IpFc8+JptXUAJaVS7UcTEVXPYCzK7M9/w2tKcvPzZuLC
         IXakdLnk2Om6srO6HTaq8FaXkQk6y/+P8uSlQNF/2QglqMvCEdSjftnL/Gfz1yKYQv0b
         g2ediS6w55OcSGXapKAuqRT5GCs8/y4+T640uK4cYFRrd/QQ0JDkS51D7FGUcRkMtg5e
         lSBfbBZIFxw2KfuWtol7ro87SQMJ8HUvaboVzbP2kO5M0Zb8rObc6EJW9KqJgaCmtSAP
         rDZA==
X-Gm-Message-State: AOAM533iiqeymARqAhhjaxOh/69jfH4j26LPKA/ArSUIiEVlO6CMPvWr
        76izW1zym4RIZegaIz6ikNQ=
X-Google-Smtp-Source: ABdhPJzBag0KPk291EGfMDuaYOlTY06f0GZGtQM4YS2IVnro5tNWZuptm/z9rPtc0F49jHydCA88DA==
X-Received: by 2002:a05:600c:4ec8:: with SMTP id g8mr679508wmq.150.1626218720901;
        Tue, 13 Jul 2021 16:25:20 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c041-6f00-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c041:6f00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id o11sm3857390wmc.2.2021.07.13.16.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 16:25:20 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, jbrunet@baylibre.com,
        narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 5/6] clk: meson: meson8b: Make the video clock trees mutable
Date:   Wed, 14 Jul 2021 01:25:09 +0200
Message-Id: <20210713232510.3057750-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210713232510.3057750-1-martin.blumenstingl@googlemail.com>
References: <20210713232510.3057750-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch from the "_ro" clock op variants to the mutable ones for all
video clocks. This will allow the VPU driver to change the clocks as
needed for the different video output modes.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 76 ++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 21bc29455f0d..cd0f5bae24d4 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -207,7 +207,7 @@ static struct clk_regmap meson8b_hdmi_pll_dco = {
 	.hw.init = &(struct clk_init_data){
 		/* sometimes also called "HPLL" or "HPLL PLL" */
 		.name = "hdmi_pll_dco",
-		.ops = &meson_clk_pll_ro_ops,
+		.ops = &meson_clk_pll_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&hdmi_pll_dco_in.hw
 		},
@@ -224,7 +224,7 @@ static struct clk_regmap meson8b_hdmi_pll_lvds_out = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "hdmi_pll_lvds_out",
-		.ops = &clk_regmap_divider_ro_ops,
+		.ops = &clk_regmap_divider_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&meson8b_hdmi_pll_dco.hw
 		},
@@ -242,7 +242,7 @@ static struct clk_regmap meson8b_hdmi_pll_hdmi_out = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "hdmi_pll_hdmi_out",
-		.ops = &clk_regmap_divider_ro_ops,
+		.ops = &clk_regmap_divider_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&meson8b_hdmi_pll_dco.hw
 		},
@@ -1104,7 +1104,7 @@ static struct clk_regmap meson8b_vid_pll_lvds_en = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vid_pll_lvds_en",
-		.ops = &clk_regmap_gate_ro_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&meson8b_hdmi_pll_lvds_out.hw
 		},
@@ -1121,7 +1121,7 @@ static struct clk_regmap meson8b_vid_pll_in_sel = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vid_pll_in_sel",
-		.ops = &clk_regmap_mux_ro_ops,
+		.ops = &clk_regmap_mux_ops,
 		/*
 		 * TODO: depending on the SoC there is also a second parent:
 		 * Meson8: unknown
@@ -1143,7 +1143,7 @@ static struct clk_regmap meson8b_vid_pll_in_en = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vid_pll_in_en",
-		.ops = &clk_regmap_gate_ro_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&meson8b_vid_pll_in_sel.hw
 		},
@@ -1160,7 +1160,7 @@ static struct clk_regmap meson8b_vid_pll_pre_div = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vid_pll_pre_div",
-		.ops = &clk_regmap_divider_ro_ops,
+		.ops = &clk_regmap_divider_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&meson8b_vid_pll_in_en.hw
 		},
@@ -1177,7 +1177,7 @@ static struct clk_regmap meson8b_vid_pll_post_div = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vid_pll_post_div",
-		.ops = &clk_regmap_divider_ro_ops,
+		.ops = &clk_regmap_divider_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&meson8b_vid_pll_pre_div.hw
 		},
@@ -1194,7 +1194,7 @@ static struct clk_regmap meson8b_vid_pll = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vid_pll",
-		.ops = &clk_regmap_mux_ro_ops,
+		.ops = &clk_regmap_mux_ops,
 		/* TODO: parent 0x2 is vid_pll_pre_div_mult7_div2 */
 		.parent_hws = (const struct clk_hw *[]) {
 			&meson8b_vid_pll_pre_div.hw,
@@ -1213,7 +1213,7 @@ static struct clk_regmap meson8b_vid_pll_final_div = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vid_pll_final_div",
-		.ops = &clk_regmap_divider_ro_ops,
+		.ops = &clk_regmap_divider_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&meson8b_vid_pll.hw
 		},
@@ -1240,7 +1240,7 @@ static struct clk_regmap meson8b_vclk_in_sel = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vclk_in_sel",
-		.ops = &clk_regmap_mux_ro_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_hws = meson8b_vclk_mux_parent_hws,
 		.num_parents = ARRAY_SIZE(meson8b_vclk_mux_parent_hws),
 		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
@@ -1254,7 +1254,7 @@ static struct clk_regmap meson8b_vclk_in_en = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vclk_in_en",
-		.ops = &clk_regmap_gate_ro_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&meson8b_vclk_in_sel.hw
 		},
@@ -1270,7 +1270,7 @@ static struct clk_regmap meson8b_vclk_en = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vclk_en",
-		.ops = &clk_regmap_gate_ro_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&meson8b_vclk_in_en.hw
 		},
@@ -1286,7 +1286,7 @@ static struct clk_regmap meson8b_vclk_div1_gate = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vclk_div1_en",
-		.ops = &clk_regmap_gate_ro_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&meson8b_vclk_en.hw
 		},
@@ -1316,7 +1316,7 @@ static struct clk_regmap meson8b_vclk_div2_div_gate = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vclk_div2_en",
-		.ops = &clk_regmap_gate_ro_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&meson8b_vclk_div2_div.hw
 		},
@@ -1346,7 +1346,7 @@ static struct clk_regmap meson8b_vclk_div4_div_gate = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vclk_div4_en",
-		.ops = &clk_regmap_gate_ro_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&meson8b_vclk_div4_div.hw
 		},
@@ -1376,7 +1376,7 @@ static struct clk_regmap meson8b_vclk_div6_div_gate = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vclk_div6_en",
-		.ops = &clk_regmap_gate_ro_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&meson8b_vclk_div6_div.hw
 		},
@@ -1406,7 +1406,7 @@ static struct clk_regmap meson8b_vclk_div12_div_gate = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vclk_div12_en",
-		.ops = &clk_regmap_gate_ro_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&meson8b_vclk_div12_div.hw
 		},
@@ -1423,7 +1423,7 @@ static struct clk_regmap meson8b_vclk2_in_sel = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vclk2_in_sel",
-		.ops = &clk_regmap_mux_ro_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_hws = meson8b_vclk_mux_parent_hws,
 		.num_parents = ARRAY_SIZE(meson8b_vclk_mux_parent_hws),
 		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
@@ -1437,7 +1437,7 @@ static struct clk_regmap meson8b_vclk2_clk_in_en = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vclk2_in_en",
-		.ops = &clk_regmap_gate_ro_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&meson8b_vclk2_in_sel.hw
 		},
@@ -1453,7 +1453,7 @@ static struct clk_regmap meson8b_vclk2_clk_en = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vclk2_en",
-		.ops = &clk_regmap_gate_ro_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&meson8b_vclk2_clk_in_en.hw
 		},
@@ -1469,7 +1469,7 @@ static struct clk_regmap meson8b_vclk2_div1_gate = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vclk2_div1_en",
-		.ops = &clk_regmap_gate_ro_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&meson8b_vclk2_clk_en.hw
 		},
@@ -1499,7 +1499,7 @@ static struct clk_regmap meson8b_vclk2_div2_div_gate = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vclk2_div2_en",
-		.ops = &clk_regmap_gate_ro_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&meson8b_vclk2_div2_div.hw
 		},
@@ -1529,7 +1529,7 @@ static struct clk_regmap meson8b_vclk2_div4_div_gate = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vclk2_div4_en",
-		.ops = &clk_regmap_gate_ro_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&meson8b_vclk2_div4_div.hw
 		},
@@ -1559,7 +1559,7 @@ static struct clk_regmap meson8b_vclk2_div6_div_gate = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vclk2_div6_en",
-		.ops = &clk_regmap_gate_ro_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&meson8b_vclk2_div6_div.hw
 		},
@@ -1589,7 +1589,7 @@ static struct clk_regmap meson8b_vclk2_div12_div_gate = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vclk2_div12_en",
-		.ops = &clk_regmap_gate_ro_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&meson8b_vclk2_div12_div.hw
 		},
@@ -1614,7 +1614,7 @@ static struct clk_regmap meson8b_cts_enct_sel = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cts_enct_sel",
-		.ops = &clk_regmap_mux_ro_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_hws = meson8b_vclk_enc_mux_parent_hws,
 		.num_parents = ARRAY_SIZE(meson8b_vclk_enc_mux_parent_hws),
 		.flags = CLK_SET_RATE_PARENT,
@@ -1628,7 +1628,7 @@ static struct clk_regmap meson8b_cts_enct = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cts_enct",
-		.ops = &clk_regmap_gate_ro_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&meson8b_cts_enct_sel.hw
 		},
@@ -1645,7 +1645,7 @@ static struct clk_regmap meson8b_cts_encp_sel = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cts_encp_sel",
-		.ops = &clk_regmap_mux_ro_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_hws = meson8b_vclk_enc_mux_parent_hws,
 		.num_parents = ARRAY_SIZE(meson8b_vclk_enc_mux_parent_hws),
 		.flags = CLK_SET_RATE_PARENT,
@@ -1659,7 +1659,7 @@ static struct clk_regmap meson8b_cts_encp = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cts_encp",
-		.ops = &clk_regmap_gate_ro_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&meson8b_cts_encp_sel.hw
 		},
@@ -1676,7 +1676,7 @@ static struct clk_regmap meson8b_cts_enci_sel = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cts_enci_sel",
-		.ops = &clk_regmap_mux_ro_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_hws = meson8b_vclk_enc_mux_parent_hws,
 		.num_parents = ARRAY_SIZE(meson8b_vclk_enc_mux_parent_hws),
 		.flags = CLK_SET_RATE_PARENT,
@@ -1690,7 +1690,7 @@ static struct clk_regmap meson8b_cts_enci = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cts_enci",
-		.ops = &clk_regmap_gate_ro_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&meson8b_cts_enci_sel.hw
 		},
@@ -1707,7 +1707,7 @@ static struct clk_regmap meson8b_hdmi_tx_pixel_sel = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "hdmi_tx_pixel_sel",
-		.ops = &clk_regmap_mux_ro_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_hws = meson8b_vclk_enc_mux_parent_hws,
 		.num_parents = ARRAY_SIZE(meson8b_vclk_enc_mux_parent_hws),
 		.flags = CLK_SET_RATE_PARENT,
@@ -1721,7 +1721,7 @@ static struct clk_regmap meson8b_hdmi_tx_pixel = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "hdmi_tx_pixel",
-		.ops = &clk_regmap_gate_ro_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&meson8b_hdmi_tx_pixel_sel.hw
 		},
@@ -1746,7 +1746,7 @@ static struct clk_regmap meson8b_cts_encl_sel = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cts_encl_sel",
-		.ops = &clk_regmap_mux_ro_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_hws = meson8b_vclk2_enc_mux_parent_hws,
 		.num_parents = ARRAY_SIZE(meson8b_vclk2_enc_mux_parent_hws),
 		.flags = CLK_SET_RATE_PARENT,
@@ -1760,7 +1760,7 @@ static struct clk_regmap meson8b_cts_encl = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cts_encl",
-		.ops = &clk_regmap_gate_ro_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&meson8b_cts_encl_sel.hw
 		},
@@ -1777,7 +1777,7 @@ static struct clk_regmap meson8b_cts_vdac0_sel = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cts_vdac0_sel",
-		.ops = &clk_regmap_mux_ro_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_hws = meson8b_vclk2_enc_mux_parent_hws,
 		.num_parents = ARRAY_SIZE(meson8b_vclk2_enc_mux_parent_hws),
 		.flags = CLK_SET_RATE_PARENT,
@@ -1791,7 +1791,7 @@ static struct clk_regmap meson8b_cts_vdac0 = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cts_vdac0",
-		.ops = &clk_regmap_gate_ro_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&meson8b_cts_vdac0_sel.hw
 		},
-- 
2.32.0

