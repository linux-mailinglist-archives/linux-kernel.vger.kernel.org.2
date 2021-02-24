Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DCC3235C2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 03:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhBXCcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 21:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbhBXCcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 21:32:07 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB59C06178B;
        Tue, 23 Feb 2021 18:31:27 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id m144so833940qke.10;
        Tue, 23 Feb 2021 18:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Px/VQYAYndg6+A8nhIaz96Rh/6Tl+ytn6H8ro/fcnBU=;
        b=eLLDSxaLh2cnv8pfaqj6iCWtdcMGFl3mA98wMvICJfuWOrNA+tml/X4FHhaCiVc5sB
         13nWDkI1qynakKSrndcquSy+Opioh382lvv/ToxrZIlBNp/k8SlhStDgT6WYjHPVQiEA
         29MJ3BtbbTEpiO8t49NxlcYTxEdRVpq5XT4L98kRO5IRX9TQEgR9WoWLIPUPxa9fUMBo
         KGUtle2eI9Bn7e/ugzYxw89iAcYsyOPbeYprhCtxJNqDenor3bsUUxKQuWnMI+XFg1Aq
         XH6ne27D2Uhyp34DEhI/b8pjt+ep3eBBSY/LaaB3HiUfq+DabNgKz/xgsONvxoMJPW+T
         7mDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Px/VQYAYndg6+A8nhIaz96Rh/6Tl+ytn6H8ro/fcnBU=;
        b=DsNlwYsLMQwQ4vmibU+dIXidcNUD4KZeKelP6/r/salFKN1Oi200AL+jGVIsOv1NPa
         4fLyaQ6+B8IxtuhQPwQoMKESAxPkm8XEW0aoxh4HWg3rcmpPzsO6+kzGgUZjBvlS6aBf
         vgN8/+iNuPNPK8MXaygcQkg5fwPegINkIrI43QYratUKM8fIqE/I405xkm5id+3+9/eP
         wHVlvUDdi8w89/tbVmOEdwUgqCyYJHny9PKKRQC1NmAVJp/xB+MwdEqp9CTvDNIl1K+u
         BdsqmTH6wrkbtbio4kEUe0ZWa+6tr0wB6q7Hn6geDI6f3Cpi0Amk2CXrkkdzaUJGm0GX
         KMqQ==
X-Gm-Message-State: AOAM533bu+uMIu5zK4jdgjeIuhxIa8HtC9ZB7tatjoZklL1x0dTVWWF0
        30MPp4k2fWfE+/qigpDtJAk=
X-Google-Smtp-Source: ABdhPJxSMPq8X+QiZwY+V+5icA3RV2AIM97NtowM+2KHbCz40J+Cw+f7NHQnmoZphxlkWtPFxVAyCg==
X-Received: by 2002:a05:620a:1312:: with SMTP id o18mr28713073qkj.307.1614133886249;
        Tue, 23 Feb 2021 18:31:26 -0800 (PST)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id p25sm529500qkh.79.2021.02.23.18.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 18:31:25 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v3 2/3] clk: lmk04832: add support for digital delay
Date:   Tue, 23 Feb 2021 21:31:15 -0500
Message-Id: <20210224023116.571718-3-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210224023116.571718-1-liambeguin@gmail.com>
References: <20210224023116.571718-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

The digital delay allows outputs to be delayed from 8 to 1023 VCO
cycles. The delay step can be as small as half the period of the clock
distribution path. For example, a 3.2-GHz VCO frequency results in
156.25-ps steps.  The digital delay value takes effect on the clock
output phase after a SYNC event.

This is required to support JESD204B subclass 1.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/clk/clk-lmk04832.c | 321 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 315 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-lmk04832.c b/drivers/clk/clk-lmk04832.c
index 387a60fa2111..5393088fa68e 100644
--- a/drivers/clk/clk-lmk04832.c
+++ b/drivers/clk/clk-lmk04832.c
@@ -36,16 +36,24 @@
 #define LMK04832_REG_CLKOUT_CTRL0(ch)	(0x100 + (ch >> 1) * 8)
 #define LMK04832_BIT_DCLK_DIV_LSB		GENMASK(7, 0)
 #define LMK04832_REG_CLKOUT_CTRL1(ch)	(0x101 + (ch >> 1) * 8)
