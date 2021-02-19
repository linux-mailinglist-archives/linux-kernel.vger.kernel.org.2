Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D6F3200FB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 22:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhBSV4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 16:56:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58195 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229886AbhBSVzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 16:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613771660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yqrvg6oBBIK95MSB53UzOrhjDOM9evvbR5uL/I7AFzg=;
        b=U/gHMewJB6JVLsPv3FEHu1r/opq+Mfehc5jxbzdj7uNpd/jLIvzH53FsJ5yCyg7y/wUjR7
        EDVR56C+mGxUrGONlUiPEAbxajnNnGO8999unuVJBpAzeX6B3x4tUNnyidLSEs3xrOb6wj
        LtziGzmzuVKo9fteKLytip/gbq7r/Co=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-kCi7ec4_OfiPnys6rI3Mtg-1; Fri, 19 Feb 2021 16:54:16 -0500
X-MC-Unique: kCi7ec4_OfiPnys6rI3Mtg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3B1DDF8DD;
        Fri, 19 Feb 2021 21:54:13 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-118-5.rdu2.redhat.com [10.10.118.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C030D6A03C;
        Fri, 19 Feb 2021 21:54:11 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sam Ravnborg <sam@ravnborg.org>, Torsten Duwe <duwe@lst.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 09/30] drm/bridge/analogix/anx78xx: Cleanup on error in anx78xx_bridge_attach()
Date:   Fri, 19 Feb 2021 16:53:05 -0500
Message-Id: <20210219215326.2227596-10-lyude@redhat.com>
In-Reply-To: <20210219215326.2227596-1-lyude@redhat.com>
References: <20210219215326.2227596-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just another issue I noticed while correcting usages of
drm_dp_aux_init()/drm_dp_aux_register() around the tree. If any of the
steps in anx78xx_bridge_attach() fail, we end up leaking resources. So,
let's fix that (and fix leaking a DP AUX adapter in the process) by
unrolling on errors.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
index 338dd8531d4b..f20558618220 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
@@ -918,7 +918,7 @@ static int anx78xx_bridge_attach(struct drm_bridge *bridge,
 				 DRM_MODE_CONNECTOR_DisplayPort);
 	if (err) {
 		DRM_ERROR("Failed to initialize connector: %d\n", err);
-		return err;
+		goto aux_unregister;
 	}
 
 	drm_connector_helper_add(&anx78xx->connector,
@@ -930,16 +930,21 @@ static int anx78xx_bridge_attach(struct drm_bridge *bridge,
 					   bridge->encoder);
 	if (err) {
 		DRM_ERROR("Failed to link up connector to encoder: %d\n", err);
-		return err;
+		goto connector_cleanup;
 	}
 
 	err = drm_connector_register(&anx78xx->connector);
 	if (err) {
 		DRM_ERROR("Failed to register connector: %d\n", err);
-		return err;
+		goto connector_cleanup;
 	}
 
 	return 0;
+connector_cleanup:
+	drm_connector_cleanup(&anx78xx->connector);
+aux_unregister:
+	drm_dp_aux_unregister(&anx78xx->aux);
+	return err;
 }
 
 static void anx78xx_bridge_detach(struct drm_bridge *bridge)
-- 
2.29.2

