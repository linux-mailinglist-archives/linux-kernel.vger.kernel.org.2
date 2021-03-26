Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E4134B1B4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 23:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhCZWAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 18:00:50 -0400
Received: from mga04.intel.com ([192.55.52.120]:61331 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230363AbhCZWAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 18:00:11 -0400
IronPort-SDR: U+fJW4g7LTZLd28DuNmt4lZlc37JRHZG/Yv/BXp9+eWGCRESrjWiJeGYvhGuKS5IQMZZpG7j6c
 UTrB0gQApAnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="188957119"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="188957119"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 15:00:11 -0700
IronPort-SDR: Kd1I434yTkLH637JLQVyyM35CrcQFJ4t6dh3hzI2PrFA8z+j0URTOizazVklMi2PFM0tl3NGir
 XvqBkBjvY/aQ==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="416706860"
Received: from zcmahone-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.255.231.203])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 15:00:10 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support)
Subject: [PATCH 11/17] ASoC: sunxi: sun8i-codec: clarify expression
Date:   Fri, 26 Mar 2021 16:59:21 -0500
Message-Id: <20210326215927.936377-12-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
References: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/sunxi/sun8i-codec.c:488:28: style: Clarify calculation
precedence for '%' and '?'. [clarifyCalculation]
 return sample_rate % 4000 ? 22579200 : 24576000;
                           ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sunxi/sun8i-codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 460924fc173f..518bfb724a5b 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -485,7 +485,7 @@ static int sun8i_codec_get_lrck_div_order(unsigned int slots,
 
 static unsigned int sun8i_codec_get_sysclk_rate(unsigned int sample_rate)
 {
-	return sample_rate % 4000 ? 22579200 : 24576000;
+	return (sample_rate % 4000) ? 22579200 : 24576000;
 }
 
 static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
-- 
2.25.1

