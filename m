Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9875134B1B8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 23:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhCZWAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 18:00:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:61331 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230423AbhCZWAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 18:00:21 -0400
IronPort-SDR: 8WnpBTVAzRxOaENDqStrFkD0KijHhNKAKYIfJ+QNlV+KIHa4cjaafWWhPlTHwvpz7ZkPdx+PZh
 +zlnQDJKsB/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="188957173"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="188957173"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 15:00:20 -0700
IronPort-SDR: nPJ8jPadMkVbnv7xLbDyKf9HG38G13QAZWtGuntDeJsDiX+xso8g0kvCTDrgIjKW4N4XYVcpI6
 /MGS1CplOobA==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="416706959"
Received: from zcmahone-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.255.231.203])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 15:00:19 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 16/17] ASoC: ux500: mop500: rename shadowing variable
Date:   Fri, 26 Mar 2021 16:59:26 -0500
Message-Id: <20210326215927.936377-17-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
References: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/ux500/mop500.c:143:23: style: Local variable 'mop500_card'
shadows outer variable [shadowVariable]

 struct snd_soc_card *mop500_card = platform_get_drvdata(pdev);
                      ^
sound/soc/ux500/mop500.c:54:28: note: Shadowed declaration
static struct snd_soc_card mop500_card = {
                           ^
sound/soc/ux500/mop500.c:143:23: note: Shadow variable
 struct snd_soc_card *mop500_card = platform_get_drvdata(pdev);
                      ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/ux500/mop500.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
index cdae1190b930..4f41bb0ab2b0 100644
--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -140,12 +140,12 @@ static int mop500_probe(struct platform_device *pdev)
 
 static int mop500_remove(struct platform_device *pdev)
 {
-	struct snd_soc_card *mop500_card = platform_get_drvdata(pdev);
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
 	pr_debug("%s: Enter.\n", __func__);
 
-	snd_soc_unregister_card(mop500_card);
-	mop500_ab8500_remove(mop500_card);
+	snd_soc_unregister_card(card);
+	mop500_ab8500_remove(card);
 	mop500_of_node_put();
 
 	return 0;
-- 
2.25.1

