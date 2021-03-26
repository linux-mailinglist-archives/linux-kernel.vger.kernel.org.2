Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E5534B1B2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 23:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhCZWAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 18:00:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:61331 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230347AbhCZWAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 18:00:09 -0400
IronPort-SDR: ZGFxeqaQ6RBAigXInpCD7Uwhy9zbdh6xFq67vXvdiDO+jjR5GfqxywGRBMpKnsMlIVhplc2fAx
 EmY3SLIshxYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="188957093"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="188957093"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 15:00:09 -0700
IronPort-SDR: CzeTxe0xAsNYaajyRxXKP2vOoum6MEbKQdiHKYSUG2P2g6L9+x50WpB4rDhgJKJfOR1gxYDezG
 0sb/3cg5pXZw==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="416706835"
Received: from zcmahone-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.255.231.203])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 15:00:07 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32
        ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32
        ARCHITECTURE)
Subject: [PATCH 10/17] ASoC: stm: stm32_adfsdm: fix snprintf format string
Date:   Fri, 26 Mar 2021 16:59:20 -0500
Message-Id: <20210326215927.936377-11-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
References: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/stm/stm32_adfsdm.c:120:2: warning: %d in format
string (no. 1) requires 'int' but the argument type is 'unsigned
int'. [invalidPrintfArgType_sint]
 snprintf(str_freq, sizeof(str_freq), "%d\n", freq);
 ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/stm/stm32_adfsdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index 47fae8dd20b4..e6078f50e508 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -117,7 +117,7 @@ static int stm32_adfsdm_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 
 	/* Set IIO frequency if CODEC is master as clock comes from SPI_IN */
 
-	snprintf(str_freq, sizeof(str_freq), "%d\n", freq);
+	snprintf(str_freq, sizeof(str_freq), "%u\n", freq);
 	size = iio_write_channel_ext_info(priv->iio_ch, "spi_clk_freq",
 					  str_freq, sizeof(str_freq));
 	if (size != sizeof(str_freq)) {
-- 
2.25.1

