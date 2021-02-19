Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0263200F1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 22:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhBSVzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 16:55:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229812AbhBSVzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 16:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613771653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wm4oY60HDEi6MJ6NUR2B395ZKlrMFtTCO2to+5mcRtw=;
        b=hN7L/3CjslxNvaWvoGbG5SLLOlILYfnGzfrYlljt2mueycY3UayQ4l5b5upou9EFj23U9f
        mjF+rDnbokXzEQmyGhk37HlVHwSzRCtllreWnMTLQ1wcpuAIw7BFYOQmCUr4QtQEJGO2I8
        M7gButMbVxa3JJQSBpa7Zml1hyVSlUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-c3LkErexM3We81p-4siIng-1; Fri, 19 Feb 2021 16:54:10 -0500
X-MC-Unique: c3LkErexM3We81p-4siIng-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 110AE1B2C98A;
        Fri, 19 Feb 2021 21:54:07 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-118-5.rdu2.redhat.com [10.10.118.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BDAE16A03C;
        Fri, 19 Feb 2021 21:54:04 +0000 (UTC)
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
        Sam Ravnborg <sam@ravnborg.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Torsten Duwe <duwe@lst.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 07/30] drm/bridge/analogix/anx78xx: Add missing drm_dp_aux_unregister() call
Date:   Fri, 19 Feb 2021 16:53:03 -0500
Message-Id: <20210219215326.2227596-8-lyude@redhat.com>
In-Reply-To: <20210219215326.2227596-1-lyude@redhat.com>
References: <20210219215326.2227596-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Surprisingly, this bridge actually registers it's AUX adapter at the
correct time already. Nice job! However, it does forget to actually
unregister the AUX adapter, so let's add a bridge function to handle that.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
index 81debd02c169..ec4607dc01eb 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
@@ -942,6 +942,11 @@ static int anx78xx_bridge_attach(struct drm_bridge *bridge,
 	return 0;
 }
 
+static void anx78xx_bridge_detach(struct drm_bridge *bridge)
+{
+	drm_dp_aux_unregister(&bridge_to_anx78xx(bridge)->aux);
+}
+
 static enum drm_mode_status
 anx78xx_bridge_mode_valid(struct drm_bridge *bridge,
 			  const struct drm_display_info *info,
@@ -1013,6 +1018,7 @@ static void anx78xx_bridge_enable(struct drm_bridge *bridge)
 
 static const struct drm_bridge_funcs anx78xx_bridge_funcs = {
 	.attach = anx78xx_bridge_attach,
+	.detach = anx78xx_bridge_detach,
 	.mode_valid = anx78xx_bridge_mode_valid,
 	.disable = anx78xx_bridge_disable,
 	.mode_set = anx78xx_bridge_mode_set,
-- 
2.29.2

