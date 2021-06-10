Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4333A3480
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 22:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhFJUHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 16:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhFJUHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 16:07:35 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D25C0617A8;
        Thu, 10 Jun 2021 13:05:38 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id u24so34482862edy.11;
        Thu, 10 Jun 2021 13:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0gUA8fCofTJN4dSFDRWQ0LtpsjbZVq0HGtPwb2y+ZNk=;
        b=pjUX2sX1hCuxJMXZzLkXI2KXrkiO2we8D5JQvdmkNjLXWO4ewuu6ZxBZ6hxK9yWmca
         KpMPeB7EI4jD9MHCP7kUDJfbFJEVmImX47nuM30re0gUzQpQkDoqv4xBqkWjQLeaF79j
         /rJzrECl78m6wl/oAubtrxGtkwZrz9fQ7AC/sgDb3O4DY8j9NCwXlwty8DBaTXV/KC9R
         AhdOkHfpBD3grkwdLrzZD32012rSppYW6PV5Kjn9EI7gKSzHQ8PohorTqdEdPWddqVoZ
         /sIrkiPy7Yc5aP8Cb3l+l/aAj5/Ac3PqLvDmAz+u/tBlUVLD2gxGyOAve9NfS3N4TW5K
         jxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0gUA8fCofTJN4dSFDRWQ0LtpsjbZVq0HGtPwb2y+ZNk=;
        b=UemONWq2rpFBfGNGSIEcy9RAIgodYFVumo7KhbnD7LIpu/sO3xHBcC1PiykJxpI81G
         7fRBIw8I878Hl6mVLhD/8DMp3wS65Lx6O5BChF0tJHjp9P+YsB0NjPuKS5c2t+ZzdTW7
         LzDuEwmS77FuOX6PoNLzTiKoMun3PcM6Gyr2eKgTQYeC/GdqFnqW0RzE2BRHOj5j9jn1
         6WYym1VTrGl2jtG+ZFG9gVD5CxnskZaM6f3NmWtNs6AJHukABmZF/ZLwbki+Ii8qltMd
         CIFxDXK4kayo45F/Csa944rIefD+GE1np0xTYWu/q++oXtayQ9TmhuksqJB0+Xn7yI9W
         0rjg==
X-Gm-Message-State: AOAM5300OYxAS2WO9HX2Og7mO45n1jgWYLDi99Eue7CKMDrqm0r8iJzj
        X8lYeIG4Oopd+N1MsxpSvGQ=
X-Google-Smtp-Source: ABdhPJwzqCXrn8iL2XWZ/0drEfa0hsMCgS3V0Y3oGOF7Zv/CdbCHIq7Drgnn6v3LAFnvr7ohgr2e8A==
X-Received: by 2002:a05:6402:cb4:: with SMTP id cn20mr195651edb.334.1623355536938;
        Thu, 10 Jun 2021 13:05:36 -0700 (PDT)
Received: from localhost.localdomain ([188.24.178.25])
        by smtp.gmail.com with ESMTPSA id du7sm1800978edb.1.2021.06.10.13.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 13:05:36 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 6/6] clk: actions: Add NIC and ETHERNET clock support for Actions S500 SoC
Date:   Thu, 10 Jun 2021 23:05:26 +0300
Message-Id: <d62e4f1f85c5cef05be14d9e8143e88bbddd2e0f.1623354574.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623354574.git.cristian.ciocaltea@gmail.com>
References: <cover.1623354574.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the missing NIC and ETHERNET clocks in the Actions Semi
Owl S500 SoC clock driver.

Additionally, change APB clock parent from AHB to the newly added NIC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v3:
 - Added Reviewed-by tag from Mani

Changes in v2:
 - Reordered "nic_clk_mux_p" after "ahbprediv_clk_mux_p" to follow the reg
   field ordering

 drivers/clk/actions/owl-s500.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
index cbeb51c804eb..57d06e183dff 100644
--- a/drivers/clk/actions/owl-s500.c
+++ b/drivers/clk/actions/owl-s500.c
@@ -113,6 +113,7 @@ static const char * const sensor_clk_mux_p[] = { "hosc", "bisp_clk" };
 static const char * const sd_clk_mux_p[] = { "dev_clk", "nand_pll_clk" };
 static const char * const pwm_clk_mux_p[] = { "losc", "hosc" };
 static const char * const ahbprediv_clk_mux_p[] = { "dev_clk", "display_pll_clk", "nand_pll_clk", "ddr_pll_clk" };
+static const char * const nic_clk_mux_p[] = { "dev_clk", "display_pll_clk", "nand_pll_clk", "ddr_pll_clk" };
 static const char * const uart_clk_mux_p[] = { "hosc", "dev_pll_clk" };
 static const char * const de_clk_mux_p[] = { "display_pll_clk", "dev_clk" };
 static const char * const i2s_clk_mux_p[] = { "audio_pll_clk" };
@@ -194,7 +195,7 @@ static OWL_GATE(hdmi_clk, "hdmi_clk", "hosc", CMU_DEVCLKEN1, 3, 0, 0);
 
 /* divider clocks */
 static OWL_DIVIDER(h_clk, "h_clk", "ahbprediv_clk", CMU_BUSCLK1, 2, 2, NULL, 0, 0);
-static OWL_DIVIDER(apb_clk, "apb_clk", "ahb_clk", CMU_BUSCLK1, 14, 2, NULL, 0, 0);
+static OWL_DIVIDER(apb_clk, "apb_clk", "nic_clk", CMU_BUSCLK1, 14, 2, NULL, 0, 0);
 static OWL_DIVIDER(rmii_ref_clk, "rmii_ref_clk", "ethernet_pll_clk", CMU_ETHERNETPLL, 1, 1, rmii_ref_div_table, 0, 0);
 
 /* factor clocks */
@@ -202,6 +203,12 @@ static OWL_FACTOR(de1_clk, "de_clk1", "de_clk", CMU_DECLK, 0, 4, de_factor_table
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
@@ -317,6 +324,10 @@ static OWL_COMP_FIXED_FACTOR(i2c3_clk, "i2c3_clk", "ethernet_pll_clk",
 			OWL_GATE_HW(CMU_DEVCLKEN1, 31, 0),
 			1, 5, 0);
 
+static OWL_COMP_FIXED_FACTOR(ethernet_clk, "ethernet_clk", "ethernet_pll_clk",
+			OWL_GATE_HW(CMU_DEVCLKEN1, 22, 0),
+			1, 20, 0);
+
 static OWL_COMP_DIV(uart0_clk, "uart0_clk", uart_clk_mux_p,
 			OWL_MUX_HW(CMU_UART0CLK, 16, 1),
 			OWL_GATE_HW(CMU_DEVCLKEN1, 6, 0),
@@ -451,6 +462,8 @@ static struct owl_clk_common *s500_clks[] = {
 	&apb_clk.common,
 	&dmac_clk.common,
 	&gpio_clk.common,
+	&nic_clk.common,
+	&ethernet_clk.common,
 };
 
 static struct clk_hw_onecell_data s500_hw_clks = {
@@ -510,6 +523,8 @@ static struct clk_hw_onecell_data s500_hw_clks = {
 		[CLK_APB]		= &apb_clk.common.hw,
 		[CLK_DMAC]		= &dmac_clk.common.hw,
 		[CLK_GPIO]		= &gpio_clk.common.hw,
+		[CLK_NIC]		= &nic_clk.common.hw,
+		[CLK_ETHERNET]		= &ethernet_clk.common.hw,
 	},
 	.num = CLK_NR_CLKS,
 };
-- 
2.32.0

