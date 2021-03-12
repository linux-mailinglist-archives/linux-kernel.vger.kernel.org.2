Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B197D339655
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbhCLSYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:24:36 -0500
Received: from mga07.intel.com ([134.134.136.100]:4255 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233193AbhCLSX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:23:57 -0500
IronPort-SDR: O3Q37hxT2H23KeOxGi+g2QWk/vV+4w7DUbr30dtbsLQesvBBmaGRIJRrm6jurZCH3woS3CtzUe
 sSoTEALtUgAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="252888966"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="252888966"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:56 -0800
IronPort-SDR: 6SOIPlZAxWJEsjsdY7SvKERcoUUu+c1aFiJMLRhHzkT1oGWK5AFgx60v0aiyrBWPOQYChhjLuT
 NROlmJZ+GTLQ==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="377792084"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.37.30])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:55 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Steven Eckhoff <steven.eckhoff.opensource@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 23/23] ASoC: tscs454: remove useless test on PLL disable
Date:   Fri, 12 Mar 2021 12:22:46 -0600
Message-Id: <20210312182246.5153-24-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/codecs/tscs454.c:730:37: style: Same value in both branches
of ternary operator. [duplicateValueTernary]
  val = pll1 ? FV_PLL1CLKEN_DISABLE : FV_PLL2CLKEN_DISABLE;
                                    ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/tscs454.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tscs454.c b/sound/soc/codecs/tscs454.c
index 1bafc9d1101c..43220bb36701 100644
--- a/sound/soc/codecs/tscs454.c
+++ b/sound/soc/codecs/tscs454.c
@@ -727,7 +727,12 @@ static int pll_power_event(struct snd_soc_dapm_widget *w,
 	if (enable)
 		val = pll1 ? FV_PLL1CLKEN_ENABLE : FV_PLL2CLKEN_ENABLE;
 	else
-		val = pll1 ? FV_PLL1CLKEN_DISABLE : FV_PLL2CLKEN_DISABLE;
+		/*
+		 * FV_PLL1CLKEN_DISABLE and FV_PLL2CLKEN_DISABLE are
+		 * identical zero vzalues, there is no need to test
+		 * the PLL index
+		 */
+		val = FV_PLL1CLKEN_DISABLE;
 
 	ret = snd_soc_component_update_bits(component, R_PLLCTL, msk, val);
 	if (ret < 0) {
-- 
2.25.1

