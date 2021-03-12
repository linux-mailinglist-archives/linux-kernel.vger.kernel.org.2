Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85F3339640
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbhCLSXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:23:50 -0500
Received: from mga02.intel.com ([134.134.136.20]:36926 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233128AbhCLSXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:23:19 -0500
IronPort-SDR: MSdkeObA2gJNdz/cx94NNbKa8LhpObJO3oo6NdF30emNB14bourtpjFPZIm/phRL2Mv6lNRRP8
 G7yfDMTiidvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="175999101"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="175999101"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:18 -0800
IronPort-SDR: yJ79O1B36TnWUtl7drVOzZFz+MfVI+WpZ2EYNR0BgAN0Urj+qMm4Z9pvhLNEkyDQFesv+bOZMD
 oOeQPI6aT8bg==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="377791926"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.37.30])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:14 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 06/23] ASoC: cx2070x: remove duplicate else branch
Date:   Fri, 12 Mar 2021 12:22:29 -0600
Message-Id: <20210312182246.5153-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/codecs/cx2072x.c:1436:10: style:inconclusive: Found
duplicate branches for 'if' and 'else'. [duplicateBranch]
  } else if (type & 0x4) {
         ^
sound/soc/codecs/cx2072x.c:1439:5: note: Found duplicate branches for
'if' and 'else'.
  } else {
    ^
sound/soc/codecs/cx2072x.c:1436:10: note: Found duplicate branches for
'if' and 'else'.
  } else if (type & 0x4) {
         ^

The last two branches do the same thing and can be collapsed together.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/cx2072x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cx2072x.c b/sound/soc/codecs/cx2072x.c
index d2d004654c9b..d924e3528029 100644
--- a/sound/soc/codecs/cx2072x.c
+++ b/sound/soc/codecs/cx2072x.c
@@ -1430,11 +1430,11 @@ static int cx2072x_jack_status_check(void *data)
 			state |= SND_JACK_HEADSET;
 			if (type & 0x2)
 				state |= SND_JACK_BTN_0;
-		} else if (type & 0x4) {
-			/* Nokia headset */
-			state |= SND_JACK_HEADPHONE;
 		} else {
-			/* Headphone */
+			/*
+			 * Nokia headset (type & 0x4) and
+			 * regular Headphone
+			 */
 			state |= SND_JACK_HEADPHONE;
 		}
 	}
-- 
2.25.1

