Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A18339651
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbhCLSY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:24:29 -0500
Received: from mga07.intel.com ([134.134.136.100]:4236 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233265AbhCLSXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:23:50 -0500
IronPort-SDR: 7IRRpOqPL/bk7xkx1X1wBRR/PPMYeiziceHm7RarHsuoW5EQzDzmYpxKuwYpg9sq6lLPZC+kvC
 KlhtWc8Lo+IQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="252888948"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="252888948"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:50 -0800
IronPort-SDR: 54u62mvE4uW4wS6G4ftoPq0ntq/SJ548ytmfzyLNWx9vvVPDlgz+rU4A3yT1CKwqUK2lUUXzUl
 iKHNULZDCLYg==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="377792057"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.37.30])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:49 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Dan Murphy <dmurphy@ti.com>,
        Jonghwan Choi <charlie.jh@kakaocorp.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 19/23] ASoC: tas2562: remove useless assignment
Date:   Fri, 12 Mar 2021 12:22:42 -0600
Message-Id: <20210312182246.5153-20-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck throws a warning:

sound/soc/codecs/tas2562.c:203:4: style: Assignment of function
parameter has no effect outside the function. [uselessAssignmentArg]
   tx_mask &= ~(1 << right_slot);
   ^

This assignment seems to come from a copy/paste but the value is
indeed not used. Let's remove it.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/tas2562.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index 19965fabe949..ba23f9f07f04 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -200,7 +200,6 @@ static int tas2562_set_dai_tdm_slot(struct snd_soc_dai *dai,
 			right_slot = left_slot;
 		} else {
 			right_slot = __ffs(tx_mask);
-			tx_mask &= ~(1 << right_slot);
 		}
 	}
 
-- 
2.25.1

