Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F1631CA06
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 12:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhBPLnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 06:43:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43787 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230122AbhBPLjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 06:39:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613475455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IeMuz+PjENRbBtRPL4YeHFDqiXu98t0Ozh6QE5njAVg=;
        b=HoiGpwZD4ggboZA4XQkhWVVLOXCeCCTPc1hUjR7ergW5bjx3RI6v5tOEdQXg9bWLcD4SDe
        xuoKDWQ7/WhsVn71TeGx55IxPLr6O86gmNINCmSN2PFlgQgMX29+cwGpd6IJG2ShjdfUpa
        poz1LwMqEBA4I4s0QLD6cCd2KNTCKQ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-5PZJWJp-PRe2Ssa8s8TOIw-1; Tue, 16 Feb 2021 06:37:30 -0500
X-MC-Unique: 5PZJWJp-PRe2Ssa8s8TOIw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31497100A8EA;
        Tue, 16 Feb 2021 11:37:29 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-184.ams2.redhat.com [10.36.114.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 296211975F;
        Tue, 16 Feb 2021 11:37:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 6AB6F180086E; Tue, 16 Feb 2021 12:37:18 +0100 (CET)
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
Subject: [PATCH 08/10] drm/qxl: fix monitors object kmap
Date:   Tue, 16 Feb 2021 12:37:14 +0100
Message-Id: <20210216113716.716996-9-kraxel@redhat.com>
In-Reply-To: <20210216113716.716996-1-kraxel@redhat.com>
References: <20210216113716.716996-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct kmap variant.  We don't hold a reservation here,
so we can't use the _locked variant.  We can drop the pin because
qxl_bo_kmap will do that for us.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 8672385a1caf..7500560db8e4 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -1159,12 +1159,10 @@ int qxl_create_monitors_object(struct qxl_device *qdev)
 	}
 	qdev->monitors_config_bo = gem_to_qxl_bo(gobj);
 
-	ret = qxl_bo_pin(qdev->monitors_config_bo);
+	ret = qxl_bo_kmap(qdev->monitors_config_bo, &map);
 	if (ret)
 		return ret;
 
-	qxl_bo_kmap_locked(qdev->monitors_config_bo, &map);
-
 	qdev->monitors_config = qdev->monitors_config_bo->kptr;
 	qdev->ram_header->monitors_config =
 		qxl_bo_physical_address(qdev, qdev->monitors_config_bo, 0);
@@ -1189,8 +1187,7 @@ int qxl_destroy_monitors_object(struct qxl_device *qdev)
 	qdev->monitors_config = NULL;
 	qdev->ram_header->monitors_config = 0;
 
-	qxl_bo_kunmap_locked(qdev->monitors_config_bo);
-	ret = qxl_bo_unpin(qdev->monitors_config_bo);
+	ret = qxl_bo_kunmap(qdev->monitors_config_bo);
 	if (ret)
 		return ret;
 
-- 
2.29.2

