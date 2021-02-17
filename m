Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBDC531D994
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 13:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhBQMfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 07:35:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53617 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232657AbhBQMdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 07:33:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613565144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ps0qnLl0Vg7nky00C03wCQu+tKKDC6GWGs6Nzz0kPq0=;
        b=KRK4oFfzaf/2Rxqcb1q3pGnihzsoEoz7tvnZYtO3y0REaFfxk1NJ/xRV1UFd81CvLKg7M7
        oszbZPWAJEfJSSV8ZjCioshpH8NpAdyfkmL53znmHo4uGwlhxf7Y7qxUsbMKd5VI8MZSQ6
        0lAm6qw5YnCS0+/sjbRQoUGUTXcJluU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-LeF7OvwsNt6SyXxzpk5-SQ-1; Wed, 17 Feb 2021 07:32:21 -0500
X-MC-Unique: LeF7OvwsNt6SyXxzpk5-SQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE66A6D4E6;
        Wed, 17 Feb 2021 12:32:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-184.ams2.redhat.com [10.36.114.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A03CB60853;
        Wed, 17 Feb 2021 12:32:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id AD1EB18003BB; Wed, 17 Feb 2021 13:32:14 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 07/11] drm/qxl: fix prime vmap
Date:   Wed, 17 Feb 2021 13:32:09 +0100
Message-Id: <20210217123213.2199186-8-kraxel@redhat.com>
In-Reply-To: <20210217123213.2199186-1-kraxel@redhat.com>
References: <20210217123213.2199186-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct vmap variant.  We don't have a reservation here,
so we can't use the _locked version.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/qxl/qxl_prime.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_prime.c b/drivers/gpu/drm/qxl/qxl_prime.c
index 2bebe662516f..0628d1cc91fe 100644
--- a/drivers/gpu/drm/qxl/qxl_prime.c
+++ b/drivers/gpu/drm/qxl/qxl_prime.c
@@ -59,7 +59,7 @@ int qxl_gem_prime_vmap(struct drm_gem_object *obj, struct dma_buf_map *map)
 	struct qxl_bo *bo = gem_to_qxl_bo(obj);
 	int ret;
 
-	ret = qxl_bo_vmap_locked(bo, map);
+	ret = qxl_bo_vmap(bo, map);
 	if (ret < 0)
 		return ret;
 
@@ -71,7 +71,7 @@ void qxl_gem_prime_vunmap(struct drm_gem_object *obj,
 {
 	struct qxl_bo *bo = gem_to_qxl_bo(obj);
 
-	qxl_bo_vunmap_locked(bo);
+	qxl_bo_vunmap(bo);
 }
 
 int qxl_gem_prime_mmap(struct drm_gem_object *obj,
-- 
2.29.2

