Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022AE320106
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 22:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhBSV62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 16:58:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60648 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229985AbhBSV42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 16:56:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613771701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zK9ZvrdZ/EankOlaPVeS93+jEpVl0nHbYomyCZ773NM=;
        b=Y4MH1hkZqM8EOrIZUmM2nlJ0P5BTSWrG1rhTmsXMn5VcQIaSF/4lIn/dBbNYybznL4tlAf
        4V7YSyEqAa5UIj8aSWD/SVGAjEHmYDqY7Xp/jrNj+9LoecsD1RzPEiT4H4jP3m6ZnyZTqa
        3J0MESY/iv+uye4myyRk1chT8cCGpP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-j6kfaj0WO8yoBf0_Q7qMoQ-1; Fri, 19 Feb 2021 16:54:59 -0500
X-MC-Unique: j6kfaj0WO8yoBf0_Q7qMoQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A2A680196C;
        Fri, 19 Feb 2021 21:54:57 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-118-5.rdu2.redhat.com [10.10.118.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E22A46A03C;
        Fri, 19 Feb 2021 21:54:55 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 17/30] drm/dp: Clarify DP AUX registration time
Date:   Fri, 19 Feb 2021 16:53:13 -0500
Message-Id: <20210219215326.2227596-18-lyude@redhat.com>
In-Reply-To: <20210219215326.2227596-1-lyude@redhat.com>
References: <20210219215326.2227596-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The docs we had for drm_dp_aux_init() and drm_dp_aux_register() were mostly
correct, except for the fact that they made the assumption that all AUX
devices were grandchildren of their respective DRM devices. This is the
case for most normal GPUs, but is almost never the case with SoCs and
display bridges. So, let's fix this documentation to clarify when the right
time to use drm_dp_aux_init() or drm_dp_aux_register() is.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_helper.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 17f5d1296ff1..194e0c273809 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -1729,8 +1729,15 @@ EXPORT_SYMBOL(drm_dp_remote_aux_init);
  * @aux: DisplayPort AUX channel
  *
  * If you need to use the drm_dp_aux's i2c adapter prior to registering it with the outside world,
- * call drm_dp_aux_init() first. You must still call drm_dp_aux_register() once the connector has
- * been registered to allow userspace access to the auxiliary DP channel.
+ * call drm_dp_aux_init() first. For drivers which are grandparents to their AUX adapters (e.g. the
+ * AUX adapter is parented by a &drm_connector), you must still call drm_dp_aux_register() once the
+ * connector has been registered to allow userspace access to the auxiliary DP channel. Likewise,
+ * for such drivers you should also assign &drm_dp_aux.drm_dev as early as possible so that the
+ * &drm_device that corresponds to the AUX adapter may be mentioned in debugging output from the DRM
+ * DP helpers.
+ *
+ * For devices which use a separate platform device for their AUX adapters, this may be called as
+ * early as required by the driver.
  */
 void drm_dp_aux_init(struct drm_dp_aux *aux)
 {
@@ -1751,12 +1758,21 @@ EXPORT_SYMBOL(drm_dp_aux_init);
  * @aux: DisplayPort AUX channel
  *
  * Automatically calls drm_dp_aux_init() if this hasn't been done yet. This should only be called
- * when the underlying &struct drm_connector is initialiazed already. Therefore the best place to
- * call this is from &drm_connector_funcs.late_register. Not that drivers which don't follow this
- * will Oops when CONFIG_DRM_DP_AUX_CHARDEV is enabled.
- *
- * Drivers which need to use the aux channel before that point (e.g. at driver load time, before
- * drm_dev_register() has been called) need to call drm_dp_aux_init().
+ * once the parent of @aux, &drm_dp_aux.dev, is initialized. For devices which are grandparents of
+ * their AUX channels, &drm_dp_aux.dev will typically be the &drm_connector &device which
+ * corresponds to @aux. For these devices, it's advised to call drm_dp_aux_register() in
+ * &drm_connector_funcs.late_register, and likewise to call drm_dp_aux_unregister() in
+ * &drm_connector_funcs.early_unregister. Functions which don't follow this will likely Oops when
+ * %CONFIG_DRM_DP_AUX_CHARDEV is enabled.
+ *
+ * For devices where the AUX channel is a device that exists independently of the &drm_device that
+ * uses it, such as SoCs and bridge devices, it is recommended to call drm_dp_aux_register() after a
+ * &drm_device has been assigned to &drm_dp_aux.drm_dev, and likewise to call
+ * drm_dp_aux_unregister() once the &drm_device should no longer be associated with the AUX channel
+ * (e.g. on bridge detach).
+ *
+ * Drivers which need to use the aux channel before either of the two points mentioned above need to
+ * call drm_dp_aux_init() in order to use the AUX channel before registration.
  *
  * Returns 0 on success or a negative error code on failure.
  */
-- 
2.29.2

