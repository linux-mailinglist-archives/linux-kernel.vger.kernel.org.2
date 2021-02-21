Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89057320B61
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 16:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhBUPbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 10:31:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:36852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhBUPbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 10:31:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62FA664EEF;
        Sun, 21 Feb 2021 15:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613921431;
        bh=O9xlPGiejTlK8aa43y0xsYCFghq5BZtPdRfRU4PePuY=;
        h=From:To:Subject:Date:From;
        b=Dn2ff16+PkGl2Jcm8JDnI4a16EOK+VRAilHMxwxScAZCTufG9SNFVwMlmQmRuCnZT
         fUjJcb5Eyye4dwMVSLLVoRzH29wyh6QcKgdWkND7+wpl1kF9ruLeLmPBzk5AwqbT63
         z8x2bcnw624KdCfPVq9VoAuF8pJFLUYmTz1Aw3FTA1jshi41EZlAXkZk8aC/JAU3pU
         6H5kriL6l4uL4I1D/Ge2Aq/naELHUmWKie5O0S/PdP4dA8cRomcsP5SQWtPDORsoRF
         sZ6za2fIl+/ehickYhTY1YghnlhWDxNCbccZczdTfYNb/+X9z21HvQTGBwo4FJ+Yrg
         Kya+3+dUaGIqQ==
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH] ASoC: constify of_phandle_args in snd_soc_get_dai_name()
Date:   Sun, 21 Feb 2021 16:30:24 +0100
Message-Id: <20210221153024.453583-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer to of_phandle_args passed to snd_soc_get_dai_name() and
of_xlate_dai_name() implementations is not modified.  Since it is being
used only to translate passed OF node to a DAI name, it should not be
modified, so mark it as const for correctness and safer code.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 include/sound/soc-component.h     | 4 ++--
 include/sound/soc.h               | 2 +-
 sound/soc/meson/aiu-acodec-ctrl.c | 2 +-
 sound/soc/meson/aiu-codec-ctrl.c  | 2 +-
 sound/soc/meson/aiu.c             | 4 ++--
 sound/soc/meson/aiu.h             | 2 +-
 sound/soc/qcom/lpass-cpu.c        | 2 +-
 sound/soc/qcom/qdsp6/q6afe-dai.c  | 2 +-
 sound/soc/soc-component.c         | 2 +-
 sound/soc/soc-core.c              | 2 +-
 10 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/sound/soc-component.h b/include/sound/soc-component.h
