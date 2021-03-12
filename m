Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5523033884A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbhCLJJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:09:22 -0500
Received: from mga03.intel.com ([134.134.136.65]:1314 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232499AbhCLJIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:08:53 -0500
IronPort-SDR: yANnZHqOTxYwPr/fR61tdmEXWJYCl6p0spm6LnetMjn1b4R2q6aGqo8LBd3duV4tUmYONSynm3
 JSe1SlQaGZcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="188848825"
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="188848825"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 01:08:49 -0800
IronPort-SDR: XGEgW8kBzvb2hUY/Tah2ebAu7FWkOG/75IT9RPleuhTHe4pkSYVXbMecC4Ut2UsQIPXh65/hEY
 klz5X0Pf2/0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="431889914"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by fmsmga004.fm.intel.com with ESMTP; 12 Mar 2021 01:08:45 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     dri-devel@lists.freedesktop.org, Laurent.pinchart@ideasonboard.com,
        narmstrong@baylibre.com, jonas@kwiboo.se, a.hajda@samsung.com
Cc:     pierre-louis.bossart@linux.intel.com, jee.heng.sia@intel.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm: bridge: adv7511: Support I2S IEC958 encoded PCM format
Date:   Fri, 12 Mar 2021 16:52:03 +0800
Message-Id: <20210312085203.13556-1-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support IEC958 encoded PCM format for ADV7511 so that ADV7511 HDMI
audio driver can accept the IEC958 data from the I2S input.

Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
---
 drivers/gpu/drm/bridge/adv7511/adv7511.h       | 1 +
 drivers/gpu/drm/bridge/adv7511/adv7511_audio.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511.h b/drivers/gpu/drm/bridge/adv7511/adv7511.h
index a9bb734366ae..05e3abb5a0c9 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511.h
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511.h
@@ -191,6 +191,7 @@
 #define ADV7511_I2S_FORMAT_I2S			0
 #define ADV7511_I2S_FORMAT_RIGHT_J		1
 #define ADV7511_I2S_FORMAT_LEFT_J		2
+#define ADV7511_I2S_IEC958_DIRECT		3
 
 #define ADV7511_PACKET(p, x)	    ((p) * 0x20 + (x))
 #define ADV7511_PACKET_SDP(x)	    ADV7511_PACKET(0, x)
diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
index 45838bd08d37..61f4a38e7d2b 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
@@ -101,6 +101,10 @@ static int adv7511_hdmi_hw_params(struct device *dev, void *data,
 	case 20:
 		len = ADV7511_I2S_SAMPLE_LEN_20;
 		break;
+	case 32:
+		if (fmt->bit_fmt != SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE)
+			return -EINVAL;
+		fallthrough;
 	case 24:
 		len = ADV7511_I2S_SAMPLE_LEN_24;
 		break;
@@ -112,6 +116,8 @@ static int adv7511_hdmi_hw_params(struct device *dev, void *data,
 	case HDMI_I2S:
 		audio_source = ADV7511_AUDIO_SOURCE_I2S;
 		i2s_format = ADV7511_I2S_FORMAT_I2S;
+		if (fmt->bit_fmt == SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE)
+			i2s_format = ADV7511_I2S_IEC958_DIRECT;
 		break;
 	case HDMI_RIGHT_J:
 		audio_source = ADV7511_AUDIO_SOURCE_I2S;

base-commit: de066e116306baf3a6a62691ac63cfc0b1dabddb
-- 
2.18.0

