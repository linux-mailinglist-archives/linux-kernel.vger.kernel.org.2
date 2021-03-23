Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EAA345D38
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhCWLoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:44:21 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:53339 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbhCWLn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1616499835; x=1648035835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p0Lsho18kMBpcX9oZF0RqtRkyIQ/xH0OxlLo0/Y+yR0=;
  b=tE5VaY9fcGPj4/TwV8Wsao7k5wpgw8UXktrYLyMTx9jxnXUZl4ro0rpP
   l9GlCDeEOrnXBukEIm+f1aFSmxZVFRK1HMGtYx+J/c5RQNBoA71bFHWPk
   OeJcHCBgm5IK7lfVJFrwSn3gyIi4x0yfoTZuEhsPPL10tMJROqbtQLt60
   ZKRM7F/7aWqjkNmTDmMu1uh9O5bFqXjwwijebIg8crgmSURl+DE/8xvf6
   V6BcaZbSg1Igy3Dlqh1/flAbARLn4ghm/QkHQMx03xn70ZDnwHak6yUZ5
   P2byLcZcFyrbX7GlmkIoZOtdpYy+2jqJt+HponLsmo/F1k8R0RclE7jEC
   A==;
IronPort-SDR: KxRF0h99fh2Si9JhkhH+j+XEhVuCCInGNxke41ZqEE9GgtpT0pHYK3/YaZ6+S62Pv/Y9W8EN/Z
 qmjXXRlymSYzIUkwsQnbJXG3TbmLxCjrN2hfAhog9w17PGUZSjth791SJH2SBUAVYcdK4Ko1zW
 omSAFw30TAVuhbrwnxB94eoID1D9F0ijqJHpQPZob0AiF35dbBnDcjLarXG+NH9FxVAFkADtPY
 j7i1hHe9AG7SWnjbdbUxg9+89HrdMov67H28bZePT+n7J+StNZVc5q6BuKzD+B70HLDXd4LI6U
 AiA=
X-IronPort-AV: E=Sophos;i="5.81,271,1610434800"; 
   d="scan'208";a="108205968"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Mar 2021 04:43:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 23 Mar 2021 04:43:55 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 23 Mar 2021 04:43:51 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     <perex@perex.cz>, <tiwai@suse.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <mirq-linux@rere.qmqm.pl>,
        <gustavoars@kernel.org>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [RFC PATCH 2/3] ASoC: soc-pcm: add hw_constraints for BE DAI links
