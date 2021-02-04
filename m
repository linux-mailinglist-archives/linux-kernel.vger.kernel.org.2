Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97CB630F5B6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237068AbhBDPBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:01:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39207 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237074AbhBDO6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:58:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612450643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GdOsrHPBHpzCoKPhsGidEPHdkXQSBSq9IJGbWdAMQ5c=;
        b=OMqJEsASaN0XxMYJ2DULMpZxv4Im10vD2RWdsoWq7OM/v6UQf7Ng6HldGMASorbT4cCjR0
        h7dwdO1PU/p7phw8WGIZZAsYN+QYfAWBBj2Ue2hOxxdNvLZH9ZH8G9r7ETR9vW60TpXY7h
        FJGNkSRKth79rxe97On986n+j0TF6Po=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-VcPF9jfTPi2m7pUl7zkNMw-1; Thu, 04 Feb 2021 09:57:19 -0500
X-MC-Unique: VcPF9jfTPi2m7pUl7zkNMw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2CF091271;
        Thu,  4 Feb 2021 14:57:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-108.ams2.redhat.com [10.36.113.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 183B4722CF;
        Thu,  4 Feb 2021 14:57:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 4474F180101E; Thu,  4 Feb 2021 15:57:12 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 02/10] Revert "drm/qxl: do not run release if qxl failed to init"
Date:   Thu,  4 Feb 2021 15:57:03 +0100
Message-Id: <20210204145712.1531203-3-kraxel@redhat.com>
In-Reply-To: <20210204145712.1531203-1-kraxel@redhat.com>
References: <20210204145712.1531203-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit b91907a6241193465ca92e357adf16822242296d.

Patch is broken, it effectively makes qxl_drm_release() a nop
because on normal driver shutdown qxl_drm_release() is called
*after* drm_dev_unregister().

Cc: Tong Zhang <ztong0001@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 34c8b25b5780..fb5f6a5e81d7 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -144,8 +144,6 @@ static void qxl_drm_release(struct drm_device *dev)
 	 * reodering qxl_modeset_fini() + qxl_device_fini() calls is
 	 * non-trivial though.
 	 */
-	if (!dev->registered)
-		return;
 	qxl_modeset_fini(qdev);
 	qxl_device_fini(qdev);
 }
-- 
2.29.2

