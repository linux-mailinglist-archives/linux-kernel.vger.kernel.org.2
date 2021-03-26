Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E458334B1B9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 23:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhCZWA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 18:00:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:61331 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230434AbhCZWAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 18:00:22 -0400
IronPort-SDR: QCw3nodFE7WYyl0all2SqNhdlXV67829d1I/CiMJ7+BicveP/xMdHbxrKLAgI5za667ewOVBP3
 hHT4BHaKHlGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="188957180"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="188957180"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 15:00:22 -0700
IronPort-SDR: TAEzOSPlq0akXNPZ3/hxP65If8aqxKNJaLEf/9qsa7edgVEr+XdS8yIVjvwp2y6e5VUN31X0Dy
 8SqYBhpssjtA==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="416706970"
Received: from zcmahone-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.255.231.203])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 15:00:21 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 17/17] ASoC: ux500: mop500: align function prototype
Date:   Fri, 26 Mar 2021 16:59:27 -0500
Message-Id: <20210326215927.936377-18-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
References: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/ux500/mop500_ab8500.c:360:60: style:inconclusive: Function
'mop500_ab8500_machine_init' argument 1 names different: declaration
'runtime' definition 'rtd'. [funcArgNamesDifferent]

int mop500_ab8500_machine_init(struct snd_soc_pcm_runtime *rtd)
                                                           ^
sound/soc/ux500/mop500_ab8500.h:16:60: note: Function
'mop500_ab8500_machine_init' argument 1 names different: declaration
'runtime' definition 'rtd'.
int mop500_ab8500_machine_init(struct snd_soc_pcm_runtime *runtime);
                                                           ^
sound/soc/ux500/mop500_ab8500.c:360:60: note: Function
'mop500_ab8500_machine_init' argument 1 names different: declaration
'runtime' definition 'rtd'.
int mop500_ab8500_machine_init(struct snd_soc_pcm_runtime *rtd)
                                                           ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/ux500/mop500_ab8500.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/ux500/mop500_ab8500.h b/sound/soc/ux500/mop500_ab8500.h
index 99cfd972ea7a..8138a4e9aaf5 100644
--- a/sound/soc/ux500/mop500_ab8500.h
+++ b/sound/soc/ux500/mop500_ab8500.h
@@ -13,7 +13,7 @@
 
 extern struct snd_soc_ops mop500_ab8500_ops[];
 
-int mop500_ab8500_machine_init(struct snd_soc_pcm_runtime *runtime);
+int mop500_ab8500_machine_init(struct snd_soc_pcm_runtime *rtd);
 void mop500_ab8500_remove(struct snd_soc_card *card);
 
 #endif
-- 
2.25.1