Date:   Tue, 23 Mar 2021 13:43:26 +0200
Message-ID: <20210323114327.3969072-3-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210323114327.3969072-1-codrin.ciubotariu@microchip.com>
References: <20210323114327.3969072-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new struct snd_pcm_hw_constraints under struct snd_soc_dpcm_runtime.
The BE DAIs can use the new structure to add constraints that will not
affect the FE of the PCM and will only apply to BE HW parameters.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 include/sound/pcm.h      |  9 ++++++++
 include/sound/soc-dpcm.h |  1 +
 sound/core/pcm_lib.c     | 12 +++++++++--
 sound/core/pcm_native.c  | 20 ++++++++++--------
 sound/soc/soc-pcm.c      | 44 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 76 insertions(+), 10 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index af7fce2b574d..198d37d04d78 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -977,6 +977,15 @@ int snd_interval_ratnum(struct snd_interval *i,
 void _snd_pcm_hw_params_any(struct snd_pcm_hw_params *params);
 void _snd_pcm_hw_param_setempty(struct snd_pcm_hw_params *params, snd_pcm_hw_param_t var);
 
+int snd_pcm_hw_rule_sample_bits(struct snd_pcm_hw_params *params,
+				struct snd_pcm_hw_rule *rule);
+int snd_pcm_hw_rule_format(struct snd_pcm_hw_params *params,
+			   struct snd_pcm_hw_rule *rule);
+int snd_pcm_hw_rule_mul(struct snd_pcm_hw_params *params,
+			struct snd_pcm_hw_rule *rule);
+int snd_pcm_hw_rule_div(struct snd_pcm_hw_params *params,
+			struct snd_pcm_hw_rule *rule);
+
 int snd_pcm_hw_refine(struct snd_pcm_substream *substream, struct snd_pcm_hw_params *params);
 
 int snd_pcm_hw_constraint_mask64(struct snd_pcm_runtime *runtime, snd_pcm_hw_param_t var,
diff --git a/include/sound/soc-dpcm.h b/include/sound/soc-dpcm.h
index e296a3949b18..c5825876824a 100644
--- a/include/sound/soc-dpcm.h
+++ b/include/sound/soc-dpcm.h
@@ -95,6 +95,7 @@ struct snd_soc_dpcm_runtime {
 	int users;
 	struct snd_pcm_runtime *runtime;
 	struct snd_pcm_hw_params hw_params;
+	struct snd_pcm_hw_constraints hw_constraints;
 
 	/* state and update */
 	enum snd_soc_dpcm_update runtime_update;
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 582144f99045..125fafdf7517 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -16,6 +16,7 @@
 #include <sound/info.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
+#include <sound/soc.h>
 #include <sound/timer.h>
 
 #include "pcm_local.h"
@@ -1121,12 +1122,19 @@ int snd_pcm_hw_rule_add(struct snd_pcm_substream *substream, unsigned int cond,
 			snd_pcm_hw_rule_func_t func, void *private,
 			int dep, ...)
 {
-	struct snd_pcm_hw_constraints *constrs =
-					&substream->runtime->hw_constraints;
+	struct snd_pcm_hw_constraints *constrs;
 	struct snd_pcm_hw_rule *c;
 	unsigned int k;
 	va_list args;
 
+	if (substream->pcm->internal) {
+		struct snd_soc_pcm_runtime *rtd = substream->private_data;
+		struct snd_soc_dpcm_runtime *dpcm = &rtd->dpcm[substream->stream];
+
+		constrs = &dpcm->hw_constraints;
+	} else {
+		constrs = &substream->runtime->hw_constraints;
+	}
 	va_start(args, dep);
 	if (constrs->rules_num >= constrs->rules_all) {
 		struct snd_pcm_hw_rule *new;
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 5feeef1b43f1..d6f14162bce5 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2278,23 +2278,25 @@ static int snd_pcm_unlink(struct snd_pcm_substream *substream)
 /*
  * hw configurator
  */
-static int snd_pcm_hw_rule_mul(struct snd_pcm_hw_params *params,
-			       struct snd_pcm_hw_rule *rule)
+int snd_pcm_hw_rule_mul(struct snd_pcm_hw_params *params,
+			struct snd_pcm_hw_rule *rule)
 {
 	struct snd_interval t;
 	snd_interval_mul(hw_param_interval_c(params, rule->deps[0]),
 		     hw_param_interval_c(params, rule->deps[1]), &t);
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
 }
+EXPORT_SYMBOL(snd_pcm_hw_rule_mul);
 
-static int snd_pcm_hw_rule_div(struct snd_pcm_hw_params *params,
-			       struct snd_pcm_hw_rule *rule)
+int snd_pcm_hw_rule_div(struct snd_pcm_hw_params *params,
+			struct snd_pcm_hw_rule *rule)
 {
 	struct snd_interval t;
 	snd_interval_div(hw_param_interval_c(params, rule->deps[0]),
 		     hw_param_interval_c(params, rule->deps[1]), &t);
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
 }
+EXPORT_SYMBOL(snd_pcm_hw_rule_div);
 
 static int snd_pcm_hw_rule_muldivk(struct snd_pcm_hw_params *params,
 				   struct snd_pcm_hw_rule *rule)
@@ -2316,8 +2318,8 @@ static int snd_pcm_hw_rule_mulkdiv(struct snd_pcm_hw_params *params,
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
 }
 
-static int snd_pcm_hw_rule_format(struct snd_pcm_hw_params *params,
-				  struct snd_pcm_hw_rule *rule)
+int snd_pcm_hw_rule_format(struct snd_pcm_hw_params *params,
+			   struct snd_pcm_hw_rule *rule)
 {
 	snd_pcm_format_t k;
 	const struct snd_interval *i =
@@ -2337,9 +2339,10 @@ static int snd_pcm_hw_rule_format(struct snd_pcm_hw_params *params,
 	}
 	return snd_mask_refine(mask, &m);
 }
+EXPORT_SYMBOL(snd_pcm_hw_rule_format);
 
-static int snd_pcm_hw_rule_sample_bits(struct snd_pcm_hw_params *params,
-				       struct snd_pcm_hw_rule *rule)
+int snd_pcm_hw_rule_sample_bits(struct snd_pcm_hw_params *params,
+				struct snd_pcm_hw_rule *rule)
 {
 	struct snd_interval t;
 	snd_pcm_format_t k;
@@ -2363,6 +2366,7 @@ static int snd_pcm_hw_rule_sample_bits(struct snd_pcm_hw_params *params,
 	t.integer = 1;
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
 }
+EXPORT_SYMBOL(snd_pcm_hw_rule_sample_bits);
 
 #if SNDRV_PCM_RATE_5512 != 1 << 0 || SNDRV_PCM_RATE_192000 != 1 << 12
 #error "Change this table"
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 65f8ea73bae7..dae246918e0d 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1471,6 +1471,43 @@ void dpcm_be_dai_stop(struct snd_soc_pcm_runtime *fe, int stream,
 	}
 }
 
+static int dpcm_hw_constraints_init(struct snd_pcm_substream *substream)
+{
+	int err;
+
+	if (!substream->pcm->internal)
+		return 0;
+
+	err = snd_pcm_hw_rule_add(substream, 0, SNDRV_PCM_HW_PARAM_FORMAT,
+				  snd_pcm_hw_rule_format, NULL,
+				  SNDRV_PCM_HW_PARAM_SAMPLE_BITS, -1);
+	if (err < 0)
+		return err;
+	err = snd_pcm_hw_rule_add(substream, 0, SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
+				  snd_pcm_hw_rule_sample_bits, NULL,
+				  SNDRV_PCM_HW_PARAM_FORMAT,
+				  SNDRV_PCM_HW_PARAM_SAMPLE_BITS, -1);
+	if (err < 0)
+		return err;
+	err = snd_pcm_hw_rule_add(substream, 0, SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
+				  snd_pcm_hw_rule_div, NULL,
+				  SNDRV_PCM_HW_PARAM_FRAME_BITS, SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+	if (err < 0)
+		return err;
+	err = snd_pcm_hw_rule_add(substream, 0, SNDRV_PCM_HW_PARAM_FRAME_BITS,
+				  snd_pcm_hw_rule_mul, NULL,
+				  SNDRV_PCM_HW_PARAM_SAMPLE_BITS, SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+	if (err < 0)
+		return err;
+	err = snd_pcm_hw_rule_add(substream, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				  snd_pcm_hw_rule_div, NULL,
+				  SNDRV_PCM_HW_PARAM_FRAME_BITS, SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
+				  -1);
+	if (err < 0)
+		return err;
+	return 0;
+}
+
 int dpcm_be_dai_startup(struct snd_soc_pcm_runtime *fe, int stream)
 {
 	struct snd_soc_pcm_runtime *be;
@@ -1513,6 +1550,13 @@ int dpcm_be_dai_startup(struct snd_soc_pcm_runtime *fe, int stream)
 			stream ? "capture" : "playback", be->dai_link->name);
 
 		be_substream->runtime = be->dpcm[stream].runtime;
+
+		/* initialize the BE constraints */
+		err = dpcm_hw_constraints_init(be_substream);
+		if (err < 0) {
+			dev_dbg(be->dev, "dpcm_hw_constraints_init failed\n");
+			goto unwind;
+		}
 		err = soc_pcm_open(be_substream);
 		if (err < 0) {
 			be->dpcm[stream].users--;
-- 
2.27.0

