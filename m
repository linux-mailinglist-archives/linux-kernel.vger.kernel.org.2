Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31B2367A55
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 08:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbhDVG5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 02:57:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:4938 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230228AbhDVG5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 02:57:50 -0400
IronPort-SDR: 9b+sdw+fkop3jHmyRzhmp7xe0AFpnM8DPTk7xvrfvkYJTsRFjSMzm0X/0Sg08dk92omC45sg+Q
 QWdCpCLtCi6w==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="175324124"
X-IronPort-AV: E=Sophos;i="5.82,242,1613462400"; 
   d="scan'208";a="175324124"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 23:57:15 -0700
IronPort-SDR: bXP9vH/3TPL+LTZoljuDEuqrFrGNj+FIj1aJk4GAPJfoSqdZKHRBA3Tm4cH07SPn17hqxDvqgD
 0YM0kcGY9NVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,242,1613462400"; 
   d="scan'208";a="427811135"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by orsmga008.jf.intel.com with ESMTP; 21 Apr 2021 23:57:13 -0700
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     dri-devel@lists.freedesktop.org, Laurent.pinchart@ideasonboard.com,
        narmstrong@baylibre.com, jonas@kwiboo.se, a.hajda@samsung.com
Cc:     pierre-louis.bossart@linux.intel.com, jee.heng.sia@intel.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] drm: bridge: adv7511: Support I2S IEC958 encoded PCM format
Date:   Thu, 22 Apr 2021 14:40:15 +0800
Message-Id: <20210422064015.15285-1-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support IEC958 encoded PCM format for ADV7511 so that ADV7511 HDMI
audio driver can accept the IEC958 data from the I2S input.

Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
Reviewed-by: Robert Foss <robert.foss@linaro.org>
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

base-commit: e488b1023a4a4eab15b905871cf8e81f00336ed7
-- 
2.18.0

