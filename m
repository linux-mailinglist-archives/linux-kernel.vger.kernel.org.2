Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663C0339654
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbhCLSYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:24:35 -0500
Received: from mga07.intel.com ([134.134.136.100]:4236 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233331AbhCLSXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:23:54 -0500
IronPort-SDR: k5F9+Xg4eF56hgdUnEsT0yAOXv+ha0zaD/DaZYK6ezKucf4Ewy+d15FpMVvcgxrrcyYPFdzHvr
 9PraJ+l0WZdQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="252888960"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="252888960"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:54 -0800
IronPort-SDR: E9O7IV7e7ub5dVrwkwUzmXCJw+SM4r+726+8r+foHL37Ll8I6AVOHSBQi42ZZKtGSx/3m1HCG3
 VeYIKmbzE2UA==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="377792069"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.37.30])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:52 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Dan Murphy <dmurphy@ti.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH 21/23] ASoC: tas2770: remove useless initialization
Date:   Fri, 12 Mar 2021 12:22:44 -0600
Message-Id: <20210312182246.5153-22-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/codecs/tas2770.c:109:10: style: Variable 'ret' is assigned a
value that is never used. [unreadVariable]
 int ret = 0;
         ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/tas2770.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 15fca5109e14..781bf9cc4faa 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -106,7 +106,7 @@ static int tas2770_codec_suspend(struct snd_soc_component *component)
 static int tas2770_codec_resume(struct snd_soc_component *component)
 {
 	struct tas2770_priv *tas2770 = snd_soc_component_get_drvdata(component);
-	int ret = 0;
+	int ret;
 
 	if (tas2770->sdz_gpio) {
 		gpiod_set_value_cansleep(tas2770->sdz_gpio, 1);
-- 
2.25.1

