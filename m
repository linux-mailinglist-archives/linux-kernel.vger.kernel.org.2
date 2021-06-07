Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594D039E078
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 17:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhFGPcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 11:32:22 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:42768 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhFGPcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 11:32:18 -0400
Received: by mail-wr1-f43.google.com with SMTP id c5so18074290wrq.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 08:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ghMquO+JsY6coLYnrXZXNOKPAifXt8QsxJuCYWY+dW8=;
        b=C2tiavq7TQRvhQGBBxu0cVWIfCikpXiMdmkl9qu9HLUMaQ2rKxzRJIvU3RM3LZ4Kif
         rWrnbgpdtYHf3nM4ysvIdb5B4kvbtrDfmmtOpi534c9ZpA5psCY3QB5sNz0dMdBhB42F
         Qq/o6UevLzdzhfD58gOus2aLJneFZDHxDUgzv9xPSMjjyCaacBQjDDcG+x6SDjFK2wXt
         NIScOjYUTBNjozUXohhyTvuKIKM3+bNJs8ZmcUS+Nfh2+q+NuoP9qIUSap5n0n6W1LOC
         MQIKXU7KuAgFaFxjgC6gSJTdQYAMlhpwnUqIomfpwAwktTh4tWb+YvM05nyt3Zid4SCj
         sXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ghMquO+JsY6coLYnrXZXNOKPAifXt8QsxJuCYWY+dW8=;
        b=k24D6ppe2XMK9qdZVPrXK2LNV968ckbyBdOalkOL4aERgOv9VB52ma9U9XWhC6hN+w
         0HTdYK2DQpfeQnPJknb4ffhbOAELePkpEo89o3jFQ5dGI09111LsSJ4wt/UXJADg4+IF
         7FUkO8XCoEXYHg0VryKwVy1j5Av6bANMcTTr4EAoyOfDkIcgu4v4Ty0r77Lhz5vcCG8j
         qkh6gShbtWkoLsCrB+2QYtg7OijXUU85Lfn7e/x0RK07EQ6K9xu4fCK605Keg2wo3KGZ
         hI1M2LUXbPEMpyDS+j0WgpsjDNRkwvYFJ3C9vVthk8aEoEUmGwUdv9qICsQJgCb0lZ9I
         HqQg==
X-Gm-Message-State: AOAM530x+9Ls/md/FWhF8PNtZ54Lk5XUE54Yf6yJGcS5v+DWgfsZ5XQ/
        HMUiOR9r5ahwdqgUeAr5Njsoiw==
X-Google-Smtp-Source: ABdhPJzcdB2u3KnuxCfK0X0wXX+0tKUSccEszb0Rs8c6dyrkTQDHU/FwvEu4s72olWaaezqIM5pzhQ==
X-Received: by 2002:adf:a550:: with SMTP id j16mr18026140wrb.25.1623079752373;
        Mon, 07 Jun 2021 08:29:12 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id q3sm16370170wrr.43.2021.06.07.08.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 08:29:11 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     bjorn.andersson@linaro.org, broonie@kernel.org
Cc:     plai@codeaurora.org, tiwai@suse.de, robh@kernel.org,
        devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, bgoswami@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 09/13] ASoC: qcom: audioreach: add bedai support
Date:   Mon,  7 Jun 2021 16:28:32 +0100
Message-Id: <20210607152836.17154-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210607152836.17154-1-srinivas.kandagatla@linaro.org>
References: <20210607152836.17154-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/Kconfig                  |   4 +
 sound/soc/qcom/audioreach/Makefile      |   2 +
 sound/soc/qcom/audioreach/q6apm-bedai.c | 377 ++++++++++++++++++++++++
 3 files changed, 383 insertions(+)
 create mode 100644 sound/soc/qcom/audioreach/q6apm-bedai.c

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 258fe9ef26f3..4eb1b1a7c1f7 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -106,11 +106,15 @@ config SND_SOC_QDSP6
 config SND_SOC_QCOM_APM_DAI
 	tristate
 
+config SND_SOC_QCOM_APM_BEDAI
+	tristate
+
 config SND_SOC_QCOM_AUDIOREACH
 	tristate "SoC ALSA audio drives for Qualcomm AUDIOREACH"
 	depends on QCOM_GPR
 	select SND_SOC_TOPOLOGY
 	select SND_SOC_QCOM_APM_DAI
+	select SND_SOC_QCOM_APM_BEDAI
 	help
 	 Support for AudioReach in QDSP
 
