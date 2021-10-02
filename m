Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90BB41FEC7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 01:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbhJBXpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 19:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbhJBXpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 19:45:20 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA935C0613EF
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 16:43:33 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id b192so10043948wmb.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 16:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hgtwgASIU2S9cTG1IYenshFLUzfZ9j3XLdKPZT+Vt+I=;
        b=icLjFAJ6wVHjLEjuWWJ/+yFvvcXnNmT8QEeBUojow7R7aVHlgNAsLsqIrdCn6QMNkj
         Nw13uFetu+cDHyvfHBoMSwhwIa0LwD+Iz/JBA1hsjhEYnvhrNmnQqzCyAjAaDM2ctgG3
         5KjzbHm+bCXQSAaf0H09JEDElzPJhFi5blU89mFpoMkgucNpkWHsnqwZ81JiZ7mWDvlo
         mQjVRbh0upNSmAdye08I6KAK8FmnY66gFt8XYgEypPl8w0lpldceuEvGuo0RHSk9O9P3
         9dfmr/sNaVUyxEI5zkQeySht0ODaFoyLO/LE93xpChlGbXnKqQRd4hDTIqt+vRKy4d0k
         x7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hgtwgASIU2S9cTG1IYenshFLUzfZ9j3XLdKPZT+Vt+I=;
        b=jKcwXGVQ10lT0ppv9QTW/mgc9JjbrYlNR490s4hQ55QQcsp7WFtwdjjFgX+k2j+cA6
         vJfOIHNKVZ0Hefhsy8a/nId8skwVh9kE6QQZ4VTHFWGbA5+MWLX87xmKJifwu+P68pqZ
         +djqSEMWE6nDrz5gBkoD5Az0Mc0EaAIJLyoIDYuxhKeWif9A1vVpEO5zUWc8yxvzOH0R
         UYq+p6GSdB7FeO4cbsGCcOFUxjSaEN3Lcg8OO8/jhutslrrkaOBLgQi0JxyPTQ6T2qHz
         KFAI6TiKAFi4KKelshCH5Phz1GOdyQvoxYw7O8QEE3sR9C9gyV3ve82xSULrDTcc8N8c
         5iVQ==
X-Gm-Message-State: AOAM5322Wauh8JBvHcxMXFsg94EeCNUVYfvTReZ0pDzm5fausg+bVy+p
        0DhhBfpcs3DN8Igy94TX8UI=
X-Google-Smtp-Source: ABdhPJyU0FswveQk5Bv5c/28BfiH8bNP4GmyUxp3rdpMUQGaardPEQJyXT6LqU+Kx0dASloRjZKwPg==
X-Received: by 2002:a7b:cd82:: with SMTP id y2mr11079862wmj.106.1633218212387;
        Sat, 02 Oct 2021 16:43:32 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-7bbe-df00-f22f-74ff-fe21-0725.c22.pool.telefonica.de. [2a01:c22:7bbe:df00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id z6sm13999463wmp.1.2021.10.02.16.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 16:43:32 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, alsa-devel@alsa-project.org,
        linux-amlogic@lists.infradead.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC PATCH v1 1/1] ASoC: meson: aiu: Fix HDMI codec control selection
Date:   Sun,  3 Oct 2021 01:43:13 +0200
Message-Id: <20211002234313.3209294-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211002234313.3209294-1-martin.blumenstingl@googlemail.com>
References: <20211002234313.3209294-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HDMI controllers on Amlogic Meson SoCs which use the AIU
audio-controller have two different audio format inputs:
- I2S which is also the only configuration supported on GXBB, GXL and
  GXM SoCs since there's no SPDIF support in the DesignWare HDMI
  controller driver (at the time of writing this)
- SPDIF can be used optionally, including pass-through formats

Switching between these requires us to set different registers:
AIU_HDMI_CLK_DATA_CTRL[1:0] "HDMI_DATA_CLK_SEL":
- 0x0 disables the HDMI output clock
- 0x1 selects the PCM clock
- 0x2 selects the AIU clock
- 0x3 is reserved

