Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6769A339643
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbhCLSX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:23:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:36942 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233193AbhCLSXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:23:23 -0500
IronPort-SDR: Zm4mL3lMvb+DVGOzYXJu3+LLiGOQS596fbanzN9MFN/jJc7v0U1iMkjPGF9t208eyS4FfQeHTw
 w3EoRjCet+mQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="175999122"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="175999122"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:23 -0800
IronPort-SDR: cUFBrBXzs7Y86AZW8ozYSduHiOlmP+2GC+HHZsmZBGHTQ0UeCY5XmuFZAXhzRETIDJYj/Ewg/5
 20oWa2kADkTg==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="377791948"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.37.30])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:22 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 09/23] ASoC: hdac_hdmi: align function arguments
Date:   Fri, 12 Mar 2021 12:22:32 -0600
Message-Id: <20210312182246.5153-10-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/codecs/hdac_hdmi.c:1882:54: style:inconclusive: Function
'hdac_hdmi_jack_init' argument 2 names different: declaration 'pcm'
definition 'device'. [funcArgNamesDifferent]
int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int device,
                                                     ^
sound/soc/codecs/hdac_hdmi.h:5:54: note: Function
'hdac_hdmi_jack_init' argument 2 names different: declaration 'pcm'
definition 'device'.
int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int pcm,
                                                     ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/hdac_hdmi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdac_hdmi.h b/sound/soc/codecs/hdac_hdmi.h
index 4fa2fc9ee893..493fa3b4ef75 100644
--- a/sound/soc/codecs/hdac_hdmi.h
+++ b/sound/soc/codecs/hdac_hdmi.h
@@ -2,7 +2,7 @@
 #ifndef __HDAC_HDMI_H__
 #define __HDAC_HDMI_H__
 
-int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int pcm,
+int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int device,
 				struct snd_soc_jack *jack);
 
 int hdac_hdmi_jack_port_init(struct snd_soc_component *component,
-- 
2.25.1

