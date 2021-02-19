Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB27320105
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 22:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhBSV6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 16:58:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59694 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229991AbhBSV41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 16:56:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613771699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1214w8APJrcueajcIeVTgK0DUmGMosHVVIbLwPSdf9k=;
        b=VJrNVtXQpNe/V+L0CRTnokrIWwbrPdG1SCe+Q4gh8PpfEUBGUBeG0RHUfRJjR7s0biSIDa
        M8IQ3CD4NG53cHzisWDCU4bRnVYIrZ6X+yhBWry0R1IW/LkZAjVnbLMuQzjM1TXvH1SYzg
        Sb47Vl9uS4BzZ4TSnyDDiKe2VJX0cz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-6kjZs9Z6N2GllGuQsYy0cQ-1; Fri, 19 Feb 2021 16:54:57 -0500
X-MC-Unique: 6kjZs9Z6N2GllGuQsYy0cQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83088EC1A1;
        Fri, 19 Feb 2021 21:54:55 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-118-5.rdu2.redhat.com [10.10.118.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 176876A03C;
        Fri, 19 Feb 2021 21:54:54 +0000 (UTC)
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
Subject: [PATCH 16/30] drm/dp: Rewrap drm_dp_aux_register()/drm_dp_aux_init() kdocs
Date:   Fri, 19 Feb 2021 16:53:12 -0500
Message-Id: <20210219215326.2227596-17-lyude@redhat.com>
In-Reply-To: <20210219215326.2227596-1-lyude@redhat.com>
References: <20210219215326.2227596-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're about to make a correction to these, so let's rewrap the kernel docs
for these while we're at it.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_helper.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index eedbb48815b7..17f5d1296ff1 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -1728,10 +1728,9 @@ EXPORT_SYMBOL(drm_dp_remote_aux_init);
  * drm_dp_aux_init() - minimally initialise an aux channel
  * @aux: DisplayPort AUX channel
  *
- * If you need to use the drm_dp_aux's i2c adapter prior to registering it
- * with the outside world, call drm_dp_aux_init() first. You must still
- * call drm_dp_aux_register() once the connector has been registered to
- * allow userspace access to the auxiliary DP channel.
+ * If you need to use the drm_dp_aux's i2c adapter prior to registering it with the outside world,
+ * call drm_dp_aux_init() first. You must still call drm_dp_aux_register() once the connector has
+ * been registered to allow userspace access to the auxiliary DP channel.
  */
 void drm_dp_aux_init(struct drm_dp_aux *aux)
 {
@@ -1751,15 +1750,13 @@ EXPORT_SYMBOL(drm_dp_aux_init);
  * drm_dp_aux_register() - initialise and register aux channel
  * @aux: DisplayPort AUX channel
  *
- * Automatically calls drm_dp_aux_init() if this hasn't been done yet.
- * This should only be called when the underlying &struct drm_connector is
- * initialiazed already. Therefore the best place to call this is from
- * &drm_connector_funcs.late_register. Not that drivers which don't follow this
+ * Automatically calls drm_dp_aux_init() if this hasn't been done yet. This should only be called
+ * when the underlying &struct drm_connector is initialiazed already. Therefore the best place to
+ * call this is from &drm_connector_funcs.late_register. Not that drivers which don't follow this
  * will Oops when CONFIG_DRM_DP_AUX_CHARDEV is enabled.
  *
- * Drivers which need to use the aux channel before that point (e.g. at driver
- * load time, before drm_dev_register() has been called) need to call
- * drm_dp_aux_init().
+ * Drivers which need to use the aux channel before that point (e.g. at driver load time, before
+ * drm_dev_register() has been called) need to call drm_dp_aux_init().
  *
  * Returns 0 on success or a negative error code on failure.
  */
-- 
2.29.2

