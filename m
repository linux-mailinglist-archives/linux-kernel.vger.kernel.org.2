Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBA433963E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhCLSXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:23:24 -0500
Received: from mga02.intel.com ([134.134.136.20]:36926 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231906AbhCLSXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:23:14 -0500
IronPort-SDR: zkA+pTH2tXQx6pTwxX1DIbRiKKm+viqAjvdN1l8eij9DN4HGoAJNWUcbnJNeQN2KRkFFVTYLNU
 HRHLboI7eaHw==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="175999094"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="175999094"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:13 -0800
IronPort-SDR: QqSJl6GqR83C0e1V9F0rNWXneiMt4IABHFnIUl5YH3DYsIw/OIfDhsvJtSC6hWb0VEFFffamOJ
 OdqkXBbqKPpA==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="377791918"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.37.30])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:12 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 05/23] ASoC: cx2070x: remove useless assignment
Date:   Fri, 12 Mar 2021 12:22:28 -0600
Message-Id: <20210312182246.5153-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cppcheck warning:

sound/soc/codecs/cx2072x.c:830:26: style: Variable
'reg1.r.rx_data_one_line' is reassigned a value before the old one has
been used. [redundantAssignment]

 reg1.r.rx_data_one_line = 1;
                         ^

sound/soc/codecs/cx2072x.c:782:26: note: reg1.r.rx_data_one_line is
assigned
 reg1.r.rx_data_one_line = 1;
                         ^

sound/soc/codecs/cx2072x.c:830:26: note: reg1.r.rx_data_one_line is
overwritten
 reg1.r.rx_data_one_line = 1;
                         ^

sound/soc/codecs/cx2072x.c:831:26: style: Variable
'reg1.r.tx_data_one_line' is reassigned a value before the old one has
been used. [redundantAssignment]
 reg1.r.tx_data_one_line = 1;
                         ^
sound/soc/codecs/cx2072x.c:783:26: note: reg1.r.tx_data_one_line is
assigned
 reg1.r.tx_data_one_line = 1;
                         ^

sound/soc/codecs/cx2072x.c:831:26: note: reg1.r.tx_data_one_line is
overwritten
 reg1.r.tx_data_one_line = 1;
                         ^

Likely copy/paste.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/cx2072x.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/cx2072x.c b/sound/soc/codecs/cx2072x.c
index 8ab22815c2c9..d2d004654c9b 100644
--- a/sound/soc/codecs/cx2072x.c
+++ b/sound/soc/codecs/cx2072x.c
@@ -827,9 +827,6 @@ static int cx2072x_config_i2spcm(struct cx2072x_priv *cx2072x)
 	}
 	regdbt2.r.i2s_bclk_invert = is_bclk_inv;
 
-	reg1.r.rx_data_one_line = 1;
-	reg1.r.tx_data_one_line = 1;
-
 	/* Configures the BCLK output */
 	bclk_rate = cx2072x->sample_rate * frame_len;
 	reg5.r.i2s_pcm_clk_div_chan_en = 0;
-- 
2.25.1

