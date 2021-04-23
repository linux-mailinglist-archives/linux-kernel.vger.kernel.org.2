Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138D3369A57
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 20:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243834AbhDWSqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 14:46:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34448 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243797AbhDWSqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 14:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619203554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pQCZ54IuLyP73OXVbRrWHmwVJxZt2tfRlIM9WCwhY7I=;
        b=KLcXFGpjrdBQyitbyMdSTg0wuz/0pAGi9PLe5/FG7QF2AoqUbv75D/3M4YgSti2k3x3Sg8
        7t8pLOnzgbeHBlnAMRqDTqWL5GBfYoK3/KE8njO+XYm8vCiLbQ4oACl+pLUqRZCet2waX9
        3Vc/QJT9VlvdcxAkDaQbQp+roD99qDo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-Fw1rbtQQNfquddD_lXrzgQ-1; Fri, 23 Apr 2021 14:45:52 -0400
X-MC-Unique: Fw1rbtQQNfquddD_lXrzgQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A213A18C35C3;
        Fri, 23 Apr 2021 18:44:57 +0000 (UTC)
Received: from Ruby.lyude.net (ovpn-114-74.rdu2.redhat.com [10.10.114.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 432AB608BA;
        Fri, 23 Apr 2021 18:44:55 +0000 (UTC)
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
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 10/17] drm/dp_dual_mode: Pass drm_device to drm_dp_dual_mode_max_tmds_clock()
Date:   Fri, 23 Apr 2021 14:43:02 -0400
Message-Id: <20210423184309.207645-11-lyude@redhat.com>
In-Reply-To: <20210423184309.207645-1-lyude@redhat.com>
References: <20210423184309.207645-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another function we need to pass drm_device down to in order to start using
drm_dbg_*().

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_dual_mode_helper.c | 3 ++-
 drivers/gpu/drm/i915/display/intel_hdmi.c | 2 +-
 include/drm/drm_dp_dual_mode_helper.h     | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_dual_mode_helper.c b/drivers/gpu/drm/drm_dp_dual_mode_helper.c
index a63d7de85309..4a26b3e1f78f 100644
--- a/drivers/gpu/drm/drm_dp_dual_mode_helper.c
+++ b/drivers/gpu/drm/drm_dp_dual_mode_helper.c
@@ -252,6 +252,7 @@ EXPORT_SYMBOL(drm_dp_dual_mode_detect);
 
 /**
  * drm_dp_dual_mode_max_tmds_clock - Max TMDS clock for DP dual mode adaptor
+ * @dev: &drm_device to use
  * @type: DP dual mode adaptor type
  * @adapter: I2C adapter for the DDC bus
  *
@@ -265,7 +266,7 @@ EXPORT_SYMBOL(drm_dp_dual_mode_detect);
  * Returns:
  * Maximum supported TMDS clock rate for the DP dual mode adaptor in kHz.
  */
-int drm_dp_dual_mode_max_tmds_clock(enum drm_dp_dual_mode_type type,
+int drm_dp_dual_mode_max_tmds_clock(const struct drm_device *dev, enum drm_dp_dual_mode_type type,
 				    struct i2c_adapter *adapter)
 {
 	uint8_t max_tmds_clock;
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index fc3e7a9396b5..46de56af33db 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2256,7 +2256,7 @@ intel_hdmi_dp_dual_mode_detect(struct drm_connector *connector, bool has_edid)
 
 	hdmi->dp_dual_mode.type = type;
 	hdmi->dp_dual_mode.max_tmds_clock =
-		drm_dp_dual_mode_max_tmds_clock(type, adapter);
+		drm_dp_dual_mode_max_tmds_clock(&dev_priv->drm, type, adapter);
 
 	drm_dbg_kms(&dev_priv->drm,
 		    "DP dual mode adaptor (%s) detected (max TMDS clock: %d kHz)\n",
diff --git a/include/drm/drm_dp_dual_mode_helper.h b/include/drm/drm_dp_dual_mode_helper.h
index 8cb0dcd98a99..aabf9c951380 100644
--- a/include/drm/drm_dp_dual_mode_helper.h
+++ b/include/drm/drm_dp_dual_mode_helper.h
@@ -106,7 +106,7 @@ enum drm_dp_dual_mode_type {
 
 enum drm_dp_dual_mode_type
 drm_dp_dual_mode_detect(const struct drm_device *dev, struct i2c_adapter *adapter);
-int drm_dp_dual_mode_max_tmds_clock(enum drm_dp_dual_mode_type type,
+int drm_dp_dual_mode_max_tmds_clock(const struct drm_device *dev, enum drm_dp_dual_mode_type type,
 				    struct i2c_adapter *adapter);
 int drm_dp_dual_mode_get_tmds_output(enum drm_dp_dual_mode_type type,
 				     struct i2c_adapter *adapter, bool *enabled);
-- 
2.30.2

