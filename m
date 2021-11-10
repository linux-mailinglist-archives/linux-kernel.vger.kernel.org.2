Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C86A44BAB2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 04:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhKJDs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 22:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhKJDsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 22:48:25 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BA1C061766
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 19:45:39 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id k4so1847504plx.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 19:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fe2DNRNkXeR676K2UnXemGHLWR3/blj3DgcVGP77Sl4=;
        b=d2Lnis2lVAn3Shp2hgnHRRuzKn0sQXgQ2yZevjqWlfL5Vp8YIVg1w2yam0cfj92wqZ
         pav63t4EAazrt4Dzy697fEkJUeQBD/BdAhCFpgl8uFYW8mkAJ0rPqVcGN6KGOEMbfjjx
         KGWf7GOkaO8phjeWoa312aVqbiWgoBQ9KgoOuhhz+XLYVZrVBDURS28h1Ur81IjSlHv+
         VdaLD6mNtX2iC/hoOARpqrFrAvHLQzvpSwkK74FbSGlRfwSDs4iDCq7yTd824kjcNYmB
         TFsUfc81pj/5he7S/Bs6Z7yI+hlwRu4C29vbu04Jf4d4wbVcoJPIqBodPqnMbd3YVEYr
         Kbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fe2DNRNkXeR676K2UnXemGHLWR3/blj3DgcVGP77Sl4=;
        b=7wjbfOAABJ9im+McMDnSG52w1B70u8/PclRG5Dn8qFEe6iYbnwaa1vMUUsmb/l0TLg
         Ch6b3ws23V82BmCeNFaKF+ff1ufEvtrI/rYDguoYEst/MPtDBJn+W85e4OS4oQCDefFZ
         EjeoF6C5WnOQb+eIGjy7n93z2WvRFgYPpejjQE8iUtpfsy8BYe3QYxH4V+dYYjHJqTBq
         WCAkjyFsuTbTMdYFwGxYJW5ca7S9oERlaCSx3IFPzc4+M62RGG+/vjkNPHogltK7YToe
         qEFzrnLpZfGkeypuCs4pvI4GmeA8XP9Bye8BfcG/PPYylNds0uDuhllO9Fo6nW1LpKV5
         wZgw==
X-Gm-Message-State: AOAM532m6dQDlcuc4lGAdAIVdhX6zGagJHdxgOR8zMnOOLQuDganM3MD
        SNI1HtoJc9HprlB0fVRlKiC76e77JUA=
X-Google-Smtp-Source: ABdhPJw3CwBfo/2T2/e7B8O1i1tAIhXztFwJ3KhMS69aDE3ak9G4yX1W8/VfM4Te+LqpSvQdNv9M+Q==
X-Received: by 2002:a17:90a:6782:: with SMTP id o2mr13385208pjj.165.1636515938601;
        Tue, 09 Nov 2021 19:45:38 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:46a:f117:d5ee:c3e5:104f:c135])
        by smtp.gmail.com with ESMTPSA id q6sm5995293pgn.42.2021.11.09.19.45.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Nov 2021 19:45:38 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     oder_chiou@realtek.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com, allen_lin@richtek.com
Subject: [PATCH v2 3/3] ASoC: rt9120: Add the compatibility with rt9120s
Date:   Wed, 10 Nov 2021 11:45:21 +0800
Message-Id: <1636515921-31694-4-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1636515921-31694-1-git-send-email-u0084500@gmail.com>
References: <1636515921-31694-1-git-send-email-u0084500@gmail.com>
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
index 981aead..7aa1772 100644
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
 
@@ -290,6 +305,7 @@ static const struct regmap_range rt9120_rd_yes_ranges[] = {
 	regmap_reg_range(0x20, 0x27),
 	regmap_reg_range(0x30, 0x38),
 	regmap_reg_range(0x3A, 0x40),
+	regmap_reg_range(0x63, 0x63),
 	regmap_reg_range(0x65, 0x65),
 	regmap_reg_range(0x69, 0x69),
 	regmap_reg_range(0x6C, 0x6C),
@@ -309,6 +325,7 @@ static const struct regmap_range rt9120_wr_yes_ranges[] = {
 	regmap_reg_range(0x30, 0x38),
 	regmap_reg_range(0x3A, 0x3D),
 	regmap_reg_range(0x40, 0x40),
+	regmap_reg_range(0x63, 0x63),
 	regmap_reg_range(0x65, 0x65),
 	regmap_reg_range(0x69, 0x69),
 	regmap_reg_range(0x6C, 0x6C),
@@ -401,8 +418,16 @@ static int rt9120_check_vendor_info(struct rt9120_data *data)
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

