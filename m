Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD32B31C9FB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 12:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhBPLmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 06:42:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29441 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230376AbhBPLi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 06:38:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613475450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2KPW0s8srkPK+oIjW73R/hOS007fqavsKuim9JgrbsM=;
        b=S4VaHKtN2IYerSUF0GcD61jIp3+TRhYIqMYlJjsRLgMEe7Rcr4LxzTbvYg/MGgYiMMXy7r
        rWZqPy08IATIQzWbZmFVGRkhojvhXZKFnkPSVHz2fw9UyM0pPYhelkku6Myhwzt7kdy6Ig
        F0WE7z3sAqmh+yUkIcmloRt7LWujZZk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-ThBwyDJ3Oh2glP8w9lMyTg-1; Tue, 16 Feb 2021 06:37:26 -0500
X-MC-Unique: ThBwyDJ3Oh2glP8w9lMyTg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7A0F80196C;
        Tue, 16 Feb 2021 11:37:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-184.ams2.redhat.com [10.36.114.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A6F619C99;
        Tue, 16 Feb 2021 11:37:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 2BBF218003BE; Tue, 16 Feb 2021 12:37:18 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 06/10] drm/qxl: add qxl_bo_kmap/qxl_bo_kunmap
Date:   Tue, 16 Feb 2021 12:37:12 +0100
Message-Id: <20210216113716.716996-7-kraxel@redhat.com>
In-Reply-To: <20210216113716.716996-1-kraxel@redhat.com>
References: <20210216113716.716996-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kmap/kunmap variants which reserve (and pin) the bo.
They can be used in case the caller doesn't hold a reservation
for the bo.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_object.h |  2 ++
 drivers/gpu/drm/qxl/qxl_object.c | 36 ++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_object.h b/drivers/gpu/drm/qxl/qxl_object.h
index 5bd33650183f..360972ae4869 100644
--- a/drivers/gpu/drm/qxl/qxl_object.h
+++ b/drivers/gpu/drm/qxl/qxl_object.h
@@ -64,7 +64,9 @@ extern int qxl_bo_create(struct qxl_device *qdev,
 			 u32 priority,
 			 struct qxl_surface *surf,
 			 struct qxl_bo **bo_ptr);
+extern int qxl_bo_kmap(struct qxl_bo *bo, struct dma_buf_map *map);
 extern int qxl_bo_kmap_locked(struct qxl_bo *bo, struct dma_buf_map *map);
+extern int qxl_bo_kunmap(struct qxl_bo *bo);
 extern void qxl_bo_kunmap_locked(struct qxl_bo *bo);
 void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev, struct qxl_bo *bo, int page_offset);
 void qxl_bo_kunmap_atomic_page(struct qxl_device *qdev, struct qxl_bo *bo, void *map);
diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index b56d4dfc28cb..22748b9566af 100644
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -29,6 +29,9 @@
 #include "qxl_drv.h"
 #include "qxl_object.h"
 
+static int __qxl_bo_pin(struct qxl_bo *bo);
+static void __qxl_bo_unpin(struct qxl_bo *bo);
+
 static void qxl_ttm_bo_destroy(struct ttm_buffer_object *tbo)
 {
 	struct qxl_bo *bo;
@@ -179,6 +182,25 @@ int qxl_bo_kmap_locked(struct qxl_bo *bo, struct dma_buf_map *map)
 	return 0;
 }
 
+int qxl_bo_kmap(struct qxl_bo *bo, struct dma_buf_map *map)
+{
+	int r;
+
+	r = qxl_bo_reserve(bo);
+	if (r)
+		return r;
+
+	r = __qxl_bo_pin(bo);
+	if (r) {
+		qxl_bo_unreserve(bo);
+		return r;
+	}
+
+	r = qxl_bo_kmap_locked(bo, map);
+	qxl_bo_unreserve(bo);
+	return r;
+}
+
 void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev,
 			      struct qxl_bo *bo, int page_offset)
 {
@@ -223,6 +245,20 @@ void qxl_bo_kunmap_locked(struct qxl_bo *bo)
 	ttm_bo_vunmap(&bo->tbo, &bo->map);
 }
 
+int qxl_bo_kunmap(struct qxl_bo *bo)
+{
+	int r;
+
+	r = qxl_bo_reserve(bo);
+	if (r)
+		return r;
+
+	qxl_bo_kunmap_locked(bo);
+	__qxl_bo_unpin(bo);
+	qxl_bo_unreserve(bo);
+	return 0;
+}
+
 void qxl_bo_kunmap_atomic_page(struct qxl_device *qdev,
 			       struct qxl_bo *bo, void *pmap)
 {
-- 
2.29.2

