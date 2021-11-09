Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB8944A6CC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 07:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243181AbhKIG0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 01:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhKIG0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 01:26:46 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29B7C061764
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 22:24:00 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id v20so19072662plo.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 22:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iGYGbg+9l8ssVOmfcebv8ju3BSiG3enW9yQKoptJRsQ=;
        b=oCzarSAYqvAhQ2Wyka7w85rnjr4nvbv552bjvAGXOP48ZZ1HWJr68dR0FbRYt5u8ZI
         uUZs0GQLU6gV7o0PgTpZ6UQGGohZeZVhuM4NU49YovfY2w/dwxYegguIM02e1HYwUeAN
         Hk15z8DXZJ/l79n+sjzu4ZzyWx0pb5hjNzBhVM40Tc4Fzjoh9FWmytXCdQnveKUCIIfM
         fFbBfAxjLqM3qrK/yKhHAQ7YMC8YMlh6F3bRp0taRO5ZtWA5kCUDPa69cnRkTiMC/Mwl
         2FVNld/5FyVL7sfN1AB8gM4YDxQ6p0ze/7aZMevZ3Qs2UHdrRKLur5hFutDNmOtcoq2x
         kMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iGYGbg+9l8ssVOmfcebv8ju3BSiG3enW9yQKoptJRsQ=;
        b=h2TFDO4MsH6OPS0l3LNFbHTaa3QyOwUdPMrqcBFhkPJxvRooM3UWOod1PX/RDS1tNJ
         8V9BAUBYpoCWUjkYfCCDOFm2gH5BmDHlDjt6NtotIDYo5jOIsBdg5C18HDrOnYZIOYwf
         jJ+F9wnNjibVdUVHMiFeoZOFkWfyn8r/fqtJ01n/laWTLtBZ/o6huoUbdCcC1jKrHC2K
         Nv75SpsOjwcgRgcMHoqvYnUthOW0X+mDAfWKb/FkpIsaSgFhaOt3Wc9RYdaLcFcxM9O0
         p5wBJZPAJ12wGTjkaA5Z//E+7gMkuTQ+5FSxT/D0VzAk6Txoa/QI7xntb2x+tjGX2SbY
         xqBQ==
X-Gm-Message-State: AOAM532IIfC1/uVJ3R/9fOrrvnPrU9op6ZSMYQTBYxdqbZxRhSZjhyg8
        ajQzSFoipMED1IIXxi2PaGkm86YgyGM=
X-Google-Smtp-Source: ABdhPJxL7Knq0JkBX4KTpSPx9/BalN7ds4cqaw1TYpytKxqBeTgd09WzvXYXtGRATb14xXc5Tw0hAg==
X-Received: by 2002:a17:90a:690d:: with SMTP id r13mr4670069pjj.40.1636439040238;
        Mon, 08 Nov 2021 22:24:00 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:578:468f:d592:ff78:ffa9:3df7])
        by smtp.gmail.com with ESMTPSA id x33sm6856718pfh.133.2021.11.08.22.23.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Nov 2021 22:23:59 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     oder_chiou@realtek.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com, allen_lin@richtek.com
Subject: [PATCH 2/2] ASoC: rt9120: Add the compatibility with rt9120s
Date:   Tue,  9 Nov 2021 14:23:44 +0800
Message-Id: <1636439024-15877-3-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1636439024-15877-1-git-send-email-u0084500@gmail.com>
References: <1636439024-15877-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Use device id reg to be compatible with rt9120 and rt9120s.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 sound/soc/codecs/rt9120.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt9120.c b/sound/soc/codecs/rt9120.c
index d007d00..6974705 100644
--- a/sound/soc/codecs/rt9120.c
+++ b/sound/soc/codecs/rt9120.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/bits.h>
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
@@ -23,6 +24,7 @@
 #define RT9120_REG_ERRRPT	0x10
 #define RT9120_REG_MSVOL	0x20
 #define RT9120_REG_SWRESET	0x40
