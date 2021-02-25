Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D40F325546
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 19:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbhBYSMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 13:12:10 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19353 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbhBYSJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 13:09:16 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6037e73a0000>; Thu, 25 Feb 2021 10:06:50 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 25 Feb
 2021 18:06:49 +0000
Received: from audio.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 25 Feb 2021 18:06:47 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <robh@kernel.org>
CC:     <jonathanh@nvidia.com>, <kuninori.morimoto.gx@renesas.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [RFC PATCH 5/5] ASoC: simple-card-utils: Support pll configuration
Date:   Thu, 25 Feb 2021 23:36:04 +0530
Message-ID: <1614276364-13655-6-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614276364-13655-1-git-send-email-spujar@nvidia.com>
References: <1614276364-13655-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614276410; bh=XsuTkaQjpknAbqXsocoOXCmvAkmPnsCYijQXi5ZJhAI=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Type;
        b=eIPcptowc7wdxHaMJXOyE5rvKtk5H4cdQCuLTxJhHu0zx6JhuPMQoUkLRTQYQsa6i
         NtMgHS1CCcugb4mCEz2fmDEl87MmB2YhYZnWELHmjNJBGW2wdsvRLvnqX8l8fynXK4
         MCyYN7FG1MkXM3aUmaNrGNvSAn7HCFVkPCh/HnaLzEc6NlQiWfs7WYs7BOxHgEhJTm
         2UPZl+3IWd78mVlY40Yq3nvLPXlHe+ou6s4RO5oWmAmaRe8MgLonEVyjxxeX3epFqY
         H1Q/oYZH6s+v5l7v3oDnmLwV60meB5iSQMvG/yqfnvYZ+vUaMstOdMGjkPevNq4aNo
         nH9DHcqc7WI6g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some CPU/Codec DAI controllers may have an internal pll which can be
used to source its clocking requirements. The ASoC core provides a DAI
or component callback snd_soc_dai_set_pll() to configure this. But
currently simple-card or audio-graph card drivers are not using this.

To configure pll on DAI controller side, following optional DT properties
can be used. These can be specified in CPU/Codec DAI or endpoint subnode.

 - pll-id               : DAI specific pll id.

 - pll-source           : DAI specific pll source. CPU/Codec DAI can
                          specify the source that is used for pll
                          reference.

 - pll-input-reference  : Depending on the given value, input frequency
                          can be calculated at runtime. For example if
                          I2S bit clock is used as reference, rate depends
                          on the actual PCM parameters (rate, channels and
                          bits) during an audio session. If a fixed rate is
                          used, then "pll-input-frequency" can be used
                          instead.

 - pll-output-reference : Depending on the given value, output frequency
                          can be calculated at runtime. If output clock is
                          used for MCLK purpose, then it may depend on
                          "mclk-fs" scale factor. In such cases it needs to
                          be calculated at runtime. If a fixed output
                          frequency is needed, then "pll-output-frequency"
                          can be used instead.

 - pll-input-frequency  : Specify fixed input frequency in Hz. This is
                          checked only when "pll-input-reference" is not
                          specified.

 - pll-output-frequency : Specify fixed output frequency in Hz. This is
                          checked only when "pll-output-reference" is not
                          specified.

