Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6B239B0EB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 05:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhFDDdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 23:33:01 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:37501 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhFDDdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 23:33:00 -0400
Received: by mail-pj1-f48.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so6663565pjs.2;
        Thu, 03 Jun 2021 20:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=icn8mgRDWXOjaY3g7V23n8mNEvlwuJBMtHS+GFwA3/g=;
        b=qYGonMOwk1vaLYuJYt+gYxeqPX10Cu+7L3mSe8vPIcvK54bSWxmMCnDgKuBDFJ+e/7
         FuAAr4uBvg9CgZ9iU3HMuDvhxMS0nNcbAHs6KwjZRHa/HvbM4qsAK6aQTjvIw7PLafmb
         3sieICe03yYs2BZtACMaeul9QYeBBvAmgfW3VIPoSLxN80hsgakyVQrpoM/d0o4Kgosj
         CH2lH/fD2FdRGLowzhULxWpTg9dnGSm7En4rk2z5j+e4Et3hd8MhzxGAkAH5//3tlueS
         AR+oTrDPLj4llMuvrcAbwsE4As/TM+5MHOE6Iw1WxR8cI1oy6XY4F1l19y9UErDcwIzm
         AQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=icn8mgRDWXOjaY3g7V23n8mNEvlwuJBMtHS+GFwA3/g=;
        b=Jkuvww/E7ZS3yC1eKiIEttzz4k899MOU7sVkcS0xvrvzNpgbipbgDXnnBM7xp/ENDT
         WEzy+KLtLnlj7SjKC3BuBwjMGM3ZbYBVRjy+SJjYu0dCkEEn1tNWMqFNgeJp1vimWKiK
         9zPR9n3lwv4+UbhhXZWJtOSN1mw2Zu5kjIDbQhr9ep662S3cKnUEcx0eo7A8lghJjUKL
         6NpSIY/+/5PvWCvz7WtCNBUkCrbzKjpijrwzeDcneO3KXatOre2fnBZJveFQZZJsQrNa
         GCOMQB0+EQYokz+L6YXR9FeRLJTC9biRhrBoxRMUOUiJ7JzB6+lYSNZpGOFewHKZUcWI
         h/5g==
X-Gm-Message-State: AOAM5318QKCTR23q217D2+vUdhN7DoSK4vb6iF4va2Jh7NLW5GVZC/x8
        WtaY0UWKE+KSmJosce/xFrU=
X-Google-Smtp-Source: ABdhPJwOYyhjg/Et0l54LKe36aN/nUR4yR0VNdVU2+W2ETi4WUgUEb+bbsfQ3gbIFIBeiBhMjAjqag==
X-Received: by 2002:a17:902:8ec9:b029:ef:5a88:e7cf with SMTP id x9-20020a1709028ec9b02900ef5a88e7cfmr2252334plo.48.1622777404343;
        Thu, 03 Jun 2021 20:30:04 -0700 (PDT)
Received: from localhost.localdomain (199.19.111.227.16clouds.com. [199.19.111.227])
        by smtp.gmail.com with ESMTPSA id a10sm3208680pjs.39.2021.06.03.20.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 20:30:04 -0700 (PDT)
From:   xieqinick@gmail.com
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nick@khadas.com, artem@khadas.com
Subject: [PATCH] clk: meson: g12a: Add missing NNA source clocks for g12b
Date:   Fri,  4 Jun 2021 11:29:57 +0800
Message-Id: <20210604032957.224496-1-xieqinick@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Xie <nick@khadas.com>

This adds the Neural Network Accelerator source clocks for g12b.

Initial support for sm1 already exist in
commit 2f1efa5340ef
("clk: meson: g12a: Add support for NNA CLK source clocks")

The sm1 and g12b share the same NNA source clocks.
This patch add missing NNA clocks for A311D (g12b).

Signed-off-by: Nick Xie <nick@khadas.com>
---
 drivers/clk/meson/g12a.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index b080359b4645..6a1db16b126f 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -4723,6 +4723,12 @@ static struct clk_hw_onecell_data g12b_hw_onecell_data = {
 		[CLKID_SPICC1_SCLK_SEL]		= &g12a_spicc1_sclk_sel.hw,
 		[CLKID_SPICC1_SCLK_DIV]		= &g12a_spicc1_sclk_div.hw,
 		[CLKID_SPICC1_SCLK]		= &g12a_spicc1_sclk.hw,
+		[CLKID_NNA_AXI_CLK_SEL]		= &sm1_nna_axi_clk_sel.hw,
+		[CLKID_NNA_AXI_CLK_DIV]		= &sm1_nna_axi_clk_div.hw,
+		[CLKID_NNA_AXI_CLK]		= &sm1_nna_axi_clk.hw,
+		[CLKID_NNA_CORE_CLK_SEL]	= &sm1_nna_core_clk_sel.hw,
+		[CLKID_NNA_CORE_CLK_DIV]	= &sm1_nna_core_clk_div.hw,
+		[CLKID_NNA_CORE_CLK]		= &sm1_nna_core_clk.hw,
 		[CLKID_MIPI_DSI_PXCLK_SEL]	= &g12a_mipi_dsi_pxclk_sel.hw,
 		[CLKID_MIPI_DSI_PXCLK_DIV]	= &g12a_mipi_dsi_pxclk_div.hw,
 		[CLKID_MIPI_DSI_PXCLK]		= &g12a_mipi_dsi_pxclk.hw,
-- 
2.25.1