+#define RT9120_REG_INTERCFG	0x63
 #define RT9120_REG_INTERNAL0	0x65
 #define RT9120_REG_INTERNAL1	0x69
 #define RT9120_REG_UVPOPT	0x6C
@@ -49,7 +51,8 @@
 #define RT9120_DVDD_UVSEL_MASK	GENMASK(5, 4)
 #define RT9120_AUTOSYNC_MASK	BIT(6)
 
-#define RT9120_VENDOR_ID	0x4200
+#define RT9120_VENDOR_ID	0x42
+#define RT9120S_VENDOR_ID	0x43
 #define RT9120_RESET_WAITMS	20
 #define RT9120_CHIPON_WAITMS	20
 #define RT9120_AMPON_WAITMS	50
@@ -63,9 +66,16 @@
 				 SNDRV_PCM_FMTBIT_S24_LE |\
 				 SNDRV_PCM_FMTBIT_S32_LE)
 
+enum {
+	CHIP_IDX_RT9120 = 0,
+	CHIP_IDX_RT9120S,
+	CHIP_IDX_MAX
+};
+
 struct rt9120_data {
 	struct device *dev;
 	struct regmap *regmap;
+	int chip_idx;
 };
 
 /* 11bit [min,max,step] = [-103.9375dB, 24dB, 0.0625dB] */
@@ -151,7 +161,12 @@ static int rt9120_codec_probe(struct snd_soc_component *comp)
 	snd_soc_component_init_regmap(comp, data->regmap);
 
 	/* Internal setting */
-	snd_soc_component_write(comp, RT9120_REG_INTERNAL0, 0x04);
+	if (data->chip_idx == CHIP_IDX_RT9120S) {
+		snd_soc_component_write(comp, RT9120_REG_INTERCFG, 0xde);
+		snd_soc_component_write(comp, RT9120_REG_INTERNAL0, 0x66);
+	} else
+		snd_soc_component_write(comp, RT9120_REG_INTERNAL0, 0x04);
+
 	return 0;
 }
 
@@ -291,6 +306,7 @@ static const struct regmap_range rt9120_rd_yes_ranges[] = {
 	regmap_reg_range(0x20, 0x27),
 	regmap_reg_range(0x30, 0x38),
 	regmap_reg_range(0x3A, 0x40),
+	regmap_reg_range(0x63, 0x63),
 	regmap_reg_range(0x65, 0x65),
 	regmap_reg_range(0x69, 0x69),
 	regmap_reg_range(0x6C, 0x6C),
@@ -310,6 +326,7 @@ static const struct regmap_range rt9120_wr_yes_ranges[] = {
 	regmap_reg_range(0x30, 0x38),
 	regmap_reg_range(0x3A, 0x3D),
 	regmap_reg_range(0x40, 0x40),
+	regmap_reg_range(0x63, 0x63),
 	regmap_reg_range(0x65, 0x65),
 	regmap_reg_range(0x69, 0x69),
 	regmap_reg_range(0x6C, 0x6C),
@@ -402,8 +419,16 @@ static int rt9120_check_vendor_info(struct rt9120_data *data)
 	if (ret)
 		return ret;
 
-	if ((devid & RT9120_VID_MASK) != RT9120_VENDOR_ID) {
-		dev_err(data->dev, "DEVID not correct [0x%04x]\n", devid);
+	devid = FIELD_GET(RT9120_VID_MASK, devid);
+	switch (devid) {
+	case RT9120_VENDOR_ID:
+		data->chip_idx = CHIP_IDX_RT9120;
+		break;
+	case RT9120S_VENDOR_ID:
+		data->chip_idx = CHIP_IDX_RT9120S;
+		break;
+	default:
+		dev_err(data->dev, "DEVID not correct [0x%0x]\n", devid);
 		return -ENODEV;
 	}
 
-- 
2.7.4

