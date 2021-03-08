Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159B0331489
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhCHRTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbhCHRSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:18:42 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE85C06174A;
        Mon,  8 Mar 2021 09:18:42 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id jt13so21975008ejb.0;
        Mon, 08 Mar 2021 09:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zzFrV0h6kVmKH1KeRdOBV+T1cKCv+zoyF5GXtMVqnnc=;
        b=ZQyoED8Al2WlCMa63tJ2iUBGTkn6FbGYK99zvJRff783x9xVm/8yW0VLVTLrguXtOj
         sQOF0DJQeyPfA2PRg3yl4xbLZ5Oxbfd+wNinbTmeJZmXcslYuy+OALUth8VQXtDSRDnM
         br/qBffboudOn0i9xgaDQ768B9hcGHn0v7S62dkPTGrE8Et3A36y6kv7v3kFk0GSlW7o
         T+xgU4FBEX8IiNpvzV91jzTS8GjcL+gYJFRIi13K7OwhW6WByGjw/ExM/NZkT67F2463
         tE8nXy52o+yspmVfIXWEcZpZfl7Rv6cMrthIl5YsXFruLoi1Fm+9A9vUAld6dPNHYHFo
         HhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zzFrV0h6kVmKH1KeRdOBV+T1cKCv+zoyF5GXtMVqnnc=;
        b=k8uN95pH2jr2zBPHwdvS40ZiLojsrljJGM5bCXJYTGX8b2WEtT6iNpmOa5qRjhOeWo
         DGzRrSiyJxjKL0aNoYmeoLikyZUDlZ2EJWaHIvTL/8V6rrPIpSKhVa5OrtfnRncqqPdo
         l+GDxOvSO+Vj9awSUT4D2AJ5GLWaI91TdI2meFiuUxmFr2vZiwZYsWthCYnaspWPFGnX
         EcwXRwMo2pVmX3PSw/AeWIZsjtVdXDKWLqZLK0jY0M4v62JjBwpD9/2zY9hdf7s7xdVT
         SmwYV+dfbIrE2eIcg4brqdxACvSwS6EUXRzVLQhk2LsGB2FBchoaOpqYMNzFEnqflEV/
         bEPA==
X-Gm-Message-State: AOAM533NZmkNZ6EPKnf44rsZ5m3sB+4iT2RMCosfAC/7t6W95m8+R3K7
        q+AddWuBmtv0Ogfy8E3ecA4=
X-Google-Smtp-Source: ABdhPJx3YyHgQFJnJBXBqefgst1l9luX/FPnqHCg0y1wY3vUhcY2J78XRbFsb9ys29+/mYuMKaUN2g==
X-Received: by 2002:a17:906:1746:: with SMTP id d6mr16488844eje.36.1615223920915;
        Mon, 08 Mar 2021 09:18:40 -0800 (PST)
Received: from localhost.localdomain ([81.18.95.223])
        by smtp.gmail.com with ESMTPSA id r5sm7457714eds.49.2021.03.08.09.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:18:40 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 6/6] clk: actions: Add NIC and ETHERNET clock support for Actions S500 SoC
Date:   Mon,  8 Mar 2021 19:18:31 +0200
Message-Id: <ddafbffafe48fc55bed050728e2ce2610c934e7b.1615221459.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615221459.git.cristian.ciocaltea@gmail.com>
References: <cover.1615221459.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the missing NIC and ETHERNET clocks in the Actions Semi
Owl S500 SoC clock driver.

Additionally, change APB clock parent from AHB to the newly added NIC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 drivers/clk/actions/owl-s500.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
index b9e434173b4f..0ccc9619b302 100644
--- a/drivers/clk/actions/owl-s500.c
+++ b/drivers/clk/actions/owl-s500.c
@@ -112,6 +112,7 @@ static const char * const bisp_clk_mux_p[] = { "display_pll_clk", "dev_clk" };
 static const char * const sensor_clk_mux_p[] = { "hosc", "bisp_clk" };
 static const char * const sd_clk_mux_p[] = { "dev_clk", "nand_pll_clk" };
 static const char * const pwm_clk_mux_p[] = { "losc", "hosc" };
