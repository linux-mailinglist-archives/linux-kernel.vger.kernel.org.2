Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A291339647
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbhCLSYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:24:00 -0500
Received: from mga02.intel.com ([134.134.136.20]:36942 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232255AbhCLSXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:23:30 -0500
IronPort-SDR: TCsUCdpKL/KMxrTNcM9F2o0l9krgVqfWqaHEPpbvNfnKHb9Fe535Y+moHVOUlGpINFORpb4GEf
 wu74CKthSqcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="175999133"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="175999133"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:29 -0800
IronPort-SDR: PIY0q2vSlc4LCYnkXD6p76ix5kuPwdko3K3KL5zxMrAyi0CtIAwocPC5liOp82yYpX+75AUSML
 mrNCB0Fndrsw==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="377791975"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.37.30])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:28 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 12/23] ASoC: max98090: remove useless assignment
Date:   Fri, 12 Mar 2021 12:22:35 -0600
Message-Id: <20210312182246.5153-13-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/codecs/max98090.c:1835:16: style: Variable 'test_diff' is
assigned a value that is never used. [unreadVariable]
 int test_diff = INT_MAX;
               ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/max98090.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 06276ff5f8a3..bc30a1dc7530 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -1832,7 +1832,7 @@ static const struct dmic_table dmic_table[] = { /* One for each pclk freq. */
 static int max98090_find_divisor(int target_freq, int pclk)
 {
 	int current_diff = INT_MAX;
-	int test_diff = INT_MAX;
+	int test_diff;
 	int divisor_index = 0;
 	int i;
 
-- 
2.25.1

