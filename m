Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D3430F5BF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236993AbhBDPCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:02:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55495 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237075AbhBDO6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:58:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612450644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1oIZf7f/oo6PVRncKORJAVfkEWNMyNF7ALcrFfX4auY=;
        b=TYfUbV3gnvxCV7tjUoEX8eXKw+uQtGm17hGiPoZVNGCSGvt80WQjSYixrusT/GP0EmfKFf
        qVcqCjzM7rDTRAXT1hIBctkhGu9C8fgJOggrR2vaAsbjGKR37pCqDwbgdY6T1ANS/kq7Xu
        odCg2VPvZMBP1bG9HK9M/LVruYr/MOY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-HDIoRp0sOXSDapPAloOOkw-1; Thu, 04 Feb 2021 09:57:19 -0500
X-MC-Unique: HDIoRp0sOXSDapPAloOOkw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B5AC801960;
        Thu,  4 Feb 2021 14:57:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-108.ams2.redhat.com [10.36.113.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0421760C15;
        Thu,  4 Feb 2021 14:57:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 69894180101F; Thu,  4 Feb 2021 15:57:12 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 03/10] drm/qxl: use drmm_mode_config_init
Date:   Thu,  4 Feb 2021 15:57:04 +0100
Message-Id: <20210204145712.1531203-4-kraxel@redhat.com>
In-Reply-To: <20210204145712.1531203-1-kraxel@redhat.com>
References: <20210204145712.1531203-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/qxl/qxl_display.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 012bce0cdb65..38d6b596094d 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -1195,7 +1195,9 @@ int qxl_modeset_init(struct qxl_device *qdev)
 	int i;
 	int ret;
 
-	drm_mode_config_init(&qdev->ddev);
+	ret = drmm_mode_config_init(&qdev->ddev);
+	if (ret)
+		return ret;
 
 	ret = qxl_create_monitors_object(qdev);
 	if (ret)
@@ -1228,5 +1230,4 @@ int qxl_modeset_init(struct qxl_device *qdev)
 void qxl_modeset_fini(struct qxl_device *qdev)
 {
 	qxl_destroy_monitors_object(qdev);
-	drm_mode_config_cleanup(&qdev->ddev);
 }
-- 
2.29.2

