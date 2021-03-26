Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3B734B210
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 23:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhCZWRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 18:17:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:43717 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229969AbhCZWQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 18:16:35 -0400
IronPort-SDR: aQH0M59JI1FUUfvNvm/qQIZqkX64B3YDp9TITkrZ1pHlXLAjkXMGbuaBJwvv1DcRl7sgQLNiXA
 9RaCMJWR4QCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="252579027"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="252579027"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 15:16:35 -0700
IronPort-SDR: 34QJdPUncT96lUQIYIzihS44wToWZicF1nK572qYaqKj6FzzfNSXbRJ0+hj6A9OaazW9HTHrfV
 ze6P0bviXeHg==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="416713337"
Received: from schine-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.213.191.61])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 15:16:34 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        M R Swami Reddy <mr.swami.reddy@ti.com>,
        Vishwas A Deshpande <vishwas.a.deshpande@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [RFC PATCH 1/2] ASoC: lm49453: fix useless assignment before return
Date:   Fri, 26 Mar 2021 17:16:18 -0500
Message-Id: <20210326221619.949961-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326221619.949961-1-pierre-louis.bossart@linux.intel.com>
References: <20210326221619.949961-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cppcheck warning:

sound/soc/codecs/lm49453.c:1210:11: style: Variable 'pll_clk' is
assigned a value that is never used. [unreadVariable]

  pll_clk = BIT(4);
          ^

FIXME: What is the correct fix?
	/* fll clk slection */
	pll_clk = BIT(4);
	return 0;

is the assignment redundant or the 'return 0' a mistake?

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/lm49453.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/lm49453.c b/sound/soc/codecs/lm49453.c
index eb3dd0bd80d9..fb0fb23537e7 100644
--- a/sound/soc/codecs/lm49453.c
+++ b/sound/soc/codecs/lm49453.c
@@ -1206,8 +1206,6 @@ static int lm49453_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 		break;
 	case 48000:
 	case 32576:
-		/* fll clk slection */
-		pll_clk = BIT(4);
 		return 0;
 	default:
 		return -EINVAL;
-- 
2.25.1

