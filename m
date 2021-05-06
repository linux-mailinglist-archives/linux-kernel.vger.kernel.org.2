Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4B3375938
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 19:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbhEFRZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 13:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236263AbhEFRYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 13:24:54 -0400
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB7BC061763
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 10:23:55 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 4209CC800AE;
        Thu,  6 May 2021 19:23:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id CsIGQ_C43pi9; Thu,  6 May 2021 19:23:54 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (p200300e37F12f2008bdED9a70B37E3f5.dip0.t-ipconnect.de [IPv6:2003:e3:7f12:f200:8bde:d9a7:b37:e3f5])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 04212C800AB;
        Thu,  6 May 2021 19:23:54 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     ville.syrjala@linux.intel.com, airlied@linux.ie, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Werner Sembach <wse@tuxedocomputers.com>
Subject: [PATCH 3/3] drm/i915/display: Use YCbCr420 as fallback when RGB fails
Date:   Thu,  6 May 2021 19:23:25 +0200
Message-Id: <20210506172325.1995964-4-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210506172325.1995964-1-wse@tuxedocomputers.com>
References: <20210506172325.1995964-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When encoder validation of a display mode fails, retry with less bandwidth
heavy YCbCr420 color mode, if available. This enables some HDMI 1.4 setups
to support 4k60Hz output, which previously failed silently.

AMDGPU had nearly the exact same issue. This problem description is
therefore copied from my commit message of the AMDGPU patch.

On some setups, while the monitor and the gpu support display modes with
pixel clocks of up to 600MHz, the link encoder might not. This prevents
YCbCr444 and RGB encoding for 4k60Hz, but YCbCr420 encoding might still be
possible. However, which color mode is used is decided before the link
encoder capabilities are checked. This patch fixes the problem by retrying
to find a display mode with YCbCr420 enforced and using it, if it is
valid.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index b0201d4f27eb..7815569267e3 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -1897,6 +1897,7 @@ intel_hdmi_mode_valid(struct drm_connector *connector,
 	int clock = mode->clock;
 	int max_dotclk = to_i915(connector->dev)->max_dotclk_freq;
 	bool has_hdmi_sink = intel_has_hdmi_sink(hdmi, connector->state);
+	bool ycbcr_420_only;
 
 	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
 		return MODE_NO_DBLESCAN;
@@ -1913,12 +1914,20 @@ intel_hdmi_mode_valid(struct drm_connector *connector,
 		clock *= 2;
 	}
 
-	if (drm_mode_is_420_only(&connector->display_info, mode))
+	ycbcr_420_only = drm_mode_is_420_only(&connector->display_info, mode);
+	if (ycbcr_420_only)
 		clock /= 2;
 
 	status = intel_hdmi_mode_clock_valid(hdmi, clock, has_hdmi_sink);
-	if (status != MODE_OK)
-		return status;
+	if (status != MODE_OK) {
+		if (ycbcr_420_only || !connector->ycbcr_420_allowed || !drm_mode_is_420_also(&connector->display_info, mode))
+			return status;
+
+		clock /= 2;
+		status = intel_hdmi_mode_clock_valid(hdmi, clock, has_hdmi_sink);
+		if (status != MODE_OK)
+			return status;
+	}
 
 	return intel_mode_valid_max_plane_size(dev_priv, mode, false);
 }
@@ -2125,6 +2134,14 @@ static int intel_hdmi_compute_output_format(struct intel_encoder *encoder,
 	}
 
 	ret = intel_hdmi_compute_clock(encoder, crtc_state);
+	if (ret) {
+		if (crtc_state->output_format != INTEL_OUTPUT_FORMAT_YCBCR420 &&
+				connector->ycbcr_420_allowed &&
+				drm_mode_is_420_also(&connector->display_info, adjusted_mode)) {
+			crtc_state->output_format = INTEL_OUTPUT_FORMAT_YCBCR420;
+			ret = intel_hdmi_compute_clock(encoder, crtc_state);
+		}
+	}
 
 	return ret;
 }
-- 
2.25.1

