Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB47433963B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbhCLSXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:23:23 -0500
Received: from mga02.intel.com ([134.134.136.20]:36921 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233121AbhCLSXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:23:12 -0500
IronPort-SDR: ubWGbqUyZLqH029yTx2wfx20yBxAIGlQEM69lHJ5kx6B6O89t+tBv1QtzRVj6cW6VDa10doUsL
 LIoRcYrdiJ2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="175999086"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="175999086"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:10 -0800
IronPort-SDR: YYsm2Ig+h24qBreBc1FvLpGhz8KQjbWRRMvYVLCGSOus4fmmuW8bxX/FbmI2ayPnEZg0oVoG6p
 8Rr3YqnMOXow==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="377791904"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.37.30])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:09 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 03/23] ASoC: adau1977: remove useless return
Date:   Fri, 12 Mar 2021 12:22:26 -0600
Message-Id: <20210312182246.5153-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cppcheck warning:

sound/soc/codecs/adau1977.c:242:9: warning: Identical condition and
return expression 'ret', return value is always 0
[identicalConditionAfterEarlyExit]

 return ret;
        ^
sound/soc/codecs/adau1977.c:239:6: note: If condition 'ret' is true,
the function will return/exit

 if (ret)
     ^
sound/soc/codecs/adau1977.c:242:9: note: Returning identical expression 'ret'
 return ret;
        ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/adau1977.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/adau1977.c b/sound/soc/codecs/adau1977.c
index 8260f49caa24..e347a48131d1 100644
--- a/sound/soc/codecs/adau1977.c
+++ b/sound/soc/codecs/adau1977.c
@@ -236,8 +236,6 @@ static int adau1977_reset(struct adau1977 *adau1977)
 	ret = regmap_write(adau1977->regmap, ADAU1977_REG_POWER,
 			ADAU1977_POWER_RESET);
 	regcache_cache_bypass(adau1977->regmap, false);
-	if (ret)
-		return ret;
 
 	return ret;
 }
-- 
2.25.1