AIU_HDMI_CLK_DATA_CTRL[5:4] "HDMI_DATA_SEL":
- 0x0 outputs constant zero, disables HDMI data
- 0x1 selects PCM data
- 0x2 selects AIU I2S data
- 0x3 is reserved

AIU_CLK_CTRL_MORE[6] "HDMITX_SEL_AOCLKX2":
- 0x0 selects cts_i958 as AIU clk to hdmi_tx_audio_master_clk
- 0x1 selects cts_aoclkx2_int as AIU clk to hdmi_tx_audio_master_clk

The Meson8/8b/8m2 vendor driver uses the following settings:
SPDIF output to the HDMI controller:
- 0x2 (AIU clock) in AIU_HDMI_CLK_DATA_CTRL[1:0]
- 0x0 (no HDMI data) in AIU_HDMI_CLK_DATA_CTRL[5:4]
- 0x0 (using cts_i958 as AIU clk) in AIU_CLK_CTRL_MORE[6]
I2S output to the HDMI controller:
- 0x2 (AIU clock) in AIU_HDMI_CLK_DATA_CTRL[1:0]
- 0x2 (I2S data) in AIU_HDMI_CLK_DATA_CTRL[5:4]
- 0x0 (using cts_aoclkx2_int as AIU clk) in AIU_CLK_CTRL_MORE[6]

The GXBB/GXL/GXM vendor driver uses the following settings:
SPDIF output to the HDMI controller:
- not setting AIU_HDMI_CLK_DATA_CTRL at all
- 0x0 (using cts_i958 as AIU clk) in AIU_CLK_CTRL_MORE[6]
I2S output to the HDMI controller:
- 0x2 (AIU clock) in AIU_HDMI_CLK_DATA_CTRL[1:0]
- 0x2 (I2S data) in AIU_HDMI_CLK_DATA_CTRL[5:4]
- 0x0 (using cts_aoclkx2_int as AIU clk) in AIU_CLK_CTRL_MORE[6]

Set the three registers at the same time following what the vendor
driver does on Meson8/8b/8m2 SoCs. This makes the SPDIF output to the
HDMI controller work. The entries and order of the entries in the enum
is not changed on purpose to not break old configurations.

Fixes: b82b734c0e9a7 ("ASoC: meson: aiu: add hdmi codec control support")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 sound/soc/meson/aiu-codec-ctrl.c  | 108 ++++++++++++++++++++++--------
 sound/soc/meson/aiu-encoder-i2s.c |   6 --
 2 files changed, 80 insertions(+), 34 deletions(-)

diff --git a/sound/soc/meson/aiu-codec-ctrl.c b/sound/soc/meson/aiu-codec-ctrl.c
index c3ea733fce91..2b8575491aeb 100644
--- a/sound/soc/meson/aiu-codec-ctrl.c
+++ b/sound/soc/meson/aiu-codec-ctrl.c
@@ -12,14 +12,60 @@
 #include "aiu.h"
 #include "meson-codec-glue.h"
 
