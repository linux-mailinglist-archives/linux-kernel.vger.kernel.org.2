Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F183A0F51
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 11:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237859AbhFIJMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 05:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237850AbhFIJMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 05:12:01 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF1DC061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 02:10:06 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id h22-20020a05600c3516b02901a826f84095so3675761wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 02:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wXmfKu70pgJnffMSieeEWeZcYO8muF1Mv78g8zVkmUc=;
        b=UqH04kjRPSBUTFNA1kaGwJRNgluBO2d8ALsw0F/6qkIDfjuss/nYyaOMsMQCL6BxAY
         vitYGu/TSrv6IzlU4ybN0IS/JIU5MeS6Uvpy+swg2KLVNtKZSCKTVFM1xP7LdpfSAtTb
         FNglGw3UMNIxjsV1wDaB1qtb0kFG+Kpgm1/saW6wQN949KOXZndiAFw1NBwdmQeMMrNF
         +KBui+PD4CF8zyZtCl73BMMrlHjWK4KOLGxvGrCGML2ZKfAitYsi5y6ptRIefnKh8M6/
         Jgre4CITztxbPylIMkkKcPujP77HlHeNhX7lBwK2l4n5bQQdpghwxfX1GELGqBBtNure
         gDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wXmfKu70pgJnffMSieeEWeZcYO8muF1Mv78g8zVkmUc=;
        b=UeZzVgQXOcHdyviBLiLfkRXAsZxaxZGG32HnA8tYW8ZKVtO8x5cEuLRPiOpEp7vnJK
         xF5fTNkaz6RK1JA84TUxamcPR3di1udMGU9hn3tXEiYXn7Zj+rXLoXI4LdMWNUZ2/mVx
         0xUugpB20WTAVngyrNZuhQ004GmcMnUwJU+E3HX1zEZVg7cBxthzIvB0Fvhr1nyQDzrn
         aOOuv+fMoGkjWrgRv9UVCE6knSyPIxu2pBb+3wk3slaTXZK7P9jojsBtGIGG4YSXGAda
         PQUjIBWIqu4LEi2qYveNNHm72mOYI5DUewikG3qD620MpWTrmUBZpyNYi8k61anZg6F3
         iO2g==
X-Gm-Message-State: AOAM533SQGPRhXn+a69l8C3XdWVv79e78fOpQx2uqVHhKBXDhPrJ6YEa
        20URIsKDkwR9o1Fp0l/08m8DhQ==
X-Google-Smtp-Source: ABdhPJwSmIjsMfDuvid9dReRfdFqMl9mXuQwEFb2UNykxqh52nzAuxbiI1QV5xfgOZVDSp5nVhT/kA==
X-Received: by 2002:a7b:ca44:: with SMTP id m4mr8771767wml.123.1623229804991;
        Wed, 09 Jun 2021 02:10:04 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id v18sm25165385wrb.10.2021.06.09.02.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 02:10:04 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v9 5/9] ASoC: codecs: wcd938x-sdw: add SoundWire driver
Date:   Wed,  9 Jun 2021 10:09:39 +0100
Message-Id: <20210609090943.7896-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210609090943.7896-1-srinivas.kandagatla@linaro.org>
References: <20210609090943.7896-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to SoundWire devices on WCD9380/WCD9385 Codec

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd938x-sdw.c | 315 +++++++++++++++++++++++++++++++++
 sound/soc/codecs/wcd938x.c     |  82 +++++++++
 sound/soc/codecs/wcd938x.h     |  49 +++++
 3 files changed, 446 insertions(+)
 create mode 100644 sound/soc/codecs/wcd938x-sdw.c

diff --git a/sound/soc/codecs/wcd938x-sdw.c b/sound/soc/codecs/wcd938x-sdw.c
new file mode 100644
index 000000000000..d82c40ec6898
--- /dev/null
+++ b/sound/soc/codecs/wcd938x-sdw.c
@@ -0,0 +1,315 @@
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
+struct device *wcd938x_sdw_device_get(struct device_node *np)
+{
+	return bus_find_device_by_of_node(&sdw_bus_type, np);
+
+}
+EXPORT_SYMBOL_GPL(wcd938x_sdw_device_get);
+
+int wcd938x_swr_get_current_bank(struct sdw_slave *sdev)
+{
+	int bank;
+
+	bank  = sdw_read(sdev, SDW_SCP_CTRL);
+
+	return ((bank & 0x40) ? 1 : 0);
+}
+EXPORT_SYMBOL_GPL(wcd938x_swr_get_current_bank);
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
index 6b8ee9971945..6400ff7347d4 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -1514,7 +1514,39 @@ int wcd938x_handle_sdw_irq(struct wcd938x_sdw_priv *wcd)
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
@@ -1558,6 +1590,53 @@ static int wcd938x_bind(struct device *dev)
 		return ret;
 	}
 
