Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7A533964C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbhCLSYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:24:06 -0500
Received: from mga07.intel.com ([134.134.136.100]:4236 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232223AbhCLSXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:23:46 -0500
IronPort-SDR: gzepHDWB+E/f0P2kt860rLpTFUjJdoWP3Ud1zBtnvr1dfRzkQRUqvOftib5uLGI3VLhoBj8bf6
 gck4LgJkxT4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="252888940"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="252888940"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:46 -0800
IronPort-SDR: T0I19Xpl7umOcexnSGDoG5Dw8vQZRch9lFDKeZUhhxsuf9Tpm/OHz0k3+B1cu9XkBVgZU0Z6vk
 sxg63zRIWgIA==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="377792045"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.37.30])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:45 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 17/23] ASoC: sigmadsp: align function prototype
Date:   Fri, 12 Mar 2021 12:22:40 -0600
Message-Id: <20210312182246.5153-18-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/codecs/sigmadsp.c:736:60: style:inconclusive: Function
'sigmadsp_setup' argument 2 names different: declaration 'rate'
definition 'samplerate'. [funcArgNamesDifferent]
int sigmadsp_setup(struct sigmadsp *sigmadsp, unsigned int samplerate)
                                                           ^

sound/soc/codecs/sigmadsp.h:62:60: note: Function 'sigmadsp_setup'
argument 2 names different: declaration 'rate' definition
'samplerate'.
int sigmadsp_setup(struct sigmadsp *sigmadsp, unsigned int rate);
                                                           ^

sound/soc/codecs/sigmadsp.c:736:60: note: Function 'sigmadsp_setup'
argument 2 names different: declaration 'rate' definition
'samplerate'.
int sigmadsp_setup(struct sigmadsp *sigmadsp, unsigned int samplerate)
                                                           ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/sigmadsp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sigmadsp.h b/sound/soc/codecs/sigmadsp.h
index e3c9656e006d..d63b8c366efb 100644
--- a/sound/soc/codecs/sigmadsp.h
+++ b/sound/soc/codecs/sigmadsp.h
@@ -59,7 +59,7 @@ struct sigmadsp *devm_sigmadsp_init_i2c(struct i2c_client *client,
 
 int sigmadsp_attach(struct sigmadsp *sigmadsp,
 	struct snd_soc_component *component);
-int sigmadsp_setup(struct sigmadsp *sigmadsp, unsigned int rate);
+int sigmadsp_setup(struct sigmadsp *sigmadsp, unsigned int samplerate);
 void sigmadsp_reset(struct sigmadsp *sigmadsp);
 
 #endif
-- 
2.25.1

