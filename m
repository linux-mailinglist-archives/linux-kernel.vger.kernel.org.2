Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB22369A56
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 20:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243823AbhDWSqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 14:46:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60113 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243795AbhDWSqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 14:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619203553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fsHuKp62g6hI184+2qHzJYxOaWwL5I8FKOj2XVUcHtg=;
        b=g0s0pEXvRo8+om3NJMvMUMQEPS5shaoXja4NexnVXLxpAUAPlh3MbaFvLr0LG8Y7yKRCwI
        I7di9bgTIwEkQyAixUjQpWhg7V7Xkg5ceufiXctoXfV+NG+5H6qH0/ZDwnG/C2n5zEKQUj
        HXEatz1JSQp7MX05GeLZpsIrKcJeC8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-0avclARUNsCvE_RBlDPs4g-1; Fri, 23 Apr 2021 14:45:49 -0400
X-MC-Unique: 0avclARUNsCvE_RBlDPs4g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56993100CCA9;
        Fri, 23 Apr 2021 18:45:03 +0000 (UTC)
Received: from Ruby.lyude.net (ovpn-114-74.rdu2.redhat.com [10.10.114.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A4B6608BA;
        Fri, 23 Apr 2021 18:45:00 +0000 (UTC)
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
        Uma Shankar <uma.shankar@intel.com>,
        Vipin Anand <vipin.anand@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 12/17] drm/dp_dual_mode: Pass drm_device to drm_lspcon_(get|set)_mode()
Date:   Fri, 23 Apr 2021 14:43:04 -0400
Message-Id: <20210423184309.207645-13-lyude@redhat.com>
In-Reply-To: <20210423184309.207645-1-lyude@redhat.com>
References: <20210423184309.207645-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that we can start using drm_dbg_*() throughout the DRM DP helpers.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_dual_mode_helper.c   |  8 +++++---
 drivers/gpu/drm/i915/display/intel_lspcon.c | 12 +++++++-----
 include/drm/drm_dp_dual_mode_helper.h       |  4 ++--
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_dual_mode_helper.c b/drivers/gpu/drm/drm_dp_dual_mode_helper.c
index c9c2952bcad2..dbf9b1fdec63 100644
--- a/drivers/gpu/drm/drm_dp_dual_mode_helper.c
+++ b/drivers/gpu/drm/drm_dp_dual_mode_helper.c
@@ -430,6 +430,7 @@ EXPORT_SYMBOL(drm_dp_get_dual_mode_type_name);
 /**
  * drm_lspcon_get_mode: Get LSPCON's current mode of operation by
  * reading offset (0x80, 0x41)
+ * @dev: &drm_device to use
  * @adapter: I2C-over-aux adapter
  * @mode: current lspcon mode of operation output variable
  *
@@ -437,7 +438,7 @@ EXPORT_SYMBOL(drm_dp_get_dual_mode_type_name);
  * 0 on success, sets the current_mode value to appropriate mode
  * -error on failure
  */
-int drm_lspcon_get_mode(struct i2c_adapter *adapter,
+int drm_lspcon_get_mode(const struct drm_device *dev, struct i2c_adapter *adapter,
 			enum drm_lspcon_mode *mode)
 {
 	u8 data;
@@ -477,13 +478,14 @@ EXPORT_SYMBOL(drm_lspcon_get_mode);
 /**
  * drm_lspcon_set_mode: Change LSPCON's mode of operation by
  * writing offset (0x80, 0x40)
+ * @dev: &drm_device to use
  * @adapter: I2C-over-aux adapter
  * @mode: required mode of operation
  *
  * Returns:
  * 0 on success, -error on failure/timeout
  */
-int drm_lspcon_set_mode(struct i2c_adapter *adapter,
+int drm_lspcon_set_mode(const struct drm_device *dev, struct i2c_adapter *adapter,
 			enum drm_lspcon_mode mode)
 {
 	u8 data = 0;
@@ -508,7 +510,7 @@ int drm_lspcon_set_mode(struct i2c_adapter *adapter,
 	 * so wait and retry until time out or done.
 	 */
 	do {
-		ret = drm_lspcon_get_mode(adapter, &current_mode);
+		ret = drm_lspcon_get_mode(dev, adapter, &current_mode);
 		if (ret) {
 			DRM_ERROR("can't confirm LSPCON mode change\n");
 			return ret;
diff --git a/drivers/gpu/drm/i915/display/intel_lspcon.c b/drivers/gpu/drm/i915/display/intel_lspcon.c
index ca25044e7d1b..ec0048024746 100644
--- a/drivers/gpu/drm/i915/display/intel_lspcon.c
+++ b/drivers/gpu/drm/i915/display/intel_lspcon.c
@@ -139,10 +139,11 @@ void lspcon_detect_hdr_capability(struct intel_lspcon *lspcon)
 
 static enum drm_lspcon_mode lspcon_get_current_mode(struct intel_lspcon *lspcon)
 {
+	struct intel_dp *intel_dp = lspcon_to_intel_dp(lspcon);
 	enum drm_lspcon_mode current_mode;
-	struct i2c_adapter *adapter = &lspcon_to_intel_dp(lspcon)->aux.ddc;
+	struct i2c_adapter *adapter = &intel_dp->aux.ddc;
 
-	if (drm_lspcon_get_mode(adapter, &current_mode)) {
+	if (drm_lspcon_get_mode(intel_dp->aux.drm_dev, adapter, &current_mode)) {
 		DRM_DEBUG_KMS("Error reading LSPCON mode\n");
 		return DRM_LSPCON_MODE_INVALID;
 	}
@@ -175,11 +176,12 @@ static enum drm_lspcon_mode lspcon_wait_mode(struct intel_lspcon *lspcon,
 static int lspcon_change_mode(struct intel_lspcon *lspcon,
 			      enum drm_lspcon_mode mode)
 {
+	struct intel_dp *intel_dp = lspcon_to_intel_dp(lspcon);
 	int err;
 	enum drm_lspcon_mode current_mode;
-	struct i2c_adapter *adapter = &lspcon_to_intel_dp(lspcon)->aux.ddc;
+	struct i2c_adapter *adapter = &intel_dp->aux.ddc;
 
-	err = drm_lspcon_get_mode(adapter, &current_mode);
+	err = drm_lspcon_get_mode(intel_dp->aux.drm_dev, adapter, &current_mode);
 	if (err) {
 		DRM_ERROR("Error reading LSPCON mode\n");
 		return err;
@@ -190,7 +192,7 @@ static int lspcon_change_mode(struct intel_lspcon *lspcon,
 		return 0;
 	}
 
-	err = drm_lspcon_set_mode(adapter, mode);
+	err = drm_lspcon_set_mode(intel_dp->aux.drm_dev, adapter, mode);
 	if (err < 0) {
 		DRM_ERROR("LSPCON mode change failed\n");
 		return err;
diff --git a/include/drm/drm_dp_dual_mode_helper.h b/include/drm/drm_dp_dual_mode_helper.h
index 01eec9ff5962..7ee482265087 100644
--- a/include/drm/drm_dp_dual_mode_helper.h
+++ b/include/drm/drm_dp_dual_mode_helper.h
@@ -114,8 +114,8 @@ int drm_dp_dual_mode_set_tmds_output(const struct drm_device *dev, enum drm_dp_d
 				     struct i2c_adapter *adapter, bool enable);
 const char *drm_dp_get_dual_mode_type_name(enum drm_dp_dual_mode_type type);
 
-int drm_lspcon_get_mode(struct i2c_adapter *adapter,
+int drm_lspcon_get_mode(const struct drm_device *dev, struct i2c_adapter *adapter,
 			enum drm_lspcon_mode *current_mode);
-int drm_lspcon_set_mode(struct i2c_adapter *adapter,
+int drm_lspcon_set_mode(const struct drm_device *dev, struct i2c_adapter *adapter,
 			enum drm_lspcon_mode reqd_mode);
 #endif
-- 
2.30.2

