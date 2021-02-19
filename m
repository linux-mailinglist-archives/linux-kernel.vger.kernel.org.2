Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F8F3200EC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 22:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhBSVzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 16:55:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41935 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229796AbhBSVze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 16:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613771646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xF0OfrnlVmd/DfJPvqmHtCe3vZ4VRsC929jG9IY3Pkw=;
        b=NBXLJC7gYRb7+Pim1zsi3OLxgq5Q1nilaFXNIYR8tnNtJiOl9MUrzSFpkFtUnkqRC+UsDh
        UE1QNm95L/ZGehdpcsgkmLrxv4E/GwtYXBKW5+usQORmhxFbP1QB42nm6AOCeTSm4a9V2c
        K8Zz1JJTTtDV5cH1v/vGTc8rMhnmKdI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-mA2a1WUFNcaPO_UpkM-fRA-1; Fri, 19 Feb 2021 16:54:04 -0500
X-MC-Unique: mA2a1WUFNcaPO_UpkM-fRA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58DF9107ACE3;
        Fri, 19 Feb 2021 21:54:01 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-118-5.rdu2.redhat.com [10.10.118.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A18266A03C;
        Fri, 19 Feb 2021 21:53:58 +0000 (UTC)
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
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Jyri Sarha <jsarha@ti.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 05/30] drm/bridge/cdns-mhdp8546: Register DP aux channel with userspace
Date:   Fri, 19 Feb 2021 16:53:01 -0500
Message-Id: <20210219215326.2227596-6-lyude@redhat.com>
In-Reply-To: <20210219215326.2227596-1-lyude@redhat.com>
References: <20210219215326.2227596-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just adds some missing calls to
drm_dp_aux_register()/drm_dp_aux_unregister() for when we attach/detach the
bridge.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 989a05bc8197..d966a33743b5 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -1674,10 +1674,14 @@ static int cdns_mhdp_attach(struct drm_bridge *bridge,
 
 	dev_dbg(mhdp->dev, "%s\n", __func__);
 
+	ret = drm_dp_aux_register(&mhdp->aux);
+	if (ret < 0)
+		return ret;
+
 	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
 		ret = cdns_mhdp_connector_init(mhdp);
 		if (ret)
-			return ret;
+			goto aux_unregister;
 	}
 
 	spin_lock(&mhdp->start_lock);
@@ -1693,6 +1697,9 @@ static int cdns_mhdp_attach(struct drm_bridge *bridge,
 		       mhdp->regs + CDNS_APB_INT_MASK);
 
 	return 0;
+aux_unregister:
+	drm_dp_aux_unregister(&mhdp->aux);
+	return ret;
 }
 
 static void cdns_mhdp_configure_video(struct cdns_mhdp_device *mhdp,
@@ -2025,6 +2032,8 @@ static void cdns_mhdp_detach(struct drm_bridge *bridge)
 
 	dev_dbg(mhdp->dev, "%s\n", __func__);
 
+	drm_dp_aux_unregister(&mhdp->aux);
+
 	spin_lock(&mhdp->start_lock);
 
 	mhdp->bridge_attached = false;
-- 
2.29.2

