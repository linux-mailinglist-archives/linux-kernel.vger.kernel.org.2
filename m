Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEF63C26C6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 17:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbhGIP1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 11:27:11 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:59032
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231976AbhGIP1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 11:27:09 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id E142B404A0;
        Fri,  9 Jul 2021 15:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1625844265;
        bh=JWX8SivwH7nNO5NjJ1Y3vDYXQvqvNAJL4GkZFF3gAA4=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=ePrbXVj2d8tzWtAZ72kOZKJnJnFlv8oFGJ8pLEqAujdtH/MVyeDdOIW24eJQzHqVx
         NCj4baz7sedv+K8XwH+yuUhLnZJkbGbgvet30xNO78qDL98u23kHbOpcUxMS9DpbXY
         ovm9gwL1yCTDV9r6T76ktqqHTrnSYiMOcwX1a1muEcqSF7PNtaX/rPBTk+XccNOKuF
         A7Vqy2ZlYV7bQEBn0dTLNJc22vc4fDDPdGEab/XGVxWJ2y51em27e+xgc4Rqwa4uw6
         sQocDG/xdakcBM0RoLO880rIWftu5WVfE4OHeTWnNJJmLohqayDxkg2VR0x4yZOkhw
         I50Ch2StUcfjA==
From:   Colin King <colin.king@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: codecs: lpass-rx-macro: clean up for-loop indentation in switch statement
Date:   Fri,  9 Jul 2021 16:24:24 +0100
Message-Id: <20210709152424.460446-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The for-loop is not indented enough and needs one more level
of indentation. Add in the indentation across the block of code.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/lpass-rx-macro.c | 65 ++++++++++++++++---------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 3622961f7c2c..196b06898eeb 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -1722,42 +1722,43 @@ static int rx_macro_digital_mute(struct snd_soc_dai *dai, int mute, int stream)
 	case RX_MACRO_AIF2_PB:
 	case RX_MACRO_AIF3_PB:
 	case RX_MACRO_AIF4_PB:
-	for (j = 0; j < INTERP_MAX; j++) {
-		reg = CDC_RX_RXn_RX_PATH_CTL(j);
-		mix_reg = CDC_RX_RXn_RX_PATH_MIX_CTL(j);
-		dsm_reg = CDC_RX_RXn_RX_PATH_DSM_CTL(j);
-
-		if (mute) {
-			snd_soc_component_update_bits(component, reg,
-						      CDC_RX_PATH_PGA_MUTE_MASK,
-						      CDC_RX_PATH_PGA_MUTE_ENABLE);
-			snd_soc_component_update_bits(component, mix_reg,
-						      CDC_RX_PATH_PGA_MUTE_MASK,
-						      CDC_RX_PATH_PGA_MUTE_ENABLE);
-		} else {
-			snd_soc_component_update_bits(component, reg,
-						      CDC_RX_PATH_PGA_MUTE_MASK, 0x0);
-			snd_soc_component_update_bits(component, mix_reg,
-						      CDC_RX_PATH_PGA_MUTE_MASK, 0x0);
-		}
-
-		if (j == INTERP_AUX)
-			dsm_reg = CDC_RX_RX2_RX_PATH_DSM_CTL;
+		for (j = 0; j < INTERP_MAX; j++) {
+			reg = CDC_RX_RXn_RX_PATH_CTL(j);
+			mix_reg = CDC_RX_RXn_RX_PATH_MIX_CTL(j);
+			dsm_reg = CDC_RX_RXn_RX_PATH_DSM_CTL(j);
+
+			if (mute) {
+				snd_soc_component_update_bits(component, reg,
+							      CDC_RX_PATH_PGA_MUTE_MASK,
+							      CDC_RX_PATH_PGA_MUTE_ENABLE);
+				snd_soc_component_update_bits(component, mix_reg,
+							      CDC_RX_PATH_PGA_MUTE_MASK,
+							      CDC_RX_PATH_PGA_MUTE_ENABLE);
+			} else {
+				snd_soc_component_update_bits(component, reg,
+							      CDC_RX_PATH_PGA_MUTE_MASK, 0x0);
+				snd_soc_component_update_bits(component, mix_reg,
+							      CDC_RX_PATH_PGA_MUTE_MASK, 0x0);
+			}
 
-		int_mux_cfg0 = CDC_RX_INP_MUX_RX_INT0_CFG0 + j * 8;
-		int_mux_cfg1 = int_mux_cfg0 + 4;
-		int_mux_cfg0_val = snd_soc_component_read(component, int_mux_cfg0);
-		int_mux_cfg1_val = snd_soc_component_read(component, int_mux_cfg1);
+			if (j == INTERP_AUX)
+				dsm_reg = CDC_RX_RX2_RX_PATH_DSM_CTL;
 
-		if (snd_soc_component_read(component, dsm_reg) & 0x01) {
-			if (int_mux_cfg0_val || (int_mux_cfg1_val & 0xF0))
-				snd_soc_component_update_bits(component, reg, 0x20, 0x20);
-			if (int_mux_cfg1_val & 0x0F) {
-				snd_soc_component_update_bits(component, reg, 0x20, 0x20);
-				snd_soc_component_update_bits(component, mix_reg, 0x20, 0x20);
+			int_mux_cfg0 = CDC_RX_INP_MUX_RX_INT0_CFG0 + j * 8;
+			int_mux_cfg1 = int_mux_cfg0 + 4;
+			int_mux_cfg0_val = snd_soc_component_read(component, int_mux_cfg0);
+			int_mux_cfg1_val = snd_soc_component_read(component, int_mux_cfg1);
+
+			if (snd_soc_component_read(component, dsm_reg) & 0x01) {
+				if (int_mux_cfg0_val || (int_mux_cfg1_val & 0xF0))
+					snd_soc_component_update_bits(component, reg, 0x20, 0x20);
+				if (int_mux_cfg1_val & 0x0F) {
+					snd_soc_component_update_bits(component, reg, 0x20, 0x20);
+					snd_soc_component_update_bits(component, mix_reg, 0x20,
+								      0x20);
+				}
 			}
 		}
-	}
 		break;
 	default:
 		break;
-- 
2.31.1

