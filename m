Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5377744BAB1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 04:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhKJDs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 22:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhKJDsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 22:48:22 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2F9C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 19:45:35 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id x7so389310pjn.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 19:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wBoAGbVhgj1EGgLNyNq5oP4OsB/aYBvxLMmAQPjrD6M=;
        b=IuHX1kyiNtczzfyUF64wMUY5b45f+Uv3BDp2qXlpngL5oedAtDCZGO5tFmyJI3/WjI
         GiDhdtJu48qpDkXqdXoy5wXkZmCH4b7ySeE13HFymZUvhbHCIEz68uczRWWQsLvUzjJ7
         a9x4YFN0gWFYI1/kP9KLhF2Cql1VZRSz0U6CWQv0Zp6AD6KU05i9VuRm6E/MbKkCmKsy
         E3/j254QBwXOp2RSzxjlAvy30Peh0009pHdv6a1YmNHR9x2BGigdsyQ36oj+QVx0eNzj
         efh5pxV1hl3U6PpK+B0Nm7Gb/ZwCK8sFo7Kia7889DDCJzqLCJ7UydrPLYQo6StrwN5f
         JS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wBoAGbVhgj1EGgLNyNq5oP4OsB/aYBvxLMmAQPjrD6M=;
        b=vrSyPZ0TIDGGLK5noMi2fXFl1MlGKlshhdWAQYFbT7izwIo5NjIQibBz8uK1oOceON
         sIY4+F/k4vQ90KyQxTQ3QWQUQqcI3j0MJDZr4/+f0Uap/6Swrnx/aPFhouxplRJPVtUD
         VSlSu44O9uwT0fmG2VDAfJ7k+XDTgf0GqITsoX07D5/gTNYBZ+sxH034n9NwoWKAEUv9
         7+TSwny+IdiFThcc577HKCbxH7pU64nWQABakrU9dMlJ0u8JhY5F10Gv+dXArV3ajorW
         A/zecisrZRin78L/cLJrK2hyPGwU04Q5/8AfmBKjU1ZJJDnnG7//CZ0xDiqqPKP3Ydgy
         znKA==
X-Gm-Message-State: AOAM531yMrYQA3RocgTnSwh1i08JIXxUC7cKIaoWtfhDI5zYQ5mdWTA4
        EjFr8kpm24vWFycb9X501b0=
X-Google-Smtp-Source: ABdhPJy7PzFemz2RPZj8gYWqRuzwe1u8zA+Czwnk1/u1ku5Jkqhm/bZUTDDjSZedB9HZTrg9UHVOpA==
X-Received: by 2002:a17:90a:be10:: with SMTP id a16mr13050233pjs.133.1636515935214;
        Tue, 09 Nov 2021 19:45:35 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:46a:f117:d5ee:c3e5:104f:c135])
        by smtp.gmail.com with ESMTPSA id q6sm5995293pgn.42.2021.11.09.19.45.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Nov 2021 19:45:34 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     oder_chiou@realtek.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com, allen_lin@richtek.com
Subject: [PATCH v2 2/3] ASoC: rt9120: Fix clock auto sync issue when fs is the multiple of 48
Date:   Wed, 10 Nov 2021 11:45:20 +0800
Message-Id: <1636515921-31694-3-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1636515921-31694-1-git-send-email-u0084500@gmail.com>
References: <1636515921-31694-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

If fs is divided by 48, to make audio clock sync rate correct, internal
sync function have be disabled.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 sound/soc/codecs/rt9120.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt9120.c b/sound/soc/codecs/rt9120.c
index 032c520..981aead 100644
--- a/sound/soc/codecs/rt9120.c
+++ b/sound/soc/codecs/rt9120.c
@@ -26,6 +26,7 @@
 #define RT9120_REG_INTERNAL0	0x65
 #define RT9120_REG_INTERNAL1	0x69
 #define RT9120_REG_UVPOPT	0x6C
+#define RT9120_REG_DIGCFG	0xF8
 
 #define RT9120_VID_MASK		GENMASK(15, 8)
 #define RT9120_SWRST_MASK	BIT(7)
@@ -46,6 +47,7 @@
 #define RT9120_CFG_WORDLEN_24	24
 #define RT9120_CFG_WORDLEN_32	32
 #define RT9120_DVDD_UVSEL_MASK	GENMASK(5, 4)
+#define RT9120_AUTOSYNC_MASK	BIT(6)
 
 #define RT9120_VENDOR_ID	0x4200
 #define RT9120_RESET_WAITMS	20
@@ -200,8 +202,8 @@ static int rt9120_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_component *comp = dai->component;
-	unsigned int param_width, param_slot_width;
-	int width;
+	unsigned int param_width, param_slot_width, auto_sync;
+	int width, fs;
 
 	switch (width = params_width(param)) {
 	case 16:
@@ -239,6 +241,16 @@ static int rt9120_hw_params(struct snd_pcm_substream *substream,
 
 	snd_soc_component_update_bits(comp, RT9120_REG_I2SWL,
 				      RT9120_AUDWL_MASK, param_slot_width);
+
+	fs = width * params_channels(param);
+	/* If fs is divided by 48, disable auto sync */
+	if (fs % 48 == 0)
+		auto_sync = 0;
+	else
+		auto_sync = RT9120_AUTOSYNC_MASK;
+
+	snd_soc_component_update_bits(comp, RT9120_REG_DIGCFG,
+				      RT9120_AUTOSYNC_MASK, auto_sync);
 	return 0;
 }
 
@@ -280,7 +292,8 @@ static const struct regmap_range rt9120_rd_yes_ranges[] = {
 	regmap_reg_range(0x3A, 0x40),
 	regmap_reg_range(0x65, 0x65),
 	regmap_reg_range(0x69, 0x69),
-	regmap_reg_range(0x6C, 0x6C)
+	regmap_reg_range(0x6C, 0x6C),
+	regmap_reg_range(0xF8, 0xF8)
 };
 
 static const struct regmap_access_table rt9120_rd_table = {
@@ -298,7 +311,8 @@ static const struct regmap_range rt9120_wr_yes_ranges[] = {
 	regmap_reg_range(0x40, 0x40),
 	regmap_reg_range(0x65, 0x65),
 	regmap_reg_range(0x69, 0x69),
-	regmap_reg_range(0x6C, 0x6C)
+	regmap_reg_range(0x6C, 0x6C),
+	regmap_reg_range(0xF8, 0xF8)
 };
 
 static const struct regmap_access_table rt9120_wr_table = {
@@ -369,7 +383,7 @@ static int rt9120_reg_write(void *context, unsigned int reg, unsigned int val)
 static const struct regmap_config rt9120_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 32,
-	.max_register = RT9120_REG_UVPOPT,
+	.max_register = RT9120_REG_DIGCFG,
 
 	.reg_read = rt9120_reg_read,
 	.reg_write = rt9120_reg_write,
-- 
2.7.4

