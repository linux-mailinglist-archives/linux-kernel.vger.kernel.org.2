Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEB8369A5B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 20:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243909AbhDWSqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 14:46:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55670 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243806AbhDWSqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 14:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619203562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cXRIHgrm2ahBtgKOQiueG74NlG9d46yHGX/Bv1Bp5Ak=;
        b=ChdDPt/V9FhUzm4Yq/Wr0uJ1/XMqpUPdB4iDh1+S9hG2Yow4QT3Op6OFEpN4Yck4Cap1Wx
        7A+o3sZCWkdqGtqFy3lcSL6w1+irpnQa0JfA9jSZap6OewhJf4rfiXVQ08gaURy2fqjEJX
        LD9+1qgrn/7Bzr5f16ZTUyGBZBG1w1g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-7Lwr7PFyPAGm4a6tdfqQkg-1; Fri, 23 Apr 2021 14:45:58 -0400
X-MC-Unique: 7Lwr7PFyPAGm4a6tdfqQkg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 495D7C73BD;
        Fri, 23 Apr 2021 18:45:09 +0000 (UTC)
Received: from Ruby.lyude.net (ovpn-114-74.rdu2.redhat.com [10.10.114.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B72CD608BA;
        Fri, 23 Apr 2021 18:45:07 +0000 (UTC)
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
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 14/17] drm/print: Handle potentially NULL drm_devices in drm_dbg_*
Date:   Fri, 23 Apr 2021 14:43:06 -0400
Message-Id: <20210423184309.207645-15-lyude@redhat.com>
In-Reply-To: <20210423184309.207645-1-lyude@redhat.com>
References: <20210423184309.207645-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While this shouldn't really be something that happens all that often, since
we're going to be using the drm_dbg_* log helpers in DRM helpers it's
technically possible that a driver could use an AUX adapter before it's
been associated with it's respective drm_device. While drivers should take
care to avoid this, there's likely going to be situations where it's
difficult to workaround. And since other logging helpers in the kernel tend
to be OK with NULL pointers (for instance, passing a NULL pointer to a "%s"
argument for a printk-like function in the kernel doesn't break anything),
we should do the same for ours.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 include/drm/drm_print.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index a3c58c941bdc..9b66be54dd16 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -443,25 +443,25 @@ void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 
 
 #define drm_dbg_core(drm, fmt, ...)					\
-	drm_dev_dbg((drm)->dev, DRM_UT_CORE, fmt, ##__VA_ARGS__)
+	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_CORE, fmt, ##__VA_ARGS__)
 #define drm_dbg(drm, fmt, ...)						\
-	drm_dev_dbg((drm)->dev, DRM_UT_DRIVER, fmt, ##__VA_ARGS__)
+	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_DRIVER, fmt, ##__VA_ARGS__)
 #define drm_dbg_kms(drm, fmt, ...)					\
-	drm_dev_dbg((drm)->dev, DRM_UT_KMS, fmt, ##__VA_ARGS__)
+	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_KMS, fmt, ##__VA_ARGS__)
 #define drm_dbg_prime(drm, fmt, ...)					\
-	drm_dev_dbg((drm)->dev, DRM_UT_PRIME, fmt, ##__VA_ARGS__)
+	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_PRIME, fmt, ##__VA_ARGS__)
 #define drm_dbg_atomic(drm, fmt, ...)					\
-	drm_dev_dbg((drm)->dev, DRM_UT_ATOMIC, fmt, ##__VA_ARGS__)
+	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_ATOMIC, fmt, ##__VA_ARGS__)
 #define drm_dbg_vbl(drm, fmt, ...)					\
-	drm_dev_dbg((drm)->dev, DRM_UT_VBL, fmt, ##__VA_ARGS__)
+	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_VBL, fmt, ##__VA_ARGS__)
 #define drm_dbg_state(drm, fmt, ...)					\
-	drm_dev_dbg((drm)->dev, DRM_UT_STATE, fmt, ##__VA_ARGS__)
+	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_STATE, fmt, ##__VA_ARGS__)
 #define drm_dbg_lease(drm, fmt, ...)					\
-	drm_dev_dbg((drm)->dev, DRM_UT_LEASE, fmt, ##__VA_ARGS__)
+	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_LEASE, fmt, ##__VA_ARGS__)
 #define drm_dbg_dp(drm, fmt, ...)					\
-	drm_dev_dbg((drm)->dev, DRM_UT_DP, fmt, ##__VA_ARGS__)
+	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_DP, fmt, ##__VA_ARGS__)
 #define drm_dbg_drmres(drm, fmt, ...)					\
-	drm_dev_dbg((drm)->dev, DRM_UT_DRMRES, fmt, ##__VA_ARGS__)
+	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_DRMRES, fmt, ##__VA_ARGS__)
 
 
 /*
-- 
2.30.2

