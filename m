Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFBD30F5D4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbhBDPIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:08:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51178 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237077AbhBDO6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:58:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612450644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dedRHYzwonhzROXGgAgNhZ07YZHUiaQwRn4N3ZaMxto=;
        b=WrvunFUmPA6o+KOnQEOg1s9BCRcuMSA9QQGMviqGvfsacSPxG7zKlSto7rBX7mqNwnZ0ox
        8A3DdTYcDHniw4JNX19QVCsrwXIPXJGUZLl+IlYiGRF9OVTccONTEeqzonaBIe/ynbaJWW
        rr8ckGPRbIZm7MYdyGA8Bn9QIlUDTXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-vH0n3oGYORW10Y6Hqu7wSA-1; Thu, 04 Feb 2021 09:57:20 -0500
X-MC-Unique: vH0n3oGYORW10Y6Hqu7wSA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75E69801967;
        Thu,  4 Feb 2021 14:57:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-108.ams2.redhat.com [10.36.113.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 36B79722C6;
        Thu,  4 Feb 2021 14:57:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 65FD71801026; Thu,  4 Feb 2021 15:57:13 +0100 (CET)
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
Subject: [PATCH v6 10/10] drm/qxl: allocate dumb buffers in ram
Date:   Thu,  4 Feb 2021 15:57:11 +0100
Message-Id: <20210204145712.1531203-11-kraxel@redhat.com>
In-Reply-To: <20210204145712.1531203-1-kraxel@redhat.com>
References: <20210204145712.1531203-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dumb buffers are shadowed anyway, so there is no need to store them
in device memory.  Use QXL_GEM_DOMAIN_CPU (TTM_PL_SYSTEM) instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_dumb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_dumb.c b/drivers/gpu/drm/qxl/qxl_dumb.c
index c04cd5a2553c..48a58ba1db96 100644
--- a/drivers/gpu/drm/qxl/qxl_dumb.c
+++ b/drivers/gpu/drm/qxl/qxl_dumb.c
@@ -59,7 +59,7 @@ int qxl_mode_dumb_create(struct drm_file *file_priv,
 	surf.stride = pitch;
 	surf.format = format;
 	r = qxl_gem_object_create_with_handle(qdev, file_priv,
-					      QXL_GEM_DOMAIN_SURFACE,
+					      QXL_GEM_DOMAIN_CPU,
 					      args->size, &surf, &qobj,
 					      &handle);
 	if (r)
-- 
2.29.2

