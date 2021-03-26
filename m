Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D98D34B1B1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 23:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhCZWAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 18:00:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:61331 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230292AbhCZWAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 18:00:07 -0400
IronPort-SDR: PnDAFp4cyGwBfJoJOe4XzEToINEnZeGSWC6FTtIbwa9JGBdj78AtKwL3QiRtd/FxoVinROAXs6
 zAeWk5uzdVTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="188957089"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="188957089"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 15:00:07 -0700
IronPort-SDR: pN/1xZugGRK4FmXCaX5DbIjro6qYN2CO3AN2B868fvbV9d9cuop8ag3Jy2dcFwhpH6hDq9Qnzv
 Ftj5AihvMCDQ==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="416706816"
Received: from zcmahone-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.255.231.203])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 15:00:06 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 09/17] ASoC: sti: uniperif: align function prototypes
Date:   Fri, 26 Mar 2021 16:59:19 -0500
Message-Id: <20210326215927.936377-10-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
References: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/sti/uniperif_player.c:1049:24: style:inconclusive: Function
'uni_player_init' argument 2 names different: declaration 'uni_player'
definition 'player'. [funcArgNamesDifferent]
      struct uniperif *player)
                       ^
sound/soc/sti/uniperif.h:1375:24: note: Function 'uni_player_init'
argument 2 names different: declaration 'uni_player' definition
'player'.
      struct uniperif *uni_player);
                       ^
sound/soc/sti/uniperif_player.c:1049:24: note: Function
'uni_player_init' argument 2 names different: declaration 'uni_player'
definition 'player'.
      struct uniperif *player)
                       ^
sound/soc/sti/uniperif_reader.c:411:24: style:inconclusive: Function
'uni_reader_init' argument 2 names different: declaration 'uni_reader'
definition 'reader'. [funcArgNamesDifferent]
      struct uniperif *reader)
                       ^
sound/soc/sti/uniperif.h:1380:24: note: Function 'uni_reader_init'
argument 2 names different: declaration 'uni_reader' definition
'reader'.
      struct uniperif *uni_reader);
                       ^
sound/soc/sti/uniperif_reader.c:411:24: note: Function
'uni_reader_init' argument 2 names different: declaration 'uni_reader'
definition 'reader'.
      struct uniperif *reader)
                       ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sti/uniperif.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
index a16adeb7c1e9..2a5de328501c 100644
--- a/sound/soc/sti/uniperif.h
+++ b/sound/soc/sti/uniperif.h
@@ -1372,12 +1372,12 @@ static __maybe_unused const struct snd_pcm_hardware uni_tdm_hw = {
 
 /* uniperiph player*/
 int uni_player_init(struct platform_device *pdev,
-		    struct uniperif *uni_player);
+		    struct uniperif *player);
 int uni_player_resume(struct uniperif *player);
 
 /* uniperiph reader */
 int uni_reader_init(struct platform_device *pdev,
-		    struct uniperif *uni_reader);
+		    struct uniperif *reader);
 
 /* common */
 int sti_uniperiph_dai_set_fmt(struct snd_soc_dai *dai,
-- 
2.25.1