Usage examples with RT5658 Codec:

  1. Use MCLK for Codec sysclk

     codec-subnode {
         mclk-fs = <256>;
         system-clock-source = <RT5659_SCLK_S_MCLK>;
     };

     In above case, the sysclk source is set to MCLK and the sysclk rate
     is set to 256 * fs, where fs is sampling rate of the stream.

  2. Use Codec internal pll to derive Codec sysclk. The pll can use
     SoC I2S bit clock (BCLK) as reference.

     codec-subnode {
         mclk-fs = <256>;

         system-clock-source = <RT5659_SCLK_S_PLL1>;

         pll-source = <RT5659_PLL1_S_BCLK1>;

         /*
          * SoC I2S BCLK as reference. Based on this pll input rate
          * (sample rate * channels * bits) is calculated at runtime.
          */
         pll-input-reference = <2>;

         /*
          * pll will generate output rate based on MCLK, which is
          * calculated at runtime as (mclk_fs * sample rate).
          */
         pll-output-reference = <1>; /* MCLK as output rate */
     };

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 include/sound/simple_card_utils.h     |  33 ++++++++++
 sound/soc/generic/simple-card-utils.c | 114 ++++++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index e026bf2..0f937eb 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -16,11 +16,44 @@
 #define asoc_simple_init_mic(card, sjack, prefix) \
 	asoc_simple_init_jack(card, sjack, 0, prefix, NULL)
 
