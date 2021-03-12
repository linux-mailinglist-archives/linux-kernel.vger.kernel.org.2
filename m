Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E98A33963A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhCLSXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:23:21 -0500
Received: from mga02.intel.com ([134.134.136.20]:36913 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233119AbhCLSXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:23:10 -0500
IronPort-SDR: UBpjiXn3sfteBFShaxHfLAXvrfK5UqElR9/6oEVo6kQ/Cufhnrbv7ANjTdv6MW1yHfSpw8hRrz
 YgILN9jI82xQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="175999084"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="175999084"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:09 -0800
IronPort-SDR: 7mFQaj0ncPzQXy21S4P27cDT1gMH9RkZghKZHFmkHbTRU4dX40t5Fpomkj5fWPLIPGcNGEjFAE
 FZ/IEpgbVSCg==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="377791901"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.37.30])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:08 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 02/23] ASoC: ad1836: remove useless return
Date:   Fri, 12 Mar 2021 12:22:25 -0600
Message-Id: <20210312182246.5153-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cppcheck warning:

sound/soc/codecs/ad1836.c:311:9: warning: Identical condition and return expression 'ret', return value is always 0 [identicalConditionAfterEarlyExit]
 return ret;
        ^
sound/soc/codecs/ad1836.c:308:6: note: If condition 'ret' is true, the function will return/exit
 if (ret)
     ^
sound/soc/codecs/ad1836.c:311:9: note: Returning identical expression 'ret'
 return ret;
        ^

Likely copy/paste between adc and dac cases.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/ad1836.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index a46152560294..08a5651bed9f 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -305,8 +305,6 @@ static int ad1836_probe(struct snd_soc_component *component)
 		return ret;
 
 	ret = snd_soc_dapm_add_routes(dapm, ad183x_adc_routes, num_adcs);
-	if (ret)
-		return ret;
 
 	return ret;
 }
-- 
2.25.1

