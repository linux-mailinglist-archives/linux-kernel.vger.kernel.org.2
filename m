Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19EE3DD08A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 08:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbhHBGbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 02:31:18 -0400
Received: from smtpbg604.qq.com ([59.36.128.82]:47546 "EHLO smtpbg604.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232298AbhHBGbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 02:31:11 -0400
X-QQ-mid: bizesmtp41t1627885358tbu3l0yk
Received: from localhost.localdomain (unknown [113.89.245.207])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 02 Aug 2021 14:22:37 +0800 (CST)
X-QQ-SSF: 01100000002000206000B00A0000000
X-QQ-FEAT: vCa7dv7JIu4AIx2Tnge217fKbr8I+9aySDaTdWFJ3NmXbL2fQ9dSIbBGlM+83
        ru1igvgEiL5Hy2fg6PqltX08K2mD8Pju4Ms6o744hzViRvCNdm2TIsx3USxZG4rUjGaEuvF
        xy6WmM/AVs9XK2yqUT1YVKiBA681i7WjdVUOb8/UIcL0Zjm80IAoXvqq/zLRT/KDrDHz3rg
        g0D0G84TcEt030BGvc9/lAO4uPLETSgv98VvSaxhfizck80Xb01rWXLQh721aenrTSHi1CA
        y2iwP2vas0ToE9IhYK4RYQI6aISrsEWcyJjybkRAxOHLr7sNGak8rNnlvPfZb1VyDW8tCi+
        8ezpdaX7hB0oWwYkmE=
X-QQ-GoodBg: 0
From:   Icenowy Zheng <icenowy@sipeed.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@sipeed.com>
Subject: [PATCH 05/17] rtc: sun6i: add support for R329 RTC
Date:   Mon,  2 Aug 2021 14:22:00 +0800
Message-Id: <20210802062212.73220-6-icenowy@sipeed.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210802062212.73220-1-icenowy@sipeed.com>
References: <20210802062212.73220-1-icenowy@sipeed.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:sipeed.com:qybgspam:qybgspam4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner R329 SoC has a RTC with similar clock control capability to
H6, but its day storage changed to be linear, similar to the one in H616
RTC.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
---
 drivers/rtc/rtc-sun6i.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 752bea949050..06eca57e5215 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -386,6 +386,24 @@ static void __init sun50i_h6_rtc_clk_init(struct device_node *node)
 CLK_OF_DECLARE_DRIVER(sun50i_h6_rtc_clk, "allwinner,sun50i-h6-rtc",
 		      sun50i_h6_rtc_clk_init);
 
+static const struct sun6i_rtc_clk_data sun50i_r329_rtc_data = {
+	.rc_osc_rate = 16000000,
+	.fixed_prescaler = 32,
+	.has_prescaler = 1,
+	.has_out_clk = 1,
+	.export_iosc = 1,
+	.has_losc_en = 1,
+	.has_auto_swt = 1,
+};
+
+static void __init sun50i_r329_rtc_clk_init(struct device_node *node)
+{
+	sun6i_rtc_clk_init(node, &sun50i_r329_rtc_data);
+}
+
+CLK_OF_DECLARE_DRIVER(sun50i_r329_rtc_clk, "allwinner,sun50i-r329-rtc",
+		      sun50i_r329_rtc_clk_init);
+
 /*
  * The R40 user manual is self-conflicting on whether the prescaler is
  * fixed or configurable. The clock diagram shows it as fixed, but there
@@ -791,6 +809,8 @@ static const struct of_device_id sun6i_rtc_dt_ids[] = {
 	{ .compatible = "allwinner,sun8i-v3-rtc" },
 	{ .compatible = "allwinner,sun50i-h5-rtc" },
 	{ .compatible = "allwinner,sun50i-h6-rtc" },
+	{ .compatible = "allwinner,sun50i-r329-rtc",
+		.data = (void *)RTC_LINEAR_DAY },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, sun6i_rtc_dt_ids);
-- 
2.30.2