+#define LMK04832_BIT_DCLKX_Y_DDLY_LSB		GENMASK(7, 0)
 #define LMK04832_REG_CLKOUT_CTRL2(ch)	(0x102 + (ch >> 1) * 8)
 #define LMK04832_BIT_CLKOUTX_Y_PD		BIT(7)
+#define LMK04832_BIT_DCLKX_Y_DDLY_PD		BIT(4)
+#define LMK04832_BIT_DCLKX_Y_DDLY_MSB		GENMASK(3, 2)
 #define LMK04832_BIT_DCLK_DIV_MSB		GENMASK(1, 0)
 #define LMK04832_REG_CLKOUT_SRC_MUX(ch)	(0x103 + (ch % 2) + (ch >> 1) * 8)
 #define LMK04832_BIT_CLKOUT_SRC_MUX		BIT(5)
 #define LMK04832_REG_CLKOUT_CTRL3(ch)	(0x103 + (ch >> 1) * 8)
 #define LMK04832_BIT_DCLKX_Y_PD			BIT(4)
 #define LMK04832_BIT_DCLKX_Y_DCC		BIT(2)
+#define LMK04832_BIT_DCLKX_Y_HS			BIT(0)
 #define LMK04832_REG_CLKOUT_CTRL4(ch)	(0x104 + (ch >> 1) * 8)
 #define LMK04832_BIT_SCLK_PD			BIT(4)
+#define LMK04832_BIT_SCLKX_Y_DIS_MODE		GENMASK(3, 2)
+#define LMK04832_REG_SCLKX_Y_ADLY(ch)	(0x105 + (ch >> 1) * 8)
+#define LMK04832_REG_SCLKX_Y_DDLY(ch)	(0x106 + (ch >> 1) * 8)
+#define LMK04832_BIT_SCLKX_Y_DDLY		GENMASK(3, 0)
 #define LMK04832_REG_CLKOUT_FMT(ch)	(0x107 + (ch >> 1) * 8)
 #define LMK04832_BIT_CLKOUT_FMT(ch)		(ch % 2 ? 0xf0 : 0x0f)
 #define LMK04832_VAL_CLKOUT_FMT_POWERDOWN		0x00
@@ -72,11 +80,19 @@
 #define LMK04832_VAL_VCO_MUX_VCO1			0x01
 #define LMK04832_VAL_VCO_MUX_EXT			0x02
 #define LMK04832_REG_SYSREF_OUT		0x139
+#define LMK04832_BIT_SYSREF_REQ_EN		BIT(6)
 #define LMK04832_BIT_SYSREF_MUX			GENMASK(1, 0)
+#define LMK04832_VAL_SYSREF_MUX_NORMAL_SYNC		0x00
+#define LMK04832_VAL_SYSREF_MUX_RECLK			0x01
+#define LMK04832_VAL_SYSREF_MUX_PULSER			0x02
 #define LMK04832_VAL_SYSREF_MUX_CONTINUOUS		0x03
 #define LMK04832_REG_SYSREF_DIV_MSB	0x13a
 #define LMK04832_BIT_SYSREF_DIV_MSB		GENMASK(4, 0)
 #define LMK04832_REG_SYSREF_DIV_LSB	0x13b
+#define LMK04832_REG_SYSREF_DDLY_MSB	0x13c
+#define LMK04832_BIT_SYSREF_DDLY_MSB		GENMASK(4, 0)
+#define LMK04832_REG_SYSREF_DDLY_LSB	0x13d
+#define LMK04832_REG_SYSREF_PULSE_CNT	0x13e
 #define LMK04832_REG_FB_CTRL		0x13f
 #define LMK04832_BIT_PLL2_RCLK_MUX		BIT(7)
 #define LMK04832_VAL_PLL2_RCLK_MUX_OSCIN		0x00
@@ -95,7 +111,15 @@
 #define LMK04832_BIT_SYSREF_DDLY_PD		BIT(1)
 #define LMK04832_BIT_SYSREF_PLSR_PD		BIT(0)
 #define LMK04832_REG_SYNC		0x143
+#define LMK04832_BIT_SYNC_CLR			BIT(7)
+#define LMK04832_BIT_SYNC_1SHOT_EN		BIT(6)
+#define LMK04832_BIT_SYNC_POL			BIT(5)
 #define LMK04832_BIT_SYNC_EN			BIT(4)
