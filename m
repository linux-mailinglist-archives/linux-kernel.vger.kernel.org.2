Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D0730F5B0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbhBDO7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:59:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45139 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236978AbhBDO6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:58:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612450640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZFZ6ubUzI5ODvIBcEa2tm5y3uImpA1BuyZlcf1Y7zLo=;
        b=Hx+DzefBm883aKouh+p/BEpIEJ1jjM+6HF/PHvPrlaot+YZCS8QhUqG7hlNRwtjiibuU+n
        F3Xr70Q1Dt0dgmk3M1GM3tQKAG7kY8jhwhzulFvPgeSipkqe4Wc3llSE/f2mLRQKSvBvTD
        LXvT9haF7JKcJyeyl39pnigykWmYyqY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-GIZfCDfKMVG57zu0Kkt__w-1; Thu, 04 Feb 2021 09:57:18 -0500
X-MC-Unique: GIZfCDfKMVG57zu0Kkt__w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D4079127E;
        Thu,  4 Feb 2021 14:57:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-108.ams2.redhat.com [10.36.113.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EA3410016FC;
        Thu,  4 Feb 2021 14:57:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 8575F1801020; Thu,  4 Feb 2021 15:57:12 +0100 (CET)
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
Subject: [PATCH v6 04/10] drm/qxl: unpin release objects
Date:   Thu,  4 Feb 2021 15:57:05 +0100
Message-Id: <20210204145712.1531203-5-kraxel@redhat.com>
In-Reply-To: <20210204145712.1531203-1-kraxel@redhat.com>
References: <20210204145712.1531203-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Balances the qxl_create_bo(..., pinned=true, ...);
call in qxl_release_bo_alloc().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/qxl/qxl_release.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index c52412724c26..28013fd1f8ea 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -347,6 +347,7 @@ int qxl_alloc_release_reserved(struct qxl_device *qdev, unsigned long size,
 
 	mutex_lock(&qdev->release_mutex);
 	if (qdev->current_release_bo_offset[cur_idx] + 1 >= releases_per_bo[cur_idx]) {
+		qxl_bo_unpin(qdev->current_release_bo[cur_idx]);
 		qxl_bo_unref(&qdev->current_release_bo[cur_idx]);
 		qdev->current_release_bo_offset[cur_idx] = 0;
 		qdev->current_release_bo[cur_idx] = NULL;
-- 
2.29.2

