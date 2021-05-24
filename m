Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFBC38E2AB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 10:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbhEXIuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 04:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbhEXIuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 04:50:17 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90503C061756
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 01:48:48 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z17so27652842wrq.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 01:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ecYsyEcAYjL7TmBn0f7IHCmAR2sMm0pluu0i2il4oM=;
        b=wz3zfx+tQJG5iGFfIzyeq7rMIpmGkroMO8PreVuP6Fjy+PAXK1MHdOVx1IVnTtyBIY
         jVRm4RU2k8WUzuGANn3jzXKI1g5Hwyz6eUuPn9udzOFk/BTrHJ7fxbtHvPb6LOxza+Gu
         q9ipaWHy0Fhmq5jov7AgcIGA83v1eIdZc0xDkzFBEqU3LQuHwG0B1E9OivV8+mg/tBd5
         FHkRSfowFoXViCgYE1U55RvpJiaTv5N/3RXiPBgUlfeXSAQ64wXhvlGZmsbfiXNy0QEq
         c6dOjIxHHQzyn0J0dm0VpX7+U3ih+Pt2OUdllLbRMnKn00ot8x3IQGfh91WIdoG3LAvl
         DEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ecYsyEcAYjL7TmBn0f7IHCmAR2sMm0pluu0i2il4oM=;
        b=udKs/q2Uplm5TJZI/7yHCq8ZdXPjWHQExBtPDTrfW0s2Dez9n9Kf4sYyv1pPIoUB/p
         h0WxRCFFZQCACGM9bDG0t1qDf3B39on4kOlupdFB2iQ4+csqT1KR/PIFeKoFaHqz1CRC
         ctQE2oS4Tx5jtOCJMo6gh9n8G2ELy7eJvthA/EnQY3TlUo8Cl2iMxhORaj5MT1eoE3/+
         3vx48GxF8dtCFyHnpHNk272WVQ3oANV6ov5KSmRgkmllbfLKVLXyHOCeVt4BqGxF0ZsH
         N0kP1qPP1y5T/pJNeeF2HFfOLaQW3bj4/0MMZTC9wAinjYZkRCE1qoO4JXW6GdRcbP85
         T6ZA==
X-Gm-Message-State: AOAM530oE4oKhnoAQzWvJfPUKB4apqbVVRfS1I+w6flzm9Jux5PSmmMa
        ioJ+hnK7uZkuwbzjg4G9VWu0zAxesGa6lQ==
X-Google-Smtp-Source: ABdhPJxuXZ08vUkMFJEVXhw17L5VBPg6s5RdGRNwbYdIA1bioL5iNluOEBGadz2IG5phyXFymWTGwg==
X-Received: by 2002:a5d:48ce:: with SMTP id p14mr21406755wrs.170.1621846127125;
        Mon, 24 May 2021 01:48:47 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id x206sm4034548wmx.47.2021.05.24.01.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 01:48:46 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v7 5/9] ASoC: codecs: wcd938x-sdw: add SoundWire driver
Date:   Mon, 24 May 2021 09:48:24 +0100
Message-Id: <20210524084828.12787-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210524084828.12787-1-srinivas.kandagatla@linaro.org>
References: <20210524084828.12787-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to SoundWire devices on WCD9380/WCD9385 Codec

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/Kconfig       |   9 +
 sound/soc/codecs/Makefile      |   2 +
 sound/soc/codecs/wcd938x-sdw.c | 298 +++++++++++++++++++++++++++++++++
 sound/soc/codecs/wcd938x.c     |  32 ++++
 sound/soc/codecs/wcd938x.h     |  34 ++++
 5 files changed, 375 insertions(+)
 create mode 100644 sound/soc/codecs/wcd938x-sdw.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index e81950c735ce..7259006e2ca5 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1537,6 +1537,15 @@ config SND_SOC_WCD934X
 config SND_SOC_WCD938X
 	tristate
 
+config SND_SOC_WCD938X_SDW
+	tristate "WCD9380/WCD9385 Codec - SDW"
+	select SND_SOC_WCD938X
+	depends on SOUNDWIRE
+	select REGMAP_SOUNDWIRE
+	help
+	  The WCD9380/9385 is a audio codec IC Integrated in
+	  Qualcomm SoCs like SM8250.
+
 config SND_SOC_WL1273
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index e4334626c2d6..2440846f8811 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -253,6 +253,7 @@ snd-soc-uda1380-objs := uda1380.o
 snd-soc-wcd9335-objs := wcd-clsh-v2.o wcd9335.o
 snd-soc-wcd934x-objs := wcd-clsh-v2.o wcd934x.o
 snd-soc-wcd938x-objs := wcd938x.o wcd-clsh-v2.o