+#define LMK04832_BIT_SYNC_MODE			GENMASK(1, 0)
+#define LMK04832_VAL_SYNC_MODE_OFF			0x00
+#define LMK04832_VAL_SYNC_MODE_ON			0x01
+#define LMK04832_VAL_SYNC_MODE_PULSER_PIN		0x02
+#define LMK04832_VAL_SYNC_MODE_PULSER_SPI		0x03
 #define LMK04832_REG_SYNC_DIS		0x144
 
 /* 0x146 - 0x14a CLKin Control */
@@ -127,6 +151,7 @@
 #define LMK04832_BIT_PLL2_N_0			GENMASK(1, 0)
 #define LMK04832_REG_PLL2_N_1		0x167
 #define LMK04832_REG_PLL2_N_2		0x168
+#define LMK04832_REG_PLL2_DLD_CNT_MSB	0x16a
 #define LMK04832_REG_PLL2_DLD_CNT_LSB	0x16b
 #define LMK04832_REG_PLL2_LD		0x16e
 #define LMK04832_BIT_PLL2_LD_MUX		GENMASK(7, 3)
@@ -203,6 +228,11 @@ struct lmk_clkout {
  *
  * @dev: reference to a struct device, linked to the spi_device
  * @regmap: struct regmap instance use to access the chip
+ * @sync_mode: operational mode for SYNC signal
+ * @sysref_mux: select SYSREF source
+ * @sysref_pulse_cnt: number of SYSREF pulses generated while not in continuous
+ *                    mode.
+ * @sysref_ddly: SYSREF digital delay value
  * @oscin: PLL2 input clock
  * @vco: reference to the internal VCO clock
  * @sclk: reference to the internal sysref clock (SCLK)
@@ -217,6 +247,11 @@ struct lmk04832 {
 	struct device *dev;
 	struct regmap *regmap;
 
+	unsigned int sync_mode;
+	unsigned int sysref_mux;
+	unsigned int sysref_pulse_cnt;
+	unsigned int sysref_ddly;
+
 	struct clk *oscin;
 	struct clk_hw vco;
 	struct clk_hw sclk;
@@ -613,6 +648,212 @@ static int lmk04832_register_vco(struct lmk04832 *lmk)
 	return devm_clk_hw_register(lmk->dev, &lmk->vco);
 }
 
+static int lmk04832_clkout_set_ddly(struct lmk04832 *lmk, int id)
+{
+	int dclk_div_adj[] = {0, 0, -2, -2, 0, 3, -1, 0};
+	unsigned int sclkx_y_ddly = 10;
+	unsigned int dclkx_y_ddly;
+	unsigned int dclkx_y_div;
+	unsigned int sysref_ddly;
+	unsigned int dclkx_y_hs;
+	unsigned int lsb, msb;
+	int ret;
+
+	ret = regmap_update_bits(lmk->regmap,
+				 LMK04832_REG_CLKOUT_CTRL2(id),
+				 LMK04832_BIT_DCLKX_Y_DDLY_PD,
+				 FIELD_PREP(LMK04832_BIT_DCLKX_Y_DDLY_PD, 0));
+	if (ret)
+		return ret;
+
+	ret = regmap_read(lmk->regmap, LMK04832_REG_SYSREF_DDLY_LSB, &lsb);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(lmk->regmap, LMK04832_REG_SYSREF_DDLY_MSB, &msb);
+	if (ret)
+		return ret;
+
+	sysref_ddly = FIELD_GET(LMK04832_BIT_SYSREF_DDLY_MSB, msb) << 8 | lsb;
+
+	ret = regmap_read(lmk->regmap, LMK04832_REG_CLKOUT_CTRL0(id), &lsb);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(lmk->regmap, LMK04832_REG_CLKOUT_CTRL2(id), &msb);
+	if (ret)
+		return ret;
+
+	dclkx_y_div = FIELD_GET(LMK04832_BIT_DCLK_DIV_MSB, msb) << 8 | lsb;
+
+	ret = regmap_read(lmk->regmap, LMK04832_REG_CLKOUT_CTRL3(id), &lsb);
+	if (ret)
+		return ret;
+
+	dclkx_y_hs = FIELD_GET(LMK04832_BIT_DCLKX_Y_HS, lsb);
+
+	dclkx_y_ddly = sysref_ddly + 1 -
+		dclk_div_adj[dclkx_y_div < 6 ?  dclkx_y_div : 7] -
+		dclkx_y_hs + sclkx_y_ddly;
+
+	if (dclkx_y_ddly < 7 || dclkx_y_ddly > 0x3fff) {
+		dev_err(lmk->dev, "DCLKX_Y_DDLY out of range (%d)\n",
+			dclkx_y_ddly);
+		return -EINVAL;
+	}
+
+	ret = regmap_write(lmk->regmap,
+			   LMK04832_REG_SCLKX_Y_DDLY(id),
+			   FIELD_GET(LMK04832_BIT_SCLKX_Y_DDLY, sclkx_y_ddly));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(lmk->regmap, LMK04832_REG_CLKOUT_CTRL1(id),
+				FIELD_GET(0x00ff, dclkx_y_ddly));
+	if (ret)
+		return ret;
+
+	dev_dbg(lmk->dev, "clkout%02u: sysref_ddly=%u, dclkx_y_ddly=%u, "
+		"dclk_div_adj=%+d, dclkx_y_hs=%u, sclkx_y_ddly=%u\n",
+		id, sysref_ddly, dclkx_y_ddly,
+		dclk_div_adj[dclkx_y_div < 6 ? dclkx_y_div : 7],
+		dclkx_y_hs, sclkx_y_ddly);
+
+	return regmap_update_bits(lmk->regmap, LMK04832_REG_CLKOUT_CTRL2(id),
+				  LMK04832_BIT_DCLKX_Y_DDLY_MSB,
+				  FIELD_GET(0x0300, dclkx_y_ddly));
+}
+
+/** lmk04832_sclk_sync - Establish deterministic phase relationship between sclk
+ *                       and dclk
+ *
+ * @lmk: Reference to the lmk device
+ *
+ * The synchronization sequence:
+ * - in the datasheet https://www.ti.com/lit/ds/symlink/lmk04832.pdf, p.31
+ *   (8.3.3.1 How to enable SYSREF)
+ * - Ti forum: https://e2e.ti.com/support/clock-and-timing/f/48/t/970972
+ *
+ * Returns 0 or negative errno.
+ */
+static int lmk04832_sclk_sync_sequence(struct lmk04832 *lmk)
+{
+	int ret;
+	int i;
+
+	/* 1. (optional) mute all sysref_outputs during synchronization */
+	/* 2. Enable and write device clock digital delay to applicable clocks */
+	ret = regmap_update_bits(lmk->regmap, LMK04832_REG_MAIN_PD,
+				 LMK04832_BIT_SYSREF_DDLY_PD,
+				 FIELD_PREP(LMK04832_BIT_SYSREF_DDLY_PD, 0));
+	if (ret)
+		return ret;
+
+	for (i = 0; i < lmk->clk_data->num; i += 2) {
+		ret = lmk04832_clkout_set_ddly(lmk, i);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * 3. Configure SYNC_MODE to SYNC_PIN and SYSREF_MUX to Normal SYNC,
+	 *    and clear SYSREF_REQ_EN (see 6.)
+	 */
+	ret = regmap_update_bits(lmk->regmap, LMK04832_REG_SYSREF_OUT,
+				 LMK04832_BIT_SYSREF_REQ_EN |
+				 LMK04832_BIT_SYSREF_MUX,
+				 FIELD_PREP(LMK04832_BIT_SYSREF_REQ_EN, 0) |
+				 FIELD_PREP(LMK04832_BIT_SYSREF_MUX,
+					    LMK04832_VAL_SYSREF_MUX_NORMAL_SYNC));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(lmk->regmap, LMK04832_REG_SYNC,
+				 LMK04832_BIT_SYNC_MODE,
+				 FIELD_PREP(LMK04832_BIT_SYNC_MODE,
+					    LMK04832_VAL_SYNC_MODE_ON));
+	if (ret)
+		return ret;
+
+	/* 4. Clear SYNXC_DISx or applicable clocks and clear SYNC_DISSYSREF */
+	ret = regmap_write(lmk->regmap, LMK04832_REG_SYNC_DIS, 0x00);
+	if (ret)
+		return ret;
+
+	/*
+	 * 5. If SCLKX_Y_DDLY != 0, Set SYSREF_CLR=1 for at least 15 clock
+	 *    distribution path cycles (VCO cycles), then back to 0. In
+	 *    PLL2-only use case, this will be complete in less than one SPI
+	 *    transaction. If SYSREF local digital delay is not used, this step
+	 *    can be skipped.
+	 */
+	ret = regmap_update_bits(lmk->regmap, LMK04832_REG_SYNC,
+				 LMK04832_BIT_SYNC_CLR,
+				 FIELD_PREP(LMK04832_BIT_SYNC_CLR, 0x01));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(lmk->regmap, LMK04832_REG_SYNC,
+				 LMK04832_BIT_SYNC_CLR,
+				 FIELD_PREP(LMK04832_BIT_SYNC_CLR, 0x00));
+	if (ret)
+		return ret;
+
+	/*
+	 * 6. Toggle SYNC_POL state between inverted and not inverted.
+	 *    If you use an external signal on the SYNC pin instead of toggling
+	 *    SYNC_POL, make sure that SYSREF_REQ_EN=0 so that the SYSREF_MUX
+	 *    does not shift into continuous SYSREF mode.
+	 */
+	ret = regmap_update_bits(lmk->regmap, LMK04832_REG_SYNC,
+			   LMK04832_BIT_SYNC_POL,
+			   FIELD_PREP(LMK04832_BIT_SYNC_POL, 0x01));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(lmk->regmap, LMK04832_REG_SYNC,
+			   LMK04832_BIT_SYNC_POL,
+			   FIELD_PREP(LMK04832_BIT_SYNC_POL, 0x00));
+	if (ret)
+		return ret;
+
+	/* 7. Set all SYNC_DISx=1, including SYNC_DISSYSREF */
+	ret = regmap_write(lmk->regmap, LMK04832_REG_SYNC_DIS, 0xff);
+	if (ret)
+		return ret;
+
+	/* 8. Restore state of SYNC_MODE and SYSREF_MUX to desired values */
+	ret = regmap_update_bits(lmk->regmap, LMK04832_REG_SYSREF_OUT,
+				 LMK04832_BIT_SYSREF_MUX,
+				 FIELD_PREP(LMK04832_BIT_SYSREF_MUX,
+					    lmk->sysref_mux));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(lmk->regmap, LMK04832_REG_SYNC,
+				 LMK04832_BIT_SYNC_MODE,
+				 FIELD_PREP(LMK04832_BIT_SYNC_MODE,
+					    lmk->sync_mode));
+	if (ret)
+		return ret;
+
+	/*
+	 * 9. (optional) if SCLKx_y_DIS_MODE was used to mute SYSREF outputs
+	 *    during the SYNC event, restore SCLKx_y_DIS_MODE=0 for active state,
+	 *    or set SYSREF_GBL_PD=0 if SCLKx_y_DIS_MODE is set to a conditional
+	 *    option.
+	 */
+
+	/*
+	 * 10. (optional) To reduce power consumption, after the synchronization
+	 *     event is complete, DCLKx_y_DDLY_PD=1 and SYSREF_DDLY_PD=1 disable the
+	 *     digital delay counters (which are only used immediately after the
+	 *     SYNC pulse to delay the output by some number of VCO counts).
+	 */
+
+	return ret;
+}
+
 static int lmk04832_sclk_is_enabled(struct clk_hw *hw)
 {
 	struct lmk04832 *lmk = container_of(hw, struct lmk04832, sclk);
@@ -700,8 +941,16 @@ static int lmk04832_sclk_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (ret)
 		return ret;
 
-	return regmap_write(lmk->regmap, LMK04832_REG_SYSREF_DIV_LSB,
+	ret = regmap_write(lmk->regmap, LMK04832_REG_SYSREF_DIV_LSB,
 			    FIELD_GET(0x00ff, sysref_div));
+	if (ret)
+		return ret;
+
+	ret = lmk04832_sclk_sync_sequence(lmk);
+	if (ret)
+		dev_err(lmk->dev, "SYNC sequence failed\n");
+
+	return ret;
 }
 
 static const struct clk_ops lmk04832_sclk_ops = {
@@ -730,18 +979,37 @@ static int lmk04832_register_sclk(struct lmk04832 *lmk)
 	ret = regmap_update_bits(lmk->regmap, LMK04832_REG_SYSREF_OUT,
 				 LMK04832_BIT_SYSREF_MUX,
 				 FIELD_PREP(LMK04832_BIT_SYSREF_MUX,
-					    LMK04832_VAL_SYSREF_MUX_CONTINUOUS));
+					    lmk->sysref_mux));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(lmk->regmap, LMK04832_REG_SYSREF_DDLY_LSB,
+			   FIELD_GET(0x00ff, lmk->sysref_ddly));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(lmk->regmap, LMK04832_REG_SYSREF_DDLY_MSB,
+			   FIELD_GET(0x1f00, lmk->sysref_ddly));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(lmk->regmap, LMK04832_REG_SYSREF_PULSE_CNT,
+			   ilog2(lmk->sysref_pulse_cnt));
 	if (ret)
 		return ret;
 
 	ret = regmap_update_bits(lmk->regmap, LMK04832_REG_MAIN_PD,
+				 LMK04832_BIT_SYSREF_DDLY_PD |
 				 LMK04832_BIT_SYSREF_PLSR_PD,
-				 LMK04832_BIT_SYSREF_PLSR_PD);
+				 FIELD_PREP(LMK04832_BIT_SYSREF_DDLY_PD, 0) |
+				 FIELD_PREP(LMK04832_BIT_SYSREF_PLSR_PD, 0));
 	if (ret)
 		return ret;
 
-	ret = regmap_update_bits(lmk->regmap, LMK04832_REG_SYNC,
-				 LMK04832_BIT_SYNC_EN, 0xff);
+	ret = regmap_write(lmk->regmap, LMK04832_REG_SYNC,
+			   FIELD_PREP(LMK04832_BIT_SYNC_POL, 0) |
+			   FIELD_PREP(LMK04832_BIT_SYNC_EN, 1) |
+			   FIELD_PREP(LMK04832_BIT_SYNC_MODE, lmk->sync_mode));
 	if (ret)
 		return ret;
 
@@ -861,15 +1129,41 @@ static int lmk04832_dclk_set_rate(struct clk_hw *hw, unsigned long rate,
 			return ret;
 	}
 
+	/*
+	 * While using Divide-by-2 or Divide-by-3 for DCLK_X_Y_DIV, SYNC
+	 * procedure requires to first program Divide-by-4 and then back to
+	 * Divide-by-2 or Divide-by-3 before doing SYNC.
+	 */
+	if (dclk_div == 2 || dclk_div == 3) {
+		ret = regmap_update_bits(lmk->regmap,
+					 LMK04832_REG_CLKOUT_CTRL2(dclk->id),
+					 LMK04832_BIT_DCLK_DIV_MSB, 0x00);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(lmk->regmap,
+				   LMK04832_REG_CLKOUT_CTRL0(dclk->id), 0x04);
+		if (ret)
+			return ret;
+	}
+
 	ret = regmap_write(lmk->regmap, LMK04832_REG_CLKOUT_CTRL0(dclk->id),
 			   FIELD_GET(0x0ff, dclk_div));
 	if (ret)
 		return ret;
 
-	return regmap_update_bits(lmk->regmap,
+	ret = regmap_update_bits(lmk->regmap,
 				  LMK04832_REG_CLKOUT_CTRL2(dclk->id),
 				  LMK04832_BIT_DCLK_DIV_MSB,
 				  FIELD_GET(0x300, dclk_div));
+	if (ret)
+		return ret;
+
+	ret = lmk04832_sclk_sync_sequence(lmk);
+	if (ret)
+		dev_err(lmk->dev, "SYNC sequence failed\n");
+
+	return ret;
 };
 
 static const struct clk_ops lmk04832_dclk_ops = {
@@ -1152,6 +1446,21 @@ static int lmk04832_probe(struct spi_device *spi)
 
 	device_property_read_u32(lmk->dev, "ti,vco-hz", &lmk->vco_rate);
 
+	lmk->sysref_ddly = 8;
+	device_property_read_u32(lmk->dev, "ti,sysref-ddly", &lmk->sysref_ddly);
+
+	lmk->sysref_mux = LMK04832_VAL_SYSREF_MUX_CONTINUOUS;
+	device_property_read_u32(lmk->dev, "ti,sysref-mux",
+				 &lmk->sysref_mux);
+
+	lmk->sync_mode = LMK04832_VAL_SYNC_MODE_OFF;
+	device_property_read_u32(lmk->dev, "ti,sync-mode",
+				 &lmk->sync_mode);
+
+	lmk->sysref_pulse_cnt = 4;
+	device_property_read_u32(lmk->dev, "ti,sysref-pulse-count",
+				 &lmk->sysref_pulse_cnt);
+
 	for_each_child_of_node(lmk->dev->of_node, child) {
 		int reg;
 
-- 
2.30.1.489.g328c10930387

