Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767593C7A23
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 01:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237082AbhGMX2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 19:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236989AbhGMX2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 19:28:12 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDBFC061786;
        Tue, 13 Jul 2021 16:25:20 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id i2-20020a05600c3542b02902058529ea07so232329wmq.3;
        Tue, 13 Jul 2021 16:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nrJy8AHK/eMoKNEana9935MG2OFHXBd4iLiXE078rqM=;
        b=MqMNlGZvFCWJoDGiOyBWk8cuaLbaS9ZVVzThxAMnItmnNYXYKWoDzHLG6CeD5dnTDN
         wtIt6z6CPUOgVsYo2hHPzFq3nqBCWEBdi0U/ijUKqsJX2lEI1NUYb7cpxfM6Ea4w/qbJ
         yIu2ERoxxJTvLQYT0vWFmX/ro4895EJPeoW/QC1aHFoo61SHhvjHlJ48e2COb6Z1ZaeO
         oRfkY8diLLbdp2gCD5q1RdpaYYJPCTwdMdA+dkQxzrEIuZLYB1Yck9iCuv84n8R1A5df
         V5j1t/NcEFX25uxjmzoUpGbm6NAY+Rlz1I1u7TddCzI5ARKLK5Ln7NiHUJkQjdd5MGv9
         vcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nrJy8AHK/eMoKNEana9935MG2OFHXBd4iLiXE078rqM=;
        b=KseJP43Hl7gLdm21Imxuvcnn94wxQmXa9ONg5N/gxL4xmvFqXS1VFlAgqsFf4WP41w
         IFh+oh4V1q6LvdYldCXGhDouGADXUEEdLlbNkA3c/KB/nBhv583ZO3+K0AOsKJQYuVJa
         x1S+JWtUAP2VBr5CTH+27Hy14ZbipiBDVwEEvhGH3UL3pPULNn2G1oPjKaNLIdWajVM+
         8N5w6DHTviBX3rKhOjqtdlyXpNQN3U7QsBe1ceUiFrWJVATv3t3lcfLCNhNBU3JKgkIz
         kbIwFuLs6VRgK3m31CgLg9HoIYUoz9yLGLAzvffNF6fsUq1S7l9Uh0xGOHLqk9DXpa6v
         Ra6g==
X-Gm-Message-State: AOAM532kb+/203ac7SKLEI2reKAYddQNvC25iPdtj2PgYRulMWtJmurx
        e9s+aho3EqgV/Gsf9qK0wj7wJejM+xg=
X-Google-Smtp-Source: ABdhPJy0vtt/jzN8eYmaXvrmdL/LH5RbSaen7X/593wZJsexT5Y7x73sJJQ2LQvexSearVkr/4xcmw==
X-Received: by 2002:a05:600c:4e8f:: with SMTP id f15mr7912526wmq.174.1626218719597;
        Tue, 13 Jul 2021 16:25:19 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c041-6f00-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c041:6f00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id o11sm3857390wmc.2.2021.07.13.16.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 16:25:19 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, jbrunet@baylibre.com,
        narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/6] clk: meson: meson8b: Add the HDMI PLL M/N parameters
Date:   Wed, 14 Jul 2021 01:25:07 +0200
Message-Id: <20210713232510.3057750-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210713232510.3057750-1-martin.blumenstingl@googlemail.com>
References: <20210713232510.3057750-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 3.10 vendor kernel uses only specific HDMI PLL M/N parameter
combinations. The PLL won't lock for values smaller than 50 if the
internal doubling (which is yet unknown how to use it) is disabled.
However, when this doubling is enabled then the values smaller than 50
will lock just fine. The only restriction for values greater than 50 is
that the resulting frequency must not exceed the 3.0GHz limit.

These values are taken from the endlessm 3.10 kernel which includes
additional M/N combinations for some VESA and 75Hz display modes.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 9ccffbfe44e5..8f29d26ed726 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -118,6 +118,27 @@ static struct clk_regmap meson8b_fixed_pll = {
 	},
 };
 
+static const struct pll_params_table hdmi_pll_params_table[] = {
+	PLL_PARAMS(40, 1),
+	PLL_PARAMS(42, 1),
+	PLL_PARAMS(44, 1),
+	PLL_PARAMS(45, 1),
+	PLL_PARAMS(49, 1),
+	PLL_PARAMS(52, 1),
+	PLL_PARAMS(54, 1),
+	PLL_PARAMS(56, 1),
+	PLL_PARAMS(59, 1),
+	PLL_PARAMS(60, 1),
+	PLL_PARAMS(61, 1),
+	PLL_PARAMS(62, 1),
+	PLL_PARAMS(64, 1),
+	PLL_PARAMS(66, 1),
+	PLL_PARAMS(68, 1),
+	PLL_PARAMS(71, 1),
+	PLL_PARAMS(82, 1),
+	{ /* sentinel */ }
+};
+
 static struct clk_regmap meson8b_hdmi_pll_dco = {
 	.data = &(struct meson_clk_pll_data){
 		.en = {
@@ -150,6 +171,7 @@ static struct clk_regmap meson8b_hdmi_pll_dco = {
 			.shift   = 29,
 			.width   = 1,
 		},
+		.table = hdmi_pll_params_table,
 	},
 	.hw.init = &(struct clk_init_data){
 		/* sometimes also called "HPLL" or "HPLL PLL" */
-- 
2.32.0

