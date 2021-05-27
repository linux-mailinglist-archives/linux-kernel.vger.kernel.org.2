Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DA9392F4E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236480AbhE0NSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236416AbhE0NSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:18:31 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C4FC06138C;
        Thu, 27 May 2021 06:16:56 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l1so22736ejb.6;
        Thu, 27 May 2021 06:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qDp+pjL8u9TTvxzEepWTwup8whUcX1eXB/WptTlt9e0=;
        b=s0fnsdwLr45qkf4CZn1JxS4nBDV5pSTUnd82Xj/SCH/G3U+MGcDcZYtSIabAsJUh+c
         b96jp2GcWbWp/UaN34T319qvzF1H6nPqSwu9S774nyR8pcuJ3DDcuu09pQWq0ofAoz8J
         vyvuZQXnh99+EuAtDR4PzAc6KkK8N5ORKS3uyL3xq8eF2GD/FIl0+Rdqdo+nrrGPtU46
         w6OKJNpfTte/NEWkC/Srmk5tZw0BF0LMqUX1TYzX7JgVJ4n7FocjgPLByOqZ3gmkQvS0
         d/LgsDV7UiUEWS25jEsGwAsKcqi0QG3bKRrY43p6K728tCZNDiSDtuMwHkHFgTmmn6Lk
         bn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qDp+pjL8u9TTvxzEepWTwup8whUcX1eXB/WptTlt9e0=;
        b=B6nNspzZFjmT3eBcIouVHKzDvOIREX/vx6eUeOiWtVBbQoa1KCNVtkfZ3xY/5kmaio
         rLIlFi+AacjrMs4i22JYkjVOeW3KD1bYbx0U5paxxF43I2oQeKaBGg8bv8oH8u5fyaXQ
         PnyU0wOQRQesvF7bhArHDZe792zo476q/TV2R8RxutjfH9WEdjJf+neHYE/rHzeEgNAY
         tmErHhgSTWssq93kBphrWjWTBwRM448Fijl6umQWs88taWH3T2mpAHJaB86O0Fnhe+Uw
         /CEVrn7Zt5awlg8Yy8skX+hUZcSCV04jDo3orS7LBBvKf+uSr2dE/1I2BWYHPo+Z+t3Y
         DQ/g==
X-Gm-Message-State: AOAM5325Nq6QOqDfQWA2dsJ8VdDO8LduqXr2Grqeq3t70YqH+fCVtqyo
        jOaTt1FFLj9VPJvh5lksvnE=
X-Google-Smtp-Source: ABdhPJyUbuiCDS8W6AcHzx60wAAVddrQEg39dMErk3zlG0aQPtEDEGUEaJpjSD5TRhw+TNVswGhWgQ==
X-Received: by 2002:a17:906:4c54:: with SMTP id d20mr3812329ejw.513.1622121415293;
        Thu, 27 May 2021 06:16:55 -0700 (PDT)
Received: from localhost.localdomain ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id r23sm1104206edq.59.2021.05.27.06.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 06:16:54 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 6/6] clk: actions: Add NIC and ETHERNET clock support for Actions S500 SoC
Date:   Thu, 27 May 2021 16:16:44 +0300
Message-Id: <fb8085722305af11311ca2661cba2bf73a71abea.1622119892.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622119892.git.cristian.ciocaltea@gmail.com>
References: <cover.1622119892.git.cristian.ciocaltea@gmail.com>
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
Changes in v2:
 - Reordered "nic_clk_mux_p" after "ahbprediv_clk_mux_p" to follow the reg
   field ordering

 drivers/clk/actions/owl-s500.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
index 257923bd5386..a9c7e06ebcd6 100644
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
2.31.1

