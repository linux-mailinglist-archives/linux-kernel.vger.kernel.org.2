Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CFF339648
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbhCLSYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:24:02 -0500
Received: from mga07.intel.com ([134.134.136.100]:4236 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233242AbhCLSXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:23:42 -0500
IronPort-SDR: Hq87hztx/troOAC7i6j+X6EtLIf36nCT2ImetOImKtiLVnvybp7rgAC51JG1mN9u4rJYw47naf
 q0SSOC+SnsNQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="252888932"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="252888932"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:41 -0800
IronPort-SDR: zMCw97GH6dLD/FJCGWKbL2HpR1ng+Fqi3/2gHxr0gMkZi0Uhx1VM8ZHR0vdlLzEbogTEVrSA4q
 ei0xbHGtahGw==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="377792038"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.37.30])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:40 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        "Shane.Chien" <shane.chien@mediatek.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH 14/23] ASoC: mt6359: remove useless assignment
Date:   Fri, 12 Mar 2021 12:22:37 -0600
Message-Id: <20210312182246.5153-15-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/codecs/mt6359.c:242:19: style: Variable 'stage' is assigned a value that is never used. [unreadVariable]
 int i = 0, stage = 0;
                  ^
sound/soc/codecs/mt6359.c:260:19: style: Variable 'stage' is assigned a value that is never used. [unreadVariable]
 int i = 0, stage = 0;
                  ^
sound/soc/codecs/mt6359.c:274:8: style: Variable 'i' is assigned a value that is never used. [unreadVariable]
 int i = 0, stage = 0;
       ^
sound/soc/codecs/mt6359.c:274:19: style: Variable 'stage' is assigned a value that is never used. [unreadVariable]
 int i = 0, stage = 0;
                  ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/mt6359.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/mt6359.c b/sound/soc/codecs/mt6359.c
index 6f4b1da52082..b909b36582b7 100644
--- a/sound/soc/codecs/mt6359.c
+++ b/sound/soc/codecs/mt6359.c
@@ -239,7 +239,7 @@ static void zcd_disable(struct mt6359_priv *priv)
 
 static void hp_main_output_ramp(struct mt6359_priv *priv, bool up)
 {
-	int i = 0, stage = 0;
+	int i, stage;
 	int target = 7;
 
 	/* Enable/Reduce HPL/R main output stage step by step */
@@ -257,7 +257,7 @@ static void hp_main_output_ramp(struct mt6359_priv *priv, bool up)
 
 static void hp_aux_feedback_loop_gain_ramp(struct mt6359_priv *priv, bool up)
 {
-	int i = 0, stage = 0;
+	int i, stage;
 	int target = 0xf;
 
 	/* Enable/Reduce HP aux feedback loop gain step by step */
-- 
2.25.1

