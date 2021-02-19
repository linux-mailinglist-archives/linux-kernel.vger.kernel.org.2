Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5893200EF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 22:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhBSVzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 16:55:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40968 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229649AbhBSVzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 16:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613771653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z5cOikk7Dn1pZpQyq/vuZUV78NfThhlat10M7LZW1ck=;
        b=H/H4uLNqwqbbo/2UiyLNHxtD7zD0ZKrHh/NJGjV2g243VpKEvo+QDIgmxc2/nswaFjHXDW
        Kr1ZnEC4CwZOHjBopSD6/eE9w9jGZzutVgikX2+YQaKaN2H/tn5Dkx3Hk9XvzD/kYjokeI
        z9YJtOEguoWY9JbNLOx8TVcyu4dK7WY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-O6KSchbwO9eiHP1mA92Pkg-1; Fri, 19 Feb 2021 16:53:57 -0500
X-MC-Unique: O6KSchbwO9eiHP1mA92Pkg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4A52801B0F;
        Fri, 19 Feb 2021 21:53:52 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-118-5.rdu2.redhat.com [10.10.118.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66B376A03C;
        Fri, 19 Feb 2021 21:53:50 +0000 (UTC)
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
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 04/30] drm/bridge/tc358767: Don't register DP AUX channel until bridge is attached
Date:   Fri, 19 Feb 2021 16:53:00 -0500
Message-Id: <20210219215326.2227596-5-lyude@redhat.com>
In-Reply-To: <20210219215326.2227596-1-lyude@redhat.com>
References: <20210219215326.2227596-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this is a bridge, we don't start out with a respective DRM device.
Likewise this means we don't have a connector, which also means that we
should be following drm_dp_aux_register()'s documentation advice and not
call drm_dp_aux_register() until we have a matching connector. Instead,
call drm_dp_aux_init() in tc_probe() and wait until tc_bridge_attach() to
register our AUX channel. We also add tc_bridge_detach() to handle
unregistering the AUX adapter once the bridge has been disconnected.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/bridge/tc358767.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 34a3e4e9f717..da89922721ed 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1414,11 +1414,15 @@ static int tc_bridge_attach(struct drm_bridge *bridge,
 	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
 		return 0;
 
+	ret = drm_dp_aux_register(&tc->aux);
+	if (ret < 0)
+		return ret;
+
 	/* Create DP/eDP connector */
 	drm_connector_helper_add(&tc->connector, &tc_connector_helper_funcs);
 	ret = drm_connector_init(drm, &tc->connector, &tc_connector_funcs, tc->bridge.type);
 	if (ret)
-		return ret;
+		goto aux_unregister;
 
 	/* Don't poll if don't have HPD connected */
 	if (tc->hpd_pin >= 0) {
@@ -1438,10 +1442,19 @@ static int tc_bridge_attach(struct drm_bridge *bridge,
 	drm_connector_attach_encoder(&tc->connector, tc->bridge.encoder);
 
 	return 0;
+aux_unregister:
+	drm_dp_aux_unregister(&tc->aux);
+	return ret;
+}
+
+static void tc_bridge_detach(struct drm_bridge *bridge)
+{
+	drm_dp_aux_unregister(&bridge_to_tc(bridge)->aux);
 }
 
 static const struct drm_bridge_funcs tc_bridge_funcs = {
 	.attach = tc_bridge_attach,
+	.detach = tc_bridge_detach,
 	.mode_valid = tc_mode_valid,
 	.mode_set = tc_bridge_mode_set,
 	.enable = tc_bridge_enable,
@@ -1680,9 +1693,7 @@ static int tc_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	tc->aux.name = "TC358767 AUX i2c adapter";
 	tc->aux.dev = tc->dev;
 	tc->aux.transfer = tc_aux_transfer;
-	ret = drm_dp_aux_register(&tc->aux);
-	if (ret)
-		return ret;
+	drm_dp_aux_init(&tc->aux);
 
 	tc->bridge.funcs = &tc_bridge_funcs;
 	if (tc->hpd_pin >= 0)
@@ -1702,7 +1713,6 @@ static int tc_remove(struct i2c_client *client)
 	struct tc_data *tc = i2c_get_clientdata(client);
 
 	drm_bridge_remove(&tc->bridge);
-	drm_dp_aux_unregister(&tc->aux);
 
 	return 0;
 }
-- 
2.29.2

