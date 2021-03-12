Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F15339652
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbhCLSYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:24:31 -0500
Received: from mga07.intel.com ([134.134.136.100]:4236 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233298AbhCLSXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:23:52 -0500
IronPort-SDR: CKf9roMpF6ilpoeClNXaGYdGVS0YENuiuTtjGLrxGAgsV8P0Qv98C37GFJRxIe8pBcqz3nGLmX
 2xuYPOTtFsmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="252888953"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="252888953"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:52 -0800
IronPort-SDR: o8BsyRpU/yc0CdyM5I3L1bh5ATKYgIyYoD4rM7Z3YXWGPwZgTOw+zfGiYLvYsTGC2dYAqXCbBS
 kcCRuVHdnKnQ==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="377792064"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.37.30])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:51 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Dan Murphy <dmurphy@ti.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonghwan Choi <charlie.jh@kakaocorp.com>
Subject: [PATCH 20/23] ASoC: tas2562: remove warning on return value
Date:   Fri, 12 Mar 2021 12:22:43 -0600
Message-Id: <20210312182246.5153-21-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/codecs/tas2562.c:530:9: warning: Identical condition and return expression 'ret', return value is always 0 [identicalConditionAfterEarlyExit]
 return ret;
        ^
sound/soc/codecs/tas2562.c:525:6: note: If condition 'ret' is true, the function will return/exit
 if (ret)
     ^
sound/soc/codecs/tas2562.c:530:9: note: Returning identical expression 'ret'
 return ret;
        ^

Fix with return 0

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/tas2562.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index ba23f9f07f04..10302552195e 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -526,7 +526,7 @@ static int tas2562_volume_control_put(struct snd_kcontrol *kcontrol,
 
 	tas2562->volume_lvl = ucontrol->value.integer.value[0];
 
-	return ret;
+	return 0;
 }
 
 /* Digital Volume Control. From 0 dB to -110 dB in 1 dB steps */
-- 
2.25.1