+snd-soc-wcd938x-sdw-objs := wcd938x-sdw.o
 snd-soc-wl1273-objs := wl1273.o
 snd-soc-wm-adsp-objs := wm_adsp.o
 snd-soc-wm0010-objs := wm0010.o
@@ -576,6 +577,7 @@ obj-$(CONFIG_SND_SOC_UDA1380)	+= snd-soc-uda1380.o
 obj-$(CONFIG_SND_SOC_WCD9335)	+= snd-soc-wcd9335.o
 obj-$(CONFIG_SND_SOC_WCD934X)	+= snd-soc-wcd934x.o
 obj-$(CONFIG_SND_SOC_WCD938X)	+= snd-soc-wcd938x.o
+obj-$(CONFIG_SND_SOC_WCD938X_SDW) += snd-soc-wcd938x-sdw.o
 obj-$(CONFIG_SND_SOC_WL1273)	+= snd-soc-wl1273.o
 obj-$(CONFIG_SND_SOC_WM0010)	+= snd-soc-wm0010.o
 obj-$(CONFIG_SND_SOC_WM1250_EV1) += snd-soc-wm1250-ev1.o
diff --git a/sound/soc/codecs/wcd938x-sdw.c b/sound/soc/codecs/wcd938x-sdw.c
new file mode 100644
index 000000000000..36cf7428d7c6
--- /dev/null
+++ b/sound/soc/codecs/wcd938x-sdw.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2021, Linaro Limited
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/component.h>
+#include <sound/soc.h>
+#include <linux/pm_runtime.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_type.h>
+#include <linux/soundwire/sdw_registers.h>
+#include <linux/regmap.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include "wcd938x.h"
+
+#define SWRS_SCP_HOST_CLK_DIV2_CTL_BANK(m) (0xE0 + 0x10 * (m))
+
+static struct wcd938x_sdw_ch_info wcd938x_sdw_rx_ch_info[] = {
+	WCD_SDW_CH(WCD938X_HPH_L, WCD938X_HPH_PORT, BIT(0)),
+	WCD_SDW_CH(WCD938X_HPH_R, WCD938X_HPH_PORT, BIT(1)),
+	WCD_SDW_CH(WCD938X_CLSH, WCD938X_CLSH_PORT, BIT(0)),
+	WCD_SDW_CH(WCD938X_COMP_L, WCD938X_COMP_PORT, BIT(0)),
+	WCD_SDW_CH(WCD938X_COMP_R, WCD938X_COMP_PORT, BIT(1)),
+	WCD_SDW_CH(WCD938X_LO, WCD938X_LO_PORT, BIT(0)),
+	WCD_SDW_CH(WCD938X_DSD_L, WCD938X_DSD_PORT, BIT(0)),
+	WCD_SDW_CH(WCD938X_DSD_R, WCD938X_DSD_PORT, BIT(1)),
+};
+
+static struct wcd938x_sdw_ch_info wcd938x_sdw_tx_ch_info[] = {
+	WCD_SDW_CH(WCD938X_ADC1, WCD938X_ADC_1_2_PORT, BIT(0)),
+	WCD_SDW_CH(WCD938X_ADC2, WCD938X_ADC_1_2_PORT, BIT(1)),
+	WCD_SDW_CH(WCD938X_ADC3, WCD938X_ADC_3_4_PORT, BIT(0)),
+	WCD_SDW_CH(WCD938X_ADC4, WCD938X_ADC_3_4_PORT, BIT(1)),
+	WCD_SDW_CH(WCD938X_DMIC0, WCD938X_DMIC_0_3_MBHC_PORT, BIT(0)),
+	WCD_SDW_CH(WCD938X_DMIC1, WCD938X_DMIC_0_3_MBHC_PORT, BIT(1)),
+	WCD_SDW_CH(WCD938X_MBHC, WCD938X_DMIC_0_3_MBHC_PORT, BIT(2)),
+	WCD_SDW_CH(WCD938X_DMIC2, WCD938X_DMIC_0_3_MBHC_PORT, BIT(2)),
+	WCD_SDW_CH(WCD938X_DMIC3, WCD938X_DMIC_0_3_MBHC_PORT, BIT(3)),
+	WCD_SDW_CH(WCD938X_DMIC4, WCD938X_DMIC_4_7_PORT, BIT(0)),
+	WCD_SDW_CH(WCD938X_DMIC5, WCD938X_DMIC_4_7_PORT, BIT(1)),
+	WCD_SDW_CH(WCD938X_DMIC6, WCD938X_DMIC_4_7_PORT, BIT(2)),
+	WCD_SDW_CH(WCD938X_DMIC7, WCD938X_DMIC_4_7_PORT, BIT(3)),
+};
+
+static struct sdw_dpn_prop wcd938x_dpn_prop[WCD938X_MAX_SWR_PORTS] = {
+	{
+		.num = 1,
+		.type = SDW_DPN_SIMPLE,
+		.min_ch = 1,
+		.max_ch = 8,
+		.simple_ch_prep_sm = true,
+	}, {
+		.num = 2,
+		.type = SDW_DPN_SIMPLE,
+		.min_ch = 1,
+		.max_ch = 4,
+		.simple_ch_prep_sm = true,
+	}, {
+		.num = 3,
+		.type = SDW_DPN_SIMPLE,
+		.min_ch = 1,
+		.max_ch = 4,
+		.simple_ch_prep_sm = true,
+	}, {
+		.num = 4,
+		.type = SDW_DPN_SIMPLE,
+		.min_ch = 1,
+		.max_ch = 4,
+		.simple_ch_prep_sm = true,
+	}, {
+		.num = 5,
+		.type = SDW_DPN_SIMPLE,
+		.min_ch = 1,
+		.max_ch = 4,
+		.simple_ch_prep_sm = true,
+	}
+};
+
+int wcd938x_sdw_hw_params(struct wcd938x_sdw_priv *wcd,
+			  struct snd_pcm_substream *substream,
+			  struct snd_pcm_hw_params *params,
+			  struct snd_soc_dai *dai)
+{
+	struct sdw_port_config port_config[WCD938X_MAX_SWR_PORTS];
+	unsigned long ch_mask;
+	int i, j;
+
+	wcd->sconfig.ch_count = 1;
+	wcd->active_ports = 0;
+	for (i = 0; i < WCD938X_MAX_SWR_PORTS; i++) {
+		ch_mask = wcd->port_config[i].ch_mask;
+
+		if (!ch_mask)
+			continue;
+
+		for_each_set_bit(j, &ch_mask, 4)
+			wcd->sconfig.ch_count++;
+
+		port_config[wcd->active_ports] = wcd->port_config[i];
+		wcd->active_ports++;
+	}
+
+	wcd->sconfig.bps = 1;
+	wcd->sconfig.frame_rate =  params_rate(params);
+	if (wcd->is_tx)
+		wcd->sconfig.direction = SDW_DATA_DIR_TX;
+	else
+		wcd->sconfig.direction = SDW_DATA_DIR_RX;
+
+	wcd->sconfig.type = SDW_STREAM_PCM;
+
+	return sdw_stream_add_slave(wcd->sdev, &wcd->sconfig,
+				    &port_config[0], wcd->active_ports,
+				    wcd->sruntime);
+}
+EXPORT_SYMBOL_GPL(wcd938x_sdw_hw_params);
+
+int wcd938x_sdw_free(struct wcd938x_sdw_priv *wcd,
+		     struct snd_pcm_substream *substream,
+		     struct snd_soc_dai *dai)
+{
+	sdw_stream_remove_slave(wcd->sdev, wcd->sruntime);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wcd938x_sdw_free);
+
+int wcd938x_sdw_set_sdw_stream(struct wcd938x_sdw_priv *wcd,
+			       struct snd_soc_dai *dai,
+			       void *stream, int direction)
+{
+	wcd->sruntime = stream;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wcd938x_sdw_set_sdw_stream);
+
+static int wcd9380_update_status(struct sdw_slave *slave,
+				 enum sdw_slave_status status)
+{
+	return 0;
+}
+
+static int wcd9380_bus_config(struct sdw_slave *slave,
+			      struct sdw_bus_params *params)
+{
+	sdw_write(slave, SWRS_SCP_HOST_CLK_DIV2_CTL_BANK(params->next_bank),  0x01);
+
+	return 0;
+}
+
+static int wcd9380_interrupt_callback(struct sdw_slave *slave,
+				      struct sdw_slave_intr_status *status)
+{
+	struct wcd938x_sdw_priv *wcd = dev_get_drvdata(&slave->dev);
+
+	return wcd938x_handle_sdw_irq(wcd);
+}
+
+static struct sdw_slave_ops wcd9380_slave_ops = {
+	.update_status = wcd9380_update_status,
+	.interrupt_callback = wcd9380_interrupt_callback,
+	.bus_config = wcd9380_bus_config,
+};
+
+static int wcd938x_sdw_component_bind(struct device *dev,
+				      struct device *master, void *data)
+{
+	return 0;
+}
+
+static void wcd938x_sdw_component_unbind(struct device *dev,
+					 struct device *master, void *data)
+{
+}
+
+static const struct component_ops wcd938x_sdw_component_ops = {
+	.bind   = wcd938x_sdw_component_bind,
+	.unbind = wcd938x_sdw_component_unbind,
+};
+
+static int wcd9380_probe(struct sdw_slave *pdev,
+			 const struct sdw_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	struct wcd938x_sdw_priv *wcd;
+	int ret;
+
+	wcd = devm_kzalloc(dev, sizeof(*wcd), GFP_KERNEL);
+	if (!wcd)
+		return -ENOMEM;
+
+	/**
+	 * Port map index starts with 0, however the data port for this codec
+	 * are from index 1
+	 */
+	if (of_property_read_bool(dev->of_node, "qcom,tx-port-mapping")) {
+		wcd->is_tx = true;
+		ret = of_property_read_u32_array(dev->of_node, "qcom,tx-port-mapping",
+						 &pdev->m_port_map[1],
+						 WCD938X_MAX_TX_SWR_PORTS);
+	} else {
+		ret = of_property_read_u32_array(dev->of_node, "qcom,rx-port-mapping",
+						 &pdev->m_port_map[1],
+						 WCD938X_MAX_SWR_PORTS);
+	}
+
+	if (ret < 0)
+		dev_info(dev, "Static Port mapping not specified\n");
+
+	wcd->sdev = pdev;
+	dev_set_drvdata(dev, wcd);
+
+	pdev->prop.scp_int1_mask = SDW_SCP_INT1_IMPL_DEF |
+					SDW_SCP_INT1_BUS_CLASH |
+					SDW_SCP_INT1_PARITY;
+	pdev->prop.lane_control_support = true;
+	if (wcd->is_tx) {
+		struct regmap *rm;
+
+		pdev->prop.source_ports = GENMASK(WCD938X_MAX_SWR_PORTS, 0);
+		pdev->prop.src_dpn_prop = wcd938x_dpn_prop;
+		wcd->ch_info = &wcd938x_sdw_tx_ch_info[0];
+		pdev->prop.wake_capable = true;
+
+		rm = devm_regmap_init_sdw(pdev, &wcd938x_regmap_config);
+		if (IS_ERR(rm))
+			return PTR_ERR(rm);
+	} else {
+		pdev->prop.sink_ports = GENMASK(WCD938X_MAX_SWR_PORTS, 0);
+		pdev->prop.sink_dpn_prop = wcd938x_dpn_prop;
+		wcd->ch_info = &wcd938x_sdw_rx_ch_info[0];
+	}
+
+	pm_runtime_set_autosuspend_delay(dev, 3000);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	return component_add(dev, &wcd938x_sdw_component_ops);
+}
+
+static const struct sdw_device_id wcd9380_slave_id[] = {
+	SDW_SLAVE_ENTRY(0x0217, 0x10d, 0),
+	{},
+};
+MODULE_DEVICE_TABLE(sdw, wcd9380_slave_id);
+
+static int __maybe_unused wcd938x_sdw_runtime_suspend(struct device *dev)
+{
+	struct regmap *regmap = dev_get_regmap(dev, NULL);
+
+	if (regmap) {
+		regcache_cache_only(regmap, true);
+		regcache_mark_dirty(regmap);
+	}
+	return 0;
+}
+
+static int __maybe_unused wcd938x_sdw_runtime_resume(struct device *dev)
+{
+	struct regmap *regmap = dev_get_regmap(dev, NULL);
+
+	if (regmap) {
+		regcache_cache_only(regmap, false);
+		regcache_sync(regmap);
+	}
+
+	pm_runtime_mark_last_busy(dev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops wcd938x_sdw_pm_ops = {
+	SET_RUNTIME_PM_OPS(wcd938x_sdw_runtime_suspend, wcd938x_sdw_runtime_resume, NULL)
+};
+
+
+static struct sdw_driver wcd9380_codec_driver = {
+	.probe	= wcd9380_probe,
+	.ops = &wcd9380_slave_ops,
+	.id_table = wcd9380_slave_id,
+	.driver = {
+		.name	= "wcd9380-codec",
+		.pm = &wcd938x_sdw_pm_ops,
+	}
+};
+module_sdw_driver(wcd9380_codec_driver);
+
+MODULE_DESCRIPTION("WCD938X SDW codec driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 6a0817868673..18d2c49314fd 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -1515,7 +1515,39 @@ int wcd938x_handle_sdw_irq(struct wcd938x_sdw_priv *wcd)
 }
 EXPORT_SYMBOL_GPL(wcd938x_handle_sdw_irq);
 
+static int wcd938x_codec_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	struct wcd938x_priv *wcd938x = dev_get_drvdata(dai->dev);
+	struct wcd938x_sdw_priv *wcd = wcd938x->sdw_priv[dai->id];
+
+	return wcd938x_sdw_hw_params(wcd, substream, params, dai);
+}
+
+static int wcd938x_codec_free(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *dai)
+{
+	struct wcd938x_priv *wcd938x = dev_get_drvdata(dai->dev);
+	struct wcd938x_sdw_priv *wcd = wcd938x->sdw_priv[dai->id];
+
+	return wcd938x_sdw_free(wcd, substream, dai);
+}
+
+static int wcd938x_codec_set_sdw_stream(struct snd_soc_dai *dai,
+				  void *stream, int direction)
+{
+	struct wcd938x_priv *wcd938x = dev_get_drvdata(dai->dev);
+	struct wcd938x_sdw_priv *wcd = wcd938x->sdw_priv[dai->id];
+
+	return wcd938x_sdw_set_sdw_stream(wcd, dai, stream, direction);
+
+}
+
 static struct snd_soc_dai_ops wcd938x_sdw_dai_ops = {
+	.hw_params = wcd938x_codec_hw_params,
+	.hw_free = wcd938x_codec_free,
+	.set_sdw_stream = wcd938x_codec_set_sdw_stream,
 };
 
 static struct snd_soc_dai_driver wcd938x_dais[] = {
diff --git a/sound/soc/codecs/wcd938x.h b/sound/soc/codecs/wcd938x.h
index efaa4dfc752a..eed914359b87 100644
--- a/sound/soc/codecs/wcd938x.h
+++ b/sound/soc/codecs/wcd938x.h
@@ -668,4 +668,38 @@ struct wcd938x_sdw_priv {
 extern struct regmap_config wcd938x_regmap_config;
 int wcd938x_handle_sdw_irq(struct wcd938x_sdw_priv *priv);
 
+#if IS_ENABLED(CONFIG_SND_SOC_WCD938X_SDW)
+int wcd938x_sdw_free(struct wcd938x_sdw_priv *wcd,
+		     struct snd_pcm_substream *substream,
+		     struct snd_soc_dai *dai);
+int wcd938x_sdw_set_sdw_stream(struct wcd938x_sdw_priv *wcd,
+			       struct snd_soc_dai *dai,
+			       void *stream, int direction);
+int wcd938x_sdw_hw_params(struct wcd938x_sdw_priv *wcd,
+			  struct snd_pcm_substream *substream,
+			  struct snd_pcm_hw_params *params,
+			  struct snd_soc_dai *dai);
+#else
+
+static inline int wcd938x_sdw_free(struct wcd938x_sdw_priv *wcd,
+		     struct snd_pcm_substream *substream,
+		     struct snd_soc_dai *dai)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int wcd938x_sdw_set_sdw_stream(struct wcd938x_sdw_priv *wcd,
+			       struct snd_soc_dai *dai,
+			       void *stream, int direction)
+{
+	return -EOPNOTSUPP;
+}
+int wcd938x_sdw_hw_params(struct wcd938x_sdw_priv *wcd,
+			  struct snd_pcm_substream *substream,
+			  struct snd_pcm_hw_params *params,
+			  struct snd_soc_dai *dai)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_SND_SOC_WCD938X_SDW */
 #endif /* __WCD938X_H__ */
-- 
2.21.0

