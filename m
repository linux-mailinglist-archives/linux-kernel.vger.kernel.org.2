Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E277130DAE5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhBCNSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:18:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45249 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231428AbhBCNRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:17:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612358187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xJ+5jBM5Efq4pvimfFQZ7dr+IKl1CDbKtMOECooNzlA=;
        b=ImoANjiBl73kRGLc8vruCEXUNGep8jg0UU5OaB4GF5WMoSnX/TMZc649aydbWWn/GbTzH2
        8gSZYSRuSvo4V5FQDrnIrQh/yJaB30GXtmyAcxeFiPgKfesi68RfR9iVKIj3UJtwLGC9AL
        +1sJ5M52kjMVoQHtc2Pr6idFK5/Mxvo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-Jsa3RwqBPqevH1--Tt3m1A-1; Wed, 03 Feb 2021 08:16:26 -0500
X-MC-Unique: Jsa3RwqBPqevH1--Tt3m1A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D34AECC620;
        Wed,  3 Feb 2021 13:16:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-27.ams2.redhat.com [10.36.113.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B6BBB5D9E3;
        Wed,  3 Feb 2021 13:16:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id DECD71800859; Wed,  3 Feb 2021 14:16:15 +0100 (CET)
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
Subject: [PATCH v5 5/6] drm/qxl: properly free qxl releases
Date:   Wed,  3 Feb 2021 14:16:14 +0100
Message-Id: <20210203131615.1714021-6-kraxel@redhat.com>
In-Reply-To: <20210203131615.1714021-1-kraxel@redhat.com>
References: <20210203131615.1714021-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorganize qxl_device_fini() a bit.
Add missing unpin() calls.

Count releases.  Add wait queue for releases.  That way
qxl_device_fini() can easily wait until everything is
ready for proper shutdown.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.h     |  2 ++
 drivers/gpu/drm/qxl/qxl_cmd.c     |  1 +
 drivers/gpu/drm/qxl/qxl_irq.c     |  1 +
 drivers/gpu/drm/qxl/qxl_kms.c     | 22 ++++++++++++++++++++--
 drivers/gpu/drm/qxl/qxl_release.c |  2 ++
 5 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 01354b43c413..6dd57cfb2e7c 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -214,6 +214,8 @@ struct qxl_device {
 	spinlock_t	release_lock;
 	struct idr	release_idr;
 	uint32_t	release_seqno;
+	atomic_t	release_count;
+	wait_queue_head_t release_event;
 	spinlock_t release_idr_lock;
 	struct mutex	async_io_mutex;
 	unsigned int last_sent_io_cmd;
diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index 54e3c3a97440..7e22a81bfb36 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -254,6 +254,7 @@ int qxl_garbage_collect(struct qxl_device *qdev)
 		}
 	}
 
+	wake_up_all(&qdev->release_event);
 	DRM_DEBUG_DRIVER("%d\n", i);
 
 	return i;
diff --git a/drivers/gpu/drm/qxl/qxl_irq.c b/drivers/gpu/drm/qxl/qxl_irq.c
index ddf6588a2a38..d312322cacd1 100644
--- a/drivers/gpu/drm/qxl/qxl_irq.c
+++ b/drivers/gpu/drm/qxl/qxl_irq.c
@@ -87,6 +87,7 @@ int qxl_irq_init(struct qxl_device *qdev)
 	init_waitqueue_head(&qdev->display_event);
 	init_waitqueue_head(&qdev->cursor_event);
 	init_waitqueue_head(&qdev->io_cmd_event);
+	init_waitqueue_head(&qdev->release_event);
 	INIT_WORK(&qdev->client_monitors_config_work,
 		  qxl_client_monitors_config_work_func);
 	atomic_set(&qdev->irq_received, 0);
diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
index 4a60a52ab62e..616aea948863 100644
--- a/drivers/gpu/drm/qxl/qxl_kms.c
+++ b/drivers/gpu/drm/qxl/qxl_kms.c
@@ -286,8 +286,26 @@ int qxl_device_init(struct qxl_device *qdev,
 
 void qxl_device_fini(struct qxl_device *qdev)
 {
-	qxl_bo_unref(&qdev->current_release_bo[0]);
-	qxl_bo_unref(&qdev->current_release_bo[1]);
+	int cur_idx;
+
+	for (cur_idx = 0; cur_idx < 3; cur_idx++) {
+		if (!qdev->current_release_bo[cur_idx])
+			continue;
+		qxl_bo_unpin(qdev->current_release_bo[cur_idx]);
+		qxl_bo_unref(&qdev->current_release_bo[cur_idx]);
+		qdev->current_release_bo_offset[cur_idx] = 0;
+		qdev->current_release_bo[cur_idx] = NULL;
+	}
+
+	/*
+	 * Ask host to release resources (+fill release ring),
+	 * then wait for the release actually happening.
+	 */
+	qxl_io_notify_oom(qdev);
+	wait_event_timeout(qdev->release_event,
+			   atomic_read(&qdev->release_count) == 0,
+			   HZ);
+
 	qxl_gem_fini(qdev);
 	qxl_bo_fini(qdev);
 	flush_work(&qdev->gc_work);
diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 28013fd1f8ea..43a5436853b7 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -196,6 +196,7 @@ qxl_release_free(struct qxl_device *qdev,
 		qxl_release_free_list(release);
 		kfree(release);
 	}
+	atomic_dec(&qdev->release_count);
 }
 
 static int qxl_release_bo_alloc(struct qxl_device *qdev,
@@ -344,6 +345,7 @@ int qxl_alloc_release_reserved(struct qxl_device *qdev, unsigned long size,
 			*rbo = NULL;
 		return idr_ret;
 	}
+	atomic_inc(&qdev->release_count);
 
 	mutex_lock(&qdev->release_mutex);
 	if (qdev->current_release_bo_offset[cur_idx] + 1 >= releases_per_bo[cur_idx]) {
-- 
2.29.2

