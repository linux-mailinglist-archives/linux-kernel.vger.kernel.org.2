Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC7D3DCC73
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 17:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbhHAPfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 11:35:25 -0400
Received: from smtprelay0122.hostedemail.com ([216.40.44.122]:44908 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232081AbhHAPfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 11:35:24 -0400
Received: from omf12.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id A62B3837F24C;
        Sun,  1 Aug 2021 15:35:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id 4C2F9240235;
        Sun,  1 Aug 2021 15:35:14 +0000 (UTC)
Message-ID: <394bd56bf72ac2282207e02e48de6e6bd67a7bc6.camel@perches.com>
Subject: Re: [PATCH] ASoC: tlv320aic32x4: make array clocks static, makes
 object smaller
From:   Joe Perches <joe@perches.com>
To:     Colin King <colin.king@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 01 Aug 2021 08:35:12 -0700
In-Reply-To: <20210801064807.138641-1-colin.king@canonical.com>
References: <20210801064807.138641-1-colin.king@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.91
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 4C2F9240235
X-Stat-Signature: ksg94apy393dz6drz5igtdar8j46f7fg
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18MS7QZ5XINIs87PUEILFIGu7VAca/8HEM=
X-HE-Tag: 1627832114-829962
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-08-01 at 07:48 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the array clocks on the stack but instead it
> static. Makes the object code smaller by 316 bytes.
> 
> Before:
>    text    data     bss     dec     hex filename
>   63668   28264       0   91932   1671c ./sound/soc/codecs/tlv320aic32x4.o
> 
> After:
>    text    data     bss     dec     hex filename
>   62616   29000       0   91616   165e0 ./sound/soc/codecs/tlv320aic32x4.o
> 
> (gcc version 10.2.0)

That's likely also compiled allyesconfig.
allyesconfig compilations create a lot of superfluous data and text.

It's rather smaller with a defconfig and just the driver selected.

And here are a few additional possibilities for this driver.

$ size sound/soc/codecs/tlv320aic32x4.o*
   text	   data	    bss	    dec	    hex	filename
  38542	   2684	      0	  41226	   a10a	sound/soc/codecs/tlv320aic32x4.o.defconfig.new
  38446	   2792	      0	  41238	   a116	sound/soc/codecs/tlv320aic32x4.o.defconfig.old
  64184	  27880	      0	  92064	  167a0	sound/soc/codecs/tlv320aic32x4.o.allyesconfig.new
  63800	  28264	      0	  92064	  167a0	sound/soc/codecs/tlv320aic32x4.o.allyesconfig.old
---
diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 254a016cb1f36..aeac45cbe1955 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -243,29 +243,29 @@ static const struct snd_kcontrol_new aic32x4_mfp5[] = {
 };
 
 /* 0dB min, 0.5dB steps */
-static DECLARE_TLV_DB_SCALE(tlv_step_0_5, 0, 50, 0);
+static const DECLARE_TLV_DB_SCALE(tlv_step_0_5, 0, 50, 0);
 /* -63.5dB min, 0.5dB steps */
-static DECLARE_TLV_DB_SCALE(tlv_pcm, -6350, 50, 0);
+static const DECLARE_TLV_DB_SCALE(tlv_pcm, -6350, 50, 0);
 /* -6dB min, 1dB steps */
-static DECLARE_TLV_DB_SCALE(tlv_driver_gain, -600, 100, 0);
+static const DECLARE_TLV_DB_SCALE(tlv_driver_gain, -600, 100, 0);
 /* -12dB min, 0.5dB steps */
-static DECLARE_TLV_DB_SCALE(tlv_adc_vol, -1200, 50, 0);
+static const DECLARE_TLV_DB_SCALE(tlv_adc_vol, -1200, 50, 0);
 /* -6dB min, 1dB steps */
-static DECLARE_TLV_DB_SCALE(tlv_tas_driver_gain, -5850, 50, 0);
-static DECLARE_TLV_DB_SCALE(tlv_amp_vol, 0, 600, 1);
+static const DECLARE_TLV_DB_SCALE(tlv_tas_driver_gain, -5850, 50, 0);
+static const DECLARE_TLV_DB_SCALE(tlv_amp_vol, 0, 600, 1);
 
 static const char * const lo_cm_text[] = {
 	"Full Chip", "1.65V",
 };
 
-static SOC_ENUM_SINGLE_DECL(lo_cm_enum, AIC32X4_CMMODE, 3, lo_cm_text);
+static const SOC_ENUM_SINGLE_DECL(lo_cm_enum, AIC32X4_CMMODE, 3, lo_cm_text);
 
 static const char * const ptm_text[] = {
 	"P3", "P2", "P1",
 };
 
-static SOC_ENUM_SINGLE_DECL(l_ptm_enum, AIC32X4_LPLAYBACK, 2, ptm_text);
-static SOC_ENUM_SINGLE_DECL(r_ptm_enum, AIC32X4_RPLAYBACK, 2, ptm_text);
+static const SOC_ENUM_SINGLE_DECL(l_ptm_enum, AIC32X4_LPLAYBACK, 2, ptm_text);
+static const SOC_ENUM_SINGLE_DECL(r_ptm_enum, AIC32X4_RPLAYBACK, 2, ptm_text);
 
 static const struct snd_kcontrol_new aic32x4_snd_controls[] = {
 	SOC_DOUBLE_R_S_TLV("PCM Playback Volume", AIC32X4_LDACVOL,
@@ -341,14 +341,14 @@ static const char * const resistor_text[] = {
 };
 
 /* Left mixer pins */
-static SOC_ENUM_SINGLE_DECL(in1l_lpga_p_enum, AIC32X4_LMICPGAPIN, 6, resistor_text);
-static SOC_ENUM_SINGLE_DECL(in2l_lpga_p_enum, AIC32X4_LMICPGAPIN, 4, resistor_text);
-static SOC_ENUM_SINGLE_DECL(in3l_lpga_p_enum, AIC32X4_LMICPGAPIN, 2, resistor_text);
-static SOC_ENUM_SINGLE_DECL(in1r_lpga_p_enum, AIC32X4_LMICPGAPIN, 0, resistor_text);
+static const SOC_ENUM_SINGLE_DECL(in1l_lpga_p_enum, AIC32X4_LMICPGAPIN, 6, resistor_text);
+static const SOC_ENUM_SINGLE_DECL(in2l_lpga_p_enum, AIC32X4_LMICPGAPIN, 4, resistor_text);
+static const SOC_ENUM_SINGLE_DECL(in3l_lpga_p_enum, AIC32X4_LMICPGAPIN, 2, resistor_text);
+static const SOC_ENUM_SINGLE_DECL(in1r_lpga_p_enum, AIC32X4_LMICPGAPIN, 0, resistor_text);
 
-static SOC_ENUM_SINGLE_DECL(cml_lpga_n_enum, AIC32X4_LMICPGANIN, 6, resistor_text);
-static SOC_ENUM_SINGLE_DECL(in2r_lpga_n_enum, AIC32X4_LMICPGANIN, 4, resistor_text);
-static SOC_ENUM_SINGLE_DECL(in3r_lpga_n_enum, AIC32X4_LMICPGANIN, 2, resistor_text);
+static const SOC_ENUM_SINGLE_DECL(cml_lpga_n_enum, AIC32X4_LMICPGANIN, 6, resistor_text);
+static const SOC_ENUM_SINGLE_DECL(in2r_lpga_n_enum, AIC32X4_LMICPGANIN, 4, resistor_text);
+static const SOC_ENUM_SINGLE_DECL(in3r_lpga_n_enum, AIC32X4_LMICPGANIN, 2, resistor_text);
 
 static const struct snd_kcontrol_new in1l_to_lmixer_controls[] = {
 	SOC_DAPM_ENUM("IN1_L L+ Switch", in1l_lpga_p_enum),
@@ -373,13 +373,13 @@ static const struct snd_kcontrol_new in3r_to_lmixer_controls[] = {
 };
 
 /*	Right mixer pins */
-static SOC_ENUM_SINGLE_DECL(in1r_rpga_p_enum, AIC32X4_RMICPGAPIN, 6, resistor_text);
-static SOC_ENUM_SINGLE_DECL(in2r_rpga_p_enum, AIC32X4_RMICPGAPIN, 4, resistor_text);
-static SOC_ENUM_SINGLE_DECL(in3r_rpga_p_enum, AIC32X4_RMICPGAPIN, 2, resistor_text);
-static SOC_ENUM_SINGLE_DECL(in2l_rpga_p_enum, AIC32X4_RMICPGAPIN, 0, resistor_text);
-static SOC_ENUM_SINGLE_DECL(cmr_rpga_n_enum, AIC32X4_RMICPGANIN, 6, resistor_text);
-static SOC_ENUM_SINGLE_DECL(in1l_rpga_n_enum, AIC32X4_RMICPGANIN, 4, resistor_text);
-static SOC_ENUM_SINGLE_DECL(in3l_rpga_n_enum, AIC32X4_RMICPGANIN, 2, resistor_text);
+static const SOC_ENUM_SINGLE_DECL(in1r_rpga_p_enum, AIC32X4_RMICPGAPIN, 6, resistor_text);
+static const SOC_ENUM_SINGLE_DECL(in2r_rpga_p_enum, AIC32X4_RMICPGAPIN, 4, resistor_text);
+static const SOC_ENUM_SINGLE_DECL(in3r_rpga_p_enum, AIC32X4_RMICPGAPIN, 2, resistor_text);
+static const SOC_ENUM_SINGLE_DECL(in2l_rpga_p_enum, AIC32X4_RMICPGAPIN, 0, resistor_text);
+static const SOC_ENUM_SINGLE_DECL(cmr_rpga_n_enum, AIC32X4_RMICPGANIN, 6, resistor_text);
+static const SOC_ENUM_SINGLE_DECL(in1l_rpga_n_enum, AIC32X4_RMICPGANIN, 4, resistor_text);
+static const SOC_ENUM_SINGLE_DECL(in3l_rpga_n_enum, AIC32X4_RMICPGANIN, 2, resistor_text);
 
 static const struct snd_kcontrol_new in1r_to_rmixer_controls[] = {
 	SOC_DAPM_ENUM("IN1_R R+ Switch", in1r_rpga_p_enum),