+/*
+ * External audio Codecs for their system clock (sysclk) may use one
+ * of the following:
+ *
+ *   - MCLK provided by SoC (already "system-clock-frequency" or
+ *     "mclk-fs" bindings exist)
+ *
+ *   - Codec internal PLL which can take reference from SoC audio
+ *     interface bit clock (BCLK) and generate required sysclk for
+ *     the Codec.
+ *
+ *   - Codec internal PLL taking reference from onboard crystal and
+ *     generate required sysclk for the Codec.
+ *
+ * BCLK depends on PCM parameters (rate, channels and bits) and has
+ * to be calculated at runtime. So is MCLK, sometimes it depends on
+ * sample rate and a scaling factor. So whenever PLL is used for
+ * sysclk, input and output references/rates need to be provided.
+ *
+ * Following macros can be used to setup input/output frequency
+ * requirements for the PLL.
+ */
+
+#define SND_SOC_DAI_PLL_REF_FIXED		0
+#define SND_SOC_DAI_PLL_REF_MCLK		(1 << 0)
+#define SND_SOC_DAI_PLL_REF_BCLK		(1 << 1)
+
 struct asoc_simple_dai {
 	const char *name;
 	unsigned int sysclk;
 	int sysclk_id;
 	int sysclk_source;
+	unsigned int pll_id;
+	unsigned int pll_source;
+	unsigned int pll_in_freq;
+	unsigned int pll_out_freq;
+	unsigned int pll_in_ref;
+	unsigned int pll_out_ref;
 	int clk_direction;
 	int slots;
 	int slot_width;
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index bbbf891..6bfde08 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -12,6 +12,7 @@
 #include <linux/of_gpio.h>
 #include <linux/of_graph.h>
 #include <sound/jack.h>
+#include <sound/pcm_params.h>
 #include <sound/simple_card_utils.h>
 
 void asoc_simple_convert_fixup(struct asoc_simple_data *data,
@@ -190,6 +191,30 @@ int asoc_simple_parse_clk(struct device *dev,
 
 	of_property_read_u32(node, "system-clock-source", &simple_dai->sysclk_source);
 
+	of_property_read_u32(node, "pll-id", &simple_dai->pll_id);
+
+	of_property_read_u32(node, "pll-source", &simple_dai->pll_source);
+
+	if (of_property_read_u32(node, "pll-input-reference",
+				 &simple_dai->pll_in_ref)) {
+		/*
+		 * Look for "pll-input-frequency" if no explicit reference
+		 * is provided.
+		 */
+		of_property_read_u32(node, "pll-input-frequency",
+				     &simple_dai->pll_in_freq);
+	}
+
+	if (of_property_read_u32(node, "pll-output-reference",
+				 &simple_dai->pll_out_ref)) {
+		/*
+		 * Look for "pll-output-frequency" if no explicit reference
+		 * is provided.
+		 */
+		of_property_read_u32(node, "pll-output-frequency",
+				     &simple_dai->pll_out_freq);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(asoc_simple_parse_clk);
@@ -217,6 +242,82 @@ static int asoc_simple_set_sysclk(struct snd_soc_dai *dai,
 	return 0;
 }
 
+static int asoc_simple_enable_pll(struct snd_soc_dai *dai,
+				  struct asoc_simple_dai *simple_dai,
+				  struct snd_pcm_hw_params *params,
+				  unsigned int mclk_fs)
+{
+	int ret;
+
+	if (!simple_dai)
+		return 0;
+
+	switch (simple_dai->pll_in_ref) {
+	case SND_SOC_DAI_PLL_REF_FIXED:
+		break;
+	case SND_SOC_DAI_PLL_REF_MCLK:
+		simple_dai->pll_in_freq = params_rate(params) * mclk_fs;
+		break;
+	case SND_SOC_DAI_PLL_REF_BCLK:
+		simple_dai->pll_in_freq = params_rate(params) *
+					  params_channels(params) *
+					  params_width(params);
+		break;
+	default:
+		dev_err(dai->dev, "pll input reference is invalid!\n");
+		return -EINVAL;
+	}
+
+	switch (simple_dai->pll_out_ref) {
+	case SND_SOC_DAI_PLL_REF_FIXED:
+		break;
+	case SND_SOC_DAI_PLL_REF_MCLK:
+		simple_dai->pll_out_freq = params_rate(params) * mclk_fs;
+		break;
+	case SND_SOC_DAI_PLL_REF_BCLK:
+		simple_dai->pll_out_freq = params_rate(params) *
+					   params_channels(params) *
+					   params_width(params);
+		break;
+	default:
+		dev_err(dai->dev, "pll output reference is invalid!\n");
+		return -EINVAL;
+	}
+
+	if (!simple_dai->pll_in_freq && !simple_dai->pll_out_freq) {
+		/* There is nothing to be configured */
+		return 0;
+	} else if ((!simple_dai->pll_in_freq && simple_dai->pll_out_freq) ||
+		   (simple_dai->pll_in_freq && !simple_dai->pll_out_freq)) {
+		dev_err(dai->dev, "Invalid pll input/output rates!\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(dai->dev,
+		"pll config: id = %d, source = %d, in_freq = %u, out_freq = %u\n",
+		simple_dai->pll_id, simple_dai->pll_source,
+		simple_dai->pll_in_freq, simple_dai->pll_out_freq);
+
+	ret = snd_soc_dai_set_pll(dai, simple_dai->pll_id,
+				  simple_dai->pll_source,
+				  simple_dai->pll_in_freq,
+				  simple_dai->pll_out_freq);
+
+	if (ret && ret != -ENOTSUPP)
+		return ret;
+
+	return 0;
+}
+
+static int asoc_simple_disable_pll(struct snd_soc_dai *dai,
+				   struct asoc_simple_dai *simple_dai)
+{
+	if (!simple_dai)
+		return 0;
+
+	return snd_soc_dai_set_pll(dai, simple_dai->pll_id, 0, 0, 0);
+}
+
 int asoc_simple_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
@@ -252,6 +353,9 @@ void asoc_simple_shutdown(struct snd_pcm_substream *substream)
 				       SND_SOC_CLOCK_OUT);
 	}
 
+	asoc_simple_disable_pll(codec_dai, dai_props->codec_dai);
+	asoc_simple_disable_pll(cpu_dai, dai_props->cpu_dai);
+
 	asoc_simple_clk_disable(dai_props->cpu_dai);
 
 	asoc_simple_clk_disable(dai_props->codec_dai);
@@ -310,6 +414,16 @@ int asoc_simple_hw_params(struct snd_pcm_substream *substream,
 			return ret;
 	}
 
+	ret = asoc_simple_enable_pll(codec_dai, dai_props->codec_dai, params,
+				     mclk_fs);
+	if (ret < 0)
+		return ret;
+
+	ret = asoc_simple_enable_pll(cpu_dai, dai_props->cpu_dai, params,
+				     mclk_fs);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(asoc_simple_hw_params);
-- 
2.7.4

