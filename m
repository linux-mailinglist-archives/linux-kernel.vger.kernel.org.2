Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BE534B1A6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 23:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhCZWAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 18:00:09 -0400
Received: from mga04.intel.com ([192.55.52.120]:61331 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230027AbhCZWAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 18:00:00 -0400
IronPort-SDR: gFf/czvSbQtD6QfpaYPn5OKgnDGaywzu9MF1UaGF/4QfBBbwin4386kNvrOAosqQO5lre5nWLn
 7KVgbE55oOng==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="188957067"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="188957067"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 14:59:59 -0700
IronPort-SDR: LJdCYQN16RvUYsE4gJWf4ZNI9EGbp1jH90sWQAEot3oGg+y9m+5BtO26kjAZpyORhn661R/J7i
 OQeje9hHsxsQ==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="416706691"
Received: from zcmahone-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.255.231.203])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 14:59:58 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE),
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM IPROC ARM
        ARCHITECTURE)
Subject: [PATCH 04/17] ASoC: bcm: cygnus_ssp: remove useless initialization
Date:   Fri, 26 Mar 2021 16:59:14 -0500
Message-Id: <20210326215927.936377-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
References: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cppcheck warning:

sound/soc/bcm/cygnus-ssp.c:1364:6: style: Redundant initialization for
'err'. The initialized value is overwritten before it is
read. [redundantInitialization]
 err = devm_snd_soc_register_component(dev, &cygnus_ssp_component,
     ^
sound/soc/bcm/cygnus-ssp.c:1313:10: note: err is initialized
 int err = -EINVAL;
         ^
sound/soc/bcm/cygnus-ssp.c:1364:6: note: err is overwritten
 err = devm_snd_soc_register_component(dev, &cygnus_ssp_component,
     ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/bcm/cygnus-ssp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
index 6e634b448293..fea296b41a43 100644
--- a/sound/soc/bcm/cygnus-ssp.c
+++ b/sound/soc/bcm/cygnus-ssp.c
@@ -1310,7 +1310,7 @@ static int cygnus_ssp_probe(struct platform_device *pdev)
 	struct device_node *child_node;
 	struct resource *res;
 	struct cygnus_audio *cygaud;
-	int err = -EINVAL;
+	int err;
 	int node_count;
 	int active_port_count;
 
-- 
2.25.1

