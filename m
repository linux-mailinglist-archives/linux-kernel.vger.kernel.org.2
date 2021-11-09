Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D2A44A6CA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 07:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243164AbhKIG0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 01:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhKIG0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 01:26:42 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6521BC061764
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 22:23:57 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id o14so19083377plg.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 22:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AUTPhAtZa6U0xaRNrom5ttukLaD6yyy5owHS5UhsYZs=;
        b=p+p0uxg9oKbjknvm1SbGEz007oMpEKL1EWMu+0UNLudwTT0+JOdaEXMQTopKL7HN4J
         7J5HuTzqjDHaUPM1eopjtsHdNapvfeAxVEpfVt5ePl+SKVcep8f4pYLHrzHPxFCWrHm2
         sGgtGBgRJ3xWkLJ+j/iGtA8z6V17AJvdMfXjPljSuykwdjp5q+HjlGLKxlIzzv3cBrU9
         RpzeGm50H/hBvldbewpbRG3nVjgzDhhKgoAjLq0NBfG+ROr3mWY3XyFYna40eJFgFsMK
         S8WN6Ol6MIS3g868m6i8ddh4EXNiudCxGXANviGJojHRVu9ZmodDKxLAnsrn+hnUAOVP
         GzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AUTPhAtZa6U0xaRNrom5ttukLaD6yyy5owHS5UhsYZs=;
        b=zc7xsOwgnERLO1b414oPpQeH74keTaANK3D9qaQZYTKpBqliUJQAIa/joQKfIww2rg
         7Le5iF1JgUpO87BmK0LKYanPPyNRmYa4Vce1bHpuZAbn2pWLcLWo15gNWjIKKcBqwOwx
         Q+vQdgSAcod5yHtGxOrJYGXBOSU9VJ2f1xGg/Wrch3BX2RFlRvwCMt4pA0S7FTBdNU2r
         7ZkxP979LGQrdw++jIw2uYz+eRwAX2PchBdSfc1RI3/jzvvumjeRAXzcXXTDc9LXbD2h
         HTmWqS4YHpkJa5vXXScfQjD1WSEqsHUZa+nmCr1HcLPpmkFwapKgQ/xfI/Lc/7dZkRq4
         BJHQ==
X-Gm-Message-State: AOAM530UmYPL/msv66B9fWn6DXj7/giP8OprHTa0BPB5pafRt2KXTJA4
        9HAn1UN/h/6fu8HvqwzE0s0=
X-Google-Smtp-Source: ABdhPJy7RZnVXtKga+QtYWFI+8dLt7Ta7ipOXSIdBF8wqFJVFF2L1jSD3KDm2Dpo2IO8kRO4ehD59Q==
X-Received: by 2002:a17:902:780f:b0:13a:3919:e365 with SMTP id p15-20020a170902780f00b0013a3919e365mr4692458pll.63.1636439036880;
        Mon, 08 Nov 2021 22:23:56 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:578:468f:d592:ff78:ffa9:3df7])
        by smtp.gmail.com with ESMTPSA id x33sm6856718pfh.133.2021.11.08.22.23.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Nov 2021 22:23:56 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     oder_chiou@realtek.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com, allen_lin@richtek.com
Subject: [PATCH 1/2] ASoC: rt9120: Update internal setting and fix auto sync problem
Date:   Tue,  9 Nov 2021 14:23:43 +0800
Message-Id: <1636439024-15877-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1636439024-15877-1-git-send-email-u0084500@gmail.com>
References: <1636439024-15877-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

- Update internal setting to fix issue.
- Disable auto sync if fs is divided by 48.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 sound/soc/codecs/rt9120.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/rt9120.c b/sound/soc/codecs/rt9120.c
index f957498..d007d00 100644
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
@@ -149,8 +151,7 @@ static int rt9120_codec_probe(struct snd_soc_component *comp)
 	snd_soc_component_init_regmap(comp, data->regmap);
 
 	/* Internal setting */
-	snd_soc_component_write(comp, RT9120_REG_INTERNAL1, 0x03);
-	snd_soc_component_write(comp, RT9120_REG_INTERNAL0, 0x69);
+	snd_soc_component_write(comp, RT9120_REG_INTERNAL0, 0x04);
 	return 0;
 }
 
@@ -201,8 +202,8 @@ static int rt9120_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_component *comp = dai->component;
-	unsigned int param_width, param_slot_width;
-	int width;
+	unsigned int param_width, param_slot_width, auto_sync;
+	int width, fs;
 
 	switch (width = params_width(param)) {
 	case 16:
@@ -240,6 +241,17 @@ static int rt9120_hw_params(struct snd_pcm_substream *substream,
 
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
+
 	return 0;
 }
 
@@ -281,7 +293,8 @@ static const struct regmap_range rt9120_rd_yes_ranges[] = {
 	regmap_reg_range(0x3A, 0x40),
 	regmap_reg_range(0x65, 0x65),
 	regmap_reg_range(0x69, 0x69),
-	regmap_reg_range(0x6C, 0x6C)
+	regmap_reg_range(0x6C, 0x6C),
+	regmap_reg_range(0xF8, 0xF8)
 };
 
 static const struct regmap_access_table rt9120_rd_table = {
@@ -299,7 +312,8 @@ static const struct regmap_range rt9120_wr_yes_ranges[] = {
 	regmap_reg_range(0x40, 0x40),
 	regmap_reg_range(0x65, 0x65),
 	regmap_reg_range(0x69, 0x69),
-	regmap_reg_range(0x6C, 0x6C)
+	regmap_reg_range(0x6C, 0x6C),
+	regmap_reg_range(0xF8, 0xF8)
 };
 
 static const struct regmap_access_table rt9120_wr_table = {
@@ -370,7 +384,7 @@ static int rt9120_reg_write(void *context, unsigned int reg, unsigned int val)
 static const struct regmap_config rt9120_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 32,
-	.max_register = RT9120_REG_UVPOPT,
+	.max_register = RT9120_REG_DIGCFG,
 
 	.reg_read = rt9120_reg_read,
 	.reg_write = rt9120_reg_write,
-- 
2.7.4

