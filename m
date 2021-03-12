Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E403833964B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbhCLSYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:24:04 -0500
Received: from mga07.intel.com ([134.134.136.100]:4236 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233248AbhCLSXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:23:45 -0500
IronPort-SDR: CXUgadzO8bECy6dh/Kvv+dsVPWinb0U6bgROGeqB/PMHddgEtqMH1jFQlF+hXiiR5bHmQDcFsZ
 r0DHnoNFKbXw==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="252888938"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="252888938"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:45 -0800
IronPort-SDR: Qmd/PrKab4w5xZ718ans4S8x0QzbdDtmgQ4cSiMH5KAMUFVWZalveoN5EIQ1fpgV22pc84X/lt
 qIjmHRs5kEJQ==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="377792044"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.37.30])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:44 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 16/23] ASoC: pcm1681: remove useless assignment
Date:   Fri, 12 Mar 2021 12:22:39 -0600
Message-Id: <20210312182246.5153-17-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/codecs/pcm1681.c:87:8: style: Variable 'i' is assigned a
value that is never used. [unreadVariable]
 int i = 0, val = -1, enable = 0;
       ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/pcm1681.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/pcm1681.c b/sound/soc/codecs/pcm1681.c
index 07ed8fded471..5b78e9299c95 100644
--- a/sound/soc/codecs/pcm1681.c
+++ b/sound/soc/codecs/pcm1681.c
@@ -84,7 +84,7 @@ static const int pcm1681_deemph[] = { 44100, 48000, 32000 };
 static int pcm1681_set_deemph(struct snd_soc_component *component)
 {
 	struct pcm1681_private *priv = snd_soc_component_get_drvdata(component);
-	int i = 0, val = -1, enable = 0;
+	int i, val = -1, enable = 0;
 
 	if (priv->deemph) {
 		for (i = 0; i < ARRAY_SIZE(pcm1681_deemph); i++) {
-- 
2.25.1