index 5b47768222b7..7dc75b39287f 100644
--- a/include/sound/soc-component.h
+++ b/include/sound/soc-component.h
@@ -101,7 +101,7 @@ struct snd_soc_component_driver {
 
 	/* DT */
 	int (*of_xlate_dai_name)(struct snd_soc_component *component,
-				 struct of_phandle_args *args,
+				 const struct of_phandle_args *args,
 				 const char **dai_name);
 	int (*of_xlate_dai_id)(struct snd_soc_component *comment,
 			       struct device_node *endpoint);
@@ -450,7 +450,7 @@ void snd_soc_component_remove(struct snd_soc_component *component);
 int snd_soc_component_of_xlate_dai_id(struct snd_soc_component *component,
 				      struct device_node *ep);
 int snd_soc_component_of_xlate_dai_name(struct snd_soc_component *component,
-					struct of_phandle_args *args,
+					const struct of_phandle_args *args,
 					const char **dai_name);
 int snd_soc_component_compr_open(struct snd_compr_stream *cstream);
 void snd_soc_component_compr_free(struct snd_compr_stream *cstream,
diff --git a/include/sound/soc.h b/include/sound/soc.h
index bd38015d6c6d..78609ab331c8 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1219,7 +1219,7 @@ unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
 				     struct device_node **bitclkmaster,
 				     struct device_node **framemaster);
 int snd_soc_get_dai_id(struct device_node *ep);
-int snd_soc_get_dai_name(struct of_phandle_args *args,
+int snd_soc_get_dai_name(const struct of_phandle_args *args,
 			 const char **dai_name);
 int snd_soc_of_get_dai_name(struct device_node *of_node,
 			    const char **dai_name);
diff --git a/sound/soc/meson/aiu-acodec-ctrl.c b/sound/soc/meson/aiu-acodec-ctrl.c
index 7078197e0cc5..27a6d3259c50 100644
--- a/sound/soc/meson/aiu-acodec-ctrl.c
+++ b/sound/soc/meson/aiu-acodec-ctrl.c
@@ -159,7 +159,7 @@ static const struct snd_kcontrol_new aiu_acodec_ctrl_controls[] = {
 };
 
 static int aiu_acodec_of_xlate_dai_name(struct snd_soc_component *component,
-					struct of_phandle_args *args,
+					const struct of_phandle_args *args,
 					const char **dai_name)
 {
 	return aiu_of_xlate_dai_name(component, args, dai_name, AIU_ACODEC);
diff --git a/sound/soc/meson/aiu-codec-ctrl.c b/sound/soc/meson/aiu-codec-ctrl.c
index 4b773d3e8b07..c3ea733fce91 100644
--- a/sound/soc/meson/aiu-codec-ctrl.c
+++ b/sound/soc/meson/aiu-codec-ctrl.c
@@ -125,7 +125,7 @@ static const struct snd_soc_dapm_route aiu_hdmi_ctrl_routes[] = {
 };
 
 static int aiu_hdmi_of_xlate_dai_name(struct snd_soc_component *component,
-				      struct of_phandle_args *args,
+				      const struct of_phandle_args *args,
 				      const char **dai_name)
 {
 	return aiu_of_xlate_dai_name(component, args, dai_name, AIU_HDMI);
diff --git a/sound/soc/meson/aiu.c b/sound/soc/meson/aiu.c
index dc35ca79021c..ba15d5762b0b 100644
--- a/sound/soc/meson/aiu.c
+++ b/sound/soc/meson/aiu.c
@@ -42,7 +42,7 @@ static const struct snd_soc_dapm_route aiu_cpu_dapm_routes[] = {
 };
 
 int aiu_of_xlate_dai_name(struct snd_soc_component *component,
-			  struct of_phandle_args *args,
+			  const struct of_phandle_args *args,
 			  const char **dai_name,
 			  unsigned int component_id)
 {
@@ -72,7 +72,7 @@ int aiu_of_xlate_dai_name(struct snd_soc_component *component,
 }
 
 static int aiu_cpu_of_xlate_dai_name(struct snd_soc_component *component,
-				     struct of_phandle_args *args,
+				     const struct of_phandle_args *args,
 				     const char **dai_name)
 {
 	return aiu_of_xlate_dai_name(component, args, dai_name, AIU_CPU);
diff --git a/sound/soc/meson/aiu.h b/sound/soc/meson/aiu.h
index 87aa19ac4af3..393b6c2307e4 100644
--- a/sound/soc/meson/aiu.h
+++ b/sound/soc/meson/aiu.h
@@ -45,7 +45,7 @@ struct aiu {
 		     SNDRV_PCM_FMTBIT_S24_LE)
 
 int aiu_of_xlate_dai_name(struct snd_soc_component *component,
-			  struct of_phandle_args *args,
+			  const struct of_phandle_args *args,
 			  const char **dai_name,
 			  unsigned int component_id);
 
diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index c642e5f8f28c..4762286b33fe 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -340,7 +340,7 @@ int asoc_qcom_lpass_cpu_dai_probe(struct snd_soc_dai *dai)
 EXPORT_SYMBOL_GPL(asoc_qcom_lpass_cpu_dai_probe);
 
 static int asoc_qcom_of_xlate_dai_name(struct snd_soc_component *component,
-				   struct of_phandle_args *args,
+				   const struct of_phandle_args *args,
 				   const char **dai_name)
 {
 	struct lpass_data *drvdata = snd_soc_component_get_drvdata(component);
diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 4e1f101281e7..e8915519f427 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -1315,7 +1315,7 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 };
 
 static int q6afe_of_xlate_dai_name(struct snd_soc_component *component,
-				   struct of_phandle_args *args,
+				   const struct of_phandle_args *args,
 				   const char **dai_name)
 {
 	int id = args->args[0];
diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index 159bf88b9f8c..8415e9bd2932 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -370,7 +370,7 @@ int snd_soc_component_of_xlate_dai_id(struct snd_soc_component *component,
 }
 
 int snd_soc_component_of_xlate_dai_name(struct snd_soc_component *component,
-					struct of_phandle_args *args,
+					const struct of_phandle_args *args,
 					const char **dai_name)
 {
 	if (component->driver->of_xlate_dai_name)
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f6d4e99b590c..50190654edda 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2994,7 +2994,7 @@ int snd_soc_get_dai_id(struct device_node *ep)
 }
 EXPORT_SYMBOL_GPL(snd_soc_get_dai_id);
 
-int snd_soc_get_dai_name(struct of_phandle_args *args,
+int snd_soc_get_dai_name(const struct of_phandle_args *args,
 				const char **dai_name)
 {
 	struct snd_soc_component *pos;
-- 
2.25.1

