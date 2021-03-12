Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B036339653
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbhCLSYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:24:34 -0500
Received: from mga07.intel.com ([134.134.136.100]:4253 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233338AbhCLSX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:23:56 -0500
IronPort-SDR: w13FiDNOJMJgKts56c6ehZmCNYzg+YdetPL53jxCXD3HvIL8WM9QpbUKzVrayyPBBZN/QS+uLf
 iXVknRMkiIIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="252888963"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="252888963"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:55 -0800
IronPort-SDR: cb+1+bNNeKKmvFm81wcWOjv/cH+gGygnh4UXRZbh1T9j2xErmsG0AsXXlVl3UEskXuawC8/QII
 OsLRmqz+weRQ==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="377792078"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.37.30])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:54 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: [PATCH 22/23] ASoC: tlv320dac33: clarify expression
Date:   Fri, 12 Mar 2021 12:22:45 -0600
Message-Id: <20210312182246.5153-23-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/codecs/tlv320dac33.c:1074:43: style: Clarify calculation
precedence for '%' and '?'. [clarifyCalculation]
    (dac33->alarm_threshold % period_size ?
                                          ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/tlv320dac33.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index d905e03aaec7..48572d66cb3b 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -1071,7 +1071,7 @@ static void dac33_calculate_times(struct snd_pcm_substream *substream,
 			 */
 			dac33->nsample = period_size *
 				((dac33->alarm_threshold / period_size) +
-				(dac33->alarm_threshold % period_size ?
+				 ((dac33->alarm_threshold % period_size) ?
 				1 : 0));
 		else if (period_size > nsample_limit)
 			dac33->nsample = nsample_limit;
-- 
2.25.1

