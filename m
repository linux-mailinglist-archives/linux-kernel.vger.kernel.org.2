Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E583534B1B0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 23:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhCZWAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 18:00:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:61331 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230240AbhCZWAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 18:00:06 -0400
IronPort-SDR: QYRJqNk+1Th4UN+qa3tJ5I1YDm7E0W7jMCRtIEBJahI3+OpEqcaJLu85uK7592BzUS/lzf+qGm
 ZpHI0AQzchjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="188957088"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="188957088"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 15:00:06 -0700
IronPort-SDR: 7NWZHaaay1C/1PxCKzjdVdf7YwM5gdF5YFKIj46EH6by9m9zByzidJ4/VP14TKr0nh48yjZQF1
 4NwB0i7DUqAQ==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="416706795"
Received: from zcmahone-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.255.231.203])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 15:00:05 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 08/17] ASoC: sti: sti_uniperif: add missing error check
Date:   Fri, 26 Mar 2021 16:59:18 -0500
Message-Id: <20210326215927.936377-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
References: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/sti/sti_uniperif.c:490:6: style: Variable 'ret' is
reassigned a value before the old one has been
used. [redundantAssignment]
 ret = devm_snd_soc_register_component(&pdev->dev,
     ^
sound/soc/sti/sti_uniperif.c:486:6: note: ret is assigned
 ret = sti_uniperiph_cpu_dai_of(node, priv);
     ^
sound/soc/sti/sti_uniperif.c:490:6: note: ret is overwritten
 ret = devm_snd_soc_register_component(&pdev->dev,
     ^

sti_uniperiph_cpu_dai_of() can return -EINVAL which seems like a
good-enough reason to bail.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sti/sti_uniperif.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sti/sti_uniperif.c b/sound/soc/sti/sti_uniperif.c
index 7b9169f04d6e..67315d9b352d 100644
--- a/sound/soc/sti/sti_uniperif.c
+++ b/sound/soc/sti/sti_uniperif.c
@@ -484,6 +484,8 @@ static int sti_uniperiph_probe(struct platform_device *pdev)
 	priv->pdev = pdev;
 
 	ret = sti_uniperiph_cpu_dai_of(node, priv);
+	if (ret < 0)
+		return ret;
 
 	dev_set_drvdata(&pdev->dev, priv);
 
-- 
2.25.1

