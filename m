Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA9F34B1A4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 23:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhCZWAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 18:00:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:61331 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229986AbhCZV74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 17:59:56 -0400
IronPort-SDR: UhI1LVE7DV7ffRdZkLSTvsqhpnc/mclpfYiZ+d9S9JXUmTglTYXs/cLYwKfLlvd7D4W53MsaGV
 PjuahNSxYSFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="188957049"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="188957049"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 14:59:55 -0700
IronPort-SDR: E1QfgjgQw2m1lH8XameoimNYsq2MdB6pLPQThMcCx6idS3GSO/WYdM8tG1Onua6FDLsW3mfSVo
 +zMipEVbq3OA==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="416706677"
Received: from zcmahone-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.255.231.203])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 14:59:54 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip
        (AT91) SoC support)
Subject: [PATCH 02/17] ASoC: atmel: fix shadowed variable
Date:   Fri, 26 Mar 2021 16:59:12 -0500
Message-Id: <20210326215927.936377-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
References: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix cppcheck warning:

sound/soc/atmel/atmel-classd.c:51:14: style: Local variable 'pwm_type'
shadows outer variable [shadowVariable]
 const char *pwm_type;
             ^
sound/soc/atmel/atmel-classd.c:226:27: note: Shadowed declaration
static const char * const pwm_type[] = {
                          ^
sound/soc/atmel/atmel-classd.c:51:14: note: Shadow variable
 const char *pwm_type;
             ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/atmel/atmel-classd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/atmel/atmel-classd.c b/sound/soc/atmel/atmel-classd.c
index b1a28a9382fb..6023369e0f1a 100644
--- a/sound/soc/atmel/atmel-classd.c
+++ b/sound/soc/atmel/atmel-classd.c
@@ -48,7 +48,7 @@ static struct atmel_classd_pdata *atmel_classd_dt_init(struct device *dev)
 {
 	struct device_node *np = dev->of_node;
 	struct atmel_classd_pdata *pdata;
-	const char *pwm_type;
+	const char *pwm_type_s;
 	int ret;
 
 	if (!np) {
@@ -60,8 +60,8 @@ static struct atmel_classd_pdata *atmel_classd_dt_init(struct device *dev)
 	if (!pdata)
 		return ERR_PTR(-ENOMEM);
 
-	ret = of_property_read_string(np, "atmel,pwm-type", &pwm_type);
-	if ((ret == 0) && (strcmp(pwm_type, "diff") == 0))
+	ret = of_property_read_string(np, "atmel,pwm-type", &pwm_type_s);
+	if ((ret == 0) && (strcmp(pwm_type_s, "diff") == 0))
 		pdata->pwm_type = CLASSD_MR_PWMTYP_DIFF;
 	else
 		pdata->pwm_type = CLASSD_MR_PWMTYP_SINGLE;
-- 
2.25.1

