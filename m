Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C308F339642
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhCLSXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:23:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:36936 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233134AbhCLSXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:23:19 -0500
IronPort-SDR: Raee1t6iXiJ3ZkMQkugpCSpwQgNBu/JZmxly74RZGkrw+qu/AQBjfNZgNoyUwfxibY+ngPvwbC
 zvOCTh1vyGtw==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="175999105"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="175999105"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:19 -0800
IronPort-SDR: lzN1KljaGYYjbG1Oo2IpFujU1ijS7jTgsFBUG2pNEQ3BVCmRNUXpt2cdgFd+LdC8sbakb1d0jH
 u+jq1nOudkmg==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="377791933"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.37.30])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:18 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 07/23] ASoC: da7219-aad: remove useless initialization
Date:   Fri, 12 Mar 2021 12:22:30 -0600
Message-Id: <20210312182246.5153-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/codecs/da7219-aad.c:118:22: style: Variable 'ret' is
assigned a value that is never used. [unreadVariable]
 int report = 0, ret = 0;
                     ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/da7219-aad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index 48081d71c22c..7998fdd3b378 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -115,7 +115,7 @@ static void da7219_aad_hptest_work(struct work_struct *work)
 
 	__le16 tonegen_freq_hptest;
 	u8 pll_srm_sts, pll_ctrl, gain_ramp_ctrl, accdet_cfg8;
-	int report = 0, ret = 0;
+	int report = 0, ret;
 
 	/* Lock DAPM, Kcontrols affected by this test and the PLL */
 	snd_soc_dapm_mutex_lock(dapm);
-- 
2.25.1

