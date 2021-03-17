Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B72A33FB9C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 00:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhCQXCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 19:02:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50320 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229494AbhCQXCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 19:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616022122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pj6xifRYunGEycUYuurZ3sRU46oa4ZyECyQnLvPC/K8=;
        b=KmPlIPCSUO//pUStagn9uomGRts5yIKk0xNEyPb1i4fo5kvgttFZHoI6m/0pfP8D21H58f
        8xJ+RjlEwkcjwfU8QtFt2/H73jzWCTxoKofvIi4tFUdy8bcDeSpAYeympII4THi8JOa9CM
        zbRCeTRcfTcsXQsD/3WVJSJzUmoXitY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-oFcJVhP8MuC0N_5PqFTciA-1; Wed, 17 Mar 2021 19:01:57 -0400
X-MC-Unique: oFcJVhP8MuC0N_5PqFTciA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64FF6108BD07;
        Wed, 17 Mar 2021 23:01:54 +0000 (UTC)
Received: from Whitewolf.lyude.net (ovpn-119-60.rdu2.redhat.com [10.10.119.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA0B6610F0;
        Wed, 17 Mar 2021 23:01:52 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Martin Peres <martin.peres@free.fr>,
        Jeremy Cline <jcline@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Maxime Ripard <maxime@cerno.tech>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/nouveau/kms/nv50-: Use NV_ATOMIC() in nv50_head_atomic_check_lut()
Date:   Wed, 17 Mar 2021 19:01:45 -0400
Message-Id: <20210317230146.504182-2-lyude@redhat.com>
In-Reply-To: <20210317230146.504182-1-lyude@redhat.com>
References: <20210317230146.504182-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this is used in the atomic check, we should use the right debug macro
for it.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Martin Peres <martin.peres@free.fr>
Cc: Jeremy Cline <jcline@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/head.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/head.c b/drivers/gpu/drm/nouveau/dispnv50/head.c
index ec361d17e900..fb821dcf6bd2 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/head.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/head.c
@@ -221,7 +221,10 @@ static int
 nv50_head_atomic_check_lut(struct nv50_head *head,
 			   struct nv50_head_atom *asyh)
 {
-	struct nv50_disp *disp = nv50_disp(head->base.base.dev);
+	struct drm_device *dev = head->base.base.dev;
+	struct drm_crtc *crtc = &head->base.base;
+	struct nv50_disp *disp = nv50_disp(dev);
+	struct nouveau_drm *drm = nouveau_drm(dev);
 	struct drm_property_blob *olut = asyh->state.gamma_lut;
 	int size;
 
@@ -251,7 +254,8 @@ nv50_head_atomic_check_lut(struct nv50_head *head,
 	}
 
 	if (!head->func->olut(head, asyh, size)) {
-		DRM_DEBUG_KMS("Invalid olut\n");
+		NV_ATOMIC(drm, "Invalid size %d for gamma on [CRTC:%d:%s]\n",
+			  size, crtc->base.id, crtc->name);
 		return -EINVAL;
 	}
 	asyh->olut.handle = disp->core->chan.vram.handle;
-- 
2.29.2

