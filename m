Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC1F311A99
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhBFEAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:00:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26135 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231962AbhBFC62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:58:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612580221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oKm0Ja8X4Ojgn+JREDsvj+rdNkNRQb5M2c2kSDsJ3+k=;
        b=HyDuj76Ikis6YLHqvmTA+kvsMK3Yr04CcrT6DrkMwnlCvcDS3FS9og7S5I6sB3vb7nD2FB
        Q//3HvOTV7QeJ3j9Kv/38hytl7La8yTVd65tjMCJ0kiDrdBTdwDi1FfwQWKUhUVjXKNGcT
        9Ydn/9xIa2baodKqQ4r098MK/zNgc+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-bQvA3uDcNlmQDUcWV15c6A-1; Fri, 05 Feb 2021 18:45:25 -0500
X-MC-Unique: bQvA3uDcNlmQDUcWV15c6A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D468484E241;
        Fri,  5 Feb 2021 23:45:23 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-116-79.rdu2.redhat.com [10.10.116.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D724819727;
        Fri,  5 Feb 2021 23:45:21 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Dave Airlie <airlied@gmail.com>, greg.depoire@gmail.com,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v3 01/10] drm/nouveau/kms/nv40-/backlight: Assign prop type once
Date:   Fri,  5 Feb 2021 18:45:05 -0500
Message-Id: <20210205234515.1216538-2-lyude@redhat.com>
In-Reply-To: <20210205234515.1216538-1-lyude@redhat.com>
References: <20210205234515.1216538-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Dave Airlie <airlied@gmail.com>
Cc: greg.depoire@gmail.com
---
 drivers/gpu/drm/nouveau/nouveau_backlight.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
index 72f35a2babcb..42b498e7e2bf 100644
--- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
+++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
@@ -106,7 +106,6 @@ nv40_backlight_init(struct nouveau_encoder *encoder,
 	if (!(nvif_rd32(device, NV40_PMC_BACKLIGHT) & NV40_PMC_BACKLIGHT_MASK))
 		return -ENODEV;
 
-	props->type = BACKLIGHT_RAW;
 	props->max_brightness = 31;
 	*ops = &nv40_bl_ops;
 	return 0;
@@ -212,7 +211,6 @@ nv50_backlight_init(struct nouveau_encoder *nv_encoder,
 	else
 		*ops = &nva3_bl_ops;
 
-	props->type = BACKLIGHT_RAW;
 	props->max_brightness = 100;
 
 	return 0;
@@ -226,7 +224,7 @@ nouveau_backlight_init(struct drm_connector *connector)
 	struct nouveau_encoder *nv_encoder = NULL;
 	struct nvif_device *device = &drm->client.device;
 	char backlight_name[BL_NAME_SIZE];
-	struct backlight_properties props = {0};
+	struct backlight_properties props = { .type = BACKLIGHT_RAW, 0 };
 	const struct backlight_ops *ops;
 	int ret;
 
-- 
2.29.2

