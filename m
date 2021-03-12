Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25589339649
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbhCLSYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:24:01 -0500
Received: from mga02.intel.com ([134.134.136.20]:36942 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233237AbhCLSXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:23:32 -0500
IronPort-SDR: LotSCT04Fn6C093kddesGepcMAlnnGeu1yNNy2GyctWYaXg9R8ywnMn4GPiuQRE7XwXYpya6SP
 t23q78sOtklw==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="175999140"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="175999140"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:31 -0800
IronPort-SDR: vMplSHCv5mEPnukrrcRjc6KXfk6xTNUJu0wfzFooCUTKsGxGuahYFdqJAT5LRASrP2xONMgZmx
 2otk2ZRhRGCg==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="377791990"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.37.30])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:30 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH 13/23] ASoC: mt6358: remove useless initializations
Date:   Fri, 12 Mar 2021 12:22:36 -0600
Message-Id: <20210312182246.5153-14-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warnings:

sound/soc/codecs/mt6358.c:334:19: style: Variable 'stage' is assigned
a value that is never used. [unreadVariable]
 int i = 0, stage = 0;
                  ^
sound/soc/codecs/mt6358.c:350:19: style: Variable 'stage' is assigned
a value that is never used. [unreadVariable]
 int i = 0, stage = 0;
                  ^
185/930 files checked 25% done
Checking sound/soc/codecs/mt6359.c ...
sound/soc/codecs/mt6359.c:274:8: style: Variable 'i' is assigned a
value that is never used. [unreadVariable]
 int i = 0, stage = 0;
       ^
sound/soc/codecs/mt6359.c:274:19: style: Variable 'stage' is assigned
a value that is never used. [unreadVariable]
 int i = 0, stage = 0;
                  ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/mt6358.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/mt6358.c b/sound/soc/codecs/mt6358.c
index 1f39d5998cf6..9b263a9a669d 100644
--- a/sound/soc/codecs/mt6358.c
+++ b/sound/soc/codecs/mt6358.c
@@ -331,7 +331,7 @@ static void hp_zcd_disable(struct mt6358_priv *priv)
 
 static void hp_main_output_ramp(struct mt6358_priv *priv, bool up)
 {
-	int i = 0, stage = 0;
+	int i, stage;
 	int target = 7;
 
 	/* Enable/Reduce HPL/R main output stage step by step */
@@ -347,7 +347,7 @@ static void hp_main_output_ramp(struct mt6358_priv *priv, bool up)
 
 static void hp_aux_feedback_loop_gain_ramp(struct mt6358_priv *priv, bool up)
 {
-	int i = 0, stage = 0;
+	int i, stage;
 
 	/* Reduce HP aux feedback loop gain step by step */
 	for (i = 0; i <= 0xf; i++) {
-- 
2.25.1

