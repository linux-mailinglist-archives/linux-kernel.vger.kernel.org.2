Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B58A388C09
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 12:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346031AbhESKvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 06:51:35 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:9135 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346011AbhESKvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 06:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1621421402; x=1652957402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E1ll/nGj027BzHPrOVz/VehF+athq088ySz9vfcAdTI=;
  b=bzXN140cRtcYaKIu12CYHKOKtjeoWJkPMV/7umjAdfWQ9XVKmMYb4phJ
   PfH4HLkxW9eJL8JPru24jJbdau8QwiLtcM1qA2UWG1Eppz0SYLFkg7U6v
   gW6MTgE336TQ2l2XW6MtIjw2o2nC1BbudRqZYLKSrxbG0p9i3b6NKQAaP
   BNyHk7BovzJk0drnx4NkxpldBLcFXMnvhOchX2ZScHH/9WViNRoILtwO1
   5MbfhJ3Re0elfKCGsmyO0ncV9VmDHi7kA0PPCwYB3vNTKigaVh1t272HT
   OIvzyuBvMGRMCrUqRswV2e3yGPoleUjypZB9nNqOpA+E06oimmfrqQkVE
   A==;
IronPort-SDR: 4hjEbRTQ5JI3IvSn/a04n2tSl1T5ydsC7y/t8UsoCZbHHvTAVvvaHjz3kICi5CoStoEhf28GEn
 Pz/uarb+np3n0jRYkiFzewiyULVsmZstmjWtmfpfZqHFuA/D/G+4BuIfN/wUhYuCkA1AY3BT2g
 g0jp6EkfPKhMbepoBoYhbWPKluNXTQWvejkQjFsHrsnXtyYxquNUAA82hrf/CkA52kjEcvYz23
 F3kLK//Ijk0Jt212ZAX+sGvy2cG7gi+PbkiIIPuJoA7S12BYsBzV3bibNfONqUTzoVa8b4fcZ9
 lK8=
X-IronPort-AV: E=Sophos;i="5.82,312,1613458800"; 
   d="scan'208";a="56105024"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 May 2021 03:50:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 03:50:01 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 19 May 2021 03:49:57 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     <perex@perex.cz>, <tiwai@suse.com>,
        <pierre-louis.bossart@linux.intel.com>, <broonie@kernel.org>,
        <joe@perches.com>, <lgirdwood@gmail.com>, <lars@metafoo.de>,
        <kuninori.morimoto.gx@renesas.com>, <nicolas.ferre@microchip.com>,
        <Cristian.Birsan@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [RFC PATCH 6/6] ASoC: dmaengine: Allocate buffer if substream is unmanaged
Date:   Wed, 19 May 2021 13:48:42 +0300
Message-ID: <20210519104842.977895-7-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210519104842.977895-1-codrin.ciubotariu@microchip.com>
References: <20210519104842.977895-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pcm_construct/pcm_destruct callbacks are not called for BE DAIs. This means
that, if the generic dmaengine driver is used, there is no managed buffer
allocation (or pre-allocation). To be able to use the generic dmaengine
driver for BE DAI links, allocate the buffer in the hw_params callback if
there is no managed buffer.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 9ef80a48707e..c915da71e1cd 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -98,6 +98,22 @@ static int dmaengine_pcm_hw_params(struct snd_soc_component *component,
 			return ret;
 	}
 
+	if (!substream->managed_buffer_alloc) {
+		substream->dma_buffer.dev.type = SNDRV_DMA_TYPE_DEV_IRAM;
+		substream->dma_buffer.dev.dev = chan->device->dev;
+		return snd_pcm_lib_malloc_pages(substream,
+						params_buffer_bytes(params));
+	}
+
+	return 0;
+}
+
+static int dmaengine_pcm_hw_free(struct snd_soc_component *component,
+				 struct snd_pcm_substream *substream)
+{
+	if (!substream->managed_buffer_alloc)
+		return snd_pcm_lib_free_pages(substream);
+
 	return 0;
 }
 
@@ -332,6 +348,7 @@ static const struct snd_soc_component_driver dmaengine_pcm_component = {
 	.open		= dmaengine_pcm_open,
 	.close		= dmaengine_pcm_close,
 	.hw_params	= dmaengine_pcm_hw_params,
+	.hw_free	= dmaengine_pcm_hw_free,
 	.trigger	= dmaengine_pcm_trigger,
 	.pointer	= dmaengine_pcm_pointer,
 	.pcm_construct	= dmaengine_pcm_new,
@@ -343,6 +360,7 @@ static const struct snd_soc_component_driver dmaengine_pcm_component_process = {
 	.open		= dmaengine_pcm_open,
 	.close		= dmaengine_pcm_close,
 	.hw_params	= dmaengine_pcm_hw_params,
+	.hw_free	= dmaengine_pcm_hw_free,
 	.trigger	= dmaengine_pcm_trigger,
 	.pointer	= dmaengine_pcm_pointer,
 	.copy_user	= dmaengine_copy_user,
-- 
2.27.0

