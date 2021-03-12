Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A10E33963C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbhCLSXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:23:23 -0500
Received: from mga02.intel.com ([134.134.136.20]:36913 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233125AbhCLSXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:23:13 -0500
IronPort-SDR: iBj3Ds8xswpqOa3dOdzXzWGBHoNJ27VEMmGuRzliQ9MFhQ80c46ydUjMvAtUVCvCj3RgMu4h6X
 BWLxce7YWQCg==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="175999090"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="175999090"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:11 -0800
IronPort-SDR: hRKnoHE/VowBFnczbtcE9mCoFpZg3OvRWwVpvZEDrZHjTrkzPJX3aue76/cawBAbdFRDqanEua
 37ijkhiH5m/w==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="377791911"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.37.30])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 10:23:10 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benson Leung <bleung@chromium.org>
Subject: [PATCH 04/23] ASoC: cros_ec_codec: remove null pointer dereference warning
Date:   Fri, 12 Mar 2021 12:22:27 -0600
Message-Id: <20210312182246.5153-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cppcheck complains of a possible issue:

sound/soc/codecs/cros_ec_codec.c:98:10: warning: Possible null pointer
dereference: in [nullPointer]
  memcpy(in, msg->data, insize);
         ^
sound/soc/codecs/cros_ec_codec.c:162:34: note: Calling function
'send_ec_host_command', 5th argument 'NULL' value is 0
       (uint8_t *)&p, sizeof(p), NULL, 0);
                                 ^
sound/soc/codecs/cros_ec_codec.c:98:10: note: Null pointer dereference
  memcpy(in, msg->data, insize);
         ^

In practice the access to the pointer is protected by another
argument, but this is likely to fool other static analysis tools. Add
a test to avoid doing the memcpy if the pointer is NULL or the size is
zero.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/cros_ec_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index c4772f82485a..a201d652aca2 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -94,7 +94,7 @@ static int send_ec_host_command(struct cros_ec_device *ec_dev, uint32_t cmd,
 	if (ret < 0)
 		goto error;
 
-	if (insize)
+	if (in && insize)
 		memcpy(in, msg->data, insize);
 
 	ret = 0;
-- 
2.25.1