-#define CTRL_CLK_SEL		GENMASK(1, 0)
-#define CTRL_DATA_SEL_SHIFT	4
-#define CTRL_DATA_SEL		(0x3 << CTRL_DATA_SEL_SHIFT)
-
-static const char * const aiu_codec_ctrl_mux_texts[] = {
-	"DISABLED", "PCM", "I2S",
+#define AIU_HDMI_CLK_DATA_CTRL_CLK_SEL			GENMASK(1, 0)
+#define AIU_HDMI_CLK_DATA_CTRL_CLK_SEL_DISABLE		0x0
+#define AIU_HDMI_CLK_DATA_CTRL_CLK_SEL_PCM		0x1
+#define AIU_HDMI_CLK_DATA_CTRL_CLK_SEL_AIU		0x2
+#define AIU_HDMI_CLK_DATA_CTRL_DATA_SEL			GENMASK(5, 4)
+#define AIU_HDMI_CLK_DATA_CTRL_DATA_SEL_OUTPUT_ZERO	0x0
+#define AIU_HDMI_CLK_DATA_CTRL_DATA_SEL_PCM_DATA	0x1
+#define AIU_HDMI_CLK_DATA_CTRL_DATA_SEL_I2S_DATA	0x2
+
+#define AIU_CLK_CTRL_MORE_AMCLK				BIT(6)
+
+#define AIU_HDMI_CTRL_MUX_DISABLED			0
+#define AIU_HDMI_CTRL_MUX_PCM				1
+#define AIU_HDMI_CTRL_MUX_I2S				2
+
+static const char * const aiu_codec_hdmi_ctrl_mux_texts[] = {
+	[AIU_HDMI_CTRL_MUX_DISABLED] =  "DISABLED",
+	[AIU_HDMI_CTRL_MUX_PCM] = "PCM",
+	[AIU_HDMI_CTRL_MUX_I2S] = "I2S",
 };
 
+static int aiu_codec_ctrl_mux_get_enum(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+		snd_soc_dapm_kcontrol_component(kcontrol);
+	unsigned int ctrl, more, mux = AIU_HDMI_CTRL_MUX_DISABLED;
+
+	ctrl = snd_soc_component_read(component, AIU_HDMI_CLK_DATA_CTRL);
+	if (FIELD_GET(AIU_HDMI_CLK_DATA_CTRL_CLK_SEL, ctrl) !=
+	    AIU_HDMI_CLK_DATA_CTRL_CLK_SEL_AIU) {
+		goto out;
+	}
+
+	more = snd_soc_component_read(component, AIU_CLK_CTRL_MORE);
+	if (FIELD_GET(AIU_HDMI_CLK_DATA_CTRL_DATA_SEL, ctrl) ==
+	    AIU_HDMI_CLK_DATA_CTRL_DATA_SEL_I2S_DATA &&
+	    !!(more & AIU_CLK_CTRL_MORE_AMCLK)) {
+		mux = AIU_HDMI_CTRL_MUX_I2S;
+		goto out;
+	}
+
+	if (FIELD_GET(AIU_HDMI_CLK_DATA_CTRL_DATA_SEL, ctrl) ==
+	    AIU_HDMI_CLK_DATA_CTRL_DATA_SEL_OUTPUT_ZERO &&
+	    !(more & AIU_CLK_CTRL_MORE_AMCLK)) {
+		mux = AIU_HDMI_CTRL_MUX_PCM;
+		goto out;
+	}
+
+out:
+	ucontrol->value.enumerated.item[0] = mux;
+	return 0;
+}
+
 static int aiu_codec_ctrl_mux_put_enum(struct snd_kcontrol *kcontrol,
 				       struct snd_ctl_elem_value *ucontrol)
 {
@@ -28,45 +74,51 @@ static int aiu_codec_ctrl_mux_put_enum(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dapm_context *dapm =
 		snd_soc_dapm_kcontrol_dapm(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
-	unsigned int mux, changed;
+	unsigned int mux, ctrl, more;
 
 	mux = snd_soc_enum_item_to_val(e, ucontrol->value.enumerated.item[0]);
-	changed = snd_soc_component_test_bits(component, e->reg,
-					      CTRL_DATA_SEL,
-					      FIELD_PREP(CTRL_DATA_SEL, mux));
 
-	if (!changed)
-		return 0;
+	if (mux == AIU_HDMI_CTRL_MUX_I2S) {
+		ctrl = FIELD_PREP(AIU_HDMI_CLK_DATA_CTRL_DATA_SEL,
+				  AIU_HDMI_CLK_DATA_CTRL_DATA_SEL_I2S_DATA);
+		more = AIU_CLK_CTRL_MORE_AMCLK;
+	} else {
+		ctrl = FIELD_PREP(AIU_HDMI_CLK_DATA_CTRL_DATA_SEL,
+				  AIU_HDMI_CLK_DATA_CTRL_DATA_SEL_OUTPUT_ZERO);
+		more = 0;
+	}
+
+	if (mux == AIU_HDMI_CTRL_MUX_DISABLED) {
+		ctrl |= FIELD_PREP(AIU_HDMI_CLK_DATA_CTRL_CLK_SEL,
+				   AIU_HDMI_CLK_DATA_CTRL_CLK_SEL_DISABLE);
+	} else {
+		ctrl |= FIELD_PREP(AIU_HDMI_CLK_DATA_CTRL_CLK_SEL,
+				   AIU_HDMI_CLK_DATA_CTRL_CLK_SEL_AIU);
+	}
 
 	/* Force disconnect of the mux while updating */
 	snd_soc_dapm_mux_update_power(dapm, kcontrol, 0, NULL, NULL);
 
-	/* Reset the source first */
-	snd_soc_component_update_bits(component, e->reg,
-				      CTRL_CLK_SEL |
-				      CTRL_DATA_SEL,
-				      FIELD_PREP(CTRL_CLK_SEL, 0) |
-				      FIELD_PREP(CTRL_DATA_SEL, 0));
+	snd_soc_component_update_bits(component, AIU_HDMI_CLK_DATA_CTRL,
+				      AIU_HDMI_CLK_DATA_CTRL_CLK_SEL |
+				      AIU_HDMI_CLK_DATA_CTRL_DATA_SEL,
+				      ctrl);
 
-	/* Set the appropriate source */
-	snd_soc_component_update_bits(component, e->reg,
-				      CTRL_CLK_SEL |
-				      CTRL_DATA_SEL,
-				      FIELD_PREP(CTRL_CLK_SEL, mux) |
-				      FIELD_PREP(CTRL_DATA_SEL, mux));
+	snd_soc_component_update_bits(component, AIU_CLK_CTRL_MORE,
+				      AIU_CLK_CTRL_MORE_AMCLK,
+				      more);
 
 	snd_soc_dapm_mux_update_power(dapm, kcontrol, mux, e, NULL);
 
 	return 0;
 }
 
-static SOC_ENUM_SINGLE_DECL(aiu_hdmi_ctrl_mux_enum, AIU_HDMI_CLK_DATA_CTRL,
-			    CTRL_DATA_SEL_SHIFT,
-			    aiu_codec_ctrl_mux_texts);
+static SOC_ENUM_SINGLE_VIRT_DECL(aiu_hdmi_ctrl_mux_enum,
+				 aiu_codec_hdmi_ctrl_mux_texts);
 
 static const struct snd_kcontrol_new aiu_hdmi_ctrl_mux =
 	SOC_DAPM_ENUM_EXT("HDMI Source", aiu_hdmi_ctrl_mux_enum,
-			  snd_soc_dapm_get_enum_double,
+			  aiu_codec_ctrl_mux_get_enum,
 			  aiu_codec_ctrl_mux_put_enum);
 
 static const struct snd_soc_dapm_widget aiu_hdmi_ctrl_widgets[] = {
diff --git a/sound/soc/meson/aiu-encoder-i2s.c b/sound/soc/meson/aiu-encoder-i2s.c
index d6aea7797641..ba3dac987112 100644
--- a/sound/soc/meson/aiu-encoder-i2s.c
+++ b/sound/soc/meson/aiu-encoder-i2s.c
@@ -24,7 +24,6 @@
 #define AIU_CLK_CTRL_AOCLK_INVERT	BIT(6)
 #define AIU_CLK_CTRL_LRCLK_INVERT	BIT(7)
 #define AIU_CLK_CTRL_LRCLK_SKEW		GENMASK(9, 8)
-#define AIU_CLK_CTRL_MORE_HDMI_AMCLK	BIT(6)
 #define AIU_CLK_CTRL_MORE_I2S_DIV	GENMASK(5, 0)
 #define AIU_CODEC_DAC_LRCLK_CTRL_DIV	GENMASK(11, 0)
 
@@ -210,11 +209,6 @@ static int aiu_encoder_i2s_set_clocks(struct snd_soc_component *component,
 	if (ret)
 		return ret;
 
-	/* Make sure amclk is used for HDMI i2s as well */
-	snd_soc_component_update_bits(component, AIU_CLK_CTRL_MORE,
-				      AIU_CLK_CTRL_MORE_HDMI_AMCLK,
-				      AIU_CLK_CTRL_MORE_HDMI_AMCLK);
-
 	return 0;
 }
 
-- 
2.33.0

