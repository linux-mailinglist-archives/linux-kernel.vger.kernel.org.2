Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955BE388C04
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 12:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344630AbhESKvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 06:51:10 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:9114 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241609AbhESKvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 06:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1621421388; x=1652957388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OvmW6tVCbjyO+IvIX2whfPUPyiGN4DEv2pSti3uCZ0w=;
  b=eP/57C9L0T3TbEWRc/ll9Krd5JFASxhsfVTADO0oe6XDWwrtbcLegibG
   +Boxnv9KSG6d4lhKLCv97+1RgHh0lrUC818HGAkBRkRDfl8toKkZgMg2c
   Q5/x0MteslyTehnv7DzLO/oNkG8h+Axp5IQLiEoQUsllkBPGzj+n7ip23
   W2z71BkYsIU0InrAjmKE+L6oq0Ql3cWO3kEsoQzOh26f2UdIVzaYk9dN0
   oE/pZUVND2fdBz2R+YXWECmObeTbx7ZfrHc8hNTCBF2Kl5kEepIqvOYtB
   x1m512+xZGi4UVHhKCtN4ORTaeAYe9Pqu/kX0Ca77bGjwbVZBbzr6A0pq
   A==;
IronPort-SDR: 4Rxd1+63VuICe/o5nrpWV3F60GHyMgupHOg+jLGRmvzBc1gDLbKyknOL/X+Vq+ApEbnUEvN9b5
 y0E4zH7AIZGW5JsWxMU6MO6ivNSEN7N8OrrvQlF7K7Ok4Sf4hC6upLvYq2feJKx5nEhVD2Lpwh
 QoD6ot/EeBKB/+KZrg68lXbatln7uvLoyrKnFs5csFhyShJwG3JpXAdoRl5s++q3SImvRgxRj5
 HXITP1DS6DyBDlsU3dThzUDXgCCIQOldHTpoDZVz1oUUp0xCa4cvS9nAIXe6V5lwSo/3TZaVth
 Apc=
X-IronPort-AV: E=Sophos;i="5.82,312,1613458800"; 
   d="scan'208";a="56105002"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 May 2021 03:49:48 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 03:49:47 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 19 May 2021 03:49:43 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     <perex@perex.cz>, <tiwai@suse.com>,
        <pierre-louis.bossart@linux.intel.com>, <broonie@kernel.org>,
        <joe@perches.com>, <lgirdwood@gmail.com>, <lars@metafoo.de>,
        <kuninori.morimoto.gx@renesas.com>, <nicolas.ferre@microchip.com>,
        <Cristian.Birsan@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [RFC PATCH 3/6] ALSA: pcm: Check for substream->ops before substream->ops->mmap
Date:   Wed, 19 May 2021 13:48:39 +0300
Message-ID: <20210519104842.977895-4-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210519104842.977895-1-codrin.ciubotariu@microchip.com>
References: <20210519104842.977895-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

substreams, like the internal ones, might not have ops set. Check it,
before looking at substream->ops->mmap.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/core/pcm_native.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 54e0eab2a57e..cb0164d55593 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -246,7 +246,7 @@ static bool hw_support_mmap(struct snd_pcm_substream *substream)
 	if (!(substream->runtime->hw.info & SNDRV_PCM_INFO_MMAP))
 		return false;
 
-	if (substream->ops->mmap ||
+	if ((substream->ops && substream->ops->mmap) ||
 	    (substream->dma_buffer.dev.type != SNDRV_DMA_TYPE_DEV &&
 	     substream->dma_buffer.dev.type != SNDRV_DMA_TYPE_DEV_UC))
 		return true;
-- 
2.27.0