+	wcd938x->rxdev = wcd938x_sdw_device_get(wcd938x->rxnode);
+	if (!wcd938x->rxdev) {
+		dev_err(dev, "could not find slave with matching of node\n");
+		return -EINVAL;
+	}
+	wcd938x->sdw_priv[AIF1_PB] = dev_get_drvdata(wcd938x->rxdev);
+	wcd938x->sdw_priv[AIF1_PB]->wcd938x = wcd938x;
+
+	wcd938x->txdev = wcd938x_sdw_device_get(wcd938x->txnode);
+	if (!wcd938x->txdev) {
+		dev_err(dev, "could not find txslave with matching of node\n");
+		return -EINVAL;
+	}
+	wcd938x->sdw_priv[AIF1_CAP] = dev_get_drvdata(wcd938x->txdev);
+	wcd938x->sdw_priv[AIF1_CAP]->wcd938x = wcd938x;
+	wcd938x->tx_sdw_dev = dev_to_sdw_dev(wcd938x->txdev);
+	if (!wcd938x->tx_sdw_dev) {
+		dev_err(dev, "could not get txslave with matching of dev\n");
+		return -EINVAL;
+	}
+
+	/* As TX is main CSR reg interface, which should not be suspended first.
+	 * expicilty add the dependency link */
+	if (!device_link_add(wcd938x->rxdev, wcd938x->txdev, DL_FLAG_STATELESS |
+			    DL_FLAG_PM_RUNTIME)) {
+		dev_err(dev, "could not devlink tx and rx\n");
+		return -EINVAL;
+	}
+
+	if (!device_link_add(dev, wcd938x->txdev, DL_FLAG_STATELESS |
+					DL_FLAG_PM_RUNTIME)) {
+		dev_err(dev, "could not devlink wcd and tx\n");
+		return -EINVAL;
+	}
+
+	if (!device_link_add(dev, wcd938x->rxdev, DL_FLAG_STATELESS |
+					DL_FLAG_PM_RUNTIME)) {
+		dev_err(dev, "could not devlink wcd and rx\n");
+		return -EINVAL;
+	}
+
+	wcd938x->regmap = dev_get_regmap(wcd938x->txdev, NULL);
+	if (!wcd938x->regmap) {
+		dev_err(dev, "%s: tx csr regmap not found\n", __func__);
+		return PTR_ERR(wcd938x->regmap);
+	}
+
 	ret = wcd938x_set_micbias_data(wcd938x);
 	if (ret < 0) {
 		dev_err(dev, "%s: bad micbias pdata\n", __func__);
@@ -1578,6 +1657,9 @@ static void wcd938x_unbind(struct device *dev)
 {
 	struct wcd938x_priv *wcd938x = dev_get_drvdata(dev);
 
+	device_link_remove(dev, wcd938x->txdev);
+	device_link_remove(dev, wcd938x->rxdev);
+	device_link_remove(wcd938x->rxdev, wcd938x->txdev);
 	snd_soc_unregister_component(dev);
 	component_unbind_all(dev, wcd938x);
 }
diff --git a/sound/soc/codecs/wcd938x.h b/sound/soc/codecs/wcd938x.h
index efaa4dfc752a..9db3ab6e47a6 100644
--- a/sound/soc/codecs/wcd938x.h
+++ b/sound/soc/codecs/wcd938x.h
@@ -668,4 +668,53 @@ struct wcd938x_sdw_priv {
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
+
+struct device *wcd938x_sdw_device_get(struct device_node *np);
+int wcd938x_swr_get_current_bank(struct sdw_slave *sdev);
+
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
+
+static inline int wcd938x_sdw_hw_params(struct wcd938x_sdw_priv *wcd,
+			  struct snd_pcm_substream *substream,
+			  struct snd_pcm_hw_params *params,
+			  struct snd_soc_dai *dai)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline struct device *wcd938x_sdw_device_get(struct device_node *np)
+{
+	return NULL;
+}
+
+static inline int wcd938x_swr_get_current_bank(struct sdw_slave *sdev)
+{
+	return 0;
+}
+#endif /* CONFIG_SND_SOC_WCD938X_SDW */
 #endif /* __WCD938X_H__ */
-- 
2.21.0

