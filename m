Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4A3336938
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 01:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhCKAtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 19:49:42 -0500
Received: from mga05.intel.com ([192.55.52.43]:15447 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhCKAtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 19:49:22 -0500
IronPort-SDR: s/g9tPUP0iZjPRpxE7vlV2if40rNVpZ5l5ni/HwWtEtza7gSK4br19cD6xI5yW3VQ691YjmamA
 UcuPKcQc15Pg==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="273629860"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="273629860"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 16:49:22 -0800
IronPort-SDR: BhKoyhXtdGKV5O1zd6/K9C7KxhHwbj9vnaXtmqYZmIkYx82BA/1XRFhC/c5asRys56K22Q4GZQ
 wV2iI0dMK3Dw==
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="370386802"
Received: from theer-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.101.109])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 16:49:21 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH 3/4] ASoC: mediatek: mt2701: rename shadowed array
Date:   Wed, 10 Mar 2021 18:49:03 -0600
Message-Id: <20210311004904.121205-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311004904.121205-1-pierre-louis.bossart@linux.intel.com>
References: <20210311004904.121205-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:406:36: style: Local
variable 'memif_data' shadows outer variable [shadowVariable]
 const struct mtk_base_memif_data *memif_data;
                                   ^
sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:977:41: note: Shadowed
declaration
static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
                                        ^
sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:406:36: note: Shadow
variable
 const struct mtk_base_memif_data *memif_data;
                                   ^
sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:431:36: style: Local
variable 'memif_data' shadows outer variable [shadowVariable]
 const struct mtk_base_memif_data *memif_data;
                                   ^
sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:977:41: note: Shadowed
declaration
static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
                                        ^
sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:431:36: note: Shadow
variable
 const struct mtk_base_memif_data *memif_data;
                                   ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index d5cffe7a7e15..bc3d0466472b 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -974,7 +974,7 @@ static const struct snd_soc_component_driver mt2701_afe_pcm_dai_component = {
 	.resume = mtk_afe_resume,
 };
 
-static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
+static const struct mtk_base_memif_data memif_data_array[MT2701_MEMIF_NUM] = {
 	{
 		.name = "DL1",
 		.id = MT2701_MEMIF_DL1,
@@ -1366,7 +1366,7 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	for (i = 0; i < afe->memif_size; i++) {
-		afe->memif[i].data = &memif_data[i];
+		afe->memif[i].data = &memif_data_array[i];
 		afe->memif[i].irq_usage = -1;
 	}
 
-- 
2.25.1