+static const char * const nic_clk_mux_p[] = { "dev_clk", "display_pll_clk", "nand_pll_clk", "ddr_pll_clk" };
 static const char * const ahbprediv_clk_mux_p[] = { "dev_clk", "display_pll_clk", "nand_pll_clk", "ddr_pll_clk" };
 static const char * const uart_clk_mux_p[] = { "hosc", "dev_pll_clk" };
 static const char * const de_clk_mux_p[] = { "display_pll_clk", "dev_clk" };
@@ -197,7 +198,7 @@ static OWL_GATE(hdmi_clk, "hdmi_clk", "hosc", CMU_DEVCLKEN1, 3, 0, 0);
 
 /* divider clocks */
 static OWL_DIVIDER(h_clk, "h_clk", "ahbprediv_clk", CMU_BUSCLK1, 2, 2, h_div_table, 0, 0);
-static OWL_DIVIDER(apb_clk, "apb_clk", "ahb_clk", CMU_BUSCLK1, 14, 2, NULL, 0, 0);
+static OWL_DIVIDER(apb_clk, "apb_clk", "nic_clk", CMU_BUSCLK1, 14, 2, NULL, 0, 0);
 static OWL_DIVIDER(rmii_ref_clk, "rmii_ref_clk", "ethernet_pll_clk", CMU_ETHERNETPLL, 1, 1, rmii_ref_div_table, 0, 0);
 
 /* factor clocks */
@@ -205,6 +206,12 @@ static OWL_FACTOR(de1_clk, "de_clk1", "de_clk", CMU_DECLK, 0, 4, de_factor_table
 static OWL_FACTOR(de2_clk, "de_clk2", "de_clk", CMU_DECLK, 4, 4, de_factor_table, 0, 0);
 
 /* composite clocks */
+static OWL_COMP_DIV(nic_clk, "nic_clk", nic_clk_mux_p,
+			OWL_MUX_HW(CMU_BUSCLK1, 4, 3),
+			{ 0 },
+			OWL_DIVIDER_HW(CMU_BUSCLK1, 16, 2, 0, NULL),
+			0);
+
 static OWL_COMP_DIV(ahbprediv_clk, "ahbprediv_clk", ahbprediv_clk_mux_p,
 			OWL_MUX_HW(CMU_BUSCLK1, 8, 3),
 			{ 0 },
@@ -320,6 +327,10 @@ static OWL_COMP_FIXED_FACTOR(i2c3_clk, "i2c3_clk", "ethernet_pll_clk",
 			OWL_GATE_HW(CMU_DEVCLKEN1, 31, 0),
 			1, 5, 0);
 
+static OWL_COMP_FIXED_FACTOR(ethernet_clk, "ethernet_clk", "ethernet_pll_clk",
+			OWL_GATE_HW(CMU_DEVCLKEN1, 22, 0),
+			1, 20, 0);
+
 static OWL_COMP_DIV(uart0_clk, "uart0_clk", uart_clk_mux_p,
 			OWL_MUX_HW(CMU_UART0CLK, 16, 1),
 			OWL_GATE_HW(CMU_DEVCLKEN1, 6, 0),
@@ -454,6 +465,8 @@ static struct owl_clk_common *s500_clks[] = {
 	&apb_clk.common,
 	&dmac_clk.common,
 	&gpio_clk.common,
+	&nic_clk.common,
+	&ethernet_clk.common,
 };
 
 static struct clk_hw_onecell_data s500_hw_clks = {
@@ -513,6 +526,8 @@ static struct clk_hw_onecell_data s500_hw_clks = {
 		[CLK_APB]		= &apb_clk.common.hw,
 		[CLK_DMAC]		= &dmac_clk.common.hw,
 		[CLK_GPIO]		= &gpio_clk.common.hw,
+		[CLK_NIC]		= &nic_clk.common.hw,
+		[CLK_ETHERNET]		= &ethernet_clk.common.hw,
 	},
 	.num = CLK_NR_CLKS,
 };
-- 
2.30.1

