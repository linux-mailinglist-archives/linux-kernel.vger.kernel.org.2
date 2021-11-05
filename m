Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231B744686E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 19:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhKEShB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 14:37:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51629 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231517AbhKESgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 14:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636137255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IVs9bIfsLwBSC1ngdG5iKdy/zSgVH32ou/PHj3hR09M=;
        b=WQADmfi0A1/YMVkeoHZsml2/5Vx3jSj+tt4kyHO7RALEE7wnzo2AhISn0r8Occm1yFtZRB
        8u5MMaHBjsfwBh8dVJJJhXnAzEmwXIPWXA7f4rIW31FCl+rf1OcG6BeadbBFhOwuH97cbY
        BXayVeYsNwmpgMMTuU0mvbLZo/3US/I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-OEnp-0VUPbWoRkwMF6zAFA-1; Fri, 05 Nov 2021 14:34:12 -0400
X-MC-Unique: OEnp-0VUPbWoRkwMF6zAFA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C9651B2C980;
        Fri,  5 Nov 2021 18:34:11 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.16.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01BD85C23A;
        Fri,  5 Nov 2021 18:34:06 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Karol Herbst <kherbst@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 2/5] drm/nouveau/kms/nv50-: Explicitly check DPCD backlights for aux enable/brightness
Date:   Fri,  5 Nov 2021 14:33:39 -0400
Message-Id: <20211105183342.130810-3-lyude@redhat.com>
In-Reply-To: <20211105183342.130810-1-lyude@redhat.com>
References: <20211105183342.130810-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we don't support hybrid AUX/PWM backlights in nouveau right now,
let's add some explicit checks so that we don't break nouveau once we
enable support for these backlights in other drivers.

Reviewed-by: Karol Herbst <kherbst@redhat.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_backlight.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
index 1cbd71abc80a..ae2f2abc8f5a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
+++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
@@ -308,7 +308,10 @@ nv50_backlight_init(struct nouveau_backlight *bl,
 		if (ret < 0)
 			return ret;
 
-		if (drm_edp_backlight_supported(edp_dpcd)) {
+		/* TODO: Add support for hybrid PWM/DPCD panels */
+		if (drm_edp_backlight_supported(edp_dpcd) &&
+		    (edp_dpcd[1] & DP_EDP_BACKLIGHT_AUX_ENABLE_CAP) &&
+		    (edp_dpcd[2] & DP_EDP_BACKLIGHT_BRIGHTNESS_AUX_SET_CAP)) {
 			NV_DEBUG(drm, "DPCD backlight controls supported on %s\n",
 				 nv_conn->base.name);
 
-- 
2.31.1

