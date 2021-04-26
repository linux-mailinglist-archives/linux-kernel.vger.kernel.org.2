Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD3936B909
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbhDZSgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbhDZSgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:36:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14099C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=yIQ8r/6+4jmPXMKwK9VLxpJ4dQsyz8jNXuoO7X+Mvyw=; b=Pia2gB4XK5q4kSTSGciQOucVHK
        v0ER2haHAO4Xtzlhyg9C3ZyyHhT+32Vr15SkVVjrFpmRy/iudnoEbULsFkJQG4ItMQd01cqjTv1eS
        vjlJrB5SKu7kOsbpSPzY2+qE8S5OVt0Lx1OU86bBlfxUz0XM0/DpXO6IdTrAuxuQukv+5wKMOVwBm
        Y5s1RX+iRho1HbWUEHsgkrcN+vwOAJx8kPw1AComAWoWEdNL3Fz4Ym37ylA+hROpAKmbrKdMtQ11e
        wX823W6KgsHCjgm+GCnm3+sHWQBAx0LOmDa/vyGeZrPWqWzjAI6vSujf533OCl/RKecnTUuwsSC/0
        qFQKz98w==;
Received: from [2601:1c0:6280:3f0::df68] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lb64q-005xso-6v; Mon, 26 Apr 2021 18:35:31 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Damien Lespiau <damien.lespiau@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm: i915: fix build when ACPI is disabled and BACKLIGHT=m
Date:   Mon, 26 Apr 2021 11:35:16 -0700
Message-Id: <20210426183516.18957-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_DRM_I915=y, CONFIG_ACPI is not set, and
CONFIG_BACKLIGHT_CLASS_DEVICE=m, not due to I915 config,
there are build errors trying to reference backlight_device_{un}register().

Changing the use of IS_ENABLED() to IS_REACHABLE() in intel_panel.[ch]
fixes this.

ld: drivers/gpu/drm/i915/display/intel_panel.o: in function `intel_backlight_device_register':
intel_panel.c:(.text+0x2ec1): undefined reference to `backlight_device_register'
ld: drivers/gpu/drm/i915/display/intel_panel.o: in function `intel_backlight_device_unregister':
intel_panel.c:(.text+0x2f93): undefined reference to `backlight_device_unregister'

ld: drivers/gpu/drm/i915/display/intel_panel.o: in function `intel_backlight_device_register':
intel_panel.c:(.text+0x2ec1): undefined reference to `backlight_device_register'
ld: drivers/gpu/drm/i915/display/intel_panel.o: in function `intel_backlight_device_unregister':
intel_panel.c:(.text+0x2f93): undefined reference to `backlight_device_unregister'

Fixes: 912e8b12eedb ("drm/i915: register backlight device also when backlight class is a module")
Fixes: 44c1220a441c ("drm/i915: extract intel_panel.h from intel_drv.h")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Damien Lespiau <damien.lespiau@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
---
Found in linux-next but applies to mainline (5.12).

 drivers/gpu/drm/i915/display/intel_panel.c |    2 +-
 drivers/gpu/drm/i915/display/intel_panel.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20210426.orig/drivers/gpu/drm/i915/display/intel_panel.c
+++ linux-next-20210426/drivers/gpu/drm/i915/display/intel_panel.c
@@ -1254,7 +1254,7 @@ void intel_panel_enable_backlight(const
 	mutex_unlock(&dev_priv->backlight_lock);
 }
 
-#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
+#if IS_REACHABLE(CONFIG_BACKLIGHT_CLASS_DEVICE)
 static u32 intel_panel_get_backlight(struct intel_connector *connector)
 {
 	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
--- linux-next-20210426.orig/drivers/gpu/drm/i915/display/intel_panel.h
+++ linux-next-20210426/drivers/gpu/drm/i915/display/intel_panel.h
@@ -54,7 +54,7 @@ u32 intel_panel_invert_pwm_level(struct
 u32 intel_panel_backlight_level_to_pwm(struct intel_connector *connector, u32 level);
 u32 intel_panel_backlight_level_from_pwm(struct intel_connector *connector, u32 val);
 
-#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
+#if IS_REACHABLE(CONFIG_BACKLIGHT_CLASS_DEVICE)
 int intel_backlight_device_register(struct intel_connector *connector);
 void intel_backlight_device_unregister(struct intel_connector *connector);
 #else /* CONFIG_BACKLIGHT_CLASS_DEVICE */