diff --git a/sound/soc/qcom/audioreach/Makefile b/sound/soc/qcom/audioreach/Makefile
index 7160bddbb1fb..e8651455b206 100644
--- a/sound/soc/qcom/audioreach/Makefile
+++ b/sound/soc/qcom/audioreach/Makefile
@@ -1,8 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 snd-ar-objs := audioreach.o q6apm.o topology.o
 snd-apm-dai-objs := q6apm-dai.o
+snd-apm-bedai-objs := q6apm-bedai.o
 
 obj-$(CONFIG_SND_SOC_QCOM_AUDIOREACH) += snd-ar.o
 obj-$(CONFIG_SND_SOC_QCOM_APM_DAI) += snd-apm-dai.o
+obj-$(CONFIG_SND_SOC_QCOM_APM_BEDAI) += snd-apm-bedai.o
 
 
diff --git a/sound/soc/qcom/audioreach/q6apm-bedai.c b/sound/soc/qcom/audioreach/q6apm-bedai.c
new file mode 100644
index 000000000000..3b0ccf4f119c
--- /dev/null
+++ b/sound/soc/qcom/audioreach/q6apm-bedai.c
@@ -0,0 +1,377 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2021, Linaro Limited
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+#include "audioreach.h"
+#include "q6apm.h"
+
+#define Q6APM_CDC_DMA_RX_DAI(did) {				\
+		.playback = {						\
+			.stream_name = #did" Playback",	\
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
+				SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_48000 |\
+				SNDRV_PCM_RATE_176400,			\
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |		\
+				   SNDRV_PCM_FMTBIT_S24_LE |		\
+				   SNDRV_PCM_FMTBIT_S32_LE,		\
+			.channels_min = 1,				\
+			.channels_max = 8,				\
+			.rate_min = 8000,				\
+			.rate_max = 176400,				\
+		},							\
+		.name = #did,						\
+		.ops = &q6dma_ops,					\
+		.id = did,						\
+	}
+
+#define Q6APM_CDC_DMA_TX_DAI(did) {				\
+		.capture = {						\
+			.stream_name = #did" Capture",		\
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
+				SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_48000 |\
+				SNDRV_PCM_RATE_176400,			\
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |		\
+				   SNDRV_PCM_FMTBIT_S24_LE |		\
+				   SNDRV_PCM_FMTBIT_S32_LE,		\
+			.channels_min = 1,				\
+			.channels_max = 8,				\
+			.rate_min = 8000,				\
+			.rate_max = 176400,				\
+		},							\
+		.name = #did,						\
+		.ops = &q6dma_ops,					\
+		.id = did,						\
+	}
+
+#define AUDIOREACH_BE_PCM_BASE	16
+
+struct q6apm_bedai_data {
+	struct q6apm_graph *graph[APM_PORT_MAX];
+	uint16_t bits_per_sample[APM_PORT_MAX];
+	bool is_port_started[APM_PORT_MAX];
+	struct q6apm_port_config port_config[APM_PORT_MAX];
+};
+
+static int q6dma_set_channel_map(struct snd_soc_dai *dai,
+				 unsigned int tx_num, unsigned int *tx_ch_mask,
+				 unsigned int rx_num, unsigned int *rx_ch_mask)
+{
+
+	struct q6apm_bedai_data *dai_data = dev_get_drvdata(dai->dev);
+	struct q6apm_cdc_dma_cfg *cfg = &dai_data->port_config[dai->id].dma_cfg;
+	int ch_mask;
+	int rc = 0;
+
+	switch (dai->id) {
+	case WSA_CODEC_DMA_TX_0:
+	case WSA_CODEC_DMA_TX_1:
+	case WSA_CODEC_DMA_TX_2:
+	case VA_CODEC_DMA_TX_0:
+	case VA_CODEC_DMA_TX_1:
+	case VA_CODEC_DMA_TX_2:
+	case TX_CODEC_DMA_TX_0:
+	case TX_CODEC_DMA_TX_1:
+	case TX_CODEC_DMA_TX_2:
+	case TX_CODEC_DMA_TX_3:
+	case TX_CODEC_DMA_TX_4:
+	case TX_CODEC_DMA_TX_5:
+		if (!tx_ch_mask) {
+			dev_err(dai->dev, "tx slot not found\n");
+			return -EINVAL;
+		}
+
+		if (tx_num > PCM_MAX_NUM_CHANNEL) {
+			dev_err(dai->dev, "invalid tx num %d\n",
+				tx_num);
+			return -EINVAL;
+		}
+		ch_mask = *tx_ch_mask;
+
+		break;
+	case WSA_CODEC_DMA_RX_0:
+	case WSA_CODEC_DMA_RX_1:
+	case RX_CODEC_DMA_RX_0:
+	case RX_CODEC_DMA_RX_1:
+	case RX_CODEC_DMA_RX_2:
+	case RX_CODEC_DMA_RX_3:
+	case RX_CODEC_DMA_RX_4:
+	case RX_CODEC_DMA_RX_5:
+	case RX_CODEC_DMA_RX_6:
+	case RX_CODEC_DMA_RX_7:
+		/* rx */
+		if (!rx_ch_mask) {
+			dev_err(dai->dev, "rx slot not found\n");
+			return -EINVAL;
+		}
+		if (rx_num > APM_PORT_MAX_AUDIO_CHAN_CNT) {
+			dev_err(dai->dev, "invalid rx num %d\n",
+				rx_num);
+			return -EINVAL;
+		}
+		ch_mask = *rx_ch_mask;
+
+		break;
+	default:
+		dev_err(dai->dev, "%s: invalid dai id 0x%x\n",
+			__func__, dai->id);
+		return -EINVAL;
+	}
+
+	cfg->active_channels_mask = ch_mask;
+
+	return rc;
+}
+
+static int q6dma_hw_params(struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params,
+			   struct snd_soc_dai *dai)
+{
+	struct q6apm_bedai_data *dai_data = dev_get_drvdata(dai->dev);
+	struct q6apm_cdc_dma_cfg *cfg = &dai_data->port_config[dai->id].dma_cfg;
+
+	cfg->bit_width = params_width(params);
+	cfg->sample_rate = params_rate(params);
+	cfg->num_channels = params_channels(params);
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		dai_data->bits_per_sample[dai->id] = 16;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		dai_data->bits_per_sample[dai->id] = 24;
+		break;
+	}
+
+	return 0;
+}
+
+static void q6apm_bedai_shutdown(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct q6apm_bedai_data *dai_data = dev_get_drvdata(dai->dev);
+	int rc;
+
+	if (!dai_data->is_port_started[dai->id])
+		return;
+	rc = q6apm_graph_stop(dai_data->graph[dai->id]);
+	if (rc < 0)
+		dev_err(dai->dev, "fail to close APM port (%d)\n", rc);
+
+	q6apm_graph_close(dai_data->graph[dai->id]);
+	dai_data->is_port_started[dai->id] = false;
+
+}
+
+static int q6apm_bedai_prepare(struct snd_pcm_substream *substream,
+			       struct snd_soc_dai *dai)
+{
+	struct q6apm_bedai_data *dai_data = dev_get_drvdata(dai->dev);
+	struct q6apm_cdc_dma_cfg *cfg = &dai_data->port_config[dai->id].dma_cfg;
+	int graph_id = dai->id;
+	int rc;
+	int ret;
+	struct q6apm_graph *graph;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		graph = q6apm_graph_open(dai->dev, NULL, dai->dev, graph_id);
+		if (IS_ERR(graph)) {
+			dev_err(dai->dev, "Failed to open graph (%d)\n",
+				graph_id);
+			ret = PTR_ERR(graph);
+			return ret;
+		}
+		dai_data->graph[graph_id] = graph;
+	}
+
+	rc = q6apm_graph_media_format_pcm(dai_data->graph[dai->id],
+					  substream->stream, cfg->sample_rate,
+					  cfg->num_channels, NULL, cfg->bit_width);
+
+	rc = q6apm_graph_prepare(dai_data->graph[dai->id]);
+	rc = q6apm_graph_start(dai_data->graph[dai->id]);
+	if (rc < 0) {
+		dev_err(dai->dev, "fail to start APM port %x\n", dai->id);
+		return rc;
+	}
+	dai_data->is_port_started[dai->id] = true;
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_route q6apm_dapm_routes[] = {
+	{"WSA_CODEC_DMA_RX_0 Playback", NULL, "WSA_CODEC_DMA_RX_0"},
+	{"WSA_CODEC_DMA_TX_0", NULL, "WSA_CODEC_DMA_TX_0 Capture"},
+	{"WSA_CODEC_DMA_RX_1 Playback", NULL, "WSA_CODEC_DMA_RX_1"},
+	{"WSA_CODEC_DMA_TX_1", NULL, "WSA_CODEC_DMA_TX_1 Capture"},
+	{"WSA_CODEC_DMA_TX_2", NULL, "WSA_CODEC_DMA_TX_2 Capture"},
+	{"VA_CODEC_DMA_TX_0", NULL, "VA_CODEC_DMA_TX_0 Capture"},
+	{"VA_CODEC_DMA_TX_1", NULL, "VA_CODEC_DMA_TX_1 Capture"},
+	{"VA_CODEC_DMA_TX_2", NULL, "VA_CODEC_DMA_TX_2 Capture"},
+	{"RX_CODEC_DMA_RX_0 Playback", NULL, "RX_CODEC_DMA_RX_0"},
+	{"TX_CODEC_DMA_TX_0", NULL, "TX_CODEC_DMA_TX_0 Capture"},
+	{"RX_CODEC_DMA_RX_1 Playback", NULL, "RX_CODEC_DMA_RX_1"},
+	{"TX_CODEC_DMA_TX_1", NULL, "TX_CODEC_DMA_TX_1 Capture"},
+	{"RX_CODEC_DMA_RX_2 Playback", NULL, "RX_CODEC_DMA_RX_2"},
+	{"TX_CODEC_DMA_TX_2", NULL, "TX_CODEC_DMA_TX_2 Capture"},
+	{"RX_CODEC_DMA_RX_3 Playback", NULL, "RX_CODEC_DMA_RX_3"},
+	{"TX_CODEC_DMA_TX_3", NULL, "TX_CODEC_DMA_TX_3 Capture"},
+	{"RX_CODEC_DMA_RX_4 Playback", NULL, "RX_CODEC_DMA_RX_4"},
+	{"TX_CODEC_DMA_TX_4", NULL, "TX_CODEC_DMA_TX_4 Capture"},
+	{"RX_CODEC_DMA_RX_5 Playback", NULL, "RX_CODEC_DMA_RX_5"},
+	{"TX_CODEC_DMA_TX_5", NULL, "TX_CODEC_DMA_TX_5 Capture"},
+	{"RX_CODEC_DMA_RX_6 Playback", NULL, "RX_CODEC_DMA_RX_6"},
+	{"RX_CODEC_DMA_RX_7 Playback", NULL, "RX_CODEC_DMA_RX_7"},
+};
+
+static int q6apm_bedai_startup(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct q6apm_bedai_data *dai_data = dev_get_drvdata(dai->dev);
+	int graph_id = dai->id, ret;
+	struct q6apm_graph *graph;
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		graph = q6apm_graph_open(dai->dev, NULL, dai->dev, graph_id);
+		if (IS_ERR(graph)) {
+			dev_err(dai->dev, "Failed to open graph (%d)\n",
+				graph_id);
+			ret = PTR_ERR(graph);
+			return ret;
+		}
+		dai_data->graph[graph_id] = graph;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops q6dma_ops = {
+	.prepare	= q6apm_bedai_prepare,
+	.startup	= q6apm_bedai_startup,
+	.shutdown	= q6apm_bedai_shutdown,
+	.set_channel_map  = q6dma_set_channel_map,
+	.hw_params        = q6dma_hw_params,
+};
+
+static struct snd_soc_dai_driver q6apm_be_dais[] = {
+	Q6APM_CDC_DMA_RX_DAI(WSA_CODEC_DMA_RX_0),
+	Q6APM_CDC_DMA_TX_DAI(WSA_CODEC_DMA_TX_0),
+	Q6APM_CDC_DMA_RX_DAI(WSA_CODEC_DMA_RX_1),
+	Q6APM_CDC_DMA_TX_DAI(WSA_CODEC_DMA_TX_1),
+	Q6APM_CDC_DMA_TX_DAI(WSA_CODEC_DMA_TX_2),
+	Q6APM_CDC_DMA_TX_DAI(VA_CODEC_DMA_TX_0),
+	Q6APM_CDC_DMA_TX_DAI(VA_CODEC_DMA_TX_1),
+	Q6APM_CDC_DMA_TX_DAI(VA_CODEC_DMA_TX_2),
+	Q6APM_CDC_DMA_RX_DAI(RX_CODEC_DMA_RX_0),
+	Q6APM_CDC_DMA_TX_DAI(TX_CODEC_DMA_TX_0),
+	Q6APM_CDC_DMA_RX_DAI(RX_CODEC_DMA_RX_1),
+	Q6APM_CDC_DMA_TX_DAI(TX_CODEC_DMA_TX_1),
+	Q6APM_CDC_DMA_RX_DAI(RX_CODEC_DMA_RX_2),
+	Q6APM_CDC_DMA_TX_DAI(TX_CODEC_DMA_TX_2),
+	Q6APM_CDC_DMA_RX_DAI(RX_CODEC_DMA_RX_3),
+	Q6APM_CDC_DMA_TX_DAI(TX_CODEC_DMA_TX_3),
+	Q6APM_CDC_DMA_RX_DAI(RX_CODEC_DMA_RX_4),
+	Q6APM_CDC_DMA_TX_DAI(TX_CODEC_DMA_TX_4),
+	Q6APM_CDC_DMA_RX_DAI(RX_CODEC_DMA_RX_5),
+	Q6APM_CDC_DMA_TX_DAI(TX_CODEC_DMA_TX_5),
+	Q6APM_CDC_DMA_RX_DAI(RX_CODEC_DMA_RX_6),
+	Q6APM_CDC_DMA_RX_DAI(RX_CODEC_DMA_RX_7),
+};
+
+static int q6apm_of_xlate_dai_name(struct snd_soc_component *component,
+				   const struct of_phandle_args *args,
+				   const char **dai_name)
+{
+	int id = args->args[0];
+	int ret = -EINVAL;
+	int i;
+
+	for (i = 0; i  < ARRAY_SIZE(q6apm_be_dais); i++) {
+		if (q6apm_be_dais[i].id == id) {
+			*dai_name = q6apm_be_dais[i].name;
+			ret = 0;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static const struct snd_soc_dapm_widget q6apm_bedai_widgets[] = {
+	SND_SOC_DAPM_AIF_IN("WSA_CODEC_DMA_RX_0", "NULL", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("WSA_CODEC_DMA_TX_0", "NULL", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("WSA_CODEC_DMA_RX_1", "NULL", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("WSA_CODEC_DMA_TX_1", "NULL", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("WSA_CODEC_DMA_TX_2", "NULL", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("VA_CODEC_DMA_TX_0", "NULL", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("VA_CODEC_DMA_TX_1", "NULL", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("VA_CODEC_DMA_TX_2", "NULL", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("RX_CODEC_DMA_RX_0", "NULL", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("TX_CODEC_DMA_TX_0", "NULL", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("RX_CODEC_DMA_RX_1", "NULL", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("TX_CODEC_DMA_TX_1", "NULL", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("RX_CODEC_DMA_RX_2", "NULL", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("TX_CODEC_DMA_TX_2", "NULL", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("RX_CODEC_DMA_RX_3", "NULL", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("TX_CODEC_DMA_TX_3", "NULL", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("RX_CODEC_DMA_RX_4", "NULL", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("TX_CODEC_DMA_TX_4", "NULL", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("RX_CODEC_DMA_RX_5", "NULL", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("TX_CODEC_DMA_TX_5", "NULL", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("RX_CODEC_DMA_RX_6", "NULL", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("RX_CODEC_DMA_RX_7", "NULL", 0, SND_SOC_NOPM, 0, 0),
+};
+
+static const struct snd_soc_component_driver q6apm_bedai_component = {
+	.name		= "q6apm-be-dai-component",
+	.dapm_widgets = q6apm_bedai_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(q6apm_bedai_widgets),
+	.dapm_routes = q6apm_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(q6apm_dapm_routes),
+	.of_xlate_dai_name = q6apm_of_xlate_dai_name,
+	.be_pcm_base = AUDIOREACH_BE_PCM_BASE,
+	.use_dai_pcm_id = true,
+};
+
+static int q6apm_bedai_dev_probe(struct platform_device *pdev)
+{
+	struct q6apm_bedai_data *dai_data;
+	struct device *dev = &pdev->dev;
+
+	dai_data = devm_kzalloc(dev, sizeof(*dai_data), GFP_KERNEL);
+	if (!dai_data)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, dai_data);
+
+	return devm_snd_soc_register_component(dev, &q6apm_bedai_component,
+					       q6apm_be_dais,
+					       ARRAY_SIZE(q6apm_be_dais));
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id q6apm_bedai_device_id[] = {
+	{ .compatible = "qcom,q6apm-be-dais" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, q6apm_bedai_device_id);
+#endif
+
+static struct platform_driver q6apm_bedai_platform_driver = {
+	.driver = {
+		.name = "q6apm-bedai",
+		.of_match_table = of_match_ptr(q6apm_bedai_device_id),
+	},
+	.probe = q6apm_bedai_dev_probe,
+};
+module_platform_driver(q6apm_bedai_platform_driver);
+
+MODULE_DESCRIPTION("AUDIOREACH Audio BackEnd dai driver");
+MODULE_LICENSE("GPL");
-- 
2.21.0

