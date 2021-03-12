Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAA9339646
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbhCLSX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:23:59 -0500
Received: from mga02.intel.com ([134.134.136.20]:36942 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233235AbhCLSX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:23:27 -0500
IronPort-SDR: la2V5iY4/RpCRn6sMAyra8hpE9/9SLiwWdBu+bXGdldV++IqefP4J8PmC8D6NxVnCMfE9aYtb7
 mmqyVORC8Lrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="175999127"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="175999127"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:27 -0800
IronPort-SDR: TXOqmeBFIU4oAz+oS82bU5HQyoIkqGNqVNDIJJGg5BnhEiPKFnayr2Sf6/dWLKFKZE1krO+Qlv
 SVY0i+l1JzuQ==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="377791964"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.37.30])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:25 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 11/23] ASoC: hdmi-codec: remove unused spk_mask member
Date:   Fri, 12 Mar 2021 12:22:34 -0600
Message-Id: <20210312182246.5153-12-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix cppcheck warning:

sound/soc/codecs/hdmi-codec.c:25:16: style: struct member
'hdmi_codec_channel_map_table::spk_mask' is never
used. [unusedStructMember]
 unsigned long spk_mask;  /* speaker position bit mask */
               ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/hdmi-codec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 83e74ddccf59..1567ba196ab9 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -22,7 +22,6 @@
 
 struct hdmi_codec_channel_map_table {
 	unsigned char map;	/* ALSA API channel map position */
-	unsigned long spk_mask;		/* speaker position bit mask */
 };
 
 /*
-- 
2.25.1

