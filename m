Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C3B336939
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 01:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhCKAtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 19:49:43 -0500
Received: from mga05.intel.com ([192.55.52.43]:15447 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbhCKAtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 19:49:25 -0500
IronPort-SDR: vFDNSVbEF+rxOy9rfu3J9x84PopMGuIIFVMiOHUos7MSGFOvUh70JpRDfHb8KOpsu3UVRgu/xS
 cMlslT0b+c+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="273629862"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="273629862"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 16:49:25 -0800
IronPort-SDR: FSbU1mY7rxBkyn+H5OVD7Y273ef/naAw+b1hkifbnAIIoIsy6sJoCNqQo/iLmPA3hbZZA4rijd
 rl09/87K6A6Q==
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="370386809"
Received: from theer-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.101.109])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 16:49:23 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH 4/4] ASoC: mediatek: mt8173: rename local irq variable
Date:   Wed, 10 Mar 2021 18:49:04 -0600
Message-Id: <20210311004904.121205-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311004904.121205-1-pierre-louis.bossart@linux.intel.com>
References: <20210311004904.121205-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/mediatek/mt8173/mt8173-afe-pcm.c:929:28: style: Local
variable 'irq' shadows outer argument [shadowArgument]
  struct mtk_base_afe_irq *irq;
                           ^
sound/soc/mediatek/mt8173/mt8173-afe-pcm.c:914:47: note: Shadowed
declaration
static irqreturn_t mt8173_afe_irq_handler(int irq, void *dev_id)
                                              ^
sound/soc/mediatek/mt8173/mt8173-afe-pcm.c:929:28: note: Shadow
variable
  struct mtk_base_afe_irq *irq;
                           ^

Not a great idea to have two 'irq' variables in the same function...

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
index 685f4074b4e0..6350390414d4 100644
--- a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
@@ -926,14 +926,14 @@ static irqreturn_t mt8173_afe_irq_handler(int irq, void *dev_id)
 
 	for (i = 0; i < MT8173_AFE_MEMIF_NUM; i++) {
 		struct mtk_base_afe_memif *memif = &afe->memif[i];
-		struct mtk_base_afe_irq *irq;
+		struct mtk_base_afe_irq *irq_p;
 
 		if (memif->irq_usage < 0)
 			continue;
 
-		irq = &afe->irqs[memif->irq_usage];
+		irq_p = &afe->irqs[memif->irq_usage];
 
-		if (!(reg_value & (1 << irq->irq_data->irq_clr_shift)))
+		if (!(reg_value & (1 << irq_p->irq_data->irq_clr_shift)))
 			continue;
 
 		snd_pcm_period_elapsed(memif->substream);
-- 
2.25.1

