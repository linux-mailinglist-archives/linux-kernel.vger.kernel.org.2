Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B8134B1AC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 23:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhCZWAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 18:00:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:61331 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230180AbhCZWAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 18:00:05 -0400
IronPort-SDR: 5394x6o8vPOr8XXSG8mkxHab+MLRVJZfW9q9XMqpaMAzlPpgNINbiJ0OVarXtYQIUKiQIVYo6b
 2g1mveA9TxiQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="188957084"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="188957084"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 15:00:05 -0700
IronPort-SDR: LPvQQBUTZQoub2tgOnyV3oci46fvQuMKxLtmO0TNsF6EKwhztLoDFYJJu9ibZwwz2dP6h5WHcv
 LChziWVcD0ww==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="416706775"
Received: from zcmahone-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.255.231.203])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 15:00:03 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:PXA2xx/PXA3xx
        SUPPORT)
Subject: [PATCH 07/17] ASoC: pxa: remove useless assignment
Date:   Fri, 26 Mar 2021 16:59:17 -0500
Message-Id: <20210326215927.936377-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
References: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/pxa/mmp-pcm.c:207:10: style: Variable 'ret' is assigned a
value that is never used. [unreadVariable]
 int ret = 0, stream;
         ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/pxa/mmp-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/pxa/mmp-pcm.c b/sound/soc/pxa/mmp-pcm.c
index 53fc49e32fbc..5d520e18e512 100644
--- a/sound/soc/pxa/mmp-pcm.c
+++ b/sound/soc/pxa/mmp-pcm.c
@@ -204,7 +204,7 @@ static int mmp_pcm_new(struct snd_soc_component *component,
 {
 	struct snd_pcm_substream *substream;
 	struct snd_pcm *pcm = rtd->pcm;
-	int ret = 0, stream;
+	int ret, stream;
 
 	for (stream = 0; stream < 2; stream++) {
 		substream = pcm->streams[stream].substream;
-- 
2.25.1

