Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C5E320101
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 22:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhBSV51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 16:57:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29978 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229913AbhBSVzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 16:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613771669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=948IrOV8AEQxRpk+LqQM+f22SO+F73jbZfD3a6okG8w=;
        b=Qk1zHjgZgpLMnIvrdJbJ3VOZRzI9q67VrXEE9hpSeq8Jr/wj2JprUhF+koPxij4RsFxV9H
        CqHnQTcBYpe9jdD/JpSX6S3DHpRen7hGBi7XPZSIAd2XLkamaUisAToZRLQiDhGlIMof/J
        f8yPRzwGbFnOOSdA28sOJRpjBsZDNxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-iMXl3N1SNA6nxY0_TMzQvg-1; Fri, 19 Feb 2021 16:54:27 -0500
X-MC-Unique: iMXl3N1SNA6nxY0_TMzQvg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3A671020C20;
        Fri, 19 Feb 2021 21:54:24 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-118-5.rdu2.redhat.com [10.10.118.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9FEE6EF55;
        Fri, 19 Feb 2021 21:54:22 +0000 (UTC)
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
        Sam Ravnborg <sam@ravnborg.org>, Torsten Duwe <duwe@lst.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Joe Perches <joe@perches.com>, Icenowy Zheng <icenowy@aosc.io>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 12/30] drm/bridge/analogix/anx6345: Cleanup on errors in anx6345_bridge_attach()
Date:   Fri, 19 Feb 2021 16:53:08 -0500
Message-Id: <20210219215326.2227596-13-lyude@redhat.com>
In-Reply-To: <20210219215326.2227596-1-lyude@redhat.com>
References: <20210219215326.2227596-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another drive-by fix I found when fixing DP AUX adapter across the kernel
tree - make sure we don't leak resources (and by proxy-AUX adapters) on
failures in anx6345_bridge_attach() by unrolling on errors.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
index 6258f16da0e8..aa6cda458eb9 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
@@ -550,7 +550,7 @@ static int anx6345_bridge_attach(struct drm_bridge *bridge,
 				 DRM_MODE_CONNECTOR_eDP);
 	if (err) {
 		DRM_ERROR("Failed to initialize connector: %d\n", err);
-		return err;
+		goto aux_unregister;
 	}
 
 	drm_connector_helper_add(&anx6345->connector,
@@ -562,16 +562,21 @@ static int anx6345_bridge_attach(struct drm_bridge *bridge,
 					   bridge->encoder);
 	if (err) {
 		DRM_ERROR("Failed to link up connector to encoder: %d\n", err);
-		return err;
+		goto connector_cleanup;
 	}
 
 	err = drm_connector_register(&anx6345->connector);
 	if (err) {
 		DRM_ERROR("Failed to register connector: %d\n", err);
-		return err;
+		goto connector_cleanup;
 	}
 
 	return 0;
+connector_cleanup:
+	drm_connector_cleanup(&anx6345->connector);
+aux_unregister:
+	drm_dp_aux_unregister(&anx6345->aux);
+	return err;
 }
 
 static void anx6345_bridge_detach(struct drm_bridge *bridge)
-- 
2.29.2

