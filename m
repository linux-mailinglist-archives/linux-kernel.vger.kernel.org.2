Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA52369A32
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 20:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243789AbhDWSqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 14:46:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24121 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243754AbhDWSqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 14:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619203543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bcsMGtj1LuRlLRRf+NneAzyPaC62wDCq434F0KB8s/o=;
        b=U62wVfC2o18jz9hjTYPos+PGgnIxgLFUm0EnUx95U0VWZT4Ysk7LkCqsY+HM9EKnXxwzWv
        BYlwg8964PrFHBlsIuZRvBRTwe/oBwx/5qVl00n42xpV5PegWA+meilNzbd532HLfZVlAP
        g5u1ZnYnNS8LZy1gK6lRmLaTaxdWUqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-NE-SWWH1NEqpyn3kzonZUA-1; Fri, 23 Apr 2021 14:45:35 -0400
X-MC-Unique: NE-SWWH1NEqpyn3kzonZUA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7DBF1067046;
        Fri, 23 Apr 2021 18:44:53 +0000 (UTC)
Received: from Ruby.lyude.net (ovpn-114-74.rdu2.redhat.com [10.10.114.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BBA56090F;
        Fri, 23 Apr 2021 18:44:51 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Ramalingam C <ramalingam.c@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 09/17] drm/dp_dual_mode: Pass drm_device to drm_dp_dual_mode_set_tmds_output()
Date:   Fri, 23 Apr 2021 14:43:01 -0400
Message-Id: <20210423184309.207645-10-lyude@redhat.com>
In-Reply-To: <20210423184309.207645-1-lyude@redhat.com>
References: <20210423184309.207645-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another function that we'll need to pass a drm_device (and not drm_dp_aux)
down to so that we can move over to using drm_dbg_*().

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_dual_mode_helper.c | 3 ++-
 drivers/gpu/drm/i915/display/intel_hdmi.c | 3 +--
 include/drm/drm_dp_dual_mode_helper.h     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_dual_mode_helper.c b/drivers/gpu/drm/drm_dp_dual_mode_helper.c
index 9ee75c568c37..a63d7de85309 100644
--- a/drivers/gpu/drm/drm_dp_dual_mode_helper.c
+++ b/drivers/gpu/drm/drm_dp_dual_mode_helper.c
@@ -336,6 +336,7 @@ EXPORT_SYMBOL(drm_dp_dual_mode_get_tmds_output);
 
 /**
  * drm_dp_dual_mode_set_tmds_output - Enable/disable TMDS output buffers in the DP dual mode adaptor
+ * @dev: &drm_device to use
  * @type: DP dual mode adaptor type
  * @adapter: I2C adapter for the DDC bus
  * @enable: enable (as opposed to disable) the TMDS output buffers
@@ -349,7 +350,7 @@ EXPORT_SYMBOL(drm_dp_dual_mode_get_tmds_output);
  * Returns:
  * 0 on success, negative error code on failure
  */
-int drm_dp_dual_mode_set_tmds_output(enum drm_dp_dual_mode_type type,
+int drm_dp_dual_mode_set_tmds_output(const struct drm_device *dev, enum drm_dp_dual_mode_type type,
 				     struct i2c_adapter *adapter, bool enable)
 {
 	uint8_t tmds_oen = enable ? 0 : DP_DUAL_MODE_TMDS_DISABLE;
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 08fb98dac169..fc3e7a9396b5 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -1251,8 +1251,7 @@ void intel_dp_dual_mode_set_tmds_output(struct intel_hdmi *hdmi, bool enable)
 	drm_dbg_kms(&dev_priv->drm, "%s DP dual mode adaptor TMDS output\n",
 		    enable ? "Enabling" : "Disabling");
 
-	drm_dp_dual_mode_set_tmds_output(hdmi->dp_dual_mode.type,
-					 adapter, enable);
+	drm_dp_dual_mode_set_tmds_output(&dev_priv->drm, hdmi->dp_dual_mode.type, adapter, enable);
 }
 
 static int intel_hdmi_hdcp_read(struct intel_digital_port *dig_port,
diff --git a/include/drm/drm_dp_dual_mode_helper.h b/include/drm/drm_dp_dual_mode_helper.h
index 23ce849152f3..8cb0dcd98a99 100644
--- a/include/drm/drm_dp_dual_mode_helper.h
+++ b/include/drm/drm_dp_dual_mode_helper.h
@@ -110,7 +110,7 @@ int drm_dp_dual_mode_max_tmds_clock(enum drm_dp_dual_mode_type type,
 				    struct i2c_adapter *adapter);
 int drm_dp_dual_mode_get_tmds_output(enum drm_dp_dual_mode_type type,
 				     struct i2c_adapter *adapter, bool *enabled);
-int drm_dp_dual_mode_set_tmds_output(enum drm_dp_dual_mode_type type,
+int drm_dp_dual_mode_set_tmds_output(const struct drm_device *dev, enum drm_dp_dual_mode_type type,
 				     struct i2c_adapter *adapter, bool enable);
 const char *drm_dp_get_dual_mode_type_name(enum drm_dp_dual_mode_type type);
 
-- 
2.30.2

