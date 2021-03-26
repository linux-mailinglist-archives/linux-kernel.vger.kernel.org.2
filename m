Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7632E34B212
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 23:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhCZWRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 18:17:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:43717 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230210AbhCZWQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 18:16:36 -0400
IronPort-SDR: qKWkyWAXhg4093nPwqwlaM/JMo6KUjgRA5rIgO5NOBCKA55FluIwHx6yo4ZnnyZ478XZuOALZn
 mIivPlhTkPhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="252579029"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="252579029"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 15:16:36 -0700
IronPort-SDR: rf9cWzdhKcHZl+TH/NnOt6tMUAnK5pJuQGwApQffEOoS0HKLrOjwcHsf/iv2gmxopmX/gqE7in
 BcroMX2D9dMw==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="416713352"
Received: from schine-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.213.191.61])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 15:16:35 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [RFC PATCH 2/2] ASoC: da732x: simplify code
Date:   Fri, 26 Mar 2021 17:16:19 -0500
Message-Id: <20210326221619.949961-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326221619.949961-1-pierre-louis.bossart@linux.intel.com>
References: <20210326221619.949961-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck reports a false positive:

sound/soc/codecs/da732x.c:1161:25: warning: Either the condition
'indiv<0' is redundant or there is division by zero at line
1161. [zerodivcond]
 fref = (da732x->sysclk / indiv);
                        ^
sound/soc/codecs/da732x.c:1158:12: note: Assuming that condition
'indiv<0' is not redundant
 if (indiv < 0)
           ^
sound/soc/codecs/da732x.c:1161:25: note: Division by zero
 fref = (da732x->sysclk / indiv);
                        ^

The code is awfully convoluted/confusing and can be simplified with a
single variable and the BIT macro.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/da732x.c | 17 ++++++-----------
 sound/soc/codecs/da732x.h | 12 ++++--------
 2 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/da732x.c b/sound/soc/codecs/da732x.c
index d43ee7159ae0..42d6a3fc3af5 100644
--- a/sound/soc/codecs/da732x.c
+++ b/sound/soc/codecs/da732x.c
@@ -168,30 +168,25 @@ static const struct reg_default da732x_reg_cache[] = {
 static inline int da732x_get_input_div(struct snd_soc_component *component, int sysclk)
 {
 	int val;
-	int ret;
 
 	if (sysclk < DA732X_MCLK_10MHZ) {
-		val = DA732X_MCLK_RET_0_10MHZ;
-		ret = DA732X_MCLK_VAL_0_10MHZ;
+		val = DA732X_MCLK_VAL_0_10MHZ;
 	} else if ((sysclk >= DA732X_MCLK_10MHZ) &&
 	    (sysclk < DA732X_MCLK_20MHZ)) {
-		val = DA732X_MCLK_RET_10_20MHZ;
-		ret = DA732X_MCLK_VAL_10_20MHZ;
+		val = DA732X_MCLK_VAL_10_20MHZ;
 	} else if ((sysclk >= DA732X_MCLK_20MHZ) &&
 	    (sysclk < DA732X_MCLK_40MHZ)) {
-		val = DA732X_MCLK_RET_20_40MHZ;
-		ret = DA732X_MCLK_VAL_20_40MHZ;
+		val = DA732X_MCLK_VAL_20_40MHZ;
 	} else if ((sysclk >= DA732X_MCLK_40MHZ) &&
 	    (sysclk <= DA732X_MCLK_54MHZ)) {
-		val = DA732X_MCLK_RET_40_54MHZ;
-		ret = DA732X_MCLK_VAL_40_54MHZ;
+		val = DA732X_MCLK_VAL_40_54MHZ;
 	} else {
 		return -EINVAL;
 	}
 
 	snd_soc_component_write(component, DA732X_REG_PLL_CTRL, val);
 
-	return ret;
+	return val;
 }
 
 static void da732x_set_charge_pump(struct snd_soc_component *component, int state)
@@ -1158,7 +1153,7 @@ static int da732x_set_dai_pll(struct snd_soc_component *component, int pll_id,
 	if (indiv < 0)
 		return indiv;
 
-	fref = (da732x->sysclk / indiv);
+	fref = da732x->sysclk / BIT(indiv);
 	div_hi = freq_out / fref;
 	frac_div = (u64)(freq_out % fref) * 8192ULL;
 	do_div(frac_div, fref);
diff --git a/sound/soc/codecs/da732x.h b/sound/soc/codecs/da732x.h
index c5af17ee1516..c2f784c3f359 100644
--- a/sound/soc/codecs/da732x.h
+++ b/sound/soc/codecs/da732x.h
@@ -48,14 +48,10 @@
 #define	DA732X_MCLK_20MHZ		20000000
 #define	DA732X_MCLK_40MHZ		40000000
 #define	DA732X_MCLK_54MHZ		54000000
-#define	DA732X_MCLK_RET_0_10MHZ		0
-#define	DA732X_MCLK_VAL_0_10MHZ		1
-#define	DA732X_MCLK_RET_10_20MHZ	1
-#define	DA732X_MCLK_VAL_10_20MHZ	2
-#define	DA732X_MCLK_RET_20_40MHZ	2
-#define	DA732X_MCLK_VAL_20_40MHZ	4
-#define	DA732X_MCLK_RET_40_54MHZ	3
-#define	DA732X_MCLK_VAL_40_54MHZ	8
+#define	DA732X_MCLK_VAL_0_10MHZ		0
+#define	DA732X_MCLK_VAL_10_20MHZ	1
+#define	DA732X_MCLK_VAL_20_40MHZ	2
+#define	DA732X_MCLK_VAL_40_54MHZ	3
 #define	DA732X_DAI_ID1			0
 #define	DA732X_DAI_ID2			1
 #define	DA732X_SRCCLK_PLL		0
-- 
2.25.1

