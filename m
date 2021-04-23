Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C3A369A03
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 20:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243715AbhDWSop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 14:44:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52227 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232582AbhDWSon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 14:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619203446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aa/xpaugDkXS10SSva9ajht1412w7bsX84a2n7VZ2vU=;
        b=E7n2FEE/AbnzDdMjMs7qXxCahYZXVdCnKHEvKp0AQjVkcmRM+Nr4nxrlZZALY8eumRqzKD
        0I6vCnmLj/bffs98V0TVuZduv3aDCKiz6JLRh3rafbIQV1ZouVCrkObYiCggIN9LohFjQR
        qCjaK9NuEbnlRWgcCXuduCG3FrbaALk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-wTjm5n51Nhu4_gUao07yHg-1; Fri, 23 Apr 2021 14:44:05 -0400
X-MC-Unique: wTjm5n51Nhu4_gUao07yHg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3887179EC0;
        Fri, 23 Apr 2021 18:44:03 +0000 (UTC)
Received: from Ruby.lyude.net (ovpn-114-74.rdu2.redhat.com [10.10.114.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2097F60CCD;
        Fri, 23 Apr 2021 18:44:01 +0000 (UTC)
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
Subject: [PATCH v4 04/17] drm/dp: Clarify DP AUX registration time
Date:   Fri, 23 Apr 2021 14:42:56 -0400
Message-Id: <20210423184309.207645-5-lyude@redhat.com>
In-Reply-To: <20210423184309.207645-1-lyude@redhat.com>
References: <20210423184309.207645-1-lyude@redhat.com>
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
 drivers/gpu/drm/drm_dp_helper.c | 45 +++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index ad73d7264743..9f66153a3c55 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -1728,10 +1728,18 @@ EXPORT_SYMBOL(drm_dp_remote_aux_init);
  * drm_dp_aux_init() - minimally initialise an aux channel
  * @aux: DisplayPort AUX channel
  *
- * If you need to use the drm_dp_aux's i2c adapter prior to registering it
- * with the outside world, call drm_dp_aux_init() first. You must still
- * call drm_dp_aux_register() once the connector has been registered to
- * allow userspace access to the auxiliary DP channel.
+ * If you need to use the drm_dp_aux's i2c adapter prior to registering it with
+ * the outside world, call drm_dp_aux_init() first. For drivers which are
+ * grandparents to their AUX adapters (e.g. the AUX adapter is parented by a
+ * &drm_connector), you must still call drm_dp_aux_register() once the connector
+ * has been registered to allow userspace access to the auxiliary DP channel.
+ * Likewise, for such drivers you should also assign &drm_dp_aux.drm_dev as
+ * early as possible so that the &drm_device that corresponds to the AUX adapter
+ * may be mentioned in debugging output from the DRM DP helpers.
+ *
+ * For devices which use a separate platform device for their AUX adapters, this
+ * may be called as early as required by the driver.
+ *
  */
 void drm_dp_aux_init(struct drm_dp_aux *aux)
 {
@@ -1751,15 +1759,26 @@ EXPORT_SYMBOL(drm_dp_aux_init);
  * drm_dp_aux_register() - initialise and register aux channel
  * @aux: DisplayPort AUX channel
  *
- * Automatically calls drm_dp_aux_init() if this hasn't been done yet.
- * This should only be called when the underlying &struct drm_connector is
- * initialiazed already. Therefore the best place to call this is from
- * &drm_connector_funcs.late_register. Not that drivers which don't follow this
- * will Oops when CONFIG_DRM_DP_AUX_CHARDEV is enabled.
- *
- * Drivers which need to use the aux channel before that point (e.g. at driver
- * load time, before drm_dev_register() has been called) need to call
- * drm_dp_aux_init().
+ * Automatically calls drm_dp_aux_init() if this hasn't been done yet. This
+ * should only be called once the parent of @aux, &drm_dp_aux.dev, is
+ * initialized. For devices which are grandparents of their AUX channels,
+ * &drm_dp_aux.dev will typically be the &drm_connector &device which
+ * corresponds to @aux. For these devices, it's advised to call
+ * drm_dp_aux_register() in &drm_connector_funcs.late_register, and likewise to
+ * call drm_dp_aux_unregister() in &drm_connector_funcs.early_unregister.
+ * Functions which don't follow this will likely Oops when
+ * %CONFIG_DRM_DP_AUX_CHARDEV is enabled.
+ *
+ * For devices where the AUX channel is a device that exists independently of
+ * the &drm_device that uses it, such as SoCs and bridge devices, it is
+ * recommended to call drm_dp_aux_register() after a &drm_device has been
+ * assigned to &drm_dp_aux.drm_dev, and likewise to call
+ * drm_dp_aux_unregister() once the &drm_device should no longer be associated
+ * with the AUX channel (e.g. on bridge detach).
+ *
+ * Drivers which need to use the aux channel before either of the two points
+ * mentioned above need to call drm_dp_aux_init() in order to use the AUX
+ * channel before registration.
  *
  * Returns 0 on success or a negative error code on failure.
  */
-- 
2.30.2

