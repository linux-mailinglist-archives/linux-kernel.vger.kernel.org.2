Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4819339644
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbhCLSX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:23:57 -0500
Received: from mga02.intel.com ([134.134.136.20]:36942 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231906AbhCLSX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:23:26 -0500
IronPort-SDR: Gwk9R4fkEo/Af4E4FM/XWes7KxgyP8kd1mDG7u/WcDkVvjuxIdCjwDMw2jhobsaNmBqoRm51/F
 EdhBR9PXoaKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="175999123"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="175999123"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:24 -0800
IronPort-SDR: ds0S0yWIDJ1HBs03JMj+yNt0YAyLpS++2rq6kg9abvuLpIxsQ0w+m9VtYlRKp0eBF/1Ky8f+rv
 fJYCpW0qJUrw==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="377791961"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.37.30])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:23 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Sia Jee Heng <jee.heng.sia@intel.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: [PATCH 10/23] ASoC: hdmi-codec: remove useless initialization
Date:   Fri, 12 Mar 2021 12:22:33 -0600
Message-Id: <20210312182246.5153-11-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix cppcheck warning:

sound/soc/codecs/hdmi-codec.c:745:5: style: Redundant initialization
for 'cf'. The initialized value is overwritten before it is
read. [redundantInitialization]
 cf = dai->playback_dma_data;
    ^
sound/soc/codecs/hdmi-codec.c:738:31: note: cf is initialized
 struct hdmi_codec_daifmt *cf = dai->playback_dma_data;
                              ^
sound/soc/codecs/hdmi-codec.c:745:5: note: cf is overwritten
 cf = dai->playback_dma_data;
    ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/hdmi-codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 422539f933de..83e74ddccf59 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -735,7 +735,7 @@ static int hdmi_codec_set_jack(struct snd_soc_component *component,
 
 static int hdmi_dai_spdif_probe(struct snd_soc_dai *dai)
 {
-	struct hdmi_codec_daifmt *cf = dai->playback_dma_data;
+	struct hdmi_codec_daifmt *cf;
 	int ret;
 
 	ret = hdmi_dai_probe(dai);
-- 
2.25.1

